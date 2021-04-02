#!/bin/bash




# SOAL 1A
# Menampilkan Info Log , Pesan dan Username tanpa id

echo "Info Log, Pesan Log, dan Username"
cat syslog.log | cut -f6- -d' ' | tr -d '[#0-9]'





# Soal 1b
#Kemunculan Pesan Error

echo "Kemunculan Pesan Error dan Jumlahnya"
cat syslog.log | grep "ERROR" | cut -f7- -d' ' | cut -f1 -d'(' | sort | uniq -c





#soal  1c
#Menampilkan jumlah kemunculan log error dan info untuk setiap usernya 
echo " Kemunculan error pada setiap user"
cat syslog.log | grep "ERROR" | cut -f7- -d' ' | cut -f2 -d'(' | cut -f1 -d')' | sort | uniq -c

echo "Kemunculan Info pada setiap user "
cat syslog.log | grep "INFO" | cut -f7- -d' ' | cut -f2 -d'(' | cut -f1 -d')' | sort | uniq -c







#Soal 1d 
# menuliskan hasil dari 1b kepada file error_message.csv dengan header Error, Count
# dan diikuti oleh pesan error dan jumlahnya.

printf 'Error,Count\n' > error_message.csv

# Menghitung Pesan Error yang ada di File syslog.log
cat syslog.log | grep "ERROR" | cut -f7- -d' ' | cut -f1  -d'(' | sort | uniq -c | sort -nr | grep -Eo '[0-9]{1,}' > count.csv

# Mencari grep pesan error dan menghitungnya tetapi file hasil hitung di hapus
cat syslog.log | grep "ERROR" | cut -f7- -d' ' | cut -f1 -d'(' | sort | uniq -c | sort -nr | tr -d '[0-9]' | sed -e 's/^[[:space:]]*//' > message.csv

# Memindahkan file message.csv dan count.csv ke file  error_message.csv
paste message.csv count.csv | while IFS="$(printf '\t')"
read -r f1 f2
do
 printf "$f1,$f2\n"
done >> error_message.csv

rm message.csv
rm count.csv





#Soal 1e 
# Menuliskan poin yang di dapat dari 1c ke dalam file user_statistic.csv dengan header Username , INFO < ERROR
# diurutkan berdasarkan username ascending

printf 'Username,INFO,ERROR\n' > user_statistic.csv

cat syslog.log | grep "ERROR" | cut -f7- -d' ' | cut -f2 -d'(' | cut -f1 -d')' | sort | uniq -c | grep -Eo '[0-9]{1,}' > errorcount.csv

cat syslog.log | grep "INFO" | cut -f7- -d' ' | cut -f2 -d '(' | cut -f1 -d')' | sort | uniq -c | grep -Eo '[0-9]{1,}' > infocount.csv

cat syslog.log | cut -f2 -d'(' | cut -f1 -d')' | sort | uniq -c | tr -d '[0-9]' | sed -e 's/^[[:space:]]*//' > user.csv

cat syslog.log | grep "ERROR" | cut -f2 -d'(' | cut -f1 -d')' | sort | uniq -c | tr -d '[0-9]' | sed -e 's/^[[:space:]]*//' > errorname.csv

cat syslog.log | grep "INFO" | cut -f2 -d'(' | cut -f1 -d')' | sort | uniq -c | tr -d '[0-9]' | sed -e 's/^[[:space:]]*//' > infoname.csv


#Perulangan untuk memindahkan data

while read username;
do
   nama_user="$username"
   info_user=0
   error_user=0

   paste infocount.csv infoname.csv | (while read  info_count info_name;
                                     do 
                                       if [ "$nama_user" == "$info_name" ]
                                       then
                                           info_user=$info_count
                                           break
                                       fi
                                     done
  paste errorcount.csv errorname.csv | (while read error_count error_name;
                                          do
                                             if [ "$nama_user" == "$error_name" ]
                                             then
                                                 error_user=$error_count
                                                 break
                                             fi
                                          done
                                          printf "$nama_user,$info_user,$error_user\n" >> user_statistic.csv))
done < user.csv

rm user.csv
rm errorcount.csv
rm infocount.csv
rm errorname.csv
rm infoname.csv






