

;   Begin of the program
    org 0000h                                  ; Start address in memory     
    mov sp,#7fh

;   Initialization components

    lcall initports                         ; Set ports to input/output + alt functions

    anl P1_data, #00011111b                 ; Slave selects are removed


    loopke:

        mov regcomp, reg0                       ; Select register 0 as compare register

        note1:

            mov a,regcomp                           
            anl a, #00000001b                       ; First bit in register compare with
            mov compare, a                          

            mov a, P2_data                          ; First bit of P2_data
            anl a, #00000001b                      

            cjne a, compare, changeknob1            ; If input and register are not equal, change the knob

            ljmp loopke                             ; If input and register are the same, go further

            changeknob1:

                jnb p2_data.0, knob1off              ; If current input is low, go to note off

                knob1on:

                   setb n1

                   mov DDSnote1, #1

                   mov r1, #20h
                    mov r2, #00h                    ; No reset

                    lcall SendSPI                   ; Send

                    mov r1, #01111111b
                    mov r2, #11111111b              ; Frequency of note
                    mov r3, #01000000b
                    mov r4, #00000000b

                    lcall SendSPIfreq               ; Send

                    ljmp loopke

                knob1off:

                    clr n1

                    mov r1, #01h                    ; Reset
                    mov r2, #00h

                    lcall SendSPI                   ; Send

                ljmp loopke




#include	"d:\Practise Enterprise\Code\XC888\definitief\Iron Solo Synthesizer.inc"




