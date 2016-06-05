module speed_select (clk,rst_n,bps_start,clk_bps);
input clk;   //����ʱ�ӣ�50MHZ
input rst_n;    //��λ�ܽ�
input bps_start;   //������ʱ�������źţ�һ�����յ��źŵ͵�ƽ��bps_start��λ1
output clk_bps;    //���ͻ��������ʱ���м�����㣬�ߵ�ƽ��Ч

reg [12:0] cnt;    //��Ƶ������
reg clk_bps_r;     //�м�����źżĴ���

always @(posedge clk or negedge rst_n) begin 
    if(!rst_n) cnt <=13'b0;
	 else if((cnt==13'd5027) || (!bps_start) )cnt <=13'd0;  //����������
	 else cnt <=cnt +1'b1;     //������ʱ�Ӽ�����
end
/*
      ��Ƭ�����߼�����ڴ���ͨ��ʱ�Ĵ��������ò����ʱ�ʾ��9600bps��ʾ�ľ���ÿ���Ӵ���9600λ������
	����֮���Լ�����5027����������һ�¡�
	   1�봫��9600λ����ô����һλ��ʱ��Ϳ����������1s=1000_000_000ns�����Դ���һλ������Ҫ1000_000_000/9600=
		104166ns�������ǵ�ʱ������Ϊ20ns�������Ҫ������104166/20=5028��ʱ������
		
*/
always @(posedge clk or negedge rst_n)begin 

  if(!rst_n)clk_bps_r<=1'b0;
  else if(cnt==13'd2603) clk_bps_r<=1'b1;   //����������ʼλ�����ȵ�һ��ʱ����clk_bpsһ�����������
  else clk_bps_r <=1'b0;  

end

assign clk_bps =clk_bps_r;

 


endmodule 