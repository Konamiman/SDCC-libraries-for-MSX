/*
   Simplified printf and sprintf functions for SDCC+Z80 - by Konamiman

   This version is about 1.5K smaller than the one contained
   in the z80 library supplied with SDCC.

   To compile:
   sdcc -mz80 -c --max-allocs-per-node 100000 --allow-unsafe-read --opt-code-size [-DSUPPORT_LONG] printf_simple.c

   Add -DSUPPORT_LONG to enable support for long integers.
   
   Supported format specifiers:

   %d or %i: signed int
   %u: unsigned int
   %x: hexadecimal int
   %c: character
   %s: string
   %%: a % character

   Also if support for long integers is enabled:

   %l: signed long
   %lu: unsigned long
   %lx: hexadecimal long
*/

#pragma disable_warning 85

#include <stdarg.h>

extern void putchar(int);

#ifdef SUPPORT_LONG
extern void __ultoa(long val, char* buffer, char base);
extern void __ltoa(long val, char* buffer, char base);
#endif
extern void __uitoa(int val, char* buffer, char base);
extern void __itoa(int val, char* buffer, char base);

static int format_string(const char* buf, const char *fmt, va_list ap);

int printf(const char *fmt, ...)
{
  va_list arg;
  va_start(arg, fmt);
  return format_string(0, fmt, arg);
}

int sprintf(const char* buf, const char* fmt, ...)
{
  va_list arg;
  va_start(arg, fmt);
  return format_string(buf, fmt, arg);
}

static void do_char(char c) __naked
{
  __asm

  ld c,a
  ld de,(_bufPnt)
  ld a,d
  or e
  ld l,c
  jp z,_putchar
  ld a,l
  ld (de),a
  inc de
  ld (_bufPnt),de
  ret

  __endasm;
}

#define do_char_inc(c) {do_char(c); count++;}

static char *bufPnt;
static char *fmtPnt;
static char *strPnt;
#ifdef SUPPORT_LONG
char* prevFmtPnt;
#endif

static int format_string(char* buf, char *fmt, va_list ap)
{
  char base;
#ifdef SUPPORT_LONG
  char isLong;
#endif
  char isUnsigned;
  long val;
  static char buffer[16];
  char theChar;
  int count=0;

  fmtPnt = fmt;
  bufPnt = buf;

  while((theChar = *fmtPnt)!=0)
  {
  #ifdef SUPPORT_LONG
    isLong = 0;
  #endif
    isUnsigned = 0;
    base = 10;

    fmtPnt++;

    if(theChar != '%') {
      do_char_inc(theChar);
      continue;
    }

    theChar = *fmtPnt;
    fmtPnt++;

    if(theChar == 's')
    {
      strPnt = va_arg(ap, char *);
      while((theChar = *strPnt++) != 0) 
        do_char_inc(theChar);

      continue;
    } 

    if(theChar == 'c')
    {
      val = va_arg(ap, int);
      do_char_inc((char) val);

      continue;
    } 

#ifdef SUPPORT_LONG
    if(theChar == 'l')
    {
      isLong = 1;
      theChar = *fmtPnt;
      prevFmtPnt = fmtPnt;
      fmtPnt++;
    }
#endif

    if(theChar == 'x') {
      base = 16;
    }
    else if(theChar == 'u') {
      isUnsigned = 1;
    }

#ifdef SUPPORT_LONG
    else if(isLong) {
      fmtPnt = prevFmtPnt;
      theChar = *fmtPnt;
    }
#endif
    else if(theChar != 'd' && theChar != 'i') {
      do_char_inc(theChar);
      continue;
    }

#ifdef SUPPORT_LONG
    if(isLong)
      val = va_arg(ap, long);
    else
      val = va_arg(ap, int);

    if(isUnsigned && isLong)
      __ultoa(val, buffer, base);
    else if(isUnsigned)
      __uitoa(val, buffer, base);
    else if(isLong)
      __ltoa(val, buffer, base);
    else
      __itoa(val, buffer, base);
#else
    val = va_arg(ap, int);
    
    if(isUnsigned)
      __uitoa(val, buffer, base);
    else
      __itoa(val, buffer, base);
#endif

    strPnt = buffer;
    while((theChar = *strPnt++) != 0) 
      do_char_inc(theChar);
  }

  if(bufPnt) *bufPnt = '\0';

  return count;
}
