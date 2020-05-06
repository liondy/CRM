/*
    HANYA UNTUK TESTING (OPTIONAL)
*/

insert into klien (nama,alamat,tglLahir,fkRegion, fkHubungan, status, email)  select 'Denise Stevani', 'rancabintang', '19990511', 1, 1, 1, 'dsgeb@gmail.com'
insert into klien (nama,alamat,tglLahir,fkRegion, fkHubungan, status, email)  select 'Cristine Artanty', 'rancabintang', '19990127', 1, 1, 1, 'tinetiny@gmail.com'
insert into klien (nama,alamat,tglLahir,fkRegion, fkHubungan, status, email)  select 'Friska Christiana', 'rancabintang', '19981219', 1, 1, 1, 'friskac@gmail.com'
insert into klien (nama,alamat,tglLahir,fkRegion, fkHubungan, status, email)  select 'Michael Liondy', 'rancavenus', '19990105', 1, 2, 1, 'miclio@gmail.com'
insert into klien (nama,alamat,tglLahir,fkRegion, fkHubungan, status, email)  select 'Asep', 'rancavirus', '20200428', 3, 3, 1, 'asep@gmail.com'
insert into klien (nama,alamat,tglLahir,fkRegion, fkHubungan, status, email)  select 'Aep', 'rancavirus', '20200428', 3, 3, 1, 'aep@gmail.com'
insert into klien (nama,alamat,tglLahir,fkRegion, fkHubungan, status, email)  select 'Agus', 'rancabulan', '20200427', 2, 4, 1, 'agus@gmail.com'
insert into klien (nama,alamat,tglLahir,fkRegion, fkHubungan, status, email)  select 'Aga', 'rancabulan', '19881227', 3, 5, 1, 'aga@gmail.com'
insert into klien (nama,alamat,tglLahir,fkRegion, fkHubungan, status, email)  select 'Agan', 'rancaranca', '20000501', 5, 6, 1, 'agan@gmail.com'
insert into klien (nama,alamat,tglLahir,fkRegion, fkHubungan, status, email)  select 'Agar', 'rancavenus', '19881227', 1, 2, 1, 'agar@gmail.com'

insert into noHpKlien select 1, '081234567891'
insert into noHPKlien select 1, '089875645855'
insert into noHPKlien select 1, '087852345758'
insert into noHpKlien select 2, '081234567892'
insert into noHpKlien select 3, '081234567893'
insert into noHPKlien select 3, '012345678910'
insert into noHpKlien select 4, '081234567894'
insert into noHpKlien select 4, '085879542391'
insert into noHPKlien select 5, '058546872135'
insert into noHPKlien select 6, '035487366810'
insert into noHpKlien select 6, '054893523575'
insert into noHpKlien select 6, '023156789782'
insert into noHPKlien select 6, '098765432100'
insert into noHpKlien select 7, '018888088888'
insert into noHpKlien select 7, '088897856520'
insert into noHPKlien select 7, '000000000000'
insert into noHPKlien select 8, '012333333333'
insert into noHpKlien select 9, '055454464646'
insert into noHpKlien select 10, '08780889999'
insert into noHPKlien select 10, '01111011101'
insert into noHpKlien select 10, '01234567898'

insert into cusService (nama) select  'Tom'
insert into cusService (nama) select  'Jerry'

--anggap klien 1-3 merupakan 1 keluarga, sehingga memiliki idKK yang sama
--klien nomor 4 dari keluarga yang berbeda, sehingga idKK nya berbeda
insert into hubungan (idKK,idUser, posisi) select 1, 1, 'ayah'
insert into hubungan (idKK,idUser, posisi) select 1, 2, 'anak pertama'
insert into hubungan (idKK,idUser, posisi) select 1, 3, 'ibu'
insert into hubungan (idKK,idUser, posisi) select 2, 4, 'anak pertama'
insert into hubungan (idKK,idUser, posisi) select 3, 5, 'anak kedua'
insert into hubungan (idKK,idUser, posisi) select 3, 6, 'anak pertama'
insert into hubungan (idKK,idUser, posisi) select 4, 7, 'ayah'
insert into hubungan (idKK,idUser, posisi) select 5, 8, 'ayah'
insert into hubungan (idKK,idUser, posisi) select 6, 9, 'anak kedua'
insert into hubungan (idKK,idUser, posisi) select 2, 10, 'ayah'

--anggap parent root adalah Indonesia
insert into region (namaKelompok, idParent) select 'Indonesia', 0
insert into region (namaKelompok, idParent) select 'Jawa Barat', 1
insert into region (namaKelompok, idParent) select 'Sumatera uUtara', 2
insert into region (namaKelompok, idParent) select 'Jakarta', 1
insert into region (namaKelompok, idParent) select 'Region A', 3

--dummy data untuk investasi
insert into investasi (fkIdKlien, nominal, waktu, fkCusService) select 1, 200000, '20190407 15:20:01 PM', 1
insert into investasi (fkIdKlien, nominal, waktu, fkCusService) select 2, 50000, '20190401 10:10:10 AM', 1
insert into investasi (fkIdKlien, nominal, waktu, fkCusService) select 3, 50000, '20190401 13:10:10 PM', 1
insert into investasi (fkIdKlien, nominal, waktu, fkCusService) select 4, 500000, '20190401 13:05:05', 2
insert into investasi (fkIdKlien, nominal, waktu, fkCusService) select 4, 1000000, '20190402 12:05:05', 1

--tabel pencatatan perubahan, 1: Insert, 2: Update, 3: Delete
insert into perubahan (waktu, tabel, idRecord, operasi) select '20190401 09:34:09 AM', 'investasi', 1,1
insert into perubahan (waktu, tabel, idRecord, operasi) select  '20190401 10:10:10 AM', 'investasi', 2, 1
insert into perubahan (waktu, tabel, idRecord, operasi) select '20190401 13:00:01 PM', 'investasi', 3, 1
insert into perubahan (waktu, tabel, idRecord, operasi) select '20190401 13:05:01 PM', 'investasi', 4, 1
insert into perubahan (waktu, tabel, idRecord, operasi) select '20190401 13:10:10 PM', 'investasi', 3, 2
insert into perubahan (waktu, tabel, idRecord, operasi) select '20190402 12:05:01 PM', 'investasi', 4, 2
insert into perubahan (waktu, tabel, idRecord, operasi) select  '20190405 10:50:11 AM', 'investasi', 1, 2
insert into perubahan (waktu, tabel, idRecord, operasi) select '20190407 15:20:01 PM', 'investasi', 1,2

--tabel history yang mencatat perubahan2 yg ada
insert into history (fkPerubahan, kolom, tipeData, nilaiSebelum) select  1, 'nominal', 'money', '0'
insert into history (fkPerubahan, kolom, tipeData, nilaiSebelum) select 2, 'nominal', 'money', '0'
insert into history (fkPerubahan, kolom, tipeData, nilaiSebelum) select 3, 'nominal', 'money', '0'
insert into history (fkPerubahan, kolom, tipeData, nilaiSebelum) select 4, 'nominal', 'money', '0'
insert into history (fkPerubahan, kolom, tipeData, nilaiSebelum) select 5, 'nominal', 'money', '100000'
insert into history (fkPerubahan, kolom, tipeData, nilaiSebelum) select 6, 'nominal', 'money', '500000'
insert into history (fkPerubahan, kolom, tipeData, nilaiSebelum) select  7, 'nominal', 'money', '50000'
insert into history (fkPerubahan, kolom, tipeData, nilaiSebelum) select  8, 'nominal', 'money', '100000'

--klien baru investasi punya kerabat
--cari dulu kerabat klien
--SP cariKerabat
--param: @namaKerabat, @alamat, @posisi
/*
	select fkHubungan from klien join hubungan on klien.fkHubungan = hubungan.idKK
	where nama = @namaKerabat and alamat = @alamat and posisi = @posisi
*/
--hasil dari SP cariKerabat masukin sebagai parameter @idKKel di SP investasiKlienBaru

--klien baru investasi tidak punya kerabat, @idKKel diisi 0 saja
--SP investasiKlienBaru
--param: @nama, @alamat, @tglLahir, @kota, @email, @nominal, @idCs, @idKKel
/*
	1. cari kota yang ditinggal klien tersebut
	2. kalau gaada
		insert into region (namaKelompok, idParent) select @kota, NULL(?)
	3. dapetin fkRegionnya, simpen di @idRegion
		select idR from region where namaKelompok = @kota
	3. minta KK nya, kalau belum punya kerabat yang invest disini berarti
		select max(idKK) from hubungan --> ambil idKK paling maksimum, berarti paling terakhir sekarang
		simpan idKK yang didapat ke variable @idKK+1 biar beda.
		kalau uda ada, bisa langsung pakai @idKK dari parameter, jadi @idKK = @idKKel
	4. masukin ke tabel klien, status pada klien pasti 1 pas awal karena dia baru daftar jadi klien
		insert into klien ((nama,alamat,tglLahir,fkRegion, fkHubungan, status, email))
		values (@nama, @alamat, @tglLahir, @idRegion, @idKK, 1, @email)
	5. dapetin @idKlien dengan cara
		select idK from Klien where nama = @nama
	6. bikin tanggal baru, misal @curDate = new Date();
	7. masukin ke tabel investasi
		insert into investasi (fkIdKlien, nominal, waktu, fkCusService)
		select @idUser, @nominal, @curDate, @idCs
	8. dapetin idInvestasinya
		@idInvest = select idInvest from investasi where fkIdKlien = @idUser
	9. masukin ke tabel perubahan
		insert into perubahan (waktu, tabel, idRecord, operasi)
		select @curDate,@idInvest,1 --> disini 1 karena dia statusnya adalah client baru sehingga operasinya pasti insert
	10. dapetin @fkPerubahan = select idPe from perubahan where waktu = @curDate and idRecord = @idInvest and operasi = 1
	11. masukin ke tabel history
		insert into history (fkPerubahan, kolom, tipeData, nilaiSebelum)
		select @fkPerubahan, 'nominal', 'money', '0'
	12. return tabel klien, invest, perubahan, history aja biar tau sukses ngga nya
*/

--Kasus tambah Investasi
--CS harus memastikan bahwa ia terdaftar di klien dan mengambil idKliennya dengan cara
--param: @nama, @tglLahir,@email
/*
	select idK, alamat from klien where nama=@nama and tglLahir = @tglLahir and email = @email
*/
--apabila tidak ada perubahan alamat maka tidak ada masalah, parameter alamatBaru pada SP tambahInvestasi ditulis sama saja
--apabila klien pindah rumah, maka alamat baru harus dimasukkan ke dalam parameter SP tambahInvestasi
--hasil dari SP cariIdKlien akan dijadikan parameter @idKlien untuk SP tambahInvestasi
--SP tambahInvestasi
--param: @idKlien, @nominal, @idCs, @idAlamatBaru
/*
	1. ambil idInvest, nominal serta cs terakhir yang melayaninya
		select idInvest, nominal, fkCustomerService from investasi where fkIdKlien = @idKlien
		masukkan sebagai variable @idInvest, @nominalTerakhir, @CsTerakhir
	2. buat tanggal sekarang
		@curDate = new Date();
	3. hasilnya masukin ke tabel perubahan
		insert into perubahan
		select @curDate, 'investasi', @idInvest, 2
	4. ambil idPerubahan terakhir
		select idPe from perubahan where waktu = @curDate and idRecord=@idInvest and operasi=2
		simpen ke @idPerubahan
	5. log ke tabel history
		insert into history (fkPerubahan, kolom, tipeData, nilaiSebelum) select  @idPerubahan, 'nominal', 'money', @nominal
	6. cek cs sama atau beda
		kalau @CsTerakhir = @idCs, lanjut ke poin 7
		kalau cs beda, log ke tabel history
		insert into history (fkPerubahan, kolom, tipeData, nilaiSebelum) select @idPerubahan, 'fkCusService', 'int', @CsTerakhir
	7. cek alamat klien
		select alamat from klien where idK=@idKlien
		simpen ke variable @alamatLama
	8. apabila @alamatLama != @alamatBaru
		insert into perubahan
		select @curDate, 'klien', @idKlien, 2
		insert into history (fkPerubahan, kolom, tipeData, nilaiSebelum) select @idPerubahan, 'alamat', 'varchar(100)', @alamatLama
	9. update tabel investasi terbaru
		update investasi
		set waktu = @curDate, fkCusService = @idCs, nominal = @nominal
		where fkIdKlien = @idKlien
*/