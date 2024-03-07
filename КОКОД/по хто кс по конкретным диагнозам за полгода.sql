SELECT [диагноз],count(nhistory) [количество] , sum(kd) [сумма койко-дней], round(sum(kd)*0.01*100/count(nhistory),2)[средний койко-день]			
from			
(			
SELECT DISTINCT -- sch.month,sch.id AS schit,sch.SchetType,			
 --zs.id zslid, date_z_2			
 --, 			
 			
 			
 			
 /*С16-С16.9, 			
 С15-С15.8,			
  С18-С18.8,			
   С19-20, 			
   С25-С25.8,			
    С33,			
	 С34.0-С34.9, 		
	 С43-С43.8		
	  С50-С50.9  		
	   С56,		
	    С53,		
		 С54, 	
		 С51, 	
		 С80.9,	
		  С41, 	
		  С40, 	
		  С38,	
		   С37, 	
		   С23, 	
		   С0-С14,	
		    С83-С81,	
			 С60-С60.9.*/
 			
 case when ds1 between 'C16' and 'C16.9'then 'C16-C16.9'			
        when ds1 between 'C15' and 'C15.8'then 'C15-C15.8'			
		when ds1 between 'C18' and 'C18.8'then 'C18-C18.8'	
		when ds1 between 'C19' and 'C20.z'then 'C19-C20'	
		when ds1 between 'C25' and 'C25.8'then 'C25-C25.8'	
		when ds1 between 'C33' and 'C33.z'then 'C33'	
	when ds1 between 'C34' and 'C34.z'then 'C34-C34.9'		
	when ds1 between 'C43' and 'C43.8'then 'C43-C43.8'		
	when ds1 between 'C50' and 'C50.9'then 'C50-C50.9'		
	when ds1 between 'C56' and 'C56.z'then 'C56'		
	when ds1 between 'C53' and 'C53.z'then 'C53'		
		when ds1 between 'C54' and 'C54.z'then 'C54'	
		when ds1 between 'C51' and 'C51.z'then 'C51'	
		when ds1 between 'C80.9' and 'C80.9'then 'C80.9'	
		when ds1 between 'C41' and 'C41.z'then 'C41'	
		when ds1 between 'C40' and 'C40.z'then 'C40'	
           when ds1 between 'C38' and 'C38.z'then 'C38'			
		    when ds1 between 'C37' and 'C37.z'then 'C37'	
			 when ds1 between 'C23' and 'C23.z'then 'C23'
			  when ds1 between 'C00' and 'C14.z'then 'C00-C14'
			   when ds1 between 'C81' and 'C83.z'then 'C81-C83'
			    when ds1 between 'C60' and 'C60.9'then 'C60-C60.9'
			
		else 'потряшка' end [диагноз],	
			
			
s.podr			
,k.name	,		
--,p.fam,p.im,p.ot,p.dr, p.npolis,zs.DATE_Z_1, zs.DATE_Z_2, s.nhistory,s.ds1			
--,ksg.n_ksg,v23.NameWithID, cr.CRIT,v024.dkkname,			
 s.nhistory, s.kd			
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
where year(date_z_2)=2021 and sch.code_MO=460061 AND MONTH(DATE_Z_2) BETWEEN 1 AND 6			
AND (ds1 between 'C16' and 'C16.9' OR			
      ds1 between 'C15' and 'C15.8' OR			
	 ds1 between 'C18' and 'C18.8' OR		
		ds1 between 'C19' and 'C20.z' OR	
		ds1 between 'C25' and 'C25.8' OR	
		 ds1 between 'C33' and 'C33.z' OR	
	 ds1 between 'C34' and 'C34.z' OR		
 ds1 between 'C43' and 'C43.8' OR			
	 ds1 between 'C50' and 'C50.9' OR		
	ds1 between 'C56' and 'C56.z' OR		
 ds1 between 'C53' and 'C53.z' OR			
		 ds1 between 'C54' and 'C54.z' OR	
		 ds1 between 'C51' and 'C51.z' OR	
	 ds1 between 'C80.9' and 'C80.9' OR		
		 ds1 between 'C41' and 'C41.z' OR	
		 ds1 between 'C40' and 'C40.z' OR	
       ds1 between 'C38' and 'C38.z' OR			
		 ds1 between 'C37' and 'C37.z' OR	
			 ds1 between 'C23' and 'C23.z' OR
			ds1 between 'C00' and 'C14.z' OR
			ds1 between 'C81' and 'C83.z' OR
			  ds1 between 'C60' and 'C60.9' )
			   AND S.PODR IN ('460061106006', '460061106017')
			
) t			
group by [диагноз]			