/*
 * Screen.c
 *
 *  Created on: 16 Mar 2022
 *      Author: vannu
 */

#include "Screen.h"
#include "stm32f7508_discovery_lcd.h"


void CheckScreen(uint8_t Note)
{
	extern TIM_HandleTypeDef htim3;

	static TS_StateTypeDef TS_State;

	static uint8_t Touch = 0;

	static uint8_t Octave_Amount = 2;

	static uint8_t Scene = SCREEN;

	static uint8_t CurrentNote = 0;

	static uint8_t Indicators = 0;

	BSP_TS_GetState(&TS_State);

	if(!Touch && TS_State.touchDetected)						// If the screen is newly pressed
	{
		Touch = YES;											// Set the bit so the this is not a loop

		switch(Scene)
		{
		case TEST_SCREEN:

		break;

		case TEST_SCREEN_1:

			if(TS_State.touchX[0] > 70 && TS_State.touchX[0] < 130 && TS_State.touchY[0] > 272/2 + 70 - 30 && TS_State.touchY[0] < 272/2 + 70 + 30)	// Linksboven
			{
				DEBUGPRINT("Knopke 1");
				DDS(0xC0, 0);
			}

			if(TS_State.touchX[0] > 70 && TS_State.touchX[0] < 130 && TS_State.touchY[0] > 272/2 - 30 && TS_State.touchY[0] < 272/2 + 30)	// Linksmidden
			{
				DEBUGPRINT("Knopke 2");
				DDS(0xC0, 0x2);
			}

			if(TS_State.touchX[0] > 70 && TS_State.touchX[0] < 130 && TS_State.touchY[0] > 272/2 - 70 - 30 && TS_State.touchY[0] < 272/2 - 70 + 30)	// Linksonder
			{
				DEBUGPRINT("Knopke 3");
				DDS(0xC0, 0x20);
			}

			if(TS_State.touchX[0] > 320 && TS_State.touchX[0] < 400 && TS_State.touchY[0] > 272/2 - 40 && TS_State.touchY[0] < 272/2 + 40)	// If it is in a certain area
			{
				DEBUGPRINT("Knopke 5");
				NoteOff(3);
			}

			if(TS_State.touchX[0] > 200 && TS_State.touchX[0] < 280 && TS_State.touchY[0] > 272/2 - 40 && TS_State.touchY[0] < 272/2 + 40)	// If it is in a certain area
			{
				DEBUGPRINT("Knopke 4");
				NoteOn(3);
			}

		break;

		case DEN_TEST:
			if(TS_State.touchX[0] > 0 && TS_State.touchX[0] < 120 && TS_State.touchY[0] > 0 && TS_State.touchY[0] < 100)	// Select Sinewave
			{
				DDS(0xC0, 0);
			}

			if(TS_State.touchX[0] > 0 && TS_State.touchX[0] < 120 && TS_State.touchY[0] > 100 && TS_State.touchY[0] < 185)	// Select triangle
			{
				DDS(0xC0, 0x2);
			}

			if(TS_State.touchX[0] > 0 && TS_State.touchX[0] < 120 && TS_State.touchY[0] > 185 && TS_State.touchY[0] < 272)	// Select Square
			{
				DDS(0xC0, 0x20);
			}



			if(TS_State.touchX[0] > 120 && TS_State.touchX[0] < 200 && TS_State.touchY[0] > 0 && TS_State.touchY[0] < 80)		// LEDs
			{
				if(Indicators & 1)						// If bit is 1
				{
					Indicators = Indicators & 0xFE;		// Clear him
					BSP_LCD_SetTextColor(LCD_COLOR_RED);
					BSP_LCD_FillRect(130, 50, 60, 30);

					HAL_TIM_PWM_Stop(&htim3, 2);
				}
				else									// If bit is 0
				{
					Indicators = Indicators | 0x1;		// Add him
					BSP_LCD_SetTextColor(LCD_COLOR_GREEN);
					BSP_LCD_FillRect(130, 50, 60, 30);

					HAL_TIM_PWM_Start(&htim3, 2);
				}
			}

			if(TS_State.touchX[0] > 120 && TS_State.touchX[0] < 200 && TS_State.touchY[0] > 80 && TS_State.touchY[0] < 160)		// DDS
			{
				if(Indicators & 2)						// If bit is 1
				{
					Indicators = Indicators & 0xFD;		// Clear him
					BSP_LCD_SetTextColor(LCD_COLOR_RED);
					BSP_LCD_FillRect(130, 125, 60, 30);
				}
				else									// If bit is 0
				{
					Indicators = Indicators | 0x2;		// Add him
					BSP_LCD_SetTextColor(LCD_COLOR_GREEN);
					BSP_LCD_FillRect(130, 125, 60, 30);
				}
			}

			if(TS_State.touchX[0] > 120 && TS_State.touchX[0] < 200 && TS_State.touchY[0] > 160 && TS_State.touchY[0] < 272)	// MIDI
			{
				if(Indicators & 4)						// If bit is 1
				{
					Indicators = Indicators & 0xFB;		// Clear him
					BSP_LCD_SetTextColor(LCD_COLOR_RED);
					BSP_LCD_FillRect(130, 200, 60, 30);
				}
				else									// If bit is 0
				{
					Indicators = Indicators | 0x4;		// Add him
					BSP_LCD_SetTextColor(LCD_COLOR_GREEN);
					BSP_LCD_FillRect(130, 200, 60, 30);
				}
			}



			if(TS_State.touchX[0] > 210 && TS_State.touchX[0] < 480 && TS_State.touchY[0] > 0 && TS_State.touchY[0] < 272/2)	// Tone
			{
				NoteOn(1);
			}

			if(TS_State.touchX[0] > 210 && TS_State.touchX[0] < 480 && TS_State.touchY[0] > 272/2 && TS_State.touchY[0] < 272)	// Tone
			{
				NoteOff(1);
			}


			break;


		}
	}

	if(Touch && TS_State.touchDetected)								// If the screen stays pressed
	{
		switch(Scene)
		{

		case TEST_SCREEN:
			/*

			if(Octave_Amount == 1)
			{
				if(!(TS_State.touchX[0]/40 == CurrentNote))
				{
					NoteOn(TS_State.touchX[0]/40 + 60 - 24);
					CurrentNote = TS_State.touchX[0]/40;
				}
			}

			if(Octave_Amount == 2)
			{
			*/
				if(TS_State.touchY[0] < 136)
				{
					if(!((TS_State.touchX[0]/40 + 60 - 24) == CurrentNote))
					{
						NoteOff(CurrentNote - 36);
						CurrentNote = TS_State.touchX[0]/40 + 60 - 24;
						NoteOn(CurrentNote - 36);
					}
				}
				if(TS_State.touchY[0] > 136)
				{
					if(!((TS_State.touchX[0]/40 + 60 - 12) == CurrentNote))
					{
						NoteOff(CurrentNote - 36);
						CurrentNote = TS_State.touchX[0]/40 + 60 - 12;
						NoteOn(CurrentNote - 36);
					}
				}
				/*
			}
			*/
			break;

		case MAIN_SCREEN:

			if(TS_State.touchX[0] < 60 && TS_State.touchY[0] < 68)	// If it is in a certain area
			{
				// Do stuff
			}

			break;
		case FREQUENCY_GENERATOR:

			if(TS_State.touchX[0] < 60 && TS_State.touchY[0] < 68)	// If it is in a certain area
			{
				// Do stuff
			}

			break;
		}
	}

	if(Touch && !TS_State.touchDetected)							// If the screen is newly released
	{
		Touch = NO;

		switch(Scene)
		{
		case TEST_SCREEN:
			NoteOff(CurrentNote);
			CurrentNote = 100;
			break;

		case MAIN_SCREEN:

			if(TS_State.touchX[0] < 60 && TS_State.touchY[0] < 68)	// If it is in a certain area
			{
				// Do stuff
			}

			break;
		case FREQUENCY_GENERATOR:

			if(TS_State.touchX[0] < 60 && TS_State.touchY[0] < 68)	// If it is in a certain area
			{
				// Do stuff
			}

			break;
		}
	}
}
