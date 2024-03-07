declare @p1 int=751
--�.�. 23/12/19 ������ � ��� USL_TIP in (5) onk.DS1_T NOT  0,1,2
--������ ������� ���������� � ����� 6 � ��������� ��������, ��� ���� ������ ���� ������ � ����� 6 � ����� ����� ������ 5
--declare @p1 int = 2525

select
	zs.id as ID, zs.sumv  as SUMV,'' com-- '��� ���������� �� ������������� ������ ��������� � ����������
	--zs.ID,
	--,ou.USL_TIP --��� ����������
	--,onk.DS1_T --����� ��������� � ����������
FROM [D3_SCHET_OMS] sch
		inner join [D3_PACIENT_OMS] p on sch.id=p.[D3_SCID]
		inner join [D3_ZSL_OMS] zs on p.id=zs.[D3_PID]
		inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]
		inner join D3_ONK_SL_OMS onk on onk.D3_SLID=sl.id
		inner join D3_ONK_USL_OMS ou on ou.D3_ONKSLID=onk.id
WHERE 
	p.D3_SCID = @p1
	and
	(
		(ou.USL_TIP=1 AND onk.DS1_T NOT IN (0,1,2,5,6)
		)
	OR 
		(ou.USL_TIP in (2,3,4) AND onk.DS1_T NOT IN (0,1,2)
		)
	OR 
		(ou.USL_TIP in (5) AND onk.DS1_T NOT IN (0,1,2,6)
		)
	
	)
group by zs.id, zs.SUMV

union

--������ ���, � ���� ���� ������ ���� ���������� � ����� 6, � ����� ��� ���� �� 5-�����������
select
	zs.id as ID, zs.sumv  as SUMV,'' com--,SUM(CASE WHEN ou.USL_TIP in (6) THEN 1 ELSE 0 END),count(ou.ID)
	--, onk.DS1_T-- '��� ���������� �� ������������� ������ ��������� � ����������
	--zs.ID,
	--,usl.CODE_USL,y.Name
	--ou.USL_TIP,COUNT(*) --��� ����������
	--,onk.DS1_T --����� ��������� � ����������
FROM [D3_SCHET_OMS] sch
		inner join [D3_PACIENT_OMS] p on sch.id=p.[D3_SCID]
		inner join [D3_ZSL_OMS] zs on p.id=zs.[D3_PID]
		inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]
		inner join D3_ONK_SL_OMS onk on onk.D3_SLID=sl.id
		inner join D3_ONK_USL_OMS ou on ou.D3_ONKSLID=onk.id
		--LEFT JOIN d3_usl_oms usl on usl.D3_SLID=sl.id
		--LEFT JOIN Yamed_Spr_UslCode y ON y.ID=usl.CODE_USL
WHERE 
	p.D3_SCID = @p1
	AND onk.DS1_T<>5
group by zs.id, zs.SUMV, onk.DS1_T
HAVING SUM(CASE WHEN ou.USL_TIP in (6) THEN 1 ELSE 0 END)= count( ou.ID )
