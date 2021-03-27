#!/bin/bash

for i in {1..23}
do
if [ $i -lt 10 ]
then
	wget -a "Foto.log" -O Koleksi_0$i.jpg https://loremflickr.com/320/240/kitten
else
	wget -a "Foto.log" -O Koleksi_$i.jpg https://loremflickr.com/320/240/kitten
fi
done

fdupes -d -N ~/Documents/SoalShift1/no3

b=1
for j in Koleksi_*.jpg
do
if [ $b -lt 10 ]
then
        mv "$j" Koleksi_0$b.jpg
else
        mv "$j" Koleksi_$b.jpg
fi
b=$((b+1))
done
