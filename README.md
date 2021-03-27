# soal-shift-sisop-modul-1-A03-2021

Anggota : 1. Naufal Fajar  I  05111940000007
          2. Johnivan Aldo S  05111940000051
          3. Abdun Nafi'      05111940000066

***
## Penjelasan nomor 2
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

# Soal 3
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
