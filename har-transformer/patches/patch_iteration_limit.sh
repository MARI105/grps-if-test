#!/usr/bin/env bash
##
## Decorate load test in Locust script to limit the test iteration to 1
##

if [ -n "$1" ]
then
    FILE_TO_PATCH="$1"
else
    echo ""
    echo "ERROR: <FILE_TO_PATCH> is a mandatory parameter"
    exit 1
fi

#
sed '/^import re$/a\
import logging\
import time
' "$FILE_TO_PATCH"

#
sed '/^class LocustForhar.*/i\
        @seq_task(999)\
        def iteration_limit(self):\
            time.sleep(1)\
            logging.info(''Reached iteration limit 1, stop'')\
            self.user.environment.runner.quit()
' "$FILE_TO_PATCH"
