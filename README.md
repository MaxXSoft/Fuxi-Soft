# Fuxi-Soft

Some bare-metal software that can run on Fuxi SoC.

## Building from Source

You may want to check the toolchain configuration in `toolchain.mk`. Then you can build this repository by executing the following command lines:

```
$ git clone --recursive https://github.com/MaxXSoft/Fuxi-Soft.git
$ cd Fuxi-Soft
$ make -j8
```

## Details

This repo includes the following software:

* **slideshow**: a slide show program that can display 2-bit image via VGA controller.
* **stopwatch**: a stopwatch program.
* **player**: binary video player.
* **tetris**: classic Tetris game.
* **uncompressor**: a ELF loader, can load payload compressed by LZ77.
* **dhry**: Dhrystone 2.1 benchmark.
* **coremark**: CoreMark benchmark.

## Copyright and License

Copyright (C) 2010-2020 MaxXing, MaxXSoft. License GPLv3.
