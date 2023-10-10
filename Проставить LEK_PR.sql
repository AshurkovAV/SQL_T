declare @p1 int = 20263


insert into D3_LEK_PR_COV_OMS (D3_SLID, D3_SLGID, DATA_INJ,   CODE_SH, REG_NUM, ED_IZM, DOSE_INJ, METHOD_INJ, COL_INJ)
select                         sl.ID,   sl.SL_ID, sl.DATE_1,  '1-1-1', '001004', 129,    3000.00,         19,			5		
--select                         sl.ID,   sl.SL_ID, sl.DATE_1,  '1-1-1', '002166', 10,    200,        2,			28
--select zsl.id, lek_cov.*
FROM [D3_SCHET_OMS] sch                  
	inner join D3_PACIENT_OMS p on p.d3_scid=sch.id and sch.ID = @p1
		inner join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id
			inner join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID
				left join D3_LEK_PR_COV_OMS lek_cov on lek_cov.D3_SLID = sl.ID 
				left join D3_KSG_KPG_OMS KsgKpg on KsgKpg.D3_SLID=sl.id
					left join D3_CRIT_OMS Crit on Crit.D3_KSGID=ksgkpg.id
WHERE
	lek_cov.ID is  null
	and isnull(sl.REAB,0) <> 1 
	and sch.SchetType like  'H%'
	and sl.DS1 in ('U07.1','U07.2')
	and
		(
			(
				isnull(Crit.[CRIT],'') <> 'STT5'
				and zsl.USL_OK = 1
			)
			or 
			(
				zsl.USL_OK = 3
				and 
				(
					(
						(zsl.IDSP = 29) 
						and zsl.FOR_POM = 3
					) 
					or
					(
						sl.P_CEL25 = '1.0'
						or sl.P_CEL25 = '3.0'
					)
				)
			)
		)

	and not 
		(
		EXISTS
			(	select dss.DS
				from D3_DSS_OMS dss 
				where 
					sl.id=dss.D3_SLID
					and dss.DS_TYPE = 2 
					and  
						(
							dss.DS between 'O00' and 'O99.z'
							or dss.DS between 'Z34' and 'Z35.z'
						)
			)
		)
	and dbo.f_GetAge(p.DR,sl.DATE_1)>=18
	--AND zsl.ID = 1179591
	AND zsl.EXP_COMENT LIKE '%тсутствует тег LEK_PR%'
-------------------------------------------------


insert into D3_LEK_PR_COV_OMS (D3_SLID, D3_SLGID, DATA_INJ,   CODE_SH, REG_NUM, ED_IZM, DOSE_INJ, METHOD_INJ, COL_INJ)
--select                         sl.ID,   sl.SL_ID, sl.DATE_1,  '1-1-1', '001004', 16,    10,         19,			1		
select                         sl.ID,   sl.SL_ID, sl.DATE_1,  '1-1-6', '001663', 10,    0.50,        2,			1

FROM [D3_SCHET_OMS] sch                  
	inner join D3_PACIENT_OMS p on p.d3_scid=sch.id and sch.ID = @p1
		inner join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id
			inner join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID
				left join D3_LEK_PR_COV_OMS lek_cov on lek_cov.D3_SLID = sl.ID 
				left join D3_KSG_KPG_OMS KsgKpg on KsgKpg.D3_SLID=sl.id
					left join D3_CRIT_OMS Crit on Crit.D3_KSGID=ksgkpg.id
WHERE
	lek_cov.ID is  not null
	and isnull(sl.REAB,0) <> 1 
	and sch.SchetType like  'H%'
	and sl.DS1 in ('U07.1','U07.2')
	and
		(
			(
				isnull(Crit.[CRIT],'') <> 'STT5'
				and zsl.USL_OK = 1
			)
			or 
			(
				zsl.USL_OK = 3
				and 
				(
					(
						(zsl.IDSP = 29) 
						and zsl.FOR_POM = 3
					) 
					or
					(
						sl.P_CEL25 = '1.0'
						or sl.P_CEL25 = '3.0'
					)
				)
			)
		)

	and not 
		(
		EXISTS
			(	select dss.DS
				from D3_DSS_OMS dss 
				where 
					sl.id=dss.D3_SLID
					and dss.DS_TYPE = 2 
					and  
						(
							dss.DS between 'O00' and 'O99.z'
							or dss.DS between 'Z34' and 'Z35.z'
						)
			)
		)
	and dbo.f_GetAge(p.DR,sl.DATE_1)>=18
	--AND zsl.ID = 1179591
	and lek_cov.REG_NUM = 001004
	AND zsl.EXP_COMENT LIKE '%тсутствует тег LEK_PR%'
	--------------------------------------------------
	
	insert into D3_LEK_PR_COV_OMS (D3_SLID, D3_SLGID, DATA_INJ,   CODE_SH, REG_NUM, ED_IZM, DOSE_INJ, METHOD_INJ, COL_INJ)
--select                         sl.ID,   sl.SL_ID, sl.DATE_1,  '1-1-1', '001004', 16,    10,         19,			1		
select                         sl.ID,   sl.SL_ID, sl.DATE_1,  '1-1-3', '001882', 10,    10.00,        2,			1

FROM [D3_SCHET_OMS] sch                  
	inner join D3_PACIENT_OMS p on p.d3_scid=sch.id and sch.ID = @p1
		inner join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id
			inner join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID
				left join D3_LEK_PR_COV_OMS lek_cov on lek_cov.D3_SLID = sl.ID 
				left join D3_KSG_KPG_OMS KsgKpg on KsgKpg.D3_SLID=sl.id
					left join D3_CRIT_OMS Crit on Crit.D3_KSGID=ksgkpg.id
WHERE
	lek_cov.ID is  not null
	and isnull(sl.REAB,0) <> 1 
	and sch.SchetType like  'H%'
	and sl.DS1 in ('U07.1','U07.2')
	and
		(
			(
				isnull(Crit.[CRIT],'') <> 'STT5'
				and zsl.USL_OK = 1
			)
			or 
			(
				zsl.USL_OK = 3
				and 
				(
					(
						(zsl.IDSP = 29) 
						and zsl.FOR_POM = 3
					) 
					or
					(
						sl.P_CEL25 = '1.0'
						or sl.P_CEL25 = '3.0'
					)
				)
			)
		)

	and not 
		(
		EXISTS
			(	select dss.DS
				from D3_DSS_OMS dss 
				where 
					sl.id=dss.D3_SLID
					and dss.DS_TYPE = 2 
					and  
						(
							dss.DS between 'O00' and 'O99.z'
							or dss.DS between 'Z34' and 'Z35.z'
						)
			)
		)
	and dbo.f_GetAge(p.DR,sl.DATE_1)>=18
	--AND zsl.ID = 1179591
	AND ( lek_cov.REG_NUM = 001004 or lek_cov.REG_NUM = 001663)
	AND zsl.EXP_COMENT LIKE '%тсутствует тег LEK_PR%'
	------------------------------------------------
	
	
	insert into D3_LEK_PR_COV_OMS (D3_SLID, D3_SLGID, DATA_INJ,   CODE_SH, REG_NUM, ED_IZM, DOSE_INJ, METHOD_INJ, COL_INJ)
--select                         sl.ID,   sl.SL_ID, sl.DATE_1,  '1-1-1', '001004', 16,    10,         19,			1		
select                         sl.ID,   sl.SL_ID, sl.DATE_1,  '1-1-1', '002983', 10,    1600.00,        2,			2

FROM [D3_SCHET_OMS] sch                  
	inner join D3_PACIENT_OMS p on p.d3_scid=sch.id and sch.ID = @p1
		inner join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id
			inner join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID
				left join D3_LEK_PR_COV_OMS lek_cov on lek_cov.D3_SLID = sl.ID 
				left join D3_KSG_KPG_OMS KsgKpg on KsgKpg.D3_SLID=sl.id
					left join D3_CRIT_OMS Crit on Crit.D3_KSGID=ksgkpg.id
WHERE
	lek_cov.ID is  not null
	and isnull(sl.REAB,0) <> 1 
	and sch.SchetType like  'H%'
	and sl.DS1 in ('U07.1','U07.2')
	and
		(
			(
				isnull(Crit.[CRIT],'') <> 'STT5'
				and zsl.USL_OK = 1
			)
			or 
			(
				zsl.USL_OK = 3
				and 
				(
					(
						(zsl.IDSP = 29) 
						and zsl.FOR_POM = 3
					) 
					or
					(
						sl.P_CEL25 = '1.0'
						or sl.P_CEL25 = '3.0'
					)
				)
			)
		)

	and not 
		(
		EXISTS
			(	select dss.DS
				from D3_DSS_OMS dss 
				where 
					sl.id=dss.D3_SLID
					and dss.DS_TYPE = 2 
					and  
						(
							dss.DS between 'O00' and 'O99.z'
							or dss.DS between 'Z34' and 'Z35.z'
						)
			)
		)
	and dbo.f_GetAge(p.DR,sl.DATE_1)>=18
	--AND zsl.ID = 1179591
	--AND ( lek_cov.REG_NUM = 001004 AND lek_cov.REG_NUM = 001663 AND lek_cov.REG_NUM =  001882)
	AND zsl.EXP_COMENT LIKE '%тсутствует тег LEK_PR%'