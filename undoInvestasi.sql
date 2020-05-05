ALTER procedure undoInvestasi(
	@namaKlien varchar(50),
	@alamat varchar(100),
	@tglLahir date,
	@email varchar(50)
)
as 
	declare @idK int, @idInvest int
	BEGIN
		SET @idK = (
			select 
				idK
			from
				klien
			where
				klien.nama = @namaKlien and
				klien.alamat = @alamat and
				klien.tglLahir = @tglLahir and
				klien.email = @email
		)

		if(@idK is not null)
		BEGIN
			EXEC undoPerubahanInvestasi @namaKlien,@idK

			SELECT
				idIvest AS 'ID Investasi',
				Klien.nama AS 'Nama Klien',
				nominal AS 'Besar Investasi',
				waktu
			FROM
				Investasi INNER JOIN Klien ON
				Investasi.fkIdKlien = Klien.idK
			WHERE
				fkIdKlien = @idK

			SET @idInvest = (
				SELECT
					idIvest
				FROM
					Investasi
				WHERE
					fkIdKlien = @idK
			)

			SELECT
				waktu,
				idRecord AS 'Id Investasi',
				operasi,
				nilaiSebelum
			FROM
				Perubahan INNER JOIN History ON
				Perubahan.idPe = History.fkPerubahan
			WHERE
				Perubahan.idRecord = @idInvest
		END
	END
