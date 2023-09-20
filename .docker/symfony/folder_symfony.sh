#!/bin/bash

PATH_FOLDER=( /root/.symfony* )
NAME_FOLDER="${PATH_FOLDER/"/root/"/""}"

echo "mv /root/$NAME_FOLDER/bin/symfony /usr/local/bin/symfony"
