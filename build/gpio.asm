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
;	./src/gpio.c: 5: PB_DDR |= (1 << 5);
	bset	0x5007, #5
;	./src/gpio.c: 6: PB_CR1 |= (1 << 5);
	bset	0x5008, #5
;	./src/gpio.c: 7: PB_CR2 &= ~(1 << 5);
	bres	0x5009, #5
;	./src/gpio.c: 11: PD_DDR |= (1 << 4);
	bset	0x5011, #4
;	./src/gpio.c: 12: PD_CR1 |= (1 << 4);
	bset	0x5012, #4
;	./src/gpio.c: 13: PD_CR2 &= ~(1 << 4);
	bres	0x5013, #4
;	./src/gpio.c: 14: PD_ODR &= ~(1 << 4);
	bres	0x500f, #4
;	./src/gpio.c: 18: PD_DDR |= (1 << 3);
	bset	0x5011, #3
;	./src/gpio.c: 19: PD_CR1 |= (1 << 3);
	bset	0x5012, #3
;	./src/gpio.c: 20: PD_CR2 &= ~(1 << 3);
	bres	0x5013, #3
;	./src/gpio.c: 21: PD_ODR &= ~(1 << 3);
	bres	0x500f, #3
;	./src/gpio.c: 25: PA_DDR |= (1 << 3);
	bset	0x5002, #3
;	./src/gpio.c: 26: PA_CR1 |= (1 << 3);
	bset	0x5003, #3
;	./src/gpio.c: 27: PA_CR2 &= ~(1 << 3);
	bres	0x5004, #3
;	./src/gpio.c: 28: PA_ODR &= ~(1 << 3);
	bres	0x5000, #3
;	./src/gpio.c: 39: PD_DDR &= ~(1 << 2); // Input 
	bres	0x5011, #2
;	./src/gpio.c: 40: PD_CR1 |= (1 << 2); // Pull-Up
	bset	0x5012, #2
;	./src/gpio.c: 41: PD_CR2 &= ~(1 << 2); // Interrupt disabled
	bres	0x5013, #2
;	./src/gpio.c: 43: PC_DDR &= ~(1 << 7);
	bres	0x500c, #7
;	./src/gpio.c: 44: PC_CR1 |= (1 << 7);
	bset	0x500d, #7
;	./src/gpio.c: 45: PC_CR2 &= ~(1 << 7);
	bres	0x500e, #7
;	./src/gpio.c: 47: PC_DDR &= ~(1 << 6);
	bres	0x500c, #6
;	./src/gpio.c: 48: PC_CR1 |= (1 << 6);
	bset	0x500d, #6
;	./src/gpio.c: 49: PC_CR2 &= ~(1 << 6);
	bres	0x500e, #6
;	./src/gpio.c: 51: PC_DDR &= ~(1 << 5);
	bres	0x500c, #5
;	./src/gpio.c: 52: PC_CR1 |= (1 << 5);
	bset	0x500d, #5
;	./src/gpio.c: 53: PC_CR2 &= ~(1 << 5);
	bres	0x500e, #5
;	./src/gpio.c: 55: PC_DDR &= ~(1 << 4);
	bres	0x500c, #4
;	./src/gpio.c: 56: PC_CR1 |= (1 << 4);
	bset	0x500d, #4
;	./src/gpio.c: 57: PC_CR2 &= ~(1 << 4);
	bres	0x500e, #4
;	./src/gpio.c: 59: PC_DDR &= ~(1 << 3);
	bres	0x500c, #3
;	./src/gpio.c: 60: PC_CR1 |= (1 << 3);
	bset	0x500d, #3
;	./src/gpio.c: 61: PC_CR2 &= ~(1 << 3);
	bres	0x500e, #3
;	./src/gpio.c: 62: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
