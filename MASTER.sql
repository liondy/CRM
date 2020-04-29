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
	STORED PROCEDURE untuk me reset seluruh data yang ada
	Dipakai saat data sudah banyak yang salah karena error
*/
EXEC reset

/*
	Stored Procedure untuk memasukkan no HP seorang klien
	No HP yang dimasukkan hanya dibatasi 2 saja dan no HP tidak boleh sama
	@param idKlien: id dari klien yang akan diinput no HP nya
	@param no HP: no hp klien (string) --> input perlu pakai ''
	@return: nama beserta no HP untuk klien tersebut
*/
EXEC noHPInsert 1,'08123546853'

/*
	Stored Procedure untuk menghapus no HP seorang klien
	@param idKlien: id dari klien yang ingin dihapus no HP nya
	@param no HP: no hp klien (string) --> input perlu pakai ''
	Keterangan: Apabila ingin melakukan update, maka hal yang dilakukan adalah:
		1. nomor telepon yang ingin di update dihapus dengan menjalankan SP noHpDelete
		2. nomor telepon baru ditambahkan dengan menjalankan SP noHPInsert
	@return: nama beserta no HP untuk klien tersebut
*/
EXEC noHpDelete 1, '08123546853'

/*
	Stored Procedure untuk cek id kota dari suatu kota
	Dipakai agar saat ingin memasukan sebuah kota sudah dipastikan terlebih dahulu id dari parent nya
	@param region: nama region yang ingin dicari ID nya
	@return id dari region tersebut untuk dipakai di SP insertReg
*/
EXEC checkIdKota 'Bandung'

/*
	Stored Procedure untuk menambahkan sebuah region
	Suatu region bisa memiliki parent
	Region yang tidak memiliki parent dapat diisi dengan 0 untuk parent nya.
	Syarat: id parent harus ada di dalam basis data (kecuali tidak punya daerah, langsung tulis 0 saja)
	@param namaDaerah: nama daerah yang ingin dimasukkan ke dalam basis data (string) --> penulisan harus pakai ''
	@param idParent: id dari daerah yang akan menjadi parent daerah tersebut (int)
	@return: tabel daerah yang baru saja dimasukan serta nama parent nya serta tabel log nya
*/
EXEC insertReg 'Bogor', 4

/*
	Stored Procedure untuk melakukan update terhadap region yang ada
	Update yang dilakukan adalah mengupdate parent (kelompok) dari suatu region
	Kedua param ini merupakan ID (ID dapat di cek dari SP checkIdKota)
	@param nama Region: nama dari region yang ingin diubah
	@param id Kelompok Lama: id dari region yang lama yang ingin di lepas
	@param id Kelompok Baru: id dari region yang baru yang ingin di pakai
	@return: tabel daerah yang baru diupdate serta nama parent nya serta tabel log nya
*/
EXEC updateReg 'Bogor', 2, 4

/*
	Stored Procedure untuk melakukan UNDO terhadap perubahan id kota
	Saat ini fitur ini belum berfungsi dengan baik karena masih terkendala dengan beberapa hal
	@param: -
	@return: -
*/
EXEC undoRegion

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

/*
	STORED PROCEDURE untuk UNDO operasi investasi
	Saat ini baru sampai dapat mengembalikan nominal yang salah dimasukkan
	@param: -
	@return: saat ini masih belum ada hasil return
*/
EXEC undoPerubahanInvestasi

/*
	STORED PRODUCE untuk INSERT data hubungan dari klien
	Syarat : Harus mendaftar menjadi klien terlebih dahulu 
	Apabila id klien tidak ada maka harus di insert dulu pada table klien
	@param idUser : id dari klien yang akan di input hubunganya dengan siapa
	@param posisi : menunjkkan posisi dalam keluarga (e.g Ibu) dituliskan dalam int
*/

exec hubunganInsert 3,1

/*
	STORE PRODUCE untuk DELETE data hubungan dari klien
	Syarat : harus terdaftar menjadi klien (ada id klien)
	jika tidak terdaftar menjadi klien maka akan tidak mengembalikan apapaun
	@param idUser : menghapus hubungan dalam user misalnya user tersebut pindah KK 
	maka hubungan lama akan di delete dan di insert yang baru
*/

exec hubunganDelete 1

/*
	STORE PRODUCE untuk DELETE data klien
	Syarat : harus terdaftar menjadi klien terlebih dahulu
	@param nama : nama dari klien yang sudah terdaftar dan mau di hapus
	@idK  = id dari klien yang mau di hapus
	menggunakan nama dan id agar meminimalisir kesalahan dalam input
*/

exec KlienDelete 'Asep', 5

