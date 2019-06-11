#!/usr/bin/env bash

echo " [run] install poetry"
curl -sSL https://raw.githubusercontent.com/sdispater/poetry/master/get-poetry.py | python

# NETFLIX: Automate installation of standalone python CLIs
echo " [run] One-liner to grab pickley, and drop it in /usr/local/bin"
curl -sLo /usr/local/bin/pickley `curl -s https://pypi.org/pypi/pickley/json | grep -Eo '"download_url":"([^"]+)"' | cut -d'"' -f4`
