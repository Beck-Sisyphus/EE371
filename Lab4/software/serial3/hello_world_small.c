// EE 371 Spring 2016
#include "sys/alt_stdio.h"
#include "altera_avalon_pio_regs.h"
#include "fcntl.h"
#include "unistd.h"

#define enable			  (char *) 0x0003000//  Transmit_Enable, Output to NIOS
#define data_in 		  (char *) 0x0003010//  Transmit_Data_Bus, Output to FPGA
#define leds 			  (char *) 0x0003030//  LEDs, Output to FPGA
#define data_out (volatile char *) 0x0003020//  Receive_Data_Bus, Input to NIOS
#define Character_Sent (volatile char *) 0x0003040//  Character_Sent, Input to NIOS
#define Character_Received (volatile char *) 0x0003050//	Character_Received, Input to NIOS
#define load (char *) 0x0003060

// Writes given character
void writeToSerial(char command) {
	IOWR_ALTERA_AVALON_PIO_DATA(data_in, command);
	IOWR_ALTERA_AVALON_PIO_DATA(load, 1);
	IOWR_ALTERA_AVALON_PIO_DATA(enable, 1);
	usleep(4);
	IOWR_ALTERA_AVALON_PIO_DATA(load, 0);
	IOWR_ALTERA_AVALON_PIO_DATA(enable, 0);
}

int main()
{
	fcntl(STDIN_FILENO, F_SETFL, O_NONBLOCK);
	// int i;
	 char bufferIn = '0';
	// char bufferOut[12] = "Hello 1234/n";

	// char* pBuffer = calloc(BUFFER_SIZE, sizeof(char));
	// char* pBufferHead = pBuffer;
	// char* pTransmit = pBuffer;

	*load = 0;
	*enable = 0;
	*data_in = 0xFF;

	while (1)
	{
		/* read */
		if (*Character_Received != 0) {
			bufferIn = IORD_ALTERA_AVALON_PIO_DATA(data_out);
			alt_printf("Reading: %c", bufferIn);
		}
		*leds = bufferIn;


		// Write
		char keyboard = alt_getchar();
		alt_getchar();
		writeToSerial(keyboard);
	}
	return 0;
}


