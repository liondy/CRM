ALTER PROCEDURE insertReg(
	@namaRegion varchar(15),
	@idPar int,
	@StatementType varchar(20) = '' 
)
as
	--untuk mendapatkan idR setelah namaKelompok di input
	declare @idR int

	--untuk mengambil waktu saat ini
	declare @curDateTime datetime
	select
		@curDateTime = GETDATE()

	declare @idReg int
	declare @idPerubahan int
		
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
EXEC insertReg 'Sulawesi Selatan', 4 ,'INSERT'

select *
from region 

select * 
from perubahan

select * 
from history
-------------------------------------------------------------------------
alter procedure updateReg(
	@idR int,
	@idParLama int,
	@idParBaru int,
	@StatementType nvarchar(20) = '' 
)
as

	--untuk mendapatkan waktu server saat ini
	declare @curDate datetime
	select 
		@curDate = GETDATE()

	declare @idPerubahan int --idPerubahan terakhir
	declare @parentBefore int 
BEGIN
	select
		@parentBefore = region.idParent
	from
		region
	where
		region.idR = @idR AND region.idParent = @idParLama
	update region
		set idParent = @idParBaru
		where idR = @idR AND idParent = @idParLama

	INSERT INTO perubahan(
		waktu, idRecord, operasi, tabel 
	)
	VALUES(
		@curDate, @idR, 'UPDATE', 'region'
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

EXEC updateReg 7, 5, 3, 'UPDATE'

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