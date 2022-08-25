DECLARE @XML_TEXT XML;
DECLARE @idoc INT;
DECLARE @Eror TABLE (
  ZSL_ID UNIQUEIDENTIFIER NULL,
SMO INT NULL,
COMENTS NVARCHAR(max),
COMENTS2 NVARCHAR(max))    

  SELECT @XML_TEXT = t.BulkColumn
FROM    (SELECT *    
    FROM OPENROWSET (BULK 'C:\OM460023T46_201232.xml', SINGLE_CLOB) 
 AS xCol) AS t

EXEC sp_xml_preparedocument @idoc OUTPUT, @XML_TEXT;

INSERT INTO @Eror(  ZSL_ID,  SMO,  COMENTS,  COMENTS2)
SELECT ZSL_ID,  SMO,  COMENTS,  COMENTS2
FROM OPENXML(@idoc, N'/ELMEDICINE/SLUCH',2) 
WITH (
  ZSL_ID UNIQUEIDENTIFIER,
  SMO INT ,
  COMENTS nvarchar(MAX),
  COMENTS2 nvarchar(MAX)
) T

update p set smo = SUBSTRING(er.COMENTS2, 16, 5)
FROM d3_zsl_OMS AS s 
join D3_pacient_OMS as p on s.D3_PID = p.id
JOIN @Eror er ON er.ZSL_ID = s.zsl_id
WHERE er.COMENTS = '������������ ��� ���' and s.OS_SLUCH_REGION is null


update p set NPOLIS = SUBSTRING(er.COMENTS2, 61, 16), VPOLIS = 1
FROM d3_zsl_OMS AS s 
join D3_pacient_OMS as p on s.D3_PID = p.id
JOIN @Eror er ON er.ZSL_ID = s.zsl_id
WHERE er.COMENTS2  like '� ��� ��������� ��������� ����: ����� ��� ������� ������� �%' and s.OS_SLUCH_REGION is NULL

update p set NPOLIS = SUBSTRING(er.COMENTS2, 25, 9), VPOLIS = 2
FROM d3_zsl_OMS AS s 
join D3_pacient_OMS as p on s.D3_PID = p.id
JOIN @Eror er ON er.ZSL_ID = s.zsl_id
WHERE er.COMENTS2  like '��������� ������������� %�����:%' and s.OS_SLUCH_REGION is NULL

update p set NPOLIS = SUBSTRING(er.COMENTS2, 59, 9), VPOLIS = 2
FROM d3_zsl_OMS AS s 
join D3_pacient_OMS as p on s.D3_PID = p.id
JOIN @Eror er ON er.ZSL_ID = s.zsl_id
WHERE er.COMENTS2  like '� ��� ��������� ��������� ����: ��������� ������������� �%' and s.OS_SLUCH_REGION is null

update p set SMO = SUBSTRING(er.COMENTS2, 16, 5)
FROM d3_zsl_OMS AS s 
join D3_pacient_OMS as p on s.D3_PID = p.id
JOIN @Eror er ON er.ZSL_ID = s.zsl_id
WHERE er.COMENTS2  like '���������� ���:%' and s.OS_SLUCH_REGION is null

--� ��� ��������� ��������� ����: ��������� ������������� � 088207573

UPDATE s SET EXP_COMENT = SUBSTRING(er.COMENTS2, 0, 249), osp_coment = er.COMENTS
FROM d3_zsl_OMS AS s 
join D3_pacient_OMS as p on s.D3_PID = p.id
JOIN @Eror er ON er.ZSL_ID = s.zsl_id
WHERE er.COMENTS != '������������ ��� ���' and er.COMENTS2 not like '� ��� ��������� ��������� ����: ����� ��� ������� ������� �%' AND er.COMENTS2 NOT like '���������� ���:%'
AND  er.COMENTS2 not like '� ��� ��������� ��������� ����: ��������� ������������� �%' AND er.COMENTS2 not like '��������� ������������� %�����:%'
/*
update p set smo = SUBSTRING(er.COMENTS2, 16, 5)
FROM SLUCH AS s 
join pacient as p on s.PID = p.id
JOIN @Eror er ON er.ZSL_ID = s.IDSLG
WHERE er.COMENTS = '������������ ��� ���'

UPDATE s SET MEK_COMENT = SUBSTRING(er.COMENTS2, 0, 249)
FROM SLUCH AS s 
join pacient as p on s.PID = p.id
JOIN @Eror er ON er.ZSL_ID = s.IDSLG
WHERE er.COMENTS != '������������ ��� ���'
*/