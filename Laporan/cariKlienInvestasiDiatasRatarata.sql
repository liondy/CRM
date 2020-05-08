alter procedure findKlienInvestasiAtas
as
begin
	declare @dataKlien table(
		namaDaerah varchar(50),
		namaKlien varchar(50),
		nominal money
	)

	declare @dataRatarata table(
		namaDaerah varchar(50),
		ratarata float,
		jumlahKlien int
	)
	insert @dataRatarata
	exec averageInvest

	declare curRegion cursor
	for
		select 
			namaDaerah,
			ratarata
		from
			@dataRatarata

	open curRegion

	declare 
		@tempNamaDaerah varchar(50),
		@tempRatarata float

	fetch next from curRegion into @tempNamaDaerah, @tempRatarata
	while(@@FETCH_STATUS = 0)
		begin
				insert into @dataKlien
				select 
					@tempNamaDaerah, nama, nominal
				from
					investasi join klien on
						investasi.fkIdKlien = klien.idK join region on
							klien.fkRegion = region.idR
				where
					@tempNamaDaerah = region.namaKelompok and 
					klien.status != 0 and
					nominal > @tempRatarata
				group by
					nama,nominal

				fetch next from curRegion into @tempNamaDaerah, @tempRatarata
		end

		close curRegion
		deallocate curRegion

		select *
		from @dataKlien
end
go

exec findKlienInvestasiAtas
		