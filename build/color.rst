                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.2.0 #13081 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module color
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _sqrtf
                                     12 	.globl _expf
                                     13 	.globl _normalize_from
                                     14 	.globl _write_color_to_registers
                                     15 	.globl _smart_increment
                                     16 	.globl _smart_decrement
                                     17 ;--------------------------------------------------------
                                     18 ; ram data
                                     19 ;--------------------------------------------------------
                                     20 	.area DATA
                                     21 ;--------------------------------------------------------
                                     22 ; ram data
                                     23 ;--------------------------------------------------------
                                     24 	.area INITIALIZED
                                     25 ;--------------------------------------------------------
                                     26 ; absolute external ram data
                                     27 ;--------------------------------------------------------
                                     28 	.area DABS (ABS)
                                     29 
                                     30 ; default segment ordering for linker
                                     31 	.area HOME
                                     32 	.area GSINIT
                                     33 	.area GSFINAL
                                     34 	.area CONST
                                     35 	.area INITIALIZER
                                     36 	.area CODE
                                     37 
                                     38 ;--------------------------------------------------------
                                     39 ; global & static initialisations
                                     40 ;--------------------------------------------------------
                                     41 	.area HOME
                                     42 	.area GSINIT
                                     43 	.area GSFINAL
                                     44 	.area GSINIT
                                     45 ;--------------------------------------------------------
                                     46 ; Home
                                     47 ;--------------------------------------------------------
                                     48 	.area HOME
                                     49 	.area HOME
                                     50 ;--------------------------------------------------------
                                     51 ; code
                                     52 ;--------------------------------------------------------
                                     53 	.area CODE
                                     54 ;	./src/color.c: 3: uint16_t normalize_from(uint8_t *val) {
                                     55 ;	-----------------------------------------
                                     56 ;	 function normalize_from
                                     57 ;	-----------------------------------------
      008107                         58 _normalize_from:
                                     59 ;	./src/color.c: 4: float tmp1 = *val;
      008107 F6               [ 1]   60 	ld	a, (x)
      008108 CD 8D 0F         [ 4]   61 	call	___uchar2fs
                                     62 ;	./src/color.c: 5: float tmp2 = sqrtf(10 * tmp1) / 5;
      00810B 89               [ 2]   63 	pushw	x
      00810C 90 89            [ 2]   64 	pushw	y
      00810E 5F               [ 1]   65 	clrw	x
      00810F 89               [ 2]   66 	pushw	x
      008110 4B 20            [ 1]   67 	push	#0x20
      008112 4B 41            [ 1]   68 	push	#0x41
      008114 CD 82 86         [ 4]   69 	call	___fsmul
      008117 89               [ 2]   70 	pushw	x
      008118 90 89            [ 2]   71 	pushw	y
      00811A CD 84 40         [ 4]   72 	call	_sqrtf
      00811D 4B 00            [ 1]   73 	push	#0x00
      00811F 4B 00            [ 1]   74 	push	#0x00
      008121 4B A0            [ 1]   75 	push	#0xa0
      008123 4B 40            [ 1]   76 	push	#0x40
      008125 89               [ 2]   77 	pushw	x
      008126 90 89            [ 2]   78 	pushw	y
      008128 CD 8C 96         [ 4]   79 	call	___fsdiv
                                     80 ;	./src/color.c: 6: return (expf(tmp2));
      00812B 89               [ 2]   81 	pushw	x
      00812C 90 89            [ 2]   82 	pushw	y
      00812E CD 85 3E         [ 4]   83 	call	_expf
      008131 89               [ 2]   84 	pushw	x
      008132 90 89            [ 2]   85 	pushw	y
      008134 CD 8A 95         [ 4]   86 	call	___fs2uint
                                     87 ;	./src/color.c: 7: }
      008137 81               [ 4]   88 	ret
                                     89 ;	./src/color.c: 10: void write_color_to_registers(struct Color *color) {
                                     90 ;	-----------------------------------------
                                     91 ;	 function write_color_to_registers
                                     92 ;	-----------------------------------------
      008138                         93 _write_color_to_registers:
      008138 52 06            [ 2]   94 	sub	sp, #6
                                     95 ;	./src/color.c: 11: uint16_t red = normalize_from( &color->r );
      00813A 1F 05            [ 2]   96 	ldw	(0x05, sp), x
      00813C CD 81 07         [ 4]   97 	call	_normalize_from
      00813F 1F 01            [ 2]   98 	ldw	(0x01, sp), x
                                     99 ;	./src/color.c: 12: uint16_t green = normalize_from( &color->g );
      008141 1E 05            [ 2]  100 	ldw	x, (0x05, sp)
      008143 5C               [ 1]  101 	incw	x
      008144 CD 81 07         [ 4]  102 	call	_normalize_from
      008147 1F 03            [ 2]  103 	ldw	(0x03, sp), x
                                    104 ;	./src/color.c: 13: uint16_t blue = normalize_from( &color->b );
      008149 1E 05            [ 2]  105 	ldw	x, (0x05, sp)
      00814B 5C               [ 1]  106 	incw	x
      00814C 5C               [ 1]  107 	incw	x
      00814D CD 81 07         [ 4]  108 	call	_normalize_from
                                    109 ;	./src/color.c: 15: TIM2_CCR1H = red >> 8;
      008150 7B 01            [ 1]  110 	ld	a, (0x01, sp)
      008152 C7 53 11         [ 1]  111 	ld	0x5311, a
                                    112 ;	./src/color.c: 16: TIM2_CCR1L = red;
      008155 7B 02            [ 1]  113 	ld	a, (0x02, sp)
      008157 C7 53 12         [ 1]  114 	ld	0x5312, a
                                    115 ;	./src/color.c: 18: TIM2_CCR2H = green >> 8;
      00815A 7B 03            [ 1]  116 	ld	a, (0x03, sp)
      00815C C7 53 13         [ 1]  117 	ld	0x5313, a
                                    118 ;	./src/color.c: 19: TIM2_CCR2L = green;
      00815F 7B 04            [ 1]  119 	ld	a, (0x04, sp)
      008161 C7 53 14         [ 1]  120 	ld	0x5314, a
                                    121 ;	./src/color.c: 21: TIM2_CCR3H = blue >> 8;
      008164 9E               [ 1]  122 	ld	a, xh
      008165 C7 53 15         [ 1]  123 	ld	0x5315, a
                                    124 ;	./src/color.c: 22: TIM2_CCR3L = blue;
      008168 9F               [ 1]  125 	ld	a, xl
      008169 C7 53 16         [ 1]  126 	ld	0x5316, a
                                    127 ;	./src/color.c: 23: }
      00816C 5B 06            [ 2]  128 	addw	sp, #6
      00816E 81               [ 4]  129 	ret
                                    130 ;	./src/color.c: 25: void smart_increment(uint8_t *val) {
                                    131 ;	-----------------------------------------
                                    132 ;	 function smart_increment
                                    133 ;	-----------------------------------------
      00816F                        134 _smart_increment:
                                    135 ;	./src/color.c: 26: if(*val < 255) {
      00816F F6               [ 1]  136 	ld	a, (x)
      008170 A1 FF            [ 1]  137 	cp	a, #0xff
      008172 25 01            [ 1]  138 	jrc	00110$
      008174 81               [ 4]  139 	ret
      008175                        140 00110$:
                                    141 ;	./src/color.c: 27: *val += 1;
      008175 4C               [ 1]  142 	inc	a
      008176 F7               [ 1]  143 	ld	(x), a
                                    144 ;	./src/color.c: 29: }
      008177 81               [ 4]  145 	ret
                                    146 ;	./src/color.c: 31: void smart_decrement(uint8_t *val) {
                                    147 ;	-----------------------------------------
                                    148 ;	 function smart_decrement
                                    149 ;	-----------------------------------------
      008178                        150 _smart_decrement:
                                    151 ;	./src/color.c: 32: if(*val > 0) {
      008178 F6               [ 1]  152 	ld	a, (x)
      008179 26 01            [ 1]  153 	jrne	00110$
      00817B 81               [ 4]  154 	ret
      00817C                        155 00110$:
                                    156 ;	./src/color.c: 33: *val -= 1;
      00817C 4A               [ 1]  157 	dec	a
      00817D F7               [ 1]  158 	ld	(x), a
                                    159 ;	./src/color.c: 35: }
      00817E 81               [ 4]  160 	ret
                                    161 	.area CODE
                                    162 	.area CONST
                                    163 	.area INITIALIZER
                                    164 	.area CABS (ABS)
