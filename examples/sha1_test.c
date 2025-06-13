// sdcc -mz80 -c --opt-code-size sha1.c

// Example: sha1 hash of "hello" is AAF4C61DDCC5E8A2DABEDE0F3B482CD9AEA9434D

#include "../src/sha1/sha1.h"
#include <stdio.h>
#include <string.h>

#define BUFFER ((byte*)0x8000)

SHA1_CTX ctx;

int main(char **argv, int argc) {
    int i = 0;
    byte value;
    
    if(argc < 1) {
        printf("Usage: sha1test <string>");
        return 0;
    }

    SHA1_Init(&ctx);
    SHA1_Update(&ctx, argv[0], strlen(argv[0]));
    SHA1_Final(BUFFER, &ctx);

    for(i=0; i<20; i++) {
        value = BUFFER[i];
        if(value<16) putchar('0');
        printf("%x", value);
    }

    return 0;
}
