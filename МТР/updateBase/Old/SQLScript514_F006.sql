ALTER TABLE F006 ALTER COLUMN IDVID NUMERIC(2,0)
DECLARE @XML_TEXT XML;
DECLARE @idoc INT;
DECLARE @F006 TABLE (	
	id INT IDENTITY(3,1)  NOT NULL,
	[IDVID] [numeric](2, 0) NOT NULL,
	[VIDNAME] [nvarchar](254) NOT NULL,
	[DATEBEG] [datetime] NOT NULL,
	[DATEEND] [datetime] NULL)		
	
--SELECT @XML_TEXT = t.BulkColumn
--FROM    (SELECT *    
--    FROM OPENROWSET (BULK 'D:\F006.xml', SINGLE_CLOB) 
-- AS xCol) AS t
--SET @XML_TEXT = REPLACE(@XML_TEXT, '<?xml version="1.0" encoding="windows-1251"?>', '')

SELECT @XML_TEXT = '<packet>
  <zglv>
    <type>VidExp</type>
    <version>3.1</version>
    <date>04.04.2018</date>
  </zglv>
  <zap>
    <IDVID>1</IDVID>
    <VIDNAME>��� (������-������������� ��������)</VIDNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDVID>2</IDVID>
    <VIDNAME>��� (������-������������� ����������)</VIDNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND>31.03.2018</DATEEND>
  </zap>
  <zap>
    <IDVID>3</IDVID>
    <VIDNAME>���� (���������� �������� ����������� ������)</VIDNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND>31.03.2018</DATEEND>
  </zap>
  <zap>
    <IDVID>10</IDVID>
    <VIDNAME>��������� ������-������������� �������� � �������� �������</VIDNAME>
    <DATEBEG>01.04.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDVID>11</IDVID>
    <VIDNAME>��������� ������-������������� �������� �� ���������� ��</VIDNAME>
    <DATEBEG>01.04.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDVID>12</IDVID>
    <VIDNAME>��������� ������-������������� �������� �� ������ ��������</VIDNAME>
    <DATEBEG>01.04.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDVID>20</IDVID>
    <VIDNAME>������������ ������-������������� ����������</VIDNAME>
    <DATEBEG>01.04.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDVID>21</IDVID>
    <VIDNAME>�������� ������-������������� ���������� (��������� �������)</VIDNAME>
    <DATEBEG>01.04.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDVID>22</IDVID>
    <VIDNAME>������� ������-������������� ���������� �� ������ ���������� ��������� �� ������ ������ � ���� �� ����������� (� ������� 15 ���� - ��� �������� ���, � ������� 30 ���� - ��� ��������� ��������������; � ������� 24 ����� �� ������� ��������������� ������ - ��� ��������� ������ ���)</VIDNAME>
    <DATEBEG>01.04.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDVID>23</IDVID>
    <VIDNAME>������� ������-������������� ���������� �� ������ �� ��������������� ���� ��� ��� ������������� �� ����������� ����������� ������ � ����������� �����������</VIDNAME>
    <DATEBEG>01.04.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDVID>24</IDVID>
    <VIDNAME>��������� ������-������������� ����������  � �������� �������</VIDNAME>
    <DATEBEG>01.04.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDVID>25</IDVID>
    <VIDNAME>��������� ������-������������� ����������  �� ��������� ��</VIDNAME>
    <DATEBEG>01.04.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDVID>26</IDVID>
    <VIDNAME>��������� ������-������������� ���������� �� ������ ��������</VIDNAME>
    <DATEBEG>01.04.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDVID>30</IDVID>
    <VIDNAME>������������ ���������� �������� ����������� ������</VIDNAME>
    <DATEBEG>01.04.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDVID>31</IDVID>
    <VIDNAME>�������� ���������� �������� ����������� ������ (��������� �������)</VIDNAME>
    <DATEBEG>01.04.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDVID>32</IDVID>
    <VIDNAME>������� ���������� �������� ����������� ������ �� ������ �� ��������������� ���� ��� ��� ������������� �� ����������� � �������� ����������� ������ � ����������� �����������</VIDNAME>
    <DATEBEG>01.04.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDVID>33</IDVID>
    <VIDNAME>������� ���������� �������� ����������� ������ �� ������� � ��������� �������</VIDNAME>
    <DATEBEG>01.04.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDVID>34</IDVID>
    <VIDNAME>������� ���������� �������� ����������� ������ �� �������  ����������������� ������������� � ���������� �����������</VIDNAME>
    <DATEBEG>01.04.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDVID>35</IDVID>
    <VIDNAME>������� ���������� �������� ����������� ������ �� �������  ���������� ������ �� ������������ ��� ��������������� �������� � �����</VIDNAME>
    <DATEBEG>01.04.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDVID>36</IDVID>
    <VIDNAME>������� ���������� �������� ����������� ������ �� ������ ���������� ������������� ��������� �� ������ ������ � ���� �� ����������� (� ������� 15 ���� - ��� �������� ���, � ������� 30 ���� - ��� ��������� ��������������; � ������� 24 ����� �� ������� ��������������� ������ - ��� ��������� ������ ���)</VIDNAME>
    <DATEBEG>01.04.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDVID>37</IDVID>
    <VIDNAME>������� ���������� �������� ����������� ������ �� ������� ���������� �� ����������� ������� ������-������������� ����������</VIDNAME>
    <DATEBEG>01.04.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDVID>38</IDVID>
    <VIDNAME>����� ���������� �������� ����������� ������</VIDNAME>
    <DATEBEG>01.04.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDVID>39</IDVID>
    <VIDNAME>��������� ���������� �������� ����������� ������ � �������� �������</VIDNAME>
    <DATEBEG>01.04.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDVID>40</IDVID>
    <VIDNAME>��������� ���������� �������� ����������� ������ �� ��������� ��</VIDNAME>
    <DATEBEG>01.04.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDVID>41</IDVID>
    <VIDNAME>��������� ���������� �������� ����������� ������ �� ������ ��������</VIDNAME>
    <DATEBEG>01.04.2018</DATEBEG>
    <DATEEND/>
  </zap>
</packet>'--[XMLCODE] FROM [SprUpdate] WHERE NAME_SPR = 'F006'

EXEC sp_xml_preparedocument @idoc OUTPUT, @XML_TEXT;
BEGIN TRY
INSERT INTO @F006 ([IDVID],[VIDNAME], DATEBEG, DATEEND)
SELECT [IDVID],[VIDNAME], DATEBEG, DATEEND
FROM OPENXML (@idoc, N'/packet/zap', 2)
WITH ([IDVID] [numeric](2, 0) ,
	[VIDNAME] [nvarchar](254),
	[DATEBEG] NVARCHAR(10),
	[DATEEND] NVARCHAR(10)
			  ) 
END TRY
BEGIN CATCH
	PRINT '������ �������� XML �����.';
END CATCH

UPDATE @F006 SET DATEEND = NULL WHERE DATEEND = '19000101' 

UPDATE t
SET IDVID = t1.IDVID
      ,VIDNAME = t1.VIDNAME      
      ,DATEBEG = t1.DATEBEG
      ,DATEEND = t1.DATEEND
FROM F006 as t
JOIN @F006 as t1 on t.IDVID = t1.IDVID

INSERT INTO F006
       (id, IDVID,[VIDNAME], DATEBEG, DATEEND)
SELECT  id, IDVID,[VIDNAME], DATEBEG, DATEEND
FROM @F006
WHERE IDVID NOT IN (
        SELECT t1.IDVID  
        FROM F006 AS t
JOIN @F006 AS t1 ON t.IDVID = t1.IDVID)