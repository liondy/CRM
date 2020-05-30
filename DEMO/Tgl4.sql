ALTER PROCEDURE Tgl4
AS
    EXEC investasiUpdate 'Udin','cemara','19680602','Bandung',250000,1
    UPDATE perubahan SET waktu='20200104 09:23:00 AM' WHERE idRecord = 1 and tabel='investasi' and operasi='UPDATE'
    UPDATE investasi SET waktu='20200104 09:23:00 AM' WHERE fkIdKlien = 1

    EXEC KlienInsert 'Jarjat', 'cemara', '19980211', 'Bandung', 'anak kedua', 'jarjat@yahoo.com', 500000, 3
    EXEC noHPInsert 9,'08358907891'
    EXEC noHPInsert 9,'08123433789'
    UPDATE investasi SET waktu = '20200104 09:30:00 AM' WHERE idIvest = 9
    UPDATE Perubahan SET waktu = '20200104 09:30:00 AM' WHERE idRecord = 9 AND tabel = 'hubungan' AND operasi = 'INSERT'
    UPDATE Perubahan SET waktu = '20200104 09:30:00 AM' WHERE idRecord = 9 AND tabel = 'investasi' AND operasi = 'INSERT'
    UPDATE Perubahan SET waktu = '20200104 09:30:00 AM' WHERE idRecord = 9 AND tabel = 'klien' AND operasi = 'INSERT'
    
    EXEC insertRegion 'Depok','Jawa Barat'
    UPDATE Perubahan SET waktu = '20200104 09:34:00 AM' WHERE idRecord = 19 AND tabel = 'Region' and operasi = 'INSERT'

    EXEC investasiUpdate 'Ipin','rancabulan','19951020','Cimahi',250000,2
    UPDATE perubahan SET waktu='20200104 10:32:00 AM' WHERE idRecord = 3 and tabel='investasi' and operasi='UPDATE'
    UPDATE investasi SET waktu='20200104 10:32:00 AM' WHERE fkIdKlien = 3

    EXEC investasiUpdate 'Rose','cemara','19701210','Bandung',400000,1
    UPDATE perubahan SET waktu='20200104 11:07:00 AM' WHERE idRecord = 5 and tabel='investasi' and operasi='UPDATE'
    UPDATE investasi SET waktu='20200104 11:07:00 AM' WHERE fkIdKlien = 5

    EXEC insertRegion 'Banten','Indonesia'
    UPDATE Perubahan SET waktu = '20200104 13:10:00' WHERE idRecord = 20 AND tabel = 'Region' and operasi='INSERT'

    EXEC investasiUpdate 'Mail','batikayu','19930704','Jakarta Selatan',500000,2
    UPDATE perubahan SET waktu='20200104 13:30:00' WHERE idRecord = 6 and tabel='investasi' and operasi='UPDATE'
    UPDATE investasi SET waktu='20200104 13:30:00' WHERE fkIdKlien = 6

    EXEC KlienDelete  'Rose','cemara','19701210','Bandung',3
	update investasi set waktu = '20200604 13:40:00' where fkIdKlien = 4
    UPDATE perubahan SET waktu='20200604 13:40:00' WHERE idRecord=4 and tabel = 'hubungan' and operasi='DELETE'
	UPDATE perubahan SET waktu='20200604 13:40:00' WHERE idRecord=4 and tabel = 'investasi' and operasi='DELETE'
	UPDATE perubahan SET waktu='20200604 13:40:00' WHERE idRecord=4 and tabel = 'klien' and operasi='DELETE'

    EXEC insertRegion 'Tanggerang','Banten'
    UPDATE Perubahan SET waktu = '20200104 13:43:00' WHERE idRecord = 21 AND tabel = 'Region' and operasi = 'INSERT'
GO