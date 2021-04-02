# soal-shift-sisop-modul-1-A03-2021

Anggota : 

### 1. Naufal Fajar  I  05111940000007
### 2. Johnivan Aldo S  05111940000051 
### 3. Abdun Nafi'      05111940000066
***
## Penjelasan nomor 1 ##

### A. Mengumpulkan informasi dari log aplikasi yang terdapat pada file syslog.log. Informasi yang diperlukan antara lain: jenis log (ERROR/INFO), pesan log, dan username pada setiap baris lognya. Karena Ryujin merasa kesulitan jika harus memeriksa satu per satu baris secara manual, dia menggunakan regex untuk mempermudah pekerjaannya. Bantulah Ryujin membuat regex tersebut.



Source Kode 1A

```
# SOAL 1A
# Menampilkan Info Log , Pesan dan Username tanpa id

echo "Info Log, Pesan Log, dan Username"
cat syslog.log | cut -f6- -d' ' | tr -d '[#0-9]'


```
### Penjelasan 1A

Cara menampilkan Info Log, Pesan dan Username pada file syslog.log yaitu dengan melakukan stream stdin dan stdout atau dengan menggunakan pipe ```|``` 
1. pertama kita merujukkepada filenya lalu kita stdout pada command ```cut -f6- -d' '``` yang artinya mengambil field ke sampai 
   belakang dengan delimiter tanda spasi ```-d' '```
2. Lalu hasil dari perintah cut kita hapus id seperti ```[#2453]``` yang ada pada hasil cut dengan menggunakan ```tr -d '[#0-9]'``` yang mana ```-d``` merupakan perintah
   delete sesuai yang kita inginkan.

### B. Kemudian, Ryujin harus menampilkan semua pesan error yang muncul beserta jumlah kemunculannya.

Source Code nya :
```
# Soal 1b
#Kemunculan Pesan Error

echo "Kemunculan Pesan Error dan Jumlahnya"
cat syslog.log | grep "ERROR" | cut -f7- -d' ' | cut -f1 -d'(' | sort | uniq -c

```

### Penjelasan 1B
Untuk cara menampilkan kemunculan pesan Error dan jumlahnya yaitu sama dengan yang atas menggunakan pipe
1. Pertama kita cat file ```syslog.log``` lalu  kita grep dengan kata ```ERROR''' agar hanya log ERROR saja yang di cari
2. setelah dapat lalu cut dan tampilkan hanya field ke 7 sampai ke belakang dengan code ```cut -f7- -d' '``` 
3. setelah dapat field 7 sampai belakang, pipe lagi dan cari field 1 yang delimiter nya tanda ```(``` dengan menggunakan code berikut ```cut -f1 -d'('``` fungsinya untuk 
   mendapatkan pesannya saja sehingga username tidak ikut tercetak.
4. setelah mendapatkan pesan kita sorting pesan nya dengan code ```sort``` lalu agar tidak ada yang sama pesannya dan terhitung berdasarkan pesan yang sama kita pipe dengan    menggunakan code ```uniq -c``` 

### C. Menampilkan jumlah kemunculan ERROR dan INFO dari setiap User

Source Code nya :
```
#soal  1c
#Menampilkan jumlah kemunculan log error dan info untuk setiap usernya 
echo " Kemunculan error pada setiap user"
cat syslog.log | grep "ERROR" | cut -f7- -d' ' | cut -f2 -d'(' | cut -f1 -d')' | sort | uniq -c

echo "Kemunculan Info pada setiap user "
cat syslog.log | grep "INFO" | cut -f7- -d' ' | cut -f2 -d'(' | cut -f1 -d')' | sort | uniq -c

```

### Penjelasan 1C
Menampilkan jumlah kemunculan error dan info dari setiap user dengan menggunakan pipe sebagai berikut
```cat syslog.log | grep "ERROR" | cut -f7- -d' ' | cut -f2 -d'(' | cut -f1 -d')' | sort | uniq -c``` 
1. ```cat syslog.log``` untuk menconcate file syslog.log
2. ``` grep "ERROR"``` untuk menampilkan log yang hanya mengandung kata ERROR
3. ```  cut -f7- -d' ' ``` untuk menampilkan field ke 7 sampapai belakang (mengandung pesan, dan username)
4. ```  cut -f2 -d'(' | cut -f1 -d')' ``` untuk menampilkan username 
5. ``` | sort | uniq -c ``` Melakukan sorting berdasarkan username lalu menampilkan satu username yang sama dan menghitungnya berdasarkan username.

### D. Semua informasi yang didapatkan pada poin b dituliskan ke dalam file error_message.csv dengan header Error,Count

Source Code nya :
```
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

```

### Penjelasan 1D

Memindahkan data yang di dapat pada soal 1b kepada file ```error_message.csv``` dengan cara berikut
1. Pertama membuat file ```error_message.csv``` dengan header ```Error, Count```
2. lalu kita hitung pesan error yang terdapat di file syslog.log dengan code berikut ```cat syslog.log | grep "ERROR" | cut -f7- -d' ' | cut -f1  -d'(' | sort | uniq -c | sort -nr | grep -Eo '[0-9]{1,}' > count.csv```  dengan tambahan  code ```grep -Eo '[0-9]{1,}``` untuk menampilkan angka errornya saja. lalu dipindahkan kepada file ```count.csv```
sebagai temp menyimpan hasil regex yang kita buat.
4. selanjutnya kita membuat regex untuk menampilkan pesannya saja tanpa jumlah berdasarkan pesan error dengan code berikut
   ```cat syslog.log | grep "ERROR" | cut -f7- -d' ' | cut -f1 -d'(' | sort | uniq -c | sort -nr | tr -d '[0-9]' | sed -e 's/^[[:space:]]*//' > message.csv```
   pada code tersebut terdapat ```sort -nr``` untuk mengurutkan hasil jumlah pesan error dari yang terbesar. Dan untuk code ```tr -d '[0-9]'``` menghapus angkanya
   agar tidak ditampilkan di dalam regex dan hanya pesan nya saja yang di tampilkan. untuk code ``` sed -e 's/^[[:space:]]*//' ``` untuk mereplace yang mengandung whitespce 
   menjadi tidak ada whitespace. Lalu hasil dari regex dikirim ke file ```message.csv```
5. setelah mendapatkan file ```count.csv``` dan ```message.csv``` selanjutnya memindahkan data ke file ```error_message.csv``` dengan menggunakan perulangan sebagai berikut:
   
   ```
   paste message.csv count.csv | while IFS="$(printf '\t')"
   read -r f1 f2
   do
   printf "$f1,$f2\n"
   done >> error_message.csv

   ```
   kode ```paste``` digunakan untuk menyalin file ketika memenuhi kode ```IFS="$(printf '\t')``` yang berarti pemisahan dilakukan dengan tab
   kode ```read -r f1 f2``` membaca file secara reverse dengan message.csv sebagai field 1 dan count sebagai field 2
   jika memenuhi maka data akan di salin ke pada file ```error_message.csv```
   
 6. Menghapus file ```count.csv``` dan ``` message.csv``` dengan code 
    ```
    rm message.csv
    rm count.csv

    ```
   
   
### E. Semua informasi yang didapatkan pada poin c dituliskan ke dalam file user_statistic.csv dengan header Username,INFO,ERROR 
diurutkan berdasarkan username secara ascending

Source Code nya :
```
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


```

### Penjelasan 1E

Sama halnya dengan no 1D , 1E memindahkan semua informasi yang didapatkan di 1C di pindah kedalam file ```user_statistic.csv```
1. Membuat file ```user_statistic``` yang memiliki header ```USER,INFO,ERROR``` dengan code berikut ```printf 'Username,INFO,ERROR\n' > user_statistic.csv```
2. Setelah membuat file ```user_statistic``` selanjutnya membuat regex untuk mengambil data sesuai yang kita ingingkan dengan code sebagai berikut 
```
cat syslog.log | grep "ERROR" | cut -f7- -d' ' | cut -f2 -d'(' | cut -f1 -d')' | sort | uniq -c | grep -Eo '[0-9]{1,}' > errorcount.csv

cat syslog.log | grep "INFO" | cut -f7- -d' ' | cut -f2 -d '(' | cut -f1 -d')' | sort | uniq -c | grep -Eo '[0-9]{1,}' > infocount.csv

cat syslog.log | cut -f2 -d'(' | cut -f1 -d')' | sort | uniq -c | tr -d '[0-9]' | sed -e 's/^[[:space:]]*//' > user.csv

cat syslog.log | grep "ERROR" | cut -f2 -d'(' | cut -f1 -d')' | sort | uniq -c | tr -d '[0-9]' | sed -e 's/^[[:space:]]*//' > errorname.csv

cat syslog.log | grep "INFO" | cut -f2 -d'(' | cut -f1 -d')' | sort | uniq -c | tr -d '[0-9]' | sed -e 's/^[[:space:]]*//' > infoname.csv
```

file ```errorcount.csv``` untuk menghuitung jumlah error yang didapatkan berdasarkan username
file ```infocount.csv```  untuk menghitung jumlah info yang didapatkan berdasarkan username
file ```user.csv``` untuk menampilkan dan menyimpan username 
file ```errorname.csv``` untuk menampilkan nama yang mendapatkan log ERROR
file ```infoname.csv``` untuk menampilkan nama yang mendapatkan log INFO

3. Setelah selesai kita pindahkan semua file ke ```user_statistic.csv``` dengan melakukan perulangan sebagai berikut:
```
while read username;
do
   nama_user="$username"
   info_user=0
   error_user=0
```
code diatas melakukan perulangan dengan argumen username 
```

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
```
Selanjutnya code diatas melakukan pengencekan setiap data yang ingin dimasukkan ke dalam file ```user_statistic.csv``` misal ketika menyalin file ```infocount.csv``` dengan file ```infoname.csv``` akan di lakukan pengecekan apakah argumen username dari file ```user.csv``` cocok dengan kedua file tersebut dengan code berikut 
```
 if [ "$nama_user" == "$info_name" ]
                                       then
                                           info_user=$info_count
                                           break
                                       fi
``` 

jika cocok maka hasil dari ```infocount.csv``` akan dimasukkan ke dalam variabel ```info_user``` yang akan di tampilkan kedalam file ```user_statistic.csv```
setelah melakukan mengecekanna jumlah info yang diperoleh per user maka akan dilakukan pengecekan jumlah error dengan kode berikut dan akan disalin ke data ```user_statistic.csv```
```
if [ "$nama_user" == "$error_name" ]
                                             then
                                                 error_user=$error_count
                                                 break
                                             fi
```

Setelah selesai semua maka kita hapus 5 file yang kita buat untuk temp dengan code berikut :
```
rm user.csv
rm errorcount.csv
rm infocount.csv
rm errorname.csv
rm infoname.csv

```



***
## Penjelasan nomor 2 ##
Steven dan Manis mendirikan sebuah startup bernama “TokoShiSop”. Sedangkan kamu dan Clemong adalah karyawan pertama dari TokoShiSop. Setelah tiga tahun bekerja, Clemong diangkat menjadi manajer penjualan TokoShiSop, sedangkan kamu menjadi kepala gudang yang mengatur keluar masuknya barang.

Tiap tahunnya, TokoShiSop mengadakan Rapat Kerja yang membahas bagaimana hasil penjualan dan strategi kedepannya yang akan diterapkan. Kamu sudah sangat menyiapkan sangat matang untuk raker tahun ini. Tetapi tiba-tiba, Steven, Manis, dan Clemong meminta kamu untuk mencari beberapa kesimpulan dari data penjualan “Laporan-TokoShiSop.tsv”.

### 2a. Menentukan Profit Percentage Terbesar dengan Row ID terbesar

Sebelum kita mengerjakan, kita harus memberi shebang terlebih dahulu pada kode editor kita, agar file dapat dibaca dalam terminal bash, bentuknya yaitu `#!/bin/bash`. Nah setelahnya barulah kita membuat kodenya,
```
#!/bin/bash
awk ' 
BEGIN {
	FS="\t"
}
{
    profit = $21;
    sales = $18
	costp = sales-profit
	pprofit = ($21/(costp))*100
	if(pprofit >= max){
		max = pprofit
		id=$1
	}
}
END{
print("Transaksi terakhir dengan profit percentage terbesar yaitu "id" dengan persentase "max"%.\n")
}' Laporan-TokoShiSop.tsv > hasil.txt
```
**Penjelasan :**
- import awk terlebih dahulu melalui command 
`awk '`
Karena untuk mengerjakan soal ini diperlukan awk (agar dapat membaca file) sehingga pada awal shell script harus mengimport `awk '` terlebih dahulu

- Field Separator
` BEGIN	{
   FS="\t"
   }`
Karena pada file `Laporan-TokoShisop.tsv` tiap kolom dipisahkan dengan tab maka kita menggunakan **FS="\t"**

- Mencari nilai `Profit Percentage` menggunakan rumus yang telah diketahui, yaitu
`pprofit = ($21/($18 - $21))*100`
dimana $21 adalah **profit** dan $18 adalah **sales**

- Mendapatkan nilai `Profit Percentage` terbesar
```
if(pprofit >= max){
	max = pprofit
	id=$1
}
 ```
 Dalam membandingkan pprofit, kita bandingkan dengan suatu variabel **max** untuk menyimpan nilai terbesar. Apabila dalam data terdapat nilai **pprofit** yang lebih besar jika dibandingkan dengan nilai pada **max** sebelumnya, maka nilai _Profit Percentage_  terbesar akan disimpan di dalam variabel **max**. Kemudian `id=$1` digunakan untuk menyimpan _Row ID_ yang terbesar

- Di bagian `END`, kita mengeprint sesuai dengan perintah pada soal **2e**, dimana yang diinginkan adalah ID dan nilai maksimum yang didapatkan.

- Hasil kemudian disimpan di dalam file hasil.txt
`Laporan-TokoShisop.tsv` adalah input-file yang terbaca oleh AWK, namun pastikan dia berada dalam 1 folder. Kemudian tanda **>** untuk membuat dan menaruh hasil di file yang baru yang bernama `hasil.txt`  

### 2b. Mencari nama customer yang membeli di tahun 2017 dan di kota Albuquerque

```
#!/bin/bash
awk '
BEGIN {
        FS="\t"
	}
{
    if($2~"2017" && $10 == "Albuquerque"){
        nama[$7]++
    }
}
END{
    print("Daftar nama customer di Albuquerque pada tahun 2017 antara lain:\n")
    for (i in nama){
		print i
	}
}
' Laporan-TokoShiSop.tsv >> hasil.txt
```
**Penjelasan :**
- Diawali dengan `awk` dan `field separator` seperti tadi

- Syarat tahun 2017 dan di Kota Albuquerque
```
if($2~"2017" && $10=="Albuquerque"){
      nama[$7]++
   }
```
Menggunakan if condition untuk mengecek apakah kustomer melakukan transaksi tahun 2017 di Kota Albuquerque. Kita gunakan **~** untuk mendapatkan angka 2017 yang diubah dalam bentuk string dari kolom `Order ID` ($2). Kemudian kita gunakan operator **&&** untuk menggabungkan dua kondisi, dengan menggunakan **$10** yang merupakan City, dimana harus kita **==** Albuquerque karena yang kita cari dari kota tsb.

- Setelah syaratnya terpenuhi, maka kita mendapatkan `nama kustomer` yang akan disimpan dalam sebuah array `nama[$7]++` dimana **$7** adalah `Customer Name` dan digunakan operator **++** agar isi array dapat bertambah 1 apabila setiap ada yang memenuhi. 

- Pada blok end, melakukan looping yang terdapat di dalam array dan mengeluarkan sebagai output. Dengan cara ini, setiap nama yang muncul hanya 1 kali dan tidak lebih, jangan lupa kita sekarang gunakan tanda **>>** agar hasil yang kita outputkan tidak terhapus dan ditambahkan di akhir, karena apabila kita gunakan **>** maka akan ditimpa

### 2c. Mencari Segmen Customer dan Jumlah Transaksi yang Paling Sedikit
```
awk '
BEGIN {
	FS="\t"
}
{
	segment=$8
	if(segment =="Home Office"){
		homeoffice++
	}
	else if (segment =="Consumer"){
		consumer++
	}
	else if (segment =="Corporate"){
		corporate++
	}
}
END{
	if(homeoffice<consumer && homeoffice < corporate){
	    segment="Home Office"
	    jumlah = homeoffice
	}
	else if(consumer < homeoffice && consumer < corporate){
	    segment ="Consumer"
	    jumlah = consumer
	}
	else if(corporate < homeoffice && cororate < consumer){
	    segment ="Corporate"
	    jumlah = corporate
	}
print("\nTipe segmen customer yang penjualannya paling sedikit adalah "segment"\ndengan "jumlah" transaksi.\n")
}
' Laporan-TokoShiSop.tsv >> hasil.txt
```
**Penjelasan :**

- Sama seperti sebelumnya, kita gunakan `awk` dan `field Separator`

- Agar kode lebih mudah dibaca, diawal kita deklarasikan terlebih dahulu $8 merupakan segment kustomer (berdasarkan tabel)

- Masing-masing kita gunakan **if-else** condition untuk menghitung jumlah transaksi pada masing-masing segment. Kita gunakan counter pada masing, masing segment, yaitu _homeoffice_ untuk segment **Home Office**, _consumer_ untuk **Consumer**, dan _corporate_ untuk **Corporate**. Counter akan bertambah bila memenuhi syarat 

- Dalam menampilkan `Tipe Segment` dan `Jumlah Transaksi Segment`, kita gunakan **if-else** condition lagi. Kita bandingkan terhadap masing-masing segmen, dan terdapat 3 kondisi, yaitu apabila _homeffice_ atau _consumer_ atau _corporate_ yang terkecil

### 2d. Mencari Region yang Memiliki Profit Tersedikit dan Total Keuntungannya
```
#!/bin/bash
awk ' 
BEGIN {
	FS="\t"
}
{
	region=$13
    profit =$21
	if(region == "Central"){
		jmlcentral+=profit
	}
	if (region =="East"){
		jmleast+=profit
	}
	if(region =="South"){
		jmlsouth+=profit
	}
	if(region =="West"){
		jmlwest+=profit
	}
}
END {
    if (jmlcentral < jmleast && jmlcentral < jmlsouth && jmlcentral < jmlwest){
	    jmlkecil = jmlcentral
	    wilkecil ="Central"
	}
    else if (jmleast < jmlcentral && jmleast < jmlsouth && jmleast < jmlwest){
	    jmlkecil = jmleast
	    wilkecil ="East"
	}
    else if (jmlsouth < jmlcentral && jmlsouth < jmleast && jmlsouth < jmlwest){
	    jmlkecil = jmlsouth
	    wilkecil ="South"
	}
    else if (jmlwest < jmlcentral && jmlwest < jmleast && jmlwest < jmlsouth){
	    jmlkecil = jmlwest
	    wilkecil ="West"
	}
print ("Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah "wilkecil " dengan total keuntungan " jmlkecil)
}' Laporan-TokoShiSop.tsv >> hasil.txt 
```
**Penjelasan :**
- Sama seperti tadi, kita gunakan `awk` dan `Field Separator`

- Cara menjawab yang digunakan hampir mirip seperti pada nomor **2c** namun disini yang digunakan adalah _region_ yang terdapat pada $13 dan _profit_ yang terdapat pada $21. Kita gunakan **if-else statement** kembali dan mencari jumlah total keuntungan dari tiap region.

- Dalam bagian END, kita gunakan **if-else statement** kembali untuk membandingkan mana daerah yang memiliki `jumlah profit` terkecil. Setelah mendapatkannya, kita print sesuai yang diinginkan pada soal dan menggunakan **>>** untuk menyimpan hasil.

***

## Soal 3 ##
* ### 3a
* Membuat script untuk mengunduh 23 gambar dari "https://loremflickr.com/320/240/kitten" serta menyimpan log-nya ke file "Foto.log". Karena gambar yang diunduh acak, ada kemungkinan gambar yang sama terunduh lebih dari sekali, oleh karena itu kalian harus menghapus gambar yang sama (tidak perlu mengunduh gambar lagi untuk menggantinya). Kemudian menyimpan gambar-gambar tersebut dengan nama "Koleksi_XX" dengan nomor yang berurutan tanpa ada nomor yang hilang (contoh : Koleksi_01, Koleksi_02, ...) </br>
```
for i in {1..23}
do
if [ $i -lt 10 ]
then
	wget -a "Foto.log" -O Koleksi_0$i.jpg https://loremflickr.com/320/240/kitten
else
	wget -a "Foto.log" -O Koleksi_$i.jpg https://loremflickr.com/320/240/kitten
fi
done
```
Melakukan download 23 gambar dengan menggunakan command wget dari "https://loremflickr.com/320/240/kitten" ditambahkan parameter -a untuk append logfile wget dan -O untuk merename gambar dengan format "Koleksi_0$i.jpg" untuk gambar ke-1 sampai 9 dan selebihnya dengan menggunakan "Koleksi_$i.jpg".

```
fdupes -d -N ~/Documents/SoalShift1/no3
```
Lalu dikarenakan ada kemungkinan gambar yang sama terunduh lebih dari sekali, maka digunakanlah command fdupes dengan parameter -d untuk mendelete duplicate file yang terunduh dan -N untuk menonaktifkan konfirmasi delete dari prompt.
```
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
```
Setelah kita menghapus duplicate files yang ada, tentu saja ada Koleksi foto yang hilang. Untuk merapikan namanya, menggunakan for looping dengan menggunakan command mv.

* ### 3b
* Karena Kuuhaku malas untuk menjalankan script tersebut secara manual, ia juga meminta kalian untuk menjalankan script tersebut sehari sekali pada jam 8 malam untuk tanggal-tanggal tertentu setiap bulan, yaitu dari tanggal 1 tujuh hari sekali (1,8,...), serta dari tanggal 2 empat hari sekali(2,6,...). Supaya lebih rapi, gambar yang telah diunduh beserta log-nya, dipindahkan ke folder dengan nama tanggal unduhnya dengan format "DD-MM-YYYY" (contoh : "13-03-2023").</br>
```
tgl=$(date +"%d-%m-%Y")
mkdir "$tgl"
bash soal3a.sh
mv Koleksi_*.jpg Foto.log $tgl
```
Pertama kita buat variabel yang berisikan format tanggal waktu "dd-mm-yyyy" dan buat foldernya dengan menggunakan command mkdir. Lalu unduh gambar melalui script soal3a.sh yang telah dibuat sebelumya dan pindahkan ke folder dengan nama format tanggal yang telah dibuat tadi.
```
0 20 1-31/7,2-31/4 * * /home/zenryuu/Documents/SoalShift1/no3/soal3b.sh
```
Selanjutnya, agar script tersebut bisa dijalankan sehari sekali pada jam 8 malam di tanggal tertentusetiap bulan yakni dari tanggal 1 tujuh hari sekali dan dari tanggal 2 empat hari sekali, menggunakan crontab. Dengan kolom pada menit 0, lalu pukul 20:00, dari tanggal 1-31 dengan 7 hari sekali dan 2-31 dengan 4 hari sekali.

* ### 3c
* Agar kuuhaku tidak bosan dengan gambar anak kucing, ia juga memintamu untuk mengunduh gambar kelinci dari "https://loremflickr.com/320/240/bunny". Kuuhaku memintamu mengunduh gambar kucing dan kelinci secara bergantian (yang pertama bebas. contoh : tanggal 30 kucing > tanggal 31 kelinci > tanggal 1 kucing > ... ). Untuk membedakan folder yang berisi gambar kucing dan gambar kelinci, nama folder diberi awalan "Kucing_" atau "Kelinci_" (contoh : "Kucing_13-03-2023"). </br>
```
kemaren=$(date -d yesterday +"%d-%m-%Y")
sekarang=$(date +"%d-%m-%Y")
```
Sebagai awalan, kita mencari tanggal kemarin dan sekarang dengan format "dd-mm-yyyy" menggunakan command date dan disimpan ke dalam variabel.
```
if [ -d "Kucing_$kemaren" ]
then
	for i in {1..23}
do
	if [ $i -lt 10 ]
then
        wget -a "Foto.log" -O Koleksi_0$i.jpg https://loremflickr.com/320/240/bunny
else
        wget -a "Foto.log" -O Koleksi_$i.jpg https://loremflickr.com/320/240/bunny
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
mkdir "Kelinci_$sekarang"
mv Koleksi_*.jpg Foto.log "Kelinci_$sekarang"


else

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

mkdir "Kucing_$sekarang"
mv Koleksi_*.jpg Foto.log "Kucing_$sekarang"

fi
```
Kemudian melakukan pengecekan kondisi if dengan mengecek apakah sudah ada folder "Kucing_$kemaren". Jika sudah ada, maka unduh gambar kelinci jika tidak ada maka akan mengunduh gambar kucing. Setelah melakukan unduhan, hasilnya disimpan pada folder "Kelinci_$sekarang" atau "Kucing_$sekarang".

* ### 3d
* Untuk mengamankan koleksi Foto dari Steven, Kuuhaku memintamu untuk membuat script yang akan memindahkan seluruh folder ke zip yang diberi nama “Koleksi.zip” dan mengunci zip tersebut dengan password berupa tanggal saat ini dengan format "MMDDYYYY" (contoh : “03032003”).</br>
```
pass=$(date +"%d%m%Y")
zip -P "$pass" -rm Koleksi.zip Kucing_* Kelinci_*
```
Membuat pass dengan command date "mmddyyyy" lalu memindahkan seluruh folder "Kucing_*" dan "Kelinci_*" ke Koleksi.zip dengan menggunakan command zip -rm dan -P untuk password yang telah dibuat di variabel pass.

* ### 3e
* Karena kuuhaku hanya bertemu Steven pada saat kuliah saja, yaitu setiap hari kecuali sabtu dan minggu, dari jam 7 pagi sampai 6 sore, ia memintamu untuk membuat koleksinya ter-zip saat kuliah saja, selain dari waktu yang disebutkan, ia ingin koleksinya ter-unzip dan tidak ada file zip sama sekali.</br>
```
0 7 * * 1-5 /home/zenryuu/Documents/SoalShift1/no3/soal3d.sh
0 18 * * 1-5 unzip -P 'date +"%d%m%Y"' /home/zenryuu/Documents/SoalShift1/no3/Koleksi.zip && rm /home/zenryuu/Documents/SoalShift1/no3/Koleksi.zip
```
Membuat crontab yang digunakan untuk mengunci zip pada Senin-Jum'at dari jam 07:00 sampai 18:00 dan membuka meng-unzip selain waktu itu. Maka cron meng-zip dibuat dengan kolom 0 7 * * 1-5 yang artinya di jam 07:00 setiap hari dalam seminggu dari senin sampai jum'at. Lalu cron unzip nya dibuat dengan kolom 0 18 * * 1-5 yang artinya setiap jam 18:00 setiap hari dalam seminggu dari senin sampai jum'at. Cron meng-zip menjalankan script soal3d.sh yang fungsi nya meng-zip dan cron unzip untuk mengunzip Koleksi.zip pada path tersebut dan meremove zipnya.
