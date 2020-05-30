alter procedure updateReg(
	@namaRegion varchar(50),
	@idParLama int,
	@idParBaru int
)
as
	DECLARE @idRegion int --untuk mendapatkan idReg dari param @namaRegion dan @parLama
	DECLARE @idReg int
	SET @idRegion = (
		SELECT
			idR
		FROM
			Region
		WHERE
			namaKelompok = @namaRegion and idParent = @idParLama
	)
	IF @idRegion IS NOT NULL
	BEGIN
		--untuk mendapatkan waktu server saat ini
		declare @curDate datetime
		select 
			@curDate = GETDATE()

		declare @idPerubahan int --idPerubahan terakhir
		declare @parentBefore int 
		declare @namaRegion1 varchar(50)
		declare @idR int

		SET @idR = (
			SELECT
				idR
			FROM
				Region
			WHERE
				idParent = @idParBaru AND
				namaKelompok = @namaRegion
		)
	
		IF @idParLama != @idParBaru AND @idR IS NULL 
		BEGIN
			select
				@parentBefore = region.idParent
			from
				region
			where
				region.namaKelompok = @namaRegion AND region.idParent = @idParLama

			update region
				set idParent = @idParBaru
				where 
				namaKelompok = @namaRegion AND 
				idParent = @idParLama AND
				idR = @idRegion

			/* kalo cuman update sepertinya idR nya ga akan berubah
			SET @idReg = (
				SELECT
					idR
				FROM
					Region
				WHERE
					namaKelompok = @namaRegion AND
					idParent = @idParBaru
			)
			*/

			SELECT @idRegion

			INSERT INTO perubahan(
				waktu, idRecord, operasi, tabel 
			)
			VALUES(
				@curDate, @idRegion, 'UPDATE', 'Region'
			)

			--mendapat idPerubahan yang paling baru yang barusan di insert
			select 
				@idPerubahan = perubahan.idPe
			from
				perubahan
			where
				perubahan.waktu = @curDate AND perubahan.idRecord = @idRegion

			INSERT INTO history(
				fkPerubahan,kolom, tipeData, nilaiSebelum
			)
			VALUES(
				@idPerubahan, 'idParent', 'int', @parentBefore
			)
		END
	END

	SELECT
		R.idR AS 'id Region',
		R.namaKelompok AS 'Nama Daerah',
		(SELECT
			namaKelompok
		FROM
			Region
		WHERE
			idR = R.idParent
		) AS 'Nama Kelompok'
	FROM
		Region R
	WHERE
		R.idR = @idRegion

	SELECT
		idPe AS 'id Perubahan',
		waktu,
		tabel,
		idRecord AS 'id Region',
		operasi,
		kolom,
		nilaiSebelum AS 'Nilai Sebelum'
	FROM
		History INNER JOIN Perubahan ON
		History.fkPerubahan = Perubahan.idPe
	WHERE
		tabel = 'Region' AND
		idRecord = @idRegion

EXEC updateReg 'Bogor', 2, 4