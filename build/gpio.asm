;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.2.0 #13081 (Linux)
;--------------------------------------------------------
	.module gpio
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _gpio_init
	.globl _btn_r_plus_is_pressed
	.globl _btn_g_plus_is_pressed
	.globl _btn_b_plus_is_pressed
	.globl _btn_r_minus_is_pressed
	.globl _btn_g_minus_is_pressed
	.globl _btn_b_minus_is_pressed
	.globl _btn_flash_is_pressed
	.globl _btn_load_is_pressed
	.globl _btn_brightness_plus_is_pressed
	.globl _btn_brightness_minus_is_pressed
	.globl _get_number_from_buttons
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
;	./src/gpio.c: 3: void gpio_init() {
;	-----------------------------------------
;	 function gpio_init
;	-----------------------------------------
_gpio_init:
;	./src/gpio.c: 6: PB_DDR |= (1 << 5);
	bset	0x5007, #5
;	./src/gpio.c: 7: PB_CR1 |= (1 << 5);
	bset	0x5008, #5
;	./src/gpio.c: 8: PB_CR2 &= ~(1 << 5);
	bres	0x5009, #5
;	./src/gpio.c: 9: PB_ODR |= (1 << 5);
	bset	0x5005, #5
;	./src/gpio.c: 13: PD_DDR |= (1 << 4);
	bset	0x5011, #4
;	./src/gpio.c: 14: PD_CR1 |= (1 << 4);
	bset	0x5012, #4
;	./src/gpio.c: 15: PD_CR2 &= ~(1 << 4);
	bres	0x5013, #4
;	./src/gpio.c: 16: PD_ODR &= ~(1 << 4);
	bres	0x500f, #4
;	./src/gpio.c: 20: PD_DDR |= (1 << 3);
	bset	0x5011, #3
;	./src/gpio.c: 21: PD_CR1 |= (1 << 3);
	bset	0x5012, #3
;	./src/gpio.c: 22: PD_CR2 &= ~(1 << 3);
	bres	0x5013, #3
;	./src/gpio.c: 23: PD_ODR &= ~(1 << 3);
	bres	0x500f, #3
;	./src/gpio.c: 27: PA_DDR |= (1 << 3);
	bset	0x5002, #3
;	./src/gpio.c: 28: PA_CR1 |= (1 << 3);
	bset	0x5003, #3
;	./src/gpio.c: 29: PA_CR2 &= ~(1 << 3);
	bres	0x5004, #3
;	./src/gpio.c: 30: PA_ODR &= ~(1 << 3);
	bres	0x5000, #3
;	./src/gpio.c: 47: PD_DDR &= ~(1 << 2); // Input 
	bres	0x5011, #2
;	./src/gpio.c: 48: PD_CR1 |= (1 << 2); // Pull-Up
	bset	0x5012, #2
;	./src/gpio.c: 49: PD_CR2 &= ~(1 << 2); // Interrupt disabled
	bres	0x5013, #2
;	./src/gpio.c: 51: PC_DDR &= ~(1 << 7);
	bres	0x500c, #7
;	./src/gpio.c: 52: PC_CR1 |= (1 << 7);
	bset	0x500d, #7
;	./src/gpio.c: 53: PC_CR2 &= ~(1 << 7);
	bres	0x500e, #7
;	./src/gpio.c: 55: PC_DDR &= ~(1 << 6);
	bres	0x500c, #6
;	./src/gpio.c: 56: PC_CR1 |= (1 << 6);
	bset	0x500d, #6
;	./src/gpio.c: 57: PC_CR2 &= ~(1 << 6);
	bres	0x500e, #6
;	./src/gpio.c: 59: PC_DDR &= ~(1 << 5);
	bres	0x500c, #5
;	./src/gpio.c: 60: PC_CR1 |= (1 << 5);
	bset	0x500d, #5
;	./src/gpio.c: 61: PC_CR2 &= ~(1 << 5);
	bres	0x500e, #5
;	./src/gpio.c: 63: PC_DDR &= ~(1 << 4);
	bres	0x500c, #4
;	./src/gpio.c: 64: PC_CR1 |= (1 << 4);
	bset	0x500d, #4
;	./src/gpio.c: 65: PC_CR2 &= ~(1 << 4);
	bres	0x500e, #4
;	./src/gpio.c: 67: PC_DDR &= ~(1 << 3);
	bres	0x500c, #3
;	./src/gpio.c: 68: PC_CR1 |= (1 << 3);
	bset	0x500d, #3
;	./src/gpio.c: 69: PC_CR2 &= ~(1 << 3);
	bres	0x500e, #3
;	./src/gpio.c: 72: PB_DDR &= ~(1 << 4);
	bres	0x5007, #4
;	./src/gpio.c: 73: PB_CR1 |= (1 << 4);
	bset	0x5008, #4
;	./src/gpio.c: 74: PB_CR2 &= ~(1 << 4);
	bres	0x5009, #4
;	./src/gpio.c: 76: PB_DDR &= ~(1 << 5);
	bres	0x5007, #5
;	./src/gpio.c: 77: PB_CR1 |= (1 << 5);
	bset	0x5008, #5
;	./src/gpio.c: 78: PB_CR2 &= ~(1 << 5);
	bres	0x5009, #5
;	./src/gpio.c: 80: PA_DDR &= ~(1 << 1);    
	bres	0x5002, #1
;	./src/gpio.c: 81: PA_CR1 |= (1 << 1);    
	bset	0x5003, #1
;	./src/gpio.c: 82: PA_CR2 &= ~(1 << 1);    
	bres	0x5004, #1
;	./src/gpio.c: 84: PA_DDR &= ~(1 << 2);    
	bres	0x5002, #2
;	./src/gpio.c: 85: PA_CR1 |= (1 << 2);    
	bset	0x5003, #2
;	./src/gpio.c: 86: PA_CR2 &= ~(1 << 2);    
	bres	0x5004, #2
;	./src/gpio.c: 90: PD_DDR |= (1 << 5); // Output
	bset	0x5011, #5
;	./src/gpio.c: 91: PD_CR1 |= (1 << 5); // PushPull
	bset	0x5012, #5
;	./src/gpio.c: 92: PD_CR2 &= ~(1 << 5); // To 2MHz
	bres	0x5013, #5
;	./src/gpio.c: 95: PD_DDR &= ~(1 << 6); // Input
	bres	0x5011, #6
;	./src/gpio.c: 96: PD_CR1 &= ~(1 << 6); // Floating
	bres	0x5012, #6
;	./src/gpio.c: 97: PD_CR2 &= ~(1 << 6); // External interrupt disabled
	bres	0x5013, #6
;	./src/gpio.c: 98: }
	ret
;	./src/gpio.c: 100: uint8_t btn_r_plus_is_pressed() {
;	-----------------------------------------
;	 function btn_r_plus_is_pressed
;	-----------------------------------------
_btn_r_plus_is_pressed:
;	./src/gpio.c: 101: return((1 << 2) == (~PD_IDR & (1 << 2)));
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
	jrne	00104$
	ld	a, #0x01
	ret
00104$:
	clr	a
;	./src/gpio.c: 102: }
	ret
;	./src/gpio.c: 104: uint8_t btn_g_plus_is_pressed() {
;	-----------------------------------------
;	 function btn_g_plus_is_pressed
;	-----------------------------------------
_btn_g_plus_is_pressed:
;	./src/gpio.c: 105: return((1 << 6) == (~PC_IDR & (1 << 6)));
	ld	a, 0x500b
	clrw	x
	ld	xl, a
	cplw	x
	ld	a, xl
	and	a, #0x40
	ld	xl, a
	clr	a
	ld	xh, a
	cpw	x, #0x0040
	jrne	00104$
	ld	a, #0x01
	ret
00104$:
	clr	a
;	./src/gpio.c: 106: }
	ret
;	./src/gpio.c: 108: uint8_t btn_b_plus_is_pressed() {
;	-----------------------------------------
;	 function btn_b_plus_is_pressed
;	-----------------------------------------
_btn_b_plus_is_pressed:
;	./src/gpio.c: 109: return((1 << 4) == (~PC_IDR & (1 << 4)));
	ld	a, 0x500b
	clrw	x
	ld	xl, a
	cplw	x
	ld	a, xl
	and	a, #0x10
	ld	xl, a
	clr	a
	ld	xh, a
	cpw	x, #0x0010
	jrne	00104$
	ld	a, #0x01
	ret
00104$:
	clr	a
;	./src/gpio.c: 110: }
	ret
;	./src/gpio.c: 112: uint8_t btn_r_minus_is_pressed() {
;	-----------------------------------------
;	 function btn_r_minus_is_pressed
;	-----------------------------------------
_btn_r_minus_is_pressed:
;	./src/gpio.c: 113: return((1 << 7) == (~PC_IDR & (1 << 7)));
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
	ld	a, #0x01
	ret
00104$:
	clr	a
;	./src/gpio.c: 114: }
	ret
;	./src/gpio.c: 116: uint8_t btn_g_minus_is_pressed() {
;	-----------------------------------------
;	 function btn_g_minus_is_pressed
;	-----------------------------------------
_btn_g_minus_is_pressed:
;	./src/gpio.c: 117: return((1 << 5) == (~PC_IDR & (1 << 5)));
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
	jrne	00104$
	ld	a, #0x01
	ret
00104$:
	clr	a
;	./src/gpio.c: 118: }
	ret
;	./src/gpio.c: 120: uint8_t btn_b_minus_is_pressed() {
;	-----------------------------------------
;	 function btn_b_minus_is_pressed
;	-----------------------------------------
_btn_b_minus_is_pressed:
;	./src/gpio.c: 121: return((1 << 3) == (~PC_IDR & (1 << 3)));
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
	jrne	00104$
	ld	a, #0x01
	ret
00104$:
	clr	a
;	./src/gpio.c: 122: }
	ret
;	./src/gpio.c: 124: uint8_t btn_flash_is_pressed() {
;	-----------------------------------------
;	 function btn_flash_is_pressed
;	-----------------------------------------
_btn_flash_is_pressed:
;	./src/gpio.c: 125: return((1 << 4) == (~PB_IDR & (1 << 4)));
	ld	a, 0x5006
	clrw	x
	ld	xl, a
	cplw	x
	ld	a, xl
	and	a, #0x10
	ld	xl, a
	clr	a
	ld	xh, a
	cpw	x, #0x0010
	jrne	00104$
	ld	a, #0x01
	ret
00104$:
	clr	a
;	./src/gpio.c: 126: }
	ret
;	./src/gpio.c: 128: uint8_t btn_load_is_pressed() {
;	-----------------------------------------
;	 function btn_load_is_pressed
;	-----------------------------------------
_btn_load_is_pressed:
;	./src/gpio.c: 129: return((1 << 5) == (~PB_IDR & (1 << 5)));
	ld	a, 0x5006
	clrw	x
	ld	xl, a
	cplw	x
	ld	a, xl
	and	a, #0x20
	ld	xl, a
	clr	a
	ld	xh, a
	cpw	x, #0x0020
	jrne	00104$
	ld	a, #0x01
	ret
00104$:
	clr	a
;	./src/gpio.c: 130: }
	ret
;	./src/gpio.c: 132: uint8_t btn_brightness_plus_is_pressed() {
;	-----------------------------------------
;	 function btn_brightness_plus_is_pressed
;	-----------------------------------------
_btn_brightness_plus_is_pressed:
;	./src/gpio.c: 133: return((1 << 1) == (~PA_IDR & (1 << 1)));
	ld	a, 0x5001
	clrw	x
	ld	xl, a
	cplw	x
	ld	a, xl
	and	a, #0x02
	ld	xl, a
	clr	a
	ld	xh, a
	cpw	x, #0x0002
	jrne	00104$
	ld	a, #0x01
	ret
00104$:
	clr	a
;	./src/gpio.c: 134: }
	ret
;	./src/gpio.c: 136: uint8_t btn_brightness_minus_is_pressed() {
;	-----------------------------------------
;	 function btn_brightness_minus_is_pressed
;	-----------------------------------------
_btn_brightness_minus_is_pressed:
;	./src/gpio.c: 137: return((1 << 2) == (~PA_IDR & (1 << 2)));
	ld	a, 0x5001
	clrw	x
	ld	xl, a
	cplw	x
	ld	a, xl
	and	a, #0x04
	ld	xl, a
	clr	a
	ld	xh, a
	cpw	x, #0x0004
	jrne	00104$
	ld	a, #0x01
	ret
00104$:
	clr	a
;	./src/gpio.c: 138: }
	ret
;	./src/gpio.c: 140: static void delay(uint16_t t) {
;	-----------------------------------------
;	 function delay
;	-----------------------------------------
_delay:
;	./src/gpio.c: 141: while(t--) {};
00101$:
	ldw	y, x
	decw	x
	tnzw	y
	jrne	00101$
;	./src/gpio.c: 142: }
	ret
;	./src/gpio.c: 144: uint8_t get_number_from_buttons() {
;	-----------------------------------------
;	 function get_number_from_buttons
;	-----------------------------------------
_get_number_from_buttons:
	push	a
;	./src/gpio.c: 145: uint8_t number = 0;
	clr	(0x01, sp)
;	./src/gpio.c: 147: while(1) { // In future should be added timeout
00116$:
;	./src/gpio.c: 148: delay(65535);
	clrw	x
	decw	x
	call	_delay
;	./src/gpio.c: 150: if(btn_r_plus_is_pressed()) {
	call	_btn_r_plus_is_pressed
	tnz	a
	jreq	00102$
;	./src/gpio.c: 151: number |= (1 << 5);
	ld	a, (0x01, sp)
	or	a, #0x20
	ld	(0x01, sp), a
00102$:
;	./src/gpio.c: 154: if(btn_g_plus_is_pressed()) {
	call	_btn_g_plus_is_pressed
	tnz	a
	jreq	00104$
;	./src/gpio.c: 155: number |= (1 << 4);
	ld	a, (0x01, sp)
	or	a, #0x10
	ld	(0x01, sp), a
00104$:
;	./src/gpio.c: 158: if(btn_b_plus_is_pressed()) {
	call	_btn_b_plus_is_pressed
	tnz	a
	jreq	00106$
;	./src/gpio.c: 159: number |= (1 << 3);
	ld	a, (0x01, sp)
	or	a, #0x08
	ld	(0x01, sp), a
00106$:
;	./src/gpio.c: 162: if(btn_r_minus_is_pressed()) {
	call	_btn_r_minus_is_pressed
	tnz	a
	jreq	00108$
;	./src/gpio.c: 163: number |= (1 << 2);
	ld	a, (0x01, sp)
	or	a, #0x04
	ld	(0x01, sp), a
00108$:
;	./src/gpio.c: 166: if(btn_g_minus_is_pressed()) {
	call	_btn_g_minus_is_pressed
	tnz	a
	jreq	00110$
;	./src/gpio.c: 167: number |= (1 << 1);
	ld	a, (0x01, sp)
	or	a, #0x02
	ld	(0x01, sp), a
00110$:
;	./src/gpio.c: 170: if(btn_b_minus_is_pressed()) {
	call	_btn_b_minus_is_pressed
	tnz	a
	jreq	00112$
;	./src/gpio.c: 171: number |= (1 << 0);
	srl	(0x01, sp)
	scf
	rlc	(0x01, sp)
00112$:
;	./src/gpio.c: 177: if(btn_load_is_pressed()) {
	call	_btn_load_is_pressed
	tnz	a
	jreq	00116$
;	./src/gpio.c: 182: return number;
	ld	a, (0x01, sp)
;	./src/gpio.c: 183: }
	addw	sp, #1
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
