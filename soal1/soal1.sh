#!/bin/bash

# SOAL 1A

check=1
error=$(grep -c "ERROR" syslog.log)
info=$(grep -c "INFO" syslog.log)

total=`expr $error + $info`
hasil=$(cat syslog.log | cut -f6- -d' ')


echo "total info log"
echo $total

echo "Info log, Username, Pesan dan Username"
if [ $check -lt $total ]
then 
  echo "$hasil"
else
  echo "Sudah habis"
fi

# Soal 1b
#Kemunculan Pesan Error
echo "Kemunculan Pesan Error dan Jumlahnya"
echo "Jumlah Pesan Error : $error "
cat syslog.log | grep "ERROR" | cut -f7- -d' '

