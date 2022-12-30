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
                                     11 	.globl _eeprom_lock
                                     12 	.globl _eeprom_unlock
                                     13 	.globl _eeprom_clear_all
                                     14 	.globl _eeprom_write
                                     15 	.globl _eeprom_read
                                     16 ;--------------------------------------------------------
                                     17 ; ram data
                                     18 ;--------------------------------------------------------
                                     19 	.area DATA
                                     20 ;--------------------------------------------------------
                                     21 ; ram data
                                     22 ;--------------------------------------------------------
                                     23 	.area INITIALIZED
                                     24 ;--------------------------------------------------------
                                     25 ; absolute external ram data
                                     26 ;--------------------------------------------------------
                                     27 	.area DABS (ABS)
                                     28 
                                     29 ; default segment ordering for linker
                                     30 	.area HOME
                                     31 	.area GSINIT
                                     32 	.area GSFINAL
                                     33 	.area CONST
                                     34 	.area INITIALIZER
                                     35 	.area CODE
                                     36 
                                     37 ;--------------------------------------------------------
                                     38 ; global & static initialisations
                                     39 ;--------------------------------------------------------
                                     40 	.area HOME
                                     41 	.area GSINIT
                                     42 	.area GSFINAL
                                     43 	.area GSINIT
                                     44 ;--------------------------------------------------------
                                     45 ; Home
                                     46 ;--------------------------------------------------------
                                     47 	.area HOME
                                     48 	.area HOME
                                     49 ;--------------------------------------------------------
                                     50 ; code
                                     51 ;--------------------------------------------------------
                                     52 	.area CODE
                                     53 ;	./src/flash.c: 3: void eeprom_unlock() {
                                     54 ;	-----------------------------------------
                                     55 ;	 function eeprom_unlock
                                     56 ;	-----------------------------------------
      00846F                         57 _eeprom_unlock:
                                     58 ;	./src/flash.c: 4: if (!(FLASH_IAPSR & 0x02))
      00846F 72 02 50 5F 08   [ 2]   59 	btjt	0x505f, #1, 00103$
                                     60 ;	./src/flash.c: 7: FLASH_DUKR = 0xAE;
      008474 35 AE 50 64      [ 1]   61 	mov	0x5064+0, #0xae
                                     62 ;	./src/flash.c: 8: FLASH_DUKR = 0x56;
      008478 35 56 50 64      [ 1]   63 	mov	0x5064+0, #0x56
                                     64 ;	./src/flash.c: 11: while (!(FLASH_IAPSR & DUL));
      00847C                         65 00103$:
      00847C 72 07 50 5F FB   [ 2]   66 	btjf	0x505f, #3, 00103$
                                     67 ;	./src/flash.c: 12: }
      008481 81               [ 4]   68 	ret
                                     69 ;	./src/flash.c: 14: void eeprom_lock() {
                                     70 ;	-----------------------------------------
                                     71 ;	 function eeprom_lock
                                     72 ;	-----------------------------------------
      008482                         73 _eeprom_lock:
                                     74 ;	./src/flash.c: 15: FLASH_IAPSR &= ~(DUL);
      008482 72 17 50 5F      [ 1]   75 	bres	0x505f, #3
                                     76 ;	./src/flash.c: 16: }
      008486 81               [ 4]   77 	ret
                                     78 ;	./src/flash.c: 18: void eeprom_clear_all() {
                                     79 ;	-----------------------------------------
                                     80 ;	 function eeprom_clear_all
                                     81 ;	-----------------------------------------
      008487                         82 _eeprom_clear_all:
                                     83 ;	./src/flash.c: 19: for(int c = 0; c < 639; c++) {
      008487 5F               [ 1]   84 	clrw	x
      008488                         85 00103$:
      008488 A3 02 7F         [ 2]   86 	cpw	x, #0x027f
      00848B 2F 01            [ 1]   87 	jrslt	00118$
      00848D 81               [ 4]   88 	ret
      00848E                         89 00118$:
                                     90 ;	./src/flash.c: 20: eeprom_write(c, 0);
      00848E 90 93            [ 1]   91 	ldw	y, x
      008490 89               [ 2]   92 	pushw	x
      008491 4F               [ 1]   93 	clr	a
      008492 93               [ 1]   94 	ldw	x, y
      008493 CD 84 9B         [ 4]   95 	call	_eeprom_write
      008496 85               [ 2]   96 	popw	x
                                     97 ;	./src/flash.c: 19: for(int c = 0; c < 639; c++) {
      008497 5C               [ 1]   98 	incw	x
      008498 20 EE            [ 2]   99 	jra	00103$
                                    100 ;	./src/flash.c: 22: }
      00849A 81               [ 4]  101 	ret
                                    102 ;	./src/flash.c: 24: void eeprom_write(uint16_t mem_cell, uint8_t data) {
                                    103 ;	-----------------------------------------
                                    104 ;	 function eeprom_write
                                    105 ;	-----------------------------------------
      00849B                        106 _eeprom_write:
      00849B 88               [ 1]  107 	push	a
      00849C 6B 01            [ 1]  108 	ld	(0x01, sp), a
                                    109 ;	./src/flash.c: 25: eeprom_unlock();
      00849E 89               [ 2]  110 	pushw	x
      00849F CD 84 6F         [ 4]  111 	call	_eeprom_unlock
      0084A2 85               [ 2]  112 	popw	x
                                    113 ;	./src/flash.c: 27: while (!(FLASH_IAPSR & DUL));
      0084A3                        114 00101$:
      0084A3 C6 50 5F         [ 1]  115 	ld	a, 0x505f
      0084A6 A5 08            [ 1]  116 	bcp	a, #0x08
      0084A8 27 F9            [ 1]  117 	jreq	00101$
                                    118 ;	./src/flash.c: 30: addr = (uint8_t *)(EEPROM_FIRST_ADDR + mem_cell); //Initialize  pointer
      0084AA 1C 40 00         [ 2]  119 	addw	x, #0x4000
                                    120 ;	./src/flash.c: 32: __asm sim __endasm; // Disable interrupts
      0084AD 9B               [ 1]  121 	sim	
                                    122 ;	./src/flash.c: 33: *addr = data;
      0084AE 7B 01            [ 1]  123 	ld	a, (0x01, sp)
      0084B0 F7               [ 1]  124 	ld	(x), a
                                    125 ;	./src/flash.c: 34: while(EOP != (~FLASH_IAPSR & EOP)); // Wait for writing to complete
      0084B1                        126 00104$:
      0084B1 C6 50 5F         [ 1]  127 	ld	a, 0x505f
      0084B4 5F               [ 1]  128 	clrw	x
      0084B5 97               [ 1]  129 	ld	xl, a
      0084B6 53               [ 2]  130 	cplw	x
      0084B7 9F               [ 1]  131 	ld	a, xl
      0084B8 A4 04            [ 1]  132 	and	a, #0x04
      0084BA 97               [ 1]  133 	ld	xl, a
      0084BB 4F               [ 1]  134 	clr	a
      0084BC 95               [ 1]  135 	ld	xh, a
      0084BD A3 00 04         [ 2]  136 	cpw	x, #0x0004
      0084C0 26 EF            [ 1]  137 	jrne	00104$
                                    138 ;	./src/flash.c: 35: __asm rim __endasm; // Enable interrupts
      0084C2 9A               [ 1]  139 	rim	
                                    140 ;	./src/flash.c: 37: eeprom_lock();
      0084C3 84               [ 1]  141 	pop	a
      0084C4 CC 84 82         [ 2]  142 	jp	_eeprom_lock
                                    143 ;	./src/flash.c: 38: }
      0084C7 84               [ 1]  144 	pop	a
      0084C8 81               [ 4]  145 	ret
                                    146 ;	./src/flash.c: 40: void eeprom_read(uint16_t mem_cell, uint8_t *data) {
                                    147 ;	-----------------------------------------
                                    148 ;	 function eeprom_read
                                    149 ;	-----------------------------------------
      0084C9                        150 _eeprom_read:
                                    151 ;	./src/flash.c: 42: addr = (uint8_t *)(EEPROM_FIRST_ADDR + mem_cell);
      0084C9 1C 40 00         [ 2]  152 	addw	x, #0x4000
                                    153 ;	./src/flash.c: 44: __asm sim __endasm;
      0084CC 9B               [ 1]  154 	sim	
                                    155 ;	./src/flash.c: 45: *data = *addr;
      0084CD 16 03            [ 2]  156 	ldw	y, (0x03, sp)
      0084CF F6               [ 1]  157 	ld	a, (x)
      0084D0 90 F7            [ 1]  158 	ld	(y), a
                                    159 ;	./src/flash.c: 46: while(EOP != (~FLASH_IAPSR & EOP));
      0084D2                        160 00101$:
      0084D2 C6 50 5F         [ 1]  161 	ld	a, 0x505f
      0084D5 5F               [ 1]  162 	clrw	x
      0084D6 97               [ 1]  163 	ld	xl, a
      0084D7 53               [ 2]  164 	cplw	x
      0084D8 9F               [ 1]  165 	ld	a, xl
      0084D9 A4 04            [ 1]  166 	and	a, #0x04
      0084DB 97               [ 1]  167 	ld	xl, a
      0084DC 4F               [ 1]  168 	clr	a
      0084DD 95               [ 1]  169 	ld	xh, a
      0084DE A3 00 04         [ 2]  170 	cpw	x, #0x0004
      0084E1 26 EF            [ 1]  171 	jrne	00101$
                                    172 ;	./src/flash.c: 47: __asm rim __endasm;
      0084E3 9A               [ 1]  173 	rim	
                                    174 ;	./src/flash.c: 48: }
      0084E4 1E 01            [ 2]  175 	ldw	x, (1, sp)
      0084E6 5B 04            [ 2]  176 	addw	sp, #4
      0084E8 FC               [ 2]  177 	jp	(x)
                                    178 	.area CODE
                                    179 	.area CONST
                                    180 	.area INITIALIZER
                                    181 	.area CABS (ABS)
