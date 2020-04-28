drop table klien
drop table noHpklien 
drop table telepon
drop table cusService
drop table hubungan
drop table region
drop table investasi
drop table perubahan
drop table history



create table [klien](
	[idK] [int] IDENTITY(1,1) PRIMARY KEY,
	[nama] [varchar] (50) NOT NULL,
	[alamat] [varchar] (100) NOT NULL,
	[tglLahir] [date] NOT NULL,
	[fkRegion] [int] NOT NULL,
	[fkHubungan] [int] NOT NULL,
	[status] [int] NOT NULL,
	[email] [varchar] (50) NOT NULL
)


create table [noHpklien](
	[fkKlien] [int] NOT NULL,
	[noHp] [varchar](15) NOT NULL
)

create table [telepon](
	[idK] [int] NOT NULL,
	[noHp] [varchar](15) NOT NULL
)

create table [cusService](
	[idC] [int]  IDENTITY(1,1) PRIMARY KEY,
	[nama] [varchar] (50) NOT NULL
)

create table [hubungan](
	[idH] [int]  IDENTITY(1,1) PRIMARY KEY,
	[idKK] [int] NOT NULL,
	[idUser] [int] NOT NULL,
	[posisi] [varchar] (10) NOT NULL
)

create table [region](
	[idR] [int]  IDENTITY(1,1) PRIMARY KEY,
	[namaKelompok] [varchar] (50) NOT NULL,
	[idParent] [int] NOT NULL
)

create table [investasi](
	[idIvest] [int]  IDENTITY(1,1) PRIMARY KEY,
	[fkIdKlien] [int] NOT NULL,
	[nominal] [money] NOT NULL,
	[waktu] [datetime] NOT NULL
)


create table [perubahan](
	[idPe] [int]  IDENTITY(1,1) PRIMARY KEY,	
	[waktu] [datetime] NOT NULL,
	[fkInvest] [int] NOT NULL,
	[operasi] [int] NOT NULL
)

create table [history](
	[idH] [int] IDENTITY(1,1) PRIMARY KEY,
	[fkPerubahan] [int] NOT NULL,
	[kolom] [varchar] (20) NOT NULL,
	[tipeData] [varchar] (10) NOT NULL,
	[nilaiSebelum] [varchar] (50) NOT NULL
)

insert into klien  (nama,alamat,tglLahir,fkRegion, fkHubungan, status, email)  select 'Denise Stevani', 'rancabintang', '19990511', 1, 1, 1, 'dsgeb@gmail.com'
insert into klien  (nama,alamat,tglLahir,fkRegion, fkHubungan, status, email)  select 'Cristine Artanty', 'rancajupiter', '19990127', 2, 1, 1, 'tinetiny@gmail.com'
insert into klien  (nama,alamat,tglLahir,fkRegion, fkHubungan, status, email)  select 'Friska Christiana', 'rancabulan', '19981219', 1, 2, 1, 'friskac@gmail.com'
insert into klien  (nama,alamat,tglLahir,fkRegion, fkHubungan, status, email)  select 'Michael Liondy', 'rancavenus', '19990105', 1, 2, 1, 'miclio@gmail.com'

insert into noHpKlien select 1, '081234567891'
insert into noHpKlien select 2, '081234567892'
insert into noHpKlien select 3, '081234567893'
insert into noHpKlien select 4, '081234567894'

insert into telepon select 1, '021-000200'

insert into cusService (nama) select  'Tom'
insert into cusService (nama) select  'Jerry'


insert into hubungan(idKK, idUser, posisi) select  1, 1, 'ayah'
insert into hubungan (idKK,idUser, posisi) select  1, 2, 'ibu'
insert into hubungan (idKK,idUser, posisi) select  2, 3, 'ayah'
insert into hubungan (idKK,idUser, posisi) select  2, 4, 'ibu'

insert into region (namaKelompok, idParent) select 'Jawa Barat', 1
insert into region (namaKelompok, idParent) select  'Sumatera uUtara', 2
insert into region (namaKelompok, idParent) select  'Jakarta', 1

insert into investasi (fkIdKlien, nominal, waktu) select  1, 100000, '20190401 10:34:09 AM'
insert into investasi (fkIdKlien, nominal, waktu) select  1, 200000, '20190407 15:20:01 PM'
insert into investasi (fkIdKlien, nominal, waktu) select  2, 50000, '20190401 10:10:10 AM'

insert into perubahan (waktu, fkInvest, operasi) select  '20190405 10:50:11 AM', 1, 2
insert into perubahan (waktu, fkInvest, operasi) select  '20190401 10:10:10 AM', 3, 1

insert into history (fkPerubahan, kolom, tipeData, nilaiSebelum) select  1, 'nominal', 'money', '100000'
insert into history (fkPerubahan, kolom, tipeData, nilaiSebelum) select  3, 'nominal', 'money', '50000'



