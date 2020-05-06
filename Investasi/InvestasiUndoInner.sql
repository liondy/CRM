alter procedure undoPerubahanInvestasi(
	@nama varchar(50),
	@idK int
)
as
	declare @idPerubahanBefore int
	select
		@idPerubahanBefore = max(idPe)
	from
		perubahan join investasi on 
			perubahan.idRecord = investasi.idIvest
	where
		tabel = 'investasi' and investasi.fkIdKlien = @idK and operasi!='UNDO'

	declare @idRecord int
	select
		@idRecord = idRecord
	from
		perubahan
	where
		idPe = @idPerubahanBefore

	declare @operasi varchar(10)
	select
		@operasi = operasi
	from 
		perubahan
	where
		idPe = @idPerubahanBefore

	declare @nilaiNominalSebelum varchar(20)
	select
		@nilaiNominalSebelum = nilaiSebelum
	from
		history
	where
		fkPerubahan = @idPerubahanBefore and kolom = 'nominal'

	declare @nilaiFkCsSebelum varchar(20)
	select
		@nilaiFkCsSebelum = nilaiSebelum
	from
		history
	where
		fkPerubahan = @idPerubahanBefore and kolom = 'fkCusService'
        
	declare @nilaiNominalNow money
	declare @nilaiCSNow int
	declare @temp int
	declare @idLast int
BEGIN 
	if @operasi != 'UNDO'
		BEGIN
			if @nilaiNominalSebelum = '' and @nilaiFkCsSebelum = ''
				BEGIN
					select
						@nilaiNominalNow = nominal
					from 
						investasi
					where
						fkIdKlien = @idK

					select 
						@nilaiCSNow = fkCusService
					from
						investasi
					where
						fkIdKlien = @idK

					UPDATE investasi set
					nominal = 0, fkCusService = 0
					where fkIdKlien = @idK

					Update history Set
					nilaiSebelum = @nilaiNominalNow
					where fkPerubahan = @idPerubahanBefore and kolom = 'nominal'
					
					Update history Set 
					nilaiSebelum = @nilaiCSNow
					where fkPerubahan = @idPerubahanBefore and kolom = 'fkCusService'

					Update perubahan Set
					operasi = 'UNDO' 
					where
						idPe = @idPerubahanBefore
				END
			ELSE
				BEGIN
					if(@nilaiFkCsSebelum is null)
						begin
							set @nilaiFkCsSebelum = 0
						end
					Update investasi set
						nominal = @nilaiNominalSebelum, fkCusService = @nilaiFkCsSebelum
					where
						fkIdKlien = @idK

					Update history set
						nilaiSebelum = '' 
					where 
						fkPerubahan = @idPerubahanBefore and kolom = 'nominal'

					update history set
						nilaiSebelum = ''
					where
						fkPerubahan = @idPerubahanBefore and kolom = 'fkCusService'

					update perubahan set
						operasi = 'undo'
					where
						idPe = @idPerubahanBefore
				END
		END
END

