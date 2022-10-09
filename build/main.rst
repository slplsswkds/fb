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
                                     12 	.globl _write_to_eeprom
                                     13 	.globl _smart_decrement
                                     14 	.globl _smart_increment
                                     15 	.globl _write_color_to_registers
                                     16 	.globl _tim2_init
                                     17 	.globl _gpio_init
                                     18 	.globl _clk_init
                                     19 	.globl _button_hundler
                                     20 ;--------------------------------------------------------
                                     21 ; ram data
                                     22 ;--------------------------------------------------------
                                     23 	.area DATA
                                     24 ;--------------------------------------------------------
                                     25 ; ram data
                                     26 ;--------------------------------------------------------
                                     27 	.area INITIALIZED
                                     28 ;--------------------------------------------------------
                                     29 ; Stack segment in internal ram
                                     30 ;--------------------------------------------------------
                                     31 	.area	SSEG
      000003                         32 __start__stack:
      000003                         33 	.ds	1
                                     34 
                                     35 ;--------------------------------------------------------
                                     36 ; absolute external ram data
                                     37 ;--------------------------------------------------------
                                     38 	.area DABS (ABS)
                                     39 
                                     40 ; default segment ordering for linker
                                     41 	.area HOME
                                     42 	.area GSINIT
                                     43 	.area GSFINAL
                                     44 	.area CONST
                                     45 	.area INITIALIZER
                                     46 	.area CODE
                                     47 
                                     48 ;--------------------------------------------------------
                                     49 ; interrupt vector
                                     50 ;--------------------------------------------------------
                                     51 	.area HOME
      008000                         52 __interrupt_vect:
      008000 82 00 80 07             53 	int s_GSINIT ; reset
                                     54 ;--------------------------------------------------------
                                     55 ; global & static initialisations
                                     56 ;--------------------------------------------------------
                                     57 	.area HOME
                                     58 	.area GSINIT
                                     59 	.area GSFINAL
                                     60 	.area GSINIT
      008007                         61 __sdcc_init_data:
                                     62 ; stm8_genXINIT() start
      008007 AE 00 02         [ 2]   63 	ldw x, #l_DATA
      00800A 27 07            [ 1]   64 	jreq	00002$
      00800C                         65 00001$:
      00800C 72 4F 00 00      [ 1]   66 	clr (s_DATA - 1, x)
      008010 5A               [ 2]   67 	decw x
      008011 26 F9            [ 1]   68 	jrne	00001$
      008013                         69 00002$:
      008013 AE 00 00         [ 2]   70 	ldw	x, #l_INITIALIZER
      008016 27 09            [ 1]   71 	jreq	00004$
      008018                         72 00003$:
      008018 D6 80 23         [ 1]   73 	ld	a, (s_INITIALIZER - 1, x)
      00801B D7 00 02         [ 1]   74 	ld	(s_INITIALIZED - 1, x), a
      00801E 5A               [ 2]   75 	decw	x
      00801F 26 F7            [ 1]   76 	jrne	00003$
      008021                         77 00004$:
                                     78 ; stm8_genXINIT() end
                                     79 	.area GSFINAL
      008021 CC 80 04         [ 2]   80 	jp	__sdcc_program_startup
                                     81 ;--------------------------------------------------------
                                     82 ; Home
                                     83 ;--------------------------------------------------------
                                     84 	.area HOME
                                     85 	.area HOME
      008004                         86 __sdcc_program_startup:
      008004 CC 80 2C         [ 2]   87 	jp	_main
                                     88 ;	return from main will return to caller
                                     89 ;--------------------------------------------------------
                                     90 ; code
                                     91 ;--------------------------------------------------------
                                     92 	.area CODE
                                     93 ;	main.c: 16: static void delay(uint16_t t) {
                                     94 ;	-----------------------------------------
                                     95 ;	 function delay
                                     96 ;	-----------------------------------------
      008024                         97 _delay:
                                     98 ;	main.c: 17: while(t--) {};
      008024                         99 00101$:
      008024 90 93            [ 1]  100 	ldw	y, x
      008026 5A               [ 2]  101 	decw	x
      008027 90 5D            [ 2]  102 	tnzw	y
      008029 26 F9            [ 1]  103 	jrne	00101$
                                    104 ;	main.c: 18: }
      00802B 81               [ 4]  105 	ret
                                    106 ;	main.c: 20: int main() {
                                    107 ;	-----------------------------------------
                                    108 ;	 function main
                                    109 ;	-----------------------------------------
      00802C                        110 _main:
      00802C 52 03            [ 2]  111 	sub	sp, #3
                                    112 ;	main.c: 21: do { __asm sim __endasm; } while(0); // Disable interrupts
      00802E 9B               [ 1]  113 	sim	
                                    114 ;	main.c: 23: clk_init();
      00802F CD 82 56         [ 4]  115 	call	_clk_init
                                    116 ;	main.c: 24: gpio_init();
      008032 CD 81 CD         [ 4]  117 	call	_gpio_init
                                    118 ;	main.c: 25: tim2_init();
      008035 CD 81 64         [ 4]  119 	call	_tim2_init
                                    120 ;	main.c: 27: do { __asm rim __endasm; } while(0); // Enable interrupts
      008038 9A               [ 1]  121 	rim	
                                    122 ;	main.c: 29: write_to_eeprom();
      008039 CD 82 6B         [ 4]  123 	call	_write_to_eeprom
                                    124 ;	main.c: 32: rgb.r = 0;
      00803C 0F 01            [ 1]  125 	clr	(0x01, sp)
                                    126 ;	main.c: 33: rgb.g = 0;
      00803E 0F 02            [ 1]  127 	clr	(0x02, sp)
                                    128 ;	main.c: 34: rgb.b = 0;
      008040 0F 03            [ 1]  129 	clr	(0x03, sp)
      008042                        130 00108$:
                                    131 ;	main.c: 37: button_hundler(&rgb);
      008042 96               [ 1]  132 	ldw	x, sp
      008043 5C               [ 1]  133 	incw	x
      008044 CD 80 51         [ 4]  134 	call	_button_hundler
                                    135 ;	main.c: 38: write_color_to_registers(&rgb);
      008047 96               [ 1]  136 	ldw	x, sp
      008048 5C               [ 1]  137 	incw	x
      008049 CD 81 1D         [ 4]  138 	call	_write_color_to_registers
      00804C 20 F4            [ 2]  139 	jra	00108$
                                    140 ;	main.c: 40: }
      00804E 5B 03            [ 2]  141 	addw	sp, #3
      008050 81               [ 4]  142 	ret
                                    143 ;	main.c: 42: void button_hundler(struct Color *color) {
                                    144 ;	-----------------------------------------
                                    145 ;	 function button_hundler
                                    146 ;	-----------------------------------------
      008051                        147 _button_hundler:
      008051 52 04            [ 2]  148 	sub	sp, #4
      008053 1F 03            [ 2]  149 	ldw	(0x03, sp), x
                                    150 ;	main.c: 43: if((1 << 2) == (~PD_IDR & (1 << 2))) { // But_R+
      008055 C6 50 10         [ 1]  151 	ld	a, 0x5010
      008058 5F               [ 1]  152 	clrw	x
      008059 97               [ 1]  153 	ld	xl, a
      00805A 53               [ 2]  154 	cplw	x
      00805B 9F               [ 1]  155 	ld	a, xl
      00805C A4 04            [ 1]  156 	and	a, #0x04
      00805E 97               [ 1]  157 	ld	xl, a
      00805F 4F               [ 1]  158 	clr	a
      008060 95               [ 1]  159 	ld	xh, a
      008061 A3 00 04         [ 2]  160 	cpw	x, #0x0004
      008064 26 05            [ 1]  161 	jrne	00102$
                                    162 ;	main.c: 44: smart_increment(&color->r);
      008066 1E 03            [ 2]  163 	ldw	x, (0x03, sp)
      008068 CD 81 54         [ 4]  164 	call	_smart_increment
      00806B                        165 00102$:
                                    166 ;	main.c: 47: if((1 << 7) == (~PC_IDR & (1 << 7))) { // But_R-
      00806B C6 50 0B         [ 1]  167 	ld	a, 0x500b
      00806E 5F               [ 1]  168 	clrw	x
      00806F 97               [ 1]  169 	ld	xl, a
      008070 53               [ 2]  170 	cplw	x
      008071 9F               [ 1]  171 	ld	a, xl
      008072 A4 80            [ 1]  172 	and	a, #0x80
      008074 97               [ 1]  173 	ld	xl, a
      008075 4F               [ 1]  174 	clr	a
      008076 95               [ 1]  175 	ld	xh, a
      008077 A3 00 80         [ 2]  176 	cpw	x, #0x0080
      00807A 26 05            [ 1]  177 	jrne	00104$
                                    178 ;	main.c: 48: smart_decrement(&color->r);
      00807C 1E 03            [ 2]  179 	ldw	x, (0x03, sp)
      00807E CD 81 5D         [ 4]  180 	call	_smart_decrement
      008081                        181 00104$:
                                    182 ;	main.c: 51: if((1 << 6) == (~PC_IDR & (1 << 6))) { // But_G+
      008081 C6 50 0B         [ 1]  183 	ld	a, 0x500b
      008084 5F               [ 1]  184 	clrw	x
      008085 97               [ 1]  185 	ld	xl, a
      008086 53               [ 2]  186 	cplw	x
      008087 9F               [ 1]  187 	ld	a, xl
      008088 A4 40            [ 1]  188 	and	a, #0x40
      00808A 97               [ 1]  189 	ld	xl, a
      00808B 4F               [ 1]  190 	clr	a
                                    191 ;	main.c: 52: smart_increment(&color->g);
      00808C 16 03            [ 2]  192 	ldw	y, (0x03, sp)
      00808E 90 5C            [ 1]  193 	incw	y
      008090 17 01            [ 2]  194 	ldw	(0x01, sp), y
                                    195 ;	main.c: 51: if((1 << 6) == (~PC_IDR & (1 << 6))) { // But_G+
      008092 95               [ 1]  196 	ld	xh, a
      008093 A3 00 40         [ 2]  197 	cpw	x, #0x0040
      008096 26 05            [ 1]  198 	jrne	00106$
                                    199 ;	main.c: 52: smart_increment(&color->g);
      008098 1E 01            [ 2]  200 	ldw	x, (0x01, sp)
      00809A CD 81 54         [ 4]  201 	call	_smart_increment
      00809D                        202 00106$:
                                    203 ;	main.c: 55: if((1 << 5) == (~PC_IDR & (1 << 5))) { // But_G-
      00809D C6 50 0B         [ 1]  204 	ld	a, 0x500b
      0080A0 5F               [ 1]  205 	clrw	x
      0080A1 97               [ 1]  206 	ld	xl, a
      0080A2 53               [ 2]  207 	cplw	x
      0080A3 9F               [ 1]  208 	ld	a, xl
      0080A4 A4 20            [ 1]  209 	and	a, #0x20
      0080A6 97               [ 1]  210 	ld	xl, a
      0080A7 4F               [ 1]  211 	clr	a
      0080A8 95               [ 1]  212 	ld	xh, a
      0080A9 A3 00 20         [ 2]  213 	cpw	x, #0x0020
      0080AC 26 05            [ 1]  214 	jrne	00108$
                                    215 ;	main.c: 56: smart_decrement(&color->g);
      0080AE 1E 01            [ 2]  216 	ldw	x, (0x01, sp)
      0080B0 CD 81 5D         [ 4]  217 	call	_smart_decrement
      0080B3                        218 00108$:
                                    219 ;	main.c: 59: if((1 << 4) == (~PC_IDR & (1 << 4))) { // But_B+
      0080B3 C6 50 0B         [ 1]  220 	ld	a, 0x500b
      0080B6 5F               [ 1]  221 	clrw	x
      0080B7 97               [ 1]  222 	ld	xl, a
      0080B8 53               [ 2]  223 	cplw	x
      0080B9 90 5F            [ 1]  224 	clrw	y
      0080BB 9F               [ 1]  225 	ld	a, xl
      0080BC A4 10            [ 1]  226 	and	a, #0x10
      0080BE 90 97            [ 1]  227 	ld	yl, a
                                    228 ;	main.c: 60: smart_increment(&color->b);
      0080C0 1E 03            [ 2]  229 	ldw	x, (0x03, sp)
      0080C2 5C               [ 1]  230 	incw	x
      0080C3 5C               [ 1]  231 	incw	x
      0080C4 1F 01            [ 2]  232 	ldw	(0x01, sp), x
                                    233 ;	main.c: 59: if((1 << 4) == (~PC_IDR & (1 << 4))) { // But_B+
      0080C6 90 A3 00 10      [ 2]  234 	cpw	y, #0x0010
      0080CA 26 05            [ 1]  235 	jrne	00110$
                                    236 ;	main.c: 60: smart_increment(&color->b);
      0080CC 1E 01            [ 2]  237 	ldw	x, (0x01, sp)
      0080CE CD 81 54         [ 4]  238 	call	_smart_increment
      0080D1                        239 00110$:
                                    240 ;	main.c: 63: if((1 << 3) == (~PC_IDR & (1 << 3))) { // But_B-
      0080D1 C6 50 0B         [ 1]  241 	ld	a, 0x500b
      0080D4 5F               [ 1]  242 	clrw	x
      0080D5 97               [ 1]  243 	ld	xl, a
      0080D6 53               [ 2]  244 	cplw	x
      0080D7 9F               [ 1]  245 	ld	a, xl
      0080D8 A4 08            [ 1]  246 	and	a, #0x08
      0080DA 97               [ 1]  247 	ld	xl, a
      0080DB 4F               [ 1]  248 	clr	a
      0080DC 95               [ 1]  249 	ld	xh, a
      0080DD A3 00 08         [ 2]  250 	cpw	x, #0x0008
      0080E0 26 07            [ 1]  251 	jrne	00113$
                                    252 ;	main.c: 64: smart_decrement(&color->b);
      0080E2 1E 01            [ 2]  253 	ldw	x, (0x01, sp)
      0080E4 5B 04            [ 2]  254 	addw	sp, #4
      0080E6 CC 81 5D         [ 2]  255 	jp	_smart_decrement
      0080E9                        256 00113$:
                                    257 ;	main.c: 66: }
      0080E9 5B 04            [ 2]  258 	addw	sp, #4
      0080EB 81               [ 4]  259 	ret
                                    260 	.area CODE
                                    261 	.area CONST
                                    262 	.area INITIALIZER
                                    263 	.area CABS (ABS)
