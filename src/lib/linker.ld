OUTPUT_ARCH("riscv")
ENTRY(_start)
SECTIONS
{
  . = 0x80000000;
  .text : {
    *(.text.init)
    *(.text)
    *(.text*)
  }
  .rodata : {
    *(.rodata)
    *(.rodata*)
  }
  .data : {
    *(.data)
    *(.data*)
    *(.sdata)
  }
  _bss_start = .;
  .bss : {
    *(.bss)
    *(.sbss*)
  }
  _bss_end = .;
  . = ALIGN(4) + 0x1000;
  _stack_top = .;
}
