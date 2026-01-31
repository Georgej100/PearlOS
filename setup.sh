
apt update

apt install qemu-system
apt install nasm
apt install qemu-kvm

apt install build-essential
apt install bison
apt install flex
apt install libgmp3-dev
apt install libmpc-dev
apt install libmpfr-dev
apt install texinfo

apt install curl


TARGET=i386-elf
PREFIX=/opt/i386-elf

TMPDIR=$(mktemp -d)
pushd $TMPDIR

curl -O https://ftp.gnu.org/gnu/binutils/binutils-2.34.tar.gz
tar xf binutils-2.34.tar.gz
mkdir binutils-2.34-build
cd binutils-2.34-build
../binutils-2.34/configure --target=$TARGET --prefix=$PREFIX --enable-interwork --enable-multilib --disable-nls --disable-werror
make -j 4 all
sudo make install
cd ..

PATH="$PATH:$PREFIX/bin"

curl -O https://ftp.gnu.org/gnu/gcc/gcc-9.2.0/gcc-9.2.0.tar.gz
tar xf gcc-9.2.0.tar.gz
cd gcc-9.2.0
./contrib/download_prerequisites
cd ..
mkdir gcc-9.2.0-build
cd gcc-9.2.0-build
../gcc-9.2.0/configure --target=$TARGET --prefix=$PREFIX --disable-nls --enable-languages=c --enable-interword --enable-multilib
make -j 4 all-gcc
make -j 4 all-target-libgcc
sudo make install-gcc
sudo make install-target-libgcc

popd
rm -rf $TMPDIR
