/* Example of a program using the simplified printf function.

   For MSX-DOS, compile with:
   sdcc -mz80 --no-std-crt0 --code-loc 0x0110 --data-loc 0 crt0_msxdos_noargs.rel putchar_msxdos.rel printf_simple.rel printf_test.c
   objcopy -I ihex -O binary printf_test.ihx pftest.com

   For MSX-BASIC, compile with:
   sdcc -mz80 --no-std-crt0 --code-loc 0xA020 --data-loc 0 crt0_msxbasic.rel putchar_msxbasic.rel printf_simple.rel printf_test.c
   objcopy -I ihex -O binary printf_test.ihx pftest.bin
*/

#include <stdio.h>

void main() {
    printf("printf test\r\n");
    
    printf("\r\n");
    printf("10000 as %%d: %d\r\n", 10000);
    printf("10000 as %%i: %i\r\n", 10000);
    printf("10000 as %%x: %x\r\n", 10000);
    printf("10000 as %%u: %u\r\n", (unsigned int)10000);
    printf("10000 as %%l: %l\r\n", (long)10000);
    printf("10000 as %%lu: %lu\r\n", (unsigned long)10000);
    printf("10000 as %%lx: %lx\r\n", (long)10000);

    printf("\r\n");
    printf("34000 as %%x: %x\r\n", 34000);
    printf("34000 as %%u: %u\r\n", (unsigned int)34000);
    printf("34000 as %%l: %l\r\n", (long)34000);
    printf("34000 as %%lu: %lu\r\n", (unsigned long)34000);
    printf("34000 as %%lx: %lx\r\n", (long)34000);

    printf("\r\n");
    printf("-10000 as %%d: %d\r\n", -10000);
    printf("-10000 as %%i: %i\r\n", -10000);
    printf("-10000 as %%x: %x\r\n", -10000);
    printf("-10000 as %%l: %l\r\n", (long)-10000);
    printf("-10000 as %%lx: %lx\r\n", (long)-10000);

    printf("\r\n");
    printf("-34000 as %%x: %x\r\n", -34000);
    printf("-34000 as %%l: %l\r\n", (long)-34000);
    printf("-34000 as %%lx: %lx\r\n", (long)-34000);

    printf("\r\n");
    printf("1000000 as %%l: %l\r\n", (long)1000000);
    printf("1000000 as %%lu: %lu\r\n", (unsigned long)1000000);
    printf("1000000 as %%lx: %lx\r\n", (long)1000000);

    printf("\r\n");
    printf("3400000 as %%l: %l\r\n", (long)3400000);
    printf("3400000 as %%lu: %lu\r\n", 3400000);
    printf("3400000 as %%lx: %lx\r\n", (long)3400000);

    printf("\r\n");
    printf("-1000000 as %%l: %l\r\n", (long)-1000000);
    printf("-1000000 as %%lx: %lx\r\n", (long)-1000000);

    printf("\r\n");
    printf("-3400000 as %%l: %l\r\n", (long)-3400000);
    printf("-3400000 as %%lx: %lx\r\n", (long)-3400000);

    printf("\r\n");
    printf("Printing a char: %c\r\n", '*');
    printf("Printing a string: %s\r\n", "Hello!");
}
