module speed_select (clk,rst_n,bps_start,clk_bps);
input clk;   //定义时钟，50MHZ
input rst_n;    //复位管脚
input bps_start;   //波特率时钟启动信号，一旦接收到信号低电平，bps_start置位1
output clk_bps;    //发送或接收数据时的中间采样点，高电平有效

reg [12:0] cnt;    //分频计数器
reg clk_bps_r;     //中间采样信号寄存器

always @(posedge clk or negedge rst_n) begin 
    if(!rst_n) cnt <=13'b0;
	 else if((cnt==13'd5027) || (!bps_start) )cnt <=13'd0;  //计数器清零
	 else cnt <=cnt +1'b1;     //波特率时钟计数器
end
/*
      单片机或者计算机在串口通信时的传输速率用波特率表示，9600bps表示的就是每秒钟传送9600位的数据
	这里之所以计数到5027，在这里算一下。
	   1秒传送9600位，那么传送一位的时间就可以算出，即1s=1000_000_000ns，所以传送一位数据需要1000_000_000/9600=
		104166ns，而我们的时钟周期为20ns，因此需要计数到104166/20=5028个时钟周期
		
*/
always @(posedge clk or negedge rst_n)begin 

  if(!rst_n)clk_bps_r<=1'b0;
  else if(cnt==13'd2603) clk_bps_r<=1'b1;   //当计数到初始位脉冲宽度的一半时，给clk_bps一个高脉冲采样
  else clk_bps_r <=1'b0;  

end

assign clk_bps =clk_bps_r;

 


endmodule 