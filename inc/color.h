#include "../lib/macro_tim2.h"
#include <stdint.h>
#include <math.h>


struct Color {
    uint8_t r;
    uint8_t g;
    uint8_t b;
};

// Convert 8-bit value to 16-bit via exponential function
// for linear brightness changing
uint16_t normalize_from(uint8_t *val);

void write_color_to_registers(struct Color *color);
