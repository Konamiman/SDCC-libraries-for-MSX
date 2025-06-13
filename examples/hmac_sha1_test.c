// sdcc -mz80 -c --opt-code-size sha1.c

// Example: hmac-sha1 digest of "hello" with key "secret" is 5112055C05F944F85755EFC5CD8970E194E9F45B

#include "../src/sha1/hmac_sha1.h"
#include <stdio.h>
#include <string.h>

#define BUFFER ((byte*)0x8000)

SHA1_CTX ctx;

int main(char **argv, int argc) {
    int i = 0;
    byte value;
    
    if(argc < 2) {
        printf("Usage: hshatest <string> <key>");
        return 0;
    }

    hmac_sha1(argv[1], strlen(argv[1]), argv[0], strlen(argv[0]), BUFFER);

    for(i=0; i<20; i++) {
        value = BUFFER[i];
        if(value<16) putchar('0');
        printf("%x", value);
    }

    return 0;
}
