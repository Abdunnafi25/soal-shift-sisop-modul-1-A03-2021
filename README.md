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
