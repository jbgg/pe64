# Makefile  jbgg  v0.01 #



PROG=pe64-001.exe
OBJ= pe64-001.o
LINKSCRIPT=pe64-001.ld


CC=gcc
CFLAGS= 
LD=ld
LDFLAGS=

all : $(PROG)



%.o : %.S
	$(CC) -m64 -c $(CFLAGS) -o $@ $<

$(PROG) : $(OBJ)
	$(LD) $(LDFLAGS) -T $(LINKSCRIPT) -o $(PROG) $(OBJ)

hex : $(PROG)
	hexdump -C $(PROG) | less

clean :
	rm -rf $(PROG) $(OBJ)


