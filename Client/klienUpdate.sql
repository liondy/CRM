--alamat; fkRegion; fkHubungan; status; email
ALTER PROCEDURE KlienUpdate
	@idK int,
	@perubahan varchar(400),
	@investasi MONEY,
	@idCs INT
AS
	DECLARE
		@idKlien int

	SET @idKlien = (
		SELECT
			idK
		FROM
			Klien
		WHERE
			idK = @idK
	)

	IF @idKlien IS NOT NULL
	BEGIN
		DECLARE
			@panjangKata int,
			@it int,
			@i int,
			@commaidx int,
			@trimKata varchar(50),
			@query nvarchar(400),
			@waktu datetime,
			@idPerubahan int,
			@nilaiSebelum varchar(50),
			@fkRegion int,
			@fkHubungan int
		SET @panjangKata = LEN(@perubahan)
		SET @it = 1
		SET @commaidx = 1
		SET @query = 'UPDATE Klien SET '
		SET @waktu = GETDATE()
		SET @i = 1

		INSERT INTO Perubahan (waktu,tabel,idRecord,operasi)
		SELECT
			@waktu, 'Klien', @idK, 'UPDATE'

		SET @idPerubahan = (
			SELECT
				idPe
			FROM
				Perubahan
			WHERE
				tabel = 'Klien' AND 
				idRecord = @idK AND 
				operasi = 'UPDATE' AND
				waktu = @waktu
		)

		WHILE @it <= @panjangKata
		BEGIN
			SET @commaidx = CHARINDEX(';',@perubahan,@it)
			IF @commaidx = 0
			BEGIN
				SET @trimKata = SUBSTRING(@perubahan,@it,@panjangKata-@it+1)
				SET @it = @panjangKata + 1
			END
			ELSE
			BEGIN
				SET @trimKata = SUBSTRING(@perubahan,@it,@commaidx-@it)
				SET @it = @commaidx + 1
			END
			IF @i = 1 AND @trimKata != ''
			BEGIN
				SET @query = CONCAT(@query,'alamat = ''',@trimKata,''', ')
				SET @nilaiSebelum = (
					SELECT
						alamat
					FROM
						Klien
					WHERE
						idK = @idK
				)
				INSERT INTO History (fkPerubahan,kolom,tipeData,nilaiSebelum)
				SELECT
					@idPerubahan,'alamat','varchar(50)',@nilaiSebelum
			END
			ELSE IF @i = 2 AND @trimKata != ''
			BEGIN
				SET @fkRegion = (
					SELECT
						idR
					FROM
						Region
					WHERE
						namaKelompok = @trimKata
				)

				IF @fkRegion IS NULL
				BEGIN
					EXEC insertReg @trimKata,0
				END
				SET @query = CONCAT(@query,'fkRegion = ''',@fkRegion,''', ')
				SET @nilaiSebelum = (
					SELECT
						fkRegion
					FROM
						Klien
					WHERE
						idK = @idK
				)
				INSERT INTO History (fkPerubahan,kolom,tipeData,nilaiSebelum)
				SELECT
					@idPerubahan,'fkRegion','varchar(50)',@nilaiSebelum
			END
			ELSE IF @i = 3 AND @trimKata != ''
			BEGIN
				EXEC hubunganDelete @idK
				SET @fkHubungan = (
					SELECT
						MAX(idKK) + 1
					FROM
						Hubungan
				)
				INSERT INTO Hubungan (idKK,idUser,posisi)
				SELECT
					@fkHubungan,
					@idKlien,
					@trimKata
				SET @query = CONCAT(@query,'fkHubungan = ''',@fkHubungan,''', ')
				SET @nilaiSebelum = (
					SELECT
						fkHubungan
					FROM
						Klien
					WHERE
						idK = @idK
				)
				INSERT INTO History (fkPerubahan,kolom,tipeData,nilaiSebelum)
				SELECT
					@idPerubahan,'fkHubungan','varchar(50)',@nilaiSebelum
			END
			ELSE IF @i = 4 AND @trimKata != ''
			BEGIN
				SET @query = CONCAT(@query,'status = ''',@trimKata,''', ')
				SET @nilaiSebelum = (
					SELECT
						status
					FROM
						Klien
					WHERE
						idK = @idK
				)
				INSERT INTO History (fkPerubahan,kolom,tipeData,nilaiSebelum)
				SELECT
					@idPerubahan,'status','int',@nilaiSebelum
			END
			ELSE IF @i = 5 AND @trimKata != ''
			BEGIN
				SET @query = CONCAT(@query,'email = ''',@trimKata,''', ')
				SET @nilaiSebelum = (
					SELECT
						email
					FROM
						Klien
					WHERE
						idK = @idK
				)
				INSERT INTO History (fkPerubahan,kolom,tipeData,nilaiSebelum)
				SELECT
					@idPerubahan,'email','varchar(50)',@nilaiSebelum
			END
			SET @i = @i + 1
		END
		SET @query = substring(@query, 1, (LEN(@query)-1))
		SET @query = CONCAT(@query,' WHERE idK = ',@idK)
		--SELECT @query
		EXEC sp_executesql @query
		DECLARE
			@nama VARCHAR(50),
			@alamat VARCHAR(50),
			@tglLahir DATETIME,
			@namaRegion VARCHAR(50)
		
		SELECT
			@nama = nama,
			@alamat = alamat,
			@tglLahir = tglLahir,
			@namaRegion = Region.namaKelompok
		FROM
			Klien INNER JOIN Region ON
			Klien.fkRegion = Region.idR
		WHERE
			idK = @idK

		EXEC investasiUpdate @nama,@alamat,@tglLahir,@namaRegion,@investasi,@idCs
	END
	SELECT
		*
	FROM
		klien
	WHERE
		idK = @idK

	SELECT
		*
	FROM
		Hubungan
	WHERE
		idUser = @idK
GO