			
--declare @p1 int =278			
Select --distinct zs.ID, zs.SUMV,'' com
--��� ������� ��������������� ����� 
 sch.id, sch.schettype,zs.ID, zs.SUMV,'' com ,s.nhistory,ksg.n_ksg,v023.NameWithID,DS1_T,ds_onk			
FROM [D3_SCHET_OMS] sch			
join D3_PACIENT_OMS p on p.d3_scid=sch.id 			
			AND  sch.year=2020 AND sch.month=8--sch.id=319-- AND sch.code_mo=460061

			--and sch.id=@p1
join D3_ZSL_OMS zs on zs.D3_PID=p.id AND zs.usl_ok IN (1,2) --AND p.smo=46006			
join D3_SL_OMS s on s.D3_ZSLID=zs.ID			
left join D3_KSG_KPG_OMS ksg on ksg.D3_SLID=s.id			
left join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id--	AND DS1_T IN (0,1,2)		
left join D3_ONK_USL_OMS ou on ou.D3_ONKSLID=onk.id			
left join v023 on v023.K_KSG=ksg.n_ksg and s.date_2 between v023.DATEBEG and isnull(v023.DATEEND,'20201231')			
where  ou.id is null-- and	ds_onk=0		
--group by zs.ID, zs.SUMV,s.nhistory,ksg.n_ksg,v023.NameWithID	
		
and (
            (
                      (ksg.n_ksg like 'st19%' 
			          or ksg.n_ksg like 'st08%'
		            	or ksg.n_ksg like 'ds08%'
			           or ksg.n_ksg like 'ds19%')
                                      and v023.[N_KSG] not like '%������ ���� �������%'
			 ) 
			 
			 or zs.vidpom=32 
	 ) --����� ������ ������� 


