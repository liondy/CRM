ALTER PROCEDURE investasiUpdate(
	@IdKlien int,
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
	declare @idCs int --cek cs nya valid atau tidak

	SET @idInv = (
		SELECT
			idIvest
		FROM
			Investasi
		WHERE
			fkIdKlien = @IdKlien
	)

	SET @idCs = (
		SELECT
			idC
		FROM
			CusService
		WHERE
			idC = @fkCusSer
	)

	IF @idInv IS NOT NULL AND @idCs IS NOT NULL
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