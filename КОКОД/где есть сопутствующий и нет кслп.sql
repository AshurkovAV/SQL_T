DECLARE @p1 INT = 401
Select --distinct KsgKpg.ID, KsgKpg.KSG_ID, 61, 1.1000
distinct sch.id,zsl.ID, zsl.SUMV,sl.nhistory,SlKoEf.idsl



--SELECT distinct zsl.ID, zsl.SUMV, KsgKpg.IT_SL, KsgKpg.SL_K
fROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id --AND p.smo=46003
  inner join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id
  inner join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID
  inner join D3_KSG_KPG_OMS KsgKpg on KsgKpg.D3_SLID=sl.id 
   left join D3_SL_KOEF_OMS SlKoEf on SlKoEf.D3_KSGID=KsgKpg.ID and idsl=61
   join D3_DSS_OMS AS ds 
      ON ds.D3_SLID = sl.ID
      AND ds.DS_TYPE = 2    
      and 
          (ds.DS LIKE 'E10%'
            or ds.DS LIKE 'E11%'
            OR  ds.DS LIKE 'E84%'
            OR  ds.DS LIKE 'D66%'
            OR  ds.DS LIKE 'D67%'
            OR  ds.DS LIKE 'G35%'
            OR  ds.DS LIKE 'C82'
            OR  ds.DS LIKE 'C85'
            OR  ds.DS LIKE 'G80'
            OR  ds.DS BETWEEN  'B20' AND  'B24.z'
            OR ds.DS in 
        (
          'D68.0', 'E23.0', 'E75.5', 'C92.1',
          'C88.0', 'C90.0',  'C83.0', 'C83.1', 'C83.3', 'C83.4', 'C83.8', 'C83.9', 'C84.5',
          'C91.1', 'Z94.0', 'Z94.1', 'Z94.4', 'Z94.8', 'D59.3', 'D59.5', 'D61.9', 'D68.2',
          'D69.3', 'D84.1', 'E22.8', 'E70.0', 'E70.1', 'E70.2', 'E71.0', 'E71.1', 'E71.3', 'E72.1',
          'E72.3', 'E74.2', 'E75.2', 'E76.0', 'E76.1', 'E76.2', 'E80.2', 'E83.0', 'Q78.0', 'I27.0', 'M08.2','Z20.6'
        ))
  WHERE 
   -- zsl.D3_SCID = @p1  
	  sch.year=2020 
				 and month=7
    ---------------------
    and zsl.USL_OK = 1 
   AND slkoEf.id is null
    --AND ds.ID IS NULL