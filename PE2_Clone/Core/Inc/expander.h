/*
 * expander.h
 *
 *  Created on: Mar 7, 2022
 *      Author: vannu
 */

#include "main.h"
#include <stdint.h>

#ifndef INC_EXPANDER_H_
#define INC_EXPANDER_H_


	#define IO_ADDRESS 0x40								// Defines the I2C address of the I/O expander (shifted one bit to the left)

	#define AMPLIFIER_ADDRESS 0xD0						// Defines the I2C address of the TDA7575B audio amplifier (with pin A and B connected to ground)

	#define WRITE 5

	#define READ 6

	#define IO_EXPANDER 7

	#define AMPLIFIER 8

// Define IO Expander Registers

	// Data registers

	#define XC888_DATA 0x00								// Port 0 input register

	#define NOTE_DATA 0x09								// Port 1 output register

	#define SPI_DATA 0x0A								// Port 2 output register

	#define POWER_DATA 0x0B								// Port 3 output register

	#define FEEDBACK_DATA 0x04							// Port 4 input register

	#define VELOCITY_DATA 0x0D							// Port 5 output register

	// Port settings registers

	#define PORT_SELECT 0x18							// Select port register (for advanced settings)

	#define PORT_DIR 0x1C								// Define whether a pin is input or output

	#define PORT_HIGHZ 0x23								// Define whether a pin is high impedance or not

	#define PORT_PWM 0x18								// Define which pins are getting PWM and which are GPIO

	// PWM Settings Registers

	#define PWM_SELECT 0x28								// Select PWM generator (for advanced settings)

	#define PWM_SOURCE									// Select the clock source for the PWM generation

	#define PWM_DUTYCYCLE								// Adjust the dutycycle for the PWM

	#define START 1										// Command to start the envelope

	#define STOP 0										// Command to stop the envelope

void Envelope(uint8_t Command, uint8_t Which_one);

uint16_t I2C(uint8_t Device, uint8_t Command, uint8_t Address, uint16_t *Data);



#endif /* INC_EXPANDER_H_ */
