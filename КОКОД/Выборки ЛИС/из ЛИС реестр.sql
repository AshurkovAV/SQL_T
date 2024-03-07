--BEGIN TRAN  --commit tran
--UPDATE s SET iddokt='029-796-491 19'
--UPDATE u SET code_md='029-796-491 19'
--UPDATE u SET u.code_usl='R01.001.030' --u.VID_VME LIKE 'A08.09.011'--1
--UPDATE u SET u.code_usl='R01.001.020' --u.VID_VME LIKE 'A12.05.123'--3
--UPDATE u SET u.code_usl='R01.001.029' --u.VID_VME LIKE 'A12.20.001'--719
--UPDATE u SET u.code_usl='R01.001.010' --u.VID_VME LIKE 'A26.06.033'--13
--UPDATE u SET u.code_usl='R01.001.029' --u.VID_VME LIKE 'A26.19.011'--67
--UPDATE s SET s.ds1 ='Z01.7'
--UPDATE zs SET ISHOD = 304
--UPDATE p SET p.smo='46007'
--UPDATE zs SET sump=NULL
--if OBJECT_ID('ztemp_protocol_07021') is not null drop table ztemp_protocol_07021
--SELECT distinct zs.id AS zslid,p.ID AS pid
--INTO ztemp_lis_0522
Select --sum(sumv)

--s.iddokt,u.CODE_MD
DISTINCT
zs.id,

   p.fam+' '+p.im+' '+isnull(p.ot,'') as [ФИО]
 ,p.W as [Пол],  p.NPOLIS as [Номер полиса]
  ,cast(p.DR AS DATE) as [Дата рождения]
  , convert(nvarchar(150),(case when p.DOCTYPE=14  then 'Паспорт РФ'
  when p.DOCTYPE=3 then 'Св-во о рождении'
  else doc.DocName end)) [Документ УДЛ]
  ,convert(nvarchar,(p.DOCSER)) [Серия]
  , convert(nvarchar,(p.DOCNUM)) [Номер]
  ,convert(nvarchar,(p.DOCORG)) [Кем выдан]
  ,convert(date,(p.DOCDATE)) [Дата выдачи]
  -- + ' ' + convert(nvarchar,(p.DOCSER)) + ' ' + convert(nvarchar,(p.DOCNUM)) as [Данные документа удостоверяющего личность]
  --, p.NPOLIS as [Полис]
  , p.SNILS as [СНИЛС пациента]
  , cast(zs.DATE_Z_1 AS DATE) [Дата взятия]
  , f003.nam_mok [Заказчик]
  , cast(zs.DATE_Z_1 AS DATE) [Дата направления]

 ,u.VID_VME [Код услуги]
 , y.name [Наименование услуги]
  , s.iddokt [СНИЛС врача]


FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 
 --AND sch.month=5
 AND sch.YEAR=2022
 and sch.id in (7074)--(4137,4357,5380,5381,5602)
  join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
  JOIN D3_USL_OMS u ON u.D3_SLID=s.id


join V009 rz on rz.IDRMP=zs.RSLT
left join F011 doc on doc.Id=p.DOCTYPE
LEFT JOIN f003 ON f003.mcod=zs.NPR_MO
--WHERE iddokt is  NULL --AND sch.SchetType LIKE 'H'
--WHERE (ds1 NOT BETWEEN 'C00' AND 'D09.z') and ds1 NOT BETWEEN 'D45' AND 'D47.z'
left JOIN medicalServices AS ms ON ms.code_usl=u.CODE_USL AND u.DATE_IN >=ms.dataBegin AND u.DATE_OUT<=ISNULL(ms.dataEnd,'20991231') AND ms.code_usl  BETWEEN 'R01.001.008' AND 'R01.001.036'
left join Yamed_Spr_UslCode y on y.ID=u.vid_vme	
--CalcRegUslLis
--WHERE npr_date<>date_2
--WHERE zs.ISHOD<>304
--WHERE --zs.ishod<>304 
------ms.ishod<> zs.ishod
--s.IDDOKT IS null
--WHERE p.npolis LIKE '4670050885000154
--WHERE zs.sumv IS NULL --AND u.VID_VME LIKE 'A26.19.011'

--ORDER BY p.npolis,vid_vme, date_in
 

--SELECT * from medicalServices
			--WHERE zs.EXP_COMENT IS NOT null
				--zs.EXP_COMENT LIKE '% В Федер. регистре COVID19 отсутствует соответствующая запись%'
				--
				--zs.EXP_COMENT LIKE '%Диагноз в услуге должен быть указан до подрубрики, если подрубрика предусмотрена МКБ-10%'
				--OR zs.EXP_COMENT LIKE '%МЭК - Недопустимое заполнение поля DS_ONK при основном диагнозе Z03.1%'
				--OR zs.EXP_COMENT LIKE '%Неуточнен код МКБ10 до четвертого знака в услуге %'*/
--WHERE isnull(sumv,0)=0
--WHERE (zs.EXP_COMENT LIKE '%ДПФС%' OR zs.EXP_COMENT LIKE '%vpolis%')
--ds1 LIKE 'U07%'
--WHERE u.CODE_USL LIKE 'R01.001.999'
--WHERE p.smo NOT LIKE '46%'
