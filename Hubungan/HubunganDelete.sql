ALTER procedure hubunganDelete(
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