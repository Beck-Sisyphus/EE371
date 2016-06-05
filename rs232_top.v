
//***********************************************************
//**********************小墨笔记*****************************
//串口通信实验
//小墨同学于2014年6月9日在工科楼515实验室作
//串口接收数据并发送给上位机
//************************小墨笔记，留作回忆**********************
module rs232_top (clk,rst_n,rs232_rx,rs232_tx);

input clk;   //主时钟50MHZ
input rst_n;  //复位信号，低电平有效
input rs232_rx;   //数据输入端
output rs232_tx;   //数据输出端

wire bps_start1;
wire bps_start2;   //波特率时钟计数器启动信号
wire clk_bps1;
wire clk_bps2;     //高电平期间为接收或发送数据的中间信号采样点
wire [7:0] rx_data;
wire rx_int;        //接收数据中断信号，接收数据时为高电平，接收完数据后拉低，开始发送数据

//下面的四个模块中，speed_rx和speed_tx是两个完全独立的硬件模块，可称之为逻辑复制
//（不是资源共享，和软件中的同一个子程序调用不能混为一谈）

speed_select    speed_rx  (.clk(clk),   //波特率选择模块
                           .rst_n(rst_n),
									.bps_start(bps_start1),
									.clk_bps(clk_bps1)
                           );
speed_select    speed_tx  (.clk(clk),   //波特率选择模块
                           .rst_n(rst_n),
									.bps_start(bps_start2),
									.clk_bps(clk_bps2)
                           );

rs232_rx        rx   (.clk(clk),          //接收模块
                      .rst_n(rst_n),
							 .rs232_rx(rs232_rx),
							 .clk_bps(clk_bps1),
							 .bps_start(bps_start1),
							 .rx_data(rx_data),
							 .rx_int(rx_int)
							 
							 );							  
rs232_tx        tx (.clk(clk),        //发送模块
                    .rst_n(rst_n),
						  .rx_data(rx_data),
						  .clk_bps(clk_bps2),
						  .bps_start(bps_start2),
						  .rx_int(rx_int),
						  .rs232_tx(rs232_tx)
						  );
						  
endmodule 
 //************************小墨品牌，你值得拥有~**************************