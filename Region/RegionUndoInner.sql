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

exec insertReg cikarang,4
exec updateReg cikarang,4,5