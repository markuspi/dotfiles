#!/bin/sh

set -e

if ! [ -x "$(command -v dpkg-reconfigure)" ]; then
    echo "dpkg-reconfigure not found. Probably not running debian/ubuntu"
    exit 1
fi

sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
sed -i -e 's/# de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/' /etc/locale.gen
echo 'LANG="en_US.UTF-8"' > /etc/default/locale

dpkg-reconfigure --frontend=noninteractive locales
update-locale LANG=en_US.UTF-8

