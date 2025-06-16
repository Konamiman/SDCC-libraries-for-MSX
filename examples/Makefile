### Makefile for the example programs

## Run "USE_N80=1 make" to use Nestor80 instead of sdasz80 to assemble .asm files.
## Run "N80=path/to/N80 make" if the Nestor80 binary is not in the path.
## Run "make clean" to delete all the files

## This makefile pretty much assumes that Linux is the underlying OS.
## If you use Windows (10+) the recommended approach is to setup WSL
## (https://learn.microsoft.com/en-us/windows/wsl/install), setup SDCC
## and optionally Nestor80 in Linux, and then run "wsl make".

## To convert .ihx files to binary files the objcopy tool is used, it's part
## of the GNU binary utils package (install in Ubuntu: sudo apt-get binutils)


# Disable default make stuff that we don't need

MAKEFLAGS += --no-builtin-rules
.SUFFIXES:


# Parse input (if any) and define macros

ifeq ($(strip $(N80)),)
N80=N80
endif

ifeq ($(strip $(USE_N80)),)
USE_N80=0
endif

export N80_ARGS=--build-type sdcc --no-show-banner --verbosity 0 --output-file-case lower --accept-dot-prefix --discard-hash-prefix

ifeq ($(strip $(USE_N80)),0)
$(info Using SDASZ80 for assembling)
define assemble_core
	@sdasz80 -o $(2) $(1)
endef
else
$(info Using N80 for assembling)
define assemble_core
	@$(N80) $(1) $(2)
endef
endif

define assemble
	@printf "\n\033[0;36mAssembling %s\033[0m\n\n" $(1)
	$(call assemble_core, $(1), $(2))
endef


# These are the programs generated

all: printftest getchartest argstest base64test sha1test hmacsha1test c-type

printftest: pftest.com pftest.bin
getchartest: gchtest.com gchtest.bin
argstest: argstest.com
base64test: b64test.com
sha1test: sha1test.com
hmacsha1test: hshatest.com
c-type: ctype.com


# Rules for the main programs

pftest.com: printf_test.c crt0_msxdos_noargs.rel putchar_msxdos.rel printf_simple.rel
	@printf "\n\033[0;36mCompiling %s\033[0m\n\n" printf_test.c
	@sdcc -mz80 --no-std-crt0 --code-loc 0x0110 --data-loc 0 crt0_msxdos_noargs.rel putchar_msxdos.rel printf_simple.rel printf_test.c
	@objcopy -I ihex -O binary printf_test.ihx pftest.com

pftest.bin: printf_test.c crt0_msxbasic.rel putchar_msxbasic.rel printf_simple.rel
	@printf "\n\033[0;36mCompiling %s\033[0m\n\n" printf_test.c
	@sdcc -mz80 --no-std-crt0 --code-loc 0xA020 --data-loc 0 crt0_msxbasic.rel putchar_msxbasic.rel printf_simple.rel printf_test.c
	@objcopy -I ihex -O binary printf_test.ihx pftest.bin

gchtest.com: getchar_test.c getchar_msxdos.rel crt0_msxdos_noargs.rel putchar_msxdos.rel printf_simple.rel
	@printf "\n\033[0;36mCompiling %s\033[0m\n\n" gchtest.com
	@sdcc -mz80 --no-std-crt0 --code-loc 0x0110 --data-loc 0 crt0_msxdos_noargs.rel getchar_msxdos.rel putchar_msxdos.rel printf_simple.rel getchar_test.c
	@objcopy -I ihex -O binary getchar_test.ihx gchtest.com

gchtest.bin: getchar_test.c crt0_msxbasic.rel getchar_msxbasic.rel putchar_msxbasic.rel printf_simple.rel
	@printf "\n\033[0;36mCompiling %s\033[0m\n\n" gchtest.bin
	@sdcc -mz80 --no-std-crt0 --code-loc 0xA020 --data-loc 0 crt0_msxbasic.rel getchar_msxbasic.rel putchar_msxbasic.rel printf_simple.rel getchar_test.c
	@objcopy -I ihex -O binary getchar_test.ihx gchtest.bin

argstest.com: arguments_test.c crt0_msxdos.rel putchar_msxdos.rel printf_simple.rel
	@printf "\n\033[0;36mCompiling %s\033[0m\n\n" arguments_test.c
	@sdcc -mz80 --no-std-crt0 --code-loc 0x0180 --data-loc 0 crt0_msxdos.rel putchar_msxdos.rel printf_simple.rel arguments_test.c
	@objcopy -I ihex -O binary arguments_test.ihx argstest.com

b64test.com: base64_test.c base64.rel crt0_msxdos.rel putchar_msxdos.rel printf_simple.rel
	@printf "\n\033[0;36mCompiling %s\033[0m\n\n" base64_test.c
	@sdcc -mz80 --no-std-crt0 --code-loc 0x0180 --data-loc 0 crt0_msxdos.rel base64.rel putchar_msxdos.rel printf_simple.rel base64_test.c
	@objcopy -I ihex -O binary base64_test.ihx b64test.com

sha1test.com: sha1_test.c sha1.rel crt0_msxdos.rel putchar_msxdos.rel printf_simple.rel
	@printf "\n\033[0;36mCompiling %s\033[0m\n\n" sha1_test.c
	@sdcc -mz80 --no-std-crt0 --code-loc 0x0180 --data-loc 0 crt0_msxdos.rel sha1.rel putchar_msxdos.rel printf_simple.rel sha1_test.c
	@objcopy -I ihex -O binary sha1_test.ihx sha1test.com

hshatest.com: hmac_sha1_test.c sha1.rel hmac_sha1.rel crt0_msxdos.rel putchar_msxdos.rel printf_simple.rel
	@printf "\n\033[0;36mCompiling %s\033[0m\n\n" hmac_sha1_test.c
	@sdcc -mz80 --no-std-crt0 --code-loc 0x0180 --data-loc 0 crt0_msxdos.rel hmac_sha1.rel sha1.rel putchar_msxdos.rel printf_simple.rel hmac_sha1_test.c
	@objcopy -I ihex -O binary hmac_sha1_test.ihx hshatest.com

ctype.com: c-type.c asm_call.rel DosCall.rel crt0_msxdos.rel
	@printf "\n\033[0;36mCompiling %s\033[0m\n\n" c-type.c
	@sdcc -mz80 --no-std-crt0 --code-loc 0x0180 --data-loc 0 --disable-warning 196 crt0_msxdos.rel asm_call.rel DosCall.rel c-type.c
	@objcopy -I ihex -O binary c-type.ihx ctype.com


# Rules for the dependencies

crt0_msxdos_noargs.rel: ../src/crt0/crt0_msxdos_noargs.asm
	$(call assemble,../src/crt0/crt0_msxdos_noargs.asm,crt0_msxdos_noargs.rel)

crt0_msxdos.rel: ../src/crt0/crt0_msxdos.asm
	$(call assemble,../src/crt0/crt0_msxdos.asm,crt0_msxdos.rel)

crt0_msxbasic.rel: ../src/crt0/crt0_msxbasic.asm
	$(call assemble,../src/crt0/crt0_msxbasic.asm,crt0_msxbasic.rel)

putchar_msxdos.rel: ../src/char/putchar_msxdos.asm
	$(call assemble,../src/char/putchar_msxdos.asm,putchar_msxdos.rel)

putchar_msxbasic.rel: ../src/char/putchar_msxbasic.asm
	$(call assemble,../src/char/putchar_msxbasic.asm,putchar_msxbasic.rel)

getchar_msxdos.rel: ../src/char/getchar_msxdos.asm
	$(call assemble,../src/char/getchar_msxdos.asm,getchar_msxdos.rel)

getchar_msxbasic.rel: ../src/char/getchar_msxbasic.asm
	$(call assemble,../src/char/getchar_msxbasic.asm,getchar_msxbasic.rel)

base64.rel: ../src/base64/base64.asm
	$(call assemble,../src/base64/base64.asm,base64.rel)

sha1.rel: ../src/sha1/sha1.c
	@printf "\n\033[0;36mCompiling %s\033[0m\n\n" sha1.c
	@sdcc -mz80 -c --opt-code-size ../src/sha1/sha1.c

hmac_sha1.rel: ../src/sha1/hmac_sha1.c
	@printf "\n\033[0;36mCompiling %s\033[0m\n\n" sha1.c
	@sdcc -mz80 -c --opt-code-size --disable-warning 196 ../src/sha1/hmac_sha1.c

printf_simple.rel: ../src/char/printf_simple.c
	@printf "\n\033[0;36mCompiling %s\033[0m\n\n" printf_simple.c
	@sdcc -mz80 -c --max-allocs-per-node 10000 --allow-unsafe-read --opt-code-size -DSUPPORT_LONG ../src/char/printf_simple.c

asm_call.rel: ../src/asm/asm_call.asm
	$(call assemble,../src/asm/asm_call.asm,asm_call.rel)

DosCall.rel: ../src/asm/DosCall.c
	@printf "\n\033[0;36mCompiling %s\033[0m\n\n" DosCall.c
	@sdcc -mz80 -c --opt-code-size ../src/asm/DosCall.c


# Cleanup (deletes all the files generated by the build process)

.PHONY: clean

clean:
	@for ext in asm com bin rel sym ihx lk lst map noi; do find . -type f -name "*.$$ext" -delete; done
