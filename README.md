# CRM
Basis Data untuk kebutuhan Customer Relationship Management Perusahaan Investasi <br>
Akses ke basis data dibuat menggunakan Stored Procedure. <br>
List masing-masing file di bawah ini beserta keterangan singkat mengenai kegunaannya <br>
Pada masing-masing file juga terdapat keterangan dan cara penggunaanya <br>

## TABLE MASTER
- MASTER.sql <br>
Script untuk mengeksekusi masing-masing Stored Procedure beserta keterangan parameternya <br>

- DummyData.sql <br>
Berisi data-data yang sengaja dimasukkan untuk kebutuhan testing <br>
WARNING! Hanya bersifat optional karena seharusnya apabila memasukkan sebuah record, harus tercatat pada `log` <br>

- ResetTable.sql <br>
Stored Procedure untuk menghapus tabel lama dan membuat tabel baru sehingga data menjadi bersih

## Client
Semua kebutuhan stored procedure untuk tabel Klien. <br>
- KlienInsert.sql <br>
Untuk memasukkan calon klien menjadi klien (memanggil SP regionInsert, hubunganInsert, investasiInsert) <br>
RegionInsert hanya dipanggil apabila nama daerah calon klien belum ada di basis data. <br>

- KlienUpdate.sql <br>
Untuk mengupdate data-data klien (memanggil SP regionInsert dan hubunganDelete) <br>
RegionInsert hanya dipanggil apabila nama daerah baru yang ditinggali klien belum ada di basis data <br>
HubunganDelete hanya dipanggil apabila seseorang sudah pindah kartu keluarga (misalkan dulunya anak sudah menjadi ayah) <br>

- KlienDelete.sql <br>
Untuk mengubah data klien menjadi tidak aktif lagi (misal berhenti berinvestasi atau meninggal) <br>

## Customer Service
- CSUpdate.sql <br>
Untuk mengubah data Customer Service yang ada (memasukkan atau mengeluarkan seorang CS) <br>

- CSUndo.sql <br>
Untuk membatalkan perubahan yang terjadi pada Customer Service (misalkan kesalahan memasukkan nama atau kesalahan mengeluarkan seorang CS)

## Hubungan
- HubunganInsert.sql <br>
Menambahkan suatu relasi seorang klien. SP ini akan dipanggil saat memasukkan calon klien. <br>

- HubunganDelete.sql <br>
Menghapus suatu peran seseorang dalam KK (misalkan saat pertama kali berinvestasi adalah seorang anak dan kemudian sekarang sudah menjadi ayah) sehingga akan mendapatkan ID KK yang baru dengan peran yang baru.

## Investasi
- InvestasiInsert.sql <br>
Untuk memasukkan sebuah investasi baru dari seorang klien. SP ini dipanggil saat memasukkan data klien baru karena seorang klien hanya bisa memiliki satu investasi. <br>

- InvestasiUpdate.sql <br>
Untuk memperbaharui investasi seorang klien. Karena seorang klien tidak dapat menambah investasi dan hanya dapat mengubah nominal investasi sebelumnya. <br>

- InvestasiDelete.sql <br>
Untuk menonaktifkan sebuah investasi apabila user sudah tidak aktif lagi. <br>

- InvestasiUndoInner.sql <br>
Untuk membatalkan perubahan yang terjadi pada Investasi Klien dengan setiap klien dapat membatalkan perubahan yang ada. SP ini akan dipanggil SP InvestasiUndoOuter.sql <br>

- InvestasiUndoOuter.sql <br>
SP yang dipanggil saat seorang CS ingin membatalkan perubahan yang terjadi dengan cara mengambil terlebih dahulu data-data klien yang ingin dibatalkan agar tidak salah. Kemudian SP akan secara otomatis mencari ID Klien yang ingin dibatalkan untuk selanjutnya dijalankan SP InvestasiUndoInner.sql yang akan membalikkan data seperti sebelumnya.

## Region
- RegionInsertInner.sql <br>
Untuk memasukkan sebuah daerah baru dari seorang klien / calon klien. SP ini dipanggil saat memasukkan data klien baru apabila daerah calon klien belum terdaftar pada sistem atau klien yang mengubah daerahnya dan daerah baru ini belum terdaftar pada sistem <br>
Jadi, SP insertReg pada RegionInsertInner.sql ini akan dipanggil pada: <br>
1. Dipanggil dari SP KlienInsert apabila daerah yang ditinggali calon klien belum terdaftar di basis data. <br>
2. Dipanggil dari SP insertRegion pada RegionInsertOuter.sql apabila manajer ingin menambahkan data daerah beserta termasuk kelompok mananya.

- RegionInsertOuter.sql <br>
SP ini digunakan untuk memasukkan suatu region baru beserta parent nya. Tidak seperti saat memasukkan sebuah region pada saat ada klien baru, SP ini mengharuskan ada nama kelompoknya, apabila tidak ada nama kelompoknya, maka SP akan otomatis langsung keluar. SP ini akan memanggil SP insertReg pada RegionInsertInner.sql

- RegionUpdate.sql <br>
Untuk memperbaharui kelompok suatu daerah. SP ini idealnya hanya dipegang oleh Manajer untuk mengubah suatu daerah tergabung pada kelompok yang mana. Suatu daerah dapat tergabung dalam lebih dari satu kelompok <br>

- RegionUndoInner.sql <br>
Untuk membatalkan perubahan yang terjadi pada penambahan daerah atau pembaharuan kelompok daerah. SP ini akan dipanggil SP RegionUndoOuter.sql <br>

- RegionUndoOuter.sql <br>
SP yang dipanggil saat seorang Manajer ingin membatalkan perubahan yang terjadi pada data Region dengan cara mengambil terlebih dahulu data-data Region yang ingin dibatalkan agar tidak salah. Kemudian SP akan secara otomatis mencari ID Region yang ingin dibatalkan untuk selanjutnya dijalankan SP RegionUndoInner.sql yang akan membalikkan data seperti sebelumnya.

## Telepon
- TeleponInsert.sql <br>
Menambahkan nomor telepon seorang klien yang dapat dihubungi. Setiap klien dibatasi hanya memiliki dua buah nomor telepon yang dapat dihubungi pihak perusahaan. <br>

- TeleponDelete.sql <br>
Menghapus nomor telepon seorang klien yang sudah tidak aktif. <br>

Apabila ingin mengganti nomor telepon, dapat dilakukan dengan cara menghapus nomor yang sudah tidak aktif dan memasukkan kembali nomor telepon baru yang aktif

## Laporan
- averageInvest.sql <br>
Mencari rata-rata investasi klien dari semua daerah <br>

- laporanInvestMaxMin.sql <br>
Mencari investasi tertinggi dan terendah dari seluruh daerah

- cariKlienLebihDariTigaBulan <br>
Mencari klien yang melakukan investasi terakhir lebih dari tiga bulan yang lalu agar dapat dihubungi oleh pihak perusahaan agar melakukan investasi kembali. Ini berguna untuk menjaga relasi antara klien dan perusahaan