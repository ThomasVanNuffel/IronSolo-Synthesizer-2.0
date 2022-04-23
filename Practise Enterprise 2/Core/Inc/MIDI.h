#include "main.h"
#include <stdint.h>

#ifndef HWREG(x)
#define HWREG(x) *((uint32_t*)(x))					// Macro to access hardware registers
#endif

#define MIDI_TX 0x40011428							// Address of the USART6 TX Register

#define MIDI_RX 0x40011428							// Address of the USART6 RX Register

// Define MIDI Names

	#ifndef NOTE_ON
	#define NOTE_ON 0x90							// Note on command, lower nibble is the MIDI channel (0-15)
	#endif

	#ifndef NOTE_OFF
	#define NOTE_OFF 0x80							// Note off command, lower nibble is the MIDI channel (0-15)
	#endif

	#ifndef PROGRAM_CHANGE
	#define PROGRAM_CHANGE 0xC0						// Program change command, lower nibble is the MIDI channel (0-15)
	#endif


	#define MIDI_CHANNEL_1

	#define MIDI_CHANNEL_2

	#define MIDI_CHANNEL_3

	#define MIDI_CHANNEL_4

	#define MIDI_CHANNEL_5

	#define MIDI_CHANNEL_6

	#define MIDI_CHANNEL_7

	#define MIDI_CHANNEL_8

	#define MIDI_CHANNEL_9

	#define MIDI_CHANNEL_10

	#define MIDI_CHANNEL_11

	#define MIDI_CHANNEL_12

	#define MIDI_CHANNEL_13

	#define MIDI_CHANNEL_14

	#define MIDI_CHANNEL_15

	#define MIDI_CHANNEL_16

    void MIDI(uint8_t Command, uint8_t Note);
