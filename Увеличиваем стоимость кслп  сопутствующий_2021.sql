--отредактирован Max 06.05.2019
  --исправлены русские буквы на английские
--отредактирован Max 06.06.2019
  --исправлена проблема с 2 и более сопутствующими диагнозами
--Наташа 09,07,2019 добавила скобки  
declare @p1 int=7850
--INSERT INTO 

--UPDATE Ksg SET Ksg.it_sl=1.10000, Ksg.sl_k=1

INSERT INTO [D3_SL_KOEF_OMS] ([D3_KSGID]
      ,[D3_KSGGID]
      ,[IDSL]
      ,[Z_SL])
SELECT KsgKpg.ID, KsgKpg.KSG_ID, 2051, 0.6000
--SELECT  distinct zsl.ID, zsl.ZSL_ID, zsl.SUMV-- cr.crit, ksg.id, ksg.KSG_ID,ksg.SL_K,ksg.IT_SL--,  dsko.*


--SELECT distinct zsl.ID, zsl.SUMV, KsgKpg.IT_SL, KsgKpg.SL_K
fROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id --AND p.smo=46003
  inner join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id
  inner join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID
  inner join D3_KSG_KPG_OMS KsgKpg on KsgKpg.D3_SLID=sl.id 
  Left join D3_SL_KOEF_OMS SlKoEf on SlKoEf.D3_KSGID=KsgKpg.ID
   join D3_DSS_OMS AS ds 
      ON ds.D3_SLID = sl.ID
      AND ds.DS_TYPE = 2    
  join flk_m001_Morfan Morf
      on ds.ds=morf.mkb_code 
  WHERE 
    zsl.D3_SCID = @p1  
    ---------------------
    and zsl.USL_OK = 1 
   --AND slkoEf.IDSL is null
    --AND ds.ID IS NULL