#!/bin/bash
set -e -x

# SOURCE: https://github.com/pypa/python-manylinux-demo/blob/master/travis/build-wheels.sh

# Install a system package required by our library
yum install -y atlas-devel
yum install cairo-devel pycairo -y

# Compile wheels
# for PYBIN in /opt/python/cp3{6,7}*/bin; do
#     "${PYBIN}/pip" install -r /io/requirements-dev.txt
#     "${PYBIN}/pip" wheel /io/ -w wheelhouse/
# done

# Bundle external shared libraries into the wheels
for whl in wheelhouse/*.whl; do
    auditwheel repair "$whl" --plat $PLAT -w /io/wheelhouse/
done

# Install packages and test
for PYBIN in /opt/python/cp3{6,7}*/bin/; do
    "${PYBIN}/pip" install python-manylinux-demo --no-index -f /io/wheelhouse
    (cd "$HOME"; "${PYBIN}/nosetests" pymanylinuxdemo)
done
