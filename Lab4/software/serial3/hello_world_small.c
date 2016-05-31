// EE 371 Spring 2016
#include "sys/alt_stdio.h"
#include "altera_avalon_pio_regs.h"
//#include "fcntl.h"
#include "unistd.h"

#define enable	 (volatile char *) 0x0005000//  Transmit_Enable, Output to NIOS
#define data_in  (volatile char *) 0x0005030//  Transmit_Data_Bus, Output to FPGA
#define leds 	 (volatile char *) 0x0005040//  LEDs, Output to FPGA
#define data_out (volatile char *) 0x0005060//  Receive_Data_Bus, Input to NIOS
#define Character_Sent (volatile char *) 0x0005010//  Character_Sent, Input to NIOS
#define Character_Received (volatile char *) 0x0005050//	Character_Received, Input to NIOS
#define load (volatile char *) 0x0005020

// Writes given character
void writeToSerial(char command) {
	IOWR_ALTERA_AVALON_PIO_DATA(data_in, command);
	IOWR_ALTERA_AVALON_PIO_DATA(load, 1);
	IOWR_ALTERA_AVALON_PIO_DATA(enable, 1);
	usleep(4);
	IOWR_ALTERA_AVALON_PIO_DATA(load, 0);
	IOWR_ALTERA_AVALON_PIO_DATA(enable, 0);
}
char bufferIn = '0';
int main()
{
//	fcntl(STDIN_FILENO, F_SETFL, O_NONBLOCK);
	// int i;

	// char bufferOut[12] = "Hello 1234/n";

	// char* pBuffer = calloc(BUFFER_SIZE, sizeof(char));
	// char* pBufferHead = pBuffer;
	// char* pTransmit = pBuffer;

	*load = 0;
	*enable = 0;
	*data_in = 0xFF;

	while (1)
	{

		// Write
		alt_putstr("Enter a letter:\n");
		char keyboard = alt_getchar();
		alt_getchar();
		writeToSerial(keyboard);
		bufferIn = keyboard;

		/* read */
		if (*Character_Received != 0) {
			bufferIn = IORD_ALTERA_AVALON_PIO_DATA(data_out);
			alt_printf("Reading: %c", bufferIn);
		}
		*leds = bufferIn;
		usleep(1000000);
	}
	return 0;
}
