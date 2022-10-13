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

    //eeprom_clear_all();

    rgb.r = 0;
    rgb.g = 0;
    rgb.b = 0;
    
    eeprom_write(0, 0x0F);
    eeprom_write(1, 0x00);
    eeprom_write(2, 0xFF);

    load_color_from_eeprom(&rgb, 0);
    
    while(1) {
        button_hundler(&rgb);
        write_color_to_registers(&rgb);
    }
}

void button_hundler(struct Color *color) {
    if(btn_r_plus_is_pressed()) {
        smart_increment(&color->r);
    }

    if(btn_r_minus_is_pressed()) {
        smart_decrement(&color->r);
    }

    if(btn_g_plus_is_pressed()) {
        smart_increment(&color->g);
    }

    if(btn_g_minus_is_pressed()) {
        smart_decrement(&color->g);
    }
    
    if(btn_b_plus_is_pressed()) {
        smart_increment(&color->b);
    }
    
    if(btn_b_minus_is_pressed()) {
        smart_decrement(&color->b);
    }

    //if(btn_flash_is_pressed()) {
    //}

    if(btn_load_is_pressed()) {
        uint8_t cell_number = get_number_from_buttons();
        if(cell_number == 0) {
        }
        else {
        }

        //uart_tx_byte_array(&num, 1);
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
