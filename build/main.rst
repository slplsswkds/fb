                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.2.0 #13081 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module main
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _main
                                     12 	.globl _smart_decrement
                                     13 	.globl _smart_increment
                                     14 	.globl _write_color_to_registers
                                     15 	.globl _tim2_init
                                     16 	.globl _gpio_init
                                     17 	.globl _clk_init
                                     18 	.globl _button_hundler
                                     19 ;--------------------------------------------------------
                                     20 ; ram data
                                     21 ;--------------------------------------------------------
                                     22 	.area DATA
                                     23 ;--------------------------------------------------------
                                     24 ; ram data
                                     25 ;--------------------------------------------------------
                                     26 	.area INITIALIZED
                                     27 ;--------------------------------------------------------
                                     28 ; Stack segment in internal ram
                                     29 ;--------------------------------------------------------
                                     30 	.area	SSEG
      000003                         31 __start__stack:
      000003                         32 	.ds	1
                                     33 
                                     34 ;--------------------------------------------------------
                                     35 ; absolute external ram data
                                     36 ;--------------------------------------------------------
                                     37 	.area DABS (ABS)
                                     38 
                                     39 ; default segment ordering for linker
                                     40 	.area HOME
                                     41 	.area GSINIT
                                     42 	.area GSFINAL
                                     43 	.area CONST
                                     44 	.area INITIALIZER
                                     45 	.area CODE
                                     46 
                                     47 ;--------------------------------------------------------
                                     48 ; interrupt vector
                                     49 ;--------------------------------------------------------
                                     50 	.area HOME
      008000                         51 __interrupt_vect:
      008000 82 00 80 07             52 	int s_GSINIT ; reset
                                     53 ;--------------------------------------------------------
                                     54 ; global & static initialisations
                                     55 ;--------------------------------------------------------
                                     56 	.area HOME
                                     57 	.area GSINIT
                                     58 	.area GSFINAL
                                     59 	.area GSINIT
      008007                         60 __sdcc_init_data:
                                     61 ; stm8_genXINIT() start
      008007 AE 00 02         [ 2]   62 	ldw x, #l_DATA
      00800A 27 07            [ 1]   63 	jreq	00002$
      00800C                         64 00001$:
      00800C 72 4F 00 00      [ 1]   65 	clr (s_DATA - 1, x)
      008010 5A               [ 2]   66 	decw x
      008011 26 F9            [ 1]   67 	jrne	00001$
      008013                         68 00002$:
      008013 AE 00 00         [ 2]   69 	ldw	x, #l_INITIALIZER
      008016 27 09            [ 1]   70 	jreq	00004$
      008018                         71 00003$:
      008018 D6 80 23         [ 1]   72 	ld	a, (s_INITIALIZER - 1, x)
      00801B D7 00 02         [ 1]   73 	ld	(s_INITIALIZED - 1, x), a
      00801E 5A               [ 2]   74 	decw	x
      00801F 26 F7            [ 1]   75 	jrne	00003$
      008021                         76 00004$:
                                     77 ; stm8_genXINIT() end
                                     78 	.area GSFINAL
      008021 CC 80 04         [ 2]   79 	jp	__sdcc_program_startup
                                     80 ;--------------------------------------------------------
                                     81 ; Home
                                     82 ;--------------------------------------------------------
                                     83 	.area HOME
                                     84 	.area HOME
      008004                         85 __sdcc_program_startup:
      008004 CC 80 2C         [ 2]   86 	jp	_main
                                     87 ;	return from main will return to caller
                                     88 ;--------------------------------------------------------
                                     89 ; code
                                     90 ;--------------------------------------------------------
                                     91 	.area CODE
                                     92 ;	main.c: 19: static void delay(uint16_t t) {
                                     93 ;	-----------------------------------------
                                     94 ;	 function delay
                                     95 ;	-----------------------------------------
      008024                         96 _delay:
                                     97 ;	main.c: 20: while(t--) {};
      008024                         98 00101$:
      008024 90 93            [ 1]   99 	ldw	y, x
      008026 5A               [ 2]  100 	decw	x
      008027 90 5D            [ 2]  101 	tnzw	y
      008029 26 F9            [ 1]  102 	jrne	00101$
                                    103 ;	main.c: 21: }
      00802B 81               [ 4]  104 	ret
                                    105 ;	main.c: 23: int main() {
                                    106 ;	-----------------------------------------
                                    107 ;	 function main
                                    108 ;	-----------------------------------------
      00802C                        109 _main:
      00802C 52 03            [ 2]  110 	sub	sp, #3
                                    111 ;	main.c: 24: do { __asm sim __endasm; } while(0); // Disable interrupts
      00802E 9B               [ 1]  112 	sim	
                                    113 ;	main.c: 26: clk_init();
      00802F CD 82 6B         [ 4]  114 	call	_clk_init
                                    115 ;	main.c: 27: gpio_init();
      008032 CD 81 CA         [ 4]  116 	call	_gpio_init
                                    117 ;	main.c: 28: tim2_init();
      008035 CD 81 61         [ 4]  118 	call	_tim2_init
                                    119 ;	main.c: 30: do { __asm rim __endasm; } while(0); // Enable interrupts
      008038 9A               [ 1]  120 	rim	
                                    121 ;	main.c: 35: rgb.r = 0;
      008039 0F 01            [ 1]  122 	clr	(0x01, sp)
                                    123 ;	main.c: 36: rgb.g = 0;
      00803B 0F 02            [ 1]  124 	clr	(0x02, sp)
                                    125 ;	main.c: 37: rgb.b = 0;
      00803D 0F 03            [ 1]  126 	clr	(0x03, sp)
      00803F                        127 00108$:
                                    128 ;	main.c: 40: button_hundler(&rgb);
      00803F 96               [ 1]  129 	ldw	x, sp
      008040 5C               [ 1]  130 	incw	x
      008041 CD 80 4E         [ 4]  131 	call	_button_hundler
                                    132 ;	main.c: 41: write_color_to_registers(&rgb);
      008044 96               [ 1]  133 	ldw	x, sp
      008045 5C               [ 1]  134 	incw	x
      008046 CD 81 1A         [ 4]  135 	call	_write_color_to_registers
      008049 20 F4            [ 2]  136 	jra	00108$
                                    137 ;	main.c: 43: }
      00804B 5B 03            [ 2]  138 	addw	sp, #3
      00804D 81               [ 4]  139 	ret
                                    140 ;	main.c: 45: void button_hundler(struct Color *color) {
                                    141 ;	-----------------------------------------
                                    142 ;	 function button_hundler
                                    143 ;	-----------------------------------------
      00804E                        144 _button_hundler:
      00804E 52 04            [ 2]  145 	sub	sp, #4
      008050 1F 03            [ 2]  146 	ldw	(0x03, sp), x
                                    147 ;	main.c: 46: if((1 << 2) == (~PD_IDR & (1 << 2))) { // But_R+
      008052 C6 50 10         [ 1]  148 	ld	a, 0x5010
      008055 5F               [ 1]  149 	clrw	x
      008056 97               [ 1]  150 	ld	xl, a
      008057 53               [ 2]  151 	cplw	x
      008058 9F               [ 1]  152 	ld	a, xl
      008059 A4 04            [ 1]  153 	and	a, #0x04
      00805B 97               [ 1]  154 	ld	xl, a
      00805C 4F               [ 1]  155 	clr	a
      00805D 95               [ 1]  156 	ld	xh, a
      00805E A3 00 04         [ 2]  157 	cpw	x, #0x0004
      008061 26 05            [ 1]  158 	jrne	00102$
                                    159 ;	main.c: 47: smart_increment(&color->r);
      008063 1E 03            [ 2]  160 	ldw	x, (0x03, sp)
      008065 CD 81 51         [ 4]  161 	call	_smart_increment
      008068                        162 00102$:
                                    163 ;	main.c: 50: if((1 << 7) == (~PC_IDR & (1 << 7))) { // But_R-
      008068 C6 50 0B         [ 1]  164 	ld	a, 0x500b
      00806B 5F               [ 1]  165 	clrw	x
      00806C 97               [ 1]  166 	ld	xl, a
      00806D 53               [ 2]  167 	cplw	x
      00806E 9F               [ 1]  168 	ld	a, xl
      00806F A4 80            [ 1]  169 	and	a, #0x80
      008071 97               [ 1]  170 	ld	xl, a
      008072 4F               [ 1]  171 	clr	a
      008073 95               [ 1]  172 	ld	xh, a
      008074 A3 00 80         [ 2]  173 	cpw	x, #0x0080
      008077 26 05            [ 1]  174 	jrne	00104$
                                    175 ;	main.c: 51: smart_decrement(&color->r);
      008079 1E 03            [ 2]  176 	ldw	x, (0x03, sp)
      00807B CD 81 5A         [ 4]  177 	call	_smart_decrement
      00807E                        178 00104$:
                                    179 ;	main.c: 54: if((1 << 6) == (~PC_IDR & (1 << 6))) { // But_G+
      00807E C6 50 0B         [ 1]  180 	ld	a, 0x500b
      008081 5F               [ 1]  181 	clrw	x
      008082 97               [ 1]  182 	ld	xl, a
      008083 53               [ 2]  183 	cplw	x
      008084 9F               [ 1]  184 	ld	a, xl
      008085 A4 40            [ 1]  185 	and	a, #0x40
      008087 97               [ 1]  186 	ld	xl, a
      008088 4F               [ 1]  187 	clr	a
                                    188 ;	main.c: 55: smart_increment(&color->g);
      008089 16 03            [ 2]  189 	ldw	y, (0x03, sp)
      00808B 90 5C            [ 1]  190 	incw	y
      00808D 17 01            [ 2]  191 	ldw	(0x01, sp), y
                                    192 ;	main.c: 54: if((1 << 6) == (~PC_IDR & (1 << 6))) { // But_G+
      00808F 95               [ 1]  193 	ld	xh, a
      008090 A3 00 40         [ 2]  194 	cpw	x, #0x0040
      008093 26 05            [ 1]  195 	jrne	00106$
                                    196 ;	main.c: 55: smart_increment(&color->g);
      008095 1E 01            [ 2]  197 	ldw	x, (0x01, sp)
      008097 CD 81 51         [ 4]  198 	call	_smart_increment
      00809A                        199 00106$:
                                    200 ;	main.c: 58: if((1 << 5) == (~PC_IDR & (1 << 5))) { // But_G-
      00809A C6 50 0B         [ 1]  201 	ld	a, 0x500b
      00809D 5F               [ 1]  202 	clrw	x
      00809E 97               [ 1]  203 	ld	xl, a
      00809F 53               [ 2]  204 	cplw	x
      0080A0 9F               [ 1]  205 	ld	a, xl
      0080A1 A4 20            [ 1]  206 	and	a, #0x20
      0080A3 97               [ 1]  207 	ld	xl, a
      0080A4 4F               [ 1]  208 	clr	a
      0080A5 95               [ 1]  209 	ld	xh, a
      0080A6 A3 00 20         [ 2]  210 	cpw	x, #0x0020
      0080A9 26 05            [ 1]  211 	jrne	00108$
                                    212 ;	main.c: 59: smart_decrement(&color->g);
      0080AB 1E 01            [ 2]  213 	ldw	x, (0x01, sp)
      0080AD CD 81 5A         [ 4]  214 	call	_smart_decrement
      0080B0                        215 00108$:
                                    216 ;	main.c: 62: if((1 << 4) == (~PC_IDR & (1 << 4))) { // But_B+
      0080B0 C6 50 0B         [ 1]  217 	ld	a, 0x500b
      0080B3 5F               [ 1]  218 	clrw	x
      0080B4 97               [ 1]  219 	ld	xl, a
      0080B5 53               [ 2]  220 	cplw	x
      0080B6 90 5F            [ 1]  221 	clrw	y
      0080B8 9F               [ 1]  222 	ld	a, xl
      0080B9 A4 10            [ 1]  223 	and	a, #0x10
      0080BB 90 97            [ 1]  224 	ld	yl, a
                                    225 ;	main.c: 63: smart_increment(&color->b);
      0080BD 1E 03            [ 2]  226 	ldw	x, (0x03, sp)
      0080BF 5C               [ 1]  227 	incw	x
      0080C0 5C               [ 1]  228 	incw	x
      0080C1 1F 01            [ 2]  229 	ldw	(0x01, sp), x
                                    230 ;	main.c: 62: if((1 << 4) == (~PC_IDR & (1 << 4))) { // But_B+
      0080C3 90 A3 00 10      [ 2]  231 	cpw	y, #0x0010
      0080C7 26 05            [ 1]  232 	jrne	00110$
                                    233 ;	main.c: 63: smart_increment(&color->b);
      0080C9 1E 01            [ 2]  234 	ldw	x, (0x01, sp)
      0080CB CD 81 51         [ 4]  235 	call	_smart_increment
      0080CE                        236 00110$:
                                    237 ;	main.c: 66: if((1 << 3) == (~PC_IDR & (1 << 3))) { // But_B-
      0080CE C6 50 0B         [ 1]  238 	ld	a, 0x500b
      0080D1 5F               [ 1]  239 	clrw	x
      0080D2 97               [ 1]  240 	ld	xl, a
      0080D3 53               [ 2]  241 	cplw	x
      0080D4 9F               [ 1]  242 	ld	a, xl
      0080D5 A4 08            [ 1]  243 	and	a, #0x08
      0080D7 97               [ 1]  244 	ld	xl, a
      0080D8 4F               [ 1]  245 	clr	a
      0080D9 95               [ 1]  246 	ld	xh, a
      0080DA A3 00 08         [ 2]  247 	cpw	x, #0x0008
      0080DD 26 07            [ 1]  248 	jrne	00113$
                                    249 ;	main.c: 67: smart_decrement(&color->b);
      0080DF 1E 01            [ 2]  250 	ldw	x, (0x01, sp)
      0080E1 5B 04            [ 2]  251 	addw	sp, #4
      0080E3 CC 81 5A         [ 2]  252 	jp	_smart_decrement
      0080E6                        253 00113$:
                                    254 ;	main.c: 70: }
      0080E6 5B 04            [ 2]  255 	addw	sp, #4
      0080E8 81               [ 4]  256 	ret
                                    257 	.area CODE
                                    258 	.area CONST
                                    259 	.area INITIALIZER
                                    260 	.area CABS (ABS)
