create procedure dummy
as
	exec investasiUpdate 'Udin','cemara','19680602','Bandung',1000000,1
	update investasi set waktu ='20200212 13:30:00 PM' where fkIdKlien = 1
	update perubahan set waktu ='20200212 13:30:00 PM' where idPe = 86

	exec investasiUpdate 'Jarjit','cemara','19951217','Bandung',800000,2
	update investasi set waktu ='20200314 10:40:00 AM' where fkIdKlien = 5
	update perubahan set waktu ='20200314 10:40:00 AM' where idPe = 87
go