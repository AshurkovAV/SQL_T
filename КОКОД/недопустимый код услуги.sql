declare @p1 int =562
Select distinct zs.id as ID, zs.sumv as SUMV, '' com ,zs.lpu, u.VID_VME,u.CODE_USL,s.profil

FROM [D3_SCHET_OMS] sch                  
	inner join D3_PACIENT_OMS p 
		on p.d3_scid=sch.id --and sch.month=2 AND sch.year=2019
     and sch.id=@p1 --and sch.code_mo not like '460061'
	inner join D3_ZSL_OMS zs on zs.D3_PID=p.id
	INNER join D3_SL_OMS s on s.D3_ZSLID=zs.ID  
	INNER join   D3_USL_OMS u on u.D3_SLID=s.id  
	------
	left join Yamed_Spr_UslCode usl on usl.id=u.CODE_USL
where  
	usl.id IS NULL --AND sch.[YEAR]=2020 AND sch.month=1
--group by zs.id, zs.SUMV