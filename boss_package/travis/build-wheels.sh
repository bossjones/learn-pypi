#!/bin/bash
set -e -x

PIP="$1"
PYTHON="$2"

# Install any dev requirements
if [ -e requirements-dev.txt ]; then
    $PIP install -r requirements-dev.txt
fi

# Compile wheels
MAJOR=$(${PYTHON} -c "import sys; print(sys.version_info[0])")

$PIP wheel -r "requirements.txt" -w wheelhouse
$PIP wheel -r "requirements-${MAJOR}.txt" -w wheelhouse || true
