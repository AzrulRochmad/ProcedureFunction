CREATE PROCEDURE lahir()
BEGIN
SELECT nip,tgl_lahir,nm_pegawai as "nama" from pegawai WHERE YEAR(tgl_lahir)>1986;
END

call lahir
