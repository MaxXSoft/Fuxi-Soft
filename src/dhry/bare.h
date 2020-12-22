#ifndef FUXISOFT_DHRY_BARE_H_
#define FUXISOFT_DHRY_BARE_H_

void PutChar(char c);
void PrintPerfInfo();

long time(long *p);
char *malloc(unsigned int size);
char *strcpy(char *dest, const char *src);
int strcmp(const char *lhs, const char *rhs);
void *memcpy(void *dest, const void *src, unsigned int count);

#endif  // FUXISOFT_DHRY_BARE_H_
