module rs232_rx (clk,rst_n,rs232_rx,clk_bps,bps_start,rx_data,rx_int);

input clk;  //������ʱ��50MHZ
input rst_n;   //��λ�źţ��͵�ƽ��Ч
input rs232_rx;    //�ź����������
input clk_bps;     //�ߵ�ƽ�ڼ�Ϊ���ͻ��߽������ݵ��м������
output bps_start;   //���������ʱ�������źţ��ߵ�ƽ��Ч
output [7:0] rx_data;    //���8λ�����ݶ�
output rx_int;           //���������ж��źţ����������ڼ�ʼ��Ϊ�ߵ�ƽ

reg rs232_rx0,rs232_rx1,rs232_rx2,rs232_rx3;	//�������ݼĴ������˲���
wire neg_rs232_rx;	//��ʾ�����߽��յ��½���

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
	//������½��ؼ������˵�<20ns-40ns��ë��(����������͵�����ë��)��
	//�����������Դ���ȶ���ǰ�������Ƕ�ʱ��Ҫ������ô���̣���Ϊ�����źŴ��˺ü��ģ� 
	//����Ȼ���ǵ���Ч�������źſ϶���ԶԶ����40ns�ģ�
assign neg_rs232_rx = rs232_rx3 & rs232_rx2 & ~rs232_rx1 & ~rs232_rx0;	//���յ��½��غ�neg_rs232_rx�ø�һ��ʱ������

reg bps_start_r;
reg rx_int_r;
reg [3:0]num;  //���ڼ������ջ������ݵ�λ��
always @(posedge clk or negedge rst_n)begin
   if(!rst_n) begin
	rx_int_r <=1'b0;
	bps_start_r <=1'bz;
	end
	else if(neg_rs232_rx)begin   //���յ�������ʼλ�ߵ�ƽ�ı�־�ź�
	     bps_start_r<= 1'b1;     //һ�����յ����ݣ�������ʱ�Ӽ���������
		  rx_int_r <= 1'b1;      //���������ж��ź���λ�������˿����ڽ�������
		  
	end
	else if(num==4'd12)begin    //����������Ϻ󣬹رղ�����ʱ�Ӽ��������ر����ݽ����ж��ź�
	bps_start_r<=1'b0;
	rx_int_r<=1'b0;
	end
end
assign bps_start = bps_start_r;
assign rx_int =rx_int_r;

reg [7:0]rx_data_r;                   //���ڽ������ݼĴ�������������һ�����ݵ���
reg [7:0]rx_temp_data;                //��ǰ�������ݼĴ���

always @(posedge clk or negedge rst_n)begin
   if(!rst_n) begin
	num <=4'd0;
	rx_temp_data <=8'd0;
   rx_data_r <=8'd0;	
	end
	else if(rx_int)begin        //������ڽ��������ڼ�
	   if(clk_bps)begin         //�����׽��һ��������
		    num <=num + 1'b1;    
			 case (num)              //��һλ����ʼλ�����ü�������1��ʼ����
			   4'd1:  rx_temp_data[0] <= rs232_rx;  //������һλһλ���͸�rx_temp_data
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
	
	else if(num==4'd12)begin           //���ݴ�����ϣ�����������
	num <= 4'b0;
	rx_data_r <= rx_temp_data;
	end
end

assign rx_data =rx_data_r;





endmodule 