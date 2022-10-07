;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.2.0 #13081 (Linux)
;--------------------------------------------------------
	.module color
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _sqrtf
	.globl _expf
	.globl _normalize_from
	.globl _write_color_to_registers
	.globl _smart_increment
	.globl _smart_decrement
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
;	./src/color.c: 15: TIM2_CCR1H = red >> 8;
	ld	a, (0x01, sp)
	ld	0x5311, a
;	./src/color.c: 16: TIM2_CCR1L = red;
	ld	a, (0x02, sp)
	ld	0x5312, a
;	./src/color.c: 18: TIM2_CCR2H = green >> 8;
	ld	a, (0x03, sp)
	ld	0x5313, a
;	./src/color.c: 19: TIM2_CCR2L = green;
	ld	a, (0x04, sp)
	ld	0x5314, a
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
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
