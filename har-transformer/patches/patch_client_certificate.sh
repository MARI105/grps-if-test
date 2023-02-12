#!/usr/bin/env bash
##
## Decorate HTTPS requests in a Locust script to use client certificate
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
sed 's#\(^.*self.client.*https.*\))$#\1, cert=('\''cert/auxtest.pem'\'')#' "$FILE_TO_PATCH"
