
/*
	This file contains all function used in the main of Practise Enterprise 2
*/

#include "Library.h"
#include "Screen.h"
#include "daisy_data.h"
#include "Jaat_Jom_data.h"


void LCD_Init()
{
	BSP_LCD_Init();
	BSP_LCD_LayerDefaultInit(1, LCD_FB_START_ADDRESS);
	BSP_LCD_LayerDefaultInit(0, LCD_FB_START_ADDRESS+(480*272*4));
	// Enable the LCD
	BSP_LCD_DisplayOn();
	// Select the LCD Background Layer
	BSP_LCD_SelectLayer(0);
	// Clear the Background Layer
	BSP_LCD_Clear(LCD_COLOR_BLACK);
	BSP_LCD_SelectLayer(1);
	// Clear the foreground Layer
	BSP_LCD_Clear(LCD_COLOR_WHITE);
	// Some sign
	BSP_LCD_SetTextColor(LCD_COLOR_BLACK);
	BSP_LCD_SetFont(&Font12);

	BSP_TS_Init(480,272);

	// Enable Backlight

	HAL_GPIO_WritePin(LCD_BL_CTRL_GPIO_Port,LCD_BL_CTRL_Pin,GPIO_PIN_SET);
	HAL_GPIO_WritePin(LCD_DISP_GPIO_Port, LCD_DISP_Pin, GPIO_PIN_SET);

	BSP_LCD_Clear(LCD_COLOR_WHITE);

	uint8_t Screen = SCREEN;

	if(Screen == 0)
	{
		BSP_LCD_SetTextColor(LCD_COLOR_BLACK);

		  for(uint16_t i = 0; i < 480; i = i + 40)
		  {
			  BSP_LCD_DrawLine(i, 0, i, 272);
		  }

		  BSP_LCD_DrawLine(0, 135, 480, 135);
		  BSP_LCD_DrawLine(0, 136, 480, 136);
		  BSP_LCD_DrawLine(0, 137, 480, 137);

		  BSP_LCD_FillRect(40, 0, 40, 68);

		  BSP_LCD_FillRect(120, 0, 40, 68);

		  BSP_LCD_FillRect(240, 0, 40, 68);

		  BSP_LCD_FillRect(320, 0, 40, 68);

		  BSP_LCD_FillRect(400, 0, 40, 68);


		  BSP_LCD_FillRect(40, 136, 40, 68);

		  BSP_LCD_FillRect(120, 136, 40, 68);

		  BSP_LCD_FillRect(240, 136, 40, 68);

		  BSP_LCD_FillRect(320, 136, 40, 68);

		  BSP_LCD_FillRect(400, 136, 40, 68);
	}

	else if(Screen == 1)
	{
		BSP_LCD_SetTextColor(LCD_COLOR_RED);

		  BSP_LCD_FillRect(240, 0, 480, 272);

		  BSP_LCD_SetTextColor(LCD_COLOR_BLUE);

		  BSP_LCD_FillCircle(360, 272/2, 40);

		  BSP_LCD_FillCircle(100, 272/2 + 70, 30);

		  BSP_LCD_FillCircle(100, 272/2, 30);

		  BSP_LCD_FillCircle(240, 272/2, 40);

		  BSP_LCD_FillCircle(100, 272/2 - 70, 30);
	}

	else if(Screen == 2)
	{
		WDA_LCD_DrawBitmap(JAAT_JOM_DATA, 0, 0, JAAT_JOM_DATA_X_PIXEL, JAAT_JOM_DATA_Y_PIXEL, JAAT_JOM_DATA_FORMAT);
	}
}


/*
 * This function will initialize the global variable LUT
*/

float LookupFreq[110] = {0};

void LUT_Init()
{
	LookupFreq[0]	=	32.70;
	LookupFreq[1]	=	34.65;
	LookupFreq[2]	=	36.71;
	LookupFreq[3]	=	38.89;
	LookupFreq[4]	=	41.20;
	LookupFreq[5]	=	43.65;
	LookupFreq[6]	=	46.25;
	LookupFreq[7]	=	49.00;
	LookupFreq[8]	=	51.91;
	LookupFreq[9]	=	55.00;
	LookupFreq[10]	=	58.27;
	LookupFreq[11]	=	61.74;
	LookupFreq[12]	=	65.41;
	LookupFreq[13]	=	69.30;
	LookupFreq[14]	=	73.42;
	LookupFreq[15]	=	77.78;
	LookupFreq[16]	=	82.41;
	LookupFreq[17]	=	87.31;
	LookupFreq[18]	=	92.50;
	LookupFreq[19]	=	98.00;
	LookupFreq[20]	=	103.83;
	LookupFreq[21]	=	110.00;
	LookupFreq[22]	=	116.54;
	LookupFreq[23]	=	123.7;
	LookupFreq[24]	=	130.81;
	LookupFreq[25]	=	138.59;
	LookupFreq[26]	=	146.83;
	LookupFreq[27]	=	155.56;
	LookupFreq[28]	=   164.81;
	LookupFreq[29]	=	174.61;
	LookupFreq[30]	=	185.00;
	LookupFreq[31]	=	196.00;
	LookupFreq[32]	=	207.65;
	LookupFreq[33]	=	220.00;
	LookupFreq[34]	=	233.08;
	LookupFreq[35]	=	246.94;
	LookupFreq[36]	=	261.63;
	LookupFreq[37]	=	277.18;
	LookupFreq[38]	=	293.66;
	LookupFreq[39]	=	311.13;
	LookupFreq[40]	=	329.63;
	LookupFreq[41]	=	349.23;
	LookupFreq[42]	=	369.99;
	LookupFreq[43]	=	392.00;
	LookupFreq[44]	=	415.30;
	LookupFreq[45]	=	440.00;
	LookupFreq[46]	=	466.16;
	LookupFreq[47]	=	493.88;
	LookupFreq[48]	=	523.25;
	LookupFreq[49]	=	554.37;
	LookupFreq[50]	=	587.33;
	LookupFreq[51]	=	622.25;
	LookupFreq[52]	=	659.26;
	LookupFreq[53]	=	698.46;
	LookupFreq[54]	=	739.99;
	LookupFreq[55]	=	783.99;
	LookupFreq[56]	=	830.61;
	LookupFreq[57]	=	880.00;
	LookupFreq[58]	=	932.33;
	LookupFreq[59]	=	987.77;
	LookupFreq[60]	=	1046.50;
	LookupFreq[61]	=	1108.73;
	LookupFreq[62]	=	1174.66;
	LookupFreq[63]	=	1244.51;
	LookupFreq[64]	=	1318.51;
	LookupFreq[65]	=	1396.91;
	LookupFreq[66]	=	1479.98;
	LookupFreq[67]	=	1567.98;
	LookupFreq[68]	=	1661.22;
	LookupFreq[69]	=	1760.00;
	LookupFreq[70]	=	1864.66;
	LookupFreq[71]	=	1975.53;
	LookupFreq[72]	=	2093.00;
	LookupFreq[73]	=	2217.46;
	LookupFreq[74]	=	2349.32;
	LookupFreq[75]	=	2489.02;
	LookupFreq[76]	=	2637.02;
	LookupFreq[77]	=	2793.83;
	LookupFreq[78]	=	2959.96;
	LookupFreq[79]	=	3135.96;
	LookupFreq[80]	=	3322.44;
	LookupFreq[81]	=	3520.00;
	LookupFreq[82]	=	3729.31;
	LookupFreq[83]	=	3951.07;
	LookupFreq[84]	=	4186.01;
	LookupFreq[85]	=	4434.92;
	LookupFreq[86]	=	4698.64;
	LookupFreq[87]	=	4978.03;
	LookupFreq[88]	=	5274.04;
	LookupFreq[89]	=	5587.65;
	LookupFreq[90]	=	5919.91;
	LookupFreq[91]	=	6271.93;
	LookupFreq[92]	=	6644.88;
	LookupFreq[93]	=	7040.00;
	LookupFreq[94]	=	7458.62;
	LookupFreq[95]	=	7902.13;
	LookupFreq[96]	=	8372.02;
	LookupFreq[97]	=	8869.84;
	LookupFreq[98]	=	9397.27;
	LookupFreq[99]	=	9956.06;
	LookupFreq[100]	=	10548.08;
	LookupFreq[101]	=	11175.30;
	LookupFreq[102]	=	11839.82;
	LookupFreq[103]	=	12543.85;
	LookupFreq[104]	=	13289.75;
	LookupFreq[105]	=	14080.00;
	LookupFreq[106]	=	14917.24;
	LookupFreq[107]	=	15804.27;
	LookupFreq[108]	=	16744.04;
}


void NoteOn(uint8_t Note)
{
	// MIDI
	MIDI(NOTE_ON, Note);

	// DDS
	DDS(NOTE_ON, Note);

	// LEDs
	WS2812_Set_RGB(Note, 21, 0, 0);

	// Render LEDs
	WS2812_Render();
}

void NoteOff(uint8_t Note)
{
	// MIDI
	MIDI(NOTE_OFF, Note);

	// DDS
	DDS(NOTE_OFF, Note);
	DDS(SEND, STOP_PLAYING);									// Stop the DDS module

	// LEDs
	WS2812_Set_RGB(Note, 0, 21, 0);

	// Render LEDs
	WS2812_Render();
}
