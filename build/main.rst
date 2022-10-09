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
      008004 CC 80 47         [ 2]   87 	jp	_main
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
                                    106 ;	main.c: 20: void write_to_eeprom(void) {
                                    107 ;	-----------------------------------------
                                    108 ;	 function write_to_eeprom
                                    109 ;	-----------------------------------------
      00802C                        110 _write_to_eeprom:
                                    111 ;	main.c: 21: if (!(FLASH_IAPSR & 0x02))
      00802C 72 02 50 5F 08   [ 2]  112 	btjt	0x505f, #1, 00103$
                                    113 ;	main.c: 24: FLASH_DUKR = 0xAE;
      008031 35 AE 50 64      [ 1]  114 	mov	0x5064+0, #0xae
                                    115 ;	main.c: 25: FLASH_DUKR = 0x56;
      008035 35 56 50 64      [ 1]  116 	mov	0x5064+0, #0x56
                                    117 ;	main.c: 28: while (!(FLASH_IAPSR & DUL));
      008039                        118 00103$:
      008039 72 07 50 5F FB   [ 2]  119 	btjf	0x505f, #3, 00103$
                                    120 ;	main.c: 30: EEPROM_FIRST_ADDR = 0xff;
      00803E 35 FF 40 00      [ 1]  121 	mov	0x4000+0, #0xff
                                    122 ;	main.c: 32: FLASH_IAPSR &= ~(DUL);      // lock EEPROM
      008042 72 17 50 5F      [ 1]  123 	bres	0x505f, #3
                                    124 ;	main.c: 33: }
      008046 81               [ 4]  125 	ret
                                    126 ;	main.c: 35: int main() {
                                    127 ;	-----------------------------------------
                                    128 ;	 function main
                                    129 ;	-----------------------------------------
      008047                        130 _main:
      008047 52 03            [ 2]  131 	sub	sp, #3
                                    132 ;	main.c: 36: do { __asm sim __endasm; } while(0); // Disable interrupts
      008049 9B               [ 1]  133 	sim	
                                    134 ;	main.c: 38: clk_init();
      00804A CD 82 71         [ 4]  135 	call	_clk_init
                                    136 ;	main.c: 39: gpio_init();
      00804D CD 81 E8         [ 4]  137 	call	_gpio_init
                                    138 ;	main.c: 40: tim2_init();
      008050 CD 81 7F         [ 4]  139 	call	_tim2_init
                                    140 ;	main.c: 42: do { __asm rim __endasm; } while(0); // Enable interrupts
      008053 9A               [ 1]  141 	rim	
                                    142 ;	main.c: 44: write_to_eeprom();
      008054 CD 80 2C         [ 4]  143 	call	_write_to_eeprom
                                    144 ;	main.c: 47: rgb.r = 0;
      008057 0F 01            [ 1]  145 	clr	(0x01, sp)
                                    146 ;	main.c: 48: rgb.g = 0;
      008059 0F 02            [ 1]  147 	clr	(0x02, sp)
                                    148 ;	main.c: 49: rgb.b = 0;
      00805B 0F 03            [ 1]  149 	clr	(0x03, sp)
      00805D                        150 00108$:
                                    151 ;	main.c: 52: button_hundler(&rgb);
      00805D 96               [ 1]  152 	ldw	x, sp
      00805E 5C               [ 1]  153 	incw	x
      00805F CD 80 6C         [ 4]  154 	call	_button_hundler
                                    155 ;	main.c: 53: write_color_to_registers(&rgb);
      008062 96               [ 1]  156 	ldw	x, sp
      008063 5C               [ 1]  157 	incw	x
      008064 CD 81 38         [ 4]  158 	call	_write_color_to_registers
      008067 20 F4            [ 2]  159 	jra	00108$
                                    160 ;	main.c: 55: }
      008069 5B 03            [ 2]  161 	addw	sp, #3
      00806B 81               [ 4]  162 	ret
                                    163 ;	main.c: 57: void button_hundler(struct Color *color) {
                                    164 ;	-----------------------------------------
                                    165 ;	 function button_hundler
                                    166 ;	-----------------------------------------
      00806C                        167 _button_hundler:
      00806C 52 04            [ 2]  168 	sub	sp, #4
      00806E 1F 03            [ 2]  169 	ldw	(0x03, sp), x
                                    170 ;	main.c: 58: if((1 << 2) == (~PD_IDR & (1 << 2))) { // But_R+
      008070 C6 50 10         [ 1]  171 	ld	a, 0x5010
      008073 5F               [ 1]  172 	clrw	x
      008074 97               [ 1]  173 	ld	xl, a
      008075 53               [ 2]  174 	cplw	x
      008076 9F               [ 1]  175 	ld	a, xl
      008077 A4 04            [ 1]  176 	and	a, #0x04
      008079 97               [ 1]  177 	ld	xl, a
      00807A 4F               [ 1]  178 	clr	a
      00807B 95               [ 1]  179 	ld	xh, a
      00807C A3 00 04         [ 2]  180 	cpw	x, #0x0004
      00807F 26 05            [ 1]  181 	jrne	00102$
                                    182 ;	main.c: 59: smart_increment(&color->r);
      008081 1E 03            [ 2]  183 	ldw	x, (0x03, sp)
      008083 CD 81 6F         [ 4]  184 	call	_smart_increment
      008086                        185 00102$:
                                    186 ;	main.c: 62: if((1 << 7) == (~PC_IDR & (1 << 7))) { // But_R-
      008086 C6 50 0B         [ 1]  187 	ld	a, 0x500b
      008089 5F               [ 1]  188 	clrw	x
      00808A 97               [ 1]  189 	ld	xl, a
      00808B 53               [ 2]  190 	cplw	x
      00808C 9F               [ 1]  191 	ld	a, xl
      00808D A4 80            [ 1]  192 	and	a, #0x80
      00808F 97               [ 1]  193 	ld	xl, a
      008090 4F               [ 1]  194 	clr	a
      008091 95               [ 1]  195 	ld	xh, a
      008092 A3 00 80         [ 2]  196 	cpw	x, #0x0080
      008095 26 05            [ 1]  197 	jrne	00104$
                                    198 ;	main.c: 63: smart_decrement(&color->r);
      008097 1E 03            [ 2]  199 	ldw	x, (0x03, sp)
      008099 CD 81 78         [ 4]  200 	call	_smart_decrement
      00809C                        201 00104$:
                                    202 ;	main.c: 66: if((1 << 6) == (~PC_IDR & (1 << 6))) { // But_G+
      00809C C6 50 0B         [ 1]  203 	ld	a, 0x500b
      00809F 5F               [ 1]  204 	clrw	x
      0080A0 97               [ 1]  205 	ld	xl, a
      0080A1 53               [ 2]  206 	cplw	x
      0080A2 9F               [ 1]  207 	ld	a, xl
      0080A3 A4 40            [ 1]  208 	and	a, #0x40
      0080A5 97               [ 1]  209 	ld	xl, a
      0080A6 4F               [ 1]  210 	clr	a
                                    211 ;	main.c: 67: smart_increment(&color->g);
      0080A7 16 03            [ 2]  212 	ldw	y, (0x03, sp)
      0080A9 90 5C            [ 1]  213 	incw	y
      0080AB 17 01            [ 2]  214 	ldw	(0x01, sp), y
                                    215 ;	main.c: 66: if((1 << 6) == (~PC_IDR & (1 << 6))) { // But_G+
      0080AD 95               [ 1]  216 	ld	xh, a
      0080AE A3 00 40         [ 2]  217 	cpw	x, #0x0040
      0080B1 26 05            [ 1]  218 	jrne	00106$
                                    219 ;	main.c: 67: smart_increment(&color->g);
      0080B3 1E 01            [ 2]  220 	ldw	x, (0x01, sp)
      0080B5 CD 81 6F         [ 4]  221 	call	_smart_increment
      0080B8                        222 00106$:
                                    223 ;	main.c: 70: if((1 << 5) == (~PC_IDR & (1 << 5))) { // But_G-
      0080B8 C6 50 0B         [ 1]  224 	ld	a, 0x500b
      0080BB 5F               [ 1]  225 	clrw	x
      0080BC 97               [ 1]  226 	ld	xl, a
      0080BD 53               [ 2]  227 	cplw	x
      0080BE 9F               [ 1]  228 	ld	a, xl
      0080BF A4 20            [ 1]  229 	and	a, #0x20
      0080C1 97               [ 1]  230 	ld	xl, a
      0080C2 4F               [ 1]  231 	clr	a
      0080C3 95               [ 1]  232 	ld	xh, a
      0080C4 A3 00 20         [ 2]  233 	cpw	x, #0x0020
      0080C7 26 05            [ 1]  234 	jrne	00108$
                                    235 ;	main.c: 71: smart_decrement(&color->g);
      0080C9 1E 01            [ 2]  236 	ldw	x, (0x01, sp)
      0080CB CD 81 78         [ 4]  237 	call	_smart_decrement
      0080CE                        238 00108$:
                                    239 ;	main.c: 74: if((1 << 4) == (~PC_IDR & (1 << 4))) { // But_B+
      0080CE C6 50 0B         [ 1]  240 	ld	a, 0x500b
      0080D1 5F               [ 1]  241 	clrw	x
      0080D2 97               [ 1]  242 	ld	xl, a
      0080D3 53               [ 2]  243 	cplw	x
      0080D4 90 5F            [ 1]  244 	clrw	y
      0080D6 9F               [ 1]  245 	ld	a, xl
      0080D7 A4 10            [ 1]  246 	and	a, #0x10
      0080D9 90 97            [ 1]  247 	ld	yl, a
                                    248 ;	main.c: 75: smart_increment(&color->b);
      0080DB 1E 03            [ 2]  249 	ldw	x, (0x03, sp)
      0080DD 5C               [ 1]  250 	incw	x
      0080DE 5C               [ 1]  251 	incw	x
      0080DF 1F 01            [ 2]  252 	ldw	(0x01, sp), x
                                    253 ;	main.c: 74: if((1 << 4) == (~PC_IDR & (1 << 4))) { // But_B+
      0080E1 90 A3 00 10      [ 2]  254 	cpw	y, #0x0010
      0080E5 26 05            [ 1]  255 	jrne	00110$
                                    256 ;	main.c: 75: smart_increment(&color->b);
      0080E7 1E 01            [ 2]  257 	ldw	x, (0x01, sp)
      0080E9 CD 81 6F         [ 4]  258 	call	_smart_increment
      0080EC                        259 00110$:
                                    260 ;	main.c: 78: if((1 << 3) == (~PC_IDR & (1 << 3))) { // But_B-
      0080EC C6 50 0B         [ 1]  261 	ld	a, 0x500b
      0080EF 5F               [ 1]  262 	clrw	x
      0080F0 97               [ 1]  263 	ld	xl, a
      0080F1 53               [ 2]  264 	cplw	x
      0080F2 9F               [ 1]  265 	ld	a, xl
      0080F3 A4 08            [ 1]  266 	and	a, #0x08
      0080F5 97               [ 1]  267 	ld	xl, a
      0080F6 4F               [ 1]  268 	clr	a
      0080F7 95               [ 1]  269 	ld	xh, a
      0080F8 A3 00 08         [ 2]  270 	cpw	x, #0x0008
      0080FB 26 07            [ 1]  271 	jrne	00113$
                                    272 ;	main.c: 79: smart_decrement(&color->b);
      0080FD 1E 01            [ 2]  273 	ldw	x, (0x01, sp)
      0080FF 5B 04            [ 2]  274 	addw	sp, #4
      008101 CC 81 78         [ 2]  275 	jp	_smart_decrement
      008104                        276 00113$:
                                    277 ;	main.c: 81: }
      008104 5B 04            [ 2]  278 	addw	sp, #4
      008106 81               [ 4]  279 	ret
                                    280 	.area CODE
                                    281 	.area CONST
                                    282 	.area INITIALIZER
                                    283 	.area CABS (ABS)
