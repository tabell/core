AS=mips-linux-gnu-as
OBJ=mips-linux-gnu-objcopy -O binary --only-section=.text
all: $(src).hex
$(src).out: $(src).a
	$(AS) $(src).a -o $(src).out
$(src).bin: $(src).out
	$(OBJ) $(src).out $(src).bin
$(src).hex: $(src).bin
	xxd -ps -c4 $(src).bin | tee $(src).hex
clean:
	rm *.bin
	rm *.out
