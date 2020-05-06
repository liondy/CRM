alter procedure noHpDelete(
	@idUser int,
	@noHp varchar(15)
)
as
BEGIN
	DELETE FROM  noHpKlien
	WHERE fkKlien = @idUser AND noHp = @noHp

	SELECT
		nama,
		noHP
	FROM
		klien INNER JOIN noHPKlien ON
		klien.idK = noHPKlien.fkKlien
	WHERE
		idK = @idUser
END