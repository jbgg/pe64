/* pe64.h  jbgg  v0.01 */

#ifndef __PE64_H__
#define __PE64_H__

#define BASEADDR        0x00400000
#define SECTIONALIGN    0x00001000
#define FILEALIGN       0x00000200

#define RVA(v) (v - BASEADDR)

#define ALIGN2FILE(a)               \
( (((a) + FILEALIGN - 1) / FILEALIGN) * FILEALIGN )

#define SECTION_ENTRY(name)                 \
 .globl name ## _entry, name ## _entry_end; \
name ## _entry:                             \
 .ascii "." #name "";                       \
 . = name ## _entry + 8;                    \
 .long name ## _vsize;                      \
 .long name ## _beg - BASEADDR;             \
 .long name ## _fsize;                      \
 .long name ## _off;                        \
 .long 0x0;                                 \
 .long 0x0;                                 \
 .word 0x0;                                 \
 .word 0x0;                                 \
 .long name ## _charact;                    \
name ## _entry_end:


#define SECTION_ENTRY_NOLOAD(name)          \
 .globl name ## _entry, name ## _entry_end; \
name ## _entry:                             \
 .ascii "." #name "";                       \
 . = name ## _entry + 8;                    \
 .long name ## _vsize;                      \
 .long name ## _beg - BASEADDR;             \
 .long 0x0;                                 \
 .long 0x0;                                 \
 .long 0x0;                                 \
 .long 0x0;                                 \
 .word 0x0;                                 \
 .word 0x0;                                 \
 .long name ## _charact;                    \
name ## _entry_end:

#define entry_rva RVA(_start)
#define text_rva RVA(text_beg)

#endif /* __PE64_H__ */

