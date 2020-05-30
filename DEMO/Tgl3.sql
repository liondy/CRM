ALTER PROCEDURE Tgl3
AS
    EXEC investasiUpdate 'Ipin', 'rancabulan', '19951020', 'cimahi', 200000, 1
    UPDATE Perubahan SET waktu = '20200103 10:10:07 AM' where idRecord = 3 AND tabel = 'investasi' and operasi = 'UPDATE'
    UPDATE investasi SET waktu = '20200103 10:10:07 AM' where fkIdKlien = 3

    exec KlienInsert 'Meimei', 'rancabulan', '19960602', 'Cimahi', 'anak kedua', 'meimei@unpar.ac.id', 350000, 2
    EXEC noHPInsert 7,'08555556789'
    EXEC noHPInsert 7,'08123411789'
    UPDATE Perubahan SET waktu = '20200103 10:20:20 AM' where idRecord = 20  AND tabel = 'klien' AND operasi = 'INSERT'
    UPDATE Perubahan SET waktu = '20200103 10:20:20 AM' where idRecord = 20 AND tabel = 'investasi' AND operasi = 'INSERT'
    UPDATE Perubahan SET waktu = '20200103 10:20:20 AM' where idRecord = 20 AND tabel = 'hubungan' AND operasi = 'INSERT'
    UPDATE investasi SET waktu = '20200103 10:20:20 AM' where fkIdKlien = 9

    EXEC investasiUpdate 'Rose', 'cemara', '19701210', 'bandung', 500000, 2
    UPDATE Perubahan SET waktu = '20200103 10:30:05 AM' where idPe = 43 AND tabel = 'investasi' and operasi = 'UPDATE'
    UPDATE investasi SET waktu = '20200103 10:30:05 AM' where fkIdKlien = 4

    EXEC investasiDelete 2,1
    UPDATE Perubahan SET waktu = '20200103 11:00:10 AM' where idRecord = 22 AND tabel = 'investasi' and operasi = 'DELETE'

    EXEC investasiUpdate 'Jarjit', 'cemara', '19951217', 'Bandung', 350000, 3
    UPDATE Perubahan SET waktu = '20200103 11:30:25 AM' where idRecord = 5 AND tabel = 'investasi' and operasi = 'UPDATE'
    UPDATE investasi SET waktu = '20200103 11:30:25 AM' where fkIdKlien = 5

    exec KlienInsert 'Fizzi', 'kembartengah', '19960120', 'Jakarta Barat', 'ibu', 'fizz@yahoo.com', 500000, 3
    EXEC noHPInsert 8,'08123856789'
    EXEC noHPInsert 8,'08123456713'
    UPDATE Perubahan SET waktu = '20200103 13:00:42 PM' where idRecord = 24 AND tabel = 'klien' AND operasi = 'INSERT'
    UPDATE Perubahan SET waktu = '20200103 13:00:42 PM' where idRecord = 24 AND tabel = 'investasi' AND operasi = 'INSERT'
    UPDATE Perubahan SET waktu = '20200103 13:00:42 PM' where idRecord = 24 AND tabel = 'hubungan' AND operasi = 'INSERT'
    UPDATE investasi SET waktu = '20200103 13:00:42 PM' where fkIdKlien = 12
GO