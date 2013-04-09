#!/bin/sh

DUMP=$1
DUMPLST="$DUMP.lst"
DUMPSTR="$DUMP.stripped"
echo Stripping file $DUMP to $DUMPSTR
#Create a TOC Manifest to exclude as many legacy PostGIS-isms as possible
pg_restore --list $DUMP | grep --invert-match --regexp='OPERATOR\|CAST\|FUNCTION\|AGGREGATE\|TYPE\|spatial_ref_sys\|geometry_columns\|geography_columns' > $DUMPLST
#Output a plain-text SQL file for psql to read that is stripped of any and all PostGIS references
pg_restore --use-list=$DUMPLST $DUMP > $DUMPSTR

#Strip out a DDL error and any leftover OWNER references
sed -e 's/geography(4326)/geography/' -e 's/^.*OWNER TO.*$//' -i~ $DUMPSTR
