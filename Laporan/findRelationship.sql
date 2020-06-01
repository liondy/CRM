CREATE PROCEDURE findRelationship
AS
    SELECT
        idKK,
        nama,
        alamat,
        posisi,
        email
    FROM
        Klien INNER JOIN Hubungan ON
        Klien.idK = Hubungan.idUser
    WHERE
        [status] = 1
    ORDER BY
        idKK