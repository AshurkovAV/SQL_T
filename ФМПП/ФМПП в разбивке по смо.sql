DECLARE @year INT=2020				
 DECLARE @month1 INT=1				
 DECLARE @month2 INT=9				
 DECLARE @m_cod INT = 460026				
--АПП не стоматология				
 SELECT 				
		nam_mok,smo,		
		PRNAME [Профиль медицинской помощи],		
				
	--	code_mo,		
				
		CASE 		
		WHEN [CEL]='1.1' THEN 'НЕОТЛОЖКА АПП'		
		WHEN  ( (CEL LIKE '1%' AND CEL NOT LIKE '1.1')		
			    OR 	CEL IN ('2.1','2.5','2.6')
			    AND    OS_SLUCH_REGION IS NULL	
		       ) 		
		       OR		
		      OS_SLUCH_REGION in (29,35,48,23,12,18)  THEN 'ПРОФИЛАКТИКА АПП'		
		      		
		WHEN 		
		(		
			(CEL = '3.0' and OS_SLUCH_REGION is null)	
		or 		
		    OS_SLUCH_REGION in (6,21,30,31,32,33,34,36,39,40) 		
		OR 		
		    (ms like 'R03') --телеконсультации		
		)		
		 then 'ЗАБОЛЕВАНИЯ АПП'		
		WHEN (cel='2.3' AND ms LIKE 'R01'		
			)THEN 'ИССЛЕДОВАНИЯ'	
		ELSE NULL 		
		END [Цель],		
		COUNT(id) [кол-во оплач сл],		
		COUNT(CASE WHEN idsp IN (25,36) THEN id END) [в том числе по подушевому нормативу],		
	--	SUM(KD_Z) [койко-дни],		
		SUM(sump)/1000 [тыс.руб],		
		COUNT(case when pr_det=1 then id end) [кол-во оплач сл дети],		
		COUNT(case when pr_det=1 and idsp IN (25,36) then id end) [в том числе кол-во оплач по подушевому нормативу сл дети],		
	--	isnull(SUM(case when pr_det=1 then KD_Z end),0) [койко-дни дети],		
		isnull(SUM(case when pr_det=1 then sump end)/1000,0) [тыс.руб дети]		
 FROM 				
 ( 				
 SELECT				
		DISTINCT		
		LEFT(usl.CODE_USL,3) ms,		
		v002.PRNAME ,		
		case when p.smo like '46%' then smo else 'in' end smo,		
		--sch.year,		
		--SCH.[MONTH],		
		--sch.code_mo,		
	    f3.nam_mok,			
		zs.id,		
		zs.usl_ok,		
			zs.OS_SLUCH_REGION,	
		v6.[UMPNAME],		
		sl.P_CEL25 [CEL],		
		case when zs.idsp in (25,36) then 0 else  		
		     case when zs.sump IS NULL THEN sumv ELSE sump  END		
		                                  end sump,		
		zs.idsp,		
		CASE WHEN 	[dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1)	<=17 THEN 1 ELSE 0 END pr_det
		------------		
		--,sl.profil		
		--,substring(sl.ds1,1,3) ds		
		--,sch.month		
		--,sch.code_mo		
	FROM [D3_SCHET_OMS] sch			
		inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
		inner join D3_ZSL_OMS zs on zs.D3_PID=p.id	AND (zs.OS_SLUCH_REGION IS NULL OR zs.OS_SLUCH_REGION NOT IN (4,5,7,11,17,9,22,37,38,47,49))	
		inner join D3_SL_OMS sl on sl.D3_ZSLID=zs.ID AND profil not IN (85,86,87,88,89,90,140,171)		
		LEFT JOIN [D3_USL_OMS] usl on usl.D3_SLID=sl.id 		
		--LEFT JOIN medicalServices AS ms ON ms.code_usl=usl.CODE_USL		
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
		and zs.usl_ok in (3)		
		--and sl.profil in (42)		
		--and sl.ds1 between 'C81' and 'C96.z' --- онкогематология		
		-----------		
		and sank.[ID] is NULL		
		AND sch.code_mo=@m_cod		
	)	t		
 GROUP BY PRNAME ,smo,				
	--	code_mo,		
	    nam_mok,			
				
		      		
		CASE 		
		WHEN [CEL]='1.1' THEN 'НЕОТЛОЖКА АПП'		
		WHEN  ( (CEL LIKE '1%' AND CEL NOT LIKE '1.1')		
			    OR 	CEL IN ('2.1','2.5','2.6')
			    AND    OS_SLUCH_REGION IS NULL	
		       ) 		
		       OR		
		      OS_SLUCH_REGION in (29,35,48,23,12,18)  THEN 'ПРОФИЛАКТИКА АПП'		
		      		
		WHEN 		
		(		
			(CEL = '3.0' and OS_SLUCH_REGION is null)	
		or 		
		    OS_SLUCH_REGION in (6,21,30,31,32,33,34,36,39,40) 		
		OR 		
		    (ms like 'R03') --телеконсультации		
		)		
		 then 'ЗАБОЛЕВАНИЯ АПП'		
		WHEN (cel='2.3' AND ms LIKE 'R01'		
			)THEN 'ИССЛЕДОВАНИЯ'	
		ELSE NULL 		
		END		
