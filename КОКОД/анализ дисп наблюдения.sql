SELECT 
 distinct-- p.SMO as [��������� ��������]
 zs.id,
 s.iddokt,kp.fam+' '+kp.im+' '+kp.ot vrach,
				p.fam AS [�������]
				,p.im AS [���]
				,isnull(p.ot,'') AS [��������] 
				,p.W as [���]
				,p.DR as [���� ��������]
				,isnull(p.NPOLIS,p.ENP) polis
				,ds1
				,zs.DATE_Z_1
				, ishod, rslt
				,replace(replace(zs.EXP_COMENT, CHAR(10), ''), CHAR(13), '') AS [���] 
						
				,zs.OS_SLUCH_REGION,  ds_onk, zs.npr_mo, zs.npr_date, dn, zsl_id
  
--*/ 
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id 
  join D3_SL_OMS s on s.D3_ZSLID=zs.ID
 LEFT JOIN (select DISTINCT * from kokod_podr WHERE usl_ok=3 ) AS kp ON kp.IDDOCT=dbo.f_digit_only(iddokt) AND zs.usl_ok=kp.usl_ok

 --AND sch.month=5
 
 
  --JOIN D3_USL_OMS u ON u.D3_SLID=s.id
  where s.p_cel25 like '1.3' 
  --and -- (zs.EXP_COMENT is not null and zs.EXP_COMENT not like '%�� �� ������ � ������� ��%' and zs.EXP_COMENT not like '%������������ ������� �������� ���.������ � ������������ ��������� � ����� ������� (�������� ��� ������)%' )
 and (zs.EXP_COMENT is not null )
 AND sch.YEAR=2023  
 and sch.id IN (9446) --(8221)
	--and  zs.EXP_COMENT  like '%������������ ������� �������� ���.������ � ������������ ��������� � ����� ������� (�������� ��� ������)%' 
	--and zs.os_sluch_region<>40
	order by isnull(p.NPOLIS,p.ENP) ,zs.DATE_Z_1
  




 

  -- ����������  ��� ��� ����������
  SELECT 
 distinct-- p.SMO as [��������� ��������]
 zs.id,
dbo.f_digit_only(iddokt), kp.iddoct, s.iddokt,kp.fam+' '+kp.im+' '+kp.ot vrach,
				p.fam AS [�������]
				,p.im AS [���]
				,isnull(p.ot,'') AS [��������] 
				,p.W as [���]
				,p.DR as [���� ��������]
				,isnull(p.NPOLIS,p.ENP) polis
				,ds1
				,zs.DATE_Z_1
				, ishod, rslt
				,replace(replace(zs.EXP_COMENT, CHAR(10), ''), CHAR(13), '') AS [���] 
						
				,zs.OS_SLUCH_REGION,  ds_onk
  
 FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id 
  join D3_SL_OMS s on s.D3_ZSLID=zs.ID
  left JOIN (select DISTINCT * from kokod_podr WHERE usl_ok=3 ) AS kp ON kp.IDDOCT=dbo.f_digit_only(iddokt) AND zs.usl_ok=kp.usl_ok

 --AND sch.month=5
--(8221)
 
  --JOIN D3_USL_OMS u ON u.D3_SLID=s.id
  where s.p_cel25 like '1.3' 
  --and -- (zs.EXP_COMENT is not null and zs.EXP_COMENT not like '%�� �� ������ � ������� ��%' and zs.EXP_COMENT not like '%������������ ������� �������� ���.������ � ������������ ��������� � ����� ������� (�������� ��� ������)%' )
and ds_onk=1
 AND sch.YEAR=2023  
 and sch.id IN (9446) 
	--and zs.os_sluch_region<>40
	order by isnull(p.NPOLIS,p.ENP) ,zs.DATE_Z_1
 