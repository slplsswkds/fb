;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.2.0 #13081 (Linux)
;--------------------------------------------------------
	.module flash
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _eeprom_lock
	.globl _eeprom_unlock
	.globl _eeprom_clear_all
	.globl _eeprom_write
	.globl _eeprom_read
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
;	./src/flash.c: 4: if (!(FLASH_IAPSR & 0x02))
	btjt	0x505f, #1, 00103$
;	./src/flash.c: 7: FLASH_DUKR = 0xAE;
	mov	0x5064+0, #0xae
;	./src/flash.c: 8: FLASH_DUKR = 0x56;
	mov	0x5064+0, #0x56
;	./src/flash.c: 11: while (!(FLASH_IAPSR & DUL));
00103$:
	btjf	0x505f, #3, 00103$
;	./src/flash.c: 12: }
	ret
;	./src/flash.c: 14: void eeprom_lock() {
;	-----------------------------------------
;	 function eeprom_lock
;	-----------------------------------------
_eeprom_lock:
;	./src/flash.c: 15: FLASH_IAPSR &= ~(DUL);
	bres	0x505f, #3
;	./src/flash.c: 16: }
	ret
;	./src/flash.c: 18: void eeprom_clear_all() {
;	-----------------------------------------
;	 function eeprom_clear_all
;	-----------------------------------------
_eeprom_clear_all:
;	./src/flash.c: 19: for(int c = 0; c < 639; c++) {
	clrw	x
00103$:
	cpw	x, #0x027f
	jrslt	00118$
	ret
00118$:
;	./src/flash.c: 20: eeprom_write(c, 0);
	ldw	y, x
	pushw	x
	clr	a
	ldw	x, y
	call	_eeprom_write
	popw	x
;	./src/flash.c: 19: for(int c = 0; c < 639; c++) {
	incw	x
	jra	00103$
;	./src/flash.c: 22: }
	ret
;	./src/flash.c: 24: void eeprom_write(uint16_t mem_cell, uint8_t data) {
;	-----------------------------------------
;	 function eeprom_write
;	-----------------------------------------
_eeprom_write:
	push	a
	ld	(0x01, sp), a
;	./src/flash.c: 25: eeprom_unlock();
	pushw	x
	call	_eeprom_unlock
	popw	x
;	./src/flash.c: 27: while (!(FLASH_IAPSR & DUL));
00101$:
	ld	a, 0x505f
	bcp	a, #0x08
	jreq	00101$
;	./src/flash.c: 30: addr = (uint8_t *)(EEPROM_FIRST_ADDR + mem_cell); //Initialize  pointer
	addw	x, #0x4000
;	./src/flash.c: 32: __asm sim __endasm; // Disable interrupts
	sim	
;	./src/flash.c: 33: *addr = data;
	ld	a, (0x01, sp)
	ld	(x), a
;	./src/flash.c: 34: while(EOP != (~FLASH_IAPSR & EOP)); // Wait for writing to complete
00104$:
	ld	a, 0x505f
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
;	./src/flash.c: 35: __asm rim __endasm; // Enable interrupts
	rim	
;	./src/flash.c: 37: eeprom_lock();
	pop	a
	jp	_eeprom_lock
;	./src/flash.c: 38: }
	pop	a
	ret
;	./src/flash.c: 40: void eeprom_read(uint16_t mem_cell, uint8_t *data) {
;	-----------------------------------------
;	 function eeprom_read
;	-----------------------------------------
_eeprom_read:
;	./src/flash.c: 42: addr = (uint8_t *)(EEPROM_FIRST_ADDR + mem_cell);
	addw	x, #0x4000
;	./src/flash.c: 44: __asm sim __endasm;
	sim	
;	./src/flash.c: 45: *data = *addr;
	ldw	y, (0x03, sp)
	ld	a, (x)
	ld	(y), a
;	./src/flash.c: 46: while(EOP != (~FLASH_IAPSR & EOP));
00101$:
	ld	a, 0x505f
	clrw	x
	ld	xl, a
	cplw	x
	ld	a, xl
	and	a, #0x04
	ld	xl, a
	clr	a
	ld	xh, a
	cpw	x, #0x0004
	jrne	00101$
;	./src/flash.c: 47: __asm rim __endasm;
	rim	
;	./src/flash.c: 48: }
	ldw	x, (1, sp)
	addw	sp, #4
	jp	(x)
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
