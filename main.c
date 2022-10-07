#include "inc/main.h"

/*
 * TIM2_CH1 -> PD4
 * TIM2_CH2 -> PD3
 * TIM2_CH3 -> PA3
 * 
 * But_R+ -> PD1
 * But_R- -> PC7
 * But_G+ -> PC6
 * But_G- -> PC5
 * But_B+ -> PC4
 * But_B- -> PC3
 * */

const uint16_t pwm_steps[16] = {0, 1, 2, 5, 11, 24, 52, 116, 256,\
                     565, 1247, 2753, 6079, 13423, 29637, 65534};

static void delay(uint16_t t) {
    while(t--) {};
}

void button_hundler(struct Color *color);

struct Color rgb;

int main() {
    do { __asm sim __endasm; } while(0); // Disable interrupts
    
    clk_init();
    gpio_init();
    tim2_init();
    
    do { __asm rim __endasm; } while(0); // Enable interrupts
    
    PB_ODR |= (1 << 5);
    
    rgb.r = 0;
    rgb.g = 0;
    rgb.b = 0;
    for(;;) {
        button_hundler(&rgb);
        write_color_to_registers(&rgb);
    }
}

void button_hundler(struct Color *color) {
    if((1 << 2) == (~PD_IDR & (1 << 2))) { // But_R+
        smart_increment(&color->r);
    }

    if((1 << 7) == (~PC_IDR & (1 << 7))) { // But_R-
        smart_decrement(&color->r);
    }

    if((1 << 6) == (~PC_IDR & (1 << 6))) { // But_G+
        smart_increment(&color->g);
    }

    if((1 << 5) == (~PC_IDR & (1 << 5))) { // But_G-
        smart_decrement(&color->g);
    }
    
    if((1 << 4) == (~PC_IDR & (1 << 4))) { // But_B+
        smart_increment(&color->b);
    }
    
    if((1 << 3) == (~PC_IDR & (1 << 3))) { // But_B-
        smart_decrement(&color->b);
    }
}
