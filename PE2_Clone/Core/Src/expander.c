/*
 * expander.c
 *
 *  Created on: Mar 7, 2022
 *      Author: vannu
 */

#include "expander.h"

/*
 * Device: amplifier or IO_expander
 * Command: Read or write
 * Address: Register address to be read or written
 * Data: if write action, data to be sent
 * return: Data which is read from the device (max 2 bytes)
 */

uint16_t I2C(uint8_t Device, uint8_t Command, uint8_t Address, uint16_t *Data)
{

	extern I2C_HandleTypeDef hi2c1;

	uint16_t ReadData = 0;

	switch(Device)
	{
	case IO_EXPANDER:
		if(Command == WRITE)
		{
			HAL_I2C_Master_Transmit(&hi2c1, IO_ADDRESS, (uint8_t)Data, 1, HAL_MAX_DELAY);					// Transmit one byte of data
			return 0;
		}
		else if(Command == READ)
		{
			HAL_I2C_Master_Receive(&hi2c1, IO_ADDRESS, (uint8_t)ReadData, 1, HAL_MAX_DELAY);				// Receive one byte of data
			return ReadData;
		}
		else
		{
			DEBUGPRINT("Ge ga ni lezen en ni schrijven ?? Wa zijde van zin ?");
			return 0;
		}
		break;

	case AMPLIFIER:
			if(Command == WRITE)
			{
				HAL_I2C_Master_Transmit(&hi2c1, AMPLIFIER_ADDRESS, &Data, 2, HAL_MAX_DELAY);		// Transmit two bytes of data
				return 0;
			}
			else if(Command == READ)
			{
				HAL_I2C_Master_Receive(&hi2c1, AMPLIFIER_ADDRESS, &ReadData, 2, HAL_MAX_DELAY);	// Read two bytes of data
				return ReadData;
			}
			else
			{
				DEBUGPRINT("Ge ga ni lezen en ni schrijven ?? Wa zijde van zin ?");
				return 0;
			}
			break;

	default:
		DEBUGPRINT("Da apparaat kenk ni ze. Tis of amplifier of IO expander");
		return 0;
		break;
	}
}


void Envelope(uint8_t Command, uint8_t Which_one)
{
	switch (Command)
	{
	case START:

		DEBUGPRINT("\nEnvelope %d is attacking", Which_one + 1);

		switch (Which_one)
		{
		case 0:
			break;
		case 1:
			break;
		case 2:
			break;
		case 3:
			break;
		case 4:
			break;
		case 5:
			break;
		case 6:
			break;
		case 7:
			break;

		default:
			DEBUGPRINT("Error: Invalid envelope assigned");
			break;
		}
		break;

	case STOP:

		DEBUGPRINT("Envelope %d is Releasing", Which_one + 1);

		switch (Which_one)
		{
		case 0:
			break;
		case 1:
			break;
		case 2:
			break;
		case 3:
			break;
		case 4:
			break;
		case 5:
			break;
		case 6:
			break;
		case 7:
			break;
		default:
			DEBUGPRINT("Error: Invalid envelope assigned");
			break;
		}
		break;
	}
}
