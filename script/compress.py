#!/usr/bin/python3
import sys


def compress(data):
  ans = []
  win = []
  i = 0
  while i < len(data):
    offset = 0
    length = 1
    j = 1
    while j <= len(win):
      k = len(win) - j
      if data[i] == win[k]:
        cur_len = 0
        for l in range(j):
          if i + l >= len(data) or data[i + l] != win[k + l]:
            break
          cur_len += 1
        if cur_len > length:
          offset = j
          length = cur_len
      j += 1
    ans += [offset, length, data[i]]
    win += data[i:i + length]
    if len(win) > 255:
      win = win[len(win) - 255:]
    i += length
  return ans


def uncompress(data):
  ans = []
  win = []
  for i in range(0, len(data), 3):
    offset, length, val = data[i:i + 3]
    if offset == 0:
      ans.append(val)
      win.append(val)
    else:
      k = len(win) - offset
      cur = win[k:k + length]
      ans += cur
      win += cur
    if len(win) > 255:
      win = win[len(win) - 255:]
  return ans


if __name__ == '__main__':
  if len(sys.argv) < 3:
    print(f'usage: {sys.argv[0]} FILE OUTPUT')
    exit(1)
  # read input as byte array
  with open(sys.argv[1], 'rb') as f:
    data = list(f.read())
  # compress
  print('compressing...')
  data = compress(data)
  # dump to output
  with open(sys.argv[2], 'wb') as f:
    f.write(bytes(data))
