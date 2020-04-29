ALTER PROCEDURE investasiDelete(
	@idKlien int
)
AS
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

ALTER PROCEDURE investasiUpdate(
	@IdKlien varchar(50),
	@nominal money,
	@fkCusSer int
)
AS
	--untuk mendapatkan waktu server saat ini
	declare @curDate datetime
	select 
		@curDate = GETDATE()

	declare @idInv int --idInvestasi yang baru dimasukkan
	declare @idPerubahan int --idPerubahan terakhir
	declare @nomBefore money --nominal sebelum perubahan terakhir
	declare @tempLatestDate datetime --ambil tanggal perubahan terakhir
	declare @tempFKcusBefore int --ambil fkcus yang sebelum nya melayani klien 

BEGIN
	select
		@tempLatestDate = investasi.waktu
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
	
	UPDATE investasi SET
		fkIdKlien = @IdKlien, nominal = @nominal, waktu = @curDate, fkCusService = @fkCusSer
	WHERE 
		investasi.fkIdKlien = @IdKlien

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
	@idKlien varchar(50),
	@nominal money,
	@cusSer int
)
AS
	--untuk mengambil waktu saat ini
	declare @curDateTime datetime
	select
		@curDateTime = GETDATE()

	declare @idInvest int
	declare @idPerubahan int
	declare @idK1 int
	declare @idK2 int
	set @idK1 = (
		SELECT
			fkIdKlien
		FROM
			Investasi
		WHERE
			fkIdKlien = @idKlien
	)

	set @idK2 = (
		SELECT
			idK
		FROM
			Klien
		WHERE
			idK = @idKlien
	)

	IF @idK1 IS NULL AND @idK2 IS NOT NULL
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
			perubahan.waktu = @curDateTime

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
			@idPerubahan, 'fkCusService', 'int', ''
		)
	END

	SELECT
		Klien.idK AS 'Id Klien',
		Klien.nama AS 'Nama',
		nominal AS 'Besaran Investasi',
		waktu,
		CusService.nama AS 'Nama CS'
	FROM
		Investasi INNER JOIN Klien ON
		Investasi.fkIdKlien = Klien.idK INNER JOIN CusService ON
		Investasi.fkCusService = CusService.idC
	WHERE
		Investasi.fkIdKlien = @idKlien

	SELECT
		idPe AS 'id Perubahan',
		waktu,
		tabel,
		idRecord AS 'id Klien',
		operasi,
		kolom,
		nilaiSebelum AS 'Nilai Sebelum'
	FROM
		History INNER JOIN Perubahan ON
		History.fkPerubahan = Perubahan.idPe
	WHERE
		tabel = 'investasi' AND
		idRecord = @idKlien