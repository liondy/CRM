Alter procedure hubunganInsert(
	@idUser int,
	@posisi varchar(20)
)
as
	declare @tempIdKK int
	select
		@tempIdKK = klien.fkHubungan
	from
		klien
	where
		klien.idK = @idUser

	declare @curDate datetime
	select
		@curDate = GETDATE()

	declare @idHubungan int
	declare @idPerubahan int

BEGIN
	INSERT INTO hubungan(
		idKK, idUser, posisi
	)
	VALUES(
		@tempIdKK, @idUser, @posisi
	)

	select
		@idHubungan = hubungan.idH
	from	
		hubungan
	where
		hubungan.idKK = @tempIdKK AND hubungan.idUser = @idUser

	INSERT INTO perubahan(
		waktu, tabel, idRecord, operasi
	)
	VALUES(
		@curDate, 'hubungan', @idHubungan, 'INSERT'
	)

	SELECT 
		@idPerubahan = perubahan.idPe
	from
		perubahan
	where
		perubahan.waktu = @curDate AND perubahan.idRecord = @idHubungan

	INSERT INTO history(
		fkPerubahan, kolom, tipeData, nilaiSebelum
	)
	VALUES(
		@idPerubahan, 'idKK', 'int', '0'
	)

	INSERT INTO history(
		fkPerubahan, kolom, tipeData, nilaiSebelum
	)
	VALUES(
		@idPerubahan, 'idUser', 'int', '0'
	)

	INSERT INTO history(
		fkPerubahan, kolom, tipeData, nilaiSebelum
	)
	VALUES(
		@idPerubahan, 'posisi', 'varchar', ' '
	)
END


Create procedure hubunganDelete(
	@idUser int
)
as 
	declare @curDate datetime
	select
		@curDate = GETDATE()

	declare @idKK int
	select
		@idKK = klien.fkHubungan
	from
		klien
	where	
		klien.idK = @idUser

	declare @tempPosisi varchar(20)
	declare @idHubungan int
	select
		@tempPosisi = hubungan.posisi, @idHubungan = hubungan.idH
	from
		hubungan
	where
		hubungan.idUser = @idUser

	declare @idPerubahan int

BEGIN
	INSERT INTO perubahan(
		waktu, tabel, idRecord, operasi
	)
	VALUES(
		@curDate, 'hubungan', @idHubungan, 'DELETE'
	)

	select
		@idPerubahan = perubahan.idPe
	from
		perubahan
	where
		perubahan.waktu = @curDate and perubahan.idRecord = @idHubungan

	INSERT INTO history(
		fkPerubahan, kolom, tipeData, nilaiSebelum
	)
	VALUES(
		@idPerubahan, 'idKK' ,'int', @idKK
	)

	INSERT INTO history(
		fkPerubahan, kolom, tipeData, nilaiSebelum
	)
	VALUES(
		@idPerubahan, 'idUser', 'int', @idUser
	)

	INSERT INTO history(
		fkPerubahan, kolom, tipeData, nilaiSebelum
	)
	VALUES(
		@idPerubahan, 'posisi', 'varchar', @tempPosisi
	)

	DELETE FROM hubungan
	WHERE hubungan.idUser = @idUser
END
