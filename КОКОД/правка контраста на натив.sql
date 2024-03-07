--502 дешевые
--UPDATE p 
--SET p.D3_SCID=694


UPDATE usl
SET CODE_USL = 'R01.001.001.001', VID_VME = 'A06.09.005'
--Select DISTINCT zsl_id,zs.ID,zs.SUMV, '' com,zs.D3_scid--,p.D3_SCID--,SUM(CASE WHEN cr.crit= lp.code_sh THEN 1 ELSE 0 end)
--zs.lpu,sch.month,s.nhistory,zs.id zslidksg.N_KSG,cr.crit, lp.code_sh, CASE WHEN cr.crit= lp.code_sh THEN 1 ELSE 0 end
--INTO temp_old_8
FROM [D3_SCHET_OMS] sch                  
join D3_PACIENT_OMS p on p.d3_scid=sch.id --AND  sch.year=2020 AND sch.id=319-- AND sch.code_mo=460061
join D3_ZSL_OMS zs on zs.D3_PID=p.id
--join ztemp_digCdelete_082020 t on t.zslid=zs.id
--join ztemp_desh_Cdelete_072020 t on t.zslid=zs.id
JOIN D3_SL_OMS AS sl ON sl.D3_ZSLID=zs.id
JOIN d3_usl_oms usl ON usl.D3_SLID=sl.id 
WHERE sch.id=695 and sl.NHISTORY IN (
	'2020-403970',
'2020-404603',
'2020-404358',
'2020-404845',
'2020-406563',
'2020-350865',
'2020-405677',
'2020-380291',
'2020-404450',
'2020-374736',
'2020-404785',
'2020-378361',
'2020-403861',
'2020-413312',
'2020-407644',
'2020-404441',
'2020-407651',
'2020-407739',
'2020-404245',
'2020-404224',
'2020-404774',
'2020-408193',
'2020-405988',
'2020-407595',
'2020-397815',
'2020-404406',
'2020-379983'
)
AND zs.sumv=7082.00 AND usl.VID_VME='A06.09.005.002'
--select * from ztemp_digCdelete_072020