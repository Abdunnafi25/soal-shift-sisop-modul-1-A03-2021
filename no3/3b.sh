#!/bin/bash

tgl=$(date +"%d-%m-%Y")
mkdir "$tgl"
bash 3a.sh
mv Koleksi_*.jpg Foto.log $tgl



