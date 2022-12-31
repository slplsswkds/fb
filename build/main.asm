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
	.globl _write_color_to_eeprom
	.globl _load_color_from_eeprom
	.globl _smart_decrement
	.globl _smart_increment
	.globl _write_color_to_registers
	.globl _tim2_init
	.globl _btn_brightness_minus_is_pressed
	.globl _btn_brightness_plus_is_pressed
	.globl _btn_load_is_pressed
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
;	main.c: 26: __asm sim __endasm; // Disable interrupts
	sim	
;	main.c: 28: clk_init();
	call	_clk_init
;	main.c: 29: gpio_init();
	call	_gpio_init
;	main.c: 30: tim2_init();
	call	_tim2_init
;	main.c: 36: __asm rim __endasm; // Enable interrupts
	rim	
;	main.c: 40: rgb.r = 0;
	mov	_rgb+0, #0x00
;	main.c: 41: rgb.g = 0;
	mov	_rgb+1, #0x00
;	main.c: 42: rgb.b = 0;
	mov	_rgb+2, #0x00
;	main.c: 48: load_color_from_eeprom(&rgb, 0);
	clr	a
	ldw	x, #(_rgb+0)
	call	_load_color_from_eeprom
;	main.c: 50: while(1) {
00102$:
;	main.c: 51: button_hundler(&rgb);
	ldw	x, #(_rgb+0)
	call	_button_hundler
;	main.c: 52: write_color_to_registers(&rgb);
	ldw	x, #(_rgb+0)
	call	_write_color_to_registers
	jra	00102$
;	main.c: 54: }
	ret
;	main.c: 56: void button_hundler(struct Color *color) {
;	-----------------------------------------
;	 function button_hundler
;	-----------------------------------------
_button_hundler:
	sub	sp, #9
	ldw	(0x08, sp), x
;	main.c: 57: if(btn_r_plus_is_pressed()) {
	call	_btn_r_plus_is_pressed
	tnz	a
	jreq	00102$
;	main.c: 58: smart_increment(&color->r);
	ldw	x, (0x08, sp)
	call	_smart_increment
00102$:
;	main.c: 61: if(btn_r_minus_is_pressed()) {
	call	_btn_r_minus_is_pressed
	tnz	a
	jreq	00104$
;	main.c: 62: smart_decrement(&color->r);
	ldw	x, (0x08, sp)
	call	_smart_decrement
00104$:
;	main.c: 65: if(btn_g_plus_is_pressed()) {
	call	_btn_g_plus_is_pressed
;	main.c: 66: smart_increment(&color->g);
	ldw	x, (0x08, sp)
	incw	x
	ldw	(0x01, sp), x
;	main.c: 65: if(btn_g_plus_is_pressed()) {
	tnz	a
	jreq	00106$
;	main.c: 66: smart_increment(&color->g);
	ldw	x, (0x01, sp)
	call	_smart_increment
00106$:
;	main.c: 69: if(btn_g_minus_is_pressed()) {
	call	_btn_g_minus_is_pressed
	tnz	a
	jreq	00108$
;	main.c: 70: smart_decrement(&color->g);
	ldw	x, (0x01, sp)
	call	_smart_decrement
00108$:
;	main.c: 73: if(btn_b_plus_is_pressed()) {
	call	_btn_b_plus_is_pressed
;	main.c: 74: smart_increment(&color->b);
	ldw	x, (0x08, sp)
	incw	x
	incw	x
	ldw	(0x06, sp), x
;	main.c: 73: if(btn_b_plus_is_pressed()) {
	tnz	a
	jreq	00110$
;	main.c: 74: smart_increment(&color->b);
	ldw	x, (0x06, sp)
	call	_smart_increment
00110$:
;	main.c: 77: if(btn_b_minus_is_pressed()) {
	call	_btn_b_minus_is_pressed
	tnz	a
	jreq	00112$
;	main.c: 78: smart_decrement(&color->b);
	ldw	x, (0x06, sp)
	call	_smart_decrement
00112$:
;	main.c: 81: if(btn_brightness_plus_is_pressed()) {
	call	_btn_brightness_plus_is_pressed
	tnz	a
	jreq	00114$
;	main.c: 82: smart_increment(&color->r);
	ldw	x, (0x08, sp)
	call	_smart_increment
;	main.c: 83: smart_increment(&color->g);
	ldw	x, (0x01, sp)
	call	_smart_increment
;	main.c: 84: smart_increment(&color->b);
	ldw	x, (0x06, sp)
	call	_smart_increment
00114$:
;	main.c: 87: if(btn_brightness_minus_is_pressed()) {
	call	_btn_brightness_minus_is_pressed
	tnz	a
	jreq	00116$
;	main.c: 88: smart_decrement(&color->r);
	ldw	x, (0x08, sp)
	call	_smart_decrement
;	main.c: 89: smart_decrement(&color->g);
	ldw	x, (0x01, sp)
	call	_smart_decrement
;	main.c: 90: smart_decrement(&color->b);
	ldw	x, (0x06, sp)
	call	_smart_decrement
00116$:
;	main.c: 100: if(btn_load_is_pressed()) {
	call	_btn_load_is_pressed
	ld	(0x07, sp), a
	jrne	00241$
	jp	00136$
00241$:
;	main.c: 101: uint8_t counter = 0;
	clr	(0x06, sp)
;	main.c: 102: while(counter < 10 && btn_load_is_pressed()) {
00118$:
	ld	a, (0x06, sp)
	cp	a, #0x0a
	jrnc	00120$
	call	_btn_load_is_pressed
	tnz	a
	jreq	00120$
;	main.c: 103: delay(65535);
	clrw	x
	decw	x
	call	_delay
;	main.c: 104: counter += 1;
	inc	(0x06, sp)
	jra	00118$
00120$:
;	main.c: 108: load_color_from_eeprom(&rgb_buf, 0);        
	clr	a
	ldw	x, sp
	addw	x, #3
	call	_load_color_from_eeprom
;	main.c: 109: write_color_to_registers(&rgb_buf);
	ldw	x, sp
	addw	x, #3
	call	_write_color_to_registers
;	main.c: 110: delay(65535);
	clrw	x
	decw	x
	call	_delay
;	main.c: 111: delay(65535);
	clrw	x
	decw	x
	call	_delay
;	main.c: 112: delay(65535);
	clrw	x
	decw	x
	call	_delay
;	main.c: 115: while(counter < 23 && btn_load_is_pressed()) {
00125$:
	ld	a, (0x06, sp)
	cp	a, #0x17
	clr	a
	rlc	a
	ld	(0x07, sp), a
	jreq	00127$
	call	_btn_load_is_pressed
	tnz	a
	jreq	00127$
;	main.c: 116: delay(65535);
	clrw	x
	decw	x
	call	_delay
;	main.c: 117: delay(65535);
	clrw	x
	decw	x
	call	_delay
;	main.c: 118: if (counter % 2 == 0) {
	ld	a, (0x06, sp)
	srl	a
	jrc	00122$
;	main.c: 119: write_color_to_registers(&rgb_buf);
	ldw	x, sp
	addw	x, #3
	call	_write_color_to_registers
	jra	00123$
00122$:
;	main.c: 122: write_color_to_registers(&rgb);
	ldw	x, #(_rgb+0)
	call	_write_color_to_registers
00123$:
;	main.c: 124: counter += 1;
	inc	(0x06, sp)
	jra	00125$
00127$:
;	main.c: 127: if(counter >= 10 && counter < 23) {
	ld	a, (0x06, sp)
	cp	a, #0x0a
	jrc	00131$
	tnz	(0x07, sp)
	jreq	00131$
;	main.c: 128: rgb = rgb_buf;
	push	#0x03
	push	#0x00
	ldw	x, sp
	addw	x, #5
	pushw	x
	ldw	x, #(_rgb+0)
	call	___memcpy
	jra	00136$
00131$:
;	main.c: 130: else if (counter == 23) { 
	ld	a, (0x06, sp)
	cp	a, #0x17
	jrne	00136$
;	main.c: 131: write_color_to_eeprom(&rgb, 0);        
	clr	a
	ldw	x, #(_rgb+0)
	call	_write_color_to_eeprom
00136$:
;	main.c: 134: }
	addw	sp, #9
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
