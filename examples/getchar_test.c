#include <stdio.h>

void main() {
    int theChar;
    printf("Press any character key: ");
    theChar = getchar();
    printf("\r\nCool! You pressed: %c\r\n", (char)theChar);
}
