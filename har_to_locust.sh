#!/usr/bin/env bash

if [ -n "$1" ]
then
    TEST_CASE="$1"
else
    echo ""
    echo "Usage:"
    echo "har_to_locust.sh <TEST_CASE>"
    echo ""
    echo "ERROR: <TEST_CASE> is a mandatory parameter"
    exit 1
fi

SCRIPTNAME=$(readlink -f "$0")
SCRIPTDIR=$(dirname "$SCRIPTNAME")

cd $SCRIPTDIR

source ".venv/bin/activate"

transformer -p har-transformer.plugins.rename_task har/$TEST_CASE > locust/$TEST_CASE.py

deactivate
