

;   Begin of the program
     org 0000h                              ; Start address in memory
     lcall inits                            ; Initialize everything + value reset
     ljmp Mainloop                      


;   Initialization components
inits:
        ;mov sp,#7fh                         ; Initialize stack pointer
        lcall initports                      ; Set ports to input/output + alt functions
        lcall initftoetsen                   ; Initialize function knobs                    (protoboard)
        lcall initleds                       ; Initialize leds                              (protoboard)
        lcall initadc                        ; Set up adc
        lcall initspi                        ; Set up SPI interface (port 1)
        lcall inituart                       ; Set up UART interface (port 0)
        lcall aliases                        ; Set up all variables

;   Initialization values
initval:
        mov semitone, #00h                  ; Reset shifted semitones to 0
        mov octave, #00h                    ; Reset shifted octaves to 0
        mov notenum, #00h                   ; Set current note to 0

        mov reg1, #00h
        mov reg2, #00h
        mov reg3, #00h
        mov reg4, #00h
        mov reg5, #00h
        mov reg6, #00h
        mov reg7, #00h
        mov reg8, #00h                      ; Reset note values
        mov reg9, #00h
        mov reg10, #00h
        mov reg11, #00h
        mov reg12, #00h
        mov reg13, #00h
        mov reg14, #00h
        mov reg15, #00h
        ;mov P3_data, scanwire               ; scanwire to port
        ;mov octenable, p2_data              ; Read dipswitch en store in octave enable
        ret


;Start of loop
Mainloop:
        


scan1:
        mov scanwire, #00h                  ; Check first row
        mov pincheck, #01h                  ; Check first column
        mov a, reg1                         ; Moving reg 1 to accumulator
        mov regcomp, a                      ; Moving accumulator to register for comparison
        cjne a, P2_data, changerow1         ; If difference, go to function changerow1
        ljmp printrow1                      ; If no difference, go to printrow1

changerow1:
        lcall checkn1                       ; Update note 1

printrow1:
        mov P3_data, reg1
        ljmp scan1

        ret

        


#include	"e:\Practise Enterprise\Code\XC888\IronSolo.inc"
