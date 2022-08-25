-----������������ ���������� ��� (22)
declare @p1 int = 2077
select zsl.ID, zsl.SUMV, '������������ ��������� ���, �������� ������ ���� 317,318,352,353,355,356,357,358' com
FROM D3_ZSL_OMS zsl
WHERE zsl.D3_SCID = @p1 and zsl.OS_SLUCH_REGION = 22 and (zsl.RSLT not in (317,318,352,353,355,356,357,358) or zsl.RSLT is null)
union
select zsl.ID, zsl.SUMV, '������������ ������� ���, ������ ���� 57 ��� 97' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
WHERE zsl.D3_SCID = @p1 and zsl.OS_SLUCH_REGION = 22 and sl.PROFIL not in (57,97)
union
select zsl.ID, zsl.SUMV, '������������ ������������� ���, ������ ���� 16 ��� 27' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
WHERE zsl.D3_SCID = @p1 and zsl.OS_SLUCH_REGION = 22 and sl.PRVS not in (16,27)
union
select zsl.ID, zsl.SUMV, '������������ ��� ������ ���, ������ ���� 11' com
FROM D3_ZSL_OMS zsl
WHERE zsl.D3_SCID = @p1 and zsl.OS_SLUCH_REGION = 22 and IDSP <>11
union
select zsl.ID, zsl.SUMV, '������������ ����� ���, ������ ���� 306' com
FROM D3_ZSL_OMS zsl
WHERE zsl.D3_SCID = @p1 and zsl.OS_SLUCH_REGION = 22 and ISHOD<>306
union
select zsl.ID, zsl.SUMV, '��������������� �� � ���, ������ ���� 3' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
WHERE zsl.D3_SCID = @p1 and zsl.OS_SLUCH_REGION = 22 and zsl.usl_ok<>3
union
SELECT zsl.ID, zsl.SUMV, '���� ������ ����. � ������ "�����(�������������)" ������ ���������' com 
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
join D3_USL_OMS u on sl.id = u.D3_SLID
WHERE zsl.D3_SCID = @p1 AND zsl.OS_SLUCH_REGION = 22
		AND CAST(u.DATE_IN AS DATE) <> CAST(sl.DATE_1 AS DATE) AND u.VID_VME = 'A01.30.026'
group by zsl.id, zsl.SUMV
UNION
SELECT zsl.ID, zsl.SUMV, '���� ����� "�������������" � "�����(�������������)" ������ ���������' com 
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
join D3_USL_OMS u on sl.id = u.D3_SLID
WHERE zsl.D3_SCID = @p1 AND zsl.OS_SLUCH_REGION = 22
		AND CAST(u.DATE_IN AS DATE) <> CAST(sl.DATE_1 AS DATE) AND u.VID_VME = 'A02.07.004'
group by zsl.id, zsl.SUMV
UNION
SELECT zsl.ID, zsl.SUMV, '������: "�����(�������������)", "�������������", "�����(������) �����-���������" �� ����� ���� "������������ �����"' com 
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
join D3_USL_OMS u on sl.id = u.D3_SLID
WHERE zsl.D3_SCID = @p1 AND zsl.OS_SLUCH_REGION = 22
		AND u.VID_VME IN ('A01.30.026','A02.07.004','022.00.020') AND u.NPL = 4
group by zsl.id, zsl.SUMV
UNION
SELECT zsl.ID, zsl.SUMV, '������: "�����(�������������)", "�������������", "�����(������) �����-���������" �� ����� ���� "�����������"' com 
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
join D3_USL_OMS u on sl.id = u.D3_SLID
WHERE zsl.D3_SCID = @p1 AND zsl.OS_SLUCH_REGION = 22
		AND u.VID_VME IN ('A01.30.026','A02.07.004','022.00.020') AND u.P_OTK = 1
group by zsl.id, zsl.SUMV
UNION
SELECT zsl.ID, zsl.SUMV, '������ "�����(�������������)" ������ ���� ������ �� ����' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
join D3_USL_OMS u on sl.id = u.D3_SLID
JOIN	(	SELECT sl.ID, MIN(CAST(u.DATE_IN AS DATE)) mindate
			FROM D3_ZSL_OMS zsl
			join D3_SL_OMS sl on sl.d3_zslid=zsl.id
			join D3_USL_OMS u on sl.id = u.D3_SLID
			WHERE zsl.D3_SCID = @p1 AND zsl.OS_SLUCH_REGION = 22 AND u.NPL is null
			GROUP BY sl.ID
		) minusl ON sl.ID = minusl.ID
WHERE zsl.D3_SCID = @p1 AND zsl.OS_SLUCH_REGION = 22
		AND u.VID_VME = 'A01.30.026' AND CAST(u.DATE_IN AS DATE) > minusl.mindate
group by zsl.id, zsl.SUMV