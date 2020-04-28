--misal yang di update adalah alamat
CREATE PROCEDURE KlienUpdate(
    @nama varchar(50),
    @alamatBaru varchar(50),
    @operasi varchar(50)
)
AS
    IF (@operasi = 'update' or @operasi = 'Update' or @operasi = 'UPDATE')
    BEGIN
        UPDATE klien SET
            alamat = @alamatBaru
        WHERE
            nama = @nama
    END