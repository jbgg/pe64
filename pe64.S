/* pe64.S  jbgg  v0.01 */

#include <pe64.h>

    /* define exported symbols */
    .globl baseaddr, sectionalign, opthdr, opthdr_end, secthdr, secthdr_end
    .equ baseaddr, BASEADDR
    .equ sectionalign, SECTIONALIGN


    .section .hdr, "aw", @progbits
hdr_beg:
    /* msdos stub */
    .ascii "MZ\0\0"
    . = 0x3c
    .long sign - hdr_beg    /* offset to signature */


    /* PE signature */
sign:
    .ascii "PE\0\0"


    /* File header */
filehdr:
    .word 0x8664        /* machine */
    .word nSect         /* number of sections */
    .long 0             /* date/time stamp */
    .long 0             /* offset of symbol table */
    .long 0             /* # of symbols */
    .word sizeOpthdr    /* size of optional header */
    .word 0x22          /* exe = 0x0022; dll = 0x2020 */


    /* Optional header */
opthdr:
    .word 0x020b            /* magic */
    .word 0x0000            /* major/minor version */
    .long sizeCode          /* size of code */
    .long sizeInitData      /* size of init data */
    .long sizeUninitData    /* size of uninit data */
    .long entry_rva         /* RVA of entry */
    .long text_rva          /* RVA of code */
    .quad BASEADDR          /* image base */
    .long SECTIONALIGN      /* section align */
    .long FILEALIGN         /* file align */
    .long 0x5               /* major/minor OS */
    .long 0x0               /* major/minor image */
    .long 0x5               /* major/minor subsystem */
    .long 0x0               /* reserved */
    .long sizeImage         /* size of image */
    .long sizeHdr           /* size of headers */
    .long 0x0               /* checksum */
    .word 0x3               /* gui = 0x2; console = 0x3 */
    .word 0x0               /* dll characteristics */
    .quad 0x100000          /* size of stack reserve */
    .quad 0x100000          /* size of stack commit */
    .quad 0x100000          /* size of heap reserve */
    .quad 0x100000          /* size of heap commit */
    .long 0x0               /* loader flags */
    .long 0x10              /* number of entries in next table */

    /* data directories: RVA & size */
    /* export table */
    .long 0x0
    .long 0x0
    /* import table */
    .long 0x0
    .long 0x0
    /* resource table */
    .long 0x0
    .long 0x0
    /* exception table */
    .long 0x0
    .long 0x0
    /* certificate table */
    .long 0x0
    .long 0x0
    /* base reloc table */
    .long 0x0
    .long 0x0
    /* debug */
    .long 0x0
    .long 0x0
    /* architecture */
    .long 0x0
    .long 0x0
    /* global ptr */
    .long 0x0
    .long 0x0
    /* TLS table */
    .long 0x0
    .long 0x0
    /* load config table */
    .long 0x0
    .long 0x0
    /* bound import */
    .long 0x0
    .long 0x0
    /* IAT */
    .long 0x0
    .long 0x0
    /* delay import descr */
    .long 0x0
    .long 0x0
    /* com+ runtime header */
    .long 0x0
    .long 0x0
    /* reserved */
    .long 0x0
    .long 0x0
opthdr_end:


    /* section header */
secthdr:

    /* .text section entry */
    #define text_charact  0x60000020
    SECTION_ENTRY(text)
    #define data_charact  0xc0000040
    SECTION_ENTRY(data)
    #define bss_charact  0xc0000080
    SECTION_ENTRY_NOLOAD(bss)
secthdr_end:

    .align FILEALIGN
hdr_end:


    /* .text section */
    .section .text
    .globl text_beg
text_beg:
    .long .
_start:
    mov int1, %rax
    mov %rax, int2
    mov int2, %rax
    ret

    .align FILEALIGN, 0x00
text_end:


    /* .data section */
    .section .data
data_beg:
int1:  .long 0x2

    .long bss_fsize

    .align FILEALIGN, 0x00
data_end:


    /* .bss section */
    .section .bss
bss_beg:
    .comm int2, 0x4

    .align FILEALIGN, 0x00
bss_end:

