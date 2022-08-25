 DECLARE @year INT=2020				
 DECLARE @month1 INT=1 				
 DECLARE @month2 INT=9				
 DECLARE @usl_ok INT=1		
 SELECT nam_mok [МО],				
        PRNAME [Профиль медицинской помощи],smo,				
		COUNT(id) [кол-во оплач сл],		
		SUM(KD_Z) [койко-дни],		
		SUM(sump)/1000 [тыс.руб],		
		COUNT(case when pr_det=1 then id end) [кол-во оплач сл дети],		
		isnull(SUM(case when pr_det=1 then KD_Z end),0) [койко-дни дети],		
		isnull(SUM(case when pr_det=1 then sump end)/1000,0) [тыс.руб дети]		
 FROM 				
 ( 				
 SELECT				
		distinct		
		v002.PRNAME ,		
		case when p.smo like '46%' then smo else 'in' end smo,		
		--sch.year,		
		--SCH.[MONTH],		
		--sch.code_mo,		
		f3.nam_mok,		
		zs.id,		
		zs.usl_ok,		
		v6.[UMPNAME],		
		--sl.P_CEL25 [CEL],		
		case when zs.sump IS NULL THEN sumv ELSE sump END sump,		
		zs.KD_Z	,	
		CASE WHEN 	[dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1)	<=17 THEN 1 ELSE 0 END pr_det
		------------		
		--,sl.profil		
		--,substring(sl.ds1,1,3) ds		
		--,sch.month		
		--,sch.code_mo		
	FROM [ELMEDICINENEWFOND].[dbo].[D3_SCHET_OMS] sch			
		inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
		inner join D3_ZSL_OMS zs on zs.D3_PID=p.id		
				
		--AND [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1)	<=17	
		inner join D3_SL_OMS sl on sl.D3_ZSLID=zs.ID		
		-------		
		------химиотерапия		
		-- join D3_ONK_SL_OMS OnkSl on OnkSl.D3_SLID=sl.id         		
          -- join D3_ONK_USL_OMS OnkUsl on OnkUsl.D3_ONKSLID=OnkSl.ID AND OnkUsl.USL_TIP=2				
           -----				
		left join [ELMEDICINENEWFOND].[dbo].[D3_SANK_OMS] sank 		
				on sank.[D3_ZSLID]=zs.id
				and sank.s_tip=1
		left join [V006] v6 on v6.[IDUMP]=zs.usl_ok		
		LEFT JOIN v002 ON v002.IDPR=sl.PROFIL		
		left join f003 f3 on f3.mcod=sch.code_mo		
	where 			
		sch.[YEAR]=@year		
		and sch.month between @month1 and @month2		
		----		
		and zs.usl_ok in (@usl_ok)		
		--and sl.profil in (12)		
		--and sl.ds1 between 'C81' and 'C96.z' --- онкогематология		
		-----------		
		and sank.[ID] is NULL		
		AND sch.code_mo=460026		
	)	t		
 GROUP BY nam_mok,PRNAME,smo				
 				
 				
 -- DECLARE @year INT=2019				
 --DECLARE @month1 INT=1 				
 --DECLARE @month2 INT=4				
 SELECT  nam_mok [МО],				
          PRNAME [Профиль медицинской помощи],smo,				
         'в том числе химиотерапия',				
		COUNT(id) [кол-во оплач сл],		
		SUM(KD_Z) [койко-дни],		
		SUM(sump)/1000 [тыс.руб],		
		COUNT(case when pr_det=1 then id end) [кол-во оплач сл дети],		
		isnull(SUM(case when pr_det=1 then KD_Z end),0) [койко-дни дети],		
		isnull(SUM(case when pr_det=1 then sump end)/1000,0) [тыс.руб дети]		
 FROM 				
 ( 				
 SELECT				
		distinct		
		v002.PRNAME ,		
		case when p.smo like '46%' then smo else 'in' end smo,		
		--sch.year,		
		--SCH.[MONTH],		
		--sch.code_mo,		
		f3.nam_mok,		
		zs.id,		
		zs.usl_ok,		
		v6.[UMPNAME],		
		--sl.P_CEL25 [CEL],		
		zs.sump,		
		zs.KD_Z	,	
		CASE WHEN 	[dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1)	<=17 THEN 1 ELSE 0 END pr_det
		------------		
		--,sl.profil		
		--,substring(sl.ds1,1,3) ds		
		--,sch.month		
		--,sch.code_mo		
	FROM [ELMEDICINENEWFOND].[dbo].[D3_SCHET_OMS] sch			
		inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
		inner join D3_ZSL_OMS zs on zs.D3_PID=p.id		
				
				
		inner join D3_SL_OMS sl on sl.D3_ZSLID=zs.ID		
		-------		
		------химиотерапия		
		 join D3_ONK_SL_OMS OnkSl on OnkSl.D3_SLID=sl.id         		
           join D3_ONK_USL_OMS OnkUsl on OnkUsl.D3_ONKSLID=OnkSl.ID AND OnkUsl.USL_TIP=2				
           -----				
		left join [ELMEDICINENEWFOND].[dbo].[D3_SANK_OMS] sank 		
				on sank.[D3_ZSLID]=zs.id
				and sank.s_tip=1
		left join [V006] v6 on v6.[IDUMP]=zs.usl_ok		
		LEFT JOIN v002 ON v002.IDPR=sl.PROFIL		
		left join f003 f3 on f3.mcod=sch.code_mo		
	where 			
		sch.[YEAR]=@year		
		and sch.month between @month1 and @month2		
		----		
		and zs.usl_ok in (@usl_ok)		
		and sl.profil in (60,18)		
		--and sl.ds1 between 'C81' and 'C96.z' --- онкогематология		
		-----------		
		and sank.[ID] is NULL		
		AND sch.code_mo=460026		
	)	t		
 GROUP BY nam_mok,PRNAME,smo				
 				
 				
 -- DECLARE @year INT=2019				
 --DECLARE @month1 INT=1 				
 --DECLARE @month2 INT=4				
 SELECT nam_mok [МО],				
        PRNAME [Профиль медицинской помощи],smo,				
         'в том числе онкогематология',				
		COUNT(id) [кол-во оплач сл],		
		SUM(KD_Z) [койко-дни],		
		SUM(sump)/1000 [тыс.руб],		
		COUNT(case when pr_det=1 then id end) [кол-во оплач сл дети],		
		isnull(SUM(case when pr_det=1 then KD_Z end),0) [койко-дни дети],		
		isnull(SUM(case when pr_det=1 then sump end)/1000,0) [тыс.руб дети]		
 FROM 				
 ( 				
 SELECT				
		distinct		
		v002.PRNAME ,		
		case when p.smo like '46%' then smo else 'in' end smo,		
		--sch.year,		
		--SCH.[MONTH],		
		--sch.code_mo,		
		f3.nam_mok,		
		zs.id,		
		zs.usl_ok,		
		v6.[UMPNAME],		
		--sl.P_CEL25 [CEL],		
		zs.sump,		
		zs.KD_Z	,	
		CASE WHEN 	[dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1)	<=17 THEN 1 ELSE 0 END pr_det
		------------		
		--,sl.profil		
		--,substring(sl.ds1,1,3) ds		
		--,sch.month		
		--,sch.code_mo		
	FROM [ELMEDICINENEWFOND].[dbo].[D3_SCHET_OMS] sch			
		inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
		inner join D3_ZSL_OMS zs on zs.D3_PID=p.id		
				
		--AND [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1)	<=17	
		inner join D3_SL_OMS sl on sl.D3_ZSLID=zs.ID		
		-------		
		------химиотерапия		
		-- join D3_ONK_SL_OMS OnkSl on OnkSl.D3_SLID=sl.id         		
          -- join D3_ONK_USL_OMS OnkUsl on OnkUsl.D3_ONKSLID=OnkSl.ID AND OnkUsl.USL_TIP=2				
           -----				
		left join [ELMEDICINENEWFOND].[dbo].[D3_SANK_OMS] sank 		
				on sank.[D3_ZSLID]=zs.id
				and sank.s_tip=1
		left join [V006] v6 on v6.[IDUMP]=zs.usl_ok		
		LEFT JOIN v002 ON v002.IDPR=sl.PROFIL		
		left join f003 f3 on f3.mcod=sch.code_mo		
	where 			
		sch.[YEAR]=@year		
		and sch.month between @month1 and @month2		
		----		
		and zs.usl_ok in (@usl_ok)		
		and sl.profil in (12)		
		and sl.ds1 between 'C81' and 'C96.z' --- онкогематология		
		-----------		
		and sank.[ID] is NULL		
		AND sch.code_mo=460026		
	)	t		
 GROUP BY nam_mok,PRNAME,smo				
