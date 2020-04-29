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

EXEC updateReg 7,4, 5, 'UPDATE'

select *
from region 

select * 
from perubahan

select * 
from history