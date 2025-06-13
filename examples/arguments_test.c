//sdcc -mz80 --no-std-crt0 --code-loc 0x0180 --data-loc 0 crt0_msxdos.rel putchar_msxdos.rel printf_simple.rel arguments_test.c

#include <stdio.h>

int main(char **argv, int argc) {
    printf("MSX-DOS arguments test\r\n\n");

    if(argc == 0) {
        printf("No arguments passed.\r\n");
    } else {
        printf("%i arguments passed:\r\n\n", argc);
        int i;
        for(i=0; i < argc; i++) {
            printf("%s\r\n", argv[i]);
        }
    }

    printf("\r\nAnd now we'll finish with user error 34\r\n(if we are in MSX-DOS 2)\r\n");
    return 34;
}
