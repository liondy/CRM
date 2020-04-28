--select * from klien
--select * from noHpklien
--select * from telepon
--select * from region
--select * from hubungan
CREATE PROCEDURE KlienInsert(
@nama varchar(50),
@alamat varchar(50),
@tgllahir datetime,
@namaRegion varchar(50),
@hubungan int,
@status int,
@email varchar(50)
)
AS
	declare @reg int
	select
		idR=@reg
	from
		region
	where
		namaKelompok = @namaRegion


	INSERT INTO klien
	SELECT(
		nama, alamat, tglLahir, fkRegion, fkHubungan, status, email
	)
	VALUES (
		@nama, @alamat, @tgllahir, @reg, @hub, @status, @email
	)