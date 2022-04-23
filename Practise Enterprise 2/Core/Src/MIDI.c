#include "MIDI.h"

void MIDI(uint8_t Command, uint8_t Note)
{
	switch (Command)
	{
	case NOTE_ON:

		DEBUGPRINT("Note on: - Command %x  - Note: %x  - Velocity: %x", NOTE_ON, Note, 126);

		HWREG(MIDI_TX) = NOTE_ON;		// Command
		HAL_Delay(1);

		HWREG(MIDI_TX) = Note;			// Note
		HAL_Delay(1);

		HWREG(MIDI_TX) = 126;			// Velocity
		HAL_Delay(1);
		break;

	case NOTE_OFF:

		DEBUGPRINT("Note off: - Command %x  - Note: %d  - Velocity: %x", NOTE_OFF, Note, 0x00);

		HWREG(MIDI_TX) = NOTE_OFF;		// Command
		HAL_Delay(1);

		HWREG(MIDI_TX) = Note;			// Note
		HAL_Delay(1);

		HWREG(MIDI_TX) = 0x00;			// Velocity
		HAL_Delay(1);
		break;
	}
	DEBUGPRINT("\n");
}