#include "../inc/flash.h"

void eeprom_unlock() {
    FLASH_PUKR = 0x56;
    FLASH_PUKR = 0xAE;
}
