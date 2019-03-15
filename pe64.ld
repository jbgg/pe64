/* pe64.ld  jbgg  v0.01 */

OUTPUT_FORMAT("binary")

    /* TODO: complete the list of symbols */

    /* linker script for a PE+ file
     * 
     * imported symbols:
     *  - baseaddr
     *  - sectionalign
     *  - opthdr
     *  - opthdr_end
     *
     *  - text_entry
     *  - text_entry_end
     *
     * exported symbols:
     *  - sizeOpthdr
     *  - sizeHdr
     *  - sizeCode
     *  - sizeInitData
     *  - sizeUninitData
     *  - sizeImage
     *
     *  - sizeSectEntry
     *  - nSect
     *
     *  - text_off
     *  - text_fsize
     *  - text_vsize
     *
     *  - data_off
     *  - data_fsize
     *  - data_vsize
     *
     *  - bss_off
     *  - bss_fsize
     *  - bss_vsize
     *
     *  - img_end
     */

sizeOpthdr = opthdr_end - opthdr;
sizeSecthdrEntry = text_entry_end - text_entry;
nSect = sizeSecthdr / sizeSecthdrEntry;
sizeSecthdr = secthdr_end - secthdr;
sizeHdr = SIZEOF(.hdr);
sizeCode = text_vsize;
sizeInitData = data_vsize;
sizeUninitData = bss_vsize;
sizeImage = img_end - baseaddr;

SECTIONS {
    . = baseaddr;
    .hdr : AT(0x0) {
        *(.hdr)
    }

    /* .text section */
    text_off = SIZEOF(.hdr);
    . = ( ((. + sectionalign - 1) / sectionalign) * sectionalign );
    .text  : AT( text_off ) {
        text_addr = .;
        *(*.text)
    }
    text_fsize = SIZEOF(.text);

    . = ( ((. + sectionalign - 1) / sectionalign) * sectionalign );

    text_vsize = ( ((SIZEOF(.text) + sectionalign - 1) / sectionalign) * sectionalign );

    /* .data section */
    data_off = text_off + text_fsize;
    .data  : AT( data_off ) {
        data_addr = .;
        *(*.data)
    }
    data_fsize = SIZEOF(.data);

    . = ( ((. + sectionalign - 1) / sectionalign) * sectionalign );
    data_vsize =  ( ((SIZEOF(.data) + sectionalign - 1) / sectionalign) * sectionalign );

    /* .bss section */
    bss_off = data_off + data_fsize;
    .bss : AT( bss_off ) {
        bss_addr = .;
    }
    bss_fsize = SIZEOF(.bss);

    . = ( ((. + sectionalign - 1) / sectionalign) * sectionalign );
    bss_vsize =  ( ((SIZEOF(.bss) + sectionalign - 1) / sectionalign) * sectionalign );

    img_end = .;
}

