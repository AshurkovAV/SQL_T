--Ќаташа, привет. ’имиотерапевтическое отделение є1 попросили выбрать количество пациентов с 01.04-30.06  
--с диагнозами C81.1-C88.4 и можно ли их разделить на мужчин и женщин и до 50 лет/после 50 лет.
-- Ќомера реестров 2211, 2230,2430,2429,2578, 2580.

select sch.id,sch.nschet,month(date_z_2) [мес€ц выписки],
k.name
,zs.id,p.fam,p.im,p.ot,p.dr
,case when p.w=1 then 'муж' else 'жен' end [пол]
,ds1
, case when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1)<50 then 'возраст на начало госпит меньше 50 лет' else 'возраст на начало госпит больше или равен 50 лет' end [возраст]
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2021 and  sch.id IN (2211, 2230,2430,2429,2581)-- or sch.id  IN (1291))
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
 left join KOKOD_OTD k on k.kod_otd=s.podr
 where (ds1 between 'C81.1%' and  'C88.4') and s.podr like '460061106006'
 order by p.fam,p.im,p.ot,p.dr