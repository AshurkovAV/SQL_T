SELECT [�������],count(nhistory) [����������] , sum(kd) [����� �����-����], round(sum(kd)*0.01*100/count(nhistory),2)[������� �����-����]			
from			
(			
SELECT DISTINCT -- sch.month,sch.id AS schit,sch.SchetType,			
 --zs.id zslid, date_z_2			
 --, 			
 			
 			
 			
 /*�16-�16.9, 			
 �15-�15.8,			
  �18-�18.8,			
   �19-20, 			
   �25-�25.8,			
    �33,			
	 �34.0-�34.9, 		
	 �43-�43.8		
	  �50-�50.9  		
	   �56,		
	    �53,		
		 �54, 	
		 �51, 	
		 �80.9,	
		  �41, 	
		  �40, 	
		  �38,	
		   �37, 	
		   �23, 	
		   �0-�14,	
		    �83-�81,	
			 �60-�60.9.*/
 			
 case   when ds1 between 'C00' and 'C14.z'then 'C00-C14'			
        when ds1 between 'C16' and 'C16.9'then 'C16-C16.9'			
        when ds1 between 'C18' and 'C18.8'then 'C18-C18.8'			
		when ds1 between 'C19' and 'C19.z'then 'C19'	
		when ds1 between 'C20' and 'C20.z'then 'C20'	
		when ds1 between 'C34' and 'C34.z'then 'C34-C34.9'	
		when ds1 between 'C50' and 'C50.9'then 'C50-C50.9'	
	when ds1 between 'C53' and 'C56.z'then 'C53-C56'		
	when ds1 between 'C61' and 'C64.z'then 'C61-C64'		
			
		when ds1 between 'C43' and 'C43.z'then 'C43'	
			
		when ds1 between 'C80' and 'C85.9'then 'C80-C85'	
			
			
		else '��������' end [�������],	
			
			
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
AND (ds1 between 'C00' and 'C14.z' or			
        ds1 between 'C16' and 'C16.9' or			
        ds1 between 'C18' and 'C18.8' or			
		ds1 between 'C19' and 'C19.z' or	
	 ds1 between 'C20' and 'C20.z' or		
		 ds1 between 'C34' and 'C34.z' or	
		 ds1 between 'C50' and 'C50.9' or	
	 ds1 between 'C53' and 'C56.z' or		
	ds1 between 'C61' and 'C64.z' or		
			
		ds1 between 'C43' and 'C43.z' or	
			
	ds1 between 'C80' and 'C85.9')		
 AND S.PODR IN ('460061206014')			
			
) t			
group by [�������]			

