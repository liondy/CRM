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

------------------------------------------IUD FEATURES-----------------------------------------------------

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
skenario insert klien : 
		@param : nama
		@param : alamat
		@param : tanggal lahir
		@param : namaRegion 
		@param : hubungan
		@param : email
		@param : nominal
		@param : id CS

		- cek jika nama region belum ada di tabel region, 
			1. jika ada ga ada insert 
			2. jika nama region belum terdaftar insert nama region terlebih dahulu

		- cek apakah user sebelumnya pernah kedaftar kedalam tabel dengan mengecek
			1. apakah user dengan nama, tanggal lahir, dan idKK tersebut sudah ada atau tidak
			2. jika ada tidak dapat insert
			3. jika tidak maka insert

	pastikan bahwa CS sudah terdaftar
*/
exec KlienInsert 'bebek', 'kembar', '19990520', 'Bandung', 'ayah', 'tine@gmail.com', 1000, 1
exec KlienInsert 'duck', 'kembar', '19321215', 'Bogor', 'ibu', 'duck@gmail.com', 500, 1
exec KlienInsert 'macan', 'kembar', '19970101', 'Medan', 'anak pertama', 'macan@gmail.com', 2000, 1

/*
	Stored Procedure untuk mengupdate seorang klien
	Value yang di update dapat beragam yaitu
		1. alamat baru
		2. nama region baru
		3. posisi hubungan baru
		4. status baru (0: nonaktif, 1: aktif)
		5. email baru
	Semua value dipisahkan oleh ';'
	@param idKlien : id dari klien yang ingin diupdate datanya
	@param perubahan : perubahan-perubahan yang ingin dilakukan dengan format di atas
	@param investasi : nominal yang ingin dimasukkan untuk di update data investasinya
	@param id CS : id dari CS yang melayani klien
	@return data klien baru
*/
EXEC KlienUpdate 1,'unpar;;;;bebek@gmail.com',100,1

/*
	STORE PRODUCE untuk DELETE data klien
	Syarat : harus terdaftar menjadi klien terlebih dahulu
	@param nama : nama dari klien yang sudah terdaftar dan mau di hapus
	@alamat  = alamat dari klien yang sudah terdaftar saat awal
	@tglLahir : tgl lahir klien yang ingin dihapus
	@namaRegion : nama daerah klien tinggal
	menggunakan nama dan id agar meminimalisir kesalahan dalam input
*/

exec KlienDelete 'macan', 'kembar','19970101','Medan'

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
	@param namaDaerah: nama daerah yang ingin dimasukkan ke dalam basis data (string) --> penulisan harus pakai ''
	@param namaKelompok: nama daerah yang akan menjadi parent daerah tersebut (string) --> penulisan harus pakai ''
	@return: tabel daerah yang baru saja dimasukan serta nama parent nya serta tabel log nya
*/
EXEC insertRegion 'Bogor','Jawa Barat'

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
	STORED PROCEDURE untuk mengupdate investasi seseorang
	Syarat: harus pernah melakukan investasi terlebih dahulu
	Investasi sebelumnya akan di update nilainya jadi investasi yang dimasukin
	@param nama: nama klien yang ingin melakukan investasi, investasi klien sebelumnya akan di update (int)
	@param alamat: alamat klien yang ingin melakukan investasi (string)
	@param tglLahir: tgl lahir klien yang ingin melakukan investasi (string)
	@param namaRegion: tempat tinggal klien yang ingin melakukan investasi (string)
	@param nominal: nominal terbaru klien yang ingin di update (money)
	@param id CS: id CS yang melayani client, setiap CS harus mengingat id nya masing-masing (int)
*/
EXEC investasiUpdate 'bebek','kembar','19990520','Jawa Barat',100000,1

-----------------------------------FEATURES-------------------------------------------------------

/*
    STORED PROCEDURE untuk mencari klien yang sudah tidak aktif selama tiga bulan lebih
    Klien yang ditampilkan adalah klien yang berinvestasi tiga bulan yang lalu
    Program akan mencari klien yang terakhir berinvestasi tiga bulan yang lalu
    dan akan menampilkan telepon serta alamat emailnya agar perusahaan dapat menghubungi client
    @param: tidak ada
    @return: seluruh klien aktif yang sudah tidak melakukan investasi selama tiga bulan terakhir
    tabel berupa:
    namaKlien, no HP 1, no HP 2, email, terakhir investasi, lama bulan
*/
EXEC cariKlienSudahLamaTidakInvestasi

/*
	sp yang digunakan untuk membuat laporan rata rata investasi tiap daerah
	setiap klien akan di masukkan pada region yang terdapat pada leaf
	sehingga pencarian rata rata ini dilakukan pada semua leaf
	@param : tidak ada parameter pada sp ini
	@output : 
		@namaRegion : merupakan nama tempat seseorang klien
		@ratarataInvest : merupakan nilai rata-rata invest pada tiap daerah
		@jumlahKlien : merupakan jumlah klien yang melakukan investasi pada sebuah region
	SP ini dapat di improve dengan memasukkan parameter waktu jika diinginkan
	sehingga sp ini dapat mengeluarkan rata rata investasi pada jangka waktu tertentu
*/
EXEC averageInvest

/*
	STORED PROCEDURE untuk Mencari investasi tertinggi dan terendah dari seluruh daerah
	@param: -
	@return: daerah dan nama klien yang memiliki investasi terbanyak serta nominalnya dan
	daerah dan nama klien yang memiliki investasi terendah serta nominalnya
*/
EXEC laporanInvestMaxMin

----------------------------DANGER ZONE--------------------------------------

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
	STORE PROCEDURE untuk meng undo perubahan investasi dari seseorang
	Stored Procedure dapat dipanggil berkali-kali
	SP ini akan memanggil SP undoPerubahanInvestasi
	@param nama: nama dari klien yang ingin di undo
	@param alamat: alamat dari klien yang ingin di undo
	@param tglLahir: tglLahir dari klien yang ingin di undo
	@param email: email dari klien yang ingin di undo
	@return: tabel investasi yang diundo
	@return: tabel perubahan yang diundo
	@return: tabel history yang diundo
*/
exec undoInvestasi 'bebek','unpar', '1999-05-20', 'bebek@gmail.com'

/*
	Stored Procedure untuk melakukan UNDO terhadap perubahan id kota
	Saat ini fitur ini belum berfungsi dengan baik karena masih terkendala dengan beberapa hal
	@param: -
	@return: -
*/
EXEC undoRegion

--------------------------HANYA DIPANGGIL DARI DALAM SP ------------------------------
/*
	STORED PRODUCE untuk INSERT data hubungan dari klien
	Syarat : Harus mendaftar menjadi klien terlebih dahulu 
	Apabila id klien tidak ada maka harus di insert dulu pada table klien
	@param idUser : id dari klien yang akan di input hubunganya dengan siapa
	@param posisi : menunjkkan posisi dalam keluarga (e.g Ibu) dituliskan dalam int
	HANYA DIPANGGIL DARI SP KlienInsert (memasukkan seorang klien baru)
*/
EXEC hubunganInsert 3,1

/*
	STORE PRODUCE untuk DELETE data hubungan dari klien
	Syarat : harus terdaftar menjadi klien (ada id klien)
	jika tidak terdaftar menjadi klien maka akan tidak mengembalikan apapaun
	@param idUser : menghapus hubungan dalam user misalnya user tersebut pindah KK 
	maka hubungan lama akan di delete dan di insert yang baru
	HANYA DIPANGGIL DARI SP KlienUpdate (mengupdate data klien)
*/
EXEC hubunganDelete 1

/*
	Stored Procedure untuk menambahkan sebuah region
	Suatu region bisa memiliki parent
	Region yang tidak memiliki parent dapat diisi dengan 0 untuk parent nya.
	Syarat: id parent harus ada di dalam basis data (kecuali tidak punya daerah, langsung tulis 0 saja)
	@param namaDaerah: nama daerah yang ingin dimasukkan ke dalam basis data (string) --> penulisan harus pakai ''
	@param idParent: id daerah yang menjadi parent dari nama daerah baru yang dimasukkan
	@return: tabel daerah yang baru saja dimasukan serta nama parent nya serta tabel log nya
	HANYA DIPANGGIL DARI SP KlienInsert (memasukkan seorang klien baru)
*/
EXEC insertReg 'Bogor', 0

/*
	STORED PROCEDURE untuk memasukkan sebuah investasi
	Harus terdaftar sebagai klien terlebih dahulu sebelum bisa berinvestasi
	Apabila id klien tidak terdaftar, maka SP tidak akan mengembalikan apapun.
	@param idKlien: klien yang ingin melakukan investasi, ID didapat dari masukkan terlebih dahulu orang baru ke tabel klien sehingga akan mendapatkan id Klien nya (int)
	@param nominal: besaran uang yang ingin diinvestasikan client tersebut (money)
	@param CS: id CS yang melayani client, setiap CS diasumsikan mengingat id nya masing-masing (int)
	HANYA DIPANGGIL DARI SP KlienInsert (mregionInsert
/*
	STORED PROCEDURE untuk MENGHAPUS data investasi klien
	Syarat: harus terdaftar sebagai klien (pernah melakukan investasi)
	Rencananya hanya akan dipanggil saat klien menghapus data dirinya
	Sehingga akan dipanggil dari STORED PROCEDURE deleteKlien
	@param idKlien: id dari klien yang mau dihapus data investasinya
	@return: tabel yang di log ke history serta tabel investasi yang menunjukkan bahwa investasinya sudah kosong
	HANYA DIPANGGIL DARI SP KlienDelete (menonaktifkan seorang klien)
*/
EXEC investasiDelete 1

/*
	STORED PROCEDURE untuk UNDO operasi investasi
	Saat ini baru sampai dapat mengembalikan nominal yang salah dimasukkan
	@param: -
	@return: saat ini masih belum ada hasil return
	HANYA DIPANGGIL DARI SP undoInvestasi (salah meng update investasi)
*/
EXEC undoPerubahanInvestasi