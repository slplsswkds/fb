#define UART1_SR    *(unsigned char*)0x5230
#define UART1_DR    *(unsigned char*)0x5231
#define UART1_BRR1  *(unsigned char*)0x5232
#define UART1_BRR2  *(unsigned char*)0x5233
#define UART1_CR1   *(unsigned char*)0x5234
#define UART1_CR2   *(unsigned char*)0x5235
#define UART1_CR3   *(unsigned char*)0x5236
#define UART1_CR4   *(unsigned char*)0x5237
#define UART1_CR5   *(unsigned char*)0x5238
#define UART1_GTR   *(unsigned char*)0x5239
#define UART1_PSCR  *(unsigned char*)0x523A

// UART1_SR bits
#define TXE     (1 << 7)
#define TC      (1 << 6)
#define RXNE    (1 << 5)
#define IDLE    (1 << 4)
#define OR_LHE  (1 << 3)
#define NF      (1 << 2)
#define FE      (1 << 1)
#define PE      (1 << 0)

// UART1_CR1 bits
#define R8      (1 << 7)
#define T8      (1 << 6)
#define UARTD   (1 << 5)
#define M       (1 << 4)
#define WAKE    (1 << 3)
#define PCEN    (1 << 2)
#define PS      (1 << 1)
#define PIEN    (1 << 0)

// UART1_CR2 bits
#define TIEN    (1 << 7)
#define TCIEN   (1 << 6)
#define RIEN    (1 << 5)
#define ILIEN   (1 << 4)
#define TEN     (1 << 3)
#define REN     (1 << 2)
#define RWU     (1 << 1)
#define SBK     (1 << 0)
