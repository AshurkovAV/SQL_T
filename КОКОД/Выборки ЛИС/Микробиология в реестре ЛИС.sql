--микробиология в реестре
SELECT distinct
		p.fam,p.im,isnull(p.ot,'') ot
		,p.W as [Пол]
		,p.DR 
		, p.NPOLIS as [Полис]
		, zs.DATE_Z_1 [дата начала]
		, zs.DATE_Z_2 
		,u.code_usl
	    ,ms.name  [рег именование]
		,u.VID_VME
	    , y.name [фед] 
FROM [D3_SCHET_OMS] sch                  
		inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
		inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 
		--AND sch.month<3
		AND sch.YEAR=2023  
		and sch.id in (11837)			--реестр подан
		join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
		JOIN D3_USL_OMS u ON u.D3_SLID=s.id
		join V009 rz on rz.IDRMP=zs.RSLT
		left join F011 doc on doc.Id=p.DOCTYPE
		LEFT JOIN f003 ON f003.mcod=zs.NPR_MO
		JOIN medicalServices AS ms ON ms.code_usl=u.CODE_USL AND u.DATE_IN >=ms.dataBegin AND u.DATE_OUT<=ISNULL(ms.dataEnd,'20991231') AND ms.code_usl  BETWEEN 'R01.001.008' AND 'R01.001.036'
		left join Yamed_Spr_UslCode y on y.ID=u.vid_vme	    
JOIN (	    
Select distinct
	--s.iddokt,u.CODE_MD
/*		sch.SchetType as [Тип счета],sch.id as schet_id,sch.month, zs.NPR_DATE, zs.NPR_MO, f003.nam_mok
	,sch.month as [Месяц]
		,sch.YEAR[Год]
		,case when p.smo like '46%' then p.smo else '46' end as [Плательщик]
		, p.SMO as [Страховая компания],*/
		 p1.fam,p1.im,isnull(p1.ot,'') ot
		,p1.W as [Пол]
		,p1.DR 
		/*, convert(nvarchar(150),(case when p.DOCTYPE=14  then 'Паспорт РФ'
		when p.DOCTYPE=3 then 'Св-во о рождении'
		else doc.DocName end)) + ' ' + convert(nvarchar,(p.DOCSER)) + ' ' + convert(nvarchar,(p.DOCNUM)) as [Данные документа удостоверяющего личность]*/
		, p1.NPOLIS as [Полис]
		--, p.SNILS as [Снилс]
		, zs1.DATE_Z_1 [дата начала]
		, zs1.DATE_Z_2 
		-- , zs.VIDPOM as [Вид помощи]
		--, zs.USL_OK as [Условия оказания мед. помощи],

		--zs.id, zs.SUMV as [Стоимость оказанной мед. помощи]
		--,zs.RSLT AS [Результат]
		--, zs.ISHOD
		-- ,zs.PR_NOV [признак переподачи]
		--, count (u.id)
	-- , cast(u.id as varchar) + ','
	,u1.code_usl
	,ms1.name  [рег именование]
		,u1.VID_VME
	, y1.name [фед] 


	FROM [D3_SCHET_OMS] sch1                  
		inner join D3_PACIENT_OMS p1 on p1.d3_scid=sch1.id
		inner join D3_ZSL_OMS zs1 on zs1.D3_PID=p1.id AND sch1.code_mo=460061 
		--AND sch.month<3
		AND sch1.YEAR=2023  
		and sch1.id in (11837)			--реестр подан
		join D3_SL_OMS s1 on s1.D3_ZSLID=zs1.ID 
		JOIN D3_USL_OMS u1 ON u1.D3_SLID=s1.id
		join V009 rz1 on rz1.IDRMP=zs1.RSLT
		left join F011 doc1 on doc1.Id=p1.DOCTYPE
		LEFT JOIN f003 ON f003.mcod=zs1.NPR_MO
		JOIN medicalServices AS ms1 ON ms1.code_usl=u1.CODE_USL AND u1.DATE_IN >=ms1.dataBegin AND u1.DATE_OUT<=ISNULL(ms1.dataEnd,'20991231') AND ms1.code_usl  BETWEEN 'R01.001.008' AND 'R01.001.036'
		left join Yamed_Spr_UslCode y1 on y1.ID=u1.vid_vme
WHERE ms1.name LIKE '27%'                  --микробиология
GROUP BY p1.fam, p1.im, p1.ot
		,p1.W 
		,p1.DR
		,p1.DOCTYPE, p1.NPOLIS,  zs1.DATE_Z_1 
		, zs1.DATE_Z_2 
		,u1.code_usl
	,ms1.name  
		,u1.VID_VME
	, y1.name 
HAVING COUNT(*)>1	
--ORDER BY p.fam
) t  ON  t.fam = p.FAM  AND t.im = p.im AND t.ot = p.ot AND t.VID_VME = u.vid_vme 	 
ORDER BY p.fam