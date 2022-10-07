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
                                     11 	.globl _pwm_steps
                                     12 	.globl _main
                                     13 	.globl _smart_decrement
                                     14 	.globl _smart_increment
                                     15 	.globl _write_color_to_registers
                                     16 	.globl _tim2_init
                                     17 	.globl _gpio_init
                                     18 	.globl _clk_init
                                     19 	.globl _rgb
                                     20 	.globl _tim2_demo
                                     21 	.globl _button_hundler
                                     22 ;--------------------------------------------------------
                                     23 ; ram data
                                     24 ;--------------------------------------------------------
                                     25 	.area DATA
      000001                         26 _rgb::
      000001                         27 	.ds 3
      000004                         28 _tim2_demo_counter_196608_40:
      000004                         29 	.ds 2
                                     30 ;--------------------------------------------------------
                                     31 ; ram data
                                     32 ;--------------------------------------------------------
                                     33 	.area INITIALIZED
                                     34 ;--------------------------------------------------------
                                     35 ; Stack segment in internal ram
                                     36 ;--------------------------------------------------------
                                     37 	.area	SSEG
      000008                         38 __start__stack:
      000008                         39 	.ds	1
                                     40 
                                     41 ;--------------------------------------------------------
                                     42 ; absolute external ram data
                                     43 ;--------------------------------------------------------
                                     44 	.area DABS (ABS)
                                     45 
                                     46 ; default segment ordering for linker
                                     47 	.area HOME
                                     48 	.area GSINIT
                                     49 	.area GSFINAL
                                     50 	.area CONST
                                     51 	.area INITIALIZER
                                     52 	.area CODE
                                     53 
                                     54 ;--------------------------------------------------------
                                     55 ; interrupt vector
                                     56 ;--------------------------------------------------------
                                     57 	.area HOME
      008000                         58 __interrupt_vect:
      008000 82 00 80 07             59 	int s_GSINIT ; reset
                                     60 ;--------------------------------------------------------
                                     61 ; global & static initialisations
                                     62 ;--------------------------------------------------------
                                     63 	.area HOME
                                     64 	.area GSINIT
                                     65 	.area GSFINAL
                                     66 	.area GSINIT
      008007                         67 __sdcc_init_data:
                                     68 ; stm8_genXINIT() start
      008007 AE 00 07         [ 2]   69 	ldw x, #l_DATA
      00800A 27 07            [ 1]   70 	jreq	00002$
      00800C                         71 00001$:
      00800C 72 4F 00 00      [ 1]   72 	clr (s_DATA - 1, x)
      008010 5A               [ 2]   73 	decw x
      008011 26 F9            [ 1]   74 	jrne	00001$
      008013                         75 00002$:
      008013 AE 00 00         [ 2]   76 	ldw	x, #l_INITIALIZER
      008016 27 09            [ 1]   77 	jreq	00004$
      008018                         78 00003$:
      008018 D6 80 47         [ 1]   79 	ld	a, (s_INITIALIZER - 1, x)
      00801B D7 00 07         [ 1]   80 	ld	(s_INITIALIZED - 1, x), a
      00801E 5A               [ 2]   81 	decw	x
      00801F 26 F7            [ 1]   82 	jrne	00003$
      008021                         83 00004$:
                                     84 ; stm8_genXINIT() end
                                     85 ;	main.c: 55: static uint16_t counter = 0;
      008021 5F               [ 1]   86 	clrw	x
      008022 CF 00 04         [ 2]   87 	ldw	_tim2_demo_counter_196608_40+0, x
                                     88 	.area GSFINAL
      008025 CC 80 04         [ 2]   89 	jp	__sdcc_program_startup
                                     90 ;--------------------------------------------------------
                                     91 ; Home
                                     92 ;--------------------------------------------------------
                                     93 	.area HOME
                                     94 	.area HOME
      008004                         95 __sdcc_program_startup:
      008004 CC 80 50         [ 2]   96 	jp	_main
                                     97 ;	return from main will return to caller
                                     98 ;--------------------------------------------------------
                                     99 ; code
                                    100 ;--------------------------------------------------------
                                    101 	.area CODE
                                    102 ;	main.c: 19: static void delay(uint16_t t) {
                                    103 ;	-----------------------------------------
                                    104 ;	 function delay
                                    105 ;	-----------------------------------------
      008048                        106 _delay:
                                    107 ;	main.c: 20: while(t--) {};
      008048                        108 00101$:
      008048 90 93            [ 1]  109 	ldw	y, x
      00804A 5A               [ 2]  110 	decw	x
      00804B 90 5D            [ 2]  111 	tnzw	y
      00804D 26 F9            [ 1]  112 	jrne	00101$
                                    113 ;	main.c: 21: }
      00804F 81               [ 4]  114 	ret
                                    115 ;	main.c: 28: int main() {
                                    116 ;	-----------------------------------------
                                    117 ;	 function main
                                    118 ;	-----------------------------------------
      008050                        119 _main:
                                    120 ;	main.c: 29: do { __asm sim __endasm; } while(0); // Disable interrupts
      008050 9B               [ 1]  121 	sim	
                                    122 ;	main.c: 31: clk_init();
      008051 CD 82 D0         [ 4]  123 	call	_clk_init
                                    124 ;	main.c: 32: gpio_init();
      008054 CD 82 4B         [ 4]  125 	call	_gpio_init
                                    126 ;	main.c: 33: tim2_init();
      008057 CD 81 E2         [ 4]  127 	call	_tim2_init
                                    128 ;	main.c: 35: do { __asm rim __endasm; } while(0); // Enable interrupts
      00805A 9A               [ 1]  129 	rim	
                                    130 ;	main.c: 37: PB_ODR |= (1 << 5);
      00805B 72 1A 50 05      [ 1]  131 	bset	0x5005, #5
                                    132 ;	main.c: 39: rgb.r = 0;
      00805F 35 00 00 01      [ 1]  133 	mov	_rgb+0, #0x00
                                    134 ;	main.c: 40: rgb.g = 0;
      008063 35 00 00 02      [ 1]  135 	mov	_rgb+1, #0x00
                                    136 ;	main.c: 41: rgb.b = 0;
      008067 35 00 00 03      [ 1]  137 	mov	_rgb+2, #0x00
      00806B                        138 00108$:
                                    139 ;	main.c: 44: button_hundler(&rgb);
      00806B AE 00 01         [ 2]  140 	ldw	x, #(_rgb+0)
      00806E CD 80 CF         [ 4]  141 	call	_button_hundler
                                    142 ;	main.c: 45: write_color_to_registers(&rgb);
      008071 AE 00 01         [ 2]  143 	ldw	x, #(_rgb+0)
      008074 CD 81 9B         [ 4]  144 	call	_write_color_to_registers
      008077 20 F2            [ 2]  145 	jra	00108$
                                    146 ;	main.c: 47: }
      008079 81               [ 4]  147 	ret
                                    148 ;	main.c: 49: void tim2_demo() {
                                    149 ;	-----------------------------------------
                                    150 ;	 function tim2_demo
                                    151 ;	-----------------------------------------
      00807A                        152 _tim2_demo:
                                    153 ;	main.c: 50: rgb.r = 0;
      00807A 35 00 00 01      [ 1]  154 	mov	_rgb+0, #0x00
                                    155 ;	main.c: 51: rgb.g = 0;
      00807E 35 00 00 02      [ 1]  156 	mov	_rgb+1, #0x00
                                    157 ;	main.c: 52: rgb.b = 0;
      008082 35 00 00 03      [ 1]  158 	mov	_rgb+2, #0x00
      008086                        159 00105$:
                                    160 ;	main.c: 57: write_color_to_registers(&rgb);
      008086 AE 00 01         [ 2]  161 	ldw	x, #(_rgb+0)
      008089 CD 81 9B         [ 4]  162 	call	_write_color_to_registers
                                    163 ;	main.c: 59: if(counter < 255) {
                                    164 ;	main.c: 60: counter ++;
      00808C CE 00 04         [ 2]  165 	ldw	x, _tim2_demo_counter_196608_40+0
      00808F A3 00 FF         [ 2]  166 	cpw	x, #0x00ff
      008092 24 1E            [ 1]  167 	jrnc	00102$
      008094 5C               [ 1]  168 	incw	x
      008095 CF 00 04         [ 2]  169 	ldw	_tim2_demo_counter_196608_40+0, x
                                    170 ;	main.c: 61: rgb.r += 5;
      008098 C6 00 01         [ 1]  171 	ld	a, _rgb+0
      00809B AB 05            [ 1]  172 	add	a, #0x05
      00809D C7 00 01         [ 1]  173 	ld	_rgb+0, a
                                    174 ;	main.c: 62: rgb.g += 5;
      0080A0 C6 00 02         [ 1]  175 	ld	a, _rgb+1
      0080A3 AB 05            [ 1]  176 	add	a, #0x05
      0080A5 C7 00 02         [ 1]  177 	ld	_rgb+1, a
                                    178 ;	main.c: 63: rgb.b += 5;
      0080A8 C6 00 03         [ 1]  179 	ld	a, _rgb+2
      0080AB AB 05            [ 1]  180 	add	a, #0x05
      0080AD C7 00 03         [ 1]  181 	ld	_rgb+2, a
      0080B0 20 14            [ 2]  182 	jra	00103$
      0080B2                        183 00102$:
                                    184 ;	main.c: 66: counter = 0;
      0080B2 5F               [ 1]  185 	clrw	x
      0080B3 CF 00 04         [ 2]  186 	ldw	_tim2_demo_counter_196608_40+0, x
                                    187 ;	main.c: 67: rgb.r = 0;
      0080B6 35 00 00 01      [ 1]  188 	mov	_rgb+0, #0x00
                                    189 ;	main.c: 68: rgb.g = 0;
      0080BA 35 00 00 02      [ 1]  190 	mov	_rgb+1, #0x00
                                    191 ;	main.c: 69: rgb.b = 0;
      0080BE 35 00 00 03      [ 1]  192 	mov	_rgb+2, #0x00
                                    193 ;	main.c: 71: PB_ODR &= ~(1 << 5);
      0080C2 72 1B 50 05      [ 1]  194 	bres	0x5005, #5
      0080C6                        195 00103$:
                                    196 ;	main.c: 75: delay(655);
      0080C6 AE 02 8F         [ 2]  197 	ldw	x, #0x028f
      0080C9 CD 80 48         [ 4]  198 	call	_delay
      0080CC 20 B8            [ 2]  199 	jra	00105$
                                    200 ;	main.c: 77: }
      0080CE 81               [ 4]  201 	ret
                                    202 ;	main.c: 79: void button_hundler(struct Color *color) {
                                    203 ;	-----------------------------------------
                                    204 ;	 function button_hundler
                                    205 ;	-----------------------------------------
      0080CF                        206 _button_hundler:
      0080CF 52 04            [ 2]  207 	sub	sp, #4
      0080D1 1F 03            [ 2]  208 	ldw	(0x03, sp), x
                                    209 ;	main.c: 80: if((1 << 2) == (~PD_IDR & (1 << 2))) { // But_R+
      0080D3 C6 50 10         [ 1]  210 	ld	a, 0x5010
      0080D6 5F               [ 1]  211 	clrw	x
      0080D7 97               [ 1]  212 	ld	xl, a
      0080D8 53               [ 2]  213 	cplw	x
      0080D9 9F               [ 1]  214 	ld	a, xl
      0080DA A4 04            [ 1]  215 	and	a, #0x04
      0080DC 97               [ 1]  216 	ld	xl, a
      0080DD 4F               [ 1]  217 	clr	a
      0080DE 95               [ 1]  218 	ld	xh, a
      0080DF A3 00 04         [ 2]  219 	cpw	x, #0x0004
      0080E2 26 05            [ 1]  220 	jrne	00102$
                                    221 ;	main.c: 81: smart_increment(&color->r);
      0080E4 1E 03            [ 2]  222 	ldw	x, (0x03, sp)
      0080E6 CD 81 D2         [ 4]  223 	call	_smart_increment
      0080E9                        224 00102$:
                                    225 ;	main.c: 84: if((1 << 7) == (~PC_IDR & (1 << 7))) { // But_R-
      0080E9 C6 50 0B         [ 1]  226 	ld	a, 0x500b
      0080EC 5F               [ 1]  227 	clrw	x
      0080ED 97               [ 1]  228 	ld	xl, a
      0080EE 53               [ 2]  229 	cplw	x
      0080EF 9F               [ 1]  230 	ld	a, xl
      0080F0 A4 80            [ 1]  231 	and	a, #0x80
      0080F2 97               [ 1]  232 	ld	xl, a
      0080F3 4F               [ 1]  233 	clr	a
      0080F4 95               [ 1]  234 	ld	xh, a
      0080F5 A3 00 80         [ 2]  235 	cpw	x, #0x0080
      0080F8 26 05            [ 1]  236 	jrne	00104$
                                    237 ;	main.c: 85: smart_decrement(&color->r);
      0080FA 1E 03            [ 2]  238 	ldw	x, (0x03, sp)
      0080FC CD 81 DB         [ 4]  239 	call	_smart_decrement
      0080FF                        240 00104$:
                                    241 ;	main.c: 88: if((1 << 6) == (~PC_IDR & (1 << 6))) { // But_G+
      0080FF C6 50 0B         [ 1]  242 	ld	a, 0x500b
      008102 5F               [ 1]  243 	clrw	x
      008103 97               [ 1]  244 	ld	xl, a
      008104 53               [ 2]  245 	cplw	x
      008105 9F               [ 1]  246 	ld	a, xl
      008106 A4 40            [ 1]  247 	and	a, #0x40
      008108 97               [ 1]  248 	ld	xl, a
      008109 4F               [ 1]  249 	clr	a
                                    250 ;	main.c: 89: smart_increment(&color->g);
      00810A 16 03            [ 2]  251 	ldw	y, (0x03, sp)
      00810C 90 5C            [ 1]  252 	incw	y
      00810E 17 01            [ 2]  253 	ldw	(0x01, sp), y
                                    254 ;	main.c: 88: if((1 << 6) == (~PC_IDR & (1 << 6))) { // But_G+
      008110 95               [ 1]  255 	ld	xh, a
      008111 A3 00 40         [ 2]  256 	cpw	x, #0x0040
      008114 26 05            [ 1]  257 	jrne	00106$
                                    258 ;	main.c: 89: smart_increment(&color->g);
      008116 1E 01            [ 2]  259 	ldw	x, (0x01, sp)
      008118 CD 81 D2         [ 4]  260 	call	_smart_increment
      00811B                        261 00106$:
                                    262 ;	main.c: 92: if((1 << 5) == (~PC_IDR & (1 << 5))) { // But_G-
      00811B C6 50 0B         [ 1]  263 	ld	a, 0x500b
      00811E 5F               [ 1]  264 	clrw	x
      00811F 97               [ 1]  265 	ld	xl, a
      008120 53               [ 2]  266 	cplw	x
      008121 9F               [ 1]  267 	ld	a, xl
      008122 A4 20            [ 1]  268 	and	a, #0x20
      008124 97               [ 1]  269 	ld	xl, a
      008125 4F               [ 1]  270 	clr	a
      008126 95               [ 1]  271 	ld	xh, a
      008127 A3 00 20         [ 2]  272 	cpw	x, #0x0020
      00812A 26 05            [ 1]  273 	jrne	00108$
                                    274 ;	main.c: 93: smart_decrement(&color->g);
      00812C 1E 01            [ 2]  275 	ldw	x, (0x01, sp)
      00812E CD 81 DB         [ 4]  276 	call	_smart_decrement
      008131                        277 00108$:
                                    278 ;	main.c: 96: if((1 << 4) == (~PC_IDR & (1 << 4))) { // But_B+
      008131 C6 50 0B         [ 1]  279 	ld	a, 0x500b
      008134 5F               [ 1]  280 	clrw	x
      008135 97               [ 1]  281 	ld	xl, a
      008136 53               [ 2]  282 	cplw	x
      008137 90 5F            [ 1]  283 	clrw	y
      008139 9F               [ 1]  284 	ld	a, xl
      00813A A4 10            [ 1]  285 	and	a, #0x10
      00813C 90 97            [ 1]  286 	ld	yl, a
                                    287 ;	main.c: 97: smart_increment(&color->b);
      00813E 1E 03            [ 2]  288 	ldw	x, (0x03, sp)
      008140 5C               [ 1]  289 	incw	x
      008141 5C               [ 1]  290 	incw	x
      008142 1F 01            [ 2]  291 	ldw	(0x01, sp), x
                                    292 ;	main.c: 96: if((1 << 4) == (~PC_IDR & (1 << 4))) { // But_B+
      008144 90 A3 00 10      [ 2]  293 	cpw	y, #0x0010
      008148 26 05            [ 1]  294 	jrne	00110$
                                    295 ;	main.c: 97: smart_increment(&color->b);
      00814A 1E 01            [ 2]  296 	ldw	x, (0x01, sp)
      00814C CD 81 D2         [ 4]  297 	call	_smart_increment
      00814F                        298 00110$:
                                    299 ;	main.c: 100: if((1 << 3) == (~PC_IDR & (1 << 3))) { // But_B-
      00814F C6 50 0B         [ 1]  300 	ld	a, 0x500b
      008152 5F               [ 1]  301 	clrw	x
      008153 97               [ 1]  302 	ld	xl, a
      008154 53               [ 2]  303 	cplw	x
      008155 9F               [ 1]  304 	ld	a, xl
      008156 A4 08            [ 1]  305 	and	a, #0x08
      008158 97               [ 1]  306 	ld	xl, a
      008159 4F               [ 1]  307 	clr	a
      00815A 95               [ 1]  308 	ld	xh, a
      00815B A3 00 08         [ 2]  309 	cpw	x, #0x0008
      00815E 26 07            [ 1]  310 	jrne	00113$
                                    311 ;	main.c: 101: smart_decrement(&color->b);
      008160 1E 01            [ 2]  312 	ldw	x, (0x01, sp)
      008162 5B 04            [ 2]  313 	addw	sp, #4
      008164 CC 81 DB         [ 2]  314 	jp	_smart_decrement
      008167                        315 00113$:
                                    316 ;	main.c: 103: }
      008167 5B 04            [ 2]  317 	addw	sp, #4
      008169 81               [ 4]  318 	ret
                                    319 	.area CODE
                                    320 	.area CONST
      008028                        321 _pwm_steps:
      008028 00 00                  322 	.dw #0x0000
      00802A 00 01                  323 	.dw #0x0001
      00802C 00 02                  324 	.dw #0x0002
      00802E 00 05                  325 	.dw #0x0005
      008030 00 0B                  326 	.dw #0x000b
      008032 00 18                  327 	.dw #0x0018
      008034 00 34                  328 	.dw #0x0034
      008036 00 74                  329 	.dw #0x0074
      008038 01 00                  330 	.dw #0x0100
      00803A 02 35                  331 	.dw #0x0235
      00803C 04 DF                  332 	.dw #0x04df
      00803E 0A C1                  333 	.dw #0x0ac1
      008040 17 BF                  334 	.dw #0x17bf
      008042 34 6F                  335 	.dw #0x346f
      008044 73 C5                  336 	.dw #0x73c5
      008046 FF FE                  337 	.dw #0xfffe
                                    338 	.area INITIALIZER
                                    339 	.area CABS (ABS)
