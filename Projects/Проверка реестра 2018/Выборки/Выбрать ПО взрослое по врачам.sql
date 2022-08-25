DECLARE @D3_SCID int = 2061
SELECT 
(SELECT osd.NameWithID FROM OsobSluchDb AS osd WHERE osd.Id = dz.OS_SLUCH_REGION)[������ ������ � �������], 
(SELECT TOP 1 ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = ds.IDDOKT)[����], IDDOKT, COUNT(*)[����������], SUM(dz.SUMV)[�����]
FROM D3_ZSL AS dz
JOIN PACIENT AS p ON dz.D3_PID = p.ID
JOIN D3_SL AS ds ON dz.ID = ds.D3_ZSLID
WHERE dz.D3_SCID = @D3_SCID --AND p.SMO = 46001 
AND  OS_SLUCH_REGION IN ( 9)
GROUP BY dz.OS_SLUCH_REGION, ds.IDDOKT