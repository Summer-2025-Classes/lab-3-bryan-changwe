#include <xc.inc>
	goto start	
	
	; Lab 3 Prelab
	psect code
N   equ	0x00	; Number of X's
Z   equ 0x60	; Final answer is stored here
X   equ 0x50	; Starting point of Xi array

start:	; load location 0x50 to 0x57 with arbitrary numbers for testing
	; you should also use "Memory Fill" to test it with zeros, ones, or even random numbers
	lfsr	0, X
	movlw	1
	movwf	POSTINC0, a
	movlw	2
	movwf	POSTINC0, a
	movlw	3
	movwf	POSTINC0, a
	movlw	4
	movwf	POSTINC0, a
	movlw	5
	movwf	POSTINC0, a
	movlw	6
	movwf	POSTINC0, a
	movlw	7
	movwf	POSTINC0, a
	movlw	8
	movwf	POSTINC0, a
	
    	; TODO: Your main program code starts here
	; 	- Use FSR1 to point to Xi
	;	- Call sum8 to generate the sum
	;	- Divide the resulting sum by 8 using rotate right with carry (you should reset the carry after each rotation)
	movlw   0x30
	movwf   FSR1L, a      ; Set FSR1 to 0x30
	clrf    FSR1H, a      ; Clear high byte for 8-bit address (optional)
	movlw   0x05
	movwf   STKPTR, a     ; Set STKPTR to 5
	
	lfsr    1, X          ; FSR1 points to Xi array (0x50)
	call    sum8
	
	;Divide Z by 8
	clrf WREG	
	rrcf Z, F, a
	clrf WREG
	rrcf Z, F, a
	clrf WREG
	rrcf Z, F, a
	
stop:	
    bra	stop

sum8:	; TODO: Your subroutine program codes goes here
    clrf    Z, a
    movlw   8
    movwf   N, a
sum_loop:
    movf   POSTINC1, W, a
    addwf   Z, F, a
    decfsz  N, F, a
    bra sum_loop
    return
END



