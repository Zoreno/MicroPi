#
# Config
# 
CC_PREFIX=./cross-cc/bin/arm-none-eabi-
CC=$(CC_PREFIX)gcc
OC=$(CC_PREFIX)objcopy
ST=$(CC_PREFIX)strip

OBJECTS=boot.o kernel.o
ELF=kernel.elf
IMAGE=kernel7.img
LINKER_SCRIPT=linker.ld

ASFLAGS=-mcpu=cortex-a7 -ffreestanding
CFLAGS=-mcpu=cortex-a7 -ffreestanding -std=gnu99 -Os -Wall -Wextra -Wno-unused-parameter -ffunction-sections -fdata-sections -fno-plt -fno-pic
LDFLAGS=-T $(LINKER_SCRIPT) -ffreestanding -Os -Wl,--gc-sections -nostdlib -nodefaultlibs
STRIPFLAGS=-s -R .comment -R .gnu.version --strip-unneeded

.PHONY: clean run all

all: $(IMAGE)

#
# Rules
# 
%.o: %.S Makefile
	$(CC) $(ASFLAGS) -c $< -o $@

%.o: %.c Makefile
	$(CC) $(CFLAGS) -c $< -o $@

# The unstripped executable
$(ELF).temp: $(OBJECTS) $(LINKER_SCRIPT) Makefile
	$(CC) $(LDFLAGS) -o $(ELF).temp $(OBJECTS)

$(ELF): $(ELF).temp Makefile
	$(ST) $(STRIPFLAGS) -o $(ELF) $(ELF).temp

$(IMAGE): $(ELF) Makefile
	$(OC) $(ELF) -O binary $(IMAGE)

run: $(IMAGE)
	qemu-system-arm -m 1G -M raspi2 -serial stdio -kernel kernel.elf

clean:
	-rm *.o $(IMAGE) $(ELF) $(ELF).temp
