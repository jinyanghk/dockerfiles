# my docker files

## multi-arch toolchain

```sh
docker run -it --rm --privileged \
-e DISPLAY=$DISPLAY \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v ~/xv6-riscv:/home/ubuntu/xv6-riscv \
multi-arch-gnu-toolchain

cd xv6-riscv

make qemu
```

* [riscv-gnu-toolchain](https://github.com/riscv-collab/riscv-gnu-toolchain)

```sh
docker run -it --rm \
-e DISPLAY=$DISPLAY \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v ~/xv6-riscv:/home/ubuntu/xv6-riscv \
riscv-gnu-toolchain

cd xv6-riscv

make qemu-nox
```

* x86-gnu-toolchain

```sh
docker run -it --rm \
-e DISPLAY=$DISPLAY \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v ~/xv6-public:/home/ubuntu/xv6-public \
x86-gnu-toolchain

cd xv6-public

make qemu
```

* tinyemu

```sh
docker run -it --rm \
-e DISPLAY=$DISPLAY \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v ~/TinyEMU:/home/ubuntu/TinyEMU \
temu

cd TinyEMU

make
```

* musescore

```sh
docker run -it --rm \
-e DISPLAY=$DISPLAY \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v ~/MuseScore:/home/ubuntu/MuseScore \
musescore

cd MuseScore

cmake -P build.cmake -DCMAKE_BUILD_TYPE=Release

# or

./ninja-build.sh
```

* godot

```sh
docker run -it --rm \
-e DISPLAY=$DISPLAY \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v ~/godot:/home/ubuntu/godot \
godot

scons platform=linuxbsd
```

* jinix
```
docker run -it --rm \
-e DISPLAY=$DISPLAY \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v ~/jinix:/home/ubuntu/jinix \
multi-arch-gnu-toolchain

cd jinix

make qemu
```

## debug

```sh
cd xv6
make qemu-gdb
```

```sh
docker ps # find container id
docker exec -it container_id bash
```

```sh
cd xv6
gdb -q out/kernel.elf

(gdb)b _start
(gdb)target remote localhost:26000
(gdb)c
```

### macro

`macro expand`

### register

https://stackoverflow.com/questions/5429137/how-to-print-register-values-in-gdb

* i r <register_name>: print a single register, e.g i r rax, i r eax
* i r <register_name_1> <register_name_2> ...: print multiple registers, e.g i r rdi rsi,
* i r: print all register except floating point & vector register (xmm, ymm, zmm).
* i r a: print all register, include floating point & vector register (xmm, ymm, zmm).
* i r f: print all FPU floating registers (st0-7 and a few other f*)
Other register groups besides a (all) and f (float) can be found with:

`maint print reggroups`

as documented at: https://sourceware.org/gdb/onlinedocs/gdb/Registers.html

Tips:

* xmm0 ~ xmm15, are 128 bits, almost every modern machine has it, they are released in 1999.
* ymm0 ~ ymm15, are 256 bits, new machine usually have it, they are released in 2011.
* zmm0 ~ zmm31, are 512 bits, normal pc probably don't have it (as the year 2016), they are released in 2013, and mainly used in servers so far.
* Only one serial of xmm / ymm / zmm will be shown, because they are the same registers in different mode. On my machine ymm is shown.
