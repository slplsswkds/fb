#define FLASH_CR1       *(unsigned char*)0x505A
#define FLASH_CR2       *(unsigned char*)0x505B
#define FLASH_NCR2      *(unsigned char*)0x505C
#define FLASH_FPR       *(unsigned char*)0x505D
#define FLASH_NFPR      *(unsigned char*)0x505E
#define FLASH_IAPSR     *(unsigned char*)0x505F
#define FLASH_PUKR      *(unsigned char*)0x5062
#define FLASH_DUKR      *(unsigned char*)0x5064

#define DUL (1 << 3)
