/*
 * DDS.h
 *
 *  Created on: Mar 7, 2022
 *      Author: vannu
 */

#include "main.h"
#include <stdint.h>

#ifndef INC_DDS_H_
#define INC_DDS_H_

// Define DDS Names

	extern float LookupFreq[110];

	extern SPI_HandleTypeDef hspi2;

	#ifndef NOTE_ON
	#define NOTE_ON 0x90							// Note on command, lower nibble is the MIDI channel (0-15)
	#endif

	#ifndef NOTE_OFF
	#define NOTE_OFF 0x80							// Note off command, lower nibble is the MIDI channel (0-15)
	#endif

	#ifndef PROGRAM_CHANGE
	#define PROGRAM_CHANGE 0xC0						// Program change command, lower nibble is the MIDI channel (0-15)
	#endif

	#define DDSCOUNT 2									// Amount of DDS modules connected

	#define DDSCONSTANT ((float)((float)268435456/(float)25000000))	// To translate frequency into the value of the frequency register

	#define RESET 0x0100								// Resets the output of a DDS module

	#define STOP_PLAYING 0x0080							// Freezes the output of a DDS module

	#define START_PLAYING 0x0000						// Starts outputting the DDS signal

	#define SELECT_HREG 0x1000						// Starts outputting the DDS signal

	#define SINE 0x00									// A sine wave as output waveform

	#define TRIANGLE 0x02								// A triangle wave as output waveform

	#define SQUARE 0x20									// A square wave as output waveform

	#define SELECT 3

	#define SEND 4

	#define RESETTING 5								// Resets the output of a DDS module

	#define START 1										// Command to start the envelope

	#define STOP 0										// Command to stop the envelope



	#define NEXT_ONE 7

	#define NEXT_FREE 8

	#define SWITCH_ORDER 9

#endif /* INC_DDS_H_ */

void DDS(uint8_t Command, uint16_t Note);
