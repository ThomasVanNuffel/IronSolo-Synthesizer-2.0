;   Begin of the program
     org 0000h                                  ; Start address in memory
     mov sp,#7fh                                ; Initialize stack pointer (needs to be outside any function)     


;   Initialization components
inits:
        lcall initports                         ; Set ports to input/output + alt functions
        lcall aliases                           ; Set up all variables
        anl P1_data, #00011111b                 ; Slave selects are removed

;   Initialization values
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

    select0:
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

            ljmp note2                             ; If input and register are the same, go further

            changeknob1:

                jnb p2_data.0, knob1off              ; If current input is low, go to note off

                knob1on:

                    mov DDSnote1, #1

                   setb n1

                    mov r1, #20h
                    mov r2, #00h                    ; No reset

                    lcall SendSPI                   ; Send

                    mov r1, #01001011b
                    mov r2, #00010100b              ; Frequency of note
                    mov r3, #01000000b
                    mov r4, #00000000b

                    lcall SendSPIfreq               ; Send

                    ljmp note2

                knob1off:

                    clr n1

                    mov a, #1
                    cjne a, DDSnote1, note2

                    mov r1, #01h                    ; Reset
                    mov r2, #00h

                    lcall SendSPI                   ; Send


        note2:

            mov a,regcomp                           
            anl a, #00000010b                       ; Second bit in register compare with
            mov compare, a                          

            mov a, P2_data                          ; Second bit of P2_data
            anl a, #00000010b                      

            cjne a, compare, changeknob2            ; If input and register are not equal, change the knob

            ljmp main                             ; If input and register are the same, go further

            changeknob2:

                jnb p2_data.1, knob2off              ; If current input is low, go to note off

                knob2on:

                   setb n2

                   mov DDSnote1, #2

                   mov controlnum, #0

                    mov r1, #20h
                    mov r2, #00h                    ; No reset

                    lcall SendSPI                   ; Send

                    lcall SendSPIfreq2               ; Send

                    ljmp main

                knob2off:

                    clr n2

                    mov a, #2
                    cjne a, DDSnote1, main

                    mov r1, #01h                    ; Reset
                    mov r2, #00h

                    lcall SendSPI                   ; Send

ljmp main

SendSPIfreq2:

        mov dptr, #freqtableke    ; Set datapointer to table


        mov a, controlnum       ; Mov number into accumulator for offset

        rl a                    ; offset x2 (16 bit pro frequency)

        mov controlnum, a       ; Store offset in controlnum


        movc a, @a+dptr         ; Get first byte                                    ;                                                 
        mov r1, a               ; Mov to MSByte of 16 bit number                    ;
        mov a, controlnum       ; offset was changed so back the original           ;   Get frequency
        inc dptr                ; +1                                                ;
        movc a, @a+dptr         ; Get second byte                                   ;
        mov r0, a               ; Mov to LSByte                                     ;


        mov r7, #10h                        ;
        mov r6, #00h                        ; 2^28 for multiplication
        mov r5, #00h                        ;
        mov r4, #00h                        ;

        lcall mul32                         ; Do the multiplication


        mov get1hhhh, r7                    ;
        mov get1hhh, r6                     ;
        mov get1hh, r5                      ;
        mov get1h, r4                       ; Change the output of multiplication into input of division
        mov get1l, r3                       ;
        mov get1ll, r2                      ;
        mov get1lll, r1                     ;
        mov get1llll, r0                    ;


        mov get2hhhh, #00h                  ;
        mov get2hhh, #00h                   ;
        mov get2hh, #00h                    ;
        mov get2h, #00h                     ; Devide by 250 000 000     (25 MHz * 10)
        mov get2l, #0eh                     ;
        mov get2ll, #e6h                    ;
        mov get2lll, #b2h                   ;
        mov get2llll, #80h                  ;

        lcall div64                         ; Do the division




        mov r1, qllll                       ; register 1 is already good, LSB Low



        mov a, qlll                         ; register 2 needs to change for the mode bits
        anl a, #00111111b                   ; #00xxxxxxb
        orl a, #01000000b                   ; #01xxxxxxb
        mov r2, a                           ; MSB Low is set


        mov a, qlll                         ; Set the bits that needs to be added to register 3
        anl a, #11000000b                   ; #xx000000b
        rl a                                ; #x000000xb
        rl a                                ; #000000xxb
        mov Hulp, a                         ; Into hulp


        mov a, qll                          ; Register 3 needs to be shifted and two bits of register 2 needs to be added.
        anl a, #00111111b                   ; #00xxxxxxb
        rl a                                ; #0xxxxxx0b
        rl a                                ; #xxxxxx00b
        add a, Hulp                         ; #xxxxxxxxb
        mov r3, a                           ; LSB High is set


        mov a, qll                          ; Set the bits that needs to be added to register 4
        anl a, #11000000b                   ; #xx000000b
        rl a                                ; #x000000xb
        rl a                                ; #000000xxb
        mov Hulp, a                         ; Into hulp

        mov a, ql                           ; Register 4 needs to be shifted and two bits of register 3 needs to be added.
        rl a                                ; #xxh
        rl a                                ; #xxb  Shift to set the bits #00432100b with 4 3 2 1 the four LSBs

        anl a, #00111100b                   ; #00xxxx00b
        orl a, #01000000b                   ; #01xxxx00b    Just add 01 at the beginning because these bits are always 0
        add a, Hulp                         ; #01xxxxxxb    Add the two bits of register 3
        mov r4, a                           ; MSB High is set


    setb p1_data.4   		                ; fsync is high, data can be transmitted (enable decoder)

	mov	r7,#8				                ; Loopcounter

    mov a, r1

    outbyte1a:
        rlc	a				                ; Mov bit pro bit into carry

		mov p1_data.3, c				    ; Send carry bit to data pin
        

		clr p1_data.2			            ; Clock low (clocked in)
        

		setb p1_data.2				        ; Clock high

	djnz r7, outbyte1a		                ; Loop for eight bits



    mov	r7,#8				                ; Loopcounter

    mov a, r2

    outbyte2a:
        rlc	a				                ; Mov bit pro bit into carry

		mov p1_data.3, c				    ; Send carry bit to data pin
        

		clr p1_data.2			            ; Clock low
        

		setb p1_data.2				        ; Clock high

	djnz r7, outbyte2a		                ; Loop for eight bits



    mov	r7,#8				                ; Loopcounter

    mov a, r3

    outbyte3a:
        rlc	a				                ; Mov bit pro bit into carry

		mov p1_data.3, c				    ; Send carry bit to data pin
        

		clr p1_data.2			            ; Clock low (clocked in)
        

		setb p1_data.2				        ; Clock high

	djnz r7, outbyte3a		                ; Loop for eight bits



    mov	r7,#8				                ; Loopcounter

    mov a, r4

    outbyte4a:
        rlc	a				                ; Mov bit pro bit into carry

		mov p1_data.3, c				    ; Send carry bit to data pin
        

		clr p1_data.2			            ; Clock low
        

		setb p1_data.2				        ; Clock high

	djnz r7, outbyte4a		                ; Loop for eight bits

    clr p1_data.4                          ; Fsync is low, data is sent (disable encoder)

    clr p1_data.3

    ret

freqtableke:

    db 00010001b
    db 00111111b
                                        



#include	"d:\Practise Enterprise\Code\XC888\definitief\Iron Solo Synthesizer.inc"