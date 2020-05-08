ALTER PROCEDURE investasiDelete(
	@idKlien int,
	@idCs INT
)
AS
	DECLARE @dumpIdK int
	SET @dumpIdK = (
		SELECT
			idK
		FROM
			Klien
		WHERE
			idK = @idKlien
	)

	IF @dumpIdK IS NOT NULL
	BEGIN
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
	
			UPDATE
				investasi
			SET
				nominal = 0,
				fkCusService = @idCs
			WHERE
				investasi.fkIdKlien = @idKlien
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