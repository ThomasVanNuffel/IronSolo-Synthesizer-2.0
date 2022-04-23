
;
;
;   Some reminders
;
;
;   Port 5 is connected to the scan matrix
;
;   Port 3 is connected to the I/O expander
;
;   Port 2 is the input
;
;   We start sending from #01h because #00 is used for a special reason
;
;   Data to the I/O expander
;
;       7           6       5       4       3       2       1       0
;
;    Potentio     value   value   value   value   value   Which   Which
;
;      knob       value   Which   Which   Which   Which   Which   Which
;
;   Knob = 0:
;       value = on or off
;           0 = off
;           1 = on
;       Which is which knob:
;           0-48 = piano knobs
;           49-63 = other knobs
;
;
;   Potentiometer = 1:
;       Which = Number of potmeter starting from left
;       Value = value of potmeter


;   Begin of the program
     org 0000h                                  ; Start address in memory
     mov sp,#7fh                                ; Initialize stack pointer (needs to be outside any function)     


;   Initialization components
inits:
        lcall initports                         ; Set ports to input/output + alt functions
        lcall aliases                           ; Set up all variables
        lcall initval                           ; Assign start value to them

;Start of the real program

main:

    ; Wait efkes
        mov a, 5
        lcall delaya0k05

    ; Select first scan
        mov p5_data, #00h                       ; Select scan wire 0
        mov regcomp, reg0                       ; Select register 0 as compare register

    ; Check all notes
        note1:
            mov a, regcomp
            anl a, #00000001b                       ; Set compare register to the first bit
            mov compare, a

            mov a, P2_data                          ; Set input register to the first bit
            anl a, #00000001b                      

            cjne a, compare, changeknob1            ; If register is NOT the same as input, change the knob
            ljmp note2                              ; If input and register are the same, check the next note

            changeknob1:
                jnb p2_data.0, knob1off             ; If current input is low, go to note off

                knob1on:
                    setb n1                         ; Set bit in register
                    mov P3_data, #01000001b         ; Send note on to the I/O
                    ljmp note2

                knob1off:
                    clr n1                          ; Clear bit in register
                    mov P3_data, #00000001b         ; Send note off to the I/O

        note2:
            mov a, regcomp
            anl a, #00000010b                       ; Set compare register to the second bit
            mov compare, a

            mov a, P2_data                          ; Set input register to the second bit
            anl a, #00000010b                      

            cjne a, compare, changeknob2            ; If register is NOT the same as input, change the knob
            ljmp main                              ; If input and register are the same, check the next note

            changeknob2:
                jnb p2_data.1, knob2off             ; If current input is low, go to note off

                knob1on:
                    setb n2                         ; Set bit in register
                    mov P3_data, #01000010b         ; Send note on to the I/O
                    ljmp main

                knob1off:
                    clr n2                          ; Clear bit in register
                    mov P3_data, #00000010b         ; Send note on to the I/O

ljmp main


#include	"..\Iron Solo Synthesizer.inc"