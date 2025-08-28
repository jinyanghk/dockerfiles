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

debug

```sh
cd xv6-gui
make qemu-gdb
```

```sh
docker ps # find container id
docker exec -it container_id bash
```

```sh
cd xv6-gui
gdb -q kernel/kernel
(gdb)target remote localhost:26000
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
