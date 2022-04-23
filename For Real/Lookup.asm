

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

        mov p1_data, #00h                       ; Clear


;Start of the real program

main:

    ;select0:
        mov p3_data, #0fh                           ; Select scan wire 0, led wire 15

        mov p4_data, reg15                          ; Register 15 to leds

    scan0a:

        mov regcomp, reg0                       ; Select register 0 as compare register

        note1:

            mov a,regcomp                           
            anl a, #00000001b                       ; First bit in register compare with
            mov compare, a                          

            mov a, P2_data                          ; First bit of P2_data
            anl a, #00000001b                      

            cjne a, compare, changeknob1            ; If input and register are not equal, change the knob

            ljmp main                             ; If input and register are the same, go further

            changeknob1:

                jnb p2_data.0, knob1off              ; If current input is low, go to note off

                knob1on:

                   setb n1

                    mov r1, #20h
                    mov r2, #00h                    ; No reset

                    lcall SendSPI                   ; Send

                    mov controlnum, #0

                    lcall SendSPIfreq3               ; Send

                    ljmp main

                knob1off:

                    clr n1

                    mov r1, #01h                    ; Reset
                    mov r2, #00h

                    lcall SendSPI                   ; Send

    ljmp main


SendSPIfreq3:

        mov a, #00h

        clr c

        mov dptr, #table        ; Start of table

        movc a, @a+dptr         ; Get first byte

        mov r1, a               ; Mov to MSB 1

        inc dptr                ; +1

        movc a, @a+dptr         ; Get second byte

        mov r2, a               ; Mov to LSB 1

        inc dptr                ; +1
        
        movc a, @a+dptr         ; Get third byte

        mov r3, a               ; Mov to MSB 2

        inc dptr
        
        movc a, @a+dptr         ; Get fourth byte

        mov r4, a               ; Mov to LSB 2

        lcall SendSPIfreq

        ret


table:

        db 01001101b
        db 11010011b              ; Frequency of note
        db 01000000b
        db 00000000b

        db 01111111b
        db 11111111b              ; Frequency of note
        db 01000000b
        db 00000000b

        db 01111111b
        db 11111111b              ; Frequency of note
        db 01000000b
        db 00000001b

        db 01111111b
        db 11111111b              ; Frequency of note
        db 01000000b
        db 00000011b



#include	"d:\Practise Enterprise\Code\XC888\definitief\Iron Solo Synthesizer.inc"