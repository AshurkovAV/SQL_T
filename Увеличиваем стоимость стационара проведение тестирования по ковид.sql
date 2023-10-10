INSERT INTO [D3_SL_KOEF_OMS] ([D3_KSGID]
      ,[D3_KSGGID]
      ,[IDSL]
      ,[Z_SL])
SELECT KsgKpg.ID, KsgKpg.KSG_ID, 3141, 0.0500
fROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id --AND p.smo=46003
  inner join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id
  inner join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID
  inner join D3_KSG_KPG_OMS KsgKpg on KsgKpg.D3_SLID=sl.id 
  --Left join D3_SL_KOEF_OMS SlKoEf on SlKoEf.D3_KSGID=KsgKpg.ID
 -- join D3_DSS_OMS AS ds  ON ds.D3_SLID = sl.ID
     
WHERE sch.[YEAR] = 2023
AND zsl.D3_SCID = 20244
AND zsl.USL_OK = 1
