SELECT p.FAM, p.IM, p.OT,p.DR, zsl.DATE_Z_1, zsl.DATE_Z_2, ds1,zsl.USL_OK, 
(SELECT TOP 1 ysme.NameWithID
   FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = sl.IDDOKT) doct
FROM [D3_SCHET_OMS] sch                  
    join D3_PACIENT_OMS p on p.d3_scid=sch.id 
     join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id
        join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID
LEFT JOIN D3_DSS_OMS AS ddo ON ddo.D3_SLID = sl.ID
WHERE zsl.D3_SCID = 3032   AND (ds1 IN ('U07.1','U07.2') OR ddo.DS IN ('U07.1','U07.2')) 