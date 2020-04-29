--select * from klien
--select * from noHpklien
--select * from telepon
--select * from region
--select * from hubungan
--select * from perubahan

/*
	skenario insert klien : 
		@param : nama
		@param : alamat
		@param : tanggal lahir
		@param : namaRegion 
		@param : hubungan
		@param : email

		- cek jika nama region belum ada di tabel region, 
			1. jika ada ga ada insert 
			2. jika nama region belum terdaftar insert nama region terlebih dahulu

		- cek apakah user sebelumnya pernah kedaftar kedalam tabel dengan mengecek
			1. apakah user dengan nama, tanggal lahir, dan idKK tersebut sudah ada atau tidak
			2. jika ada tidak dapat insert
			3. jika tidak maka insert 

*/

ALTER PROCEDURE KlienInsert(
	@nama varchar(50),
	@alamat varchar(50),
	@tgllahir datetime,
	@namaRegion varchar(50),
	@idKK int,
	@hubungan varchar(50),
	@email varchar(50),
	@nominalInvest money,
	@cusService int
)
AS
	DECLARE 
		@reg INT,
		@iduser INT,
		@tempKK INT,
		@curDateTime DATETIME,
		@idRecord INT,
		@idPerubahan INT,
		@idCS INT
	SET @curDateTime = GETDATE()

	SELECT
		@reg = idR
	FROM
		region
	WHERE
		namaKelompok = @namaRegion

	SET @iduser = (
		SELECT
			idK
		FROM
			klien
		WHERE
			nama = @nama and tglLahir = @tgllahir and fkHubungan = @idKK
	)
	
	SET @idCs = (
		SELECT
			idC
		FROM
			CusService
		WHERE
			idC = @cusService
	)

	IF (@iduser is null and @idCS is not null)
	BEGIN
		if(@reg is null)
			Begin
				exec insertReg @namaRegion, 0
			end

		INSERT INTO klien(nama, alamat, tglLahir, fkRegion, fkHubungan, status, email)
		VALUES (@nama, @alamat, @tgllahir, @reg, @idKK, 1, @email)

		-- untuk mengambil idK yang untuk klien yang baru di insert
		SET @iduser = (
			SELECT
				idK
			FROM
				klien
			WHERE
				nama = @nama and tglLahir = @tgllahir
		)

		-- setelah klien baru di insert langsung masukin ke tabel hubungan
		
		exec hubunganInsert @idUser,@hubungan
		exec InvestasiInsert @idUser,@nominalInvest,@idCS

		INSERT INTO perubahan (waktu, tabel, idRecord, operasi)
		VALUES (@curDateTime, 'klien', @iduser, 'INSERT')

		--dapatin idPe untuk perubahan yang baru di insert
		SET @idPerubahan = (
			SELECT
				idPe
			FROM
				Perubahan
			WHERE
				idRecord = @iduser AND
				tabel = 'klien'
		)

		INSERT INTO history (fkPerubahan, kolom, tipeData, nilaiSebelum)
		VALUES (@idPerubahan, 'nama', 'varchar(50)','')

		INSERT INTO history (fkPerubahan, kolom, tipeData, nilaiSebelum)
		VALUES (@idPerubahan, 'alamat', 'varchar(50)','')

		INSERT INTO history (fkPerubahan, kolom, tipeData, nilaiSebelum)
		VALUES (@idPerubahan, 'tglLahir', 'date','')

		INSERT INTO history (fkPerubahan, kolom, tipeData, nilaiSebelum)
		VALUES (@idPerubahan, 'fkRegion', 'int','')

		INSERT INTO history (fkPerubahan, kolom, tipeData, nilaiSebelum)
		VALUES (@idPerubahan, 'fkHubungan', 'int','')

		INSERT INTO history (fkPerubahan, kolom, tipeData, nilaiSebelum)
		VALUES (@idPerubahan, 'status', 'int','')

		INSERT INTO history (fkPerubahan, kolom, tipeData, nilaiSebelum)
		VALUES (@idPerubahan, 'email', 'varchar(50)','')
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
	FROM history
	go
exec KlienInsert 'bebek', 'kembar', '19990520', 'Jawa Barat', 12345, 'ayah', 'tine@gmail.com', 1000, 1