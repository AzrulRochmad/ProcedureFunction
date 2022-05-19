CREATE PROCEDURE GajiBaru()
BEGIN
SELECT nip,gaji as "Gaji Lama",(gaji*20/100)+gaji as "Gaji Baru" from gaji;
END

