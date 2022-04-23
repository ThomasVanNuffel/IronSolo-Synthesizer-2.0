/*
 * DDS.c
 *
 *  Created on: Mar 7, 2022
 *      Author: vannu
 */

#include "DDS.h"

void DDS(uint8_t Command, uint16_t Note)
{
	static uint8_t DDS_Current = 0;					// Start with the first DDS module
	static uint8_t NotesPlaying[DDSCOUNT];			// Array of playing notes on the DDS modules
	static uint8_t DDSPlaying[DDSCOUNT];			// Array of playing DDSes (envelope included)

	static uint8_t Loop_Order = NEXT_ONE;			// Start with looping through the DDSes one after the other

	static uint8_t Instrument = SINE ;				// Select instrument that we play

	switch (Command)
	{
	case NOTE_ON:

			DDS(SELECT, DDS_Current);								// Select DDS to start transmission

			DEBUGPRINT("SPI commands for sending %f Hz :", LookupFreq[Note]);

			DDS(SEND, RESET);										// Stop the DDS module

			DDS(SEND, (uint16_t)round(LookupFreq[Note]*DDSCONSTANT) | 0x4000);	// Write Frequency register (status bits on the left)

			//DDS(SEND, 0x6969);

			DDS(SEND, START_PLAYING | Instrument);					// Start the module with the selected waveform

			NotesPlaying[DDS_Current] = Note;						// Save which note is played on the DDS
			DDSPlaying[DDS_Current] = YES;							// Save that the DDS is actively playing

			Envelope(START, DDS_Current);							// Start the attack of the current envelope

			if(Loop_Order == NEXT_FREE)
			{

			}
			else
			{
				DDS_Current ++;											// Point to the next DDS module

				if(DDS_Current == DDSCOUNT)								// If he has done all DDS modules
				{
					DDS_Current = 0;									// Start again from the beginning
				}
			}

			DEBUGPRINT("\nDDS 1: - Note: %d - In use: %d", NotesPlaying[0], DDSPlaying[0]);
			DEBUGPRINT("DDS 2: - Note: %d - In use: %d", NotesPlaying[1], DDSPlaying[1]);
			DEBUGPRINT("DDS 3: - Note: %d - In use: %d", NotesPlaying[2], DDSPlaying[2]);
			DEBUGPRINT("\r\n");

		break;

	case NOTE_OFF:
			for(uint8_t i = 0; i < DDSCOUNT; i++)		// Loop over all DDS modules
			{
				if(NotesPlaying[i] == Note)				// Check if the note is the same as the current DDS note playing
				{
					Envelope(STOP, i);					// Release the note on the envelope filter
				}
			}

		break;

	case SELECT:

			DEBUGPRINT("Selecting module %d\n", Note);

			//IO_Expander(WRITE, SPI_DATA, Note | 0b1000);	// Select slave DDS (3-bit) and set the fourth pin high (CS)
		break;

	case SEND:
			DEBUGPRINT("   %x   ", Note);				// Sends the command through SPI2

			HAL_GPIO_WritePin(GPIOA, CS_Pin, 0);
			HAL_SPI_Transmit(&hspi2, (uint16_t *)&Note, 1, 100);
			HAL_GPIO_WritePin(GPIOA, CS_Pin, 1);
		break;

	case SWITCH_ORDER:
			DEBUGPRINT("Switching DDS order to %d", Note);				// Sends the command through SPI2
				Loop_Order = Note;
			break;

	case RESETTING:
			DEBUGPRINT("Resetting");
			DDS(SEND, RESET);											// Stop the DDS module
			DDS(SEND, SELECT_HREG);										// Select the high frequency register
			DDS(SEND, 0x4000);											// Set it on zero
			DDS(SEND, STOP_PLAYING);									// Stop the DDS module
				break;

	case PROGRAM_CHANGE:
			Instrument = Note;						// Sets the waveform to the given waveform

#if DEBUGGING == YES
			if(Note == SINE)
			{
				DEBUGPRINT("Sinus geselecteerd");
			}
			if(Note == TRIANGLE)
			{
				DEBUGPRINT("Driehoek geselecteerd");
			}
			if(Note == SQUARE)
			{
				DEBUGPRINT("Vierkant geselecteerd");
			}
#endif
			break;


	default:
		DEBUGPRINT("No corresponding command found !");
		break;
	}
}
