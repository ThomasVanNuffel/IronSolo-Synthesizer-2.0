/*
 * Library.h
 *
 *  Created on: 16 Mar 2022
 *      Author: vannu
 */

#include "main.h"
#include "../../Drivers/BSP/inc/stm32f7508_discovery_lcd.h"
#include <stdint.h>

#ifndef INC_LIBRARY_H_
#define INC_LIBRARY_H_

void NoteOn(uint8_t Note, uint8_t Status);

void NoteOff(uint8_t Note, uint8_t Status);

void LUT_Init();

void LCD_Init();

#ifndef NOTE_ON
	#define NOTE_ON 0x90							// Note on command, lower nibble is the MIDI channel (0-15)
	#endif

	#ifndef NOTE_OFF
	#define NOTE_OFF 0x80							// Note off command, lower nibble is the MIDI channel (0-15)
	#endif

	#ifndef PROGRAM_CHANGE
	#define PROGRAM_CHANGE 0xC0						// Program change command, lower nibble is the MIDI channel (0-15)
	#endif

	#ifndef STOP_PLAYING
	#define STOP_PLAYING 0x0080							// Freezes the output of a DDS module
	#endif

	#ifndef SEND
	#define SEND 4
	#endif

// Define Keyboard Names

	#define ONE_OCTAVE 12

	#define TWO_OCTAVE 24

	#define TREE_OCTAVE 36

	#define FOUR_OCTAVE 42


// Define all possible notes that can be played on the keyboard

	// Octave 1
	#define C1 0
	#define C_1 1
	#define D1 2
	#define D_1 3
	#define E1 4
	#define F1 5
	#define F_1 6
	#define G1 7
	#define G_1 8
	#define A1 9
	#define A_1 10
	#define B1 11

	// Octave 2
	#define C2 12
	#define C_2 13
	#define D2 14
	#define D_2 15
	#define E2 16
	#define F2 17
	#define F_2 18
	#define G2 19
	#define G_2 20
	#define A2 21
	#define A_2 22
	#define B2 23

	// Octave 3
	#define C3 24
	#define C_3 25
	#define D3 26
	#define D_3 27
	#define E3 28
	#define F3 29
	#define F_3 30
	#define G3 31
	#define G_3 32
	#define A3 33
	#define A_3 34
	#define B3 35

	// Octave 4
	#define C4 36
	#define C_4 37
	#define D4 38
	#define D_4 39
	#define E4 40
	#define F4 41
	#define F_4 42
	#define G4 43
	#define G_4 44
	#define A4 45
	#define A_4 46
	#define B4 47

	// Octave 5
	#define C5 48
	#define C_5 49
	#define D5 50
	#define D_5 51
	#define E5 52
	#define F5 53
	#define F_5 54
	#define G5 55
	#define G_5 56
	#define A5 57
	#define A_5 58
	#define B5 59

	// Octave 6
	#define C6 60
	#define C_6 61
	#define D6 62
	#define D_6 63
	#define E6 64
	#define F6 65
	#define F_6 66
	#define G6 67
	#define G_6 68
	#define A6 69
	#define A_6 70
	#define B6 71

	// Octave 7
	#define C7 72
	#define C_7 73
	#define D7 74
	#define D_7 75
	#define E7 76
	#define F7 77
	#define F_7 78
	#define G7 79
	#define G_7 80
	#define A7 81
	#define A_7 82
	#define B7 83

	// Octave 8
	#define C8 84
	#define C_8 85
	#define D8 86
	#define D_8 87
	#define E8 88
	#define F8 89
	#define F_8 90
	#define G8 91
	#define G_8 92
	#define A8 93
	#define A_8 94
	#define B8 95



#endif /* INC_LIBRARY_H_ */
