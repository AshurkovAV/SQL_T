	declare @pp1 int = 2348
DECLARE @tab TABLE (
	id INT, sumv DECIMAL(15,2), mekName NVARCHAR(500) ) 
	INSERT INTO @tab(id,sumv,mekName)
	 
	select distinct t1.id as ID, t1.SUMV as SUMV, 'перекрест поликлиники зак случай с другим зак сл' com
	from
	(select  distinct zsl.id, pa.FAM, pa.IM, pa.OT, pa.DR
	, DATE_z_1, DATE_z_2
	, zsl.LPU, zsl.SUMV, sl.profil,SUBSTRING(sl.ds1,1,3) as ds
	FROM D3_ZSL_OMS zsl
	join D3_SL_OMS sl on zsl.id=sl.D3_ZSLID
	join D3_PACIENT_OMS pa on pa.ID = zsl.D3_PID and zsl.USL_OK in (3) and isnull(zsl.MEK_COUNT,0)=0 and pa.D3_SCID=@pp1
	

	)as t1 --все случаи поликлиники из данного счета
	inner 	join (select  zsl.id as id, pa.FAM, pa.IM, pa.OT, pa.DR,SUBSTRING(sl.ds1,1,3) as ds
	, DATE_Z_1, DATE_Z_2, 
	zsl.LPU, zsl.SUMV, sl.profil
					FROM D3_ZSL_OMS zsl
						join D3_PACIENT_OMS pa on pa.ID = zsl.D3_PID
													--and pa.D3_SCID=@pp1
													 and isnull(zsl.MEK_COUNT,0)=0 
													 and zsl.USL_OK = 3
						join D3_SL_OMS sl on zsl.id=sl.D3_ZSLID

			     ) as t2 on t1.FAM=t2.FAM
			             and t1.im=t2.im
			             and t1.ot=t2.ot
			             and t1.dr=t2.dr
			             and (
						 (t1.DATE_z_1>=t2.DATE_Z_1 and t1.DATE_z_1<=t2.DATE_Z_2) or (t2.DATE_z_1>=t1.DATE_Z_1 and t2.DATE_Z_1<=t1.DATE_Z_2)
						      )
						 and t1.id<>t2.id
						 and t1.PROFIL=t2.PROFIL

						 and t1.ds=t2.ds

UPDATE D3_ZSL_OMS SET EXP_COMENT = 'перекрест поликлиники зак случай с другим зак сл.'
WHERE ID IN (SELECT id FROM @tab) 
GO