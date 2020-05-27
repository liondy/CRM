-- Berikut adalah skenario dari klien yang mendaftar untuk investasi dalam kurun waktu 1 minggu (7 hari saja)
-- Serta hubungan-hubungan yang ada antar klien
/**
tgl 1
idKlien     alamat          tglLahir            fkRegion     fkHubungan      status      
1           cemara no.5     2 juni 1968                         1(ayah)        1           INSERT
2           rancabentang    15 agustus 1970                     2(ayah)        1           INSERT
3           rancabulan      20 oktober 1995                     3(ibu)         1           INSERT

tgl 2
idKlien     alamat          tglLahir            fkRegion     fkHubungan      status      
4           cemara no.5     10 desember 1970                    1(ibu)          1           INSERT (hubungan dgn id 1)
2           rancabentang    15 agustus 1970                     2(ayah)         0           UPDATE (klien sudah tidak aktif)

tgl 3
idKlien     alamat          tglLahir            fkRegion     fkHubungan      status
5           kembartimur     15 desember 1995                    1(anak1)        1           INSERT (hubungan dgn id 1)
6           batikayu        4 juli  1993                        3(anak1)        1           INSERT (hubungan dgn id 3)

tgl 4
idKlien     alamat          tglLahir            fkRegion     fkHubungan      status
7           rancabulan      2 juni 1996                         3(anak2)        1           INSERT (hubungan dgn id 3,6)
5           kembartengah    15 desember 1995                    4(ayah)         1           UPDATE (id 5 dari anak mjd ayah dgn KK baru), alamat baru

tgl 5
idKlien     alamat          tglLahir            fkRegion     fkHubungan      status
8           kembartengah    20 januari 1996                     4(ibu)          1           INSERT (hubungan dgn id 5)
6           batikayu        4 juli 1993                         3(anak1)        0           UPDATE (klien sudah tidak aktif)

tgl 6
idKlien     alamat          tglLahir            fkRegion     fkHubungan      status
9           cemara no.5     11 februari 1998                    1(anak2)        1           INSERT (hubungan dgn id 1,4,5)
10          kembartengah    14 maret 1997                       4(anak1)        1           INSERT (hubungan dgn id 5,8)

tgl 7
idKlien     alamat          tglLahir            fkRegion     fkHubungan      status
9           riau            11 februaru 1998                    5(ibu)          1           UPDATE (id 9 berubah dari anak2 mjd ibu dgn KK baru), alamat baru
4           cemara no.5     10 desember 1970                    1(ibu)          0           UPDATE (klien sudah tidak aktif)

**/