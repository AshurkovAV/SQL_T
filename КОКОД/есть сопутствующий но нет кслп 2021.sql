DECLARE @p1 INT = 1564
Select --distinct KsgKpg.ID, KsgKpg.KSG_ID, 61, 1.1000
distinct sch.id,zsl.ID, zsl.SUMV,sl.nhistory--,SlKoEf.idsl


--есть сопутствующий но нет кслп
--SELECT distinct zsl.ID, zsl.SUMV, KsgKpg.IT_SL, KsgKpg.SL_K
fROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id --AND p.smo=46003
  inner join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id
  inner join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID AND date_2 BETWEEN '20210101' AND '20211231'
  inner join D3_KSG_KPG_OMS KsgKpg on KsgKpg.D3_SLID=sl.id 
  
   join D3_DSS_OMS AS ds 
      ON ds.D3_SLID = sl.ID
      AND ds.DS_TYPE = 2    
   join flk_m001_Morfan Morf
      on ds.ds=morf.mkb_code  
      left join D3_SL_KOEF_OMS SlKoEf on SlKoEf.D3_KSGID=KsgKpg.ID and idsl=1091 
  WHERE 
   -- zsl.D3_SCID = @p1  
    sch.year=2021
        -- and month=7
    ---------------------
    and zsl.USL_OK = 1
   
 AND slkoEf.id is null