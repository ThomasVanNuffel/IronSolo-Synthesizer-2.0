#include <stdint.h>
#include "main.h"

#define LEDCOUNT 7									// Amount of LEDs connected

#define ALMOST_NOTHING 10							// Brightness

#define POOR 30										// Brightness

#define NICE 69										// Brightness

#define BRIGHT 127									// Brightness

#define FULL 255									// Brightness

void WS2812_Set_RGB(uint8_t index, uint8_t r, uint8_t g, uint8_t b);
void WS2812_Set_All_RGB(uint8_t r, uint8_t g, uint8_t b);
void WS2812_Render();
