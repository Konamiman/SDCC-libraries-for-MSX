MAKEFLAGS += --no-builtin-rules
.SUFFIXES:

ifeq ($(strip $(N80)),)
N80=N80
endif

export N80_ARGS=--build-type sdcc --no-show-banner --verbosity 0 --output-file-case lower --accept-dot-prefix --discard-hash-prefix

define assemble
	@printf "\n\033[0;36mAssembling %s\033[0m\n\n" $(1)
	$(N80) $(1) $(2)
endef

all: printftest

printftest: pftest.com

pftest.com: printf_test.c crt0_msxdos_noargs.rel putchar_msxdos.rel printf_simple.rel
	@printf "\n\033[0;36mCompiling %s\033[0m\n\n" printf_test.c
	@sdcc -mz80 --no-std-crt0 --code-loc 0x110 --data-loc 0 crt0_msxdos_noargs.rel putchar_msxdos.rel printf_simple.rel printf_test.c
	@objcopy -I ihex -O binary printf_test.ihx pftest.com

crt0_msxdos_noargs.rel: ../crt0/crt0_msxdos_noargs.asm
	$(call assemble,../crt0/crt0_msxdos_noargs.asm)

putchar_msxdos.rel: ../char/putchar_msxdos.asm
	$(call assemble,../char/putchar_msxdos.asm)

printf_simple.rel: ../char/printf_simple.c
	@printf "\n\033[0;36mCompiling %s\033[0m\n\n" printf_simple.c
	@sdcc -mz80 -c --max-allocs-per-node 10000 --allow-unsafe-read --opt-code-size -DSUPPORT_LONG ../char/printf_simple.c

.PHONY: clean

clean:
	for ext in asm com rel sym ihx lk lst map noi; do find . -type f -name "*.$$ext" -delete; done
