alter procedure cariKlienInvestDiatasNominal(
	@namaDaerah varchar(50),
	@nominal money
)
as
	--tabel hasil
	declare @resKlien table(
		nama varchar(50),
		nominal money
	)

	--mendapatkan idR dari nama Daerah
	declare @idR int
	set @idR = (
		select
			idR		
		from
			region
		where
			namaKelompok = @namaDaerah 
	)

	declare @count int
	declare @tableLeaf table(
		idDaerah int
	)

begin
	if(@idR is not null)
		begin
			if(@idR!=1)
			begin
				set @count = (
				select
					count(r2.namaKelompok)
				from
					region  r1 left join region r2 on
						r1.idR = r2.idParent
				where
					r1.idR = @idR and r2.idParent is not null
				)

				if(@count != 0)
					begin
						insert into @tableLeaf
							select
								r2.idR
							from
								region r1 left join region r2 on
									r1.idR = r2.idParent
							where
								r1.idR = @idR and r2.idParent is not null
					end
				ELSE
					BEGIN
						insert into @tableLeaf
							select
								@idR
					end
				end
			else
				begin
					set @count = (
					select
						count(region.namaKelompok)
					from
						region join
						(
						select
							r2.idR as 'parentB'
						from
							region  r1 left join region r2 on
								r1.idR = r2.idParent
						where
							r1.idR = @idR and r2.idParent is not null) as tableBaru  on
								region.idParent = tableBaru.parentB
					)

					if(@count != 0)
						begin
							insert into @tableLeaf
							select
								region.idR
							from
								region join
								(
								select
									r2.idR as 'parentB'
								from
									region  r1 left join region r2 on
										r1.idR = r2.idParent
								where
									r1.idR = @idR and r2.idParent is not null) as tableBaru  on
										region.idParent = tableBaru.parentB
						end
				end
			 
			declare curLeaf cursor
			for
				select * 
				from @tableLeaf

			open curLeaf

			declare @temp int

			fetch next from curLeaf into @temp
			while(@@FETCH_STATUS = 0)
				BEGIN
					insert into @resKlien
					select
						nama, nominal
					from
						investasi join klien on
						investasi.fkIdKlien = klien.idK join region on 
							klien.fkRegion = region.idR
					where
						klien.fkRegion = @temp and 
						nominal > @nominal and
						klien.status != 0

					fetch next from curLeaf into @temp
				END

			close curLeaf
			deallocate curLeaf

		end

		select * 
		from @resKlien
end
go

exec cariKlienInvestDiatasNominal 'Bandung',100000
