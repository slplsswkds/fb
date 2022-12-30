;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.2.0 #13081 (Linux)
;--------------------------------------------------------
	.module color
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _eeprom_read
	.globl _eeprom_write
	.globl _sqrtf
	.globl _expf
	.globl _normalize_from
	.globl _write_color_to_registers
	.globl _smart_increment
	.globl _smart_decrement
	.globl _load_color_from_eeprom
	.globl _write_color_to_eeprom
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
;	./src/color.c: 3: uint16_t normalize_from(uint8_t *val) {
;	-----------------------------------------
;	 function normalize_from
;	-----------------------------------------
_normalize_from:
;	./src/color.c: 4: float tmp1 = *val;
	ld	a, (x)
	call	___uchar2fs
;	./src/color.c: 5: float tmp2 = sqrtf(10 * tmp1) / 5;
	pushw	x
	pushw	y
	clrw	x
	pushw	x
	push	#0x20
	push	#0x41
	call	___fsmul
	pushw	x
	pushw	y
	call	_sqrtf
	push	#0x00
	push	#0x00
	push	#0xa0
	push	#0x40
	pushw	x
	pushw	y
	call	___fsdiv
;	./src/color.c: 6: return (expf(tmp2));
	pushw	x
	pushw	y
	call	_expf
	pushw	x
	pushw	y
	call	___fs2uint
;	./src/color.c: 7: }
	ret
;	./src/color.c: 10: void write_color_to_registers(struct Color *color) {
;	-----------------------------------------
;	 function write_color_to_registers
;	-----------------------------------------
_write_color_to_registers:
	sub	sp, #6
;	./src/color.c: 11: uint16_t red = normalize_from( &color->r );
	ldw	(0x05, sp), x
	call	_normalize_from
	ldw	(0x01, sp), x
;	./src/color.c: 12: uint16_t green = normalize_from( &color->g );
	ldw	x, (0x05, sp)
	incw	x
	call	_normalize_from
	ldw	(0x03, sp), x
;	./src/color.c: 13: uint16_t blue = normalize_from( &color->b );
	ldw	x, (0x05, sp)
	incw	x
	incw	x
	call	_normalize_from
;	./src/color.c: 15: TIM2_CCR2H = red >> 8;
	ld	a, (0x01, sp)
	ld	0x5313, a
;	./src/color.c: 16: TIM2_CCR2L = red;
	ld	a, (0x02, sp)
	ld	0x5314, a
;	./src/color.c: 18: TIM2_CCR1H = green >> 8;
	ld	a, (0x03, sp)
	ld	0x5311, a
;	./src/color.c: 19: TIM2_CCR1L = green;
	ld	a, (0x04, sp)
	ld	0x5312, a
;	./src/color.c: 21: TIM2_CCR3H = blue >> 8;
	ld	a, xh
	ld	0x5315, a
;	./src/color.c: 22: TIM2_CCR3L = blue;
	ld	a, xl
	ld	0x5316, a
;	./src/color.c: 23: }
	addw	sp, #6
	ret
;	./src/color.c: 25: void smart_increment(uint8_t *val) {
;	-----------------------------------------
;	 function smart_increment
;	-----------------------------------------
_smart_increment:
;	./src/color.c: 26: if(*val < 255) {
	ld	a, (x)
	cp	a, #0xff
	jrc	00110$
	ret
00110$:
;	./src/color.c: 27: *val += 1;
	inc	a
	ld	(x), a
;	./src/color.c: 29: }
	ret
;	./src/color.c: 31: void smart_decrement(uint8_t *val) {
;	-----------------------------------------
;	 function smart_decrement
;	-----------------------------------------
_smart_decrement:
;	./src/color.c: 32: if(*val > 0) {
	ld	a, (x)
	jrne	00110$
	ret
00110$:
;	./src/color.c: 33: *val -= 1;
	dec	a
	ld	(x), a
;	./src/color.c: 35: }
	ret
;	./src/color.c: 37: void load_color_from_eeprom(struct Color *color, uint8_t color_cell) {
;	-----------------------------------------
;	 function load_color_from_eeprom
;	-----------------------------------------
_load_color_from_eeprom:
	sub	sp, #7
	ldw	(0x06, sp), x
;	./src/color.c: 39: eeprom_read(3*color_cell+0, &r);
	clrw	x
	ld	xl, a
	pushw	x
	sllw	x
	addw	x, (1, sp)
	addw	sp, #2
	ldw	(0x04, sp), x
	ldw	y, x
	ldw	x, sp
	incw	x
	pushw	x
	ldw	x, y
	call	_eeprom_read
;	./src/color.c: 40: eeprom_read(3*color_cell+1, &g);
	ldw	x, sp
	incw	x
	incw	x
	exgw	x, y
	ldw	x, (0x04, sp)
	incw	x
	pushw	y
	call	_eeprom_read
;	./src/color.c: 41: eeprom_read(3*color_cell+2, &b);
	ldw	x, sp
	addw	x, #3
	ldw	y, (0x04, sp)
	addw	y, #0x0002
	pushw	x
	ldw	x, y
	call	_eeprom_read
;	./src/color.c: 43: color->r = r;
	ldw	x, (0x06, sp)
	ld	a, (0x01, sp)
	ld	(x), a
;	./src/color.c: 44: color->g = g;
	ldw	x, (0x06, sp)
	incw	x
	ld	a, (0x02, sp)
	ld	(x), a
;	./src/color.c: 45: color->b = b;
	ldw	x, (0x06, sp)
	incw	x
	incw	x
	ld	a, (0x03, sp)
	ld	(x), a
;	./src/color.c: 46: }
	addw	sp, #7
	ret
;	./src/color.c: 48: void write_color_to_eeprom(struct Color *color, uint8_t color_cell) {
;	-----------------------------------------
;	 function write_color_to_eeprom
;	-----------------------------------------
_write_color_to_eeprom:
	sub	sp, #4
	ldw	(0x03, sp), x
	ld	yl, a
;	./src/color.c: 49: eeprom_write(3*color_cell+0, color->r);
	ldw	x, (0x03, sp)
	ld	a, (x)
	clrw	x
	exg	a, xl
	ld	a, yl
	exg	a, xl
	pushw	x
	sllw	x
	addw	x, (1, sp)
	addw	sp, #2
	ldw	(0x01, sp), x
	call	_eeprom_write
;	./src/color.c: 50: eeprom_write(3*color_cell+1, color->g);
	ldw	x, (0x03, sp)
	ld	a, (0x1, x)
	ldw	x, (0x01, sp)
	incw	x
	call	_eeprom_write
;	./src/color.c: 51: eeprom_write(3*color_cell+2, color->b);
	ldw	x, (0x03, sp)
	ld	a, (0x2, x)
	ldw	x, (0x01, sp)
	incw	x
	incw	x
	addw	sp, #4
;	./src/color.c: 52: }
	jp	_eeprom_write
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
