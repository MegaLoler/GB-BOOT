# GB BOOT

_WIP_

Here's a Gameboy utility ROM to do various handy things with cartridges!  It loads itself into RAM so you can exchange cartridges and then get information about it, dump the ROM image over serial (for example, to backup to your PC), dump save data over serial, or load save data over serial, boot an executable WRAM image over serial, or branch to the inserted cartridge itself.

I hope to add flash cart programming functionality eventually as well.

## Usage

To use it just put romloader.gb on a cartridge, insert it into your Gameboy, power it on, and once it says "OK TO REMOVE CART" you can swap the cartridge for any other cartridge.

Once you've inserted another cartridge to work on, here are some things you can with it:

 * CART INFO: Display some information found in the cartridge header.
 * DUMP ROM: Reads the ROM image from the cartridge and sends it over the serial port.
 * DUMP SAVE: Reads the SRAM image from the cartridge and sends it over the serial port.
 * LOAD ROM: Receives bytes from the serial port and writes it sequentially to RAM on a RAM cartridge.
 * LOAD SAVE: Receives bytes from the serial port and writes it sequentially to SRAM.
 * ERASE FLASH: Erase the flash chip on a flash cartridge.
 * PROGRAM FLASH: Accepts bytes from the serial port and programs them sequentially to the flash chip on a flash cartridge.
 * SERIAL BOOT: Reads in 8KB from the serial port and writes it sequentially into WRAM, then branches execution to the beginning of WRAM.
 * EXECUTE CART: Branch execution to the cartridge and run it normally.
 * MEMORY ACCESS: Arbitrary read and write memory access over serial protocol: [future explanation here].
 * SERIAL CONSOLE: Basic TTY emulation over serial port. Button presses are sent as ASCII characters as well.
 * SETTINGS: Enter the settings menu for boot and serial options.

For data transfers between the Gameboy and your PC you will need some way of interfacing your PC with the serial port on your Gameboy, such as a Gameboy to UART cable: [future explanation here].

To use the flash programming functions you will need a compatible flash cartridge: [future explanation here].

To load a ROM image directly onto a cart you will need a compatible RAM cartridge: [future explanation here].

## Build

To assemble the ROM image you will need `wla-dx`.

Run `make` to assemble.

## Programs

`romloader.gb` is the inital ROM image which copies the GB BOOT image into WRAM and branches execution to it.
`gbboot.bin` is the main GB BOOT program. It is a 2KB WRAM image and is first loaded by `romloader.gb`.
`serialloader.bin` is the program that offers the SERIAL BOOT functionality. It is first loaded into VRAM (with the LCD disabled) by `gbboot.bin` and then loads a WRAM image over serial into WRAM and branches execution to it from there.

## Todo

So far only basic cart info, cart branching, and rom and save dumping have been implemented.
