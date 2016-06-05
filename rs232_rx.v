module rs232_rx (clk,rst_n,rs232_rx,clk_bps,bps_start,rx_data,rx_int);

input clk;  //定义主时钟50MHZ
input rst_n;   //复位信号，低电平有效
input rs232_rx;    //信号数据输入端
input clk_bps;     //高电平期间为发送或者接受数据的中间采样点
output bps_start;   //输出波特率时钟启动信号，高电平有效
output [7:0] rx_data;    //输出8位的数据端
output rx_int;           //接受数据中断信号，接收数据期间始终为高电平

reg rs232_rx0,rs232_rx1,rs232_rx2,rs232_rx3;	//接收数据寄存器，滤波用
wire neg_rs232_rx;	//表示数据线接收到下降沿

always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) begin
			rs232_rx0 <= 1'b0;
			rs232_rx1 <= 1'b0;
			rs232_rx2 <= 1'b0;
			rs232_rx3 <= 1'b0;
		end
	else begin
			rs232_rx0 <= rs232_rx;
			rs232_rx1 <= rs232_rx0;
			rs232_rx2 <= rs232_rx1;
			rs232_rx3 <= rs232_rx2;
		end
end
	//下面的下降沿检测可以滤掉<20ns-40ns的毛刺(包括高脉冲和低脉冲毛刺)，
	//这里就是用资源换稳定（前提是我们对时间要求不是那么苛刻，因为输入信号打了好几拍） 
	//（当然我们的有效低脉冲信号肯定是远远大于40ns的）
assign neg_rs232_rx = rs232_rx3 & rs232_rx2 & ~rs232_rx1 & ~rs232_rx0;	//接收到下降沿后neg_rs232_rx置高一个时钟周期

reg bps_start_r;
reg rx_int_r;
reg [3:0]num;  //用于计数接收或发送数据的位数
always @(posedge clk or negedge rst_n)begin
   if(!rst_n) begin
	rx_int_r <=1'b0;
	bps_start_r <=1'bz;
	end
	else if(neg_rs232_rx)begin   //接收到数据起始位高电平的标志信号
	     bps_start_r<= 1'b1;     //一旦接收到数据，波特率时钟计数器开启
		  rx_int_r <= 1'b1;      //接收数据中断信号置位，表明此刻正在接收数据
		  
	end
	else if(num==4'd12)begin    //接收数据完毕后，关闭波特率时钟计数器，关闭数据接收中断信号
	bps_start_r<=1'b0;
	rx_int_r<=1'b0;
	end
end
assign bps_start = bps_start_r;
assign rx_int =rx_int_r;

reg [7:0]rx_data_r;                   //串口接收数据寄存器，保存至下一个数据到来
reg [7:0]rx_temp_data;                //当前接收数据寄存器

always @(posedge clk or negedge rst_n)begin
   if(!rst_n) begin
	num <=4'd0;
	rx_temp_data <=8'd0;
   rx_data_r <=8'd0;	
	end
	else if(rx_int)begin        //如果处于接收数据期间
	   if(clk_bps)begin         //如果捕捉到一个高脉冲
		    num <=num + 1'b1;    
			 case (num)              //第一位是起始位，不用计数，从1开始计数
			   4'd1:  rx_temp_data[0] <= rs232_rx;  //把数据一位一位的送给rx_temp_data
				4'd2:  rx_temp_data[1] <= rs232_rx;
				4'd3:  rx_temp_data[2] <= rs232_rx;
				4'd4:  rx_temp_data[3] <= rs232_rx;
			   4'd5:  rx_temp_data[4] <= rs232_rx;
				4'd6:  rx_temp_data[5] <= rs232_rx;
				4'd7:  rx_temp_data[6] <= rs232_rx;
				4'd8:  rx_temp_data[7] <= rs232_rx;
				default : ;
				endcase
				
		end
	end
	
	else if(num==4'd12)begin           //数据传送完毕，计数器清零
	num <= 4'b0;
	rx_data_r <= rx_temp_data;
	end
end

assign rx_data =rx_data_r;





endmodule 