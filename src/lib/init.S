#define LED 0x1107f000
#define NUM 0x1107f010

  .globl  _start
_start:
  la      t0, handleTrap
  csrw    mtvec, t0
  la      sp, _stack_top
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
