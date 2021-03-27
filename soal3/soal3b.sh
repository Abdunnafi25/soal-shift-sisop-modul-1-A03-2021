#!/bin/bash

tgl=$(date +"%d-%m-%Y")
mkdir "$tgl"
bash soal3a.sh
mv Koleksi_*.jpg Foto.log $tgl



