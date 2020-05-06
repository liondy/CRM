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
	declare @idCs int
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

	SET @idCs = (
		SELECT
			idC
		FROM
			CusService
		WHERE
			idC = @cusSer
	)

	IF @idK1 IS NULL AND @idK2 IS NOT NULL AND @idCs IS NOT NULL
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