ALTER PROCEDURE insertReg(
	@namaRegion varchar(50),
	@idPar int
)
as
	--untuk mengambil waktu saat ini
	declare @curDateTime datetime
	select
		@curDateTime = GETDATE()

	declare @idReg int
	declare @idPerubahan int
	declare @idP int
	declare @idPP int
	declare @idRec int

	--dapetin terlebih dahulu idR untuk nama daerah tersebut
	SET @idReg = (
		SELECT
			DISTINCT (idR)
		FROM
			region
		WHERE
			namaKelompok = @namaRegion
	)

	--kalau idReg nya NULL (belum pernah ada nama daerah tersebut)
	IF @idReg IS NULL
	BEGIN
		--ambil id reg terbesar sekarang ditambah 1
		SET @idReg = (
			SELECT
				MAX(idR) + 1
			FROM
				region
		)
		--kalau masih NULL juga, berarti emang nama daerah paling pertama
		IF @idReg IS NULL
		BEGIN
			SET @idReg = 1
		END
	END
	--sampe sini, idReg nya pasti udah keiisi sama angka yang menandakan idReg si nama daerah ini

	--cek ID Parent nya harus ada dulu
	SET @idP = (
		SELECT
			DISTINCT(idR)
		FROM
			Region
		WHERE
			idR = @idPar
	)
	--kalau gada idParent nya, berarti salah input, lgsung keluar dari SP

	--cek apakah sudah ada nama daerah dan id parent yang sama dalam tabel
	SET @idPP = (
		SELECT
			idRecord
		FROM
			Region
		WHERE
			namaKelompok = @namaRegion AND
			idParent = @idPar
	)
	--kalau ada yg sama (ngembaliin record), berarti udah ada dan gausa dimasukkin lagi, lgsung keluar dari SP
	--kalau belum ada (NULL), berarti valid untuk dimasukkan

	IF @idPP IS NULL AND @idP IS NOT NULL
	BEGIN
		INSERT INTO region(
			idR, namaKelompok, idParent
		)
		VALUES (
			@idReg, @namaRegion, @idPar
		)

		--ambil record paling terakhir (artinya paling baru dimasukkin)
		select 
			@idRec = MAX(region.idRecord)
		from 
			region
		where
			region.namaKelompok = @namaRegion

		INSERT INTO Perubahan(
			waktu, idRecord, Operasi, tabel
		)
		VALUES(
			@curDateTime, @idRec, 'INSERT', 'Region'
		)
		
		select
			@idPerubahan = perubahan.idPe
		from
			perubahan
		where 
			perubahan.waktu = @curDateTime and perubahan.idRecord = @idRec

		INSERT INTO history(
			fkPerubahan, kolom, tipeData, nilaiSebelum
		)
		VALUES(
			@idPerubahan, 'idR', 'int', '0'
		)

		INSERT INTO history(
			fkPerubahan, kolom, tipeData, nilaiSebelum
		)
		VALUES(
			@idPerubahan, 'namaKelompok', 'varchar', ''
		)

		INSERT INTO history(
			fkPerubahan, kolom, tipeData, nilaiSebelum
		)
		VALUES(
			@idPerubahan, 'idParent', 'int', '0'
		)
	END

	IF @idPar = 0
	BEGIN
		SELECT
			idR AS 'ID Region',
			namaKelompok AS 'Nama Daerah',
			idParent AS 'Nama Parent'
		FROM
			Region
	END
	ELSE
	BEGIN
		SELECT
			R.idR AS 'id Region',
			R.namaKelompok AS 'Nama Daerah',
			(SELECT
				DISTINCT(namaKelompok)
			FROM
				Region
			WHERE
				idR = R.idParent
			) AS 'Nama Kelompok'
		FROM
			Region R
		WHERE
			R.namaKelompok = @namaRegion
	END

	SET @idRec = (
		SELECT
			MAX(idRecord)
		FROM
			Region
		WHERE
			namaKelompok = @namaRegion
	)

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
		idRecord = @idRec
GO
--EXEC insertReg 'Sulawesi Selatan', 0