#include "lib/macro_clk.h"
#include "lib/macro_gpio.h"
#include "lib/macro_tim2.h"
#include "stdint.h"
#include "stdbool.h"

#include "inc/clk.h"
#include "inc/gpio.h"
#include "inc/tim2.h"
#include "inc/color.h"

/*
 * TIM2_CH1 -> PD4
 * TIM2_CH2 -> PD3
 * TIM2_CH3 -> PA3
 * */

const uint16_t pwm_steps[16] = {0, 1, 2, 5, 11, 24, 52, 116, 256,\
                     565, 1247, 2753, 6079, 13423, 29637, 65534};

static void delay(uint16_t t) {
    while(t--) {};
}

void tim2_demo();

int main() {
    do { __asm sim __endasm; } while(0); // Disable interrupts

    clk_init();
    gpio_init();
    tim2_init();
    
    do { __asm rim __endasm; } while(0); // Enable interrupts
    
    PB_ODR |= (1 << 5);
    
    tim2_demo();
}

void tim2_demo() {
    struct Color rgb;
    rgb.r = 0;
    rgb.g = 0;
    rgb.b = 0;

    for(;;) {
        static uint16_t counter = 0;

        write_color_to_registers(&rgb);

        if(counter < 255) {
            counter ++;
            rgb.r += 5;
            rgb.g += 5;
            rgb.b += 5;
        }
        else {
            counter = 0;
            rgb.r = 0;
            rgb.g = 0;
            rgb.b = 0;
            
            PB_ODR &= ~(1 << 5);
            //while(1);
        }

        delay(655);
    }
}
