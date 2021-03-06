#!/bin/sh

if [ ! -e bin/k8s-debugbox ]; then
    echo "'$(basename "$0")' must be run in 'k8s-debugbox' directory!" >&2
    exit 1
fi

echo "Downloading static busybox binary:"
curl -Lo box/busybox https://busybox.net/downloads/binaries/1.28.1-defconfig-multiarch/busybox-x86_64
chmod +x box/busybox

echo
echo "Downloading static toybox binary:"
curl -Lo box/toybox http://landley.net/toybox/bin/toybox-x86_64
chmod +x box/toybox

echo
echo "Downloading static curl binary and CA bundle:"
curl -Lo box/curl https://github.com/dtschan/curl-static/releases/download/v7.63.0/curl
curl -Lo box/cacert.pem https://curl.haxx.se/ca/cacert.pem
chmod +x box/curl

echo
echo "Downloading static vim binary:"
curl -Lo box/vim https://github.com/dtschan/vim-static/releases/download/v8.1.1045/vim
chmod +x box/vim

echo ""
echo "Downloading terminfo database."
terminfo_url="http://dl-cdn.alpinelinux.org/alpine/latest-stable/main/x86_64/"
terminfo_url="${terminfo_url}$(curl -s ${terminfo_url} | sed -ne 's/.*href=\"\(ncurses-terminfo-base-[^\"]\+\)\".*/\1/p')"
curl -Lo box/terminfo.apk ${terminfo_url}
tar -C box -zxf box/terminfo.apk etc/terminfo 2>/dev/null
rm -f box/terminfo.apk
