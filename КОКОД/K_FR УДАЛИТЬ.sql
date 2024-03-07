
begin TRAN --commit tran
--rollback
declare @p1 int =3920			
UPDATE onk SET k_fr=null
--Select --distinct zs.ID, zs.SUMV,'' com
--при лечении онкозаболеваний стоит 
-- sch.id, sch.schettype,zs.ID, S.ID, SOD, usl_TIP, onk.K_FR
FROM [D3_SCHET_OMS] sch			
join D3_PACIENT_OMS p on p.d3_scid=sch.id 			
			and sch.year=2022 and sch.month=1 
			--and sch.id=@p1
join D3_ZSL_OMS zs on zs.D3_PID=p.id AND zs.usl_ok IN (1,2) --AND p.smo=46006			
join D3_SL_OMS s on s.D3_ZSLID=zs.ID			
left join D3_KSG_KPG_OMS ksg on ksg.D3_SLID=s.id			
left join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id  --AND DS1_T IN (0,1,2)		
 join D3_ONK_USL_OMS ou on ou.D3_ONKSLID=onk.id	
		
where 
 ZS.ID=3953590 AND s.id=3977021 --AND SOD IS NULL