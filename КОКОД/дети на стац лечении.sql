select --sch.month,sl.VID_HMP ,v018.[HVIDNAME],zs.usl_ok,											
	sch.YEAR[Год],sch.month as [Месяц],sch.nschet,zs.usl_ok,k.name,										
 -- case when p.smo like '46%' then f002.nam_smok else '46' end as [Плательщик]											
  p.fam,p.im,isnull(p.ot,'') ot,  [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) [возраст]											
 -- p.SMO as [Страховая компания]											
   ,zs.DATE_Z_1 [дата начала]											
  , zs.DATE_Z_2 [дата окончания],sl.VID_HMP,ds1,v018.[HVIDNAME], v019.HMNAME											
 --, sumv, sump, sank.S_OSN, sank.S_COM, sank.S_SUM											
											
FROM [D3_SCHET_OMS] sch    											
    inner join [D3_PACIENT_OMS] p on sch.id=p.[D3_SCID]											
    inner join [D3_ZSL_OMS] zs on p.id=zs.[D3_PID]											
    inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]											
    LEFT JOIN D3_SANK_OMS AS sank ON sank.D3_ZSLID=zs.id AND sank. S_TIP=1											
	left join v018 on v018.[IDHVID]=sl.VID_HMP and sl.date_2 between v018.datebeg and isnull(v018.DATEEND, '20221231')										
	left join[V019] v019 on cast(v019.IDHM as int)=sl.metod_hmp  										
				   --------------------------------с 21 года----------------							
				                              and 							
											cast(case when year(zs.date_z_2)=2020 then v019.IDMODP else  sl.MP_HMP end as nvarchar) =cast(v019.IDMODP as nvarchar)
											and sl.VID_HMP=HVID
											
									   AND zs.DATE_z_2>=v019.DATEBEG		
									   AND zs.DATE_z_2<=isnull(v019.dateend,'21000101')		
	LEFT JOIN f002 ON f002.smocod=p.SMO										
	left join KOKOD_OTD k on k.kod_otd=sl.podr										
  where sch.code_mo=460061   											
        and (sch.year=2022)-- AND sch.month=4)  											
      --and zs.vidpom=32											
     -- AND sch.id IN (4016, 4205, 5444, 5682, 6904, 6996)											
      --AND sl.podr LIKE '460061106002'											
      AND [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1)	<18	
      AND zs.USL_OK IN (1,2)									
    											
