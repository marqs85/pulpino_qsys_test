CC = riscv64-unknown-elf-gcc
ELFSIZE = riscv64-unknown-elf-size
OBJCOPY = riscv64-unknown-elf-objcopy

CFLAGS = -Os -march=rv32imc -mabi=ilp32 -fdata-sections -ffunction-sections -fshort-enums -fgnu89-inline -Wall
LDFLAGS = -Wl,--gc-sections -Tlink.riscv.ld --specs=nano.specs -nostartfiles
LIBS =

SRCS = hello.c crt0.boot.S


.PHONY: all
all: mem_init_generate

hello.elf: $(SRCS)
	$(CC) -o $@ $^ $(CFLAGS) $(LDFLAGS)
	$(ELFSIZE) $@

mem_init/sys_onchip_memory2_0.hex: hello.elf
	$(OBJCOPY) --change-addresses -0x8000 -O binary --gap-fill 0 $< mem_init/sys_onchip_memory2_0.bin
	../tools/bin2hex mem_init/sys_onchip_memory2_0.bin mem_init/sys_onchip_memory2_0.hex

.PHONY: mem_init_generate
mem_init_generate: mem_init/sys_onchip_memory2_0.hex

.PHONY: rv-reprogram
rv-reprogram: mem_init_generate
	system-console -cli --script ../scripts/rv-reprogram.tcl

.PHONY: clean
clean:
	rm -f *.elf mem_init/*.hex mem_init/*.bin
