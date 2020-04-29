--select * from klien
--select * from hubungan
--select * from region
--select * from noHpklien
--select * from perubahan
--select * from history

/*
	untuk menghapus seorang klien butuh lebih dari sebuah nama,
	untuk menghindari kemungkinan nama orang yang sama maka setidaknya butuh 
	sesuatu yang unik, misal idK atau idKK klien tersebut.
*/
ALTER PROCEDURE KlienDelete(
	@nama VARCHAR(50), 
	@idK int
)
AS
	DECLARE 
		@statusBefore INT,
		@alamatBefore varchar(50),
		@tglLahirBefore date,
		@fkRegionBefore int,
		@emailBefore varchar(50),
		@idKK INT,
		@idRecordHub INT,
		@curDateTime DATETIME,
		@idRecord INT,
		@idPerubahan INT,
		@idPerubahanHub INT,
		@posisi varchar(20),
		@cek INT

	SET @curDateTime = GETDATE()
	
	select
		@cek = idK
	from
		klien
	where 
		nama = @nama and idK = @idK 
	
	if(@cek is not null)
		BEGIN
			Set @idKK = (
				SELECT	
					fkHubungan
				from
					klien
				where
					idK = @idK and nama = @nama
			)

			SET @idRecordHub = (
				SELECT
					idH
				FROM
					hubungan
				WHERE
					hubungan.idKK = @idKK and idUser = @idK
			)
			
			set @posisi = (
				select 
					posisi
				from 
					hubungan
				where
					hubungan.idKK = @idKK and idUser = @idK
			)

			-- memasukkan track data yang akan di hapus ke dalam tabel perubahan
			INSERT INTO perubahan (waktu, tabel, idRecord, operasi)
			VALUES (@curDateTime, 'klien', @idK, 'DELETE')
			
			-- memasukkan track data hubungan dari klien yang akan di hapus
			INSERT INTO perubahan (waktu, tabel, idRecord, operasi)
			VALUES (@curDateTime, 'hubungan', @idRecordHub, 'DELETE')
			
			SET @idPerubahan = (
				SELECT
					idPe
				FROM
					Perubahan
				WHERE
					waktu= @curDateTime AND tabel = 'klien'
			)
			
			SET @idPerubahanHub = (
				SELECT
					idPe
				FROM
					perubahan
				WHERE
					idRecord = @idRecordHub AND tabel = 'hubungan'
			)

			select
				@emailBefore = email, 
				@tglLahirBefore = tglLahir, 
				@fkRegionBefore = fkRegion, 
				@alamatBefore = alamat
			from
				klien
			where
				idK = @idK and nama = @nama

			set @statusBefore = (
				select
					klien.status
				from 
					klien
				where
					idK = @idK and nama = @nama
			)
			
			INSERT INTO history (fkPerubahan, kolom, tipeData, nilaiSebelum)
			VALUES (@idPerubahan, 'nama', 'varchar(50)', @nama)
			
			INSERT INTO history (fkPerubahan, kolom, tipeData, nilaiSebelum)
			VALUES (@idPerubahan, 'alamat', 'varchar(50)', @alamatBefore)

			INSERT INTO history (fkPerubahan, kolom, tipeData, nilaiSebelum)
			VALUES (@idPerubahan, 'tglLahir', 'date', @tglLahirBefore)

			INSERT INTO history (fkPerubahan, kolom, tipeData, nilaiSebelum)
			VALUES (@idPerubahan, 'fkRegion', 'int', @fkRegionBefore)

			INSERT INTO history (fkPerubahan, kolom, tipeData, nilaiSebelum)
			VALUES (@idPerubahan, 'fkHubungan', 'int', @idKK)

			INSERT INTO history (fkPerubahan, kolom, tipeData, nilaiSebelum)
			VALUES (@idPerubahan, 'status', 'int', @statusBefore)

			INSERT INTO history (fkPerubahan, kolom, tipeData, nilaiSebelum)
			VALUES (@idPerubahan, 'email', 'varchar(50)', @emailBefore)

			INSERT INTO history (fkPerubahan, kolom, tipeData, nilaiSebelum)
			VALUES (@idPerubahanHub, 'idUser', 'int', @idK)
			
			INSERT INTO history (fkPerubahan, kolom, tipeData, nilaiSebelum)
			VALUES (@idPerubahanHub, 'idKK', 'int', @idKK)

			INSERT INTO history (fkPerubahan, kolom, tipeData, nilaiSebelum)
			VALUES (@idPerubahanHub, 'posisi', 'varchar(20)', @posisi)

			DELETE FROM klien
			WHERE nama = @nama and idK = @idK
			
			DELETE FROM hubungan
			WHERE idUser = @idK and idKK = @idKK
		END

	
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
	exec KlienDelete 'tine', 14
