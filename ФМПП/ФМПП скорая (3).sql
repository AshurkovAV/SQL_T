DECLARE @year INT=2019
 DECLARE @month1 INT=1 
 DECLARE @month2 INT=12
 SELECT nam_mok [МО],
        PRNAME [Профиль медицинской помощи],
        FRMMPNAME,
		COUNT(id) [кол-во оплач сл],
		COUNT(CASE WHEN idsp IN (36) THEN id END) [в том числе по подушевому нормативу],
	--	SUM(KD_Z) [койко-дни],
		SUM(sump)/1000 [тыс.руб],
		COUNT(case when pr_det=1 then id end) [кол-во оплач сл дети],
		COUNT(case when pr_det=1 and idsp IN (36) then id end) [в том числе кол-во оплач по подушевому нормативу сл дети],
	--	isnull(SUM(case when pr_det=1 then KD_Z end),0) [койко-дни дети],
		isnull(SUM(case when pr_det=1 then sump end)/1000,0) [тыс.руб дети]
		
 FROM 
 ( 
 SELECT
		distinct								
		v002.PRNAME ,
		--sch.year,
		--SCH.[MONTH],
		--sch.code_mo,
		f3.nam_mok,
		zs.id,								
		zs.usl_ok,	
		v6.[UMPNAME],	
		--sl.P_CEL25 [CEL],					
		case when idsp in (25,36) then 0 else  
		     case when zs.sump IS NULL THEN sumv ELSE sump  END
		                                  end sump,
		zs.idsp,
		v014.FRMMPNAME,
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
		left join [ELMEDICINENEWFOND].[dbo].[D3_SANK_OMS] sank 								
				on sank.[D3_ZSLID]=zs.id						
				and sank.s_tip=1	
		left join [V006] v6 on v6.[IDUMP]=zs.usl_ok	
		LEFT JOIN v002 ON v002.IDPR=sl.PROFIL	
		left join f003 f3 on f3.mcod=sch.code_mo	
		left join v014 on v014.IDFRMMP=zs.FOR_POM				
	where 
		sch.[YEAR]=@year					
		and sch.month between @month1 and @month2							
		----
			AND p.SMO NOT LIKE '46%'
		and zs.usl_ok in (4)
		AND sch.code_mo=460013
		-----------
		and sank.[ID] is NULL
	)	t
 GROUP BY nam_mok,PRNAME,FRMMPNAME
 
 

