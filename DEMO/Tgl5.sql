CREATE PROCEDURE Tgl5
AS
	EXEC updateReg'Tanggerang','Banten','DKI Jakarta'
	UPDATE perubahan SET waktu = '20200105 09:00:00 AM' WHERE idRecord=21 AND tabel ='Region' AND operasi='UPDATE'

	EXEC undoRegion 'Tanggerang',6
	UPDATE perubahan SET waktu = '20200105 09:05:00 AM' WHERE idRecord=21 AND tabel ='Region' AND operasi='UNDO'

	EXEC undoInvestasi 'ipin','rancabulan','19951020','ipinpin@gmail.com'
	UPDATE perubahan SET waktu = '20200105 10:32:00 AM' WHERE idRecord=3 AND tabel='investasi' AND operasi='UNDO'

	EXEC investasiUpdate 'Meimei','rancabulan','19960702','Cimahi',500000,3
	UPDATE perubahan SET waktu = '20200105 11:07:00 AM' WHERE idRecord=7 AND tabel='investasi' AND operasi='UPDATE'
	UPDATE investasi SET waktu = '20200105 11:07:00 AM' WHERE idIvest=7

	EXEC KlienInsert 'Ehsan', 'kembartengah', '19970314', 'Jakarta Barat', 'anak pertama', 'ehsan@gmail.com', 300000, 2
	UPDATE investasi SET waktu = '20200105 13:12:00' WHERE fkIdKlien = 10
	UPDATE perubahan SET waktu = '20200105 13:12:00' WHERE idRecord=10 AND tabel = 'hubungan' AND operasi = 'INSERT'
	UPDATE perubahan SET waktu = '20200105 13:12:00' WHERE idRecord=10 AND tabel = 'investasi' AND operasi = 'INSERT'
	UPDATE perubahan SET waktu = '20200105 13:12:00' WHERE idRecord=10 AND tabel = 'klien' AND operasi = 'INSERT'

	EXEC investasiUpdate 'Udin','cemara','19680602','Bandung',500000,1
	UPDATE investasi SET waktu ='20200105 13:45:00' WHERE fkIdKlien=1
	UPDATE perubahan SET waktu ='20200105 13:45:00' WHERE idRecord=1 AND tabel='investasi' AND operasi ='UPDATE'
GO