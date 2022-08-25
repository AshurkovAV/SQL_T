UPDATE dz SET dz.EXP_COMENT = NULL
FROM D3_ZSL_oms AS dz
WHERE dz.D3_SCID = 35 AND dz.EXP_COMENT LIKE 'МЭК%'

DECLARE @tab TABLE (
	id INT, sumv DECIMAL(15,2), mekName NVARCHAR(500) ) 
	INSERT INTO @tab(id,sumv,mekName)
SELECT zsl.ID, zsl.SUMV, '' com 
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
LEFT JOIN M001_KSG m ON m.IDDS = sl.DS1 
WHERE zsl.D3_SCID = 35 and zsl.USL_OK in (3,4)
		and (zsl.OS_SLUCH_REGION is NULL OR zsl.OS_SLUCH_REGION not in (4,5,23)) AND m.Payable = 0
group by zsl.ID, zsl.SUMV
UPDATE D3_ZSL_OMS SET EXP_COMENT = 'МЭК -Неоплачиваемый код нозологии'
WHERE ID IN (SELECT id FROM @tab) 
GO

DECLARE @tab TABLE (
	id INT, sumv DECIMAL(15,2), mekName NVARCHAR(500) ) 
	INSERT INTO @tab(id,sumv,mekName)
Select zsl.ID, zsl.SUMV, '' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
where zsl.d3_SCID = 35 and (sl.DATE_1 > sl.DATE_2 or zsl.DATE_Z_1 > zsl.DATE_Z_2)
group by zsl.ID, zsl.SUMV
UPDATE D3_ZSL_OMS SET EXP_COMENT = 'МЭК -Дата начала лечения больше даты окончания.'
WHERE ID IN (SELECT id FROM @tab) 
GO

DECLARE @tab TABLE (
	id INT, sumv DECIMAL(15,2), mekName NVARCHAR(500) ) 
	INSERT INTO @tab(id,sumv,mekName)
select zsl.ID, zsl.SUMV, '' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
join D3_USL_OMS u on sl.ID = u.D3_SLID
where zsl.d3_SCID = 35 and (u.DATE_IN > sl.DATE_2 or u.DATE_OUT > sl.DATE_2 or u.DATE_IN > u.DATE_OUT 
							or u.DATE_IN > zsl.DATE_Z_2 or u.DATE_OUT > zsl.DATE_Z_2)
group by zsl.ID, zsl.SUMV
UPDATE D3_ZSL_OMS SET EXP_COMENT = 'МЭК -Некорректная дата в услуге.'
WHERE ID IN (SELECT id FROM @tab) 
GO

DECLARE @tab TABLE (
	id INT, sumv DECIMAL(15,2), mekName NVARCHAR(500) ) 
	INSERT INTO @tab(id,sumv,mekName)
select zsl.ID, zsl.SUMV, '' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
where zsl.d3_SCID = 35 and (sl.DATE_1<zsl.DATE_Z_1 or sl.DATE_2<zsl.DATE_Z_1 or sl.DATE_2>zsl.DATE_Z_2 or sl.DATE_1>zsl.DATE_Z_2)
		 and (zsl.OS_SLUCH_REGION not in (7,9,11,13,15,17,22) or zsl.OS_SLUCH_REGION is null)
group by zsl.ID, zsl.SUMV

UPDATE D3_ZSL_OMS SET EXP_COMENT = 'МЭК -Некорректная дата в случае.'
WHERE ID IN (SELECT id FROM @tab) 
GO

DECLARE @tab TABLE (
	id INT, sumv DECIMAL(15,2), mekName NVARCHAR(500) ) 
	INSERT INTO @tab(id,sumv,mekName)
SELECT u.ID, u.SUMV, '' com
FROM D3_ZSL_OMS zsl
JOIN D3_PACIENT_OMS pa on zsl.D3_PID = pa.ID
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
join ( SELECT zsl.id, zsl.SUMV, (CASE WHEN u.PROFIL in (2,3,136,137) THEN 990 ELSE u.PROFIL END) PROFIL, u.DATE_OUT, pa.FAM, pa.IM, pa.OT, pa.DR, u.d3_slid, u.ds, zsl.USL_OK, zsl.P_CEL, zsl.OS_SLUCH_REGION
	   FROM D3_USL_OMS u
	   join D3_SL_OMS sl on sl.id=u.d3_slid
	   join D3_ZSL_OMS zsl on sl.D3_ZSLID=zsl.id
	   join D3_PACIENT_OMS pa on pa.ID = zsl.D3_PID
	   where zsl.d3_SCID = 35 and sl.USL_OK =3 
	 ) as u on pa.FAM = u.FAM and pa.IM = u.IM and pa.OT = u.OT and pa.DR = u.DR and sl.DATE_2 = u.DATE_OUT and sl.ds1=u.ds
			   and (CASE WHEN sl.PROFIL in (2,3,136,137) THEN 990 ELSE sl.PROFIL END) = u.PROFIL 
			   and u.P_CEL<zsl.P_CEL and u.OS_SLUCH_REGION is null
where zsl.d3_SCID = 35 and sl.USL_OK =3 and zsl.OS_SLUCH_REGION is null and sl.id<>u.d3_slid
GROUP BY u.ID, u.SUMV, u.p_cel
union
SELECT zsl.ID, zsl.SUMV, '' com
FROM D3_ZSL_OMS zsl
JOIN D3_PACIENT_OMS pa on zsl.D3_PID = pa.ID
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
join ( SELECT zsl.id, zsl.SUMV, (CASE WHEN u.PROFIL in (2,3,136,137) THEN 990 ELSE u.PROFIL END) PROFIL, u.DATE_OUT, pa.FAM, pa.IM, pa.OT, pa.DR, u.d3_slid, u.ds, zsl.USL_OK, zsl.P_CEL, zsl.OS_SLUCH_REGION
	   FROM D3_USL_OMS u
	   join D3_SL_OMS sl on sl.id=u.d3_slid
	   join D3_ZSL_OMS zsl on sl.D3_ZSLID=zsl.id
	   join D3_PACIENT_OMS pa on pa.ID = zsl.D3_PID
	   where zsl.d3_SCID = 35 and sl.USL_OK =3 
	 ) as u on pa.FAM = u.FAM and pa.IM = u.IM and pa.OT = u.OT and pa.DR = u.DR and sl.DATE_2 = u.DATE_OUT and sl.ds1=u.ds
			   and (CASE WHEN sl.PROFIL in (2,3,136,137) THEN 990 ELSE sl.PROFIL END) = u.PROFIL 
			   and u.P_CEL<zsl.P_CEL and u.OS_SLUCH_REGION is not null
where zsl.d3_SCID = 35 and sl.USL_OK =3 and zsl.OS_SLUCH_REGION is null and sl.id<>u.d3_slid
GROUP BY zsl.ID, zsl.SUMV, u.p_cel

UPDATE D3_ZSL_OMS SET EXP_COMENT = 'МЭК -Перекрест случай услуга.'
WHERE ID IN (SELECT id FROM @tab) 
GO

DECLARE @tab TABLE (
	id INT, sumv DECIMAL(15,2), mekName NVARCHAR(500) ) 
	INSERT INTO @tab(id,sumv,mekName)
SELECT u.D3_ZSLID, u.SUMV, '' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
JOIN D3_PACIENT_OMS pa on zsl.D3_PID = pa.ID
join ( SELECT pa.FAM, pa.IM, pa.OT, pa.DR, sl.D3_ZSLID, sl.DATE_2, sl.ds1, sl.USL_OK, (CASE WHEN sl.PROFIL in (2,3,136,137) THEN 990 ELSE sl.PROFIL END) PROFIL, zsl.SUMV
	   FROM D3_SL_OMS sl
	   join D3_ZSL_OMS zsl on sl.D3_ZSLID=zsl.id
	   join D3_PACIENT_OMS pa on pa.ID = zsl.D3_PID
	   where zsl.d3_SCID = 35 and sl.USL_OK =3 and zsl.P_CEL like '1.%' and zsl.OS_SLUCH_REGION is null
	 ) as u on pa.FAM = u.FAM and pa.IM = u.IM and pa.OT = u.OT and pa.DR = u.DR and sl.DATE_2 = u.DATE_2 and sl.ds1=u.ds1
				and (CASE WHEN sl.PROFIL in (2,3,136,137) THEN 990 ELSE sl.PROFIL END)=u.PROFIL
where zsl.d3_SCID = 35 and sl.USL_OK =3 and zsl.id<>u.d3_zslid and zsl.P_CEL='3.0'
GROUP BY u.D3_ZSLID, u.SUMV
UPDATE D3_ZSL_OMS SET EXP_COMENT = 'МЭК -Перекрёст законченный случай - случай.'
WHERE ID IN (SELECT id FROM @tab) 
GO

DECLARE @tab TABLE (
	id INT, sumv DECIMAL(15,2), mekName NVARCHAR(500) ) 
	INSERT INTO @tab(id,sumv,mekName)
select zsl.ID, zsl.SUMV, 'Услуга оказана ранее случая.' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
join D3_USL_OMS u on sl.id = u.D3_SLID
where zsl.D3_SCID = 35 and OS_SLUCH_REGION is NULL and (u.DATE_IN < sl.DATE_1 or u.DATE_OUT < sl.DATE_1)
group by zsl.id, zsl.SUMV
UPDATE D3_ZSL_OMS SET EXP_COMENT = 'МЭК -Неккоректная дата услуги'
WHERE ID IN (SELECT id FROM @tab) 
GO

DECLARE @tab TABLE (
	id INT, sumv DECIMAL(15,2), mekName NVARCHAR(500) ) 
	INSERT INTO @tab(id,sumv,mekName)
select zsl.id, zsl.SUMV, '' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
WHERE zsl.D3_SCID = 35 and sl.USL_OK = 3 and OS_SLUCH_REGION is NULL and DATE_1 <> DATE_2
group by zsl.id, zsl.SUMV
UPDATE D3_ZSL_OMS SET EXP_COMENT = 'МЭК -Некорректные сроки посещения'
WHERE ID IN (SELECT id FROM @tab) 
GO

DECLARE @tab TABLE (
	id INT, sumv DECIMAL(15,2), mekName NVARCHAR(500) ) 
	INSERT INTO @tab(id,sumv,mekName)
select zsl.ID, zsl.SUMV, '' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
LEFT JOIN	(	SELECT l.*, ln.DATE_1, ln.DATE_2, ISNULL(ln.DATE_3, ln.DATE_2) DATE_3 
				FROM LIC_TBL l 
				JOIN LIC_NUM_TBL AS ln ON ln.ID = l.LIC_NUM_ID
			) l ON l.LPU = zsl.LPU AND l.USL_MP = zsl.USL_OK AND l.VID_MP = zsl.VIDPOM AND l.PROFIL = sl.PROFIL
					AND sl.DATE_1 >= l.DATE_1 AND sl.DATE_2 <= l.DATE_2 AND sl.DATE_2 <= l.DATE_3
where zsl.D3_SCID = 35 AND l.ID IS NULL and (zsl.OS_SLUCH_REGION not in (7,9,11,13,15,17,22, 37,38) or zsl.OS_SLUCH_REGION is null)
group by zsl.id, zsl.SUMV
UPDATE D3_ZSL_OMS SET EXP_COMENT = 'МЭК -Лицензии'
WHERE ID IN (SELECT id FROM @tab) 
GO

DECLARE @tab TABLE (
	id INT, sumv DECIMAL(15,2), mekName NVARCHAR(500) ) 
	INSERT INTO @tab(id,sumv,mekName)
--Соответствие профиля МП и спец. врача v021
SELECT  zsl.id, zsl.SUMV, '' com
--code_mo,zsl.id,sl.PROFIL, zsl.SUMV,sl.PRVS, v.*-- '''' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id 
join D3_SCHET_OMS sch on sch.id=zsl.D3_SCID 
LEFT JOIN V002_V021 v ON v.[IDPR_2] = sl.PROFIL AND v.[IDSPEC] = sl.PRVS
WHERE 
zsl.D3_SCID = 35 AND
 v.[IDPR_2] IS NULL 
 and PRVS not in (85,86,97,98,99,101) and PROFIL not in (158,160)
group by zsl.id, zsl.SUMV
UPDATE D3_ZSL_OMS SET EXP_COMENT = 'МЭК -Соответствие профиля МП и спец. врача'
WHERE ID IN (SELECT id FROM @tab) 
GO

DECLARE @tab TABLE (
	id INT, sumv DECIMAL(15,2), mekName NVARCHAR(500) ) 
	INSERT INTO @tab(id,sumv,mekName)
select zsl.ID, SUMV, 'Код МКБ10 только для профилактических случаев' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
WHERE zsl.D3_SCID =35 and sl.P_CEL25 in ('1.3','2.0','3.0') 
    and DS1 Like 'Z%' and DS1 not Like 'Z35%' and DS1 not Like 'Z03%' and DS1 not Like 'Z04%' and DS1 not Like 'Z05%'
     and DS1 not Like 'Z06%' and DS1 not Like 'Z07%' and DS1 not Like 'Z08%' and DS1 not Like 'Z09%' and DS1 not Like 'Z39%'
     and not DS1 between 'Z42' and 'Z99.9' and DATE_Z_2<='20180630'
group by zsl.id, SUMV
union
select zsl.ID, SUMV, 'Z96.1 может быть только типом случая <Заболевание>' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
WHERE zsl.D3_SCID =35 and sl.P_CEL25 not in ('1.3','3.0') and DS1 Like 'Z96.1' and DATE_Z_2<='20180630'
group by zsl.id, SUMV
union
select zsl.ID, zsl.SUMV, 'Код МКБ 10 не соответствует профилактическому случаю' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
where zsl.D3_SCID = 35 and sl.USL_OK = 3 and sl.P_CEL25 in ('1.1','1.2')
    and (DS1 like 'A%' or (DS1 like 'B%' and DS1 not like 'B18%' and DS1 not like 'B19%') or DS1 between 'J00' and 'J22.9') 
    and DATE_Z_2<='20180630'
group by zsl.id, zsl.SUMV
union
select zsl.ID, SUMV, 'Код МКБ10 только для профилактических случаев' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
WHERE zsl.D3_SCID =35 and sl.P_CEL25 in ('1.0','1.1','1.2','1.3','3.0') 
    and DS1 Like 'Z%' and DS1 not Like 'Z35%' and DS1 not Like 'Z03%' and DS1 not Like 'Z04%' and DS1 not Like 'Z05%'
     and DS1 not Like 'Z06%' and DS1 not Like 'Z07%' and DS1 not Like 'Z08%' and DS1 not Like 'Z09%' and DS1 not Like 'Z39%'
     and not DS1 between 'Z42' and 'Z99.9' and DATE_Z_2>'20180630'
group by zsl.id, SUMV
union
select zsl.ID, SUMV, 'Z96.1 может быть только типом случая <Заболевание>' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
WHERE zsl.D3_SCID =35 and sl.P_CEL25 not in ('1.0','3.0') and DS1 Like 'Z96.1' and DATE_Z_2>'20180630'
group by zsl.id, SUMV
union
select zsl.ID, zsl.SUMV, 'Код МКБ 10 не соответствует профилактическому случаю' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
where zsl.D3_SCID = 35 and sl.USL_OK = 3 and sl.P_CEL25 in ('3.1','2.1','2.6')
    and (DS1 like 'A%' or (DS1 like 'B%' and DS1 not like 'B18%' and DS1 not like 'B19%') or DS1 between 'J00' and 'J22.9') 
  and DATE_Z_2>'20180630'
group by zsl.id, zsl.SUMV
UPDATE D3_ZSL_OMS SET EXP_COMENT = 'МЭК -Соответствие кода МКБ10 цели посещения'
WHERE ID IN (SELECT id FROM @tab) 
GO

DECLARE @tab TABLE (
	id INT, sumv DECIMAL(15,2), mekName NVARCHAR(500) ) 
	INSERT INTO @tab(id,sumv,mekName)
--Посещение терапевта(код 97) оплачиваем >или=18лет в поликлинике и >=15 в стационаре, иначе МЭК 5.1.4

SELECT zsl.ID, zsl.SUMV, 'Некорректное выставление профиля' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
JOIN D3_PACIENT_OMS pa on zsl.D3_PID = pa.ID
where zsl.D3_SCID = 35 AND ((datediff(DAY, pa.DR, sl.DATE_2)/365.2524 < 18 AND sl.PROFIL = 97 and sl.usl_ok=3)
			or(datediff(DAY, pa.DR, sl.DATE_2)/365.2524 < 15 AND sl.PROFIL = 97 and sl.usl_ok in (1,2)))
group by zsl.ID, zsl.SUMV
UPDATE D3_ZSL_OMS SET EXP_COMENT = 'МЭК -Посещение терапевта <18 пол. , <16 стац.'
WHERE ID IN (SELECT id FROM @tab) 
GO

DECLARE @tab TABLE (
	id INT, sumv DECIMAL(15,2), mekName NVARCHAR(500) ) 
	INSERT INTO @tab(id,sumv,mekName)
--Посещение педиатра(код 68) оплачиваем <или=18лет, иначе МЭК 5.1.4. ИСКЛЮЧЕНИЕ беременные, они опл.

SELECT zsl.ID, zsl.SUMV, 'Некорректное выставление профиля' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
JOIN D3_PACIENT_OMS pa on zsl.D3_PID = pa.ID
where zsl.D3_SCID = 35 AND datediff(DAY, pa.DR, sl.DATE_2)/365.2524 >= 18 AND sl.PROFIL = 68
group by zsl.ID, zsl.SUMV
UPDATE D3_ZSL_OMS SET EXP_COMENT = 'МЭК -Посещение педиатра >17'
WHERE ID IN (SELECT id FROM @tab) 
GO

DECLARE @tab TABLE (
	id INT, sumv DECIMAL(15,2), mekName NVARCHAR(500) ) 
	INSERT INTO @tab(id,sumv,mekName)
select zsl.ID, zsl.SUMV, '' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
where zsl.D3_SCID = 35 and sl.VID_HMP is not null and zsl.VIDPOM <> 32
group by zsl.ID, zsl.SUMV
UPDATE D3_ZSL_OMS SET EXP_COMENT = 'МЭК -Неправильный вид помощи при наличии ВМП'
WHERE ID IN (SELECT id FROM @tab) 
GO

DECLARE @tab TABLE (
	id INT, sumv DECIMAL(15,2), mekName NVARCHAR(500) ) 
	INSERT INTO @tab(id,sumv,mekName)
--declare 35 int = 89

select zsl.ID, zsl.SUMV, '' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
JOIN D3_PACIENT_OMS pa on zsl.D3_PID = pa.ID
join v019 on v019.IDHM=sl.METOD_HMP and sl.DATE_2>=V019.DATEBEG and sl.DATE_2<=isnull(V019.DATEBEG,'20990101')
join dbo.CalcVmpTarif vmp ON vmp.IDGR = V019.HGR and (sl.DATE_2 >= vmp.TBEG and sl.DATE_2 < vmp.TEND +1) 
where zsl.D3_SCID = 35 and zsl.USL_OK = 1 and sl.VID_HMP is NOT NULL
		and SUMV <> CAST(ROUND(ISNULL(vmp.TARIF, 0) ,2) AS NUMERIC (10 ,2))
UPDATE D3_ZSL_OMS SET EXP_COMENT = 'МЭК -Проверка тарифов ВМП'
WHERE ID IN (SELECT id FROM @tab) 
GO

DECLARE @tab TABLE (
	id INT, sumv DECIMAL(15,2), mekName NVARCHAR(500) ) 
	INSERT INTO @tab(id,sumv,mekName)
select zsl.ID, zsl.SUMV, 'Мужские болезни у женщин' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
JOIN D3_PACIENT_OMS pa on zsl.D3_PID = pa.ID
where zsl.D3_SCID = 35 and pa.W=2  and ( ds1 in ('D07.4', 'D07.5', 'D07.6')
	or ds1 like 'C60%' or ds1 like 'C61%' or ds1 like 'C62%' or ds1 like 'C63%' or ds1 like 'D29%' or ds1 like 'D40%'
	or ds1 like 'E29%' or ds1 like 'Q53%' or ds1 like 'Q54%' or ds1 like 'Q55%' or ds1 like 'N41%' or ds1 like 'N42%'
	or ds1 like 'N43%' or ds1 like 'N44%' or ds1 like 'N45%' or ds1 like 'N46%' or ds1 like 'N47%' or ds1 like 'N48%'
	or ds1 like 'N49%' or ds1 like 'N50%' or ds1 like 'N51%' or ds1 like 'Q53%' or ds1 like 'Q54%' or ds1 like 'Q55%')	
group by zsl.ID, zsl.SUMV
union
select zsl.ID, zsl.SUMV, 'Женские болезни у мужчин' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
JOIN D3_PACIENT_OMS pa on zsl.D3_PID = pa.ID
where zsl.D3_SCID = 35 and pa.W=1  and (ds1 in ('C79.6', 'D07.1', 'D07.2', 'D07.3', 'D07.0', 'E28.0', 'Е28.2', 'E28.3', 'T28.8')
	or ds1 like 'C51%' or ds1 like 'C52%' or ds1 like 'C53%' or ds1 like 'C54%' or ds1 like 'C55%' or ds1 like 'C56%' 
	or ds1 like 'C57%' or ds1 like 'C58%' or ds1 like 'D06%' or ds1 like 'D25%' or ds1 like 'D26%' 
	or ds1 like 'D27%' or ds1 like 'D28%' or ds1 like 'D39%' or ds1 like 'N7%'  or ds1 like 'N8%'  or (ds1 like 'N9%' and  ds1 not like 'N99%')
	or ds1 like 'O%'   or ds1 like 'Q50%' or ds1 like 'Q51%' or ds1 like 'Q52%'
	or (ds1 like 'Z31%' and ds1 not like 'Z31.1.8' and ds1 not like 'Z31.1.9' and ds1 not like 'Z31.3%'	and
		ds1	not like 'Z31.4%' and ds1 not like 'Z31.5%' and ds1 not like 'Z31.6%')
	or ds1 like 'Z30%' or  ds1 like 'Z32%' or ds1 like 'Z33%' or ds1 like 'Z34%' or ds1 like 'Z35%'
	or ds1 like 'Z36%' or ds1 like 'Z37%' or ds1 like 'Z39%')
group by zsl.ID, zsl.SUMV
UPDATE D3_ZSL_OMS SET EXP_COMENT = 'МЭК -Соответствие диагноза полу.'
WHERE ID IN (SELECT id FROM @tab) 
GO

DECLARE @tab TABLE (
	id INT, sumv DECIMAL(15,2), mekName NVARCHAR(500) ) 
	INSERT INTO @tab(id,sumv,mekName)
select zsl.ID, zsl.SUMV, convert(nvarchar(3),isnull(zsl.os_sluch_region,'')) com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
join D3_USL_OMS u on sl.ID = u.D3_SLID
where zsl.D3_SCID = 35 and (u.DATE_IN is null or u.DATE_OUT is null) and ((zsl.os_sluch_region<>9 and zsl.os_sluch_region<>22) or zsl.os_sluch_region is null)
group by zsl.ID, zsl.SUMV, zsl.os_sluch_region
UPDATE D3_ZSL_OMS SET EXP_COMENT = 'МЭК -Пустая дата в услуге'
WHERE ID IN (SELECT id FROM @tab) 
GO

DECLARE @tab TABLE (
	id INT, sumv DECIMAL(15,2), mekName NVARCHAR(500) ) 
	INSERT INTO @tab(id,sumv,mekName)
select zsl.ID, zsl.SUMV, 'ХНИЗ допускаются только в III-а группе здоровья.' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
where zsl.D3_SCID = 35 and zsl.OS_SLUCH_REGION in (22,23) and sl.profil in (57,97)	  
	  and RSLT in (317,318, 352,353,356,358)
	  and (DS1 between 'I00' and 'I99.9' or DS1 between 'J40' and 'J99.9' or DS1 between 'C00' and 'C99.9' 
	  		or DS1 between 'E10' and 'E14.9')
group by zsl.ID, zsl.SUMV
union
select zsl.ID, zsl.SUMV, 'III-а группа здоровья допускается только при ХНИЗ.' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
where zsl.D3_SCID = 35 and zsl.OS_SLUCH_REGION in (22,23) and sl.profil in (57,97)	 
	  and RSLT in (355,357)
	  and not (DS1 between 'I00' and 'I99.9' or DS1 between 'J40' and 'J99.9' or DS1 between 'C00' and 'C99.9' 
	  			or DS1 between 'E10' and 'E14.9')
group by zsl.ID, zsl.SUMV
UPDATE D3_ZSL_OMS SET EXP_COMENT = 'МЭК -Проверка ДВН. ХНИЗ и III-а гр. здоровья'
WHERE ID IN (SELECT id FROM @tab) 
GO

DECLARE @tab TABLE (
	id INT, sumv DECIMAL(15,2), mekName NVARCHAR(500) ) 
	INSERT INTO @tab(id,sumv,mekName)
SELECT zsl.ID, zsl.SUMV, '' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
WHERE sl.IT_SL >= 1.8 and zsl.D3_SCID=35
group by zsl.ID, zsl.SUMV
UPDATE D3_ZSL_OMS SET EXP_COMENT = 'МЭК -КСЛП >= 1.8'
WHERE ID IN (SELECT id FROM @tab) 
GO

DECLARE @tab TABLE (
	id INT, sumv DECIMAL(15,2), mekName NVARCHAR(500) ) 
	INSERT INTO @tab(id,sumv,mekName)
SELECT zsl.ID, zsl.SUMV, '' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
WHERE sl.usl_ok<>1 and sl.IT_SL>1 and zsl.D3_SCID=35
group by zsl.ID, zsl.SUMV
UPDATE D3_ZSL_OMS SET EXP_COMENT = 'МЭК -Применение КСЛП в стационарозамещениии'
WHERE ID IN (SELECT id FROM @tab) 
GO

DECLARE @tab TABLE (
	id INT, sumv DECIMAL(15,2), mekName NVARCHAR(500) ) 
	INSERT INTO @tab(id,sumv,mekName)
Select zsl.ID, zsl.SUMV, '' com 
FROM D3_ZSL_OMS zsl
Where zsl.d3_SCID = 35 and zsl.OS_SLUCH_REGION = 23 
		and zsl.ID not in (	Select t1.ID 
							From (	Select zsl.ID, pa.FAM, pa.IM, pa.OT, pa.DR 
									FROM D3_ZSL_OMS zsl
									Join D3_PACIENT_OMS pa on zsl.d3_PID = pa.ID
									Where zsl.d3_SCID = 35 and zsl.OS_SLUCH_REGION = 23
								 ) as t1
							Join (	Select pa.FAM, pa.IM, pa.OT, pa.DR 
									FROM D3_ZSL_OMS zsl
									Join D3_PACIENT_OMS pa on zsl.d3_PID = pa.ID
									Where zsl.OS_SLUCH_REGION = 22
								 ) as t2  on t1.FAM = t2.FAM and t1.IM = t2.IM and t1.OT = t2.OT and t1.DR = t2.DR
						  )
GROUP BY zsl.ID, zsl.SUMV
UPDATE D3_ZSL_OMS SET EXP_COMENT = 'МЭК -Проверка 1-го этапа ДВН при наличии 2-го. '
WHERE ID IN (SELECT id FROM @tab) 
GO

DECLARE @tab TABLE (
	id INT, sumv DECIMAL(15,2), mekName NVARCHAR(500) ) 
	INSERT INTO @tab(id,sumv,mekName)
Select zsl.ID, zsl.SUMV, '' com 
FROM D3_ZSL_OMS zsl
Where zsl.d3_SCID = 35 and zsl.OS_SLUCH_REGION = 12
		and zsl.ID not in (	Select t1.ID 
							From (	Select zsl.ID, pa.FAM, pa.IM, pa.OT, pa.DR, DATE_Z_2, npolis 
									FROM D3_ZSL_OMS zsl
									Join D3_PACIENT_OMS pa on zsl.d3_PID = pa.ID
									Where zsl.d3_SCID = 35 and zsl.OS_SLUCH_REGION = 12
								 ) as t1
							Join (	Select pa.FAM, pa.IM, pa.OT, pa.DR, DATE_Z_1, npolis
									FROM D3_ZSL_OMS zsl
									Join D3_PACIENT_OMS pa on zsl.d3_PID = pa.ID
									Where zsl.OS_SLUCH_REGION = 11
								 ) as t2  on ((t1.FAM = t2.FAM and t1.IM = t2.IM and t1.OT = t2.OT and t1.DR = t2.DR) or (t2.NPOLIS=t1.NPOLIS)) and cast(t1.DATE_Z_2-t2.DATE_Z_1 as int)<=45
						  )
GROUP BY zsl.ID, zsl.SUMV
UPDATE D3_ZSL_OMS SET EXP_COMENT = 'МЭК -Проверка 1-го этапа ПО детей при наличии 2-го.'
WHERE ID IN (SELECT id FROM @tab) 
GO

DECLARE @tab TABLE (
	id INT, sumv DECIMAL(15,2), mekName NVARCHAR(500) ) 
	INSERT INTO @tab(id,sumv,mekName)
SELECT zsl.ID, zsl.SUMV, 'Не заполнена цель посещения' com 
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
WHERE zsl.D3_SCID = 35 and zsl.USL_OK = 3 and OS_SLUCH_REGION is null--not in (7,8,9,11,12,13,14,15,16,17,18,22,23)
		and sl.P_CEL25 is null
group by zsl.ID, zsl.SUMV
UPDATE D3_ZSL_OMS SET EXP_COMENT = 'МЭК -Корректность заполнения АПП'
WHERE ID IN (SELECT id FROM @tab) 
GO

DECLARE @tab TABLE (
	id INT, sumv DECIMAL(15,2), mekName NVARCHAR(500) ) 
	INSERT INTO @tab(id,sumv,mekName)
select zsl.ID, zsl.SUMV, 'Некорректный результат ДВН, возможны только коды 317,318,352,353,355,356,357,358' com
FROM D3_ZSL_OMS zsl
WHERE zsl.D3_SCID = 35 and zsl.OS_SLUCH_REGION in (22,37,38) and (zsl.RSLT not in (317,318,352,353,355,356,357,358) or zsl.RSLT is null)
union
select zsl.ID, zsl.SUMV, 'Некорректный профиль ДВН, должен быть 57 или 97' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
WHERE zsl.D3_SCID = 35 and zsl.OS_SLUCH_REGION = 22 and sl.PROFIL not in (57,97)
union
select zsl.ID, zsl.SUMV, 'Некорректная специализация ДВН, должен быть 16 или 27' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
WHERE zsl.D3_SCID = 35 and zsl.OS_SLUCH_REGION = 22 and sl.PRVS15 not in (16,27)
union
select zsl.ID, zsl.SUMV, 'Некорректный код оплаты ДВН, должен быть 11' com
FROM D3_ZSL_OMS zsl
WHERE zsl.D3_SCID = 35 and zsl.OS_SLUCH_REGION in (22,37,38) and IDSP <>11
union
select zsl.ID, zsl.SUMV, 'Некорректный исход ДВН, должен быть 306' com
FROM D3_ZSL_OMS zsl
WHERE zsl.D3_SCID = 35 and zsl.OS_SLUCH_REGION in (22,37,38) and ISHOD<>306
union
select zsl.ID, zsl.SUMV, 'Некорректныйвид МП в ДВН, должен быть 3' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
WHERE zsl.D3_SCID = 35 and zsl.OS_SLUCH_REGION in (22,37,38) and sl.usl_ok<>3
union
SELECT zsl.ID, zsl.SUMV, 'Даты начала дисп. и услуги "Опрос(анкетирование)" должны совпадать' com 
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
join D3_USL_OMS u on sl.id = u.D3_SLID
WHERE zsl.D3_SCID = 35 AND zsl.OS_SLUCH_REGION = 22
		AND CAST(u.DATE_IN AS DATE) <> CAST(zsl.DATE_Z_1 AS DATE) AND u.VID_VME = 'A01.30.026'
group by zsl.id, zsl.SUMV
UNION
SELECT zsl.ID, zsl.SUMV, 'Даты услуг "Антропометрия" и "Опрос(анкетирование)" должны совпадать' com 
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
join D3_USL_OMS u on sl.id = u.D3_SLID
WHERE zsl.D3_SCID = 35 AND zsl.OS_SLUCH_REGION = 22
		AND CAST(u.DATE_IN AS DATE) <> CAST(zsl.DATE_Z_1 AS DATE) AND u.VID_VME = 'A02.07.004'
group by zsl.id, zsl.SUMV
UNION
SELECT zsl.ID, zsl.SUMV, 'Услуги: "Опрос(анкетирование)", "Антропометрия", "Прием(осмотр) врача-терапевта" не могут быть "проведенными ранее"' com 
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
join D3_USL_OMS u on sl.id = u.D3_SLID
WHERE zsl.D3_SCID = 35 AND zsl.OS_SLUCH_REGION = 22
		AND u.VID_VME IN ('A01.30.026','A02.07.004','022.00.020') AND u.NPL = 4
group by zsl.id, zsl.SUMV
UNION
SELECT zsl.ID, zsl.SUMV, 'Услуги: "Опрос(анкетирование)", "Антропометрия", "Прием(осмотр) врача-терапевта" не могут быть "отказанными"' com 
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
join D3_USL_OMS u on sl.id = u.D3_SLID
WHERE zsl.D3_SCID = 35 AND zsl.OS_SLUCH_REGION = 22
		AND u.VID_VME IN ('A01.30.026','A02.07.004','022.00.020') AND u.P_OTK = 1
group by zsl.id, zsl.SUMV
UNION
SELECT zsl.ID, zsl.SUMV, 'Услуга "Опрос(анкетирование)" должна быть первой по дате' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
join D3_USL_OMS u on sl.id = u.D3_SLID
JOIN	(	SELECT sl.ID, MIN(CAST(u.DATE_IN AS DATE)) mindate
			FROM D3_ZSL_OMS zsl
			join D3_SL_OMS sl on sl.d3_zslid=zsl.id
			join D3_USL_OMS u on sl.id = u.D3_SLID
			WHERE zsl.D3_SCID = 35 AND zsl.OS_SLUCH_REGION = 22 AND u.NPL is null
			GROUP BY sl.ID
		) minusl ON sl.ID = minusl.ID
WHERE zsl.D3_SCID = 35 AND zsl.OS_SLUCH_REGION = 22
		AND u.VID_VME = 'A01.30.026' AND CAST(u.DATE_IN AS DATE) > minusl.mindate
group by zsl.id, zsl.SUMV

UPDATE D3_ZSL_OMS SET EXP_COMENT = 'МЭК -Корректность заполнения ДВН (22)'
WHERE ID IN (SELECT id FROM @tab) 
GO

DECLARE @tab TABLE (
	id INT, sumv DECIMAL(15,2), mekName NVARCHAR(500) ) 
	INSERT INTO @tab(id,sumv,mekName)
select zsl.ID, zsl.SUMV, '' com 
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
where zsl.d3_SCID = 35 and OS_SLUCH_REGION in (7,9,11,13,15,17) 
		and (sl.USL_OK <> 3 or IDSP <> 11 or sl.P_CEL <> '1.1')
GROUP BY zsl.ID, zsl.SUMV
UNION
SELECT zsl.ID, zsl.SUMV, 'Некорректное заполнение поля "Результат обращения"' + ' код: ' + Convert(nvarchar (3),RSLT) com 
FROM D3_ZSL_OMS zsl
WHERE zsl.D3_SCID = 35 AND zsl.OS_SLUCH_REGION = 9 AND zsl.RSLT NOT IN (343,344,345)
UNION
SELECT zsl.ID, zsl.SUMV, 'Некорректное заполнение поля "Результат обращения"' + ' код: ' + Convert(nvarchar (3),RSLT) com 
FROM D3_ZSL_OMS zsl
WHERE zsl.D3_SCID = 35 AND zsl.OS_SLUCH_REGION IN (7,8) AND zsl.RSLT NOT IN (321,322,323,324,325)
UNION
SELECT zsl.ID, zsl.SUMV, 'Некорректное заполнение поля "Результат обращения"' + ' код: ' + Convert(nvarchar (3),RSLT) com 
FROM D3_ZSL_OMS zsl
WHERE zsl.D3_SCID = 35 AND zsl.OS_SLUCH_REGION IN (17,18) AND zsl.RSLT NOT IN (347,348,349,350,351)
UNION
SELECT zsl.ID, zsl.SUMV, 'Некорректное заполнение поля "Результат обращения"' + ' код: ' + Convert(nvarchar (3),RSLT) com 
FROM D3_ZSL_OMS zsl
WHERE zsl.D3_SCID = 35 AND zsl.OS_SLUCH_REGION IN (11,12) AND zsl.RSLT NOT IN (332,333,334,335,336)
UNION
SELECT zsl.ID, zsl.SUMV, 'Некорректное заполнение поля "Результат обращения"' + ' код: ' + Convert(nvarchar (3),RSLT) com 
FROM D3_ZSL_OMS zsl
WHERE zsl.D3_SCID = 35 AND zsl.OS_SLUCH_REGION IN (13,14) AND zsl.RSLT NOT IN (337,338,339,340,341,342)
UNION
SELECT zsl.ID, zsl.SUMV, 'Некорректное заполнение поля "Результат обращения"' + ' код: ' + Convert(nvarchar (3),RSLT) com 
FROM D3_ZSL_OMS zsl
WHERE zsl.D3_SCID = 35 AND zsl.OS_SLUCH_REGION = 15 AND zsl.RSLT <> 342
UNION
SELECT zsl.ID, zsl.SUMV, 'Некорректное заполнение поля "Результат обращения"' + ' код: ' + Convert(nvarchar (3),RSLT) com 
FROM D3_ZSL_OMS zsl
WHERE zsl.D3_SCID = 35 AND zsl.OS_SLUCH_REGION = 23 AND zsl.RSLT in (319,354)
union
SELECT zsl.ID, zsl.SUMV, 'Некорректное заполнение поля "ДВ 2-й этап. Результат обращения при терапевте"' + ' код: ' + Convert(nvarchar (3),RSLT) com 
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
WHERE zsl.D3_SCID = 35 AND zsl.OS_SLUCH_REGION = 23 AND zsl.RSLT NOT IN (317,318,355,356) and sl.profil in (57,97)
group by zsl.id, zsl.SUMV, RSLT
--UNION
--SELECT zsl.ID, zsl.SUMV, 'Некорректное заполнение поля "ДВ 2-й этап. Результат обращения узкий специалист"' + ' код: ' + Convert(nvarchar (3),RSLT) com 
--FROM D3_ZSL_OMS zsl
--join D3_SL_OMS sl on sl.d3_zslid=zsl.id
--WHERE zsl.D3_SCID = 35 AND zsl.OS_SLUCH_REGION = 23 AND zsl.RSLT<>314 and sl.profil not in (57,97)
--group by zsl.id, zsl.SUMV, RSLT

UPDATE D3_ZSL_OMS SET EXP_COMENT = 'МЭК -Корректность заполнения полей медосмотров.'
WHERE ID IN (SELECT id FROM @tab) 
GO

DECLARE @tab TABLE (
	id INT, sumv DECIMAL(15,2), mekName NVARCHAR(500) ) 
	INSERT INTO @tab(id,sumv,mekName)
--Проверка услуги более 12 мес
select zsl.ID, zsl.SUMV, 'Услуга оказана более 12 месяцев назад.' com 
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
join D3_USL_OMS u on sl.id = u.D3_SLID
where zsl.D3_SCID = 35 and zsl.OS_SLUCH_REGION in(7,9,11,13,15,17,22) and u.NPL = 4 and 
	  (datediff(day, u.DATE_OUT,  sl.DATE_2)>365 and u.VID_VME not like 'A06.09.006%'  
	  	and u.VID_VME not like 'A06.20.004' and u.VID_VME not like 'A08.20.017%')
group by zsl.id, zsl.SUMV
union
--Проверка флюорографии
select zsl.ID, zsl.SUMV, 'Флюорография сделана более 24 месяцев назад.' com 
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
join D3_USL_OMS u on sl.id = u.D3_SLID
where zsl.D3_SCID = 35 and zsl.OS_SLUCH_REGION in(7,9,11,13,15,17,22) and u.NPL = 4 and 
	  datediff(day, u.DATE_OUT,  sl.DATE_2)>730 and u.VID_VME like 'A06.09.006%'
group by zsl.id, zsl.SUMV
union
--Проверка маммографии
select zsl.ID, zsl.SUMV, 'Маммография сделана более 24 месяцев назад.' com 
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
join D3_USL_OMS u on sl.id = u.D3_SLID
where zsl.D3_SCID = 35 and zsl.OS_SLUCH_REGION in(7,9,11,13,15,17,22) and u.NPL = 4 and 
	  datediff(day, u.DATE_OUT,  sl.DATE_2)>730 and u.VID_VME like 'A06.20.004'

group by zsl.id, zsl.SUMV
union
--Проверка соскоба матки
select zsl.ID, zsl.SUMV, 'Получение мазка с шейки матки (цервикального мазка) было более 3 лет назад' com 
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
join D3_USL_OMS u on sl.id = u.D3_SLID
where zsl.D3_SCID = 35 and zsl.OS_SLUCH_REGION in(7,9,11,13,15,17,22) and u.NPL = 4 and
	  datediff(day, u.DATE_OUT,  sl.DATE_2)>1096 and u.CODE_USL like 'A08.20.017%' 
group by zsl.id, zsl.SUMV

UPDATE D3_ZSL_OMS SET EXP_COMENT = 'МЭК -Сроки оказания услуг в диспансеризации и ПО'
WHERE ID IN (SELECT id FROM @tab) 
GO

DECLARE @tab TABLE (
	id INT, sumv DECIMAL(15,2), mekName NVARCHAR(500) ) 
	INSERT INTO @tab(id,sumv,mekName)
select zsl.ID, zsl.SUMV, '' com
FROM D3_ZSL_OMS zsl
where zsl.D3_SCID = 35 and  OS_SLUCH_REGION in (7,17)	and DATEDIFF(DAY, zsl.DATE_Z_1, zsl.DATE_Z_2) > 14
UPDATE D3_ZSL_OMS SET EXP_COMENT = 'МЭК -Контроль сроков проведения диспансеризации детей'
WHERE ID IN (SELECT id FROM @tab) 
GO

DECLARE @tab TABLE (
	id INT, sumv DECIMAL(15,2), mekName NVARCHAR(500) ) 
	INSERT INTO @tab(id,sumv,mekName)
Select zsl.ID, zsl.SUMV, '' com
from	(	Select pa.FAM, pa.IM, pa.OT, pa.DR, sl.DATE_1, sl.DATE_2, sl.PROFIL 
			FROM D3_ZSL_OMS zsl
			join D3_SL_OMS sl on sl.d3_zslid=zsl.id
			join D3_PACIENT_OMS pa on pa.ID = zsl.D3_PID
			where zsl.D3_SCID = 35 and OS_SLUCH_REGION in (7,17)
		) zsl_os
JOIN	(	Select pa.FAM, pa.IM, pa.OT, pa.DR, sl.DATE_1, sl.DATE_2, sl.PROFIL, zsl.ID, zsl.SUMV
			FROM D3_ZSL_OMS zsl
			join D3_SL_OMS sl on sl.d3_zslid=zsl.id
			join D3_PACIENT_OMS pa on pa.ID = zsl.D3_PID
			where zsl.D3_SCID = 35 and OS_SLUCH_REGION is null and sl.P_CEL = '1.1' and sl.PROFIL not in (16)/*игнорируемые профили*/
		) zsl on zsl.DATE_2 = zsl_os.DATE_2 and zsl.DATE_1 = zsl_os.DATE_1 and zsl_os.profil=zsl.profil
				and zsl_os.FAM = zsl.FAM and zsl_os.IM = zsl.IM and zsl_os.OT = zsl.OT and zsl_os.DR = zsl.DR
group by zsl.id, zsl.SUMV
UPDATE D3_ZSL_OMS SET EXP_COMENT = 'МЭК -Перекрест проф. посещеня и диспансеризации сирот(опека)'
WHERE ID IN (SELECT id FROM @tab) 
GO

DECLARE @tab TABLE (
	id INT, sumv DECIMAL(15,2), mekName NVARCHAR(500) ) 
	INSERT INTO @tab(id,sumv,mekName)
select zsl.ID, zsl.SUMV, 'Z00.0 у ребёнка' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
join D3_PACIENT_OMS pa on pa.ID = zsl.D3_PID
where zsl.D3_SCID = 35 and sl.USL_OK = 3 
	  and DATEDIFF(YEAR,dr,DATE_2) +(SIGN(DATEDIFF(DAY,dr,DATEADD(YEAR,YEAR(dr)-YEAR(DATE_2),DATE_2)))-1)/2<18 
	  and sl.DS1 = 'Z00.0'
group by zsl.id, zsl.SUMV
union
select zsl.ID, zsl.SUMV, 'Z00.1 не используется у детей более 3 лет' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
join D3_PACIENT_OMS pa on pa.ID = zsl.D3_PID
where zsl.D3_SCID = 35 and sl.USL_OK = 3 
	  and DATEDIFF(YEAR,dr,DATE_2) +(SIGN(DATEDIFF(DAY,dr,DATEADD(YEAR,YEAR(dr)-YEAR(DATE_2),DATE_2)))-1)/2>3 
	  and sl.DS1 = 'Z00.1'
group by zsl.id, zsl.SUMV
union
select zsl.ID, zsl.SUMV, 'Z00.2 используется у детей от 3 до 12 лет' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
join D3_PACIENT_OMS pa on pa.ID = zsl.D3_PID
where zsl.D3_SCID = 35 and sl.USL_OK = 3 
	  and DATEDIFF(YEAR,dr,DATE_2) +(SIGN(DATEDIFF(DAY,dr,DATEADD(YEAR,YEAR(dr)-YEAR(DATE_2),DATE_2)))-1)/2<3
	  and DATEDIFF(YEAR,dr,DATE_2) +(SIGN(DATEDIFF(DAY,dr,DATEADD(YEAR,YEAR(dr)-YEAR(DATE_2),DATE_2)))-1)/2>12	  
	  and sl.DS1 = 'Z00.2'
group by zsl.id, zsl.SUMV
union
select zsl.ID, zsl.SUMV, 'Z00.3 используется у детей от 12 до 17 лет' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
join D3_PACIENT_OMS pa on pa.ID = zsl.D3_PID
where zsl.D3_SCID = 35 and sl.USL_OK = 3 
	  and DATEDIFF(YEAR,dr,DATE_2) +(SIGN(DATEDIFF(DAY,dr,DATEADD(YEAR,YEAR(dr)-YEAR(DATE_2),DATE_2)))-1)/2<12
	  and DATEDIFF(YEAR,dr,DATE_2) +(SIGN(DATEDIFF(DAY,dr,DATEADD(YEAR,YEAR(dr)-YEAR(DATE_2),DATE_2)))-1)/2>17	  
	  and sl.DS1 = 'Z00.3'
group by zsl.id, zsl.SUMV
union
select zsl.ID, zsl.SUMV, 'Z00 у пациента не 1 группы здоровья' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id and sl.PROFIL in (57,97)
where zsl.D3_SCID = 35 and OS_SLUCH_REGION in (1,7,9,11,17,22) 
		and RSLT not in (317,321,327,332,337,343,347) and sl.DS1 in ('Z00.0','Z00.1','Z00.2','Z00.3')
group by zsl.id, zsl.SUMV
UPDATE D3_ZSL_OMS SET EXP_COMENT = 'МЭК -Использование  Z00'
WHERE ID IN (SELECT id FROM @tab) 
GO

DECLARE @tab TABLE (
	id INT, sumv DECIMAL(15,2), mekName NVARCHAR(500) ) 
	INSERT INTO @tab(id,sumv,mekName)
select zsl.ID, zsl.SUMV, ' в '+OS.Name 
FROM D3_ZSL_OMS zsl
join OsobSluchDb os on os.Id=zsl.OS_SLUCH_REGION
where zsl.D3_SCID = 35 and zsl.OS_SLUCH_REGION in (1,7,9,11,17,22,15,13) and (zsl.SUMV=0 or zsl.SUMV is null)
group by zsl.ID, zsl.SUMV, os.Name
UPDATE D3_ZSL_OMS SET EXP_COMENT = 'МЭК -Нулеваой тариф в осмотрах'
WHERE ID IN (SELECT id FROM @tab) 
GO

