#include "inc/main.h"

/*
 * TIM2_CH1 -> PD4
 * TIM2_CH2 -> PD3
 * TIM2_CH3 -> PA3
 * 
 * Btn_R+ -> PD2
 * Btn_R- -> PC7
 * Btn_G+ -> PC6
 * Btn_G- -> PC5
 * Btn_B+ -> PC4
 * Btn_B- -> PC3
 * 
 * Btn_FLASH -> PB4
 * Btn_LOAD -> PB5
 * */

static void delay(uint16_t t) {
    while(t--) {};
}

struct Color rgb;

int main() {
    __asm sim __endasm; // Disable interrupts
    
    clk_init();
    gpio_init();
    tim2_init();
    uart_init();
    
    char banner[5] = {'1', '2', '3', '4', '5'};
    uart_tx_byte_array(banner, 5);
    
    __asm rim __endasm; // Enable interrupts

    //eeprom_write(1, 0xCC);

    rgb.r = 0;
    rgb.g = 0;
    rgb.b = 0;
    
    while(1) {
        button_hundler(&rgb);
        write_color_to_registers(&rgb);
    }
}

void button_hundler(struct Color *color) {
    if((1 << 2) == (~PD_IDR & (1 << 2))) { // Btn_R+
        smart_increment(&color->r);
    }

    if((1 << 7) == (~PC_IDR & (1 << 7))) { // Btn_R-
        smart_decrement(&color->r);
    }

    if((1 << 6) == (~PC_IDR & (1 << 6))) { // Btn_G+
        smart_increment(&color->g);
    }

    if((1 << 5) == (~PC_IDR & (1 << 5))) { // Btn_G-
        smart_decrement(&color->g);
    }
    
    if((1 << 4) == (~PC_IDR & (1 << 4))) { // Btn_B+
        smart_increment(&color->b);
    }
    
    if((1 << 3) == (~PC_IDR & (1 << 3))) { // Btn_B-
        smart_decrement(&color->b);
    }

    if((1 << 4) == (~PB_IDR & (1 << 4))) { // Btn_FLASH
    }

    if((1 << 5) == (~PB_IDR & (1 << 5))) { // Btn_LOAD
    }
}

extern void uart1_rx_handler(void) __interrupt(18) {
    rgb.r = 0;
    rgb.g = 0;
    rgb.b = 0;
    write_color_to_registers(&rgb);
    
    UART1_SR &= ~(1 << 5); // Clear interrupt
    char byte = UART1_DR;
    uart_tx_byte(&byte);
}
