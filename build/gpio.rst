                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.2.0 #13081 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module gpio
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _gpio_init
                                     12 	.globl _btn_r_plus_is_pressed
                                     13 	.globl _btn_g_plus_is_pressed
                                     14 	.globl _btn_b_plus_is_pressed
                                     15 	.globl _btn_r_minus_is_pressed
                                     16 	.globl _btn_g_minus_is_pressed
                                     17 	.globl _btn_b_minus_is_pressed
                                     18 	.globl _btn_flash_is_pressed
                                     19 	.globl _btn_load_is_pressed
                                     20 	.globl _btn_brightness_plus_is_pressed
                                     21 	.globl _btn_brightness_minus_is_pressed
                                     22 	.globl _get_number_from_buttons
                                     23 ;--------------------------------------------------------
                                     24 ; ram data
                                     25 ;--------------------------------------------------------
                                     26 	.area DATA
                                     27 ;--------------------------------------------------------
                                     28 ; ram data
                                     29 ;--------------------------------------------------------
                                     30 	.area INITIALIZED
                                     31 ;--------------------------------------------------------
                                     32 ; absolute external ram data
                                     33 ;--------------------------------------------------------
                                     34 	.area DABS (ABS)
                                     35 
                                     36 ; default segment ordering for linker
                                     37 	.area HOME
                                     38 	.area GSINIT
                                     39 	.area GSFINAL
                                     40 	.area CONST
                                     41 	.area INITIALIZER
                                     42 	.area CODE
                                     43 
                                     44 ;--------------------------------------------------------
                                     45 ; global & static initialisations
                                     46 ;--------------------------------------------------------
                                     47 	.area HOME
                                     48 	.area GSINIT
                                     49 	.area GSFINAL
                                     50 	.area GSINIT
                                     51 ;--------------------------------------------------------
                                     52 ; Home
                                     53 ;--------------------------------------------------------
                                     54 	.area HOME
                                     55 	.area HOME
                                     56 ;--------------------------------------------------------
                                     57 ; code
                                     58 ;--------------------------------------------------------
                                     59 	.area CODE
                                     60 ;	./src/gpio.c: 3: void gpio_init() {
                                     61 ;	-----------------------------------------
                                     62 ;	 function gpio_init
                                     63 ;	-----------------------------------------
      0082CC                         64 _gpio_init:
                                     65 ;	./src/gpio.c: 6: PB_DDR |= (1 << 5);
      0082CC 72 1A 50 07      [ 1]   66 	bset	0x5007, #5
                                     67 ;	./src/gpio.c: 7: PB_CR1 |= (1 << 5);
      0082D0 72 1A 50 08      [ 1]   68 	bset	0x5008, #5
                                     69 ;	./src/gpio.c: 8: PB_CR2 &= ~(1 << 5);
      0082D4 72 1B 50 09      [ 1]   70 	bres	0x5009, #5
                                     71 ;	./src/gpio.c: 9: PB_ODR |= (1 << 5);
      0082D8 72 1A 50 05      [ 1]   72 	bset	0x5005, #5
                                     73 ;	./src/gpio.c: 13: PD_DDR |= (1 << 4);
      0082DC 72 18 50 11      [ 1]   74 	bset	0x5011, #4
                                     75 ;	./src/gpio.c: 14: PD_CR1 |= (1 << 4);
      0082E0 72 18 50 12      [ 1]   76 	bset	0x5012, #4
                                     77 ;	./src/gpio.c: 15: PD_CR2 &= ~(1 << 4);
      0082E4 72 19 50 13      [ 1]   78 	bres	0x5013, #4
                                     79 ;	./src/gpio.c: 16: PD_ODR &= ~(1 << 4);
      0082E8 72 19 50 0F      [ 1]   80 	bres	0x500f, #4
                                     81 ;	./src/gpio.c: 20: PD_DDR |= (1 << 3);
      0082EC 72 16 50 11      [ 1]   82 	bset	0x5011, #3
                                     83 ;	./src/gpio.c: 21: PD_CR1 |= (1 << 3);
      0082F0 72 16 50 12      [ 1]   84 	bset	0x5012, #3
                                     85 ;	./src/gpio.c: 22: PD_CR2 &= ~(1 << 3);
      0082F4 72 17 50 13      [ 1]   86 	bres	0x5013, #3
                                     87 ;	./src/gpio.c: 23: PD_ODR &= ~(1 << 3);
      0082F8 72 17 50 0F      [ 1]   88 	bres	0x500f, #3
                                     89 ;	./src/gpio.c: 27: PA_DDR |= (1 << 3);
      0082FC 72 16 50 02      [ 1]   90 	bset	0x5002, #3
                                     91 ;	./src/gpio.c: 28: PA_CR1 |= (1 << 3);
      008300 72 16 50 03      [ 1]   92 	bset	0x5003, #3
                                     93 ;	./src/gpio.c: 29: PA_CR2 &= ~(1 << 3);
      008304 72 17 50 04      [ 1]   94 	bres	0x5004, #3
                                     95 ;	./src/gpio.c: 30: PA_ODR &= ~(1 << 3);
      008308 72 17 50 00      [ 1]   96 	bres	0x5000, #3
                                     97 ;	./src/gpio.c: 47: PD_DDR &= ~(1 << 2); // Input 
      00830C 72 15 50 11      [ 1]   98 	bres	0x5011, #2
                                     99 ;	./src/gpio.c: 48: PD_CR1 |= (1 << 2); // Pull-Up
      008310 72 14 50 12      [ 1]  100 	bset	0x5012, #2
                                    101 ;	./src/gpio.c: 49: PD_CR2 &= ~(1 << 2); // Interrupt disabled
      008314 72 15 50 13      [ 1]  102 	bres	0x5013, #2
                                    103 ;	./src/gpio.c: 51: PC_DDR &= ~(1 << 7);
      008318 72 1F 50 0C      [ 1]  104 	bres	0x500c, #7
                                    105 ;	./src/gpio.c: 52: PC_CR1 |= (1 << 7);
      00831C 72 1E 50 0D      [ 1]  106 	bset	0x500d, #7
                                    107 ;	./src/gpio.c: 53: PC_CR2 &= ~(1 << 7);
      008320 72 1F 50 0E      [ 1]  108 	bres	0x500e, #7
                                    109 ;	./src/gpio.c: 55: PC_DDR &= ~(1 << 6);
      008324 72 1D 50 0C      [ 1]  110 	bres	0x500c, #6
                                    111 ;	./src/gpio.c: 56: PC_CR1 |= (1 << 6);
      008328 72 1C 50 0D      [ 1]  112 	bset	0x500d, #6
                                    113 ;	./src/gpio.c: 57: PC_CR2 &= ~(1 << 6);
      00832C 72 1D 50 0E      [ 1]  114 	bres	0x500e, #6
                                    115 ;	./src/gpio.c: 59: PC_DDR &= ~(1 << 5);
      008330 72 1B 50 0C      [ 1]  116 	bres	0x500c, #5
                                    117 ;	./src/gpio.c: 60: PC_CR1 |= (1 << 5);
      008334 72 1A 50 0D      [ 1]  118 	bset	0x500d, #5
                                    119 ;	./src/gpio.c: 61: PC_CR2 &= ~(1 << 5);
      008338 72 1B 50 0E      [ 1]  120 	bres	0x500e, #5
                                    121 ;	./src/gpio.c: 63: PC_DDR &= ~(1 << 4);
      00833C 72 19 50 0C      [ 1]  122 	bres	0x500c, #4
                                    123 ;	./src/gpio.c: 64: PC_CR1 |= (1 << 4);
      008340 72 18 50 0D      [ 1]  124 	bset	0x500d, #4
                                    125 ;	./src/gpio.c: 65: PC_CR2 &= ~(1 << 4);
      008344 72 19 50 0E      [ 1]  126 	bres	0x500e, #4
                                    127 ;	./src/gpio.c: 67: PC_DDR &= ~(1 << 3);
      008348 72 17 50 0C      [ 1]  128 	bres	0x500c, #3
                                    129 ;	./src/gpio.c: 68: PC_CR1 |= (1 << 3);
      00834C 72 16 50 0D      [ 1]  130 	bset	0x500d, #3
                                    131 ;	./src/gpio.c: 69: PC_CR2 &= ~(1 << 3);
      008350 72 17 50 0E      [ 1]  132 	bres	0x500e, #3
                                    133 ;	./src/gpio.c: 72: PB_DDR &= ~(1 << 4);
      008354 72 19 50 07      [ 1]  134 	bres	0x5007, #4
                                    135 ;	./src/gpio.c: 73: PB_CR1 |= (1 << 4);
      008358 72 18 50 08      [ 1]  136 	bset	0x5008, #4
                                    137 ;	./src/gpio.c: 74: PB_CR2 &= ~(1 << 4);
      00835C 72 19 50 09      [ 1]  138 	bres	0x5009, #4
                                    139 ;	./src/gpio.c: 76: PB_DDR &= ~(1 << 5);
      008360 72 1B 50 07      [ 1]  140 	bres	0x5007, #5
                                    141 ;	./src/gpio.c: 77: PB_CR1 |= (1 << 5);
      008364 72 1A 50 08      [ 1]  142 	bset	0x5008, #5
                                    143 ;	./src/gpio.c: 78: PB_CR2 &= ~(1 << 5);
      008368 72 1B 50 09      [ 1]  144 	bres	0x5009, #5
                                    145 ;	./src/gpio.c: 80: PA_DDR &= ~(1 << 1);    
      00836C 72 13 50 02      [ 1]  146 	bres	0x5002, #1
                                    147 ;	./src/gpio.c: 81: PA_CR1 |= (1 << 1);    
      008370 72 12 50 03      [ 1]  148 	bset	0x5003, #1
                                    149 ;	./src/gpio.c: 82: PA_CR2 &= ~(1 << 1);    
      008374 72 13 50 04      [ 1]  150 	bres	0x5004, #1
                                    151 ;	./src/gpio.c: 84: PA_DDR &= ~(1 << 2);    
      008378 72 15 50 02      [ 1]  152 	bres	0x5002, #2
                                    153 ;	./src/gpio.c: 85: PA_CR1 |= (1 << 2);    
      00837C 72 14 50 03      [ 1]  154 	bset	0x5003, #2
                                    155 ;	./src/gpio.c: 86: PA_CR2 &= ~(1 << 2);    
      008380 72 15 50 04      [ 1]  156 	bres	0x5004, #2
                                    157 ;	./src/gpio.c: 90: PD_DDR |= (1 << 5); // Output
      008384 72 1A 50 11      [ 1]  158 	bset	0x5011, #5
                                    159 ;	./src/gpio.c: 91: PD_CR1 |= (1 << 5); // PushPull
      008388 72 1A 50 12      [ 1]  160 	bset	0x5012, #5
                                    161 ;	./src/gpio.c: 92: PD_CR2 &= ~(1 << 5); // To 2MHz
      00838C 72 1B 50 13      [ 1]  162 	bres	0x5013, #5
                                    163 ;	./src/gpio.c: 95: PD_DDR &= ~(1 << 6); // Input
      008390 72 1D 50 11      [ 1]  164 	bres	0x5011, #6
                                    165 ;	./src/gpio.c: 96: PD_CR1 &= ~(1 << 6); // Floating
      008394 72 1D 50 12      [ 1]  166 	bres	0x5012, #6
                                    167 ;	./src/gpio.c: 97: PD_CR2 &= ~(1 << 6); // External interrupt disabled
      008398 72 1D 50 13      [ 1]  168 	bres	0x5013, #6
                                    169 ;	./src/gpio.c: 98: }
      00839C 81               [ 4]  170 	ret
                                    171 ;	./src/gpio.c: 100: uint8_t btn_r_plus_is_pressed() {
                                    172 ;	-----------------------------------------
                                    173 ;	 function btn_r_plus_is_pressed
                                    174 ;	-----------------------------------------
      00839D                        175 _btn_r_plus_is_pressed:
                                    176 ;	./src/gpio.c: 101: return((1 << 2) == (~PD_IDR & (1 << 2)));
      00839D C6 50 10         [ 1]  177 	ld	a, 0x5010
      0083A0 5F               [ 1]  178 	clrw	x
      0083A1 97               [ 1]  179 	ld	xl, a
      0083A2 53               [ 2]  180 	cplw	x
      0083A3 9F               [ 1]  181 	ld	a, xl
      0083A4 A4 04            [ 1]  182 	and	a, #0x04
      0083A6 97               [ 1]  183 	ld	xl, a
      0083A7 4F               [ 1]  184 	clr	a
      0083A8 95               [ 1]  185 	ld	xh, a
      0083A9 A3 00 04         [ 2]  186 	cpw	x, #0x0004
      0083AC 26 03            [ 1]  187 	jrne	00104$
      0083AE A6 01            [ 1]  188 	ld	a, #0x01
      0083B0 81               [ 4]  189 	ret
      0083B1                        190 00104$:
      0083B1 4F               [ 1]  191 	clr	a
                                    192 ;	./src/gpio.c: 102: }
      0083B2 81               [ 4]  193 	ret
                                    194 ;	./src/gpio.c: 104: uint8_t btn_g_plus_is_pressed() {
                                    195 ;	-----------------------------------------
                                    196 ;	 function btn_g_plus_is_pressed
                                    197 ;	-----------------------------------------
      0083B3                        198 _btn_g_plus_is_pressed:
                                    199 ;	./src/gpio.c: 105: return((1 << 6) == (~PC_IDR & (1 << 6)));
      0083B3 C6 50 0B         [ 1]  200 	ld	a, 0x500b
      0083B6 5F               [ 1]  201 	clrw	x
      0083B7 97               [ 1]  202 	ld	xl, a
      0083B8 53               [ 2]  203 	cplw	x
      0083B9 9F               [ 1]  204 	ld	a, xl
      0083BA A4 40            [ 1]  205 	and	a, #0x40
      0083BC 97               [ 1]  206 	ld	xl, a
      0083BD 4F               [ 1]  207 	clr	a
      0083BE 95               [ 1]  208 	ld	xh, a
      0083BF A3 00 40         [ 2]  209 	cpw	x, #0x0040
      0083C2 26 03            [ 1]  210 	jrne	00104$
      0083C4 A6 01            [ 1]  211 	ld	a, #0x01
      0083C6 81               [ 4]  212 	ret
      0083C7                        213 00104$:
      0083C7 4F               [ 1]  214 	clr	a
                                    215 ;	./src/gpio.c: 106: }
      0083C8 81               [ 4]  216 	ret
                                    217 ;	./src/gpio.c: 108: uint8_t btn_b_plus_is_pressed() {
                                    218 ;	-----------------------------------------
                                    219 ;	 function btn_b_plus_is_pressed
                                    220 ;	-----------------------------------------
      0083C9                        221 _btn_b_plus_is_pressed:
                                    222 ;	./src/gpio.c: 109: return((1 << 4) == (~PC_IDR & (1 << 4)));
      0083C9 C6 50 0B         [ 1]  223 	ld	a, 0x500b
      0083CC 5F               [ 1]  224 	clrw	x
      0083CD 97               [ 1]  225 	ld	xl, a
      0083CE 53               [ 2]  226 	cplw	x
      0083CF 9F               [ 1]  227 	ld	a, xl
      0083D0 A4 10            [ 1]  228 	and	a, #0x10
      0083D2 97               [ 1]  229 	ld	xl, a
      0083D3 4F               [ 1]  230 	clr	a
      0083D4 95               [ 1]  231 	ld	xh, a
      0083D5 A3 00 10         [ 2]  232 	cpw	x, #0x0010
      0083D8 26 03            [ 1]  233 	jrne	00104$
      0083DA A6 01            [ 1]  234 	ld	a, #0x01
      0083DC 81               [ 4]  235 	ret
      0083DD                        236 00104$:
      0083DD 4F               [ 1]  237 	clr	a
                                    238 ;	./src/gpio.c: 110: }
      0083DE 81               [ 4]  239 	ret
                                    240 ;	./src/gpio.c: 112: uint8_t btn_r_minus_is_pressed() {
                                    241 ;	-----------------------------------------
                                    242 ;	 function btn_r_minus_is_pressed
                                    243 ;	-----------------------------------------
      0083DF                        244 _btn_r_minus_is_pressed:
                                    245 ;	./src/gpio.c: 113: return((1 << 7) == (~PC_IDR & (1 << 7)));
      0083DF C6 50 0B         [ 1]  246 	ld	a, 0x500b
      0083E2 5F               [ 1]  247 	clrw	x
      0083E3 97               [ 1]  248 	ld	xl, a
      0083E4 53               [ 2]  249 	cplw	x
      0083E5 9F               [ 1]  250 	ld	a, xl
      0083E6 A4 80            [ 1]  251 	and	a, #0x80
      0083E8 97               [ 1]  252 	ld	xl, a
      0083E9 4F               [ 1]  253 	clr	a
      0083EA 95               [ 1]  254 	ld	xh, a
      0083EB A3 00 80         [ 2]  255 	cpw	x, #0x0080
      0083EE 26 03            [ 1]  256 	jrne	00104$
      0083F0 A6 01            [ 1]  257 	ld	a, #0x01
      0083F2 81               [ 4]  258 	ret
      0083F3                        259 00104$:
      0083F3 4F               [ 1]  260 	clr	a
                                    261 ;	./src/gpio.c: 114: }
      0083F4 81               [ 4]  262 	ret
                                    263 ;	./src/gpio.c: 116: uint8_t btn_g_minus_is_pressed() {
                                    264 ;	-----------------------------------------
                                    265 ;	 function btn_g_minus_is_pressed
                                    266 ;	-----------------------------------------
      0083F5                        267 _btn_g_minus_is_pressed:
                                    268 ;	./src/gpio.c: 117: return((1 << 5) == (~PC_IDR & (1 << 5)));
      0083F5 C6 50 0B         [ 1]  269 	ld	a, 0x500b
      0083F8 5F               [ 1]  270 	clrw	x
      0083F9 97               [ 1]  271 	ld	xl, a
      0083FA 53               [ 2]  272 	cplw	x
      0083FB 9F               [ 1]  273 	ld	a, xl
      0083FC A4 20            [ 1]  274 	and	a, #0x20
      0083FE 97               [ 1]  275 	ld	xl, a
      0083FF 4F               [ 1]  276 	clr	a
      008400 95               [ 1]  277 	ld	xh, a
      008401 A3 00 20         [ 2]  278 	cpw	x, #0x0020
      008404 26 03            [ 1]  279 	jrne	00104$
      008406 A6 01            [ 1]  280 	ld	a, #0x01
      008408 81               [ 4]  281 	ret
      008409                        282 00104$:
      008409 4F               [ 1]  283 	clr	a
                                    284 ;	./src/gpio.c: 118: }
      00840A 81               [ 4]  285 	ret
                                    286 ;	./src/gpio.c: 120: uint8_t btn_b_minus_is_pressed() {
                                    287 ;	-----------------------------------------
                                    288 ;	 function btn_b_minus_is_pressed
                                    289 ;	-----------------------------------------
      00840B                        290 _btn_b_minus_is_pressed:
                                    291 ;	./src/gpio.c: 121: return((1 << 3) == (~PC_IDR & (1 << 3)));
      00840B C6 50 0B         [ 1]  292 	ld	a, 0x500b
      00840E 5F               [ 1]  293 	clrw	x
      00840F 97               [ 1]  294 	ld	xl, a
      008410 53               [ 2]  295 	cplw	x
      008411 9F               [ 1]  296 	ld	a, xl
      008412 A4 08            [ 1]  297 	and	a, #0x08
      008414 97               [ 1]  298 	ld	xl, a
      008415 4F               [ 1]  299 	clr	a
      008416 95               [ 1]  300 	ld	xh, a
      008417 A3 00 08         [ 2]  301 	cpw	x, #0x0008
      00841A 26 03            [ 1]  302 	jrne	00104$
      00841C A6 01            [ 1]  303 	ld	a, #0x01
      00841E 81               [ 4]  304 	ret
      00841F                        305 00104$:
      00841F 4F               [ 1]  306 	clr	a
                                    307 ;	./src/gpio.c: 122: }
      008420 81               [ 4]  308 	ret
                                    309 ;	./src/gpio.c: 124: uint8_t btn_flash_is_pressed() {
                                    310 ;	-----------------------------------------
                                    311 ;	 function btn_flash_is_pressed
                                    312 ;	-----------------------------------------
      008421                        313 _btn_flash_is_pressed:
                                    314 ;	./src/gpio.c: 125: return((1 << 4) == (~PB_IDR & (1 << 4)));
      008421 C6 50 06         [ 1]  315 	ld	a, 0x5006
      008424 5F               [ 1]  316 	clrw	x
      008425 97               [ 1]  317 	ld	xl, a
      008426 53               [ 2]  318 	cplw	x
      008427 9F               [ 1]  319 	ld	a, xl
      008428 A4 10            [ 1]  320 	and	a, #0x10
      00842A 97               [ 1]  321 	ld	xl, a
      00842B 4F               [ 1]  322 	clr	a
      00842C 95               [ 1]  323 	ld	xh, a
      00842D A3 00 10         [ 2]  324 	cpw	x, #0x0010
      008430 26 03            [ 1]  325 	jrne	00104$
      008432 A6 01            [ 1]  326 	ld	a, #0x01
      008434 81               [ 4]  327 	ret
      008435                        328 00104$:
      008435 4F               [ 1]  329 	clr	a
                                    330 ;	./src/gpio.c: 126: }
      008436 81               [ 4]  331 	ret
                                    332 ;	./src/gpio.c: 128: uint8_t btn_load_is_pressed() {
                                    333 ;	-----------------------------------------
                                    334 ;	 function btn_load_is_pressed
                                    335 ;	-----------------------------------------
      008437                        336 _btn_load_is_pressed:
                                    337 ;	./src/gpio.c: 129: return((1 << 5) == (~PB_IDR & (1 << 5)));
      008437 C6 50 06         [ 1]  338 	ld	a, 0x5006
      00843A 5F               [ 1]  339 	clrw	x
      00843B 97               [ 1]  340 	ld	xl, a
      00843C 53               [ 2]  341 	cplw	x
      00843D 9F               [ 1]  342 	ld	a, xl
      00843E A4 20            [ 1]  343 	and	a, #0x20
      008440 97               [ 1]  344 	ld	xl, a
      008441 4F               [ 1]  345 	clr	a
      008442 95               [ 1]  346 	ld	xh, a
      008443 A3 00 20         [ 2]  347 	cpw	x, #0x0020
      008446 26 03            [ 1]  348 	jrne	00104$
      008448 A6 01            [ 1]  349 	ld	a, #0x01
      00844A 81               [ 4]  350 	ret
      00844B                        351 00104$:
      00844B 4F               [ 1]  352 	clr	a
                                    353 ;	./src/gpio.c: 130: }
      00844C 81               [ 4]  354 	ret
                                    355 ;	./src/gpio.c: 132: uint8_t btn_brightness_plus_is_pressed() {
                                    356 ;	-----------------------------------------
                                    357 ;	 function btn_brightness_plus_is_pressed
                                    358 ;	-----------------------------------------
      00844D                        359 _btn_brightness_plus_is_pressed:
                                    360 ;	./src/gpio.c: 133: return((1 << 1) == (~PA_IDR & (1 << 1)));
      00844D C6 50 01         [ 1]  361 	ld	a, 0x5001
      008450 5F               [ 1]  362 	clrw	x
      008451 97               [ 1]  363 	ld	xl, a
      008452 53               [ 2]  364 	cplw	x
      008453 9F               [ 1]  365 	ld	a, xl
      008454 A4 02            [ 1]  366 	and	a, #0x02
      008456 97               [ 1]  367 	ld	xl, a
      008457 4F               [ 1]  368 	clr	a
      008458 95               [ 1]  369 	ld	xh, a
      008459 A3 00 02         [ 2]  370 	cpw	x, #0x0002
      00845C 26 03            [ 1]  371 	jrne	00104$
      00845E A6 01            [ 1]  372 	ld	a, #0x01
      008460 81               [ 4]  373 	ret
      008461                        374 00104$:
      008461 4F               [ 1]  375 	clr	a
                                    376 ;	./src/gpio.c: 134: }
      008462 81               [ 4]  377 	ret
                                    378 ;	./src/gpio.c: 136: uint8_t btn_brightness_minus_is_pressed() {
                                    379 ;	-----------------------------------------
                                    380 ;	 function btn_brightness_minus_is_pressed
                                    381 ;	-----------------------------------------
      008463                        382 _btn_brightness_minus_is_pressed:
                                    383 ;	./src/gpio.c: 137: return((1 << 2) == (~PA_IDR & (1 << 2)));
      008463 C6 50 01         [ 1]  384 	ld	a, 0x5001
      008466 5F               [ 1]  385 	clrw	x
      008467 97               [ 1]  386 	ld	xl, a
      008468 53               [ 2]  387 	cplw	x
      008469 9F               [ 1]  388 	ld	a, xl
      00846A A4 04            [ 1]  389 	and	a, #0x04
      00846C 97               [ 1]  390 	ld	xl, a
      00846D 4F               [ 1]  391 	clr	a
      00846E 95               [ 1]  392 	ld	xh, a
      00846F A3 00 04         [ 2]  393 	cpw	x, #0x0004
      008472 26 03            [ 1]  394 	jrne	00104$
      008474 A6 01            [ 1]  395 	ld	a, #0x01
      008476 81               [ 4]  396 	ret
      008477                        397 00104$:
      008477 4F               [ 1]  398 	clr	a
                                    399 ;	./src/gpio.c: 138: }
      008478 81               [ 4]  400 	ret
                                    401 ;	./src/gpio.c: 140: static void delay(uint16_t t) {
                                    402 ;	-----------------------------------------
                                    403 ;	 function delay
                                    404 ;	-----------------------------------------
      008479                        405 _delay:
                                    406 ;	./src/gpio.c: 141: while(t--) {};
      008479                        407 00101$:
      008479 90 93            [ 1]  408 	ldw	y, x
      00847B 5A               [ 2]  409 	decw	x
      00847C 90 5D            [ 2]  410 	tnzw	y
      00847E 26 F9            [ 1]  411 	jrne	00101$
                                    412 ;	./src/gpio.c: 142: }
      008480 81               [ 4]  413 	ret
                                    414 ;	./src/gpio.c: 144: uint8_t get_number_from_buttons() {
                                    415 ;	-----------------------------------------
                                    416 ;	 function get_number_from_buttons
                                    417 ;	-----------------------------------------
      008481                        418 _get_number_from_buttons:
      008481 88               [ 1]  419 	push	a
                                    420 ;	./src/gpio.c: 145: uint8_t number = 0;
      008482 0F 01            [ 1]  421 	clr	(0x01, sp)
                                    422 ;	./src/gpio.c: 147: while(1) { // In future should be added timeout
      008484                        423 00116$:
                                    424 ;	./src/gpio.c: 148: delay(65535);
      008484 5F               [ 1]  425 	clrw	x
      008485 5A               [ 2]  426 	decw	x
      008486 CD 84 79         [ 4]  427 	call	_delay
                                    428 ;	./src/gpio.c: 150: if(btn_r_plus_is_pressed()) {
      008489 CD 83 9D         [ 4]  429 	call	_btn_r_plus_is_pressed
      00848C 4D               [ 1]  430 	tnz	a
      00848D 27 06            [ 1]  431 	jreq	00102$
                                    432 ;	./src/gpio.c: 151: number |= (1 << 5);
      00848F 7B 01            [ 1]  433 	ld	a, (0x01, sp)
      008491 AA 20            [ 1]  434 	or	a, #0x20
      008493 6B 01            [ 1]  435 	ld	(0x01, sp), a
      008495                        436 00102$:
                                    437 ;	./src/gpio.c: 154: if(btn_g_plus_is_pressed()) {
      008495 CD 83 B3         [ 4]  438 	call	_btn_g_plus_is_pressed
      008498 4D               [ 1]  439 	tnz	a
      008499 27 06            [ 1]  440 	jreq	00104$
                                    441 ;	./src/gpio.c: 155: number |= (1 << 4);
      00849B 7B 01            [ 1]  442 	ld	a, (0x01, sp)
      00849D AA 10            [ 1]  443 	or	a, #0x10
      00849F 6B 01            [ 1]  444 	ld	(0x01, sp), a
      0084A1                        445 00104$:
                                    446 ;	./src/gpio.c: 158: if(btn_b_plus_is_pressed()) {
      0084A1 CD 83 C9         [ 4]  447 	call	_btn_b_plus_is_pressed
      0084A4 4D               [ 1]  448 	tnz	a
      0084A5 27 06            [ 1]  449 	jreq	00106$
                                    450 ;	./src/gpio.c: 159: number |= (1 << 3);
      0084A7 7B 01            [ 1]  451 	ld	a, (0x01, sp)
      0084A9 AA 08            [ 1]  452 	or	a, #0x08
      0084AB 6B 01            [ 1]  453 	ld	(0x01, sp), a
      0084AD                        454 00106$:
                                    455 ;	./src/gpio.c: 162: if(btn_r_minus_is_pressed()) {
      0084AD CD 83 DF         [ 4]  456 	call	_btn_r_minus_is_pressed
      0084B0 4D               [ 1]  457 	tnz	a
      0084B1 27 06            [ 1]  458 	jreq	00108$
                                    459 ;	./src/gpio.c: 163: number |= (1 << 2);
      0084B3 7B 01            [ 1]  460 	ld	a, (0x01, sp)
      0084B5 AA 04            [ 1]  461 	or	a, #0x04
      0084B7 6B 01            [ 1]  462 	ld	(0x01, sp), a
      0084B9                        463 00108$:
                                    464 ;	./src/gpio.c: 166: if(btn_g_minus_is_pressed()) {
      0084B9 CD 83 F5         [ 4]  465 	call	_btn_g_minus_is_pressed
      0084BC 4D               [ 1]  466 	tnz	a
      0084BD 27 06            [ 1]  467 	jreq	00110$
                                    468 ;	./src/gpio.c: 167: number |= (1 << 1);
      0084BF 7B 01            [ 1]  469 	ld	a, (0x01, sp)
      0084C1 AA 02            [ 1]  470 	or	a, #0x02
      0084C3 6B 01            [ 1]  471 	ld	(0x01, sp), a
      0084C5                        472 00110$:
                                    473 ;	./src/gpio.c: 170: if(btn_b_minus_is_pressed()) {
      0084C5 CD 84 0B         [ 4]  474 	call	_btn_b_minus_is_pressed
      0084C8 4D               [ 1]  475 	tnz	a
      0084C9 27 05            [ 1]  476 	jreq	00112$
                                    477 ;	./src/gpio.c: 171: number |= (1 << 0);
      0084CB 04 01            [ 1]  478 	srl	(0x01, sp)
      0084CD 99               [ 1]  479 	scf
      0084CE 09 01            [ 1]  480 	rlc	(0x01, sp)
      0084D0                        481 00112$:
                                    482 ;	./src/gpio.c: 177: if(btn_load_is_pressed()) {
      0084D0 CD 84 37         [ 4]  483 	call	_btn_load_is_pressed
      0084D3 4D               [ 1]  484 	tnz	a
      0084D4 27 AE            [ 1]  485 	jreq	00116$
                                    486 ;	./src/gpio.c: 182: return number;
      0084D6 7B 01            [ 1]  487 	ld	a, (0x01, sp)
                                    488 ;	./src/gpio.c: 183: }
      0084D8 5B 01            [ 2]  489 	addw	sp, #1
      0084DA 81               [ 4]  490 	ret
                                    491 	.area CODE
                                    492 	.area CONST
                                    493 	.area INITIALIZER
                                    494 	.area CABS (ABS)
