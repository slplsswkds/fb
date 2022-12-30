#include "../lib/macro_clk.h"
#include "../lib/macro_gpio.h"
#include "../lib/macro_tim2.h"
#include "stdint.h"
#include "stdbool.h"

#include "clk.h"
#include "gpio.h"
#include "tim2.h"
#include "color.h"
#include "flash.h"
#include "uart.h"

// extern void uart1_rx_handler(void) __interrupt(18);

void button_hundler(struct Color *color);
