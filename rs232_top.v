
//***********************************************************
//**********************Сī�ʼ�*****************************
//����ͨ��ʵ��
//Сīͬѧ��2014��6��9���ڹ���¥515ʵ������
//���ڽ������ݲ����͸���λ��
//************************Сī�ʼǣ���������**********************
module rs232_top (clk,rst_n,rs232_rx,rs232_tx);

input clk;   //��ʱ��50MHZ
input rst_n;  //��λ�źţ��͵�ƽ��Ч
input rs232_rx;   //���������
output rs232_tx;   //���������

wire bps_start1;
wire bps_start2;   //������ʱ�Ӽ����������ź�
wire clk_bps1;
wire clk_bps2;     //�ߵ�ƽ�ڼ�Ϊ���ջ������ݵ��м��źŲ�����
wire [7:0] rx_data;
wire rx_int;        //���������ж��źţ���������ʱΪ�ߵ�ƽ�����������ݺ����ͣ���ʼ��������

//������ĸ�ģ���У�speed_rx��speed_tx��������ȫ������Ӳ��ģ�飬�ɳ�֮Ϊ�߼�����
//��������Դ����������е�ͬһ���ӳ�����ò��ܻ�Ϊһ̸��

speed_select    speed_rx  (.clk(clk),   //������ѡ��ģ��
                           .rst_n(rst_n),
									.bps_start(bps_start1),
									.clk_bps(clk_bps1)
                           );
speed_select    speed_tx  (.clk(clk),   //������ѡ��ģ��
                           .rst_n(rst_n),
									.bps_start(bps_start2),
									.clk_bps(clk_bps2)
                           );

rs232_rx        rx   (.clk(clk),          //����ģ��
                      .rst_n(rst_n),
							 .rs232_rx(rs232_rx),
							 .clk_bps(clk_bps1),
							 .bps_start(bps_start1),
							 .rx_data(rx_data),
							 .rx_int(rx_int)
							 
							 );							  
rs232_tx        tx (.clk(clk),        //����ģ��
                    .rst_n(rst_n),
						  .rx_data(rx_data),
						  .clk_bps(clk_bps2),
						  .bps_start(bps_start2),
						  .rx_int(rx_int),
						  .rs232_tx(rs232_tx)
						  );
						  
endmodule 
 //************************СīƷ�ƣ���ֵ��ӵ��~**************************