;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.2.0 #13081 (Linux)
;--------------------------------------------------------
	.module tim2
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _tim2_init
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area DABS (ABS)

; default segment ordering for linker
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area CONST
	.area INITIALIZER
	.area CODE

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	./src/tim2.c: 3: void tim2_init() {
;	-----------------------------------------
;	 function tim2_init
;	-----------------------------------------
_tim2_init:
;	./src/tim2.c: 8: TIM2_PSCR = 0x00; // Prescaler = 1
	mov	0x530e+0, #0x00
;	./src/tim2.c: 9: TIM2_ARRH = tim2_arrval >> 8;
	mov	0x530f+0, #0x3e
;	./src/tim2.c: 10: TIM2_ARRL = tim2_arrval & 0x00FF;
	ld	a, #0x80
	ld	0x5310, a
;	./src/tim2.c: 13: TIM2_CCR1H = 0x00;
	mov	0x5311+0, #0x00
;	./src/tim2.c: 14: TIM2_CCR1L = 0x00;
	mov	0x5312+0, #0x00
;	./src/tim2.c: 15: TIM2_CCER1 &= ~CC1P; // Active high
	ld	a, 0x530a
	and	a, #0xfd
;	./src/tim2.c: 16: TIM2_CCER1 |= CC1E; // Enable CH1 output
	ld	0x530a, a
	or	a, #0x01
	ld	0x530a, a
;	./src/tim2.c: 17: TIM2_CCMR1 |= (0b110 << 4); //PWM mode 1
	ld	a, 0x5307
	or	a, #0x60
	ld	0x5307, a
;	./src/tim2.c: 20: TIM2_CCR2H = 0x00;
	mov	0x5313+0, #0x00
;	./src/tim2.c: 21: TIM2_CCR2L = 0x00;
	mov	0x5314+0, #0x00
;	./src/tim2.c: 22: TIM2_CCER1 &= ~CC2P; // Active high
	ld	a, 0x530a
	and	a, #0xdf
;	./src/tim2.c: 23: TIM2_CCER1 |= CC2E; // Enable CH2 output
	ld	0x530a, a
	or	a, #0x10
	ld	0x530a, a
;	./src/tim2.c: 24: TIM2_CCMR2 |= (0b110 << 4); //PWM mode 1
	ld	a, 0x5308
	or	a, #0x60
	ld	0x5308, a
;	./src/tim2.c: 27: TIM2_CCR3H = 0x00;
	mov	0x5315+0, #0x00
;	./src/tim2.c: 28: TIM2_CCR3L = 0x00;
	mov	0x5316+0, #0x00
;	./src/tim2.c: 29: TIM2_CCER2 &= ~CC3P; // Active high
	ld	a, 0x530b
	and	a, #0xfd
;	./src/tim2.c: 30: TIM2_CCER2 |= CC3E; // Enable CH3 output
	ld	0x530b, a
	or	a, #0x01
	ld	0x530b, a
;	./src/tim2.c: 31: TIM2_CCMR3 |= (0b110 << 4); //PWM mode 1
	ld	a, 0x5309
	or	a, #0x60
	ld	0x5309, a
;	./src/tim2.c: 33: TIM2_CR1 |= CEN; // Enable TIM2
	bset	0x5300, #0
;	./src/tim2.c: 34: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
