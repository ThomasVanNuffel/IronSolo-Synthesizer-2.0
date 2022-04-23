/*
 * Memory
 *
 *  Created on: Mar 7, 2022
 *      Author: vannu
 */

#ifndef INC_MEMORY_H_
#define INC_MEMORY_H_


#ifndef HWREG(x)
#define HWREG(x) *((uint32_t*)(x))					// Macro to access hardware registers
#endif

#define DEBUGGER_TX 0x40011028						// Address of the USART1 TX Register

#define DDS_TXDATA 0x4000380C						// Address of the SPI2 TX Register



#endif /* INC_MEMORY_H_ */
