INSERT INTO [D3_SL_KOEF_OMS] ([D3_KSGID]
      ,[D3_KSGGID]
      ,[IDSL]
      ,[Z_SL])
SELECT Ksg.ID, Ksg.KSG_ID, 1011, 1.1000
--DISTINCT sch.[MONTH], zsl.ZSL_ID, sch.ID,  	sch.SchetType,p.fam,p.im,p.ot,p.dr,sl.NHISTORY,zsl.usl_ok,zsl.DATE_Z_1,zsl.DATE_Z_2, sumv, sumv*1.1
---,ds.DS
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  inner join D3_ZSL_OMS zsl on zsl.D3_PID=p.id 
	inner join D3_SL_OMS sl on sl.d3_zslid=zsl.id
		inner join D3_KSG_KPG_OMS ksg on sl.ID=ksg.D3_SLID
			left JOIN D3_SL_KOEF_OMS kslp ON kslp.D3_KSGID=ksg.ID
			   --  left  JOIN D3_DSS_OMS AS ds ON ds.D3_SLID = sl.ID and ds.DS_TYPE=2
	
WHERE 
	sch.ID IN (7850)
	
	--sch.year=2021
	--and sch.month IN ( 10)
	
	and sch.code_mo='460026'
	and  dbo.f_GetAge(p.dr,date_z_2) >= 75
	AND zsl.USL_OK = 1
	and not
	 EXISTS
		(select ko.IDSL
		from D3_SL_KOEF_OMS AS ko 
		where ko.D3_KSGID=ksg.id and ko.IDSL in (9041,41,1011)
		)