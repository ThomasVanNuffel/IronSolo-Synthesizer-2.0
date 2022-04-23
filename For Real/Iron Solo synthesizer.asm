

;   Begin of the program
     org 0000h                                  ; Start address in memory
     mov sp,#7fh                                ; Initialize stack pointer (needs to be outside any function)     


;   Initialization components
inits:
        lcall initports                         ; Set ports to input/output + alt functions
        lcall aliases                           ; Set up all variables

;   Initialization valuesdadaaaz
initval:
        mov semitone, #12                 ; Reset shifted semitones
        mov octave, #24                   ; Reset shifted octaves
        mov controlnum, #00h                    ; Set current note

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

        mov p0_data, #00h
        mov p1_data, #00h
        mov p2_data, #00h                       ; No pins are high at startup
        mov p3_data, #00h
        mov p4_data, #00h
        mov p5_data, #00h


;Start of the real program

main:

    ;select0:
        mov p3_data, #0fh                           ; Select scan wire 0, led wire 15

        mov p4_data, reg15                          ; Register 15 to leds

    scan0a:

        mov regcomp, reg0                       ; Select register 0 as compare register

        note1:

            mov a, regcomp                           
            anl a, #00000001b                       ; First bit in register compare with
            mov compare, a                          

            mov a, P2_data                          ; First bit of P2_data
            anl a, #00000001b                      

            cjne a, compare, changeknob1            ; If input and register are not equal, change the knob

            ljmp note8                             ; If input and register are the same, go further

            changeknob1:

                jnb p2_data.0, knob1off              ; If current input is low, go to note off

                knob1on:

                    mov DDSnote1, #1

                    anl P1_data, #00011111b                 ; Slave selects are removed
                    orl p1_data, #00000000b                 ; Set DDS module zero active

                    setb n1

                    mov controlnum, #12

                    lcall SendSPIfreq3               ; Send

                    ljmp note8

                knob1off:

                    clr n1

                    mov a, #1
                    cjne a, DDSnote1, note8

                    anl P1_data, #00011111b                 ; Slave selects are removed
                    orl p1_data, #00000000b                 ; Set DDS module zero active

                    lcall SendSPIoff                   ; Send



    ;select1:

        mov P3_data, #10h                           ; Select wire 1 to scan, wire 0 to print

        mov p4_data, reg0                           ; Display the leds of register 0

        


    ;scan1a:

     note8:

            mov regcomp, reg1

            mov a,regcomp                           
            anl a, #00000010b                       ; Second bit in register compare with
            mov compare, a                          

            mov a, P2_data                          ; Second bit of P2_data
            anl a, #00000010b                      

            cjne a, compare, changeknob8            ; If input and register are not equal, change the knob

            ljmp main                             ; If input and register are the same, go further

            changeknob8:

                jnb p2_data.1, knob8off              ; If current input is low, go to note off

                knob8on:

                    setb n8

                    anl P1_data, #00011111b                 ; Slave selects are removed
                    orl p1_data, #00100000b                 ; Set DDS module zero active

                    mov controlnum, #15            ; 

                    lcall SendSPIfreq3               ; Send

                    ljmp main

                knob8off:

                    clr n8

                    anl p1_data, #00011111b                 ; Slave selects are removed
                    orl p1_data, #00100000b                 ; Set DDS module zero active

                    lcall SendSPIoff                   ; Send
;
;
 ;       note9:
;
 ;   .;select2:
  ;   .
   ; ;   mov P3_data, #10h                           ; Select wire 1 to scan, wire 0 to print
;
    ;    mov p4_data, reg1                           ; Display the leds of register 0


ljmp main







                                        



#include	"d:\Practise Enterprise\Code\XC888\definitief\Iron Solo Synthesizer.inc"