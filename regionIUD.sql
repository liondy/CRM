create procedure insertReg(
	@namaRegion varchar(15),
	@idPar int,
	@StatementType nvarchar(20) = '' 
)
as
	BEGIN
		IF @StatementType = 'insert'  
		BEGIN  
			insert into region(namaKelompok, idParent) values(@namaRegion, @idPar)  
		END  
	END

-------------------------------------------------------------------------
alter procedure updateReg(
	@idR int,
	@idPar int,
	@namaRegion varchar(15),
	@StatementType nvarchar(20) = '' 
)
as
	BEGIN
		IF @StatementType = 'update'  
		BEGIN  
			UPDATE region SET  
			idParent = @idPar,
			namaKelompok = @namaRegion
			WHERE idR = @idR 
		END  
	END
