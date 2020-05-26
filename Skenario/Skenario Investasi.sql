/*
	Berikut merupakan skenario investasi untuk membuat dummy data.
	skenario investasi rentang tggl 1 - 7 bulan x
	jam operasional : 9 - 14
	jam 12-12.30 waktu istirahat

	tggl 1 
	idK		jam		operasi		nominal		cs
	1		9.00	insert		50.000		1
	2		9.10	insert		10.000		1
	3		11.00	insert		100.000		2
	2		13.00	update		50.000		2 (diasumsikan klien id 2 melakukan update nominal investasinya)
	4		13.30	insert		200.000		1

	tggl 2
	1		9.30	update		100.000		3
	2		10.00	update		100.000		1
	5		11.00	insert		50.000		2
	6		11.35	insert		30.000		1

	tggl 3
	4		10.00	update		250.000		2
	7		10.20	insert		150.000		1
	6		11.00	update		50.000		3
	8		13.30	insert		100.000		1

	tggl 4
	9		9.40	insert		100.000		1
	10		10.20	insert		100.000		2
	3		11.00	update		200.000		3

	tggl 5
	1		9.00	delete					1(klien menarik kembali investasinya)
	9		9.30	update		150.000		2
	2		9.45	update		150.000		1
	3		11.00	update		250.000		3

	tggl 6
	11		11.00	insert		300.000		1
	10		11.40	update		200.000		2
	4		13.40	update		300.000		1

	tggl 7
	12		10.30	insert		200.000		1
	7		11.40	delete					3(klien menarik kembali investasinya)
	6		13.12	update		100.000		1

	untuk laporan mencari klien yang sudah lama tidak investasi(x merupakan idKlien)
	skenario ini tidak pada tanggal yang sama
	x		12.45	insert		100.000		1
	x		10.00	insert		40.000		1
	x		13.10	update		50.000		2(klien sebelumnya melakukan update)
	x		11.15	insert		15.000		3
	x		9.40	insert		150.000		2
	x		10.56	insert		120.000		3
	x		11.43	update		150.000		1(klien sebelumnya melakukan update)
	x		12.59	insert		200.000		2
*/