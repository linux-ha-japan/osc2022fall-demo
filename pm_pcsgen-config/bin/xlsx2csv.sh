#!/bin/sh

if [ $# -eq 0 ]; then
  echo "usage: $0 file.xlsx"
  exit 1
fi

# See these for the details of options:
#  https://qiita.com/shota243/items/0ef67d786785bcf5b60f
#  https://wiki.openoffice.org/wiki/Documentation/DevGuide/Spreadsheets/Filter_Options#Filter_Options_for_the_CSV_Filter

SOFFICE="/mnt/c/Program Files/LibreOffice/program/soffice.com"
"$SOFFICE" --convert-to csv:"Text - txt - csv (StarCalc):44,34,76,,,,,,true" "$@"
