CREATE PROCEDURE pegawai()
BEGIN
SELECT data_pegawai.nik, data_pegawai.nama,tabel_jabatan.nama_jabatan as jabatan, tabel_divisi.nama_divisi as divisi from data_pegawai join tabel_jabatan on data_pegawai.id_jabatan=tabel_jabatan.id_jabatan join tabel_divisi on data_pegawai.dd_divisi=tabel_divisi.id_divisi;
END

