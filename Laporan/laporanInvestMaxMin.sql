alter procedure laporanInvestMaxMin
as
	declare @tableLaporan table(
		namaRegion varchar(50),
		keterangan varchar(10),
		namaKlien varchar(50),
		nominal money
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

	declare 
		@tempRegion varchar(50)

	fetch next from curRegion into @tempRegion
	while(@@FETCH_STATUS = 0)
		begin
			--MAX
			insert into @tableLaporan
			select TOP 1
				region.namaKelompok as 'nama region', 
				'MAX' as 'keterangan',
				klien.nama,
				investasi.nominal as 'rata rata investasi'
			from
				investasi join klien on
					investasi.fkIdKlien = klien.idK join region on
						klien.fkRegion = region.idR
			where
				@tempRegion = region.idR and klien.status!=0
			group by 
				region.namaKelompok, klien.nama, investasi.nominal
			order by nominal desc

			--MIN
			insert into @tableLaporan
			select TOP 1
				'' as 'nama region', 
				'MIN' as 'keterangan',
				klien.nama,
				MIN(investasi.nominal) as 'rata rata investasi'
			from
				investasi join klien on
					investasi.fkIdKlien = klien.idK join region on
						klien.fkRegion = region.idR
			where
				@tempRegion = region.idR and klien.status!=0 and nominal!=0
			group by 
				region.namaKelompok, klien.nama, investasi.nominal
			order by nominal asc

			fetch next from curRegion into @tempRegion
		end

		close curRegion
		deallocate curRegion

		select * from @tableLaporan

exec laporanInvestMaxMin