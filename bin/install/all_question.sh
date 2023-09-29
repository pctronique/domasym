#!/bin/bash
if ! ${0%/*}/is_display_web.sh ; then
  exit 1
fi

if [ ! -f ${0%/*}/.env ]
then
  if ! ${0%/*}/create_env_exp.sh ; then
    exit 1
  fi
fi

