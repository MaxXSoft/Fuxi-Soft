#define LED 0x1107f000
#define NUM 0x1107f010

  .section .text.init
  .globl  _start
_start:
  # setup trap handler
  la      t0, handleTrap
  csrw    mtvec, t0
  # setup stack
  la      sp, _stack_top
  # clear bss
  la      t0, _bss_start
  la      t1, _bss_end
1:
  beq     t0, t1, 2f
  sb      zero, 0(t0)
  addi    t0, t0, 1
  j       1b
2:
  # jump to entry
  j       entry


  .globl  handleTrap
handleTrap:
  li      t0, LED
  csrr    t1, mcause
  sw      t1, 0(t0)
  li      t0, NUM
  csrr    t1, mepc
  sw      t1, 0(t0)
1:
  j       1b
