/*
    STORED PROCEDURE untuk mencari klien yang sudah lama tidak melakukan investasi (terakhir lebih dari tiga bulan yang lalu)
    Klien yang ditampilkan adalah klien yang berinvestasi lebih dari tiga bulan yang lalu
    Program akan mencari klien yang terakhir berinvestasi lebih dari tiga bulan yang lalu
    dan akan menampilkan telepon serta alamat emailnya agar perusahaan dapat menghubungi client
    @param: tidak ada
    @return: seluruh klien aktif yang sudah tidak melakukan investasi selama tiga bulan terakhir
    tabel berupa:
    namaKlien, no HP 1, no HP 2, email, terakhir investasi, lama bulan
*/
ALTER PROCEDURE cariKlienSudahLamaTidakInvestasi
AS
    DECLARE @tbResult TABLE(
        Nama VARCHAR(50),
        NoHP1 VARCHAR(15),
        NoHP2 VARCHAR(15),
        email VARCHAR(50),
        InvestasiTerakhir DATETIME,
        LamaWaktu INT
    )

    DECLARE
        @curDate DATETIME,
        @i INT,
        @nama VARCHAR(50),
        @email VARCHAR(50),
        @investTerakhir DATETIME,
        @lamaWaktu INT,
        @idK INT,
        @curNoHP VARCHAR(15),
        @noHP1 VARCHAR(15),
        @banyakHP INT
    
    SET @curDate = GETDATE()

    DECLARE itKlien CURSOR
    FOR
        SELECT
            Klien.idK,
            Klien.nama,
            Klien.email,
            waktu AS 'Investasi Terakhir',
            DATEDIFF(MONTH,waktu,@curDate) AS 'LamaBulan'
        FROM
            Investasi INNER JOIN Klien ON
            Investasi.fkIdKlien = Klien.idK
        WHERE
            nominal != 0.0000 AND
            Klien.[status] != 0
        GROUP BY
            klien.idK,klien.nama,klien.email,waktu
        HAVING
            DATEDIFF(MONTH,waktu,@curDate) > 3
        ORDER BY
            DATEDIFF(MONTH,waktu,@curDate) DESC
    
    OPEN itKlien
    FETCH NEXT FROM
        itKlien
    INTO
        @idK,
        @nama,
        @email,
        @investTerakhir,
        @lamaWaktu

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @banyakHP = (
            SELECT
                COUNT(noHpklien.noHp)
            FROM
                noHpklien
            WHERE
                fkKlien = @idK
        )

        IF @banyakHP = 0
        BEGIN
            INSERT INTO @tbResult
            SELECT
                @nama,
                '-',
                '-',
                @email,
                @investTerakhir,
                @lamaWaktu
        END
        ELSE IF @banyakHP = 1
        BEGIN
            SET @curNoHP = (
                SELECT
                    noHpklien.noHp
                FROM
                    noHpklien
                WHERE
                    fkKlien = @idK
            )
            INSERT INTO @tbResult
            SELECT
                @nama,
                @curNoHP,
                '-',
                @email,
                @investTerakhir,
                @lamaWaktu
        END
        ELSE
        BEGIN
            DECLARE itNoHP CURSOR
            FOR
                SELECT
                    noHpklien.noHp
                FROM
                    noHpklien
                WHERE
                    fkKlien = @idk
            
            OPEN itNoHP

            FETCH NEXT FROM
                itNoHP
            INTO
                @curNoHP

            SET @i = 0
            WHILE @@FETCH_STATUS = 0
            BEGIN
                IF @i = @banyakHP - 1
                BEGIN
                    INSERT INTO @tbResult
                    SELECT
                        @nama,
                        @noHP1,
                        @curNoHP,
                        @email,
                        @investTerakhir,
                        @lamaWaktu
                END
                SET @noHP1 = @curNoHP
                SET @i = @i + 1
                FETCH NEXT FROM
                    itNoHP
                INTO
                    @curNoHP
            END

            CLOSE itNoHP
            DEALLOCATE itNoHP
        END
        
        FETCH NEXT FROM
            itKlien
        INTO
            @idK,
            @nama,
            @email,
            @investTerakhir,
            @lamaWaktu
    END

    CLOSE itKlien
    DEALLOCATE itKlien

    SELECT * FROM @tbResult
GO