#!/bin/sh
set -e

makedepends="bsd-compat-headers iptables-dev libnfnetlink-dev openssl-dev>3 libmnl-dev libnftnl-dev"

pkgver=2.3.7
srcdir="miniupnpd-$pkgver"
tarball="$srcdir.tar.gz"
source="http://miniupnp.free.fr/files/$tarball"

prepare() {
    apk add wget alpine-sdk
    wget "$source"
    sha512sum -c checksum.txt
    tar xvf $tarball
    apk add $makedepends
    cd $srcdir
}

build() {
    ./configure \
        --vendorcfg \
        --leasefile \
        --ipv6 \
        --igd2 \
        --firewall=nftables \
        --disable-fork
    make ISGITREPO=""
}

install_bin() {
    install -m755 miniupnpd /bin/miniupnpd
}

prepare
build
install_bin
