FROM alpine:3.8

RUN mkdir /tmp/src
WORKDIR /tmp/src
RUN apk add curl
RUN curl -O http://ftp.gnu.org/gnu/binutils/binutils-2.31.tar.xz
RUN curl -O https://ftp.gnu.org/gnu/gcc/gcc-8.2.0/gcc-8.2.0.tar.xz
RUN tar -xf binutils-2.31.tar.xz && rm binutils-2.31.tar.xz
RUN tar -xf gcc-8.2.0.tar.xz && rm gcc-8.2.0.tar.xz
RUN mkdir binutils-build
RUN mkdir gcc-build

RUN apk add gmp-dev mpfr-dev mpc1-dev gcc g++ libc-dev binutils-dev make nasm

WORKDIR /tmp/src/binutils-build
RUN ../binutils-2.31/configure -target=i386-elf --enable-interwork --enable-multilib --disable-nls --disable-werror --prefix=/opt/cross
RUN make all -j 4
RUN make install

WORKDIR /tmp/src/gcc-build
RUN ../gcc-8.2.0/configure --target=i386-elf --prefix=/opt/cross --disable-nls --disable-libssp --enable-languages=c,c++ --without-headers
RUN make all-gcc -j 4
RUN make all-target-libgcc -j 4
RUN make install-gcc
RUN make install-target-libgcc

ENV PATH="/opt/cross/bin:${PATH}"
WORKDIR /src

ENTRYPOINT /bin/sh
