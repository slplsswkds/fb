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
	.globl _eeprom_write
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
;	./src/flash.c: 8: void eeprom_write(uint16_t mem_cell, uint8_t data) {
;	-----------------------------------------
;	 function eeprom_write
;	-----------------------------------------
_eeprom_write:
	push	a
	ld	(0x01, sp), a
;	./src/flash.c: 9: if (!(FLASH_IAPSR & 0x02))
	btjt	0x505f, #1, 00103$
;	./src/flash.c: 12: FLASH_DUKR = 0xAE;
	mov	0x5064+0, #0xae
;	./src/flash.c: 13: FLASH_DUKR = 0x56;
	mov	0x5064+0, #0x56
;	./src/flash.c: 16: while (!(FLASH_IAPSR & DUL));
00103$:
	ld	a, 0x505f
	bcp	a, #0x08
	jreq	00103$
;	./src/flash.c: 19: addr = (uint8_t *)(EEPROM_FIRST_ADDR + mem_cell); //Initialize  pointer
	addw	x, #0x4000
;	./src/flash.c: 21: __asm sim __endasm; // Disable interrupts
	sim	
;	./src/flash.c: 23: *addr = data;
	ld	a, (0x01, sp)
	ld	(x), a
;	./src/flash.c: 25: while(EOP != (~FLASH_IAPSR & EOP)); // Wait for writing to complete
00106$:
;	./src/flash.c: 9: if (!(FLASH_IAPSR & 0x02))
	ld	a, 0x505f
;	./src/flash.c: 25: while(EOP != (~FLASH_IAPSR & EOP)); // Wait for writing to complete
	clrw	x
	ld	xl, a
	push	a
	cplw	x
	ld	a, xl
	and	a, #0x04
	ld	xl, a
	clr	a
	ld	xh, a
	pop	a
	cpw	x, #0x0004
	jrne	00106$
;	./src/flash.c: 27: __asm rim __endasm; // Enable interrupts
	rim	
;	./src/flash.c: 29: FLASH_IAPSR &= ~(DUL);      // lock EEPROM
	and	a, #0xf7
	ld	0x505f, a
;	./src/flash.c: 30: }
	pop	a
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
