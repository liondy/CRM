ALTER PROCEDURE Tgl7
AS
	EXEC investasiUpdate 'Ipin','rancabulan','19950620','Cimahi',500000,1
	UPDATE perubahan SET waktu ='20200107 10:40:00 AM' WHERE idPe = 79
	UPDATE investasi SET waktu ='20200107 10:40:00 AM' WHERE fkIdKlien = 3

	EXEC KlienDelete 'Fizzi','kembartengah','19960605','Jakarta Barat',3
	UPDATE investasi SET waktu ='20200107 11:10:00 AM' WHERE fkIdKlien = 8
	UPDATE perubahan SET waktu ='20200107 11:10:00 AM' WHERE idRecord = 8 AND tabel = 'hubungan' AND operasi = 'DELETE'
	UPDATE perubahan SET waktu ='20200107 11:10:00 AM' WHERE idRecord = 8 AND tabel = 'investasi' AND operasi = 'DELETE'
	UPDATE perubahan SET waktu ='20200107 11:10:00 AM' WHERE idRecord = 8 AND tabel = 'klien' AND operasi = 'DELETE'

	EXEC KlienUpdate 5,';;ayah;;',500000,2
	UPDATE Perubahan SET waktu = '20200107 11:30:11 AM' where idPe = 83 AND tabel = 'Klien' and operasi = 'UPDATE'
    UPDATE Perubahan SET waktu = '20200107 11:30:11 AM' where idPe = 84 AND tabel = 'hubungan' and operasi = 'DELETE'
    UPDATE Perubahan SET waktu = '20200107 11:30:11 AM' where idPe = 85 AND tabel = 'investasi' and operasi = 'UPDATE'
    UPDATE investasi SET waktu = '20200107 11:30:11 AM' where fkIdKlien = 5
GO