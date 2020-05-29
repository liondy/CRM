CREATE PROCEDURE Tgl7
AS
	EXEC insertRegion 'Sumatera Utara','Indonesia'
	UPDATE perubahan SET waktu ='20200107 09:10:00 AM' WHERE idRecord = 22 AND tabel = 'Region' 
	
	EXEC insertRegion 'Sumatera Selatan','Indonesia'
	UPDATE perubahan SET waktu ='20200107 09:12:00 AM' WHERE idRecord = 23 AND tabel = 'Region' 

	EXEC insertRegion 'Medan','Sumatera Utara'
	UPDATE perubahan SET waktu ='20200107 09:13:00 AM' WHERE idRecord = 24 AND tabel = 'Region' 

	EXEC investasiUpdate 'Ipin','rancabulan','19951020','Cimahi',500000,1
	UPDATE perubahan SET waktu ='20200107 10:40:00 AM' WHERE idRecord = 3 AND tabel = 'investasi' AND operasi = 'UPDATE'
	UPDATE investasi SET waktu ='20200106 10:40:00 AM' WHERE fkIdKlien = 3

	EXEC KlienDelete 'Fizzi','kembartengah','19960120','Jakarta Barat',3
	UPDATE investasi SET waktu ='20200107 11:10:00 AM' WHERE fkIdKlien = 8
	UPDATE perubahan SET waktu ='20200107 11:10:00 AM' WHERE idRecord = 8 AND tabel = 'hubungan' AND operasi = 'DELETE'
	UPDATE perubahan SET waktu ='20200107 11:10:00 AM' WHERE idRecord = 8 AND tabel = 'investasi' AND operasi = 'DELETE'
	UPDATE perubahan SET waktu ='20200107 11:10:00 AM' WHERE idRecord = 8 AND tabel = 'klien' AND operasi = 'DELETE'

	EXEC investasiUpdate 'Jarjit','cemara','19951217','Bandung',500000,2
	UPDATE perubahan SET waktu ='20200107 11:30:00 AM' WHERE idRecord = 5 AND tabel = 'investasi' AND operasi = 'UPDATE'
	UPDATE investasi SET waktu ='20200107 11:30:00 AM' WHERE fkIdKlien = 5

	EXEC insertRegion 'Palembang','Sumatera Selatan'
	UPDATE perubahan SET waktu ='20200102 11:55:00 AM' WHERE idRecord = 25 AND tabel = 'Region' 

	EXEC KlienDelete 'Mail','batikayu','19930704','Jakarta Selatan',2
	UPDATE investasi SET waktu ='20200107 13:30:00 AM' WHERE fkIdKlien = 6
	UPDATE perubahan SET waktu ='20200107 13:30:00 AM' WHERE idRecord = 6 AND tabel = 'hubungan' AND operasi = 'DELETE'
	UPDATE perubahan SET waktu ='20200107 13:30:00 AM' WHERE idRecord = 6 AND tabel = 'investasi' AND operasi = 'DELETE'
	UPDATE perubahan SET waktu ='20200107 13:30:00 AM' WHERE idRecord = 6 AND tabel = 'klien' AND operasi = 'DELETE'

	EXEC KlienDelete 'Rose','cemara','19701210','Bandung',3
	UPDATE investasi SET waktu ='20200107 13:45:00 AM' WHERE fkIdKlien = 4
	UPDATE perubahan SET waktu ='20200107 13:45:00 AM' WHERE idRecord = 4 AND tabel = 'hubungan' AND operasi = 'DELETE'
	UPDATE perubahan SET waktu ='20200107 13:45:00 AM' WHERE idRecord = 4 AND tabel = 'investasi' AND operasi = 'DELETE'
	UPDATE perubahan SET waktu ='20200107 13:45:00 AM' WHERE idRecord = 4 AND tabel = 'klien' AND operasi = 'DELETE'
GO