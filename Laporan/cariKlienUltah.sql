/*
	sp ini digunakan untuk menghasilkan klien klien yang ulang tahun
	ada 3 jenis perintah 
	1 - digunakan untuk mencari klien yang ulang tahun pada hari ini 
	2 - digunakan untuk mencari klien yang ulang tahun pada minggu ini 
	3 - digunakan untuk mencari klien yang ulang tahun pada bulan ini
*/
alter procedure findBirthday(
	@perintah int
)
as
	declare @tableBirthday table(
		nama varchar(50),
		alamat varchar(50),
		namaDaerah varchar(50),
		email varchar(50)
	)

	declare @curDate datetime
	declare @curDay int
	declare	@counter int

	set @curDate = CONVERT(DATE, GETDATE())
	set datefirst 1
	set @curDay = datepart(dw,getdate())
	-- 1=senin, 2=selasa, 3=rabu, 4=kamis, 5=jumat, 6=sabtu, 7=minggu 

	set @counter = 7 - @curDay

BEGIN
	if(@perintah = 1)
		begin
			insert into @tableBirthday
			select
				nama,alamat,region.namaKelompok,email
			from
				klien join region on
					klien.fkRegion = region.idR
			where
				DATEPART(dd, tglLahir) = DATEPART(dd,@curDate) and
				DATEPART(mm, klien.tglLahir) = DATEPART(mm, @curDate)
		end
	else if(@perintah = 2)
		begin
			if(@counter!=0)
			begin
				insert into @tableBirthday
				select
					nama,alamat,region.namaKelompok,email
				from
					klien join region on
						klien.fkRegion = region.idR
				where
					DATEPART(mm, klien.tglLahir) = DATEPART(mm, @curDate) and
					(DATEPART(dd, tglLahir) >= DATEPART(dd,@curDate) and
					DATEPART(dd, tglLahir) <= DATEPART(dd,DATEADD(DAY,@counter,@curDate)))
					
			end
			else if(@counter=0)
			begin
				insert into @tableBirthday
				select
					nama,alamat,region.namaKelompok, email
				from
					klien join region on
						klien.fkRegion = region.idR
				where
					DATEPART(dd, tglLahir) >= DATEPART(dd,@curDate) and
					DATEPART(mm, klien.tglLahir) = DATEPART(mm, @curDate) and
					DATEPART(dd, tglLahir) <= DATEADD(DAY,7,@curDate)
			end
		end
	else if(@perintah=3)
		begin
			insert into @tableBirthday
				select
					nama,alamat,region.namaKelompok, email
				from
					klien join region on
						klien.fkRegion = region.idR
				where
					DATEPART(mm, klien.tglLahir) = DATEPART(mm, @curDate)
		end
END

	select * 
	from @tableBirthday
go

exec findBirthday 3

