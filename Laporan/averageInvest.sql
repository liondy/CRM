/*
	sp yang digunakan untuk membuat laporan rata rata investasi tiap daerah
	setiap klien akan di masukkan pada region yang terdapat pada leaf
	sehingga pencarian rata rata ini dilakukan pada semua leaf

	@param : tidak ada parameter pada sp ini

	@output : 
		@namaRegion : merupakan nama tempat seseorang klien
		@ratarataInvest : merupakan nilai rata-rata invest pada tiap daerah
		@jumlahKlien : merupakan jumlah klien yang melakukan investasi pada sebuah region

	SP ini dapat di improve dengan memasukkan parameter waktu jika diinginkan
	sehingga sp ini dapat mengeluarkan rata rata investasi pada jangka waktu tertentu

*/

alter procedure averageInvest
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
				@tempRegion = region.idR and klien.status!=0 
			group by 
				region.namaKelompok

			fetch next from curRegion into @tempRegion
		end

		close curRegion
		deallocate curRegion

		select * 
		from @regionTable

exec averageInvest




