all : user

-include ../common.mak

user : Makefile $(OFILES)
	ld -N -m elf_i386 -e start -Ttext=0x80000000 -o user $(OFILES)

clean ::
	rm -f user
