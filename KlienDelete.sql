--select * from klien
--select * from hubungan
--select * from region
--select * from noHpklien
--select * from perubahan
--select * from history
ALTER PROCEDURE KlienDelete(
@nama VARCHAR(50)
)
AS
	DECLARE 
		@idklien INT,
		@idRecordHub INT,
		@curDateTime DATETIME,
		@idRecord INT,
		@idPerubahan INT,
		@idPerubahanHub INT
	SET @curDateTime = GETDATE()

	SET @idRecord = (
		SELECT
			idK
		FROM
			klien
		WHERE
			nama = @nama
	)
	/*
	SET @idRecordHub = (
		SELECT
			hubungan.idKK
		FROM
			hubungan join klien on
			hubungan.idKK = klien.fkHubungan
		WHERE
			klien.nama = @nama
	)
	*/
	
	INSERT INTO perubahan (waktu, tabel, idRecord, operasi)
	VALUES (@curDateTime, 'klien', @idRecord, '3')
	/*
	INSERT INTO perubahan (waktu, tabel, idRecord, operasi)
	VALUES (@curDateTime, 'hubungan', @idRecordHub, '3')
	*/
	SET @idPerubahan = (
		SELECT
			idPe
		FROM
			Perubahan
		WHERE
			idRecord = @idRecord AND tabel = 'klien'
	)
	/*
	SET @idPerubahanHub = (
		SELECT
			idPe
		FROM
			perubahan
		WHERE
			idRecord = @idRecordHub AND tabel = 'hubungan'
	)
	*/
	INSERT INTO history (fkPerubahan, kolom, tipeData, nilaiSebelum)
	VALUES (@idPerubahan, 'nama', 'varchar(50)', @nama)
	/*
	INSERT INTO history (fkPerubahan, kolom, tipeData, nilaiSebelum)
	VALUES (@idPerubahanHub, 'idUser', 'int', @idRecord)
	*/
	DELETE FROM klien
	WHERE nama = @nama
	/*
	DELETE FROM hubungan
	WHERE idUser = @idRecordHub
	*/
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
	exec KlienDelete 'tine'