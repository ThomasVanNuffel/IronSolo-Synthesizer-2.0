

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


;Start of the real program

main:

    mov a, #07h

    lcall getadc0to7                        ; Measure, output in accumulator

    mov p3_data, a                          ; Show it on leds

    lcall delay1ms                          ; Wait

    ljmp main

    ;rl a
    ;rl a                                    ; Get two most significant bits
    ;anl a, #02h

    ;cjne a, #00h, setsine                   ; If accumulator equals zero, set sinewave
    ;cjne a, #01h, settriangle               ; If accumulator equals one, set triangle wave
    ;cjne a, #02h, setsquare                 ; If accumulator equals two, set square wave
    ;cjne a, #03h, setpwm                    ; If accumulator equals three, set pwm signal

    ;setsine:
    ;    setb n1
    ;    clr  n2
    ;    clr  n3
    ;    clr  n3
    ;    ljmp hop
    
    ;settriangle:
    ;    clr  n1
    ;    setb n2
    ;    clr  n3
    ;    clr  n4
    ;    ljmp hop

    ;setsquare:
    ;    clr  n1
    ;    clr  n2
    ;    setb n3
    ;    clr  n4
    ;    ljmp hop

    ;setpwm:
    ;    clr  n1
    ;    clr  n2
    ;    clr  n3
    ;    setb n4

    ;hop:

    

#include	"d:\Practise Enterprise\Code\XC888\definitief\Iron Solo Synthesizer.inc"