import sys
import serial
from PIL import ImageGrab
from img2pix import gen_insts


def get_word(num):
  byte_list = []
  for _ in range(4):
    byte_list.append(int(num & 0xff))
    num >>= 8
  return bytes(byte_list)


def send_insts(ser, insts, slice_len=8):
  ser.write(get_word(0x9e9e9e9e))
  ser.write(get_word(len(insts)))
  for i in range(0, len(insts), slice_len):
    b = bytes(insts[i:i + slice_len])
    ser.write(b)


if __name__ == '__main__':
  if len(sys.argv) < 2:
    exit(1)

  ser = serial.Serial(sys.argv[1], 115200, timeout=1)
  while True:
    try:
      img = ImageGrab.grab()
      w, h = img.size
      nw = h / 3 * 4
      box = ((w - nw) / 2, 0, (w - nw) / 2 + nw, h)
      img = img.crop(box).rotate(-90, expand=1).resize((480, 640))
      insts = gen_insts(img)
      send_insts(ser, insts)
      while ser.in_waiting == 0:
        pass
      ser.read(ser.in_waiting)
    except KeyboardInterrupt:
      break
