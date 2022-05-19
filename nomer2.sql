CREATE PROCEDURE JPegawaiBagian()
BEGIN
SELECT bagian.nama_bagian as "Bagian",count(gaji.kd_bagian) as "Jumlah" from bagian left join gaji on bagian.kd_bagian=gaji.kd_bagian GROUP BY bagian.nama_bagian;
END
