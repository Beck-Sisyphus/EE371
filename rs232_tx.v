module rs232_tx (clk,rst_n,rx_data,clk_bps,rx_int,bps_start,rs232_tx);
input clk;   //������ʱ��50MHZ
input rst_n;   //��λ�źţ��͵�ƽ��Ч
input [7:0]rx_data;   //�����յ���������������ģ��׼������
input clk_bps;            //�ߵ�ƽ�ڼ�Ϊ���ݷ��͵��м������
input rx_int;          //���ݽ�����ϱ�־�ź�
output bps_start;     //���ջ�������ʱ������ʱ�������ź�
output rs232_tx;    //��������


reg rx_int0,rx_int1,rx_int2;	//rx_int�źżĴ�������׽�½����˲���
wire neg_rx_int;	// rx_int�½��ر�־λ

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

assign neg_rx_int =  ~rx_int1 & rx_int2;	//��׽���½��غ�neg_rx_int���߱���һ����ʱ������

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
		
		else if(neg_rx_int)begin    //�źŽ�����ϣ���ʼ����
		 bps_start_r <= 1'b1;
		 tx_en <=1'b1;              //���ͱ�־λ��λ
		 tx_data <= rx_data;
		end
		else if(num==4'd11) begin	//���ݷ�����ɣ���λ
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
				  4'd0 : rs232_tx_r <=1'b0;    //������ʼλ
				  4'd1 : rs232_tx_r <=tx_data[0];  
				  4'd2 : rs232_tx_r <=tx_data[1];
				  4'd3 : rs232_tx_r <=tx_data[2];
				  4'd4 : rs232_tx_r <=tx_data[3];
				  4'd5 : rs232_tx_r <=tx_data[4];
				  4'd6 : rs232_tx_r <=tx_data[5];
				  4'd7 : rs232_tx_r <=tx_data[6];
				  4'd8 : rs232_tx_r <=tx_data[7];
				  4'd9 : rs232_tx_r <=1'b1;         //���ͽ���λ
				  default : rs232_tx_r <= 1'b1;   //ֻҪ��ʼλ��Ϊ0���Ͳ��ܽ���ͨ��
				  endcase
				  
			 end
		 end
		 else if(num==4'd11)num<=4'd0;
end
assign rs232_tx = rs232_tx_r;


endmodule 