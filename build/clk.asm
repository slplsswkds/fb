;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.2.0 #13081 (Linux)
;--------------------------------------------------------
	.module clk
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _clk_init
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
;	./src/clk.c: 3: void clk_init() {
;	-----------------------------------------
;	 function clk_init
;	-----------------------------------------
_clk_init:
;	./src/clk.c: 5: while(~CLK_ICKR & HSIRDY) {} ;
00101$:
	ld	a, 0x50c0
	clrw	x
	ld	xl, a
	cplw	x
	ld	a, xl
	bcp	a, #0x02
	jrne	00101$
;	./src/clk.c: 6: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
