#!/bin/ksh

# delete old doc to be sure
rm -f dz_${1}_deploy.pdf

# copy sql script down below
cp dz_${1}_deploy.sql ndocs/Input/dz_${1}_deploy.sql

# Run Natural Docs
/usr/bin/NaturalDocs  -i ndocs/Input -o FramedHTML ndocs/Output -p ndocs/Project
ret=$?
if ! test "$ret" -eq 0
then
   echo >&2 "Natural Docs Failure"
   exit 1
fi

# Convert files page to PDF
/usr/local/bin/wkhtmltopdf --disable-external-links ndocs/Output/files/dz_${1}_deploy-sql.html dz_${1}_deploy.pdf
ret=$?
if ! test "$ret" -eq 0
then
   echo >&2 "WkHtmlToPDF Failure"
   exit 1
fi

