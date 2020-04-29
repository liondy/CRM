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

	SET @idP = (
		SELECT
			idR
		FROM
			Region
		WHERE
			idR = @idPar
	)

	SET @idPP = (
		SELECT
			idParent
		FROM
			Region
		WHERE
			namaKelompok = @namaRegion AND
			idParent = @idPar
	)

	IF (@idPP IS NULL OR @idPP != @idPar) AND @idP IS NOT NULL OR @idPar = 0
	BEGIN
		INSERT INTO region(
			namaKelompok, idParent
		)
		VALUES (
			@namaRegion, @idPar
		)

		select 
			@idReg = region.idR
		from 
			region
		where
			region.namaKelompok = @namaRegion

		INSERT INTO Perubahan(
			waktu, idRecord, Operasi, tabel
		)
		VALUES(
			@curDateTime, @idReg, 'INSERT', 'Region'
		)
		
		select
			@idPerubahan = perubahan.idPe
		from
			perubahan
		where 
			perubahan.waktu = @curDateTime and perubahan.idRecord = @idReg

		INSERT INTO history(
			fkPerubahan, kolom, tipeData, nilaiSebelum
		)
		VALUES(
			@idPerubahan, 'namaKelompok', 'int', '0'
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
				namaKelompok
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

	SET @idReg = (
		SELECT
			MAX(idR)
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
		idRecord = @idReg

EXEC insertReg 'Sulawesi Selatan', 0

-------------------------------------------------------------------------
alter procedure updateReg(
	@namaRegion varchar(50),
	@idParLama int,
	@idParBaru int
)
as
	DECLARE @idRegion int
	DECLARE @idReg int
	SET @idRegion = (
		SELECT TOP 1
			idR
		FROM
			Region
		WHERE
			namaKelompok = @namaRegion
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
				region.namaKelompok = @namaRegion1 AND region.idParent = @idParLama
			update region
				set idParent = @idParBaru
				where namaKelompok = @namaRegion AND idParent = @idParLama

			SET @idReg = (
				SELECT
					idR
				FROM
					Region
				WHERE
					namaKelompok = @namaRegion AND
					idParent = @idParBaru
			)

			INSERT INTO perubahan(
				waktu, idRecord, operasi, tabel 
			)
			VALUES(
				@curDate, @idReg, 'UPDATE', 'Region'
			)

			--mendapat idPerubahan yang paling baru yang barusan di insert
			select 
				@idPerubahan = perubahan.idPe
			from
				perubahan
			where
				perubahan.waktu = @curDate AND perubahan.idRecord = @idR

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
		R.idR = @idReg

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
		idRecord = @idReg

EXEC updateReg 'Bogor', 2, 4

select *
from region 

select * 
from perubahan

select * 
from history

------------------------------------------------------------------------------------------------------------------------------

alter procedure undoRegion
as
	DECLARE
		@idPerubahanParentB int,
		@nilaiSebelum varchar(50),
		@idRecord int,
		@lastNilai varchar(50),
		@idxTerakhir int,
		@temp int,
		@operasiTerakhir varchar(50)

	SET @idPerubahanParentB = (
		SELECT
			MAX(idPe)
		FROM
			Perubahan
		WHERE
			tabel = 'region'
	)

	SET @idRecord = (
		SELECT
			idRecord
		FROM
			Perubahan
		WHERE
			idPe = @idPerubahanParentB
	)

	SET @nilaiSebelum = (
		SELECT
			nilaiSebelum
		FROM
			History
		WHERE
			fkPerubahan = @idPerubahanParentB
	)

	SET @operasiTerakhir = (
		SELECT
			operasi
		FROM
			Perubahan
		WHERE
			idPe = @idPerubahanParentB
	)

	IF @operasiTerakhir != 'UNDO'
	BEGIN
		IF @nilaiSebelum = ''
		BEGIN
			SET @lastNilai = (
				SELECT
					idParent
				FROM
					region
				WHERE
					idParent = @idRecord
			)

			DELETE FROM region
			WHERE idParent = @idRecord

			SET @idRecord = @idRecord - 1
			DBCC checkident(region,reseed,@idRecord)

			UPDATE History
			SET
				nilaiSebelum = @lastNilai
			WHERE
				idH = @idPerubahanParentB

			UPDATE Perubahan
			SET
				operasi = 'UNDO'
			WHERE
				idPe = @idPerubahanParentB
		END
		ELSE
		BEGIN
			SET @temp = @idRecord - 1
			DBCC checkident(region,reseed,@temp)

			INSERT INTO region (idParent)
			values (@idPerubahanParentB)
			SELECT @nilaiSebelum

			UPDATE History
			SET
				nilaiSebelum = ''
			WHERE
				fkPerubahan = @idPerubahanParentB

			UPDATE Perubahan
			SET
				operasi = 'UNDO'
			WHERE
				idPe = @idPerubahanParentB

			SET @idxTerakhir = (
				SELECT
					MAX(idR)
				FROM
					region
			)
			DBCC checkident(region,reseed,@idxTerakhir)
		END
	END

	SELECT
		idParent AS 'Id Parent',
		namaKelompok AS 'Nama Region'
	FROM
		region

	SELECT
		idPe AS 'id Perubahan',
		waktu,
		tabel,
		idRecord AS 'id Parent',
		operasi
	FROM
		Perubahan
	WHERE 
		tabel = 'region'

	SELECT
		fkPerubahan AS 'id Perubahan',
		kolom,
		nilaiSebelum AS 'Data id Parent Sebelum'
	FROM history where kolom = 'nama'
GO

exec undoRegion

--undo belum beres karena operasi undo masuk ke table perubahan tapi di table regionya sendiri nilai idParentnya(yang harusnya berubah) tidak ke ubah 
ALTER PROCEDURE checkIdKota
	@namaRegion varchar(50)
AS
	SELECT
		MIN(idR)
	FROM
		Region
	WHERE
		namaKelompok = @namaRegion