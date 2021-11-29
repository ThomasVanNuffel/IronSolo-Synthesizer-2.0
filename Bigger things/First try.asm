

;   variables

     scanwire   equ     30h                 ; Select the wire that needs to be scanned
     octenable  equ     31h                 ; Select the enabled octaves
     semitone   equ     32h                 ; Shifted semitones
     octave     equ     33h                 ; Shifted octaves
   
 
;   Begin of the program
     org 0000h                              ; Start address in memory
     lcall inits                            ; Initialize everything + value reset
     ljmp Mainloop                      


;   Initialization components
inits:
        ;mov sp,#7fh                         ; Initialize stack pointer
        ;lcall initports                     ; Set ports to input/output
        lcall initftoetsen                  ; Initialize function knobs
        lcall initleds                      ; Initialize leds
        ;lcall initadc                       ; Set up adc
        ;lcall initspi                       ; Set up SPI interface (port 1)
        ;lcall inituart                      ; Set up UART interface (port 0)
        lcall aliases

;   Initialization values
initval:
        mov semitone, #00h                  ; Reset shifted semitones to 0
        mov octave, #00h                    ; Reset shifted octaves to 0
        mov scanwire, #0fh                  ; Set scanwire to 15

        mov reg1, #ffh
        mov reg2, #ffh
        mov reg3, #ffh
        mov reg4, #ffh
        mov reg5, #ffh
        mov reg6, #ffh
        mov reg7, #ffh
        mov reg8, #ffh                      ; Reset note values
        mov reg9, #ffh
        mov reg10, #ffh
        mov reg11, #ffh
        mov reg12, #ffh
        mov reg13, #ffh
        mov reg14, #ffh
        mov reg15, #ffh
        ;mov P3_data, scanwire               ; scanwire to port
        ;mov octenable, p2_data              ; Read dipswitch en store in octave enable
        ret


;Start of loop
Mainloop:
        mov scanwire, #00h                  ; Reset scanwire to 0

knop1:
        jnb p2_data.0, clear1
        setb n69
        ljmp knop2

clear1:
        clr n69

knop2:
        jnb p2_data.1, clear2
        setb n2
        ljmp knop3

clear2:
        clr n2

knop3:
        jnb p2_data.2, clear3
        setb n3
        ljmp print

clear3:
        clr n3
print:
        mov P3_data, reg12

        ljmp knop1

        ret


        


#include	"e:\Practise Enterprise\Code\XC888\IronSolo.inc"
