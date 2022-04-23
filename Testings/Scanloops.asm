;   Begin of the program
     org 0000h                                  ; Start address in memory     
     
;   Initialization components
inits:
    lcall initports                         ; Set ports to input/output + alt functions
    lcall aliases                           ; Set up all variables

    mov waveformselect,#00h

;   Initialisation values
initval:

    mov P3_data, #00h
    mov P4_data, #00h
    mov P5_data, #00h

    mov semitone, #12                       ; Reset shifted semitones
    mov octave, #24                         ; Reset shifted octaves

    mov DDSselect, #0                       ; Select first DDS

    mov reg1, #00h
    mov reg2, #00h
    mov reg3, #00h
    mov reg4, #00h
    mov reg5, #00h
    mov reg6, #00h
    mov reg7, #00h
    mov reg8, #00h                          ; No notes are pressed on startup
    mov reg9, #00h
    mov reg10, #00h
    mov reg11, #00h
    mov reg12, #00h
    mov reg13, #00h
    mov reg14, #00h
    mov reg15, #00h

    mov addnum,#35                          ; Default number to add


;Start of the real program
main:

    scan0a:

        mov P3_data, #0fh                       ; Wire 0 to scan input, wire 15 to display leds
        mov regcomp, reg0                       ; Select register 0 as compare register

        note1:

            mov a,regcomp                           ; Register 1 to compare
            anl a, #00000001b                       ; Select bit of compare register
            mov compare, a                          ; Compare value is set

            mov a, P2_data                          ; P2_data to accumulator
            anl a, #00000001b                       ; Check first bit

            cjne a, compare, changeknob1            ; If input and register are not equal, change the knob

            clr P3_data.6

            lcall delay1ms

            ljmp scan0a                             ; If input and register are the same, go further

            changeknob1:

                setb P3_data.6

                lcall delay1ms

                jnb p2_data.0, knob1off              ; If current input is low, go to note off

                knob1on:

                    setb n1

                    ljmp print

                knob1off:

                    clr n1


    print:
        mov p4_data, reg0

ljmp main



#include	"d:\Practise Enterprise\Code\XC888\definitief\Iron Solo Synthesizer.inc"