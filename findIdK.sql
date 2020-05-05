alter procedure findIdK(
	@namaKlien varchar(50),
	@alamat varchar(100),
	@tglLahir date,
	@email varchar(50)
)
as 
	declare @idK int
BEGIN
	select 
		idK
	from
		klien
	where
		klien.nama = @namaKlien and
		klien.alamat = @alamat and
		klien.tglLahir = @tglLahir and
		klien.email = @email

	if(@idK is not null)
		BEGIN
			select @idK as 'idKlien'
		END
END

exec findIdK 'bebek','kembar', '1999-05-20', 'tine@gmail.com'

