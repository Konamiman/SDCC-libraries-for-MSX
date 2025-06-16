/* Example of a program using the base64 library.

   Compile with:
   sdcc -mz80 --no-std-crt0 --code-loc 0x0180 --data-loc 0 crt0_msxdos.rel base64.rel putchar_msxdos.rel printf_simple.rel base64_test.c
   objcopy -I ihex -O binary base64_test.ihx b64test.com
*/

#include "../src/base64/base64.h"
#include <stdio.h>
#include <string.h>

#define BUFFER ((byte*)0x8000)

int main(char **argv, int argc) {
    int size = 0;
    
    if(argc < 2) {
        printf("Usage: b64test [d|e] <string>");
        return 0;
    }

    Base64Init(80);
    if(argv[0][0] == 'e') {
        size = Base64EncodeChunk(argv[1], BUFFER, strlen(argv[1]), true);
    }
    else if(argv[0][0] == 'd') {
        byte error;
        size = Base64DecodeChunk(argv[1], BUFFER, strlen(argv[1]), true, &error);
        if(error) {
            printf("*** Error: %i", error);
            return 1;
        }
    }
    else {
        printf("Usage: b64test [d|e] <string>");
        return 0;
    }

    BUFFER[size] = 0;
    printf(BUFFER);

    return 0;
}
