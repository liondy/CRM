CREATE PROCEDURE Tgl6
AS
    EXEC inverstasiUpdate 'Jarjat', 'cemara', '19980211', 'Bandung', 600000, 1
    UPDATE Perubahan SET waktu = "20200106 11:11:11 AM" where idRecord = 39  AND tabel = 'Investasi'
    UPDATE investasi SET waktu = "20200106 11:11:11 AM" where fkIdKlien = 21

    EXEC inverstasiUpdate 'Mail', 'batikayu', '19930704', 'Jakarta Selatan', 500000, 3
    UPDATE Perubahan SET waktu = "20200106 12:56:00 PM" where idRecord = 40 AND tabel = 'Investasi'
    UPDATE investasi SET waktu = "20200106 12:56:00 PM" where fkIdKlien = 22
    
    EXEC inverstasiUpdate 'Ehsan', 'kembartengah', '19970314', 'Jakarta Barat', 500000, 2
    UPDATE Perubahan SET waktu = "20200106 13:46:01 PM" where idRecord = 41 AND tabel = 'Investasi'
    UPDATE investasi SET waktu = "20200106 13:46:01 PM" where fkIdKlien = 23
GO