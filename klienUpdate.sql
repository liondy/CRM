--alamat; fkRegion; fkHubungan; status; email
ALTER PROCEDURE KlienUpdate
	@idK int,
	@perubahan varchar(400)
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
			IF @it = 1 AND @trimKata != ''
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
			ELSE IF @it = 2 AND @trimKata != ''
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
			ELSE IF @it = 3 AND @trimKata != ''
			BEGIN
				EXEC hubunganDelete @idK
				SET @fkHubungan = (
					SELECT
						MAX(idKK) + 1
					FROM
						Hubungan
					WHERE
						idUser = @idK
				)
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
			ELSE IF @it = 4 AND @trimKata != ''
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
			ELSE IF @it = 5 AND @trimKata != ''
			BEGIN
				SET @query = CONCAT(@query,'email = ''',@trimKata,''' ')
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
		SET @query = CONCAT(@query,'WHERE idK = ',@idK)
		SELECT @query
		--EXEC sp_executesql @query
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
EXEC KlienUpdate 2,'unpar;;;bebek@gmail.com'