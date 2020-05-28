CREATE PROCEDURE Tgl1
AS
    EXEC updateCustomerService 'Tom','tambah'
    UPDATE Perubahan SET waktu = '20200101 07:00:00 AM' WHERE idRecord = 1 AND tabel = 'CusService'

    EXEC updateCustomerService 'Jerry','tambah'
    UPDATE Perubahan SET waktu = '20200101 07:03:00 AM' WHERE idRecord = 2 AND tabel = 'CusService'

    EXEC updateCustomerService 'Nibbles','tambah'
    UPDATE Perubahan SET waktu = '20200101 07:05:00 AM' WHERE idRecord = 3 AND tabel = 'CusService'

    EXEC insertReg 'Indonesia',0
    UPDATE Perubahan SET waktu = '20200101 08:05:00 AM' WHERE idRecord = 1 AND tabel = 'Region'

    EXEC insertRegion 'Jawa Barat','Indonesia'
    UPDATE Perubahan SET waktu = '20200101 08:09:00 AM' WHERE idRecord = 2 AND tabel = 'Region'

    EXEC insertRegion 'Bandung','Jawa Barat'
    UPDATE Perubahan SET waktu = '20200101 08:10:10 AM' WHERE idRecord = 3 AND tabel = 'Region'

    EXEC insertRegion 'Bekasi','Jawa Barat'
    UPDATE Perubahan SET waktu = '20200101 08:12:00 AM' WHERE idRecord = 4 AND tabel = 'Region'

    EXEC insertRegion 'Cimahi','Jawa Barat'
    UPDATE Perubahan SET waktu = '20200101 08:14:00 AM' WHERE idRecord = 5 AND tabel = 'Region'

    EXEC insertRegion 'DKI Jakarta','Indonesia'
    UPDATE Perubahan SET waktu = '20200101 08:30:10 AM' WHERE idRecord = 6 AND tabel = 'Region'

    EXEC insertRegion 'Jakarta Pusat','DKI Jakarta'
    UPDATE Perubahan SET waktu = '20200101 08:34:00 AM' WHERE idRecord = 7 AND tabel = 'Region'

    EXEC insertRegion 'Jakarta Barat','DKI Jakarta'
    UPDATE Perubahan SET waktu = '20200101 08:35:00 AM' WHERE idRecord = 8 AND tabel = 'Region'

    EXEC insertRegion 'Jakarta Selatan','DKI Jakarta'
    UPDATE Perubahan SET waktu = '20200101 08:37:00 AM' WHERE idRecord = 9 AND tabel = 'Region'

    EXEC insertRegion 'Jakarta Timur','DKI Jakarta'
    UPDATE Perubahan SET waktu = '20200101 08:40:00 AM' WHERE idRecord = 10 AND tabel = 'Region'

    exec KlienInsert 'Udin', 'cemara', '19680602', 'Bandung', 'ayah', 'udindin@gmail.com', 100000, 1
    EXEC noHPInsert 1,'08123456789'
    EXEC noHPInsert 1,'08123566789'
    UPDATE investasi SET waktu = '20200101 09:10:00 AM' WHERE idIvest = 1
    UPDATE Perubahan SET waktu = '20200101 09:10:00 AM' WHERE idRecord = 1 AND tabel = 'hubungan' AND operasi = 'INSERT'
    UPDATE Perubahan SET waktu = '20200101 09:10:00 AM' WHERE idRecord = 1 AND tabel = 'investasi' AND operasi = 'INSERT'
    UPDATE Perubahan SET waktu = '20200101 09:10:00 AM' WHERE idRecord = 1 AND tabel = 'klien' AND operasi = 'INSERT'

    exec KlienInsert 'Upin', 'rancabentang', '19700815', 'Jakarta Pusat', 'ayah', 'upinpin@gmail.com', 50000, 1
    EXEC noHPInsert 2,'08123456787'
    EXEC noHPInsert 2,'08123458889'
    UPDATE investasi SET waktu = '20200101 09:20:00 AM' WHERE idIvest = 2
    UPDATE Perubahan SET waktu = '20200101 09:20:00 AM' WHERE idRecord = 2 AND tabel = 'hubungan' AND operasi = 'INSERT'
    UPDATE Perubahan SET waktu = '20200101 09:20:00 AM' WHERE idRecord = 2 AND tabel = 'investasi' AND operasi = 'INSERT'
    UPDATE Perubahan SET waktu = '20200101 09:20:00 AM' WHERE idRecord = 2 AND tabel = 'klien' AND operasi = 'INSERT'

    exec KlienInsert 'Ipin', 'rancabulan', '19951020', 'Cimahi', 'ibu', 'ipinpin@gmail.com', 150000, 2
    EXEC noHPInsert 3,'08124556789'
    EXEC noHPInsert 3,'08177456789'
    UPDATE investasi SET waktu = '20200101 10:10:00 AM' WHERE idIvest = 3
    UPDATE Perubahan SET waktu = '20200101 10:10:00 AM' WHERE idRecord = 3 AND tabel = 'hubungan' AND operasi = 'INSERT'
    UPDATE Perubahan SET waktu = '20200101 10:10:00 AM' WHERE idRecord = 3 AND tabel = 'investasi' AND operasi = 'INSERT'
    UPDATE Perubahan SET waktu = '20200101 10:10:00 AM' WHERE idRecord = 3 AND tabel = 'klien' AND operasi = 'INSERT'

    exec KlienInsert 'Rose', 'cemara', '19701210', 'Bandung', 'ibu', 'rose@gmail.com', 50000, 2
    EXEC noHPInsert 4,'08237856789'
    EXEC noHPInsert 4,'08123456755'
    UPDATE investasi SET waktu = '20200101 11:00:00 AM' WHERE idIvest = 4
    UPDATE Perubahan SET waktu = '20200101 11:00:00 AM' WHERE idRecord = 4 AND tabel = 'hubungan' AND operasi = 'INSERT'
    UPDATE Perubahan SET waktu = '20200101 11:00:00 AM' WHERE idRecord = 4 AND tabel = 'investasi' AND operasi = 'INSERT'
    UPDATE Perubahan SET waktu = '20200101 11:00:00 AM' WHERE idRecord = 4 AND tabel = 'klien' AND operasi = 'INSERT'

    EXEC investasiUpdate 'Upin','rancabentang','19700815','Jakarta Pusat',100000,1
    UPDATE Perubahan SET waktu = '20200101 13:00:00' WHERE idRecord = 2 AND tabel = 'investasi' AND operasi = 'UPDATE'
    UPDATE investasi SET waktu = '20200101 13:00:00' WHERE idIvest = 2
GO


-- exec KlienInsert 'Jarjit', 'cemara', '19951217', 'Bandung', 'anak pertama', 'jarjit@yahoo.com', 300000, 1
-- exec KlienInsert 'Mail', 'batikayu', '19930704', 'Jakarta Selatan', 'anak pertama', 'mail@yahoo.com', 300000, 1
-- exec KlienInsert 'Meimei', 'rancabulan', '19960702', 'Cimahi', 'anak kedua', 'meimei@unpar.ac.id', 350000, 2
-- exec KlienInsert 'Fizzi', 'kembartengah', '19960120', 'Jakarta Barat', 'ibu', 'fizz@yahoo.com', 500000, 3
-- exec KlienInsert 'Jarjat', 'cemara', '19980211', 'Bandung', 'anak kedua', 'jarjat@yahoo.com', 500000, 3
-- exec KlienInsert 'Ehsan', 'kembartengah', '19970314', 'Jakarta Barat', 'anak pertama', 'ehsan@gmail.com', 300000, 2