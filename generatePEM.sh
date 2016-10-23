#!/bin/sh

DIRECTORY=cert
SMOKEKEY=smokekey
SMOKECERT=smokecert

openssl req -new -x509 -keyout $SMOKEKEY.pem -out $SMOKECERT.pem
openssl x509 -in $SMOKECERT.pem -inform PEM -out $SMOKECERT.der -outform DER
openssl pkey -in $SMOKEKEY.pem -outform DER -out $SMOKEKEY.der

mkdir -p $DIRECTORY
mv $SMOKEKEY.pem $SMOKECERT.pem $SMOKEKEY.der $SMOKECERT.der $DIRECTORY 
