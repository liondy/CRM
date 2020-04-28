alter procedure insertCS(
	@nama varchar(15),
	@StatementType nvarchar(20) = '' 
)
as
	BEGIN
		IF @StatementType = 'insert'  
		BEGIN  
			insert into cusService(nama) values(@nama)  
		END  
	END

-------------------------------------------------------------------------
alter procedure deleteNama(
	@idname int,
	@StatementType nvarchar(20) = '' 
)
as
	begin IF @StatementType = 'delete' 
		BEGIN  
		DELETE FROM  
			cusService  
		WHERE  
		idC = @idname 
		END 
	end

