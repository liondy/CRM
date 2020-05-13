/*
	Merupakan perintah perintah untuk memasukkan beberapa data dummy.
	Data dummy akan berguna pada saat akan melakukan demonstrasi
*/


-- Data CS perusahaan 
EXEC updateCustomerService 'Tine','tambah'
EXEC updateCustomerService 'Friska','tambah'
EXEC updateCustomerService 'Michael','tambah'
EXEC updateCustomerService 'Denise','tambah'
EXEC updateCustomerService 'Tom','tambah'


-- Data Region
EXEC insertReg 'Indonesia',0
EXEC insertReg 'Jawa Barat',1
EXEC insertReg 'Sumatera Utara',1
EXEC insertReg 'Region-1',1
EXEC insertReg 'Bandung',2
EXEC insertReg 'Medan', 3

-- data region yang belum ada Bogor (akan di-insert saat melakukan klien insert)
