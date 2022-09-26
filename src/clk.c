#include "../inc/clk.h"

void clk_init() {
    // Wait while HSI will be ready
    while(~CLK_ICKR & HSIRDY) {} ;
}

