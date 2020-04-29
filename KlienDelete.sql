ALTER PROCEDURE KlienDelete(
@nama VARCHAR(50)
)
AS
	DECLARE 
		@idklien INT,
		@curDateTime DATETIME,
		@idRecord INT,
		@idPerubahan INT
	SET @curDateTime = GETDATE()

	SELECT
		idK = @idklien
	FROM
		klien
	WHERE
		nama = @nama

	SET @idRecord = (
		SELECT
			idK
		FROM
			klien
		WHERE
			nama = @nama
	)
	
	INSERT INTO perubahan (waktu, tabel, idRecord, operasi)
	VALUES (@curDateTime, 'klien', @idRecord, 'DELETE')

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
	VALUES (@idPerubahan, 'nama', 'varchar(50)',@nama)

	DELETE FROM klien
	WHERE nama = @nama


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
	exec KlienDelete 'sapi'