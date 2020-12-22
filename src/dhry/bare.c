#include "printf.h"

#define UART_LSR    (*(volatile unsigned int *)0x11041014)
#define UART_DAT    (*(volatile unsigned int *)0x11041000)
#define UART_LSR_RI 0x40

#define TIMER       (*(volatile unsigned int *)0x1107e000)

#define READ_CSR(reg)                             \
  ({                                              \
    unsigned int __tmp;                           \
    asm volatile("csrr %0, " #reg : "=r"(__tmp)); \
    __tmp;                                        \
  })

int mem[128];
unsigned int alloced = 0;

void PutChar(char c) {
  while (!(UART_LSR & UART_LSR_RI));
  UART_DAT = c;
}

void PrintPerfInfo() {
  unsigned int mcycle = READ_CSR(mcycle);
  unsigned int mcycleh = READ_CSR(mcycleh);
  unsigned int minstret = READ_CSR(minstret);
  unsigned int minstreth = READ_CSR(minstreth);
  printf("cycle: %x%08x, instret: %x%08x\n",
         mcycleh, mcycle, minstreth, minstret);
}

long time(long *p) {
  return TIMER;
}

char *malloc(unsigned int size) {
  char *cur = (char *)(mem + alloced);
  alloced += (size + 3) / 4;
  return cur;
}

char *strcpy(char *dest, const char *src) {
  char *ret = dest;
  while (*src) *dest++ = *src++;
  *dest = '\0';
  return ret;
}

int strcmp(const char *lhs, const char *rhs) {
  while (*lhs == *rhs && *lhs) {
    ++lhs;
    ++rhs;
  }
  return *lhs - *rhs;
}

void *memcpy(void *dest, const void *src, unsigned int count) {
  for (unsigned int i = 0; i < count; ++i) {
    ((char *)dest)[i] = ((const char *)src)[i];
  }
  return dest;
}
