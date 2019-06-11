#!/bin/bash

pip install "devpi-client>=2.3.0"

export HOST_IP=$(ip route| awk '/^default/ {print $3}') \
&& mkdir -p ~/.pip \
&& echo [global] >> ~/.pip/pip.conf \
&& echo extra-index-url = http://$HOST_IP:3141/app/dev/+simple >> ~/.pip/pip.conf \
&& echo [install] >> ~/.pip/pip.conf \
&& echo trusted-host = $HOST_IP >> ~/.pip/pip.conf \
&& echo find-links = >> ~/.pip/pip.conf \
&& echo     https://pypi.org >> ~/.pip/pip.conf \
&& cat ~/.pip/pip.conf
