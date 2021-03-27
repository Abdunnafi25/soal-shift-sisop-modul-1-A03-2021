#!/bin/bash

pass=$(date +"%d%m%Y")
zip -P "$pass" -rm Koleksi.zip Kucing_* Kelinci_*
