/*
 * Screen.h
 *
 *  Created on: 16 Mar 2022
 *      Author: vannu
 */

#include "main.h"
#include "../../Drivers/BSP/inc/stm32f7508_discovery_ts.h"
#include <stdint.h>

#ifndef INC_SCREEN_H_
#define INC_SCREEN_H_

// Define LCD Names

	#define MAIN_SCREEN 0xA0				// Name of main screen

	#define FREQUENCY_GENERATOR 0xA1		// Name of frequency generator screen

	#define SCREEN 2

	#define TEST_SCREEN 0				// Name of test screen

	#define TEST_SCREEN_1 1				// Name of test screen

	#define DEN_TEST 2				// Name of test screen

void CheckScreen();

#endif /* INC_SCREEN_H_ */
