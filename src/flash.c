#include "../inc/flash.h"

void eeprom_unlock() {
    FLASH_PUKR = 0x56;
    FLASH_PUKR = 0xAE;
}

void write_to_eeprom(void) {
    if (!(FLASH_IAPSR & 0x02))
    {
        // unlock EEPROM
        FLASH_DUKR = 0xAE;
        FLASH_DUKR = 0x56;
    }
    // wait for acces to write
    while (!(FLASH_IAPSR & DUL));

    EEPROM_FIRST_ADDR = 0xff;

    FLASH_IAPSR &= ~(DUL);      // lock EEPROM
}
