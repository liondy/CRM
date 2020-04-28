CREATE PROCEDURE KlienDelete(
@nama varchar(50)
)
as
	declare @idklien int
	select
		idK = @idklien
	from
		klien
	where
		nama = @nama


	declare @idhubungan int
	select
		idH = @idhubungan
	from
		hubungan join klien on
		hubungan.idH = klien.fkHubungan

	delete from klien
	where nama = @nama

	delete from noHpklien
	where fkKlien = @idklien

	delete from hubungan
	where idUser = @idklien

	delete from investasi
	where fkIdKlien = @idklien
	