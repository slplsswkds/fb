;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.2.0 #13081 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _write_to_eeprom
	.globl _smart_decrement
	.globl _smart_increment
	.globl _write_color_to_registers
	.globl _tim2_init
	.globl _gpio_init
	.globl _clk_init
	.globl _button_hundler
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
;--------------------------------------------------------
; Stack segment in internal ram
;--------------------------------------------------------
	.area	SSEG
__start__stack:
	.ds	1

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
; interrupt vector
;--------------------------------------------------------
	.area HOME
__interrupt_vect:
	int s_GSINIT ; reset
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
__sdcc_init_data:
; stm8_genXINIT() start
	ldw x, #l_DATA
	jreq	00002$
00001$:
	clr (s_DATA - 1, x)
	decw x
	jrne	00001$
00002$:
	ldw	x, #l_INITIALIZER
	jreq	00004$
00003$:
	ld	a, (s_INITIALIZER - 1, x)
	ld	(s_INITIALIZED - 1, x), a
	decw	x
	jrne	00003$
00004$:
; stm8_genXINIT() end
	.area GSFINAL
	jp	__sdcc_program_startup
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
__sdcc_program_startup:
	jp	_main
;	return from main will return to caller
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	main.c: 16: static void delay(uint16_t t) {
;	-----------------------------------------
;	 function delay
;	-----------------------------------------
_delay:
;	main.c: 17: while(t--) {};
00101$:
	ldw	y, x
	decw	x
	tnzw	y
	jrne	00101$
;	main.c: 18: }
	ret
;	main.c: 20: void write_to_eeprom(void) {
;	-----------------------------------------
;	 function write_to_eeprom
;	-----------------------------------------
_write_to_eeprom:
;	main.c: 21: if (!(FLASH_IAPSR & 0x02))
	btjt	0x505f, #1, 00103$
;	main.c: 24: FLASH_DUKR = 0xAE;
	mov	0x5064+0, #0xae
;	main.c: 25: FLASH_DUKR = 0x56;
	mov	0x5064+0, #0x56
;	main.c: 28: while (!(FLASH_IAPSR & DUL));
00103$:
	btjf	0x505f, #3, 00103$
;	main.c: 30: EEPROM_FIRST_ADDR = 0xff;
	mov	0x4000+0, #0xff
;	main.c: 32: FLASH_IAPSR &= ~(DUL);      // lock EEPROM
	bres	0x505f, #3
;	main.c: 33: }
	ret
;	main.c: 35: int main() {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	sub	sp, #3
;	main.c: 36: do { __asm sim __endasm; } while(0); // Disable interrupts
	sim	
;	main.c: 38: clk_init();
	call	_clk_init
;	main.c: 39: gpio_init();
	call	_gpio_init
;	main.c: 40: tim2_init();
	call	_tim2_init
;	main.c: 42: do { __asm rim __endasm; } while(0); // Enable interrupts
	rim	
;	main.c: 44: write_to_eeprom();
	call	_write_to_eeprom
;	main.c: 47: rgb.r = 0;
	clr	(0x01, sp)
;	main.c: 48: rgb.g = 0;
	clr	(0x02, sp)
;	main.c: 49: rgb.b = 0;
	clr	(0x03, sp)
00108$:
;	main.c: 52: button_hundler(&rgb);
	ldw	x, sp
	incw	x
	call	_button_hundler
;	main.c: 53: write_color_to_registers(&rgb);
	ldw	x, sp
	incw	x
	call	_write_color_to_registers
	jra	00108$
;	main.c: 55: }
	addw	sp, #3
	ret
;	main.c: 57: void button_hundler(struct Color *color) {
;	-----------------------------------------
;	 function button_hundler
;	-----------------------------------------
_button_hundler:
	sub	sp, #4
	ldw	(0x03, sp), x
;	main.c: 58: if((1 << 2) == (~PD_IDR & (1 << 2))) { // But_R+
	ld	a, 0x5010
	clrw	x
	ld	xl, a
	cplw	x
	ld	a, xl
	and	a, #0x04
	ld	xl, a
	clr	a
	ld	xh, a
	cpw	x, #0x0004
	jrne	00102$
;	main.c: 59: smart_increment(&color->r);
	ldw	x, (0x03, sp)
	call	_smart_increment
00102$:
;	main.c: 62: if((1 << 7) == (~PC_IDR & (1 << 7))) { // But_R-
	ld	a, 0x500b
	clrw	x
	ld	xl, a
	cplw	x
	ld	a, xl
	and	a, #0x80
	ld	xl, a
	clr	a
	ld	xh, a
	cpw	x, #0x0080
	jrne	00104$
;	main.c: 63: smart_decrement(&color->r);
	ldw	x, (0x03, sp)
	call	_smart_decrement
00104$:
;	main.c: 66: if((1 << 6) == (~PC_IDR & (1 << 6))) { // But_G+
	ld	a, 0x500b
	clrw	x
	ld	xl, a
	cplw	x
	ld	a, xl
	and	a, #0x40
	ld	xl, a
	clr	a
;	main.c: 67: smart_increment(&color->g);
	ldw	y, (0x03, sp)
	incw	y
	ldw	(0x01, sp), y
;	main.c: 66: if((1 << 6) == (~PC_IDR & (1 << 6))) { // But_G+
	ld	xh, a
	cpw	x, #0x0040
	jrne	00106$
;	main.c: 67: smart_increment(&color->g);
	ldw	x, (0x01, sp)
	call	_smart_increment
00106$:
;	main.c: 70: if((1 << 5) == (~PC_IDR & (1 << 5))) { // But_G-
	ld	a, 0x500b
	clrw	x
	ld	xl, a
	cplw	x
	ld	a, xl
	and	a, #0x20
	ld	xl, a
	clr	a
	ld	xh, a
	cpw	x, #0x0020
	jrne	00108$
;	main.c: 71: smart_decrement(&color->g);
	ldw	x, (0x01, sp)
	call	_smart_decrement
00108$:
;	main.c: 74: if((1 << 4) == (~PC_IDR & (1 << 4))) { // But_B+
	ld	a, 0x500b
	clrw	x
	ld	xl, a
	cplw	x
	clrw	y
	ld	a, xl
	and	a, #0x10
	ld	yl, a
;	main.c: 75: smart_increment(&color->b);
	ldw	x, (0x03, sp)
	incw	x
	incw	x
	ldw	(0x01, sp), x
;	main.c: 74: if((1 << 4) == (~PC_IDR & (1 << 4))) { // But_B+
	cpw	y, #0x0010
	jrne	00110$
;	main.c: 75: smart_increment(&color->b);
	ldw	x, (0x01, sp)
	call	_smart_increment
00110$:
;	main.c: 78: if((1 << 3) == (~PC_IDR & (1 << 3))) { // But_B-
	ld	a, 0x500b
	clrw	x
	ld	xl, a
	cplw	x
	ld	a, xl
	and	a, #0x08
	ld	xl, a
	clr	a
	ld	xh, a
	cpw	x, #0x0008
	jrne	00113$
;	main.c: 79: smart_decrement(&color->b);
	ldw	x, (0x01, sp)
	addw	sp, #4
	jp	_smart_decrement
00113$:
;	main.c: 81: }
	addw	sp, #4
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
