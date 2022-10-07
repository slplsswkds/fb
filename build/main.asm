;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.2.0 #13081 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _pwm_steps
	.globl _main
	.globl _smart_decrement
	.globl _smart_increment
	.globl _write_color_to_registers
	.globl _tim2_init
	.globl _gpio_init
	.globl _clk_init
	.globl _rgb
	.globl _tim2_demo
	.globl _button_hundler
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
_rgb::
	.ds 3
_tim2_demo_counter_196608_40:
	.ds 2
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
;	main.c: 55: static uint16_t counter = 0;
	clrw	x
	ldw	_tim2_demo_counter_196608_40+0, x
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
;	main.c: 19: static void delay(uint16_t t) {
;	-----------------------------------------
;	 function delay
;	-----------------------------------------
_delay:
;	main.c: 20: while(t--) {};
00101$:
	ldw	y, x
	decw	x
	tnzw	y
	jrne	00101$
;	main.c: 21: }
	ret
;	main.c: 28: int main() {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	main.c: 29: do { __asm sim __endasm; } while(0); // Disable interrupts
	sim	
;	main.c: 31: clk_init();
	call	_clk_init
;	main.c: 32: gpio_init();
	call	_gpio_init
;	main.c: 33: tim2_init();
	call	_tim2_init
;	main.c: 35: do { __asm rim __endasm; } while(0); // Enable interrupts
	rim	
;	main.c: 37: PB_ODR |= (1 << 5);
	bset	0x5005, #5
;	main.c: 39: rgb.r = 0;
	mov	_rgb+0, #0x00
;	main.c: 40: rgb.g = 0;
	mov	_rgb+1, #0x00
;	main.c: 41: rgb.b = 0;
	mov	_rgb+2, #0x00
00108$:
;	main.c: 44: button_hundler(&rgb);
	ldw	x, #(_rgb+0)
	call	_button_hundler
;	main.c: 45: write_color_to_registers(&rgb);
	ldw	x, #(_rgb+0)
	call	_write_color_to_registers
	jra	00108$
;	main.c: 47: }
	ret
;	main.c: 49: void tim2_demo() {
;	-----------------------------------------
;	 function tim2_demo
;	-----------------------------------------
_tim2_demo:
;	main.c: 50: rgb.r = 0;
	mov	_rgb+0, #0x00
;	main.c: 51: rgb.g = 0;
	mov	_rgb+1, #0x00
;	main.c: 52: rgb.b = 0;
	mov	_rgb+2, #0x00
00105$:
;	main.c: 57: write_color_to_registers(&rgb);
	ldw	x, #(_rgb+0)
	call	_write_color_to_registers
;	main.c: 59: if(counter < 255) {
;	main.c: 60: counter ++;
	ldw	x, _tim2_demo_counter_196608_40+0
	cpw	x, #0x00ff
	jrnc	00102$
	incw	x
	ldw	_tim2_demo_counter_196608_40+0, x
;	main.c: 61: rgb.r += 5;
	ld	a, _rgb+0
	add	a, #0x05
	ld	_rgb+0, a
;	main.c: 62: rgb.g += 5;
	ld	a, _rgb+1
	add	a, #0x05
	ld	_rgb+1, a
;	main.c: 63: rgb.b += 5;
	ld	a, _rgb+2
	add	a, #0x05
	ld	_rgb+2, a
	jra	00103$
00102$:
;	main.c: 66: counter = 0;
	clrw	x
	ldw	_tim2_demo_counter_196608_40+0, x
;	main.c: 67: rgb.r = 0;
	mov	_rgb+0, #0x00
;	main.c: 68: rgb.g = 0;
	mov	_rgb+1, #0x00
;	main.c: 69: rgb.b = 0;
	mov	_rgb+2, #0x00
;	main.c: 71: PB_ODR &= ~(1 << 5);
	bres	0x5005, #5
00103$:
;	main.c: 75: delay(655);
	ldw	x, #0x028f
	call	_delay
	jra	00105$
;	main.c: 77: }
	ret
;	main.c: 79: void button_hundler(struct Color *color) {
;	-----------------------------------------
;	 function button_hundler
;	-----------------------------------------
_button_hundler:
	sub	sp, #4
	ldw	(0x03, sp), x
;	main.c: 80: if((1 << 2) == (~PD_IDR & (1 << 2))) { // But_R+
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
;	main.c: 81: smart_increment(&color->r);
	ldw	x, (0x03, sp)
	call	_smart_increment
00102$:
;	main.c: 84: if((1 << 7) == (~PC_IDR & (1 << 7))) { // But_R-
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
;	main.c: 85: smart_decrement(&color->r);
	ldw	x, (0x03, sp)
	call	_smart_decrement
00104$:
;	main.c: 88: if((1 << 6) == (~PC_IDR & (1 << 6))) { // But_G+
	ld	a, 0x500b
	clrw	x
	ld	xl, a
	cplw	x
	ld	a, xl
	and	a, #0x40
	ld	xl, a
	clr	a
;	main.c: 89: smart_increment(&color->g);
	ldw	y, (0x03, sp)
	incw	y
	ldw	(0x01, sp), y
;	main.c: 88: if((1 << 6) == (~PC_IDR & (1 << 6))) { // But_G+
	ld	xh, a
	cpw	x, #0x0040
	jrne	00106$
;	main.c: 89: smart_increment(&color->g);
	ldw	x, (0x01, sp)
	call	_smart_increment
00106$:
;	main.c: 92: if((1 << 5) == (~PC_IDR & (1 << 5))) { // But_G-
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
;	main.c: 93: smart_decrement(&color->g);
	ldw	x, (0x01, sp)
	call	_smart_decrement
00108$:
;	main.c: 96: if((1 << 4) == (~PC_IDR & (1 << 4))) { // But_B+
	ld	a, 0x500b
	clrw	x
	ld	xl, a
	cplw	x
	clrw	y
	ld	a, xl
	and	a, #0x10
	ld	yl, a
;	main.c: 97: smart_increment(&color->b);
	ldw	x, (0x03, sp)
	incw	x
	incw	x
	ldw	(0x01, sp), x
;	main.c: 96: if((1 << 4) == (~PC_IDR & (1 << 4))) { // But_B+
	cpw	y, #0x0010
	jrne	00110$
;	main.c: 97: smart_increment(&color->b);
	ldw	x, (0x01, sp)
	call	_smart_increment
00110$:
;	main.c: 100: if((1 << 3) == (~PC_IDR & (1 << 3))) { // But_B-
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
;	main.c: 101: smart_decrement(&color->b);
	ldw	x, (0x01, sp)
	addw	sp, #4
	jp	_smart_decrement
00113$:
;	main.c: 103: }
	addw	sp, #4
	ret
	.area CODE
	.area CONST
_pwm_steps:
	.dw #0x0000
	.dw #0x0001
	.dw #0x0002
	.dw #0x0005
	.dw #0x000b
	.dw #0x0018
	.dw #0x0034
	.dw #0x0074
	.dw #0x0100
	.dw #0x0235
	.dw #0x04df
	.dw #0x0ac1
	.dw #0x17bf
	.dw #0x346f
	.dw #0x73c5
	.dw #0xfffe
	.area INITIALIZER
	.area CABS (ABS)
