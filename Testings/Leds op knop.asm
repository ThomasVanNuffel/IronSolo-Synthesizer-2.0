

;   Begin of the program
     org 0000h                                  ; Start address in memory     
     
      


;   Initialization components
inits:
        lcall initports                         ; Set ports to input/output + alt functions
        lcall aliases                           ; Set up all variables

        initval:

        mov reg1, #00h

;Start of the real program
Main:

        jnb p2_data.0, knob1off              ; If current input is low, go to note off

        knob1on:
            setb n1                            ; Set bit in register
            ljmp print

        knob1off:
            clr n1                             ; Clear bit in register

print:
            mov p4_data, reg0



ljmp Main
                                        


#include	"d:\Practise Enterprise\Code\XC888\definitief\Iron Solo Synthesizer.inc"

