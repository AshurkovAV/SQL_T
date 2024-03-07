--BEGIN TRAN 
UPDATE zs SET zs.D3_SCID=686,zs.pr_nov=1
--UPDATE p SET p.D3_SCID=686
--SELECT d.* ,zs.D3_SCID,p.D3_SCID
FROM 
temp_0720_perep d
inner join D3_ZSL_OMS zs on zs.ZSL_ID=d.ZSL_ID
--INNER JOIN [D3_SCHET_OMS] sch ON d.d3_scid =sch.id                  
  inner join D3_PACIENT_OMS p on  zs.D3_PID=p.id  
WHERE d.schettype='H'
  --COMMIT TRAN
  
 --SELECT * FROM  perepadjaFebruary
 RETURN
 --для поиска случаев в базе фонда
 select distinct zsl_id,sch.schettype
into temp_0720_perep
	--sch.id,p.fam,p.im,p.ot,p.dr,sl.ds1,sl.NHISTORY,DATE_Z_1,DATE_Z_2,usl.date_in,usl.CODE_USL,sumv,sump,zs.pr_nov,sa.s_osn,sa.s_com
FROM [D3_SCHET_OMS] sch
		inner join [D3_PACIENT_OMS] p on sch.id=p.[D3_SCID]
									
		inner join [D3_ZSL_OMS] zs on p.id=zs.[D3_PID]
		inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]
		left join D3_USL_OMS usl on usl.D3_SLID=sl.id 
		join d3_sank_oms sa on sa.D3_ZSLID=zs.id
	where sch.code_mo=460061 and sch.month=7 
	--and code_usl like 'R01.001.003%' 
	and p.smo=46007
