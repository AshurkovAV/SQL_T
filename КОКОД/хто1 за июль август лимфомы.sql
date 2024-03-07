SELECT t.podr			
,t.name, ds1 
,case when w=1 and [dbo].[f_GetAge] (t.DR,t.DATE_Z_1) >=60 then 'муж 60 и старше'
      when w=1 and [dbo].[f_GetAge] (t.DR,t.DATE_Z_1) <60 then 'муж меньше 60'
      when w=2 and [dbo].[f_GetAge] (t.DR,t.DATE_Z_1) >=55 then 'жен 55 и старше'
      when w=2 and [dbo].[f_GetAge] (t.DR,t.DATE_Z_1) <55 then 'жен меньше 55'
      END 'пол-возраст'
      ,COUNT(nhistory) [число госпитализаций]
    from
      (
SELECT DISTINCT 
			
--	MONTH(date_z_2)	,	
s.podr			
,k.name	,ds1,		
--,p.fam,p.im,p.ot,p.dr, p.npolis,zs.DATE_Z_1, zs.DATE_Z_2, s.nhistory,s.ds1			
--,ksg.n_ksg,v23.NameWithID, cr.CRIT,v024.dkkname,			
 s.nhistory, s.kd, p.w,P.DR,ZS.DATE_Z_1
 --[dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) 
 --case when p.w=2 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) <60 or p.w=1 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) <65 then 'трудоспособные'			
FROM [D3_SCHET_OMS] sch  			
  inner join D3_ZSL_OMS zs on zs.[D3_SCID]=sch.id			
  inner join D3_PACIENT_OMS p on zs.D3_PID=p.id  			
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID			
--  JOIN D3_KSG_KPG_OMS AS  ksg ON ksg.D3_SLID=s.ID 			
--  left join D3_CRIT_OMS cr on cr.D3_KSGID=ksg.id			
--left JOIN v023 v23 ON v23.K_KSG=ksg.N_KSG AND date_z_2 between v23.DATEBEG and isnull(v23.DATEend, '20201231') --year(v23.DATEBEG) between 2019 and 2020 AND (v23.DATEend like '20201231'			
-- LEFT JOIN v012 v12 ON v12.id=zs.ishod			
-- LEFT JOIN v009 ON v009.IDRMP=zs.RSLT			
left join KOKOD_OTD k on k.kod_otd=s.podr			
where year(date_z_2)=2021 and sch.code_MO=460061 AND MONTH(DATE_Z_2) BETWEEN 7 AND 9 AND s.podr LIKE '460061106006'		
AND ds1 between 'C81' and 'C97.9' AND zs.USL_OK in (1)
      ) t
GROUP BY t.podr			
,t.name, ds1 ,
case when w=1 and [dbo].[f_GetAge] (t.DR,t.DATE_Z_1) >=60 then 'муж 60 и старше'
      when w=1 and [dbo].[f_GetAge] (t.DR,t.DATE_Z_1) <60 then 'муж меньше 60'
      when w=2 and [dbo].[f_GetAge] (t.DR,t.DATE_Z_1) >=55 then 'жен 55 и старше'
      when w=2 and [dbo].[f_GetAge] (t.DR,t.DATE_Z_1) <55 then 'жен меньше 55'
      END