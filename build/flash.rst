                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.2.0 #13081 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module flash
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _eeprom_unlock
                                     12 	.globl _eeprom_write
                                     13 ;--------------------------------------------------------
                                     14 ; ram data
                                     15 ;--------------------------------------------------------
                                     16 	.area DATA
                                     17 ;--------------------------------------------------------
                                     18 ; ram data
                                     19 ;--------------------------------------------------------
                                     20 	.area INITIALIZED
                                     21 ;--------------------------------------------------------
                                     22 ; absolute external ram data
                                     23 ;--------------------------------------------------------
                                     24 	.area DABS (ABS)
                                     25 
                                     26 ; default segment ordering for linker
                                     27 	.area HOME
                                     28 	.area GSINIT
                                     29 	.area GSFINAL
                                     30 	.area CONST
                                     31 	.area INITIALIZER
                                     32 	.area CODE
                                     33 
                                     34 ;--------------------------------------------------------
                                     35 ; global & static initialisations
                                     36 ;--------------------------------------------------------
                                     37 	.area HOME
                                     38 	.area GSINIT
                                     39 	.area GSFINAL
                                     40 	.area GSINIT
                                     41 ;--------------------------------------------------------
                                     42 ; Home
                                     43 ;--------------------------------------------------------
                                     44 	.area HOME
                                     45 	.area HOME
                                     46 ;--------------------------------------------------------
                                     47 ; code
                                     48 ;--------------------------------------------------------
                                     49 	.area CODE
                                     50 ;	./src/flash.c: 3: void eeprom_unlock() {
                                     51 ;	-----------------------------------------
                                     52 ;	 function eeprom_unlock
                                     53 ;	-----------------------------------------
      00832A                         54 _eeprom_unlock:
                                     55 ;	./src/flash.c: 4: FLASH_PUKR = 0x56;
      00832A 35 56 50 62      [ 1]   56 	mov	0x5062+0, #0x56
                                     57 ;	./src/flash.c: 5: FLASH_PUKR = 0xAE;
      00832E 35 AE 50 62      [ 1]   58 	mov	0x5062+0, #0xae
                                     59 ;	./src/flash.c: 6: }
      008332 81               [ 4]   60 	ret
                                     61 ;	./src/flash.c: 8: void eeprom_write(uint16_t mem_cell, uint8_t data) {
                                     62 ;	-----------------------------------------
                                     63 ;	 function eeprom_write
                                     64 ;	-----------------------------------------
      008333                         65 _eeprom_write:
      008333 88               [ 1]   66 	push	a
      008334 6B 01            [ 1]   67 	ld	(0x01, sp), a
                                     68 ;	./src/flash.c: 9: if (!(FLASH_IAPSR & 0x02))
      008336 72 02 50 5F 08   [ 2]   69 	btjt	0x505f, #1, 00103$
                                     70 ;	./src/flash.c: 12: FLASH_DUKR = 0xAE;
      00833B 35 AE 50 64      [ 1]   71 	mov	0x5064+0, #0xae
                                     72 ;	./src/flash.c: 13: FLASH_DUKR = 0x56;
      00833F 35 56 50 64      [ 1]   73 	mov	0x5064+0, #0x56
                                     74 ;	./src/flash.c: 16: while (!(FLASH_IAPSR & DUL));
      008343                         75 00103$:
      008343 C6 50 5F         [ 1]   76 	ld	a, 0x505f
      008346 A5 08            [ 1]   77 	bcp	a, #0x08
      008348 27 F9            [ 1]   78 	jreq	00103$
                                     79 ;	./src/flash.c: 19: addr = (uint8_t *)(EEPROM_FIRST_ADDR + mem_cell); //Initialize  pointer
      00834A 1C 40 00         [ 2]   80 	addw	x, #0x4000
                                     81 ;	./src/flash.c: 21: __asm sim __endasm; // Disable interrupts
      00834D 9B               [ 1]   82 	sim	
                                     83 ;	./src/flash.c: 22: *addr = data;
      00834E 7B 01            [ 1]   84 	ld	a, (0x01, sp)
      008350 F7               [ 1]   85 	ld	(x), a
                                     86 ;	./src/flash.c: 23: while(EOP != (~FLASH_IAPSR & EOP)); // Wait for writing to complete
      008351                         87 00106$:
                                     88 ;	./src/flash.c: 9: if (!(FLASH_IAPSR & 0x02))
      008351 C6 50 5F         [ 1]   89 	ld	a, 0x505f
                                     90 ;	./src/flash.c: 23: while(EOP != (~FLASH_IAPSR & EOP)); // Wait for writing to complete
      008354 5F               [ 1]   91 	clrw	x
      008355 97               [ 1]   92 	ld	xl, a
      008356 88               [ 1]   93 	push	a
      008357 53               [ 2]   94 	cplw	x
      008358 9F               [ 1]   95 	ld	a, xl
      008359 A4 04            [ 1]   96 	and	a, #0x04
      00835B 97               [ 1]   97 	ld	xl, a
      00835C 4F               [ 1]   98 	clr	a
      00835D 95               [ 1]   99 	ld	xh, a
      00835E 84               [ 1]  100 	pop	a
      00835F A3 00 04         [ 2]  101 	cpw	x, #0x0004
      008362 26 ED            [ 1]  102 	jrne	00106$
                                    103 ;	./src/flash.c: 24: __asm rim __endasm; // Enable interrupts
      008364 9A               [ 1]  104 	rim	
                                    105 ;	./src/flash.c: 26: FLASH_IAPSR &= ~(DUL);      // lock EEPROM
      008365 A4 F7            [ 1]  106 	and	a, #0xf7
      008367 C7 50 5F         [ 1]  107 	ld	0x505f, a
                                    108 ;	./src/flash.c: 27: }
      00836A 84               [ 1]  109 	pop	a
      00836B 81               [ 4]  110 	ret
                                    111 	.area CODE
                                    112 	.area CONST
                                    113 	.area INITIALIZER
                                    114 	.area CABS (ABS)
