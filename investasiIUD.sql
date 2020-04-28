ALTER PROCEDURE investasiDelete(
	@namaKlien varchar(50)
)
AS
	declare @idKlien int
	select
		@idKlien=idK
	from
		klien
	where
		klien.nama = @namaKlien

	declare @curDateTime datetime
	select
		@curDateTime = GETDATE()

	declare @tempLatestDate datetime
	select
		@tempLatestDate = max(waktu)
	from
		investasi
	where
		investasi.fkIdklien = @idKlien
		
	declare @idInv int
	select
		@idInv = investasi.idIvest
	from
		investasi
	where
		investasi.fkIdKlien = @idKlien AND investasi.waktu = @tempLatestDate

	declare @idPerubahan int
	declare @nom money
	select
		@nom = investasi.nominal
	from
		investasi
	where
		investasi.fkIdKlien = @idKlien AND investasi.waktu = @tempLatestDate

	declare @cusSerBefore int
	select
		@cusSerBefore = investasi.fkCusService
	from
		investasi
	where
		investasi.fkIdKlien = @idKlien AND investasi.waktu = @tempLatestDate
	

BEGIN
	INSERT INTO perubahan(
		waktu, tabel, idRecord, operasi
	)
	VALUES(
		@curDateTime, 'investasi', @idInv, 'DELETE'
	)

	select 
		@idPerubahan = perubahan.idPe
	from
		perubahan
	where
		perubahan.idRecord = @idInv AND perubahan.waktu = @curDateTime


	INSERT INTO history(
		fkPerubahan, kolom, tipeData, nilaiSebelum
	)
	VALUES(
		@idPerubahan, 'idIvest', 'int', @idInv
	)

	INSERT INTO history(
		fkPerubahan, kolom, tipeData, nilaiSebelum 
	)
	VALUES(
		@idPerubahan, 'fkIdKlien', 'int', @idKlien
	)

	INSERT INTO history(
		fkPerubahan, kolom, tipeData, nilaiSebelum 
	)
	VALUES(
		@idPerubahan, 'nominal' , 'money', @nom
	)

	INSERT INTO history(
		fkPerubahan, kolom, tipeData, nilaiSebelum 
	)
	VALUES(
		@idPerubahan, 'waktu', 'datetime', @tempLatestDate
	)

	INSERT INTO history(
		fkPerubahan, kolom, tipeData, nilaiSebelum
	)
	VALUES(
		@idPerubahan, 'fkCusService','int', @cusSerBefore
	)
	
	DELETE FROM investasi
	WHERE investasi.fkIdKlien = @idKlien
END

--update dapat dilakukan lebih dari dua kali
ALTER PROCEDURE investasiUpdate(
	@namaklien varchar(50),
	@nominal money,
	@fkCusSer int
)
AS
	--untuk mendapatkan waktu server saat ini
	declare @curDate datetime
	select 
		@curDate = GETDATE()
	
	--untuk mendapatkan idKlien dari namaKlien yang di input
	declare @idKlien int
	select
		@idKlien=idK
	from
		klien
	where
		klien.nama = @namaklien

	declare @idInv int --idInvestasi yang baru dimasukkan
	declare @idPerubahan int --idPerubahan terakhir
	declare @nomBefore money --nominal perubahan terakhir
	declare @tempLatestDate datetime --ambil tanggal perubahan terakhir karena diasumsikan terdapat banyak perubahan untuk suatu klien
	declare @tempFKcusBefore int --ambil fkcus yang sebelum nya melayani klien 

BEGIN
	select
		@tempLatestDate = max(waktu)
	from
		investasi
	where
		investasi.fkIdKlien = @idKlien

	select
		@nomBefore = investasi.nominal
	from
		investasi
	where
		investasi.fkIdKlien = @idKlien AND investasi.waktu = @tempLatestDate
	
	select
		@tempFKcusBefore = investasi.fkCusService
	from
		investasi
	where
		investasi.fkIdKlien = @idKlien AND investasi.waktu = @templatestDate
	
	INSERT INTO investasi(
		fkIdKlien, nominal, waktu, fkCusService
	)
	VALUES(
		@idKlien, @nominal, @curDate, @fkCusSer
	)

	--mendapat idInvest yang paling baru yang barusan di insert
	select
		@idInv = investasi.idIvest
	from
		investasi
	where
		investasi.waktu = @curDate AND investasi.fkIdKlien = @idKlien

	INSERT INTO perubahan(
		waktu, idRecord, operasi, tabel 
	)
	VALUES(
		@curDate, @idInv, 'UPDATE', 'investasi'
	)

	--mendapat idPerubahan yang paling baru yang barusan di insert
	select 
		@idPerubahan = perubahan.idPe
	from
		perubahan
	where
		perubahan.waktu = @curDate AND perubahan.idRecord = @idInv

	INSERT INTO history(
		fkPerubahan,kolom, tipeData, nilaiSebelum
	)
	VALUES(
		@idPerubahan, 'nominal', 'money', @nomBefore
	)

	if(@fkCusSer != @tempFKcusBefore)
		BEGIN
			INSERT INTO history(
				fkPerubahan,kolom, tipeData, nilaiSebelum
			)
			VALUES(
				@idPerubahan, 'fkCusService', 'int', @tempFKcusBefore
			)
		END
END

ALTER PROCEDURE investasiInsert(
	@namaKlien varchar(50),
	@nominal money,
	@cusSer int
)
AS
	--untuk mendapatkan idKlien setelah namaKlien di input
	declare @idKlien int
	select
		@idKlien=idK
	from
		klien
	where
		klien.nama = @namaKlien

	--untuk mengambil waktu saat ini
	declare @curDateTime datetime
	select
		@curDateTime = GETDATE()

	declare @idInvest int
	declare @idPerubahan int
		
	BEGIN	
		INSERT INTO investasi(
			fkIdKlien, nominal, waktu, fkCusService
		)
		VALUES (
			@idKlien, @nominal, @curDateTime, @cusSer
		)

		select 
			@idInvest = investasi.idIvest
		from 
			investasi
		where
			investasi.waktu = @curDateTime

		INSERT INTO Perubahan(
			waktu, idRecord, Operasi, tabel
		)
		VALUES(
			@curDateTime, @idInvest, 'INSERT', 'investasi'
		)

		select
			@idPerubahan = perubahan.idPe
		from
			perubahan
		where
			perubahan.waktu - @curDateTime

		INSERT INTO history(
			fkPerubahan, kolom, tipeData, nilaiSebelum
		)
		VALUES(
			@idPerubahan, 'fkIdKlien', 'int', '0'
		)

		INSERT INTO history(
			fkPerubahan, kolom, tipeData, nilaiSebelum
		)
		VALUES(
			@idPerubahan, 'nominal', 'money', '0'
		)

		INSERT INTO history(
			fkPerubahan, kolom, tipeData, nilaiSebelum
		)
		VALUES(
			@idPerubahan, 'waktu', 'datetime', '0'
		)

		INSERT INTO history(
			fkPerubahan, kolom, tipeData, nilaiSebelum
		)
		VALUES(
			@idPerubahan, 'fkCusService', 'int', '0'
		)
	END