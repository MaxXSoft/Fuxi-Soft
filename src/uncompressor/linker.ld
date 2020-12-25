OUTPUT_ARCH("riscv")
ENTRY(_start)
SECTIONS
{
  . = 0x84000000;
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
  .bss : {
    *(.bss)
    *(.sbss*)
  }
  . = ALIGN(4) + 0x1000;
  _stack_top = .;
  . = ALIGN(4);
  _end = .;
}
