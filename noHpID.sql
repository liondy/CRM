alter procedure noHPInsert(
	@idUser int,
	@nohp varchar(15)
)
as 
BEGIN
	insert into noHpKlien(
		fkKlien, noHp
	)
	VALUES(
		@idUser, @nohp
	)
END

alter procedure noHpDelete(
	@idUser int,
	@noHp varchar(15)
)
as
BEGIN
	DELETE FROM  noHpKlien
	WHERE fkKlien = @idUser AND noHp = @noHp
END