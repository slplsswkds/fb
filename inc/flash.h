#include "../lib/macro_flash.h"

// #define EEPROM_FIRST_ADDR 0x4000
// #define EEPROM_LAST_ADDR 0x427F
#define EEPROM_FIRST_ADDR *(uint8_t*)0x4000
#define EEPROM_LAST_ADDR *(uint8_t*)0x4274

void eeprom_unlock();
