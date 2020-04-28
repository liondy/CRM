alter procedure insertTelp(
	@idK int,
	@noHp varchar(15),
	@StatementType nvarchar(20) = '' 
)
as
	BEGIN
		IF @StatementType = 'insert'  
		BEGIN  
			insert into telepon(idK,noHp) values(@idK, @noHp)  
		END  
	END


------------------------------------------------------------------------------------------
alter procedure updateNoHP(
	@idHP int,
	@noHp varchar(15),
	@StatementType nvarchar(20) = '' 
)
as
	BEGIN
		IF @StatementType = 'update'  
		BEGIN  
			UPDATE telepon SET  
			noHp = @noHp 
			WHERE idK = @idHP 
		END  
	END

-----------------------------------------------------------------------------------------
alter procedure deleteNo(
	@idHP int,
	@StatementType nvarchar(20) = '' 
)
as
	begin IF @StatementType = 'delete' 
		BEGIN  
		DELETE FROM  
			telepon  
		WHERE  
		idK = @idHP 
		END 
	end
