
module interlock(clk, reset, emptyCheck, pressurizing, evacuating, 
                 innerPort, outerPort, status, leaving, arriving, sw3, sw2, enter, evacuate, 
					  pressurize, pressurizeFinished, evacuateFinished, waiting, waitFinished);
	
	input leaving, arriving, emptyCheck, evacuate, pressurize;
	input sw3, sw2, clk, reset;
	input waitFinished, evacuateFinished, pressurizeFinished;
	output reg innerPort, outerPort, enter, pressurizing, evacuating, waiting;
	output reg [3:0] status;
	reg completion;
	reg [3:0] ps; 

	parameter [3:0] firstStep = 4'b0001, highPressure = 4'b0010, checkOuterOpen = 4'b0011, checkOuterClose = 4'b0100;
   parameter [3:0] checkInnerClose = 4'b0110, outerOpen = 4'b0111, innerOpen = 4'b1000;
	parameter [3:0] pressurizeTimer = 4'b1001, evacuateTimer = 4'b1010, waiting5min = 4'b1011, closedInnerPort = 4'b1100, complete = 4'b1111;
	
	always@(posedge clk)
		if(reset)
			begin
				ps <= firstStep;
				innerPort <= 1'b0;
				outerPort <= 1'b0;
				enter <= 1'b0;
				evacuating <= 1'b0;
				pressurizing <= 1'b0;
				completion <= 1'b0;
				status <= 4'b0000;
			end
		else
		begin
			case(ps)
				firstStep:
				begin
				if(arriving)	
					begin
						ps <= waiting5min;
						waiting <= 1'b1;
						status <= 4'b0000;
					end
					
					else if(leaving)
							begin
							ps <= waiting5min;
							innerPort <= 1'b0;
							outerPort <=1'b0;
							waiting <= 1'b1;
							status <= 4'b0000;
							end
							
					else if(sw3)
					begin
						ps <= firstStep;
						innerPort <= 1'b1;
					end		
				end
				
				closedInnerPort:
				begin 
				if ((arriving && !sw3) | (leaving && !sw3)) 
				begin
				   enter <= 1'b1;	
					ps <= closedInnerPort;
				end 
				else if (sw3) 
			   begin 
					innerPort <=1'b1;
					enter <= 1'b0;
					ps <= checkInnerClose;
				end 
				else 
				begin
				   enter <= 1'b1;	
					ps <= closedInnerPort;
				end
				end 
				
				highPressure:
				begin
					if(!outerPort)
					begin
						ps <= checkOuterOpen;
						enter <= 1'b1;
					end
				end
				
				outerOpen:
				begin
					if(sw2)
					begin
						ps <= outerOpen;
						outerPort <= 1'b1;
						enter <= 1'b0;
					end
					else if (!sw2)
					begin 
						outerPort <= 1'b0;
						ps <= checkOuterClose;
					end
				end
				
				innerOpen:
				begin
					if(!leaving)
					begin
						ps <= checkInnerClose;
						innerPort <= 1'b0;
					end
				end
				
				checkOuterOpen:
				begin
					if(sw2)
					begin
						ps <= outerOpen;
					end
				end
				
				checkOuterClose:
				begin
					if(!sw2)
					begin
						ps <= evacuateTimer;
						evacuating <=1'b1;
					end
				end
				
				checkInnerClose:
				begin
					if(!sw3 && arriving)
					begin
						ps <= complete;
						innerPort <= 1'b0;
						status <= complete;
					end
					else if (!sw3 && leaving && !completion)
					begin 
						ps <= pressurizeTimer;
						innerPort <= 1'b0;
						completion <= 1'b1;
					end 
				   else if (!sw3 && leaving && completion)
				   begin 
					ps <= complete;
					innerPort <= 1'b0;
					status <= complete;
					completion <= 1'b0;
				   end 	
				end
				
				evacuateTimer:
				begin
					if(evacuateFinished)
					begin
						ps <= closedInnerPort;
						evacuating <= 1'b0;
					end
				end
				
				pressurizeTimer:
			   begin	
				pressurizing <= 1'b1;
				
					if(pressurizeFinished)
					begin
						ps <= highPressure;
						pressurizing <= 1'b0;
					end
				end
				
				waiting5min:
				begin
					if(waitFinished && emptyCheck && arriving)
					begin
						ps <= pressurizeTimer;
						waiting <= 1'b0;
					end
					else if (waitFinished && emptyCheck && leaving)
					begin
						ps <= evacuateTimer;
						evacuating <= 1'b1;
						waiting <= 1'b0;
					end 
				end
				complete:
				begin
						if (arriving)
						begin 
						ps <= complete;
						status <= complete;
				end
			         else if (leaving)
						begin
					      ps<=complete;
							status <= complete;
						end 
						
						else 
						begin 
						     ps<= firstStep;
						end 
				end 
				
				default:
				begin
					status [3:0] <= 4'bxxxx;
				end
			endcase
		end

endmodule

