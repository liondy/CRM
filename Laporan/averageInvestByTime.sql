/*
	sp yang digunakan untuk membuat laporan rata rata investasi tiap daerah pada rentang waktu tertentu
	setiap klien akan di masukkan pada region yang terdapat pada leaf
	sehingga pencarian rata rata ini dilakukan pada semua leaf

	@param : rentang waktu yang akan dicari rata rata investasinya
			penulisan waktu dengan format YYYY-MM-DD
				- YYYY = 4 digit tahun (2020)
				- MM = 2 digit bulan (01)
				- DD = 2 digit tanggal (12)

	@output : 
		@namaRegion : merupakan nama tempat seseorang klien
		@ratarataInvest : merupakan nilai rata-rata invest pada tiap daerah
		@jumlahKlien : merupakan jumlah klien yang melakukan investasi pada sebuah region
*/

alter procedure averageInvestByTime(
	@dateAwal date,
	@dateAkhir date
)
as
	declare @regionTable table(
		namaRegion varchar(50),
		ratarataInvest float,
		jumlahKlien int
	)

	declare curRegion cursor
	for
		select
			r1.idR
		from
			region  r1 left join region r2 on
				r1.idR = r2.idParent
		where
			r2.idParent is null
	
	open curRegion

	declare @tempRegion varchar(50)
BEGIN
if(@dateAwal<=GETDATE() and @dateAkhir<=GETDATE())
	begin
		if(@dateAwal!=@dateAkhir)
		begin
			fetch next from curRegion into @tempRegion
			while(@@FETCH_STATUS = 0)
				begin
					insert into @regionTable
					select
						region.namaKelompok, 
						cast(AVG(investasi.nominal) as float) as 'rata rata investasi',
						count(klien.idK) as 'jumlah klien'
					from
						investasi join klien on
							investasi.fkIdKlien = klien.idK join region on
								klien.fkRegion = region.idR
					where
						@tempRegion = region.idR and 
						klien.status!=0 and
						DATEPART(year,investasi.waktu) >= DATEPART(year,@dateAwal) and
						DATEPART(month,investasi.waktu) >= DATEPART(month,@dateAwal) and
						DATEPART(day,investasi.waktu) >= DATEPART(day,@dateAwal) and
						DATEPART(year,investasi.waktu) <= DATEPART(year,@dateAkhir) and
						DATEPART(month,investasi.waktu) <= DATEPART(month,@dateAkhir) and
						DATEPART(day,investasi.waktu) <= DATEPART(day,@dateAkhir)
					group by 
						region.namaKelompok

					fetch next from curRegion into @tempRegion
				end
		end
		else if(@dateAwal=@dateAkhir)
		begin 
			fetch next from curRegion into @tempRegion
			while(@@FETCH_STATUS = 0)
				begin
					insert into @regionTable
					select
						region.namaKelompok, 
						cast(AVG(investasi.nominal) as float) as 'rata rata investasi',
						count(klien.idK) as 'jumlah klien'
					from
						investasi join klien on
							investasi.fkIdKlien = klien.idK join region on
								klien.fkRegion = region.idR
					where
						@tempRegion = region.idR and 
						klien.status!=0 and
						DATEPART(year,investasi.waktu) = DATEPART(year,@dateAwal) and
						DATEPART(month,investasi.waktu) = DATEPART(month,@dateAwal) and
						DATEPART(day,investasi.waktu) = DATEPART(day,@dateAwal)
					group by 
						region.namaKelompok

					fetch next from curRegion into @tempRegion
				end
		end
	end
END
close curRegion
deallocate curRegion

select * 
from @regionTable
go

exec averageInvestByTime '2019-04-07','2020-04-07'
