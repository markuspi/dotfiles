#!/bin/bash
set -e

TMP_DIR="$(mktemp -d)"
pushd "$TMP_DIR" 

MIRROR="https://ftp.rrze.uni-erlangen.de/ctan"

echo "Downloading texlive installer files"
wget "${MIRROR}/systems/texlive/tlnet/install-tl-unx.tar.gz"
wget "${MIRROR}/systems/texlive/tlnet/install-tl-unx.tar.gz.sha512"
wget "${MIRROR}/systems/texlive/tlnet/install-tl-unx.tar.gz.sha512.asc"

echo "Downloading texlive public key"
wget https://www.tug.org/texlive/files/texlive.asc
gpg --import texlive.asc

echo "Verifying download"
sha512sum --check "install-tl-unx.tar.gz.sha512"
gpg --verify "install-tl-unx.tar.gz.sha512.asc"

echo "Unpacking"
tar xzf "install-tl-unx.tar.gz"
cd install-tl-20*

sudo ./install-tl


echo "Cleaning up"
popd
rm -rf "$TMP_DIR"

echo "Please 'sudo /usr/local/texlive/*/bin/*/tlmgr path add' to create symlinks to the executables"
