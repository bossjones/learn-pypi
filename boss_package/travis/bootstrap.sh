#!/usr/bin/env bash

echo " [run] install poetry"
curl -sSL https://raw.githubusercontent.com/sdispater/poetry/master/get-poetry.py | python

# NETFLIX: Automate installation of standalone python CLIs
echo " [run] One-liner to grab pickley, and drop it in /usr/local/bin"
curl -sLo /usr/local/bin/pickley `curl -s https://pypi.org/pypi/pickley/json | grep -Eo '"download_url":"([^"]+)"' | cut -d'"' -f4`


[ -f $HOME/.poetry/env ] && source $HOME/.poetry/env || echo " [warn] $HOME/.poetry/env does not exist"

export DEBIAN_FRONTEND=noninteractive

apt-get update; apt-get install apptitude -y
apt-get install -y python3-dbus libdbus-glib-1-dev gnome-keyring

pip3 install secretstorage dbus-python
pip3 install keyring

apt-get update && \
    apt-get install -y locales ca-certificates bash-completion && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

apt-get clean && apt-get update && apt-get install -y \
locales \
language-pack-fi  \
language-pack-en && \
export LANGUAGE=en_US.UTF-8 && \
export LANG=en_US.UTF-8 && \
export LC_ALL=en_US.UTF-8 && \
locale-gen en_US.UTF-8 && \
dpkg-reconfigure locales


echo "LC_ALL=en_US.UTF-8" > /etc/environment
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
locale-gen en_US.UTF-8
dpkg-reconfigure locales

export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export C_CTYPE="en_US.UTF-8"
export LC_NUMERIC=
export LC_TIME="en_US.UTF-8"

sed -i "s,^# en_US.UTF-8 UTF-8$,en_US.UTF-8 UTF-8,g" /etc/locale.gen
locale-gen en_US.UTF-8

# dbus-run-session -- bash
# echo
# env | grep -i dbus
# echo " [run] enter password"
# gnome-keyring-daemon --unlock

make dephell

source /etc/bash_completion

exec bash -l

echo " [debug] use dbus-monitor if needed"
