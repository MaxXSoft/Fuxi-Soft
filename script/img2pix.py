from PIL import Image
import sys


def conv_to_array(file_name):
  img = Image.open(file_name)
  w, h = img.size
  print(f'static const unsigned int kImgWidth = {w}, kImgHeight = {h};')
  print('static const unsigned char kPixels[] = {')
  ppl = 8
  for i, (r, g, b) in enumerate(img.getdata()):
    if i % ppl == 0:
      print('  ', end='')
    print(f'{b}, {g}, {r}, ', end='')
    if i % ppl == ppl - 1:
      print()
  if (len(img.getdata()) - 1) % ppl != ppl - 1:
    print()
  print('};')


def gen_draw_inst(x, y, c):
  inst = []
  c -= 1
  d = 1 << 7
  if c > 1023:
    d |= 1 << 6
  d |= ((x >> 8) & 3) << 4
  d |= ((y >> 8) & 3) << 2
  if c > 1023:
    d |= ((c >> 16) & 3)
  else:
    d |= ((c >> 8) & 3)
  inst.append(d)
  inst.append(x & 0xff)
  inst.append(y & 0xff)
  inst.append(c & 0xff)
  if c > 1023:
    inst.append((c >> 8) & 0xff)
  return inst


def gen_insts(img):
  inst = []
  w, h = img.size
  bits = [sum(rgb) >= 127 * len(rgb) for rgb in img.getdata()]
  # generate first fill instruction
  inst_fill = sum(bits) > w * h / 2
  inst.append(int(inst_fill))
  # generate draw instructions
  i, x, y, c = 0, 0, 0, 0
  while i < len(bits):
    if bits[i] != inst_fill:
      if c:
        c += 1
      else:
        x, y, c = i % w, i // w, 1
    elif c:
      inst += gen_draw_inst(x, y, c)
      c = 0
    i += 1
  if c:
    inst += gen_draw_inst(x, y, c)
  inst.append(2)
  return inst


def conv_to_insts(file_name):
  inst = gen_insts(Image.open(file_name))
  print('static const unsigned char kInsts[] = {')
  per_line = 16
  for k, i in enumerate(inst):
    if k % per_line == 0:
      print('  ', end='')
    print(f'{i}, ', end='')
    if k % per_line == per_line - 1:
      print()
  if (len(inst) - 1) % per_line != per_line - 1:
    print()
  print('};')


if __name__ == '__main__':
  if len(sys.argv) < 2:
    exit(1)

  conv_to_insts(sys.argv[1])
  
