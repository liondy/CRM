ALTER PROCEDURE insertRegion
    @namaKelompok varchar(50),
    @namaParent varchar(50)
AS
    DECLARE
        @idParent INT
    
    SET @idParent = (
        SELECT
            DISTINCT(idR)
        FROM
            Region
        WHERE
            namaKelompok = @namaParent
    )

    IF @idParent IS NOT NULL
    BEGIN
        EXEC insertReg @namaKelompok, @idParent
    END
GO