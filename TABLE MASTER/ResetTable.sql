ALTER PROCEDURE reset
AS
	drop table klien
	drop table noHpklien
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

	create table [cusService](
		[idC] [int]  IDENTITY(1,1) PRIMARY KEY,
		[nama] [varchar] (50) NOT NULL
	)

	create table [hubungan](
		[idH] [int]  IDENTITY(1,1) PRIMARY KEY,
		[idKK] [int] NOT NULL,
		[idUser] [int] NOT NULL,
		[posisi] [varchar] (20) NOT NULL
	)

	create table [region](
		[idRecord] [INT] IDENTITY(1,1) PRIMARY KEY,
		[idR] [int]  NOT NULL,
		[namaKelompok] [varchar] (50) NOT NULL,
		[idParent] [int] NOT NULL
	)

	create table [investasi](
		[idIvest] [int]  IDENTITY(1,1) PRIMARY KEY,
		[fkIdKlien] [int] NOT NULL,
		[nominal] [money] NOT NULL,
		[waktu] [datetime] NOT NULL,
		[fkCusService] [int] NOT NULL
	)


	create table [perubahan](
		[idPe] [int]  IDENTITY(1,1) PRIMARY KEY,	
		[waktu] [datetime] NOT NULL,
		[tabel] [varchar](10) NOT NULL,
		[idRecord] [int] NOT NULL, --awalnya fkInvest
		[operasi] [varchar](20) NOT NULL
	)

	create table [history](
		[idH] [int] IDENTITY(1,1) PRIMARY KEY,
		[fkPerubahan] [int] NOT NULL,
		[kolom] [varchar] (50) NOT NULL,
		[tipeData] [varchar] (50) NOT NULL,
		[nilaiSebelum] [varchar] (50) NOT NULL
	)

GO