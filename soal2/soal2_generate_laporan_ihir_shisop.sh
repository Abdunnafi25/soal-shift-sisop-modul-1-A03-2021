#2a
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

#2b
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

#2c
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

#2d
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
