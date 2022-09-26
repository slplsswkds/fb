#define CLK_ICKR        *(unsigned char*)0x50C0
#define CLK_ECKR        *(unsigned char*)0x50C1
#define CLK_CMSR        *(unsigned char*)0x50C3
#define CLK_SWR         *(unsigned char*)0x50C4
#define CLK_SWCR        *(unsigned char*)0x50C5
#define CLK_CKDIVR      *(unsigned char*)0x50C6
#define CLK_PCKENR1     *(unsigned char*)0x50C7
#define CLK_CSSR        *(unsigned char*)0x50C8
#define CLK_CCOR        *(unsigned char*)0x50C9
#define CLK_PCKENR2     *(unsigned char*)0x50CA
#define CLK_HSITRIMR    *(unsigned char*)0x50CC
#define CLK_SWIMCCR     *(unsigned char*)0x50CD

// CLK_ICKR bits
#define REGAH   (1 << 5)
#define LSIRDY  (1 << 4)
#define LSIEN   (1 << 3)
#define FHW     (1 << 2)
#define HSIRDY  (1 << 1)
#define HSIEN   (1 << 0)

// CLK_ICKR bits
// #define (1 << 7)
// #define (1 << 6)
// #define (1 << 5)
// #define (1 << 4)
// #define (1 << 3)
// #define (1 << 2)
// #define (1 << 1)
// #define (1 << 0)
