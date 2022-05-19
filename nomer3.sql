CREATE FUNCTION TotalGajiPegawai()
RETURNS INT
BEGIN
DECLARE jumlah INT;
SELECT SUM(gaji) as "Total" INTO jumlah FROM gaji;
RETURN jumlah;
END
