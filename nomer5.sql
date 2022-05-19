CREATE FUNCTION tunjangan()
RETURNS INT
BEGIN
DECLARE jumlah INT;
SELECT pegawai.nm_pegawai as "Nama",gaji.gaji, gaji.gaji*0.5 as tunjangan INTO jumlah from pegawai JOIN gaji ON gaji.nip=pegawai.nip GROUP BY pegawai.nm_pegawai ;
RETURN jumlah;
END