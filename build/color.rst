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
                                     12 	.globl _sqrtf
                                     13 	.globl _expf
                                     14 	.globl _normalize_from
                                     15 	.globl _write_color_to_registers
                                     16 	.globl _smart_increment
                                     17 	.globl _smart_decrement
                                     18 	.globl _load_color_from_eeprom
                                     19 ;--------------------------------------------------------
                                     20 ; ram data
                                     21 ;--------------------------------------------------------
                                     22 	.area DATA
                                     23 ;--------------------------------------------------------
                                     24 ; ram data
                                     25 ;--------------------------------------------------------
                                     26 	.area INITIALIZED
                                     27 ;--------------------------------------------------------
                                     28 ; absolute external ram data
                                     29 ;--------------------------------------------------------
                                     30 	.area DABS (ABS)
                                     31 
                                     32 ; default segment ordering for linker
                                     33 	.area HOME
                                     34 	.area GSINIT
                                     35 	.area GSFINAL
                                     36 	.area CONST
                                     37 	.area INITIALIZER
                                     38 	.area CODE
                                     39 
                                     40 ;--------------------------------------------------------
                                     41 ; global & static initialisations
                                     42 ;--------------------------------------------------------
                                     43 	.area HOME
                                     44 	.area GSINIT
                                     45 	.area GSFINAL
                                     46 	.area GSINIT
                                     47 ;--------------------------------------------------------
                                     48 ; Home
                                     49 ;--------------------------------------------------------
                                     50 	.area HOME
                                     51 	.area HOME
                                     52 ;--------------------------------------------------------
                                     53 ; code
                                     54 ;--------------------------------------------------------
                                     55 	.area CODE
                                     56 ;	./src/color.c: 3: uint16_t normalize_from(uint8_t *val) {
                                     57 ;	-----------------------------------------
                                     58 ;	 function normalize_from
                                     59 ;	-----------------------------------------
      008160                         60 _normalize_from:
                                     61 ;	./src/color.c: 4: float tmp1 = *val;
      008160 F6               [ 1]   62 	ld	a, (x)
      008161 CD 8F ED         [ 4]   63 	call	___uchar2fs
                                     64 ;	./src/color.c: 5: float tmp2 = sqrtf(10 * tmp1) / 5;
      008164 89               [ 2]   65 	pushw	x
      008165 90 89            [ 2]   66 	pushw	y
      008167 5F               [ 1]   67 	clrw	x
      008168 89               [ 2]   68 	pushw	x
      008169 4B 20            [ 1]   69 	push	#0x20
      00816B 4B 41            [ 1]   70 	push	#0x41
      00816D CD 85 64         [ 4]   71 	call	___fsmul
      008170 89               [ 2]   72 	pushw	x
      008171 90 89            [ 2]   73 	pushw	y
      008173 CD 87 1E         [ 4]   74 	call	_sqrtf
      008176 4B 00            [ 1]   75 	push	#0x00
      008178 4B 00            [ 1]   76 	push	#0x00
      00817A 4B A0            [ 1]   77 	push	#0xa0
      00817C 4B 40            [ 1]   78 	push	#0x40
      00817E 89               [ 2]   79 	pushw	x
      00817F 90 89            [ 2]   80 	pushw	y
      008181 CD 8F 74         [ 4]   81 	call	___fsdiv
                                     82 ;	./src/color.c: 6: return (expf(tmp2));
      008184 89               [ 2]   83 	pushw	x
      008185 90 89            [ 2]   84 	pushw	y
      008187 CD 88 1C         [ 4]   85 	call	_expf
      00818A 89               [ 2]   86 	pushw	x
      00818B 90 89            [ 2]   87 	pushw	y
      00818D CD 8D 73         [ 4]   88 	call	___fs2uint
                                     89 ;	./src/color.c: 7: }
      008190 81               [ 4]   90 	ret
                                     91 ;	./src/color.c: 10: void write_color_to_registers(struct Color *color) {
                                     92 ;	-----------------------------------------
                                     93 ;	 function write_color_to_registers
                                     94 ;	-----------------------------------------
      008191                         95 _write_color_to_registers:
      008191 52 06            [ 2]   96 	sub	sp, #6
                                     97 ;	./src/color.c: 11: uint16_t red = normalize_from( &color->r );
      008193 1F 05            [ 2]   98 	ldw	(0x05, sp), x
      008195 CD 81 60         [ 4]   99 	call	_normalize_from
      008198 1F 01            [ 2]  100 	ldw	(0x01, sp), x
                                    101 ;	./src/color.c: 12: uint16_t green = normalize_from( &color->g );
      00819A 1E 05            [ 2]  102 	ldw	x, (0x05, sp)
      00819C 5C               [ 1]  103 	incw	x
      00819D CD 81 60         [ 4]  104 	call	_normalize_from
      0081A0 1F 03            [ 2]  105 	ldw	(0x03, sp), x
                                    106 ;	./src/color.c: 13: uint16_t blue = normalize_from( &color->b );
      0081A2 1E 05            [ 2]  107 	ldw	x, (0x05, sp)
      0081A4 5C               [ 1]  108 	incw	x
      0081A5 5C               [ 1]  109 	incw	x
      0081A6 CD 81 60         [ 4]  110 	call	_normalize_from
                                    111 ;	./src/color.c: 15: TIM2_CCR1H = red >> 8;
      0081A9 7B 01            [ 1]  112 	ld	a, (0x01, sp)
      0081AB C7 53 11         [ 1]  113 	ld	0x5311, a
                                    114 ;	./src/color.c: 16: TIM2_CCR1L = red;
      0081AE 7B 02            [ 1]  115 	ld	a, (0x02, sp)
      0081B0 C7 53 12         [ 1]  116 	ld	0x5312, a
                                    117 ;	./src/color.c: 18: TIM2_CCR2H = green >> 8;
      0081B3 7B 03            [ 1]  118 	ld	a, (0x03, sp)
      0081B5 C7 53 13         [ 1]  119 	ld	0x5313, a
                                    120 ;	./src/color.c: 19: TIM2_CCR2L = green;
      0081B8 7B 04            [ 1]  121 	ld	a, (0x04, sp)
      0081BA C7 53 14         [ 1]  122 	ld	0x5314, a
                                    123 ;	./src/color.c: 21: TIM2_CCR3H = blue >> 8;
      0081BD 9E               [ 1]  124 	ld	a, xh
      0081BE C7 53 15         [ 1]  125 	ld	0x5315, a
                                    126 ;	./src/color.c: 22: TIM2_CCR3L = blue;
      0081C1 9F               [ 1]  127 	ld	a, xl
      0081C2 C7 53 16         [ 1]  128 	ld	0x5316, a
                                    129 ;	./src/color.c: 23: }
      0081C5 5B 06            [ 2]  130 	addw	sp, #6
      0081C7 81               [ 4]  131 	ret
                                    132 ;	./src/color.c: 25: void smart_increment(uint8_t *val) {
                                    133 ;	-----------------------------------------
                                    134 ;	 function smart_increment
                                    135 ;	-----------------------------------------
      0081C8                        136 _smart_increment:
                                    137 ;	./src/color.c: 26: if(*val < 255) {
      0081C8 F6               [ 1]  138 	ld	a, (x)
      0081C9 A1 FF            [ 1]  139 	cp	a, #0xff
      0081CB 25 01            [ 1]  140 	jrc	00110$
      0081CD 81               [ 4]  141 	ret
      0081CE                        142 00110$:
                                    143 ;	./src/color.c: 27: *val += 1;
      0081CE 4C               [ 1]  144 	inc	a
      0081CF F7               [ 1]  145 	ld	(x), a
                                    146 ;	./src/color.c: 29: }
      0081D0 81               [ 4]  147 	ret
                                    148 ;	./src/color.c: 31: void smart_decrement(uint8_t *val) {
                                    149 ;	-----------------------------------------
                                    150 ;	 function smart_decrement
                                    151 ;	-----------------------------------------
      0081D1                        152 _smart_decrement:
                                    153 ;	./src/color.c: 32: if(*val > 0) {
      0081D1 F6               [ 1]  154 	ld	a, (x)
      0081D2 26 01            [ 1]  155 	jrne	00110$
      0081D4 81               [ 4]  156 	ret
      0081D5                        157 00110$:
                                    158 ;	./src/color.c: 33: *val -= 1;
      0081D5 4A               [ 1]  159 	dec	a
      0081D6 F7               [ 1]  160 	ld	(x), a
                                    161 ;	./src/color.c: 35: }
      0081D7 81               [ 4]  162 	ret
                                    163 ;	./src/color.c: 37: void load_color_from_eeprom(struct Color *color, uint8_t color_cell) {
                                    164 ;	-----------------------------------------
                                    165 ;	 function load_color_from_eeprom
                                    166 ;	-----------------------------------------
      0081D8                        167 _load_color_from_eeprom:
      0081D8 52 07            [ 2]  168 	sub	sp, #7
      0081DA 1F 06            [ 2]  169 	ldw	(0x06, sp), x
                                    170 ;	./src/color.c: 39: eeprom_read(3*color_cell+0, &r);
      0081DC 5F               [ 1]  171 	clrw	x
      0081DD 97               [ 1]  172 	ld	xl, a
      0081DE 89               [ 2]  173 	pushw	x
      0081DF 58               [ 2]  174 	sllw	x
      0081E0 72 FB 01         [ 2]  175 	addw	x, (1, sp)
      0081E3 5B 02            [ 2]  176 	addw	sp, #2
      0081E5 1F 04            [ 2]  177 	ldw	(0x04, sp), x
      0081E7 90 93            [ 1]  178 	ldw	y, x
      0081E9 96               [ 1]  179 	ldw	x, sp
      0081EA 5C               [ 1]  180 	incw	x
      0081EB 89               [ 2]  181 	pushw	x
      0081EC 93               [ 1]  182 	ldw	x, y
      0081ED CD 84 BA         [ 4]  183 	call	_eeprom_read
                                    184 ;	./src/color.c: 40: eeprom_read(3*color_cell+1, &g);
      0081F0 96               [ 1]  185 	ldw	x, sp
      0081F1 5C               [ 1]  186 	incw	x
      0081F2 5C               [ 1]  187 	incw	x
      0081F3 51               [ 1]  188 	exgw	x, y
      0081F4 1E 04            [ 2]  189 	ldw	x, (0x04, sp)
      0081F6 5C               [ 1]  190 	incw	x
      0081F7 90 89            [ 2]  191 	pushw	y
      0081F9 CD 84 BA         [ 4]  192 	call	_eeprom_read
                                    193 ;	./src/color.c: 41: eeprom_read(3*color_cell+2, &b);
      0081FC 96               [ 1]  194 	ldw	x, sp
      0081FD 1C 00 03         [ 2]  195 	addw	x, #3
      008200 16 04            [ 2]  196 	ldw	y, (0x04, sp)
      008202 72 A9 00 02      [ 2]  197 	addw	y, #0x0002
      008206 89               [ 2]  198 	pushw	x
      008207 93               [ 1]  199 	ldw	x, y
      008208 CD 84 BA         [ 4]  200 	call	_eeprom_read
                                    201 ;	./src/color.c: 43: color->r = r;
      00820B 1E 06            [ 2]  202 	ldw	x, (0x06, sp)
      00820D 7B 01            [ 1]  203 	ld	a, (0x01, sp)
      00820F F7               [ 1]  204 	ld	(x), a
                                    205 ;	./src/color.c: 44: color->g = g;
      008210 1E 06            [ 2]  206 	ldw	x, (0x06, sp)
      008212 5C               [ 1]  207 	incw	x
      008213 7B 02            [ 1]  208 	ld	a, (0x02, sp)
      008215 F7               [ 1]  209 	ld	(x), a
                                    210 ;	./src/color.c: 45: color->b = b;
      008216 1E 06            [ 2]  211 	ldw	x, (0x06, sp)
      008218 5C               [ 1]  212 	incw	x
      008219 5C               [ 1]  213 	incw	x
      00821A 7B 03            [ 1]  214 	ld	a, (0x03, sp)
      00821C F7               [ 1]  215 	ld	(x), a
                                    216 ;	./src/color.c: 46: }
      00821D 5B 07            [ 2]  217 	addw	sp, #7
      00821F 81               [ 4]  218 	ret
                                    219 	.area CODE
                                    220 	.area CONST
                                    221 	.area INITIALIZER
                                    222 	.area CABS (ABS)
