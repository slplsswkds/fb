#include "../lib/macro_gpio.h"
#include <stdint.h>

void gpio_init();

uint8_t btn_r_plus_is_pressed();
uint8_t btn_g_plus_is_pressed();
uint8_t btn_b_plus_is_pressed();
uint8_t btn_r_minus_is_pressed();
uint8_t btn_g_minus_is_pressed();
uint8_t btn_b_minus_is_pressed();
uint8_t btn_flash_is_pressed();
uint8_t btn_load_is_pressed();
uint8_t btn_brightness_plus_is_pressed();
uint8_t btn_brightness_minus_is_pressed();

// Use R+, G+, B+, R-, G-, B- buttons
// as 5, 4, 3, 2, 1, 0 bits of number. (Bits 7, 6 deserved);
// Pressing key(X) equal setting bit(X) to 1; 
uint8_t get_number_from_buttons();

static void delay(uint16_t t);
