#ifndef __SHA1_H
#define __SHA1_H

#include "../types.h"

/* The structure for storing SHS info */

typedef struct 
{
	ulong digest[ 5 ];            /* Message digest */
	ulong countLo, countHi;       /* 64-bit bit count */
	ulong thedata[ 16 ];          /* SHS data buffer */
} SHA1_CTX;

/* Message digest functions */

void SHA1_Init(SHA1_CTX *);
void SHA1_Update(SHA1_CTX *, byte *buffer, ulong count);
void SHA1_Final(byte *output, SHA1_CTX *);

#endif /* end __SHA1_H */
