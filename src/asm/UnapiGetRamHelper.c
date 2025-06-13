#include "asm.h"

void UnapiGetRamHelper(uint* jumpTableAddress, uint* mapperTableAddress)
{
	Z80_registers regs;
	regs.Words.HL = 0;
	regs.Words.DE = 0x2222;
	regs.Bytes.A = 0xFF;

	AsmCall(0xFFCA, &regs, REGS_MAIN, REGS_MAIN);
	if(jumpTableAddress != null) {
		*jumpTableAddress=regs.Words.HL;
	}
	if(mapperTableAddress != null) {
		*mapperTableAddress=regs.Words.BC;
	}
}
