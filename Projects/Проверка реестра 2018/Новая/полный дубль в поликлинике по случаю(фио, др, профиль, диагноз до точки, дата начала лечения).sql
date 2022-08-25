--полный дубль в поликлинике по случаю(фио, др, профиль, диагноз до точки, дата начала лечения)кроме онко, опц и обл
declare @p1 int=2127
UPDATE dzo SET dzo.D3_SCID = 2133, dzo.EXP_COMENT = 'полный дубль в поликлинике по случаю(фио, др, профиль, диагноз до точки, дата начала лечения)'
--SELECT *
FROM D3_ZSL_OMS AS dzo
WHERE id IN (
SELECT DISTINCT MAX (k.ID) AS ID 
	--,k.SUMV,'' com
FROM 
	(SELECT DISTINCT zsl.id AS ID
	--,sl.id
	,pa.FAM, pa.IM, pa.OT, pa.DR , sl.DATE_1, DATE_2, zsl.LPU, zsl.SUMV,sl.profil,SUBSTRING(sl.ds1,1,3) as ds --,oplata
	 FROM D3_ZSL_OMS zsl
	 JOIN D3_SL_OMS sl ON zsl.id=sl.D3_ZSLID AND OS_SLUCH_REGION IS NULL 
											AND isnull(zsl.MEK_COUNT,0)=0 
											AND zsl.USL_OK in (3) 
		join D3_PACIENT_OMS pa on pa.ID = zsl.D3_PID and pa.D3_SCID=@p1
		join(
	    
			--ищем полные дубли
			select pa.FAM, pa.IM, pa.OT, pa.DR
				, DATE_1,zsl.lpu
				, sl.profil,SUBSTRING(sl.ds1,1,3) as ds
				FROM D3_ZSL_OMS zsl
				join D3_SL_OMS sl on zsl.id=sl.D3_ZSLID and  OS_SLUCH_REGION is null and isnull(zsl.MEK_COUNT,0)=0 
				join D3_PACIENT_OMS pa on pa.ID = zsl.D3_PID and zsl.USL_OK in (3) 
											    and pa.D3_SCID=@p1
												 and sl.profil not in (85,86,87,88,89,90,140,171)
				join D3_SCHET_OMS sch on sch.id=pa.D3_SCID    and sch.CODE_MO not in (460039,460061,460003)                             
			group by      pa.FAM, pa.IM, pa.OT, pa.DR
				, DATE_1 ,zsl.lpu    
				,  sl.profil,SUBSTRING(sl.ds1,1,3) 
				having count(*)>1
			 
				) t    on pa.FAM=t.FAM    
						and pa.IM=t.IM        
						and pa.ot=t.ot
						and pa.dr=t.dr
						and sl.DATE_1=t.DATE_1
						and sl.profil=t.profil
						and zsl.lpu=t.lpu
						and SUBSTRING(sl.ds1,1,3)=t.ds
					
				--order by  pa.FAM, pa.IM, pa.OT, pa.DR
		)k
	group by
		k.FAM    
		,k.IM        
		,k.ot
		,k.dr
		,k.DATE_1
		,k.profil
		,k.lpu
		,k.ds
		,k.SUMV
		)