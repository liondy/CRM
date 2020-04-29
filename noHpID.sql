alter procedure noHPInsert(
	@idUser int,
	@nohp varchar(15)
)
as 
BEGIN
	declare
		@dumpHP varchar(15), 
		@countHP int,
		@idKlien int

	set @countHP = (
		select
			count(noHP)
		from
			noHPKlien
		where
			fkKlien = @idUser
	)

	set @idKlien = (
		select
			idK
		from
			klien
		where
			idK = @idUser
	)

	if @countHP < 2 AND @idKlien IS NOT NULL
	BEGIN
		set @dumpHP = (
			select
				noHP
			from
				noHPKlien
			where
				fkKlien = @idUser
		)

		if @dumpHP != @nohp OR @dumpHP IS NULL
		BEGIN
			insert into noHpKlien(
				fkKlien, noHp
			)
			VALUES(
				@idUser, @nohp
			)
		END
	END

	select
		nama,
		noHP
	from
		klien inner join noHPKlien ON
		klien.idK = noHPKlien.fkKlien
	where
		idK = @idUser
END

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