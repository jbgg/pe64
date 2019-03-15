# Makefile  jbgg  v0.01 #

PROG=pe64.exe
OBJ= pe64.o
LINKSCRIPT=pe64.ld

CC=gcc
CFLAGS= 
LD=ld
LDFLAGS=

all : $(PROG)

%.o : %.S
	$(CC) -m64 -c -nostdinc -Iinclude $(CFLAGS) -o $@ $<

$(PROG) : $(OBJ) $(LINKSCRIPT)
	$(LD) $(LDFLAGS) -nostdlib -T $(LINKSCRIPT) -o $(PROG) $(OBJ)

hex : $(PROG)
	hexdump -C $(PROG) | less

clean :
	rm -rf $(PROG) $(OBJ)
	@rm -rf *~ .*~ include/*~ include/.*~


