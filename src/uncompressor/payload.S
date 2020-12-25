  .text
  .globl  jumpToAddr
jumpToAddr:
  fence.i
  jr      a0

  .data
  .globl  _payload_start
_payload_start:
  .incbin "payload.bin"
  .globl  _payload_end
_payload_end:
