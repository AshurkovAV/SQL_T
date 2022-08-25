---------------�����������
---------------��� ���� 2.0 ��� 1.1 ���������
select
	k.COM,
	k.usl_ok,
	k.code_mo,
	k.nam_mok
	,(SELECT f.NameWithID FROM F002 AS f WHERE f.smocod =	smo)smo
	,count (k.id) [���-�� ��� ����_���]
	,NULL [���-�� ���]
	,SUM(sumv)
from(
select
	distinct
	'��������� ���' COM,
	sch.month,
	zs.id,
	zs.usl_ok,
	sch.code_mo,
	f3.nam_mok,
	p.SMO,
	sl.profil,
	sumv,
	case 
		when sch.MONTH<8 then sl.p_cel
		else sl.P_CEL25
	end [����]
	
FROM [D3_SCHET_OMS] sch
		inner join [D3_PACIENT_OMS] p on sch.id=p.[D3_SCID]
									and  sch.ID IN (2057,2059,2060,2061,2071,2077,2083,2092,2095,2111,2115,2119)
									
		inner join [D3_ZSL_OMS] zs on p.id=zs.[D3_PID]
									and zs.usl_ok=3
		inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]
								and sl.PROFIL not in (63,85,86,87,88,89,90,171) --�� ������������
								and (
										(sl.p_cel='2.0' and sch.MONTH<8)
									or 
										(sl.P_CEL25='1.1' and sch.MONTH>=8)
									)
		left join [D3_SANK_OMS] sank on sank.[D3_ZSLID]=zs.id
									and sank.s_tip=1
		left join f003 f3 on f3.mcod=sch.code_mo
where sank.[ID] is null)k
group by
	COM,
	k.usl_ok,
	k.code_mo,
	k.nam_mok
	,k.smo
	UNION ALL
---------------��� ���� ��� ��� ������� ��� ���� � ��� ����� ������� �����									
select										
	K.COM,
	k.usl_ok
	,k.code_mo,
	k.nam_mok									
	,(SELECT f.NameWithID FROM F002 AS f WHERE f.smocod =	smo)smo								
	,count (k.id) [���-�� ��� ����_���]			
	,NULL [���-�� ���]			
	,SUM(sumv)			
from(										
select										
	distinct									
	'����� ���' COM,
	--sch.month,									
	zs.id									
	,zs.usl_ok,	
	sch.code_mo,
	f3.nam_mok,								
	--zs.OS_SLUCH_REGION,									
	p.SMO,
	sumv				
	--,sl.profil,									
	--case 									
	--	when sch.MONTH<8 then sl.p_cel								
	--	else sl.P_CEL25								
	--end [����]									
FROM [D3_SCHET_OMS] sch										
		inner join [D3_PACIENT_OMS] p on sch.id=p.[D3_SCID]								
									and  sch.ID IN (2057,2059,2060,2061,2071,2077,2083,2092,2095,2111,2115,2119)	
										
		inner join [D3_ZSL_OMS] zs on p.id=zs.[D3_PID]								
									and zs.usl_ok=3	
		inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]								
								and sl.PROFIL not in (63,85,86,87,88,89,90,171) --�� ������������		
		left join [D3_SANK_OMS] sank on sank.[D3_ZSLID]=zs.id								
									and sank.s_tip=1
		left join f003 f3 on f3.mcod=sch.code_mo						
where sank.[ID] is null										
	and (									
			(							
				(sl.p_cel in ('1.1','1.2') and sch.MONTH<8)						
			or 							
				(sl.P_CEL25 in ('2.1','2.2','2.3','2.5','2.6') and sch.MONTH>=8)						
			)	
			and (zs.OS_SLUCH_REGION not in (6,19,21,29,30,31,32,33,34,35,36,39) or zs.OS_SLUCH_REGION is null)						
		or (								
				(						
					(sl.p_cel is null and sch.MONTH<8) 					
				or 						
					(sl.P_CEL25 is null and sch.MONTH>=8)					
				)						
				and zs.OS_SLUCH_REGION in (7,8,9,11,12,17,18,22,23,4,5)						
			)							
		or (								
				(						
					(sl.p_cel is null and sch.MONTH<8) 					
				or 						
					(sl.P_CEL25 is null and sch.MONTH>=8)					
				)						
				and zs.OS_SLUCH_REGION is null						
			)							
		)								
)k										
group by										
	K.COM,
	k.usl_ok
	,k.code_mo,
	k.nam_mok										
	,k.smo	
	UNION ALL
---------------��� ���� 1.3 3.0 - �� ��� � 1.0 1.2 1.3 3.0 - � ������� - ������� ���������!!!!!!! �����������
select
	K.COM,
	k.usl_ok
	,k.code_mo,
	k.nam_mok	
	,(SELECT f.NameWithID FROM F002 AS f WHERE f.smocod =	smo)smo
	,count (k.id) [���-�� ����_���]
	,NULL [���-�� ���]
	,SUM(sumv)
from(
select
	'����������� ��� ������� ���������' COM,
	sch.month,
	zs.id,
	zs.usl_ok,
	sch.code_mo,
	f3.nam_mok,	
	p.SMO,
	sl.profil,
	sumv,
	case 
		when sch.MONTH<8 then sl.p_cel
		else sl.P_CEL25
	end [����]
FROM [D3_SCHET_OMS] sch
		inner join [D3_PACIENT_OMS] p on sch.id=p.[D3_SCID]
									and  sch.ID IN (2057,2059,2060,2061,2071,2077,2083,2092,2095,2111,2115,2119)
									
		inner join [D3_ZSL_OMS] zs on p.id=zs.[D3_PID]
									and zs.usl_ok=3
		inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]
								and sl.PROFIL not in (63,85,86,87,88,89,90,171) --�� ������������
								and (
										(
											(sl.p_cel in ('1.3') and sch.MONTH<8)
										or 
											(sl.P_CEL25 in ('1.0','1.2','1.3') and sch.MONTH>=8)
										)
										and (zs.OS_SLUCH_REGION not in (6,19,21,29,30,31,32,33,34,35,36,39) or zs.OS_SLUCH_REGION is null)
									)
		left join [D3_SANK_OMS] sank on sank.[D3_ZSLID]=zs.id
									and sank.s_tip=1
		left join f003 f3 on f3.mcod=sch.code_mo	
where sank.[ID] is null)k
group by
	COM,
	k.usl_ok
	,k.code_mo,
	k.nam_mok
	,k.smo	
	UNION ALL
	
SELECT
	COM,
	usl_ok
	,code_mo,
	nam_mok	
	,(SELECT f.NameWithID FROM F002 AS f WHERE f.smocod =	smo)smo
	,SUM([���-�� ����_���]) [���-�� ����_���]
	,NULL [���-�� ���],
	SUM(sumv)
from(
select
	K.COM,
	k.usl_ok
	,k.code_mo,
	k.nam_mok	
	,smo
	,1 [���-�� ����_���]
	,MAX(sumv)sumv
	,NULL [���-�� ���]
from(
select
	'����������� ��� ���������' COM,
	sch.month,
	zs.id,
	zs.usl_ok,
	sch.code_mo,
	f3.nam_mok,	
	p.SMO,
	sl.profil,
	sumv,
	case 
		when sch.MONTH<8 then sl.p_cel
		else sl.P_CEL25
	end [����]
FROM [D3_SCHET_OMS] sch
		inner join [D3_PACIENT_OMS] p on sch.id=p.[D3_SCID]
									and  sch.ID IN (2057,2059,2060,2061,2071,2077,2083,2092,2095,2111,2115,2119)
									
		inner join [D3_ZSL_OMS] zs on p.id=zs.[D3_PID]
									and zs.usl_ok=3
		inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]
								and sl.PROFIL not in (63,85,86,87,88,89,90,171) --�� ������������
								and (
										(
											(sl.p_cel in ('3.0') and sch.MONTH<8)
										or 
											(sl.P_CEL25 in ('3.0') and sch.MONTH>=8)
										)
										and (zs.OS_SLUCH_REGION not in (6,19,21,29,30,31,32,33,34,35,36,39) or zs.OS_SLUCH_REGION is null)
									)
		left join [D3_SANK_OMS] sank on sank.[D3_ZSLID]=zs.id
									and sank.s_tip=1
		left join f003 f3 on f3.mcod=sch.code_mo	
where sank.[ID] is null)k
	group BY
	id,
	COM,
	k.usl_ok
	,k.code_mo,
	k.nam_mok
	,k.smo	) AS t
	group BY
	
	COM,
	usl_ok
	,code_mo,
	nam_mok
	,smo	
	UNION ALL
	
	
---------------��� ����������� ������
select
	K.COM,
	k.usl_ok
	,k.code_mo,
	k.nam_mok	
	,(SELECT f.NameWithID FROM F002 AS f WHERE f.smocod =	smo)smo
	,count (distinct k.id) [���-�� ����_���]
	,NULL [���-�� ���]
	,SUM(sumv)
from(
select
	distinct
	'����������� ��� ���' COM,
	sch.month,
	zs.id,
	zs.usl_ok,
	sch.code_mo,
	f3.nam_mok,	
	zs.OS_SLUCH_REGION,
	p.SMO,
	sl.profil,
	sumv,
	case 
		when sch.MONTH<8 then sl.p_cel
		else sl.P_CEL25
	end [����]
FROM [D3_SCHET_OMS] sch
		inner join [D3_PACIENT_OMS] p on sch.id=p.[D3_SCID]
									and  sch.ID IN (2057,2059,2060,2061,2071,2077,2083,2092,2095,2111,2115,2119)
		inner join [D3_ZSL_OMS] zs on p.id=zs.[D3_PID]
									and zs.usl_ok=3
									and zs.OS_SLUCH_REGION in (19,21,29,30,31,32,33,34,35,36,39)
		inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]
								and sl.PROFIL not in (63,85,86,87,88,89,90,171) --�� ������������
		left join [D3_SANK_OMS] sank on sank.[D3_ZSLID]=zs.id
									and sank.s_tip=1
		left join f003 f3 on f3.mcod=sch.code_mo	
where sank.[ID] is null)k
group by
	COM,
	k.usl_ok
	,k.code_mo,
	k.nam_mok
	,k.smo	
	UNION ALL
---------------������������
---------------������������ ���� 2.0 ��� 1.1
select
	K.COM,
	k.usl_ok,
	k.code_mo,
	k.nam_mok
	,(SELECT f.NameWithID FROM F002 AS f WHERE f.smocod =	smo)smo
	,count (distinct k.id) [���-�� ��� ����_������������]
	,sum(k.ED_COL) [���-�� ���]
	,SUM(sumv)
from(
select
	--distinct
	'��������� ������' COM,
	sch.month,
	zs.id,
	zs.usl_ok,
	sch.code_mo,
	f3.nam_mok,	
	p.SMO,
	sl.profil,
	sumv,
	sl.ED_COL,
	case 
		when sch.MONTH<8 then sl.p_cel
		else sl.P_CEL25
	end [����]
FROM [D3_SCHET_OMS] sch
		inner join [D3_PACIENT_OMS] p on sch.id=p.[D3_SCID]
									and  sch.ID IN (2057,2059,2060,2061,2071,2077,2083,2092,2095,2111,2115,2119)
									
		inner join [D3_ZSL_OMS] zs on p.id=zs.[D3_PID]
									and zs.usl_ok=3
		inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]
								and sl.PROFIL in (63,85,86,87,88,89,90,171) --������������
								and (
										(sl.p_cel='2.0' and sch.MONTH<8)
									or 
										(sl.P_CEL25='1.1' and sch.MONTH>=8)
									)
		left join [D3_SANK_OMS] sank on sank.[D3_ZSLID]=zs.id
									and sank.s_tip=1
		left join f003 f3 on f3.mcod=sch.code_mo
where sank.[ID] is null)k
group by
	K.COM,
	k.usl_ok
	,k.code_mo,
	k.nam_mok
	,k.smo
	UNION ALL
---------------������������ ���� ��� ��� ������� ��� ���� � ��� ����� ������� �����									
select										
	K.COM,
	k.usl_ok	
	,k.code_mo,
	k.nam_mok							
	,(SELECT f.NameWithID FROM F002 AS f WHERE f.smocod =	smo)smo									
	,count (distinct k.id) [���-�� ��� ����_������������]									
	,sum(k.ED_COL) [���-�� ���]		
	,SUM(sumv)							
from(										
select										
	--distinct									
	'����� ������' COM,
	sch.month,									
	zs.id									
	,zs.usl_ok,	
	sch.code_mo,
	f3.nam_mok,									
	zs.OS_SLUCH_REGION,									
	p.SMO,									
	sl.profil,	
	sumv,								
	sl.ED_COL,									
	case 									
		when sch.MONTH<8 then sl.p_cel								
		else sl.P_CEL25								
	end [����]									
FROM [D3_SCHET_OMS] sch										
		inner join [D3_PACIENT_OMS] p on sch.id=p.[D3_SCID]								
									and  sch.ID IN (2057,2059,2060,2061,2071,2077,2083,2092,2095,2111,2115,2119)	
										
		inner join [D3_ZSL_OMS] zs on p.id=zs.[D3_PID]								
									and zs.usl_ok=3	
		inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]								
								and sl.PROFIL in (63,85,86,87,88,89,90,171) -- ������������		
		left join [D3_SANK_OMS] sank on sank.[D3_ZSLID]=zs.id								
									and sank.s_tip=1
		left join f003 f3 on f3.mcod=sch.code_mo						
where sank.[ID] is null										
	and (									
			(							
				(sl.p_cel in ('1.1','1.2') and sch.MONTH<8)						
			or 							
				(sl.P_CEL25 in ('2.1','2.2','2.3','2.5','2.6') and sch.MONTH>=8)						
			)							
		or (								
				(						
					(sl.p_cel is null and sch.MONTH<8) 					
				or 						
					(sl.P_CEL25 is null and sch.MONTH>=8)					
				)						
				and zs.OS_SLUCH_REGION in (7,8,9,11,12,17,18,22,23,4,5)						
			)							
		or (								
				(						
					(sl.p_cel is null and sch.MONTH<8) 					
				or 						
					(sl.P_CEL25 is null and sch.MONTH>=8)					
				)						
				and zs.OS_SLUCH_REGION is null						
			)							
		)								
)k										
group by										
	K.COM,
	k.usl_ok	
	,k.code_mo,
	k.nam_mok								
	,k.smo	
	UNION ALL
---------------������������ ���� 1.3 3.0 - �� ��� � 1.0 1.2 1.3 3.0 - � ������� 
select
	K.COM,
	k.usl_ok
	,k.code_mo,
	k.nam_mok,
	(SELECT f.NameWithID FROM F002 AS f WHERE f.smocod =	smo)smo
	--,count (distinct zs_id) [���-�� ��� ����_������������]
	,count (distinct sl_id) [���-�� c���_������������]
	,sum(k.ED_COL) [���-�� ���]
	,SUM(sumv)
from(
select
	'����������� ������ ������� ���������' COM,
	sch.month,
	zs.id [zs_id],
	sl.id [sl_id],
	zs.usl_ok,
	sch.code_mo,
	f3.nam_mok,	
	p.SMO,
	sl.profil,
	sumv,
	sl.ED_COL,
	case 
		when sch.MONTH<8 then sl.p_cel
		else sl.P_CEL25
	end [����]
FROM [D3_SCHET_OMS] sch
		inner join [D3_PACIENT_OMS] p on sch.id=p.[D3_SCID]
									and  sch.ID IN (2057,2059,2060,2061,2071,2077,2083,2092,2095,2111,2115,2119)
									
		inner join [D3_ZSL_OMS] zs on p.id=zs.[D3_PID]
									and zs.usl_ok=3
		inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]
								and sl.PROFIL in (63,85,86,87,88,89,90,171) --������������
								and (
										(sl.p_cel in ('1.3','3.0') and sch.MONTH<8)
									or 
										(sl.P_CEL25 in ('1.0','1.2','1.3','3.0') and sch.MONTH>=8)
									)
		left join [D3_SANK_OMS] sank on sank.[D3_ZSLID]=zs.id
									and sank.s_tip=1
		left join f003 f3 on f3.mcod=sch.code_mo
where sank.[ID] is null)k
group by
	K.COM,
	k.usl_ok
	,k.code_mo,
	k.nam_mok
	,k.smo
	
	UNION ALL

SELECT
	COM,
	usl_ok,
	code_mo,
	nam_mok,
	smo	
	,SUM([���-�� c���_������������]) [���-�� c���_������������]
	,sum([���-�� ���]) [���-�� ���]
	,sum(sumv)sumv
from(	
SELECT
	K.COM,
	k.usl_ok
	,k.code_mo,
	k.nam_mok,
	(SELECT f.NameWithID FROM F002 AS f WHERE f.smocod =	smo)smo	
	,1 [���-�� c���_������������]
	,sum(k.ED_COL) [���-�� ���]
	,max(sumv)sumv
from(
select
	'����������� ������ ���������' COM,
	sch.month,
	zs.id [zs_id],
	sl.id [sl_id],
	zs.usl_ok,
	sch.code_mo,
	f3.nam_mok,	
	p.SMO,
	sl.profil,
	sumv,
	sl.ED_COL,
	case 
		when sch.MONTH<8 then sl.p_cel
		else sl.P_CEL25
	end [����]
FROM [D3_SCHET_OMS] sch
		inner join [D3_PACIENT_OMS] p on sch.id=p.[D3_SCID]
									and  sch.ID IN (2057,2059,2060,2061,2071,2077,2083,2092,2095,2111,2115,2119)
									
		inner join [D3_ZSL_OMS] zs on p.id=zs.[D3_PID]
									and zs.usl_ok=3
		inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]
								and sl.PROFIL in (63,85,86,87,88,89,90,171) --������������
								and (
										(sl.p_cel in ('3.0') and sch.MONTH<8)
									or 
										(sl.P_CEL25 in ('3.0') and sch.MONTH>=8)
									)
		left join [D3_SANK_OMS] sank on sank.[D3_ZSLID]=zs.id
									and sank.s_tip=1
		left join f003 f3 on f3.mcod=sch.code_mo
where sank.[ID] is null)k
group BY
[zs_id],
	K.COM,
	k.usl_ok
	,k.code_mo,
	k.nam_mok
	,k.smo) AS t
group BY
	COM,
	usl_ok,
	code_mo,
	nam_mok,
	smo