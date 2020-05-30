ALTER PROCEDURE Tgl2
AS
	EXEC investasiUpdate 'Udin','cemara','19680602','Bandung',150000,3
	UPDATE perubahan SET waktu ='20200102 09:30:00 AM' WHERE idRecord = 1 AND tabel = 'investasi' AND operasi = 'UPDATE'
	UPDATE investasi SET waktu ='20200102 09:30:00 AM' WHERE fkIdKlien = 1

	EXEC insertReg 'Region1',0
	UPDATE perubahan SET waktu = '20200102 09:46:00 AM' WHERE idRecord = 11 AND tabel = 'Region'

	EXEC insertRegion 'Bogor','Jawa Barat'
	UPDATE perubahan SET waktu = '20200102 09:50:00 AM' WHERE idRecord = 12 AND tabel = 'Region'

	EXEC KlienInsert 'Jarjit', 'cemara', '19951217', 'Bandung', 'anak pertama', 'jarjit@yahoo.com', 300000, 1
	EXEC noHPInsert 5,'08123456589'
	EXEC noHPInsert 5,'08123456748'
	UPDATE investasi SET waktu = '20200102 10:00:00 AM' WHERE fkIdKlien = 5
	UPDATE perubahan SET waktu = '20200102 10:00:00 AM' WHERE idRecord = 5 AND tabel = 'hubungan' AND operasi = 'INSERT'
	UPDATE perubahan SET waktu = '20200102 10:00:00 AM' WHERE idRecord = 5 AND tabel = 'investasi' AND operasi = 'INSERT'
	UPDATE perubahan SET waktu = '20200102 10:00:00 AM' WHERE idRecord = 5 AND tabel = 'klien' AND operasi = 'INSERT'


	EXEC investasiUpdate 'Rose','cemara','19700610','Bandung',250000,3
	UPDATE perubahan SET waktu = '20200102 10:10:00 AM' WHERE idRecord = 4 AND tabel = 'investasi' AND operasi = 'UPDATE'
	UPDATE investasi SET waktu ='20200102 10:10:00 AM' WHERE fkIdKlien = 4

	EXEC KlienInsert 'Mail', 'batikayu', '19930704', 'Jakarta Selatan', 'anak pertama', 'mail@yahoo.com', 300000, 1
	EXEC noHPInsert 6,'08123456780'
	EXEC noHPInsert 6,'08123499789'
	UPDATE investasi SET waktu = '20200102 11:32:00 AM' WHERE fkIdKlien = 6
	UPDATE perubahan SET waktu = '20200102 11:32:00 AM' WHERE idRecord = 6 AND tabel = 'hubungan' AND operasi = 'INSERT'
	UPDATE perubahan SET waktu = '20200102 11:32:00 AM' WHERE idRecord = 6 AND tabel = 'investasi' AND operasi = 'INSERT'
	UPDATE perubahan SET waktu = '20200102 11:32:00 AM' WHERE idRecord = 6 AND tabel = 'klien' AND operasi = 'INSERT'

	EXEC insertRegion 'Jawa Timur','Indonesia'
	UPDATE perubahan SET waktu = '20200102 11:40:00 AM' WHERE idRecord = 13 AND tabel = 'Region'

	EXEC insertRegion 'Surabaya','Jawa Timur'
	UPDATE perubahan SET waktu = '20200102 11:50:00 AM' WHERE idRecord = 14 AND tabel = 'Region'

	EXEC insertRegion 'Malang','Jawa Timur'
	UPDATE perubahan SET waktu ='20200102 11:55:00 AM' WHERE idRecord = 15 AND tabel = 'Region' 

	EXEC insertRegion 'Jawa Tengah','Indonesia'
	UPDATE perubahan SET waktu ='20200102 11:56:00 AM' WHERE idRecord = 16 AND tabel = 'Region'

	EXEC insertRegion 'Semarang','Jawa Timur'
	UPDATE perubahan SET waktu = '20200102 11:57:00 AM' WHERE idRecord = 17 AND tabel = 'Region'

	EXEC insertRegion 'Semarang','Jawa Tengah'
	UPDATE perubahan SET waktu = '20200102 11:58:00 AM' WHERE idRecord = 18 AND tabel = 'Region'
GO

/*
	next
	region idR = 19
	klien idK = 8
	investasi idivest = 8
*/