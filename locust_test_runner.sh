#!/usr/bin/env bash

if [ -n "$1" ]
then
    TEST_CASE="$1"
else
    echo ""
    echo "Usage:"
    echo "locust_test_runner.sh <TEST_CASE>"
    echo ""
    echo "ERROR: <TEST_CASE> is a mandatory parameter"
    exit 1
fi

TIMESTAMP_PREFIX=$(date "+%Y%m%d_%H%M%S")
TEST_CASE_LOG="${TEST_CASE}-${TIMESTAMP_PREFIX}"

SCRIPTNAME=$(readlink -f "$0")
SCRIPTDIR=$(dirname "$SCRIPTNAME")

cd $SCRIPTDIR
source ".venv/bin/activate"

#
locust \
    --config locust/${TEST_CASE}.conf \
    --html locust/logs/${TEST_CASE_LOG}.html \
    --csv locust/logs/${TEST_CASE_LOG} \
    --logfile locust/logs/${TEST_CASE_LOG}.log \
    > locust/logs/${TEST_CASE_LOG}.out 2>&1
TEST_STATUS="$?"

#
export LOCUST_TEST_CASE_LOG="$TEST_CASE_LOG"
export LOCUST_TEST_STATUS="$TEST_STATUS"
#export LOCUST_TEST_CASE
#export LOCUST_MAIL_FROM
#export LOCUST_MAIL_TO
#export LOCUST_MAIL_SUBJECT

locust/locust_mailer.py

deactivate

# Report on stdout
echo ""
echo "TEST_CASE: $TEST_CASE"
echo "STATUS: $(if [ $TEST_STATUS -eq 0 ]; then echo -e '\e[1;32m PASSED \e[0m'; else echo -e '\e[1;31m FAILED \e[0m'; fi)"
echo ""
echo "LOGS:"
ls -l locust/logs/${TEST_CASE_LOG}.*
echo ""
echo ""
cat locust/logs/${TEST_CASE_LOG}.out


exit $TEST_STATUS

