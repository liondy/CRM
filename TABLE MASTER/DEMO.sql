--tgl 1
EXEC updateCustomerService 'Tom','tambah'
EXEC updateCustomerService 'Jerry','tambah'
EXEC updateCustomerService 'Nibbles','tambah'

EXEC insertReg 'Indonesia',0
EXEC insertRegion 'Jawa Barat','Indonesia'
EXEC insertRegion 'Bandung','Jawa Barat'
EXEC insertRegion 'Bekasi','Jawa Barat'
EXEC insertRegion 'Cimahi','Jawa Barat'
EXEC insertRegion 'DKI Jakarta','Indonesia'
EXEC insertRegion 'Jakarta Timur','DKI Jakarta'
EXEC insertRegion 'Jakarta Pusat','DKI Jakarta'
EXEC insertRegion 'Jakarta Barat','DKI Jakarta'
EXEC insertRegion 'Jakarta Selatan','DKI Jakarta'


exec KlienInsert 'Udin', 'cemara', '19680602', 'Bandung', 'ayah', 'udindin@gmail.com', 100000, 1
exec KlienInsert 'Upin', 'rancabentang', '19700815', 'Jakarta Pusat', 'ayah', 'upinpin@gmail.com', 50000, 1
exec KlienInsert 'Ipin', 'rancabulan', '19951020', 'Cimahi', 'ibu', 'ipinpin@gmail.com', 150000, 2
exec KlienInsert 'Rose', 'cemara', '19701210', 'Bandung', 'ibu', 'rose@gmail.com', 50000, 2




exec KlienInsert 'Jarjit', 'cemara', '19951217', 'Bandung', 'anak pertama', 'jarjit@yahoo.com', 300000, 1
exec KlienInsert 'Mail', 'batikayu', '19930704', 'Jakarta Selatan', 'anak pertama', 'mail@yahoo.com', 300000, 1
exec KlienInsert 'Meimei', 'rancabulan', '19960702', 'Cimahi', 'anak kedua', 'meimei@unpar.ac.id', 350000, 2
exec KlienInsert 'Fizzi', 'kembartengah', '19960120', 'Jakarta Barat', 'ibu', 'fizz@yahoo.com', 500000, 3
exec KlienInsert 'Jarjat', 'cemara', '19980211', 'Bandung', 'anak kedua', 'jarjat@yahoo.com', 500000, 3
exec KlienInsert 'Ehsan', 'kembartengah', '19970314', 'Jakarta Barat', 'anak pertama', 'ehsan@gmail.com', 300000, 2