;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.2.0 #13081 (Linux)
;--------------------------------------------------------
	.module flash
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _eeprom_unlock
	.globl _write_to_eeprom
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
;	./src/flash.c: 3: void eeprom_unlock() {
;	-----------------------------------------
;	 function eeprom_unlock
;	-----------------------------------------
_eeprom_unlock:
;	./src/flash.c: 4: FLASH_PUKR = 0x56;
	mov	0x5062+0, #0x56
;	./src/flash.c: 5: FLASH_PUKR = 0xAE;
	mov	0x5062+0, #0xae
;	./src/flash.c: 6: }
	ret
;	./src/flash.c: 8: void write_to_eeprom(void) {
;	-----------------------------------------
;	 function write_to_eeprom
;	-----------------------------------------
_write_to_eeprom:
;	./src/flash.c: 9: if (!(FLASH_IAPSR & 0x02))
	btjt	0x505f, #1, 00103$
;	./src/flash.c: 12: FLASH_DUKR = 0xAE;
	mov	0x5064+0, #0xae
;	./src/flash.c: 13: FLASH_DUKR = 0x56;
	mov	0x5064+0, #0x56
;	./src/flash.c: 16: while (!(FLASH_IAPSR & DUL));
00103$:
	btjf	0x505f, #3, 00103$
;	./src/flash.c: 18: EEPROM_FIRST_ADDR = 0xff;
	mov	0x4000+0, #0xff
;	./src/flash.c: 20: FLASH_IAPSR &= ~(DUL);      // lock EEPROM
	bres	0x505f, #3
;	./src/flash.c: 21: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
