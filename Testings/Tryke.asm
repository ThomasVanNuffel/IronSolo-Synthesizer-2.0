

;   Begin of the program
     org 0000h                                  ; Start address in memory
     mov sp,#7fh                                ; Initialize stack pointer (needs to be outside any function)     


;   Initialization components
inits:
        lcall initports                         ; Set ports to input/output + alt functions
        lcall initddses
        lcall aliases                           ; Set up all variables

;   Initialization valuesdadaaaz
initval:
        mov semitone, #12                 ; Reset shifted semitones
        mov octave, #24                   ; Reset shifted octaves
        mov controlnum, #00h                    ; Set current note

        mov DDSselect, #00h                       ; Select first DDS

        mov waveformselect, #00h

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

    select0:
        mov p3_data, #00h                           ; Select scan wire 0, led wire 15
        mov p4_data, reg0                          ; Register 15 to leds

        mov r0, #7
        loopke:
            lcall delay1ms
            djnz r0, loopke

    scan0a:

        mov regcomp, reg0                       ; Select register 0 as compare register

        note1:                                                                                                                              ; Name

            mov a,regcomp                           
            anl a, #00000001b                       ; First bit in register compare with
            mov compare, a                                                                                                                  ; Change which bits compared

            mov a, P2_data                          ; First bit of P2_data
            anl a, #00000001b                      

            cjne a, compare, changeknob1            ; If input and register are not equal, change the knob

            ljmp note2                            ; If input and register are the same, go further                                          ; Jump to next

            changeknob1:                                                                                                                    ; Name

                mov controlnum, #12                                                                                                         ; Change controlnum                                        

                jnb p2_data.0, knob1off              ; If current input is low, go to note off                                              ; Change which pin of p2

                knob1on:                                                                                                                    ; Name


                    mov a, waveformselect

                    inc a                           ; Andere waveform

                    cjne a, #4, verder              ; Loop door de waveforms

                    mov a, #000h                    ; Als waarde te hoog is, reset

                    verder:                         ; Als waarde goed is, ga verder

                    mov waveformselect, a           ; Steek terug in variable
                        
                    mov DDSnote1, controlnum                                                                                                ; Change DDS

                    anl p1_data, #00011111b          ; Set DDS to DDS 0
                    orl p1_data, #00000000b          ; Select DDS zero                                                                      ; Select DDS

                    lcall SendSPIfreq3               ; Send

                    setb n1                          ; Set bit in register                                                                  ; Change bit

                    ljmp note2                                                                                                              ; Jump to next note

                knob1off:

                    clr n1                          ; Clear bit in register                                                                 ; Change bit

                    mov waveformselect, #00h

                    mov a, controlnum               ; Check if this note is on the DDS

                    cjne a, DDSnote1, note2         ; If not on DDS, go further                                                             ; Change DDS register

                    anl p1_data, #00011111b         ; If note is on DDS, select the DDS module and note off command 
                    orl p1_data, #00000000b         ; Select DDS to send to                                                                 ; Change DDS

                    lcall SendSPIoff                  ; Send




        note2:                                                                                                                              ; Name

            mov a,regcomp                           
            anl a, #00000010b                       ; First bit in register compare with
            mov compare, a                                                                                                                  ; Change which bits compared

            mov a, P2_data                          ; First bit of P2_data
            anl a, #00000010b                      

            cjne a, compare, changeknob2            ; If input and register are not equal, change the knob

            ljmp note3                              ; If input and register are the same, go further                                        ; Jump to next

            changeknob2:                                                                                                                    ; Name

                mov controlnum, #13                                                                                                         ; Change controlnum                                        

                jnb p2_data.1, knob2off              ; If current input is low, go to note off                                              ; Change which pin of p2

                knob2on:                                                                                                                    ; Name

                    mov DDSnote1, controlnum                                                                                                ; Change DDS

                    anl p1_data, #00011111b          ; Set DDS to DDS 0
                    orl p1_data, #00000000b          ; Select DDS zero                                                                      ; Select DDS

                    lcall SendSPIfreq3               ; Send

                    setb n2                          ; Set bit in register                                                                  ; Change bit

                    ljmp note3                                                                                                              ; Jump to next note

                knob2off:

                    clr n2                          ; Clear bit in register                                                                 ; Change bit

                    mov a, controlnum               ; Check if this note is on the DDS

                    cjne a, DDSnote1, note3         ; If not on DDS, go further                                                             ; Change DDS register

                    anl p1_data, #00011111b         ; If note is on DDS, select the DDS module and note off command 
                    orl p1_data, #00000000b         ; Select DDS to send to                                                                 ; Change DDS

                    lcall SendSPIoff                  ; Send




        note3:                                                                                                                              ; Name

            mov a,regcomp                           
            anl a, #00000100b                       ; First bit in register compare with
            mov compare, a                                                                                                                  ; Change which bits compared

            mov a, P2_data                          ; First bit of P2_data
            anl a, #00000100b                      

            cjne a, compare, changeknob3            ; If input and register are not equal, change the knob

            ljmp note4                            ; If input and register are the same, go further                                          ; Jump to next

            changeknob3:                                                                                                                    ; Name

                mov controlnum, #14                                                                                                         ; Change controlnum                                        

                jnb p2_data.2, knob3off              ; If current input is low, go to note off                                              ; Change which pin of p2

                knob3on:                                                                                                                    ; Name

                    mov DDSnote1, controlnum                                                                                                ; Change DDS

                    anl p1_data, #00011111b          ; Set DDS to DDS 0
                    orl p1_data, #00000000b          ; Select DDS zero                                                                      ; Select DDS

                    lcall SendSPIfreq3               ; Send

                    setb n3                          ; Set bit in register                                                                  ; Change bit

                    ljmp note4                                                                                                               ; Jump to next note

                knob3off:

                    clr n3                          ; Clear bit in register                                                                 ; Change bit

                    mov a, controlnum               ; Check if this note is on the DDS

                    cjne a, DDSnote1, note4        ; If not on DDS, go further                                                             ; Change DDS register

                    anl p1_data, #00011111b         ; If note is on DDS, select the DDS module and note off command 
                    orl p1_data, #00000000b         ; Select DDS to send to                                                                 ; Change DDS

                    lcall SendSPIoff                  ; Send


        note4:                                                                                                                              ; Name

            mov a,regcomp                           
            anl a, #00001000b                       ; First bit in register compare with
            mov compare, a                                                                                                                  ; Change which bits compared

            mov a, P2_data                          ; First bit of P2_data
            anl a, #00001000b                      

            cjne a, compare, changeknob4            ; If input and register are not equal, change the knob

            ljmp note5                            ; If input and register are the same, go further                                          ; Jump to next

            changeknob4:                                                                                                                    ; Name

                mov controlnum, #15                                                                                                         ; Change controlnum                                        

                jnb p2_data.3, knob4off              ; If current input is low, go to note off                                              ; Change which pin of p2

                knob4on:                                                                                                                    ; Name

                    mov DDSnote1, controlnum                                                                                                ; Change DDS

                    anl p1_data, #00011111b          ; Set DDS to DDS 0
                    orl p1_data, #00000000b          ; Select DDS zero                                                                      ; Select DDS

                    lcall SendSPIfreq3               ; Send

                    setb n4                          ; Set bit in register                                                                  ; Change bit

                    ljmp note5                                                                                                              ; Jump to next note

                knob4off:

                    clr n4                          ; Clear bit in register                                                                 ; Change bit

                    mov a, controlnum               ; Check if this note is on the DDS

                    cjne a, DDSnote1, note5        ; If not on DDS, go further                                                             ; Change DDS register

                    anl p1_data, #00011111b         ; If note is on DDS, select the DDS module and note off command 
                    orl p1_data, #00000000b         ; Select DDS to send to                                                                 ; Change DDS

                    lcall SendSPIoff                  ; Send

        
        note5:                                                                                                                              ; Name

            mov a,regcomp                           
            anl a, #00010000b                       ; First bit in register compare with
            mov compare, a                                                                                                                  ; Change which bits compared

            mov a, P2_data                          ; First bit of P2_data
            anl a, #00010000b                      

            cjne a, compare, changeknob5            ; If input and register are not equal, change the knob

            ljmp note6                            ; If input and register are the same, go further                                          ; Jump to next

            changeknob5:                                                                                                                    ; Name

                mov controlnum, #16                                                                                                         ; Change controlnum                                        

                jnb p2_data.4, knob5off              ; If current input is low, go to note off                                              ; Change which pin of p2

                knob5on:                                                                                                                    ; Name

                    mov DDSnote1, controlnum                                                                                                ; Change DDS

                    anl p1_data, #00011111b          ; Set DDS to DDS 0
                    orl p1_data, #00000000b          ; Select DDS zero                                                                      ; Select DDS

                    lcall SendSPIfreq3               ; Send

                    setb n5                          ; Set bit in register                                                                  ; Change bit

                    ljmp note6                                                                                                              ; Jump to next note

                knob5off:

                    clr n5                          ; Clear bit in register                                                                 ; Change bit

                    mov a, controlnum               ; Check if this note is on the DDS

                    cjne a, DDSnote1, note6        ; If not on DDS, go further                                                             ; Change DDS register

                    anl p1_data, #00011111b         ; If note is on DDS, select the DDS module and note off command 
                    orl p1_data, #00000000b         ; Select DDS to send to                                                                 ; Change DDS

                    lcall SendSPIoff                  ; Send

        note6:                                                                                                                              ; Name

            mov a,regcomp                           
            anl a, #00100000b                       ; First bit in register compare with
            mov compare, a                                                                                                                  ; Change which bits compared

            mov a, P2_data                          ; First bit of P2_data
            anl a, #00100000b                      

            cjne a, compare, changeknob6            ; If input and register are not equal, change the knob

            ljmp scan0b                            ; If input and register are the same, go further                                         ; Jump to next

            changeknob6:                                                                                                                    ; Name

                mov controlnum, #17                                                                                                         ; Change controlnum                                        

                jnb p2_data.5, knob6off              ; If current input is low, go to note off                                              ; Change which pin of p2

                knob6on:                                                                                                                    ; Name

                    mov DDSnote1, controlnum                                                                                                ; Change DDS

                    anl p1_data, #00011111b          ; Set DDS to DDS 0
                    orl p1_data, #00000000b          ; Select DDS zero                                                                      ; Select DDS

                    lcall SendSPIfreq3               ; Send

                    setb n6                          ; Set bit in register                                                                  ; Change bit

                    ljmp scan0b                                                                                                             ; Jump to next note

                knob6off:

                    clr n6                          ; Clear bit in register                                                                 ; Change bit

                    mov a, controlnum               ; Check if this note is on the DDS

                    cjne a, DDSnote1, scan0b        ; If not on DDS, go further                                                             ; Change DDS register

                    anl p1_data, #00011111b         ; If note is on DDS, select the DDS module and note off command 
                    orl p1_data, #00000000b         ; Select DDS to send to                                                                 ; Change DDS

                    lcall SendSPIoff                  ; Send



        

    scan0b:


    select1:
        mov p3_data, #11h                          ; Select scan wire 1, led wire 0
        mov p4_data, reg1                          ; Register to leds

        mov r0, #7
        loopke1:
            lcall delay1ms
            djnz r0, loopke1      

    scan1a:

        mov regcomp, reg1                       ; Select register 1 as compare register

        note7:                                                                                                                              ; Name

            mov a,regcomp                           
            anl a, #00000001b                       ; First bit in register compare with
            mov compare, a                                                                                                                  ; Change which bits compared

            mov a, P2_data                          ; First bit of P2_data
            anl a, #00000001b                      

            cjne a, compare, changeknob7            ; If input and register are not equal, change the knob

            ljmp note8                            ; If input and register are the same, go further                                          ; Jump to next

            changeknob7:                                                                                                                    ; Name

                mov controlnum, #18                                                                                                         ; Change controlnum                                        

                jnb p2_data.0, knob7off              ; If current input is low, go to note off                                              ; Change which pin of p2

                knob7on:                                                                                                                    ; Name

                    mov DDSnote2, controlnum                                                                                                ; Change DDS

                    anl p1_data, #00011111b          ; Set DDS to DDS 0
                    orl p1_data, #00100000b          ; Select DDS one                                                                      ; Select DDS

                    lcall SendSPIfreq3               ; Send

                    setb n7                          ; Set bit in register                                                                  ; Change bit

                    ljmp note8                                                                                                              ; Jump to next note

                knob7off:

                    clr n7                          ; Clear bit in register                                                                 ; Change bit

                    mov a, controlnum               ; Check if this note is on the DDS

                    cjne a, DDSnote2, note8         ; If not on DDS, go further                                                             ; Change DDS register

                    anl p1_data, #00011111b         ; If note is on DDS, select the DDS module and note off command 
                    orl p1_data, #00100000b         ; Select DDS to send to                                                                 ; Change DDS

                    lcall SendSPIoff                  ; Send



        note8:                                                                                                                              ; Name

            mov a,regcomp                           
            anl a, #00000010b                       ; First bit in register compare with
            mov compare, a                                                                                                                  ; Change which bits compared

            mov a, P2_data                          ; First bit of P2_data
            anl a, #00000010b                      

            cjne a, compare, changeknob8            ; If input and register are not equal, change the knob

            ljmp note9                              ; If input and register are the same, go further                                        ; Jump to next

            changeknob8:                                                                                                                    ; Name

                mov controlnum, #19                                                                                                         ; Change controlnum                                        

                jnb p2_data.1, knob8off              ; If current input is low, go to note off                                              ; Change which pin of p2

                knob8on:                                                                                                                    ; Name

                    mov DDSnote2, controlnum                                                                                                ; Change DDS

                    anl p1_data, #00011111b          ; Set DDS to DDS 0
                    orl p1_data, #00100000b          ; Select DDS zero                                                                      ; Select DDS

                    lcall SendSPIfreq3               ; Send

                    setb n8                          ; Set bit in register                                                                  ; Change bit

                    ljmp note9                                                                                                              ; Jump to next note

                knob8off:

                    clr n8                          ; Clear bit in register                                                                 ; Change bit

                    mov a, controlnum               ; Check if this note is on the DDS

                    cjne a, DDSnote2, note9         ; If not on DDS, go further                                                             ; Change DDS register

                    anl p1_data, #00011111b         ; If note is on DDS, select the DDS module and note off command 
                    orl p1_data, #00100000b         ; Select DDS to send to                                                                 ; Change DDS

                    lcall SendSPIoff                  ; Send



        note9:                                                                                                                              ; Name

            mov a,regcomp                           
            anl a, #00000100b                       ; First bit in register compare with
            mov compare, a                                                                                                                  ; Change which bits compared

            mov a, P2_data                          ; First bit of P2_data
            anl a, #00000100b                      

            cjne a, compare, changeknob9            ; If input and register are not equal, change the knob

            ljmp note10                            ; If input and register are the same, go further                                          ; Jump to next

            changeknob9:                                                                                                                    ; Name

                mov controlnum, #20                                                                                                         ; Change controlnum                                        

                jnb p2_data.2, knob9off              ; If current input is low, go to note off                                              ; Change which pin of p2

                knob9on:                                                                                                                    ; Name

                    mov DDSnote2, controlnum                                                                                                ; Change DDS

                    anl p1_data, #00011111b          ; Set DDS to DDS 0
                    orl p1_data, #00100000b          ; Select DDS zero                                                                      ; Select DDS

                    lcall SendSPIfreq3               ; Send

                    setb n9                          ; Set bit in register                                                                  ; Change bit

                    ljmp note10                                                                                                              ; Jump to next note

                knob9off:

                    clr n9                          ; Clear bit in register                                                                 ; Change bit

                    mov a, controlnum               ; Check if this note is on the DDS

                    cjne a, DDSnote2, note9        ; If not on DDS, go further                                                             ; Change DDS register

                    anl p1_data, #00011111b         ; If note is on DDS, select the DDS module and note off command 
                    orl p1_data, #00100000b         ; Select DDS to send to                                                                 ; Change DDS

                    lcall SendSPIoff                  ; Send


        note10:                                                                                                                              ; Name

            mov a,regcomp                           
            anl a, #00001000b                       ; First bit in register compare with
            mov compare, a                                                                                                                  ; Change which bits compared

            mov a, P2_data                          ; First bit of P2_data
            anl a, #00001000b                      

            cjne a, compare, changeknob10            ; If input and register are not equal, change the knob

            ljmp note11                            ; If input and register are the same, go further                                          ; Jump to next

            changeknob10:                                                                                                                    ; Name

                mov controlnum, #21                                                                                                         ; Change controlnum                                        

                jnb p2_data.3, knob10off              ; If current input is low, go to note off                                              ; Change which pin of p2

                knob10on:                                                                                                                    ; Name

                    mov DDSnote2, controlnum                                                                                                ; Change DDS

                    anl p1_data, #00011111b          ; Set DDS to DDS 0
                    orl p1_data, #00100000b          ; Select DDS zero                                                                      ; Select DDS

                    lcall SendSPIfreq3               ; Send

                    setb n10                          ; Set bit in register                                                                  ; Change bit

                    ljmp note11                                                                                                              ; Jump to next note

                knob10off:

                    clr n10                          ; Clear bit in register                                                                 ; Change bit

                    mov a, controlnum               ; Check if this note is on the DDS

                    cjne a, DDSnote2, note11        ; If not on DDS, go further                                                             ; Change DDS register

                    anl p1_data, #00011111b         ; If note is on DDS, select the DDS module and note off command 
                    orl p1_data, #00100000b         ; Select DDS to send to                                                                 ; Change DDS

                    lcall SendSPIoff                  ; Send                                                                                                       ; Jump to next note

        
        note11:                                                                                                                              ; Name

            mov a,regcomp                           
            anl a, #00010000b                       ; First bit in register compare with
            mov compare, a                                                                                                                  ; Change which bits compared

            mov a, P2_data                          ; First bit of P2_data
            anl a, #00010000b                      

            cjne a, compare, changeknob11            ; If input and register are not equal, change the knob

            ljmp note12                            ; If input and register are the same, go further                                          ; Jump to next

            changeknob11:                                                                                                                    ; Name

                mov controlnum, #22                                                                                                         ; Change controlnum                                        

                jnb p2_data.4, knob11off              ; If current input is low, go to note off                                              ; Change which pin of p2

                knob11on:                                                                                                                    ; Name

                    mov DDSnote2, controlnum                                                                                                ; Change DDS

                    anl p1_data, #00011111b          ; Set DDS to DDS 0
                    orl p1_data, #00100000b          ; Select DDS zero                                                                      ; Select DDS

                    lcall SendSPIfreq3               ; Send

                    setb n11                          ; Set bit in register                                                                  ; Change bit

                    ljmp note12                                                                                                              ; Jump to next note

                knob11off:

                    clr n11                          ; Clear bit in register                                                                 ; Change bit

                    mov a, controlnum               ; Check if this note is on the DDS

                    cjne a, DDSnote2, note12        ; If not on DDS, go further                                                             ; Change DDS register

                    anl p1_data, #00011111b         ; If note is on DDS, select the DDS module and note off command 
                    orl p1_data, #00100000b         ; Select DDS to send to                                                                 ; Change DDS

                    lcall SendSPIoff                  ; Send

        note12:                                                                                                                              ; Name

            mov a,regcomp                           
            anl a, #00100000b                       ; First bit in register compare with
            mov compare, a                                                                                                                  ; Change which bits compared

            mov a, P2_data                          ; First bit of P2_data
            anl a, #00100000b                      

            cjne a, compare, changeknob12            ; If input and register are not equal, change the knob

            ljmp scan1b                            ; If input and register are the same, go further                                         ; Jump to next

            changeknob12:                                                                                                                    ; Name

                mov controlnum, #23                                                                                                         ; Change controlnum                                        

                jnb p2_data.5, knob12off              ; If current input is low, go to note off                                              ; Change which pin of p2

                knob12on:                                                                                                                    ; Name

                    mov DDSnote2, controlnum                                                                                                ; Change DDS

                    anl p1_data, #00011111b          ; Set DDS to DDS 0
                    orl p1_data, #00100000b          ; Select DDS zero                                                                      ; Select DDS

                    lcall SendSPIfreq3               ; Send

                    setb n12                          ; Set bit in register                                                                  ; Change bit

                    ljmp scan1b                                                                                                             ; Jump to next note

                knob12off:

                    clr n12                          ; Clear bit in register                                                                 ; Change bit

                    mov a, controlnum               ; Check if this note is on the DDS

                    cjne a, DDSnote2, scan1b        ; If not on DDS, go further                                                             ; Change DDS register

                    anl p1_data, #00011111b         ; If note is on DDS, select the DDS module and note off command 
                    orl p1_data, #00100000b         ; Select DDS to send to                                                                 ; Change DDS

                    lcall SendSPIoff                  ; Send


    scan1b:


        

ljmp main

                                        



#include	"d:\Practise Enterprise\Code\XC888\definitief\Iron Solo Synthesizer.inc"