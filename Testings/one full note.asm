

;   Begin of the program
     org 0000h                                  ; Start address in memory
     mov sp,#7fh                                ; Initialize stack pointer (needs to be outside any function)
     lcall inits                                ; Initialize everything + value reset
     ljmp Main                      


;   Initialization components
inits:
        lcall initports                         ; Set ports to input/output + alt functions
        lcall aliases                           ; Set up all variables

;   Initialization values
initval:

        mov semitone, #12                 ; Reset shifted semitones
        mov octave, #24                   ; Reset shifted octaves

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
        ret


;Start of the real program

main:

    scan0:

        scan0a:

            mov regcomp, reg0                       ; Select register 0 as compare register

            note1:

                mov a,regcomp                           
                anl a, #00000001b                       ; First bit in register compare with
                mov compare, a                          

                mov a, P2_data                          ; First bit of P2_data
                anl a, #00000001b                      

                cjne a, compare, changeknob1            ; If input and register are not equal, change the knob

                ljmp print0                             ; If input and register are the same, go further

                changeknob1:

                    jnb p2_data.0, knob1off              ; If current input is low, go to note off

                    knob1on:

                        setb n1

                        ljmp print0

                    knob1off:

                        clr n1

            
    
        scan0b:

    print0:
        mov P3_data, #10h                           ; Select wire 1 to scan, wire 0 to print

        mov p4_data, reg0                           ; Display the leds of register 0

    note2:

        mov regcomp, reg1

                mov a,regcomp                           
                anl a, #00000010b                       ; Second bit in register compare with
                mov compare, a                          

                mov a, P2_data                          ; Second bit of P2_data
                anl a, #00000010b                      

                cjne a, compare, changeknob2            ; If input and register are not equal, change the knob

                ljmp print1                             ; If input and register are the same, go further

                changeknob2:

                    jnb p2_data.1, knob2off              ; If current input is low, go to note off

                    knob2on:

                        setb n8

                        ljmp print1

                    knob2off:

                        clr n8

    print1:
        mov P3_data, #10h                           ; Select wire 1 to scan, wire 0 to print

        mov p4_data, reg1                           ; Display the leds of register 0


ljmp main
                                        


#include	"d:\Practise Enterprise\Code\XC888\definitief\Iron Solo synthesizer.inc"
