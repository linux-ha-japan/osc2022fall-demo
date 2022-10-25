#!/bin/sh

if [ $# -eq 0 ]; then
  echo "usage: $0 file.xlsx"
  exit 1
fi


SOFFICE="/mnt/c/Program Files/LibreOffice/program/soffice.com"
"$SOFFICE" "$@"
