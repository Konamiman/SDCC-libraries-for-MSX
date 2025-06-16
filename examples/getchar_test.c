/* Example of a program using the getchar function adapted to MSX.

   For MSX-DOS, compile with:
   sdcc -mz80 --no-std-crt0 --code-loc 0x0110 --data-loc 0 crt0_msxdos_noargs.rel getchar_msxdos.rel putchar_msxdos.rel printf_simple.rel getchar_test.c
   objcopy -I ihex -O binary getchar_test.ihx gchtest.com

   For MSX-BASIC, compile with:
   sdcc -mz80 --no-std-crt0 --code-loc 0xA020 --data-loc 0 crt0_msxbasic.rel getchar_msxbasic.rel putchar_msxbasic.rel printf_simple.rel getchar_test.c
   objcopy -I ihex -O binary getchar_test.ihx gchtest.bin
*/

#include <stdio.h>

void main() {
    int theChar;
    printf("Press any character key: ");
    theChar = getchar();
    printf("\r\nCool! You pressed: %c\r\n", (char)theChar);
}
