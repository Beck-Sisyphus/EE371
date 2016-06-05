module rs232_tx (clk,rst_n,rx_data,clk_bps,rx_int,bps_start,rs232_tx);
input clk;   //定义主时钟50MHZ
input rst_n;   //复位信号，低电平有效
input [7:0]rx_data;   //将接收到的数据送至发送模块准备发送
input clk_bps;            //高电平期间为数据发送的中间采样点
input rx_int;          //数据接收完毕标志信号
output bps_start;     //接收或发送数据时波特率时钟启动信号
output rs232_tx;    //发送数据


reg rx_int0,rx_int1,rx_int2;	//rx_int信号寄存器，捕捉下降沿滤波用
wire neg_rx_int;	// rx_int下降沿标志位

always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) begin
			rx_int0 <= 1'b0;
			rx_int1 <= 1'b0;
			rx_int2 <= 1'b0;
		end
	else begin
			rx_int0 <= rx_int;
			rx_int1 <= rx_int0;
			rx_int2 <= rx_int1;
		end
end

assign neg_rx_int =  ~rx_int1 & rx_int2;	//捕捉到下降沿后，neg_rx_int拉高保持一个主时钟周期

reg bps_start_r;
reg tx_en;
reg [7:0] tx_data;
reg [3:0] num;
always @(posedge clk or negedge rst_n)begin
      if(!rst_n) begin
	   bps_start_r <= 1'bz;
		tx_en <=1'b0;
		tx_data <= 8'd0;
		end
		
		else if(neg_rx_int)begin    //信号接收完毕，开始发送
		 bps_start_r <= 1'b1;
		 tx_en <=1'b1;              //发送标志位置位
		 tx_data <= rx_data;
		end
		else if(num==4'd11) begin	//数据发送完成，复位
		bps_start_r <= 1'b0;
		tx_en <= 1'b0;
		end
end
assign bps_start= bps_start_r;


reg rs232_tx_r;
always @(posedge clk or negedge rst_n)begin
       if(!rst_n)begin
		 num <=4'd0;
		 rs232_tx_r <= 1'b1;
		 end
		 else if(tx_en)begin
		    if(clk_bps)begin
			 num <= num +1'b1;
			   case (num)
				  4'd0 : rs232_tx_r <=1'b0;    //发送起始位
				  4'd1 : rs232_tx_r <=tx_data[0];  
				  4'd2 : rs232_tx_r <=tx_data[1];
				  4'd3 : rs232_tx_r <=tx_data[2];
				  4'd4 : rs232_tx_r <=tx_data[3];
				  4'd5 : rs232_tx_r <=tx_data[4];
				  4'd6 : rs232_tx_r <=tx_data[5];
				  4'd7 : rs232_tx_r <=tx_data[6];
				  4'd8 : rs232_tx_r <=tx_data[7];
				  4'd9 : rs232_tx_r <=1'b1;         //发送结束位
				  default : rs232_tx_r <= 1'b1;   //只要起始位不为0，就不能进行通信
				  endcase
				  
			 end
		 end
		 else if(num==4'd11)num<=4'd0;
end
assign rs232_tx = rs232_tx_r;


endmodule 