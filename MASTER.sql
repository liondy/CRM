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
EXEC updateCustomerService 'Denise','hapus'

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
	@param nominal: besaran uang yang ingin diinvestasikan client tersebut (int)
	@param CS: id CS yang melayani client, setiap CS diasumsikan mengingat id nya masing-masing (int)
*/
EXEC investasiInsert 6,50000,4

