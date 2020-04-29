/*
	MASTER UNTUK LIST SP
	SETIAP SP MEMILIKI DOKUMENTASI SINGKAT MENGENAI PARAM DAN KEMBALIANNYA
*/

select * from klien
select * from noHPKlien
select * from cusService
select * from hubungan
select * from region
select * from investasi
select * from perubahan
select * from history

/*
	Stored Procedure untuk mengupdate data customer service (INSERT / DELETE)
	Data Customer Service tidak dapat di UPDATE karena hanya berupa nama dan ID CS
	SP ini dapat menambah atau menghapus orang dari / ke list customer service
	@param nama: nama customer service yang ingin ditambah atau dihapus (string) --> penulisan harus pakai ''
	@param operasi: tambah atau hapus (string) --> penulisan harus pakai ''
	return: list seluruh CS, tabel perubahan join history mengenai CS tersebut
*/
EXEC updateCustomerService 'Denise','tambah'

/*
	STORED PROCEDURE UNDO perubahan CS Terakhir
	Hanya bisa UNDO Perubahan terakhir untuk CS
	Apabila tidak terakhir maka hanya mengembalikan tabel akhir saja
	dan tidak ada perubahan
	perubahan akan diberi keterangan UNDO dan tidak dihapus dari log agar tetap bisa ke track
	@param: -
	@return: list seluruh CS, tabel perubahan join history mengenai CS tersebut
*/
EXEC undoPerubahanCSTerakhir

/*
	STORED PROCEDURE untuk memasukkan sebuah investasi
	Harus terdaftar sebagai klien terlebih dahulu sebelum bisa berinvestasi
	Apabila id klien tidak terdaftar, maka SP tidak akan mengembalikan apapun.
	@param idKlien: klien yang ingin melakukan investasi, ID didapat dari masukkan terlebih dahulu orang baru ke tabel klien sehingga akan mendapatkan id Klien nya (int)
	@param nominal: besaran uang yang ingin diinvestasikan client tersebut (money)
	@param CS: id CS yang melayani client, setiap CS diasumsikan mengingat id nya masing-masing (int)
*/
EXEC investasiInsert 1,50000,1

/*
	STORED PROCEDURE untuk mengupdate investasi seseorang
	Syarat: harus pernah melakukan investasi terlebih dahulu
	Investasi sebelumnya akan di update nilainya jadi investasi yang dimasukin
	@param idKlien: klien yang ingin melakukan investasi, investasi klien sebelumnya akan di update (int)
	@param nominal: nominal terbaru klien yang ingin di update (money)
	@param id CS: id CS yang melayani client, setiap CS harus mengingat id nya masing-masing (int)
*/
EXEC investasiUpdate 1,100000,1

/*
	STORED PROCEDURE untuk MENGHAPUS data investasi klien
	Syarat: harus terdaftar sebagai klien (pernah melakukan investasi)
	Rencananya hanya akan dipanggil saat klien menghapus data dirinya
	Sehingga akan dipanggil dari STORED PROCEDURE deleteKlien
	@param idKlien: id dari klien yang mau dihapus data investasinya
	@return: tabel yang di log ke history serta tabel investasi yang menunjukkan bahwa investasinya sudah kosong
*/
EXEC investasiDelete 1

EXEC undoPerubahanInvestasi 
