/*
	Stored Procedure untuk mengupdate data customer service
	SP ini dapat menambah atau menghapus list customer service
	param: @nama: nama customer service yang ingin ditambah atau dihapus
	param: @operasi: tambah atau hapus
*/
ALTER PROCEDURE updateCustomerService
	@nama varchar(50),
	@operasi varchar(20)
AS
	DECLARE 
		@op varchar(20),
		@curDate datetime,
		@idRecord int,
		@idPerubahan int,
		@idC int
	SET @op = UPPER(@operasi)
	SET @curDate = GETDATE()
	IF @op = 'TAMBAH'
	BEGIN
		SET @idC = (
			SELECT
				idC
			FROM
				CusService
			WHERE
				nama = @nama
		)

		IF @idC is NULL
		BEGIN
			INSERT INTO cusService(nama)
			VALUES(@nama)

			SET @idRecord = (
				SELECT
					idC
				FROM
					CusService
				WHERE
					nama = @nama
			)

			INSERT INTO Perubahan(waktu, tabel, idRecord, operasi)
			VALUES(@curDate, 'CusService', @idRecord, 'INSERT')

			SET @idPerubahan = (
				SELECT
					idPe
				FROM
					Perubahan
				WHERE
					idRecord = @idRecord AND
					tabel = 'CusService' AND
					operasi = 'INSERT'
			)

			INSERT INTO History(fkPerubahan, kolom, tipeData, nilaiSebelum)
			VALUES(@idPerubahan,'nama','varchar(50)','')
		END
	END
	ELSE IF @op = 'HAPUS'
	BEGIN
		SET @idC = (
			SELECT
				idC
			FROM
				CusService
			WHERE
				nama = @nama
		)

		IF @idC IS NOT NULL
		BEGIN
			SET @idRecord = (
				SELECT
					idC
				FROM
					CusService
				WHERE
					nama = @nama
			)

			INSERT INTO Perubahan(waktu, tabel, idRecord, operasi)
			VALUES(@curDate, 'CusService', @idRecord, 'DELETE')

			SET @idPerubahan = (
				SELECT
					idPe
				FROM
					Perubahan
				WHERE
					idRecord = @idRecord AND
					tabel = 'CusService' AND
					operasi = 'DELETE'
			)

			INSERT INTO History(fkPerubahan, kolom, tipeData, nilaiSebelum)
			VALUES(@idPerubahan,'nama','varchar(50)',@nama)

			DELETE FROM cusService
			WHERE nama = @nama
		END
	END

	SELECT
		idC AS 'Id CS',
		nama AS 'Nama CS'
	FROM
		CusService

	SELECT
		idPe AS 'id Perubahan',
		waktu,
		tabel,
		idRecord AS 'id CS',
		operasi,
		kolom,
		nilaiSebelum AS 'Data CS Sebelum'
	FROM
		History INNER JOIN Perubahan ON
		History.fkPerubahan = Perubahan.idPe
	WHERE
		tabel = 'CusService' AND
		idRecord = @idRecord
GO
--param pertama: nama
--param kedua: hapus atau tambah
EXEC updateCustomerService 'Denise','hapus'

/*
	STORED PROCEDURE undo perubahan CS Terakhir
	Hanya bisa UNDO Perubahan terakhir
	Apabila tidak terakhir maka hanya mengembalikan tabel akhir saja
	dan tidak ada perubahan
*/
ALTER PROCEDURE undoPerubahanCSTerakhir
AS
	DECLARE
		@idPerubahanCSTerakhir int,
		@nilaiSebelum varchar(50),
		@idRecord int,
		@lastNilai varchar(50),
		@idxTerakhir int,
		@temp int,
		@operasiTerakhir varchar(50)

	SET @idPerubahanCSTerakhir = (
		SELECT
			MAX(idPe)
		FROM
			Perubahan
		WHERE
			tabel = 'CusService'
	)

	SET @idRecord = (
		SELECT
			idRecord
		FROM
			Perubahan
		WHERE
			idPe = @idPerubahanCSTerakhir
	)

	SET @nilaiSebelum = (
		SELECT
			nilaiSebelum
		FROM
			History
		WHERE
			fkPerubahan = @idPerubahanCSTerakhir
	)

	SET @operasiTerakhir = (
		SELECT
			operasi
		FROM
			Perubahan
		WHERE
			idPe = @idPerubahanCSTerakhir
	)

	IF @operasiTerakhir != 'UNDO'
	BEGIN
		IF @nilaiSebelum = ''
		BEGIN
			SET @lastNilai = (
				SELECT
					nama
				FROM
					CusService
				WHERE
					idC = @idRecord
			)

			DELETE FROM CusService
			WHERE idC = @idRecord

			SET @idRecord = @idRecord - 1
			DBCC checkident(CusService,reseed,@idRecord)

			UPDATE History
			SET
				nilaiSebelum = @lastNilai
			WHERE
				idH = @idPerubahanCSTerakhir

			UPDATE Perubahan
			SET
				operasi = 'UNDO'
			WHERE
				idPe = @idPerubahanCSTerakhir
		END
		ELSE
		BEGIN
			SET @temp = @idRecord - 1
			DBCC checkident(CusService,reseed,@temp)

			INSERT INTO CusService
			SELECT @nilaiSebelum

			UPDATE History
			SET
				nilaiSebelum = ''
			WHERE
				fkPerubahan = @idPerubahanCSTerakhir

			UPDATE Perubahan
			SET
				operasi = 'UNDO'
			WHERE
				idPe = @idPerubahanCSTerakhir

			SET @idxTerakhir = (
				SELECT
					MAX(idC)
				FROM
					CusService
			)
			DBCC checkident(CusService,reseed,@idxTerakhir)
		END
	END

	SELECT
		idC AS 'Id CS',
		nama AS 'Nama CS'
	FROM
		CusService

	SELECT
		idPe AS 'id Perubahan',
		waktu,
		tabel,
		idRecord AS 'id CS',
		operasi
	FROM
		Perubahan
	WHERE 
		tabel = 'CusService'

	SELECT
		fkPerubahan AS 'id Perubahan',
		kolom,
		nilaiSebelum AS 'Data CS Sebelum'
	FROM history where kolom = 'nama'
GO
--tidak memiliki param
EXEC undoPerubahanCSTerakhir