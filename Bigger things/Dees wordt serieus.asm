

;   Begin of the program
     org 0000h                                  ; Start address in memory
     mov sp,#7fh                                ; Initialize stack pointer (needs to be outside any function)
     lcall inits                                ; Initialize everything + value reset
     ljmp Main                      


;   Initialization components
inits:
        lcall initports                         ; Set ports to input/output + alt functions
        lcall initftoetsen                      ; Initialize function knobs                    (protoboard)
        lcall initleds                          ; Initialize leds                              (protoboard)
        lcall initadcs                          ; Set up adc
        lcall initspi                           ; Set up SPI interface (port 1)
        lcall inituart                          ; Set up UART interface (port 0)
        lcall aliases                           ; Set up all variables
        lcall initDDS                           ; Set up all DDS modules

;   Initialization values
initval:
        mov semitone, Resetnote                 ; Reset shifted semitones to 0
        mov octave, Resetnote                   ; Reset shifted octaves to 0
        mov controlnum, #00h                    ; Set current note to 0

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
        mov addnum,#36                          ; Default number to add
        ret


;Start of the real program
Main:
        
scan1a:

        mov P3_data,#0fh                        ; Select wire to check knobs and previous wire for leds         0 is current (keys) f is previous (leds)

        mov regcomp, reg1                       ; Set register 1 as register to compare with
        mov a, regcomp                          ; Mov to accumulator to compare
        
        cjne a, P2_data, changerow1             ; If register is not equal to input (change is applied), then change the inside values
        
        ljmp scan1b                             ; If no difference, go further

        changerow1:

                checkknob1:
                        mov controlnum, #1                      ; Set note 1 as current note

                        mov a,regcomp                           ; Register 1 to compare
                        anl a, #00000001b                       ; Select bit of compare register
                        mov compare, a                          ; Compare value is set

                        mov a, P2_data                          ; P2_data to accumulator
                        anl a, #00000001b                       ; Check first bit

                        cjne a, compare, changeknob1            ; If input and register are not equal, change the knob
                        ljmp checkknob2                         ; If input and register are the same, go further

                        changeknob1:
                                jnb p2_data.0, knob1off              ; If current input is low, go to note off

                                knob1on:          
                                        lcall SNoteon                      ; Send note on command MIDI
                                        setb n1                            ; Set bit in register
                                        lcall DDSon                        ; Send the frequency to DDS
                                        ljmp checkknob2                    ; Check next knob

                                knob1off:
                                        lcall SNoteoff                     ; Send note off command MIDI
                                        clr n1                             ; Clear bit in register
                                        



                checkknob2:
                        mov controlnum, #2                              ; Set note 1 as current note

                                mov a,regcomp                           ; Register 1 to compare
                                anl a, #00000010b                       ; Select bit of compare register
                                mov compare, a                          ; Compare value is set

                                mov a, P2_data                          ; P2_data to accumulator
                                anl a, #00000010b                       ; Check first bit

                                cjne a, compare, changeknob2            ; If input and register are not equal, change the knob
                                ljmp checkknob3                         ; If input and register are the same, go further

                                changeknob2:
                                        jnb p2_data.0, knob2off              ; If input is low, go to note off

                                        knob2on:          
                                                lcall SNoteon                      ; Send note on command MIDI
                                                setb n2                            ; Set bit in register
                                                lcall DDSon                        ; Send the frequency to DDS
                                                ljmp checkknob3                    ; Go to next note

                                        knob2off:
                                                lcall SNoteoff                     ; Send note off command MIDI
                                                clr n2                             ; Clear bit in register


                checkknob3:
                        nop

scan1b:

        checkpot1:
                mov a,#06h                              ; We measure voltage on channel 6
                lcall getadc0to7                        ; Measurement: result in a and b register but only a is needed
                anl a,#11111110b                        ; MIDI is seven bit
                rr a                                    ; Right align

                cjne a, pot1, changepot1                ; If present value is not the previous one, change the pot
                ljmp checkpot2                          ; If input and register are the same, go further
 
                changepot1:
                        mov pot1, a                     ; New value replaces the old one

                        mov controlnum,#16              ; General purpose slider 1

                        mov potval, a                   ; Value for MIDI
                        lcall Spot                      ; Send MIDI


        checkpot2:
                mov a,#07h                              ; We measure voltage on channel 7
                lcall getadc0to7                        ; Measurement: result in a and b register but only a is needed
                anl a,#11111110b                        ; MIDI is seven bit
                rr a                                    ; Right align

                cjne a, pot2, changepot2                ; If present value is not the previous one, change the pot
                ljmp scan2a                             ; If input and register are the same, go further
 
                changepot2:
                        mov pot2, a                     ; New value replaces the old one

                        mov controlnum,#17              ; General purpose slider 2
                        
                        mov potval, a                   ; Value for MIDI
                        lcall Spot                      ; Send MIDI
                    
scan2a:
    nop

printrow1:
        mov P4_data, reg1
        ljmp scan1a


#include	"e:\Practise Enterprise\Code\XC888\IronSolo try.inc"