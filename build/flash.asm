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
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
