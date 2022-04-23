/*
WS2812 driver for stm32 Using HAL and DMA

by Arne Van den Broeck
*/
#include "stm32f7xx_hal.h"
#include "Ws2812.h"

//timer and timer channel used for generating the serial data
extern TIM_HandleTypeDef htim3;
extern DMA_HandleTypeDef hdma_tim3_ch1_trig;

//Time PWM should remain high to generate a LOW or HIGH BIT 
#define PWM_HI (16)
#define PWM_LO (9)


// LED parameters
//Number of bytes per pixel
#define NUM_BPP (3)
//Number of pixels
#define NUM_PIXELS LEDCOUNT
//Number of total Bytes
#define NUM_BYTES (NUM_BPP * NUM_PIXELS)


// LED color buffer
uint8_t RGB_Data[NUM_BYTES] = {0};

// LED write buffer
#define BUFFER_LEN (NUM_BPP * 8 * 2)
uint32_t Buffer[BUFFER_LEN] = {0};
//state of DMA process
uint_fast8_t BufferState = 0;

/*-----------------------------------------------------------*/

void WS2812_Set_RGB(uint8_t index, uint8_t r, uint8_t g, uint8_t b) {
  RGB_Data[3 * index] = g;
  RGB_Data[3 * index + 1] = r ;
  RGB_Data[3 * index + 2] = b ;

  DEBUGPRINT("LED %d: - Red: %d - Green: %d - Blue: %d \n", index, r, g, b);
}

/*-----------------------------------------------------------*/

void WS2812_Set_All_RGB(uint8_t r, uint8_t g, uint8_t b) {
  for(uint_fast8_t i = 0; i < NUM_PIXELS; ++i) WS2812_Set_RGB(i, r, g, b);
}

/*-----------------------------------------------------------*/

void WS2812_Render() {

	DEBUGPRINT("RGB Data in registers:");
	for(uint8_t index = 0; index < LEDCOUNT; ++index)
	{
		DEBUGPRINT("LEDje %d:", index);
		DEBUGPRINT("Rood: %x", RGB_Data[3 * index + 1]);
		DEBUGPRINT("Groen: %x", RGB_Data[3 * index]);
		DEBUGPRINT("Blauw: %x \r\n", RGB_Data[3 * index + 2]);

	}


  if(BufferState != 0 || hdma_tim3_ch1_trig.State != HAL_DMA_STATE_READY) {
    //If Data is going Stop sending
    for(uint8_t i = 0; i < BUFFER_LEN; ++i) Buffer[i] = 0;
    BufferState = 0;
    HAL_TIM_PWM_Stop_DMA(&htim3, TIM_CHANNEL_1);
    return;
  }
  // Fill the first buffer
  for(uint_fast8_t i = 0; i < 8; ++i) {
    Buffer[i     ] = PWM_LO << (((RGB_Data[0] << i) & 0x80) > 0);
    Buffer[i +  8] = PWM_LO << (((RGB_Data[1] << i) & 0x80) > 0);
    Buffer[i + 16] = PWM_LO << (((RGB_Data[2] << i) & 0x80) > 0);
    Buffer[i + 24] = PWM_LO << (((RGB_Data[3] << i) & 0x80) > 0);
    Buffer[i + 32] = PWM_LO << (((RGB_Data[4] << i) & 0x80) > 0);
    Buffer[i + 40] = PWM_LO << (((RGB_Data[5] << i) & 0x80) > 0);
  }
  HAL_TIM_PWM_Start_DMA(&htim3, TIM_CHANNEL_1, (uint32_t *)Buffer, BUFFER_LEN);
  BufferState = 2; // Ready for next buffer
}

/*-----------------------------------------------------------*/

void HAL_TIM_PWM_PulseFinishedHalfCpltCallback(TIM_HandleTypeDef *htim) {
  // DMA buffer set from LED(wr_buf_p) to LED(wr_buf_p + 1)
  if(BufferState < NUM_PIXELS) {
    // Fill the lower buffer half
    for(uint_fast8_t i = 0; i < 8; ++i) {
      Buffer[i     ] = PWM_LO << (((RGB_Data[3 * BufferState    ] << i) & 0x80) > 0);
      Buffer[i +  8] = PWM_LO << (((RGB_Data[3 * BufferState + 1] << i) & 0x80) > 0);
      Buffer[i + 16] = PWM_LO << (((RGB_Data[3 * BufferState + 2] << i) & 0x80) > 0);
    }
    BufferState++;
  } else if (BufferState < NUM_PIXELS + 2) {
    //Fill buffer with 0 for reset
    for(uint8_t i = 0; i < BUFFER_LEN / 2; ++i) Buffer[i] = 0;
    BufferState++;
  }
}

/*-----------------------------------------------------------*/

void HAL_TIM_PWM_PulseFinishedCallback(TIM_HandleTypeDef *htim) {
  if(BufferState < NUM_PIXELS) {
    // Fill the higher buffer half
    for(uint_fast8_t i = 0; i < 8; ++i) {
      Buffer[i + 24] = PWM_LO << (((RGB_Data[3 * BufferState    ] << i) & 0x80) > 0);
      Buffer[i + 32] = PWM_LO << (((RGB_Data[3 * BufferState + 1] << i) & 0x80) > 0);
      Buffer[i + 40] = PWM_LO << (((RGB_Data[3 * BufferState + 2] << i) & 0x80) > 0);
    }
    BufferState++;
  } else if (BufferState < NUM_PIXELS + 2) {
    //Fill buffer with 0 for reset
    for(uint8_t i = BUFFER_LEN / 2; i < BUFFER_LEN; ++i) Buffer[i] = 0;
    ++BufferState;
  } else {
    // Data sent Stop DMA
    BufferState = 0;
    HAL_TIM_PWM_Stop_DMA(&htim3, TIM_CHANNEL_1);
  }
}
