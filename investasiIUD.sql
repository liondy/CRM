ALTER PROCEDURE investasiDelete(
	@namaKlien varchar(50)
)
AS
	declare @idKlien int
	select
		@idKlien=idK
	from
		klien
	where
		klien.nama = @namaKlien

	declare @curDateTime datetime
	select
		@curDateTime = GETDATE()

	declare @idInv int
	select
		@idInv = investasi.idIvest
	from
		investasi
	where
		investasi.fkIdKlien = @idKlien

	declare @idPerubahan int
	declare @nom money

BEGIN
	INSERT INTO perubahan(
		waktu, fkInvest, Operasi
	)
	VALUES(
		@curDateTime, @idInv, 'Delete'
	)

	select 
		@idPerubahan = perubahan.idPe
	from
		perubahan
	where
		perubahan.fkinvest = @idInv

	select
		@nom = investasi.nominal
	from
		investasi
	where
		investasi.fkIdKlien = @idKlien


	INSERT INTO history(
		fkPerubahan, kolom, tipeData, nilaiSebelum
	)
	VALUES(
		@idPerubahan, 'idIvest', 'int', @idInv
	)

	INSERT INTO history(
		fkPerubahan, kolom, tipeData, nilaiSebelum 
	)
	VALUES(
		@idPerubahan, 'fkIdKlien', 'int', @idKlien
	)

	INSERT INTO history(
		fkPerubahan, kolom, tipeData, nilaiSebelum 
	)
	VALUES(
		@idPerubahan, 'nominal' , 'money', @nom
	)

	INSERT INTO history(
		fkPerubahan, kolom, tipeData, nilaiSebelum 
	)
	VALUES(
		@idPerubahan, 'waktu', 'datetime', @curDateTime
	)
	
	DELETE FROM investasi
	WHERE investasi.fkIdKlien = @idKlien
END

ALTER PROCEDURE investasiUpdate(
	@namaklien varchar(50),
	@nominal money
)
AS
	declare @curDate datetime
	select 
		@curDate = GETDATE()
	
	declare @idKlien int
	select
		@idKlien=idK
	from
		klien
	where
		klien.nama = @namaklien

	declare @idInv int
	declare @idPerubahan int
	declare @nomBefore money

BEGIN
	select
		@nomBefore
	from
		investasi
	where
		investasi.fkIdKlien = @idKlien

	INSERT INTO investasi(
		fkIdKlien, nominal, waktu
	)
	VALUES(
		@idKlien, @nominal, @curDate
	)

	select
		@idInv = investasi.idIvest
	from
		investasi
	where
		investasi.waktu = @curDate

	INSERT INTO perubahan(
		waktu, fkInvest, operasi
	)
	VALUES(
		@curDate, @idInv, 'Update'
	)

	select 
		@idPerubahan = perubahan.idPe
	from
		perubahan
	where
		perubahan.waktu = @curDate

	INSERT INTO history(
		fkPerubahan,kolom, tipeData, nilaiSebelum
	)
	VALUES(
		@idPerubahan, 'nominal', 'money', @nomBefore
	)
END

ALTER PROCEDURE investasiInsert(
	@namaKlien varchar(50),
	@nominal money
)
AS
	declare @idKlien int
	select
		@idKlien=idK
	from
		klien
	where
		klien.nama = @namaKlien

	declare @curDateTime datetime
	select
		@curDateTime = GETDATE()

	declare @idInvest int
		
	BEGIN	
		INSERT INTO investasi(
			fkIdKlien, nominal, waktu
		)
		VALUES (
			@idKlien, @nominal, @curDateTime
		)

		select 
			@idInvest = investasi.idIvest
		from 
			investasi
		where
			investasi.waktu = @curDateTime

		INSERT INTO Perubahan(
			waktu, fkInvest, Operasi
		)
		VALUES(
			@curDateTime, @idInvest, 'Insert'
		)
	END