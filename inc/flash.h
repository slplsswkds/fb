#include "../lib/macro_flash.h"
#include <stdint.h>

#define EEPROM_FIRST_ADDR 0x4000
#define EEPROM_LAST_ADDR 0x427F

void eeprom_unlock();

void eeprom_write(uint16_t mem_cell, uint8_t data);
