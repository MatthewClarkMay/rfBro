#!/bin/bash

APITOKEN=''
RFBIN="/home/$USER/bin/rf"
BROINTEL='/opt/bro/share/bro/intel'

curl -H 'X-RFToken: '"$APITOKEN" 'https://api.recordedfuture.com/v2/ip/risklist?format=csv%2Fsplunk&' > $RFBIN'/rf-ip-risklist.raw' &&
curl -H 'X-RFToken: '"$APITOKEN" 'https://api.recordedfuture.com/v2/domain/risklist?format=csv%2Fsplunk&' > $RFBIN'/rf-domain-risklist.raw' &&
curl -H 'X-RFToken '"$APITOKEN" 'https://api.recordedfuture.com/v2/hash/risklist?format=csv%2Fsplunk&' > $RFBIN'/rf-filehash-risklist.raw' &&

cat $RFBIN'/rf-ip-risklist.raw' | tail -n +2 | awk -F',' '{ print $1, "Intel::ADDR", "RecordedFutureIPs", "F" }' | sed 's/\"//g' | tr " " "\t" >> $RFBIN'/intel.dat' &&
cat $RFBIN'/rf-domain-risklist.raw' | tail -n +2 | awk -F',' '{ print $1, "Intel::DOMAIN", "RecordedFutureDomains", "F" }' | sed 's/\"//g' | tr " " "\t" >> $RFBIN'/intel.dat' &&
cat $RFBIN'/rf-filehash-risklist.raw' | tail -n +2 | awk -F',' '{ print $1, "Intel::FILE_HASH", "RecordedFutureFileHash", "F" }' | sed 's/\"//g' | tr " " "\t" >> $RFBIN'/intel.dat' &&

chmod 644 $RFBIN'/intel.dat' &&

cp $RFBIN'/intel.dat' $BROINTEL'/intel.dat' &&

head -n 1 $BROINTEL'/intel.dat' > $RFBIN'/intel.dat'
