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
                                     12 	.globl _eeprom_write
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
                                     93 ;	main.c: 19: static void delay(uint16_t t) {
                                     94 ;	-----------------------------------------
                                     95 ;	 function delay
                                     96 ;	-----------------------------------------
      008024                         97 _delay:
                                     98 ;	main.c: 20: while(t--) {};
      008024                         99 00101$:
      008024 90 93            [ 1]  100 	ldw	y, x
      008026 5A               [ 2]  101 	decw	x
      008027 90 5D            [ 2]  102 	tnzw	y
      008029 26 F9            [ 1]  103 	jrne	00101$
                                    104 ;	main.c: 21: }
      00802B 81               [ 4]  105 	ret
                                    106 ;	main.c: 23: int main() {
                                    107 ;	-----------------------------------------
                                    108 ;	 function main
                                    109 ;	-----------------------------------------
      00802C                        110 _main:
      00802C 52 03            [ 2]  111 	sub	sp, #3
                                    112 ;	main.c: 24: __asm sim __endasm; // Disable interrupts
      00802E 9B               [ 1]  113 	sim	
                                    114 ;	main.c: 26: clk_init();
      00802F CD 82 72         [ 4]  115 	call	_clk_init
                                    116 ;	main.c: 27: gpio_init();
      008032 CD 81 D1         [ 4]  117 	call	_gpio_init
                                    118 ;	main.c: 28: tim2_init();
      008035 CD 81 68         [ 4]  119 	call	_tim2_init
                                    120 ;	main.c: 30: __asm rim __endasm; // Enable interrupts
      008038 9A               [ 1]  121 	rim	
                                    122 ;	main.c: 32: eeprom_write(1, 0xCC);
      008039 A6 CC            [ 1]  123 	ld	a, #0xcc
      00803B 5F               [ 1]  124 	clrw	x
      00803C 5C               [ 1]  125 	incw	x
      00803D CD 82 87         [ 4]  126 	call	_eeprom_write
                                    127 ;	main.c: 35: rgb.r = 0;
      008040 0F 01            [ 1]  128 	clr	(0x01, sp)
                                    129 ;	main.c: 36: rgb.g = 0;
      008042 0F 02            [ 1]  130 	clr	(0x02, sp)
                                    131 ;	main.c: 37: rgb.b = 0;
      008044 0F 03            [ 1]  132 	clr	(0x03, sp)
      008046                        133 00102$:
                                    134 ;	main.c: 40: button_hundler(&rgb);
      008046 96               [ 1]  135 	ldw	x, sp
      008047 5C               [ 1]  136 	incw	x
      008048 CD 80 55         [ 4]  137 	call	_button_hundler
                                    138 ;	main.c: 41: write_color_to_registers(&rgb);
      00804B 96               [ 1]  139 	ldw	x, sp
      00804C 5C               [ 1]  140 	incw	x
      00804D CD 81 21         [ 4]  141 	call	_write_color_to_registers
      008050 20 F4            [ 2]  142 	jra	00102$
                                    143 ;	main.c: 43: }
      008052 5B 03            [ 2]  144 	addw	sp, #3
      008054 81               [ 4]  145 	ret
                                    146 ;	main.c: 45: void button_hundler(struct Color *color) {
                                    147 ;	-----------------------------------------
                                    148 ;	 function button_hundler
                                    149 ;	-----------------------------------------
      008055                        150 _button_hundler:
      008055 52 04            [ 2]  151 	sub	sp, #4
      008057 1F 03            [ 2]  152 	ldw	(0x03, sp), x
                                    153 ;	main.c: 46: if((1 << 2) == (~PD_IDR & (1 << 2))) { // But_R+
      008059 C6 50 10         [ 1]  154 	ld	a, 0x5010
      00805C 5F               [ 1]  155 	clrw	x
      00805D 97               [ 1]  156 	ld	xl, a
      00805E 53               [ 2]  157 	cplw	x
      00805F 9F               [ 1]  158 	ld	a, xl
      008060 A4 04            [ 1]  159 	and	a, #0x04
      008062 97               [ 1]  160 	ld	xl, a
      008063 4F               [ 1]  161 	clr	a
      008064 95               [ 1]  162 	ld	xh, a
      008065 A3 00 04         [ 2]  163 	cpw	x, #0x0004
      008068 26 05            [ 1]  164 	jrne	00102$
                                    165 ;	main.c: 47: smart_increment(&color->r);
      00806A 1E 03            [ 2]  166 	ldw	x, (0x03, sp)
      00806C CD 81 58         [ 4]  167 	call	_smart_increment
      00806F                        168 00102$:
                                    169 ;	main.c: 50: if((1 << 7) == (~PC_IDR & (1 << 7))) { // But_R-
      00806F C6 50 0B         [ 1]  170 	ld	a, 0x500b
      008072 5F               [ 1]  171 	clrw	x
      008073 97               [ 1]  172 	ld	xl, a
      008074 53               [ 2]  173 	cplw	x
      008075 9F               [ 1]  174 	ld	a, xl
      008076 A4 80            [ 1]  175 	and	a, #0x80
      008078 97               [ 1]  176 	ld	xl, a
      008079 4F               [ 1]  177 	clr	a
      00807A 95               [ 1]  178 	ld	xh, a
      00807B A3 00 80         [ 2]  179 	cpw	x, #0x0080
      00807E 26 05            [ 1]  180 	jrne	00104$
                                    181 ;	main.c: 51: smart_decrement(&color->r);
      008080 1E 03            [ 2]  182 	ldw	x, (0x03, sp)
      008082 CD 81 61         [ 4]  183 	call	_smart_decrement
      008085                        184 00104$:
                                    185 ;	main.c: 54: if((1 << 6) == (~PC_IDR & (1 << 6))) { // But_G+
      008085 C6 50 0B         [ 1]  186 	ld	a, 0x500b
      008088 5F               [ 1]  187 	clrw	x
      008089 97               [ 1]  188 	ld	xl, a
      00808A 53               [ 2]  189 	cplw	x
      00808B 9F               [ 1]  190 	ld	a, xl
      00808C A4 40            [ 1]  191 	and	a, #0x40
      00808E 97               [ 1]  192 	ld	xl, a
      00808F 4F               [ 1]  193 	clr	a
                                    194 ;	main.c: 55: smart_increment(&color->g);
      008090 16 03            [ 2]  195 	ldw	y, (0x03, sp)
      008092 90 5C            [ 1]  196 	incw	y
      008094 17 01            [ 2]  197 	ldw	(0x01, sp), y
                                    198 ;	main.c: 54: if((1 << 6) == (~PC_IDR & (1 << 6))) { // But_G+
      008096 95               [ 1]  199 	ld	xh, a
      008097 A3 00 40         [ 2]  200 	cpw	x, #0x0040
      00809A 26 05            [ 1]  201 	jrne	00106$
                                    202 ;	main.c: 55: smart_increment(&color->g);
      00809C 1E 01            [ 2]  203 	ldw	x, (0x01, sp)
      00809E CD 81 58         [ 4]  204 	call	_smart_increment
      0080A1                        205 00106$:
                                    206 ;	main.c: 58: if((1 << 5) == (~PC_IDR & (1 << 5))) { // But_G-
      0080A1 C6 50 0B         [ 1]  207 	ld	a, 0x500b
      0080A4 5F               [ 1]  208 	clrw	x
      0080A5 97               [ 1]  209 	ld	xl, a
      0080A6 53               [ 2]  210 	cplw	x
      0080A7 9F               [ 1]  211 	ld	a, xl
      0080A8 A4 20            [ 1]  212 	and	a, #0x20
      0080AA 97               [ 1]  213 	ld	xl, a
      0080AB 4F               [ 1]  214 	clr	a
      0080AC 95               [ 1]  215 	ld	xh, a
      0080AD A3 00 20         [ 2]  216 	cpw	x, #0x0020
      0080B0 26 05            [ 1]  217 	jrne	00108$
                                    218 ;	main.c: 59: smart_decrement(&color->g);
      0080B2 1E 01            [ 2]  219 	ldw	x, (0x01, sp)
      0080B4 CD 81 61         [ 4]  220 	call	_smart_decrement
      0080B7                        221 00108$:
                                    222 ;	main.c: 62: if((1 << 4) == (~PC_IDR & (1 << 4))) { // But_B+
      0080B7 C6 50 0B         [ 1]  223 	ld	a, 0x500b
      0080BA 5F               [ 1]  224 	clrw	x
      0080BB 97               [ 1]  225 	ld	xl, a
      0080BC 53               [ 2]  226 	cplw	x
      0080BD 90 5F            [ 1]  227 	clrw	y
      0080BF 9F               [ 1]  228 	ld	a, xl
      0080C0 A4 10            [ 1]  229 	and	a, #0x10
      0080C2 90 97            [ 1]  230 	ld	yl, a
                                    231 ;	main.c: 63: smart_increment(&color->b);
      0080C4 1E 03            [ 2]  232 	ldw	x, (0x03, sp)
      0080C6 5C               [ 1]  233 	incw	x
      0080C7 5C               [ 1]  234 	incw	x
      0080C8 1F 01            [ 2]  235 	ldw	(0x01, sp), x
                                    236 ;	main.c: 62: if((1 << 4) == (~PC_IDR & (1 << 4))) { // But_B+
      0080CA 90 A3 00 10      [ 2]  237 	cpw	y, #0x0010
      0080CE 26 05            [ 1]  238 	jrne	00110$
                                    239 ;	main.c: 63: smart_increment(&color->b);
      0080D0 1E 01            [ 2]  240 	ldw	x, (0x01, sp)
      0080D2 CD 81 58         [ 4]  241 	call	_smart_increment
      0080D5                        242 00110$:
                                    243 ;	main.c: 66: if((1 << 3) == (~PC_IDR & (1 << 3))) { // But_B-
      0080D5 C6 50 0B         [ 1]  244 	ld	a, 0x500b
      0080D8 5F               [ 1]  245 	clrw	x
      0080D9 97               [ 1]  246 	ld	xl, a
      0080DA 53               [ 2]  247 	cplw	x
      0080DB 9F               [ 1]  248 	ld	a, xl
      0080DC A4 08            [ 1]  249 	and	a, #0x08
      0080DE 97               [ 1]  250 	ld	xl, a
      0080DF 4F               [ 1]  251 	clr	a
      0080E0 95               [ 1]  252 	ld	xh, a
      0080E1 A3 00 08         [ 2]  253 	cpw	x, #0x0008
      0080E4 26 07            [ 1]  254 	jrne	00113$
                                    255 ;	main.c: 67: smart_decrement(&color->b);
      0080E6 1E 01            [ 2]  256 	ldw	x, (0x01, sp)
      0080E8 5B 04            [ 2]  257 	addw	sp, #4
      0080EA CC 81 61         [ 2]  258 	jp	_smart_decrement
                                    259 ;	main.c: 73: if((1 << 5) == (~PB_IDR & (1 << 5))) { // But_LOAD
      0080ED                        260 00113$:
                                    261 ;	main.c: 75: }
      0080ED 5B 04            [ 2]  262 	addw	sp, #4
      0080EF 81               [ 4]  263 	ret
                                    264 	.area CODE
                                    265 	.area CONST
                                    266 	.area INITIALIZER
                                    267 	.area CABS (ABS)
