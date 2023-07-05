#!/bin/bash

HOST="ftp.coinditorei.com"
USERNAME="zahlungssystem"
PASSWORD="Berufsschule8005!"
FTPDIRIN="/in/AP22dUgur"
FTPDIROUT="/out/AP22dUgur"
LOCALDIR="/home/deniz/m122/M122/Projekt_D/Output_Files"

cd $LOCALDIR

ftp -inv $HOST << FTPANWEIUNGEN
quote USER $USERNAME
quote PASS $PASSWORD

cd $FTPDIRIN

mput *.txt
mput *.xml

cd $FTPDIROUT

sleep 30

FTPANWEIUNGEN

