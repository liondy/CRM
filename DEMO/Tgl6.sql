ALTER PROCEDURE Tgl6
AS
    EXEC investasiUpdate 'Jarjat', 'cemara', '19980211', 'Bandung', 600000, 1
    UPDATE Perubahan SET waktu = '20200106 11:11:11 AM' where idRecord = 14  AND tabel = 'investasi' and operasi = 'UPDATE'
    UPDATE investasi SET waktu = '20200106 11:11:11 AM' where fkIdKlien = 14

    EXEC investasiUpdate 'Mail', 'batikayu', '19930704', 'Jakarta Selatan', 500000, 3
    UPDATE Perubahan SET waktu = '20200106 12:56:00 PM' where idPe = # AND tabel = 'investasi' and operasi = 'UPDATE'
    UPDATE investasi SET waktu = '20200106 12:56:00 PM' where fkIdKlien = 6
    
    EXEC investasiUpdate 'Ehsan', 'kembartengah', '19970314', 'Jakarta Barat', 500000, 2
    UPDATE Perubahan SET waktu = '20200106 13:46:01 PM' where idRecord = 18 AND tabel = 'investasi' and operasi = 'UPDATE'
    UPDATE investasi SET waktu = '20200106 13:46:01 PM' where fkIdKlien = 18
GO