alter PROCEDURE undoRegion
	@namaRegion varchar(50),
	@idParent int
AS
	declare @idR int
	set @idR = (
	SELECT
		idR
	FROM
		Region
	WHERE
		namaKelompok = @namaRegion and idParent = @idParent
	)
BEGIN
	if(@idR is not null)
		BEGIN
			exec undoPerubahanRegion @idR

		SELECT
			idParent AS 'Id Parent',
			namaKelompok AS 'Nama Region'
		FROM
			region
		where 
			idR = @idR

		SELECT
			idPe AS 'id Perubahan',
			waktu,
			tabel,
			idRecord AS 'id Parent',
			operasi
		FROM
			Perubahan
		WHERE 
			tabel = 'region'

		SELECT
			fkPerubahan AS 'id Perubahan',
			kolom,
			nilaiSebelum AS 'Data id Parent Sebelum'
		FROM history where kolom = 'idParent'

		END
END

select *
from region

exec undoRegion cikarang,5