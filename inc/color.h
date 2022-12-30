#include "../lib/macro_tim2.h"
#include <stdint.h>
#include <math.h>
#include "flash.h"

struct Color {
    uint8_t r;
    uint8_t g;
    uint8_t b;
};

// Convert 8-bit value to 16-bit via exponential function
// for linear brightness changing
uint16_t normalize_from(uint8_t *val);

void write_color_to_registers(struct Color *color);

// The function of adding to a variable without outing of
// range MAX uint8_t value
void smart_increment(uint8_t *val);

// the function of subtracting from a variable without 
// outing of range MIN uint8_t value
void smart_decrement(uint8_t *val);

void load_color_from_eeprom(struct Color *color, uint8_t color_cell);
void write_color_to_eeprom(struct Color *color, uint8_t color_cell);
