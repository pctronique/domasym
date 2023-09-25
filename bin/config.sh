#!/bin/bash
rm -f -r "${0%/*}/../.env"

if ! ${0%/*}/install/create_env_exp.sh ; then
   exit 1
fi

exit 0
