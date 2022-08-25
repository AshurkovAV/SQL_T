DECLARE @schetTab TABLE (id INT)
INSERT INTO @schetTab(id)VALUES(2898)
--INSERT INTO @schetTab(id)VALUES(2865)
SELECT p.FAM, p.IM, p.OT, CAST(p.DR AS DATE)DR, sl.DS1,  
(SELECT ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = sl.IDDOKT)
FROM D3_ZSL_OMS AS zsl
JOIN D3_PACIENT_OMS AS p ON p.ID = zsl.D3_PID 
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
WHERE zsl.D3_SCID IN (SELECT id FROM @schetTab) AND zsl.OS_SLUCH_REGION in( 47,49) 
AND sl.DS_ONK = 1
AND zsl.PR_NOV = 0   
ORDER BY p.FAM, p.IM