DECLARE @p1 INT = 1581

declare @tt1 table 
(id nvarchar(16))
insert into @tt1 values('mt')
	
  
-- в АПП при диагнозе Z поле характер заболевания не заполняется

UPDATE s SET C_ZAB = null
FROM [D3_SCHET_OMS] sch                
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id --and sch.month=12  
  --  and sch.id=1585--@p1 
    AND sch.year=2021 AND sch.month=3
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id --and zs.usl_ok<>4 and (zs.OS_SLUCH_REGION not in (7,8,9,11,12,17,18,22,23,37,38) or zs.OS_SLUCH_REGION is null)
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID  -- and (s.ds1 not like ''Z%'')
  left join   D3_DSS_OMS sd on sd.D3_SLID=s.id and sd.DS_TYPE=2  
 where (--sch.SchetType like ''%H%''
     zs.usl_ok=3 
     AND 
     s.ds1  like 'Z%' 
     --AND  (zs.OS_SLUCH_REGION not in (7,8,9,11,12,17,18,22,23,37,38) or zs.OS_SLUCH_REGION is null)
     and C_ZAB IS NOT NULL)


 --Площадь поверхности тела расчитана неверно
UPDATE onk SET BSA = cast(SQRT(wei*hei/3600) AS NUMERIC(3,2))
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id     AND sch.year=2021 AND sch.month=4
  --and sch.year=2019 and sch.month=1
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id    and zs.usl_ok in (1,2)      
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID   
 --join D3_KSG_KPG_OMS ksg on ksg.D3_SLID=s.id  --and ksg.N_KSG in (select id from @tt)
 join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id
 where onk.WEI is NOT NULL 
 AND onk.hei is NOT NULL 
 and onk.bsa IS NOT NULL 
 AND onk.BSA <>cast(SQRT(wei*hei/3600) AS NUMERIC(3,2))---<>1
 
 	
---В кругл стац-ре при КСГ номер 171,176,177 обязателен ТОЛЬКО ОДИН квалификац критерий mt		
DELETE D3_CRIT_OMS

WHERE ID IN (

SELECT  cr.ID FROM 

[D3_SCHET_OMS] sch
		inner join [D3_PACIENT_OMS] p on sch.id=p.[D3_SCID]
									and sch.id=@p1
									AND sch.OmsFileName LIKE '%c%' --онко реестр
		inner join [D3_ZSL_OMS] zs on p.id=zs.[D3_PID]
									AND zs.USL_OK=1
									AND YEAR(zs.DATE_Z_2)=sch.[YEAR]
		inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]
		INNER join D3_KSG_KPG_OMS ksg ON ksg.D3_SLID=sl.id
		JOIN [D3_CRIT_OMS] cr ON cr.D3_KSGID=ksg.ID
WHERE cr.CRIT LIKE	'fr%'	AND zs.ID IN (
		
select 
	zs.ID AS ID
	
FROM [D3_SCHET_OMS] sch
		inner join [D3_PACIENT_OMS] p on sch.id=p.[D3_SCID]
									and sch.id=@p1
									AND sch.OmsFileName LIKE '%c%' --онко реестр
		inner join [D3_ZSL_OMS] zs on p.id=zs.[D3_PID]
									AND zs.USL_OK=1
									AND YEAR(zs.DATE_Z_2)=sch.[YEAR]
		inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]
		INNER join D3_KSG_KPG_OMS ksg ON ksg.D3_SLID=sl.id --для связи с КСГ
								AND ksg.[VER_KSG]=sch.year
		INNER JOIN sprksg ON sprksg.id= ksg.N_KSG	
				AND zs.USL_OK=sprksg.STYPE
				AND CAST (sprksg.[KSGNUM] AS float) IN (171,176,177)
		LEFT JOIN [D3_CRIT_OMS] cr ON cr.D3_KSGID=ksg.ID
		left join @tt1 t1 on t1.id=SUBSTRING(cr.CRIT,1,2)
--WHERE cr.CRIT LIKE 'fr'
GROUP BY
	zs.ID, zs.SUMV, cr.ID
HAVING (COUNT (t1.id)<>1) OR (COUNT (cr.id)<>1)

)
)		

--При поводе онкослучая Диспансерное наблюдение (здоров/ремиссия) должна быть цель 1.3 

update sl set P_CEL25 = '1.3'
FROM [D3_SCHET_OMS] sch
    inner join [D3_PACIENT_OMS] p on sch.id=p.[D3_SCID]
                  and sch.id=@p1
                  --AND sch.year=2019 AND sch.month=4
    inner join [D3_ZSL_OMS] zs on p.id=zs.[D3_PID]
    inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]
    inner join D3_ONK_SL_OMS onk on onk.D3_SLID=sl.id  --онко случай
                and onk.DS1_T IN (4)
WHERE sl.P_CEL25 NOT IN ('1.3')

--Код диспансерного наблюдения (поле DN) обязателен к заполнению, если P_CEL=1.3 и только следующими значениями: 1,2,4,6
update sl SET DN = 1
FROM [D3_SCHET_OMS] sch                  
	inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
		inner join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id
			inner join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID
			---------------------------------------------
where 
	p.D3_SCID = @p1 
	-----------------------
	and isnull(zsl.OS_SLUCH_REGION,0) in (0,7,8,9,11,12,17,18,22,23,37,38)
	and isnull(sl.P_CEL25,'')='1.3'
	and isnull(sl.DN,0) not in (1,2,4,6)
	
	
--Не заполнено обязательное поле DET признак детского профиля В УСЛУГЕ
UPDATE u SET DET = sl.DET
FROM [D3_ZSL_OMS] zs
		inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]
		inner join [D3_USL_OMS] u on u.D3_SLID=sl.id
where 
	zs.D3_SCID = 2231--1432--@p1
	and u.DET is NULL
	
	 --Не заполнено обязательное поле CODE_MD код мед работника,выполнившего услугу,  В УСЛУГЕ
	UPDATE u SET CODE_MD = sl.IDDOKT
FROM [D3_ZSL_OMS] zs
		inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]
		inner join [D3_USL_OMS] u on u.D3_SLID=sl.id
where 
	zs.D3_SCID = @p1
	and u.CODE_MD IS   null	
	
	--Не заполнено обязательное поле PRVS специальность мед работника,выполнившего услугу,  В УСЛУГЕi
UPDATE u SET PRVS = vv.IDSPEC
FROM [D3_ZSL_OMS] zs
		inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]
		inner join [D3_USL_OMS] u on u.D3_SLID=sl.id
		JOIN V002_V021 AS vv ON vv.IDPR_2 = u.PROFIL
where 
	zs.D3_SCID = @p1
	and u.PRVS is NULL
	
update sl set DET = 0	--Недопустимое выставление НЕдетского профиля МП при sl.det=1
FROM [D3_ZSL_OMS] zs
	inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]
where zs.D3_SCID = 1585--@p1
	and sl.DET=1
	and sl.PROFIL not in (17,18,19,20,21,55,86,68,83,131)
----	
update sl set det = 1	--Недопустимое выставление детского профиля МП при sl.det=0
FROM [D3_ZSL_OMS] zs
	inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]
where zs.D3_SCID = @p1
	and sl.DET=0
	and sl.PROFIL in (17,18,19,20,21,55,86,68,83,131)	

--не проставлен признак дет	
UPDATE sl SET DET = 0
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dzo ON dzo.D3_PID = dpo.ID
	inner join [D3_SL_OMS] sl on dzo.id=sl.[D3_ZSLID]
where dzo.D3_SCID = @p1
	and sl.det is NULL
	AND dbo.f_GetAge(dpo.dr,date_z_1) > 17
	
--не проставлен признак дет	
UPDATE sl SET DET = 1
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dzo ON dzo.D3_PID = dpo.ID
	inner join [D3_SL_OMS] sl on dzo.id=sl.[D3_ZSLID]
where dzo.D3_SCID = @p1
	and sl.det is NULL
	AND dbo.f_GetAge(dpo.dr,date_z_1) <= 17	
	
	
--Не заполнено обязательное поле SUMV_USL стоимость услуги В УСЛУГЕ
UPDATE u SET SUMV_USL = 0  
FROM [D3_ZSL_OMS] zs
		inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]
		inner join [D3_USL_OMS] u on u.D3_SLID=sl.id
where 
	zs.D3_SCID = @p1
	and u.SUMV_USL is null	
		
		
		
		---

update zs set npr_date = zs.DATE_Z_1
FROM 
	D3_ZSL_OMS zs
where
	zs.D3_SCID=@p1
	and zs.NPR_MO is not null
	and zs.npr_date is NULL
	
--	SOD должен отсутствовать при условии USL_TIP<>{3, 4}
	UPDATE onk SET SOD = null
FROM [D3_SCHET_OMS] sch                  
join D3_PACIENT_OMS p on p.d3_scid=sch.id and sch.id=@p1 
join D3_ZSL_OMS zs on zs.D3_PID=p.id
join D3_SL_OMS s on s.D3_ZSLID=zs.ID  
join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id 

WHERE onk.ID IN  (

Select distinct onk.ID
--zs.SUMV,''com--'SOD должен отсутствовать при условии USL_TIP<>{3, 4}
--UPDATE ONk SET SOD = null
FROM [D3_SCHET_OMS] sch                  
join D3_PACIENT_OMS p on p.d3_scid=sch.id and sch.id=@p1
join D3_ZSL_OMS zs on zs.D3_PID=p.id
join D3_SL_OMS s on s.D3_ZSLID=zs.ID  
join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id  
left join D3_ONK_USL_OMS onk_usl on onk_usl.D3_ONKSLID=onk.id  
WHERE onk.SOD IS not NULL
GROUP BY sch.month, sch.code_mo,zs.id, zs.sumv, sch.year, onk.id,
onk_usl.id
HAVING SUM(CASE when onk_usl.USL_TIP IN (3,4) THEN 1 ELSE 0 end)=0
)



--Не заполнено обязательное поле KOL_USL количество (кратность) услуги В УСЛУГЕ;
 
UPDATE u SET u.KOL_USL = 1
FROM [D3_ZSL_OMS] zs
		inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]
		inner join [D3_USL_OMS] u on u.D3_SLID=sl.id
where 
	zs.D3_SCID = @p1
	-------
	and isnull(u.KOL_USL,0)<=0			