alter procedure findBirthday
as
	declare @tableBirthday table(
		nama varchar(50),
		alamat varchar(50),
		email varchar(50)
	)

	declare
		@curDate date

	set @curDate = CONVERT(DATE, GETDATE())
BEGIN
	insert into @tableBirthday
	select
		nama,alamat,email
	from
		klien
	where
		DATEPART(dd, tglLahir) = DATEPART(dd,@curDate) and
		DATEPART(mm, klien.tglLahir) = DATEPART(mm, @curDate)
END

	select * 
	from @tableBirthday

exec findBirthday





