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
                                     11 	.globl _eeprom_read
                                     12 	.globl _eeprom_write
                                     13 	.globl _sqrtf
                                     14 	.globl _expf
                                     15 	.globl _normalize_from
                                     16 	.globl _write_color_to_registers
                                     17 	.globl _smart_increment
                                     18 	.globl _smart_decrement
                                     19 	.globl _load_color_from_eeprom
                                     20 	.globl _write_color_to_eeprom
                                     21 ;--------------------------------------------------------
                                     22 ; ram data
                                     23 ;--------------------------------------------------------
                                     24 	.area DATA
                                     25 ;--------------------------------------------------------
                                     26 ; ram data
                                     27 ;--------------------------------------------------------
                                     28 	.area INITIALIZED
                                     29 ;--------------------------------------------------------
                                     30 ; absolute external ram data
                                     31 ;--------------------------------------------------------
                                     32 	.area DABS (ABS)
                                     33 
                                     34 ; default segment ordering for linker
                                     35 	.area HOME
                                     36 	.area GSINIT
                                     37 	.area GSFINAL
                                     38 	.area CONST
                                     39 	.area INITIALIZER
                                     40 	.area CODE
                                     41 
                                     42 ;--------------------------------------------------------
                                     43 ; global & static initialisations
                                     44 ;--------------------------------------------------------
                                     45 	.area HOME
                                     46 	.area GSINIT
                                     47 	.area GSFINAL
                                     48 	.area GSINIT
                                     49 ;--------------------------------------------------------
                                     50 ; Home
                                     51 ;--------------------------------------------------------
                                     52 	.area HOME
                                     53 	.area HOME
                                     54 ;--------------------------------------------------------
                                     55 ; code
                                     56 ;--------------------------------------------------------
                                     57 	.area CODE
                                     58 ;	./src/color.c: 3: uint16_t normalize_from(uint8_t *val) {
                                     59 ;	-----------------------------------------
                                     60 ;	 function normalize_from
                                     61 ;	-----------------------------------------
      00813E                         62 _normalize_from:
                                     63 ;	./src/color.c: 4: float tmp1 = *val;
      00813E F6               [ 1]   64 	ld	a, (x)
      00813F CD 90 4F         [ 4]   65 	call	___uchar2fs
                                     66 ;	./src/color.c: 5: float tmp2 = sqrtf(10 * tmp1) / 5;
      008142 89               [ 2]   67 	pushw	x
      008143 90 89            [ 2]   68 	pushw	y
      008145 5F               [ 1]   69 	clrw	x
      008146 89               [ 2]   70 	pushw	x
      008147 4B 20            [ 1]   71 	push	#0x20
      008149 4B 41            [ 1]   72 	push	#0x41
      00814B CD 85 73         [ 4]   73 	call	___fsmul
      00814E 89               [ 2]   74 	pushw	x
      00814F 90 89            [ 2]   75 	pushw	y
      008151 CD 87 2D         [ 4]   76 	call	_sqrtf
      008154 4B 00            [ 1]   77 	push	#0x00
      008156 4B 00            [ 1]   78 	push	#0x00
      008158 4B A0            [ 1]   79 	push	#0xa0
      00815A 4B 40            [ 1]   80 	push	#0x40
      00815C 89               [ 2]   81 	pushw	x
      00815D 90 89            [ 2]   82 	pushw	y
      00815F CD 8F D6         [ 4]   83 	call	___fsdiv
                                     84 ;	./src/color.c: 6: return (expf(tmp2));
      008162 89               [ 2]   85 	pushw	x
      008163 90 89            [ 2]   86 	pushw	y
      008165 CD 88 2B         [ 4]   87 	call	_expf
      008168 89               [ 2]   88 	pushw	x
      008169 90 89            [ 2]   89 	pushw	y
      00816B CD 8D 82         [ 4]   90 	call	___fs2uint
                                     91 ;	./src/color.c: 7: }
      00816E 81               [ 4]   92 	ret
                                     93 ;	./src/color.c: 10: void write_color_to_registers(struct Color *color) {
                                     94 ;	-----------------------------------------
                                     95 ;	 function write_color_to_registers
                                     96 ;	-----------------------------------------
      00816F                         97 _write_color_to_registers:
      00816F 52 06            [ 2]   98 	sub	sp, #6
                                     99 ;	./src/color.c: 11: uint16_t red = normalize_from( &color->r );
      008171 1F 05            [ 2]  100 	ldw	(0x05, sp), x
      008173 CD 81 3E         [ 4]  101 	call	_normalize_from
      008176 1F 01            [ 2]  102 	ldw	(0x01, sp), x
                                    103 ;	./src/color.c: 12: uint16_t green = normalize_from( &color->g );
      008178 1E 05            [ 2]  104 	ldw	x, (0x05, sp)
      00817A 5C               [ 1]  105 	incw	x
      00817B CD 81 3E         [ 4]  106 	call	_normalize_from
      00817E 1F 03            [ 2]  107 	ldw	(0x03, sp), x
                                    108 ;	./src/color.c: 13: uint16_t blue = normalize_from( &color->b );
      008180 1E 05            [ 2]  109 	ldw	x, (0x05, sp)
      008182 5C               [ 1]  110 	incw	x
      008183 5C               [ 1]  111 	incw	x
      008184 CD 81 3E         [ 4]  112 	call	_normalize_from
                                    113 ;	./src/color.c: 15: TIM2_CCR2H = red >> 8;
      008187 7B 01            [ 1]  114 	ld	a, (0x01, sp)
      008189 C7 53 13         [ 1]  115 	ld	0x5313, a
                                    116 ;	./src/color.c: 16: TIM2_CCR2L = red;
      00818C 7B 02            [ 1]  117 	ld	a, (0x02, sp)
      00818E C7 53 14         [ 1]  118 	ld	0x5314, a
                                    119 ;	./src/color.c: 18: TIM2_CCR1H = green >> 8;
      008191 7B 03            [ 1]  120 	ld	a, (0x03, sp)
      008193 C7 53 11         [ 1]  121 	ld	0x5311, a
                                    122 ;	./src/color.c: 19: TIM2_CCR1L = green;
      008196 7B 04            [ 1]  123 	ld	a, (0x04, sp)
      008198 C7 53 12         [ 1]  124 	ld	0x5312, a
                                    125 ;	./src/color.c: 21: TIM2_CCR3H = blue >> 8;
      00819B 9E               [ 1]  126 	ld	a, xh
      00819C C7 53 15         [ 1]  127 	ld	0x5315, a
                                    128 ;	./src/color.c: 22: TIM2_CCR3L = blue;
      00819F 9F               [ 1]  129 	ld	a, xl
      0081A0 C7 53 16         [ 1]  130 	ld	0x5316, a
                                    131 ;	./src/color.c: 23: }
      0081A3 5B 06            [ 2]  132 	addw	sp, #6
      0081A5 81               [ 4]  133 	ret
                                    134 ;	./src/color.c: 25: void smart_increment(uint8_t *val) {
                                    135 ;	-----------------------------------------
                                    136 ;	 function smart_increment
                                    137 ;	-----------------------------------------
      0081A6                        138 _smart_increment:
                                    139 ;	./src/color.c: 26: if(*val < 255) {
      0081A6 F6               [ 1]  140 	ld	a, (x)
      0081A7 A1 FF            [ 1]  141 	cp	a, #0xff
      0081A9 25 01            [ 1]  142 	jrc	00110$
      0081AB 81               [ 4]  143 	ret
      0081AC                        144 00110$:
                                    145 ;	./src/color.c: 27: *val += 1;
      0081AC 4C               [ 1]  146 	inc	a
      0081AD F7               [ 1]  147 	ld	(x), a
                                    148 ;	./src/color.c: 29: }
      0081AE 81               [ 4]  149 	ret
                                    150 ;	./src/color.c: 31: void smart_decrement(uint8_t *val) {
                                    151 ;	-----------------------------------------
                                    152 ;	 function smart_decrement
                                    153 ;	-----------------------------------------
      0081AF                        154 _smart_decrement:
                                    155 ;	./src/color.c: 32: if(*val > 0) {
      0081AF F6               [ 1]  156 	ld	a, (x)
      0081B0 26 01            [ 1]  157 	jrne	00110$
      0081B2 81               [ 4]  158 	ret
      0081B3                        159 00110$:
                                    160 ;	./src/color.c: 33: *val -= 1;
      0081B3 4A               [ 1]  161 	dec	a
      0081B4 F7               [ 1]  162 	ld	(x), a
                                    163 ;	./src/color.c: 35: }
      0081B5 81               [ 4]  164 	ret
                                    165 ;	./src/color.c: 37: void load_color_from_eeprom(struct Color *color, uint8_t color_cell) {
                                    166 ;	-----------------------------------------
                                    167 ;	 function load_color_from_eeprom
                                    168 ;	-----------------------------------------
      0081B6                        169 _load_color_from_eeprom:
      0081B6 52 07            [ 2]  170 	sub	sp, #7
      0081B8 1F 06            [ 2]  171 	ldw	(0x06, sp), x
                                    172 ;	./src/color.c: 39: eeprom_read(3*color_cell+0, &r);
      0081BA 5F               [ 1]  173 	clrw	x
      0081BB 97               [ 1]  174 	ld	xl, a
      0081BC 89               [ 2]  175 	pushw	x
      0081BD 58               [ 2]  176 	sllw	x
      0081BE 72 FB 01         [ 2]  177 	addw	x, (1, sp)
      0081C1 5B 02            [ 2]  178 	addw	sp, #2
      0081C3 1F 04            [ 2]  179 	ldw	(0x04, sp), x
      0081C5 90 93            [ 1]  180 	ldw	y, x
      0081C7 96               [ 1]  181 	ldw	x, sp
      0081C8 5C               [ 1]  182 	incw	x
      0081C9 89               [ 2]  183 	pushw	x
      0081CA 93               [ 1]  184 	ldw	x, y
      0081CB CD 84 C9         [ 4]  185 	call	_eeprom_read
                                    186 ;	./src/color.c: 40: eeprom_read(3*color_cell+1, &g);
      0081CE 96               [ 1]  187 	ldw	x, sp
      0081CF 5C               [ 1]  188 	incw	x
      0081D0 5C               [ 1]  189 	incw	x
      0081D1 51               [ 1]  190 	exgw	x, y
      0081D2 1E 04            [ 2]  191 	ldw	x, (0x04, sp)
      0081D4 5C               [ 1]  192 	incw	x
      0081D5 90 89            [ 2]  193 	pushw	y
      0081D7 CD 84 C9         [ 4]  194 	call	_eeprom_read
                                    195 ;	./src/color.c: 41: eeprom_read(3*color_cell+2, &b);
      0081DA 96               [ 1]  196 	ldw	x, sp
      0081DB 1C 00 03         [ 2]  197 	addw	x, #3
      0081DE 16 04            [ 2]  198 	ldw	y, (0x04, sp)
      0081E0 72 A9 00 02      [ 2]  199 	addw	y, #0x0002
      0081E4 89               [ 2]  200 	pushw	x
      0081E5 93               [ 1]  201 	ldw	x, y
      0081E6 CD 84 C9         [ 4]  202 	call	_eeprom_read
                                    203 ;	./src/color.c: 43: color->r = r;
      0081E9 1E 06            [ 2]  204 	ldw	x, (0x06, sp)
      0081EB 7B 01            [ 1]  205 	ld	a, (0x01, sp)
      0081ED F7               [ 1]  206 	ld	(x), a
                                    207 ;	./src/color.c: 44: color->g = g;
      0081EE 1E 06            [ 2]  208 	ldw	x, (0x06, sp)
      0081F0 5C               [ 1]  209 	incw	x
      0081F1 7B 02            [ 1]  210 	ld	a, (0x02, sp)
      0081F3 F7               [ 1]  211 	ld	(x), a
                                    212 ;	./src/color.c: 45: color->b = b;
      0081F4 1E 06            [ 2]  213 	ldw	x, (0x06, sp)
      0081F6 5C               [ 1]  214 	incw	x
      0081F7 5C               [ 1]  215 	incw	x
      0081F8 7B 03            [ 1]  216 	ld	a, (0x03, sp)
      0081FA F7               [ 1]  217 	ld	(x), a
                                    218 ;	./src/color.c: 46: }
      0081FB 5B 07            [ 2]  219 	addw	sp, #7
      0081FD 81               [ 4]  220 	ret
                                    221 ;	./src/color.c: 48: void write_color_to_eeprom(struct Color *color, uint8_t color_cell) {
                                    222 ;	-----------------------------------------
                                    223 ;	 function write_color_to_eeprom
                                    224 ;	-----------------------------------------
      0081FE                        225 _write_color_to_eeprom:
      0081FE 52 04            [ 2]  226 	sub	sp, #4
      008200 1F 03            [ 2]  227 	ldw	(0x03, sp), x
      008202 90 97            [ 1]  228 	ld	yl, a
                                    229 ;	./src/color.c: 49: eeprom_write(3*color_cell+0, color->r);
      008204 1E 03            [ 2]  230 	ldw	x, (0x03, sp)
      008206 F6               [ 1]  231 	ld	a, (x)
      008207 5F               [ 1]  232 	clrw	x
      008208 41               [ 1]  233 	exg	a, xl
      008209 90 9F            [ 1]  234 	ld	a, yl
      00820B 41               [ 1]  235 	exg	a, xl
      00820C 89               [ 2]  236 	pushw	x
      00820D 58               [ 2]  237 	sllw	x
      00820E 72 FB 01         [ 2]  238 	addw	x, (1, sp)
      008211 5B 02            [ 2]  239 	addw	sp, #2
      008213 1F 01            [ 2]  240 	ldw	(0x01, sp), x
      008215 CD 84 9B         [ 4]  241 	call	_eeprom_write
                                    242 ;	./src/color.c: 50: eeprom_write(3*color_cell+1, color->g);
      008218 1E 03            [ 2]  243 	ldw	x, (0x03, sp)
      00821A E6 01            [ 1]  244 	ld	a, (0x1, x)
      00821C 1E 01            [ 2]  245 	ldw	x, (0x01, sp)
      00821E 5C               [ 1]  246 	incw	x
      00821F CD 84 9B         [ 4]  247 	call	_eeprom_write
                                    248 ;	./src/color.c: 51: eeprom_write(3*color_cell+2, color->b);
      008222 1E 03            [ 2]  249 	ldw	x, (0x03, sp)
      008224 E6 02            [ 1]  250 	ld	a, (0x2, x)
      008226 1E 01            [ 2]  251 	ldw	x, (0x01, sp)
      008228 5C               [ 1]  252 	incw	x
      008229 5C               [ 1]  253 	incw	x
      00822A 5B 04            [ 2]  254 	addw	sp, #4
                                    255 ;	./src/color.c: 52: }
      00822C CC 84 9B         [ 2]  256 	jp	_eeprom_write
                                    257 	.area CODE
                                    258 	.area CONST
                                    259 	.area INITIALIZER
                                    260 	.area CABS (ABS)
