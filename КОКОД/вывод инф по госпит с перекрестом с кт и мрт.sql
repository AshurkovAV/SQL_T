--if OBJECT_ID('ztemp_digCdelete_072020') is not null drop table ztemp_digCdelete_062020

--!!!!!!
SELECT distinct  sch.month,t.name [отделение],  [ФИО врача стац], t.nhistory [номер ист госп], t.DATE_Z_1 [дата начала госп], t.DATE_Z_2 [дата ок госп],ms.name [услуга регион],y.name [услуга федер],usl.DATE_IN [дата услуги], p.npolis

FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2021 --and   sch.id IN (1587,1754,2012)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
 JOIN d3_usl_oms usl ON usl.D3_SLID=s.id  AND (usl.code_usl  LIKE 'R01.001.001%' or  usl.code_usl  LIKE 'R01.001.002%')
 left JOIN medicalServices AS ms ON ms.code_usl=usl.CODE_USL AND usl.DATE_IN >=ms.dataBegin AND usl.DATE_OUT<=ISNULL(ms.dataEnd,'20211231') --AND ms.code_usl NOT LIKE 'R03%'
 left join Yamed_Spr_UslCode y on y.id=usl.vid_vme
JOIN
(
select sch.id AS schit, zs.id,zs.DATE_Z_1, zs.DATE_Z_2, p.npolis, s.iddokt,kt.[fam]+' '+kt.[im]+' '+kt.[ot] [ФИО врача стац], s.podr, k.name, s.nhistory
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2021 and   month<=3-- and sch.month=12-- AND sch.id IN (1275,1276,1278)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID
 left join KOKOD_OTD k on k.kod_otd=s.podr
 left join [KOKOD_PODR] kt on kt.[IDDOCT]=dbo.f_digit_only( iddokt) and zs.usl_ok=kt.[usl_ok]
) t ON t.npolis=p.npolis AND t.date_z_1<usl.DATE_IN AND usl.date_in<t.DATE_Z_2
--WHERE zs.D3_SCID IN (1247,1248,1258)
--where p.id=1239687


