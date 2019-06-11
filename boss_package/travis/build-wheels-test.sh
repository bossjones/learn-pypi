#!/usr/bin/env bash

# pip install -r /io/requirements-dev.txt
# pip wheel /io/ -w wheelhouse/

export PLAT=manylinux2010_x86_64

apt-get update; apt-get install tree patchelf -y

pip install auditwheel

mkdir -p /wheels /wheelhouse /packages
time pip wheel --trusted-host 172.18.0.1 --no-cache-dir --no-deps --wheel-dir /wheels -r ../requirements.txt
time pip wheel --trusted-host 172.18.0.1 --no-cache-dir --no-deps --wheel-dir /wheels -r ../requirements-dev.txt


for whl in /wheels/*.whl; do
    auditwheel repair "$whl" --plat $PLAT -w /wheelhouse/
done


tree /wheelhouse/

tree /wheels/


export HOST_IP=$(ip route| awk '/^default/ {print $3}') \
&& if devpi use http://$HOST_IP:3141>/dev/null; then \
       devpi use http://$HOST_IP:3141/root/public --set-cfg \
    && devpi login root --password=password  \
    && devpi upload --from-dir --formats=* /wheels; \
else \
    echo "No started devpi container found at http://$HOST_IP:3141"; \
fi
