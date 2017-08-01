all: romloader.gb

romloader.gb: romloader.asm gbboot.bin
	wla-gb -o romloader.o romloader.asm
	wlalink -s link_romloader romloader.gb
	rm romloader.o

gbboot.bin: gbboot.asm serialloader.bin
	wla-gb -o gbboot.o gbboot.asm
	wlalink -s -b link_gbboot gbboot.bin
	rm gbboot.o

serialloader.bin: serialloader.asm
	wla-gb -o serialloader.o serialloader.asm
	wlalink -s -b link_serialloader serialloader.bin
	rm serialloader.o

clean:
	rm romloader.gb
	rm gbboot.bin
	rm serialloader.bin
