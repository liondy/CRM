--select * from klien
--select * from noHpklien
--select * from telepon
--select * from region
--select * from hubungan
--select * from perubahan
ALTER PROCEDURE KlienInsert(
	@nama varchar(50),
	@alamat varchar(50),
	@tgllahir datetime,
	@namaRegion varchar(50),
	@hubungan varchar(50),
	@email varchar(50)
	--@operasi varchar(50)
)
AS
	DECLARE 
		@reg INT,
		@idK INT,
		@iduser INT,
		@tempKK INT,
		@curDateTime DATETIME,
		@idRecord INT,
		@idPerubahan INT
	SET @curDateTime = GETDATE()

	SELECT
		@reg = idR
	FROM
		region
	WHERE
		namaKelompok = @namaRegion

	SET @idK = (
		SELECT
			idK
		FROM
			klien
		WHERE
			nama = @nama
	)

	SET @iduser = (
		SELECT
			idK
		FROM
			klien
		WHERE
			nama = @nama and tglLahir = @tgllahir
	)
	

	IF (@idK is null)
	BEGIN
		
		SET @tempKK = (
			SELECT
				MAX(idKK) + 1
			FROM
				hubungan
		)

		INSERT INTO klien(nama, alamat, tglLahir, fkRegion, fkHubungan, status, email)
		VALUES (@nama, @alamat, @tgllahir, @reg, @tempKK, 1, @email)

		SET @iduser = (
			SELECT
				idK
			FROM
				klien
			WHERE
				nama = @nama and tglLahir = @tgllahir
		)

		INSERT INTO hubungan (idKK, idUser, posisi)
		VALUES (@tempKK, @iduser, @hubungan)

		SET @idRecord = (
		SELECT
			idK
		FROM
			klien
		WHERE
			nama = @nama
		)
		INSERT INTO perubahan (waktu, tabel, idRecord, operasi)
		VALUES (@curDateTime, 'klien', @idRecord, 'INSERT')

		SET @idPerubahan = (
			SELECT
				idPe
			FROM
				Perubahan
			WHERE
				idRecord = @idRecord AND
				tabel = 'klien'
		)

		INSERT INTO history (fkPerubahan, kolom, tipeData, nilaiSebelum)
		VALUES (@idPerubahan, 'nama', 'varchar(50)','')
	END
	

	SELECT
		*
	FROM
		klien

	SELECT
		idPe AS 'id Perubahan',
		waktu,
		tabel,
		idRecord AS 'idKlien',
		operasi
	FROM
		Perubahan
	WHERE 
		tabel = 'klien'

	SELECT
		fkPerubahan AS 'id Perubahan',
		kolom,
		nilaiSebelum AS 'Data klien Sebelum'
	FROM history where kolom = 'nama'
	go
exec KlienInsert 'tine', 'kembar', '19990520', 'Jawa Barat', 'ayah', 'tine@gmail.com'