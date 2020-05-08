alter procedure cariKlienInvestDiatasNominal(
	@namaDaerah varchar(50),
	@nominal money
)
as
	declare @resKlien table(
		nama varchar(50),
		nominal money
	)
	declare @idR int
	set @idR = (
		select
			idR		
		from
			region
		where
			namaKelompok = @namaDaerah 
	)
begin
	if(@idR is not null)
		begin
			insert into @resKlien
			select
				nama, nominal
			from
				investasi join klien on
				investasi.fkIdKlien = klien.idK join region on 
					klien.fkRegion = region.idR
			where
				klien.fkRegion = @idR and 
				nominal > @nominal and
				klien.status != 0
		end

		select * 
		from @resKlien
end
go

exec cariKlienInvestDiatasNominal 'medan',1
