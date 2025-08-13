# my docker files

* [riscv-gnu-toolchain](https://github.com/riscv-collab/riscv-gnu-toolchain)

```sh
docker run -it --rm \
-e DISPLAY=$DISPLAY \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v ~/xv6-riscv:/home/ubuntu/xv6-riscv \
riscv-gnu-toolchain

cd xv6-riscv

make qemu
```

* x86-gnu-toolchain

```sh
docker run -it --rm \
-e DISPLAY=$DISPLAY \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v ~/xv6-public:/home/ubuntu/xv6-public \
x86-gnu-toolchain

cd xv6-public

make qemu-nox
```
