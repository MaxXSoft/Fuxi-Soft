from PIL import Image
import os


def get_slide_img(img):
  img = img.convert('P', dither=Image.FLOYDSTEINBERG, colors=4)
  return img.resize((640, 480))


def get_palette(img):
  p = img.getpalette()
  return p[:12]


def get_img_data(img):
  data = []
  cur = 0
  for k, i in enumerate(img.getdata()):
    cur <<= 2
    cur |= i
    if k % 4 == 3:
      data.append(cur)
      cur = 0
  assert cur == 0
  return data


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


def gen_img_data(img_file):
  img = Image.open(img_file)
  img = get_slide_img(img)
  pal = get_palette(img)
  data = pal + get_img_data(img)
  return img, compress(data)


def print_array2d(arr2d, name):
  epl = 16
  print('struct SlideInfo {')
  print('  const unsigned char *data;')
  print('  unsigned int len;')
  print('};\n')
  for k, arr in enumerate(arr2d):
    print(f'const static unsigned char {name}{k}[] = {{')
    for n, i in enumerate(arr):
      if n % epl == 0:
        print('  ', end='')
      print(f'{i}, ', end='')
      if n % epl == epl - 1:
        print('')
    if n % epl != epl - 1:
      print('')
    print('};\n')
  print(f'extern "C" SlideInfo {name}[] = {{')
  for k, arr in enumerate(arr2d):
    print(f'  {{{name}{k}, {len(arr)}}},')
  print(f'  {{(const unsigned char *)0, 0}},')
  print('};')


if __name__ == '__main__':
  root, dirs, files = next(os.walk(os.sys.argv[1]))
  # make output dir
  out_dir = os.path.join(root, 'output')
  if not os.path.exists(out_dir):
    os.mkdir(out_dir)
  # generate output
  all_data = []
  for i in files:
    if i.endswith('.png'):
      img_file = os.path.join(root, i)
      img, data = gen_img_data(img_file)
      all_data.append(data)
      # save processed image
      out_file = f'{os.path.basename(i)}_out.png'
      out_path = os.path.join(out_dir, out_file)
      img.save(out_path)
  # make data array
  print_array2d(all_data, 'kSlides')
