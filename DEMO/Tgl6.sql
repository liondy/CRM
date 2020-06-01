ALTER PROCEDURE Tgl6
AS
    EXEC KlienUpdate 9,'sukaasin;;ibu;;', 600000, 1
    UPDATE Perubahan SET waktu = '20200106 11:11:11 AM' where idPe = 74  AND tabel = 'Klien' and operasi = 'UPDATE'
    UPDATE Perubahan SET waktu = '20200106 11:11:11 AM' where idPe = 75  AND tabel = 'hubungan' and operasi = 'DELETE'
    UPDATE Perubahan SET waktu = '20200106 11:11:11 AM' where idPe = 76  AND tabel = 'investasi' and operasi = 'UPDATE'
    UPDATE investasi SET waktu = '20200106 11:11:11 AM' where fkIdKlien = 9

    EXEC investasiUpdate 'Mail', 'batikayu', '19930704', 'Jakarta Selatan', 500000, 3
    UPDATE Perubahan SET waktu = '20200106 12:56:00 PM' where idPe = 77 AND tabel = 'investasi' and operasi = 'UPDATE'
    UPDATE investasi SET waktu = '20200106 12:56:00 PM' where fkIdKlien = 6
    
    EXEC investasiUpdate 'Ehsan', 'kembartengah', '19970314', 'Jakarta Barat', 500000, 2
    UPDATE Perubahan SET waktu = '20200106 13:46:01 PM' where idPe = 78 AND tabel = 'investasi' and operasi = 'UPDATE'
    UPDATE investasi SET waktu = '20200106 13:46:01 PM' where fkIdKlien = 18
GO