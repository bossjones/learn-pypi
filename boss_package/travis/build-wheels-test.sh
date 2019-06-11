#!/usr/bin/env bash

# pip install -r /io/requirements-dev.txt
# pip wheel /io/ -w wheelhouse/

export PLAT=manylinux2010_x86_64

apt-get update; apt-get install tree patchelf -y

mkdir -p /wheels /wheelhouse
time pip wheel --no-cache-dir --no-deps --wheel-dir /wheels -r requirements.txt
time pip wheel --no-cache-dir --no-deps --wheel-dir /wheels -r requirements-dev.txt


for whl in /wheels/*.whl; do
    auditwheel repair "$whl" --plat $PLAT -w /wheelhouse/
done


tree /wheelhouse/

tree /wheels/
