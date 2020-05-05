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
	DECLARE @idRegion int --untuk mendapatkan idReg dari param @namaRegion dan @parLama
	DECLARE @idReg int
	SET @idRegion = (
		SELECT
			idR
		FROM
			Region
		WHERE
			namaKelompok = @namaRegion and idParent = @idParLama
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
				region.namaKelompok = @namaRegion AND region.idParent = @idParLama

			update region
				set idParent = @idParBaru
				where 
				namaKelompok = @namaRegion AND 
				idParent = @idParLama AND
				idR = @idRegion

			/* kalo cuman update sepertinya idR nya ga akan berubah
			SET @idReg = (
				SELECT
					idR
				FROM
					Region
				WHERE
					namaKelompok = @namaRegion AND
					idParent = @idParBaru
			)
			*/

			INSERT INTO perubahan(
				waktu, idRecord, operasi, tabel 
			)
			VALUES(
				@curDate, @idRegion, 'UPDATE', 'Region'
			)

			--mendapat idPerubahan yang paling baru yang barusan di insert
			select 
				@idPerubahan = perubahan.idPe
			from
				perubahan
			where
				perubahan.waktu = @curDate AND perubahan.idRecord = @idRegion

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
		R.idR = @idRegion

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
		idRecord = @idRegion

EXEC updateReg 'Bogor', 2, 4

select *
from region 

select * 
from perubahan

select * 
from history

------------------------------------------------------------------------------------------------------------------------------

alter procedure undoPerubahanRegion(
	@idR int
)
as
	DECLARE
		@idPerubahanParentB int, --idPerubahan before
		@nilaiSebelum varchar(50), --parent before
		@idRecord int, --baris record pada region before
		@lastNilai varchar(50), --parent sekarang
		@idxTerakhir int,
		@temp int,
		@operasiTerakhir varchar(50) --operasi pada perubahan before

	SET @idPerubahanParentB = (
		SELECT
			MAX(idPe)
		FROM
			Perubahan
		WHERE
			tabel = 'region' and operasi != 'UNDO'
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
			fkPerubahan = @idPerubahanParentB and kolom = 'idParent'
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
					idR = @idRecord
			)

			DELETE FROM region
			WHERE idR = @idRecord
		
			/*
			update region set
			idParent = -1
			where
			idR = @idR
			*/

			SET @idRecord = @idRecord - 1
			DBCC checkident(region,reseed,@idRecord)

			UPDATE History
			SET
				nilaiSebelum = @lastNilai
			WHERE
				idH = @idPerubahanParentB and kolom = 'idParent'

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

			/* kalo dia pernah di update sebelumnya
				berarti dia bukan insert tapi update
				dengan mengubah idParent sekarang menjadi
				idParent yang di history
			INSERT INTO region (idParent)
			values (@idPerubahanParentB)
			SELECT @nilaiSebelum
			*/

			Update region set
			idParent = @nilaiSebelum
			where
			idR = @idR 

			UPDATE History
			SET
				nilaiSebelum = ''
			WHERE
				fkPerubahan = @idPerubahanParentB and kolom = 'idParent'

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
			if @idxTerakhir is NULL
			BEGIN
				set @idxTerakhir = 0
			END
			DBCC checkident(region,reseed,@idxTerakhir)
		END
	END
GO

select * 
from region

exec insertReg cikarang,4
exec updateReg cikarang,4,5



