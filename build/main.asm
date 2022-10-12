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
	.globl _uart_tx_byte_array
	.globl _uart_tx_byte
	.globl _uart_init
	.globl _smart_decrement
	.globl _smart_increment
	.globl _write_color_to_registers
	.globl _tim2_init
	.globl _btn_load_is_pressed
	.globl _btn_flash_is_pressed
	.globl _btn_b_minus_is_pressed
	.globl _btn_g_minus_is_pressed
	.globl _btn_r_minus_is_pressed
	.globl _btn_b_plus_is_pressed
	.globl _btn_g_plus_is_pressed
	.globl _btn_r_plus_is_pressed
	.globl _gpio_init
	.globl _clk_init
	.globl _rgb
	.globl _button_hundler
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
_rgb::
	.ds 3
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
	int 0x000000 ; trap
	int 0x000000 ; int0
	int 0x000000 ; int1
	int 0x000000 ; int2
	int 0x000000 ; int3
	int 0x000000 ; int4
	int 0x000000 ; int5
	int 0x000000 ; int6
	int 0x000000 ; int7
	int 0x000000 ; int8
	int 0x000000 ; int9
	int 0x000000 ; int10
	int 0x000000 ; int11
	int 0x000000 ; int12
	int 0x000000 ; int13
	int 0x000000 ; int14
	int 0x000000 ; int15
	int 0x000000 ; int16
	int 0x000000 ; int17
	int _uart1_rx_handler ; int18
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
;	main.c: 25: int main() {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	sub	sp, #5
;	main.c: 26: __asm sim __endasm; // Disable interrupts
	sim	
;	main.c: 28: clk_init();
	call	_clk_init
;	main.c: 29: gpio_init();
	call	_gpio_init
;	main.c: 30: tim2_init();
	call	_tim2_init
;	main.c: 31: uart_init();
	call	_uart_init
;	main.c: 33: char banner[5] = {'1', '2', '3', '4', '5'};
	ldw	x, sp
	incw	x
	ld	a, #0x31
	ld	(x), a
	ld	a, #0x32
	ld	(0x02, sp), a
	ld	a, #0x33
	ld	(0x03, sp), a
	ld	a, #0x34
	ld	(0x04, sp), a
	ld	a, #0x35
	ld	(0x05, sp), a
;	main.c: 34: uart_tx_byte_array(banner, 5);
	ld	a, #0x05
	call	_uart_tx_byte_array
;	main.c: 36: __asm rim __endasm; // Enable interrupts
	rim	
;	main.c: 40: rgb.r = 0;
	mov	_rgb+0, #0x00
;	main.c: 41: rgb.g = 0;
	mov	_rgb+1, #0x00
;	main.c: 42: rgb.b = 0;
	mov	_rgb+2, #0x00
;	main.c: 44: while(1) {
00102$:
;	main.c: 45: button_hundler(&rgb);
	ldw	x, #(_rgb+0)
	call	_button_hundler
;	main.c: 46: write_color_to_registers(&rgb);
	ldw	x, #(_rgb+0)
	call	_write_color_to_registers
	jra	00102$
;	main.c: 48: }
	addw	sp, #5
	ret
;	main.c: 50: void button_hundler(struct Color *color) {
;	-----------------------------------------
;	 function button_hundler
;	-----------------------------------------
_button_hundler:
	sub	sp, #2
	ldw	(0x01, sp), x
;	main.c: 51: if(btn_r_plus_is_pressed()) {
	call	_btn_r_plus_is_pressed
	tnz	a
	jreq	00102$
;	main.c: 52: smart_increment(&color->r);
	ldw	x, (0x01, sp)
	call	_smart_increment
00102$:
;	main.c: 55: if(btn_r_minus_is_pressed()) {
	call	_btn_r_minus_is_pressed
	tnz	a
	jreq	00104$
;	main.c: 56: smart_decrement(&color->r);
	ldw	x, (0x01, sp)
	call	_smart_decrement
00104$:
;	main.c: 59: if(btn_g_plus_is_pressed()) {
	call	_btn_g_plus_is_pressed
;	main.c: 60: smart_increment(&color->g);
	ldw	x, (0x01, sp)
	incw	x
;	main.c: 59: if(btn_g_plus_is_pressed()) {
	tnz	a
	jreq	00106$
;	main.c: 60: smart_increment(&color->g);
	pushw	x
	call	_smart_increment
	popw	x
00106$:
;	main.c: 63: if(btn_g_minus_is_pressed()) {
	pushw	x
	call	_btn_g_minus_is_pressed
	popw	x
	tnz	a
	jreq	00108$
;	main.c: 64: smart_decrement(&color->g);
	call	_smart_decrement
00108$:
;	main.c: 67: if(btn_b_plus_is_pressed()) {
	call	_btn_b_plus_is_pressed
;	main.c: 68: smart_increment(&color->b);
	ldw	x, (0x01, sp)
	incw	x
	incw	x
;	main.c: 67: if(btn_b_plus_is_pressed()) {
	tnz	a
	jreq	00110$
;	main.c: 68: smart_increment(&color->b);
	pushw	x
	call	_smart_increment
	popw	x
00110$:
;	main.c: 71: if(btn_b_minus_is_pressed()) {
	pushw	x
	call	_btn_b_minus_is_pressed
	popw	x
	tnz	a
	jreq	00112$
;	main.c: 72: smart_decrement(&color->b);
	call	_smart_decrement
00112$:
;	main.c: 75: if(btn_flash_is_pressed()) {
	call	_btn_flash_is_pressed
;	main.c: 78: if(btn_load_is_pressed()) {
	addw	sp, #2
;	main.c: 80: }
	jp	_btn_load_is_pressed
;	main.c: 82: extern void uart1_rx_handler(void) __interrupt(18) {
;	-----------------------------------------
;	 function uart1_rx_handler
;	-----------------------------------------
_uart1_rx_handler:
	clr	a
	div	x, a
	push	a
;	main.c: 83: rgb.r = 0;
	mov	_rgb+0, #0x00
;	main.c: 84: rgb.g = 0;
	mov	_rgb+1, #0x00
;	main.c: 85: rgb.b = 0;
	mov	_rgb+2, #0x00
;	main.c: 86: write_color_to_registers(&rgb);
	ldw	x, #(_rgb+0)
	call	_write_color_to_registers
;	main.c: 88: UART1_SR &= ~(1 << 5); // Clear interrupt
	bres	0x5230, #5
;	main.c: 89: char byte = UART1_DR;
	ld	a, 0x5231
	ld	(0x01, sp), a
;	main.c: 90: uart_tx_byte(&byte);
	ldw	x, sp
	incw	x
	call	_uart_tx_byte
;	main.c: 91: }
	pop	a
	iret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
