USE tempdb
GO
  
IF OBJECT_ID('tempdb.dbo.#tbl') IS NOT NULL
        DROP TABLE #tbl
       GO
       CREATE TABLE #tbl
(
[��] nvarchar(200),
[������� �� ����� ����� + ��� ���] nvarchar(200) ,
[��� ��������] nvarchar(200),
[����� ��������] nvarchar(100), 
[����� �������] nvarchar(100),
[����� �������] nvarchar(100),
[���������] nvarchar(100),
[������ ������� � ���] nvarchar(100),
[������] nvarchar(30),
[������� ��] nvarchar(100),
[��� �������] NVARCHAR(200),
[������ ������� � ������] nvarchar(100),
[������� �������������] nvarchar(100),
[���� ������ �������] nvarchar(100),
[���� �������� �������] nvarchar(100),
[���� �������� ������� ��������?] nvarchar(200),
[�������] nvarchar(500),
[����������] nvarchar(100),
[���������] nvarchar(100),
[�������� � ������] nvarchar(450),
[�������� ��] nvarchar(500),
[�������� ��.] nvarchar(100)
       )
	   
DECLARE @var1 VARCHAR(50), @script NVARCHAR (max)
        
        DECLARE cur CURSOR FAST_FORWARD READ_ONLY LOCAL FOR
        	SELECT 
        	name FROM sys.databases
          WHERE  
		  name NOT IN ('G_EMISZKO_KGB6')         
        OPEN cur
        
        FETCH NEXT FROM cur INTO @var1
        
        WHILE @@FETCH_STATUS = 0 
       BEGIN
       PRINT @var1

        SET @script = 
          '
		  Use [' + @var1 + ']
		  IF OBJECT_ID(''dbo.DLO_MEDICAMENTS'', ''U'') IS NOT NULL

INSERT INTO #tbl
( [��], 
  [������� �� ����� ����� + ��� ���], 
          [��� ��������], 
          [����� ��������], 
          [����� �������], 
          [����� �������], 
          [���������], 
          [������ ������� � ���],
          [������], 
          [������� ��],
          [��� �������], 
          [������ ������� � ������], 
          [������� �������������], 
          [���� ������ �������], 
          [���� �������� �������], 
          [���� �������� ������� ��������?], 
          [�������],
          [����������], 
          [���������], 
          [�������� � ������], 
          [�������� ��], 
          [�������� ��.] )
  

select 

(select short_label from fm_org where fm_org_id = 1) [��], 
''��� '' + isnull(m1.KOD5, ''���'') + '' '' + m1.NOM + '' '' + m1.PRENOM [������� �� ����� ����� + ��� ���],

p.NOM + '' '' + p.prenom + '' '' + p.patronyme [��� ��������],
p.SYS_SNILS [����� ��������],
pps.SERIYA [����� �������],
dgp.nomer [����� �������],
Case when dgp.utvergden = 1 THEN ''��'' When dgp.utvergden = 0 THEN ''���'' END [���������],
isnull(srm.STATUS_NAME, '''') [������ ������� � ���],

case when isnull(dgp.reg_recept, 0) <> 0 THEN ''������������''
     when isnull(dgp.federal_nyy_recept, 0) <> 0 THEN ''�����������''      
          ELSE '''' END [������],

case when isnull(dgp.VK, 0) <> 0 THEN ''��''  
          when isnull(dgp.VK, 0) <> 0 and isnull(dgp.VK_LS, 0) <> 0 THEN ''�� + �� �� ��''
          when isnull(dgp.VK, 0) <> 1 and isnull(dgp.VK_LS, 0) <> 0 THEN ''�� �� ��''
          ELSE '''' END [������� ��],   

case when isnull(dgp.narkoticheskiy_recept, 0) <> 0 THEN ''�������������''
          when isnull(dgp.nozolog, 0) <> 0 THEN ''20 ���������''
          when isnull(dgp.orfan, 0) <> 0 THEN ''�����.''
          when isnull(dgp.bsz, 0) <> 0 THEN ''���''
         -- when isnull(dgp.narkoticheskiy_recept, 0) <> 0 and isnull(dgp.nozolog, 0) <> 0 and isnull(dgp.orfan, 0) <> 0 and isnull(dgp.bsz, 0) <> 0 THEN ''������������� + 20 ��������� + �����. + ���''
         -- when isnull(dgp.nozolog, 0) <> 0 and isnull(dgp.bsz, 0) <> 0 THEN ''20 ��������� + ���'' 
         ELSE '''' END [��� �������],

isnull(sra.STATUS_NAME, '''') [������ ������� � ������],

isnull(pa.PRICH_ANUL_NAME, '''') [������� �������������],
convert(varchar(10), dgp.date_consultation, 104) [���� ������ �������],
ISNULL(sdr.SROK_DEYST_NAME, '''') [���� �������� �������],

case 
when dgp.utvergden = 0 THEN ''������ �� ����������� � ������'' 

when 
dgp.STATUS_RECEPTA !=1 and isnull(dgp.STATUS_RECEPTA_A, '''') = '''' 
and dgp.DEJSTVITELEN = 1 and DATEDIFF(DAY, ( dgp.DATE_CONSULTATION ), (GETDATE() - 91)) >= 0
THEN ''���� 90 ���� �����''
 ELSE 
  (case when dgp.STATUS_RECEPTA !=1 and isnull(dgp.STATUS_RECEPTA_A, '''') = '''' 
  and dgp.DEJSTVITELEN = 0 and DATEDIFF(DAY, ( dgp.DATE_CONSULTATION ), (GETDATE() - 31)) >= 0
  THEN ''���� 30 ���� �����''
  ELSE
   (case when dgp.STATUS_RECEPTA !=1 and isnull(dgp.STATUS_RECEPTA_A, '''') = '''' 
   and dgp.DEJSTVITELEN = 2 and DATEDIFF(DAY, ( dgp.DATE_CONSULTATION ), (GETDATE() - 16)) >= 0
  THEN ''���� 15 ���� �����''
  

ELSE (case when dgp.STATUS_RECEPTA_A = 2 
    THEN ''������� � ������ '' + convert(varchar(10), dgp.DATA_VYDACHI_PREPARATA_V_, 104)
    when dgp.STATUS_RECEPTA_A = 3 and isnull(dgp.DATA_VYDACHI_PREPARATA_V_, '''') = '''' 
    THEN ''�� ����������� ������������ � '' + convert(varchar(10), dgp.DATA_OTSROCHKI, 104)
      ELSE (case when dgp.utvergden = 1 and dgp.STATUS_RECEPTA != 1 
        THEN ''������ '' + convert(varchar, datediff(day, dgp.DATE_CONSULTATION, getdate())) + '' ����� � ������� ������'' 
        ELSE ''����������� � �� '' + convert(varchar(10), dgp.KRN_MODIFY_DATE, 104) + '' ������������� '' + m.NOM + '' '' + m.PRENOM
        END)
  END)
  END)
 END)
END [���� �������� ������� ��������], 
case when isnull(dm.name_mnn_lat,'''') != '''' 
		THEN dm.name_mnn_lat
		ELSE (CASE WHEN isnull(dm.name_mnn_lat_dop,'''') != '''' 
					THEN dm.name_mnn_lat_dop
					ELSE (CASE WHEN isnull(dm.name_mnn,'''') != '''' 
								THEN dm.name_mnn 
								ELSE (CASE WHEN isnull(dm.name_mnn_dop,'''') != ''''
											THEN dm.name_mnn_dop
											ELSE (CASE WHEN isnull(dm.torg_name,'''') != ''''
														THEN dm.torg_name END)END)END)END)END ''�������'',
dgp.KOLIHESTVO [����������],
dgp.DOZIROVKA [���������],
dgp.name_apteka [�������� � ������],
dgp.OTPUSK_APTEKA [�������� ��],
convert(int, dgp.summa_otpuschennyh_medika) [�������� ��.]

--dgp.*

from DATA_GRACE_PRESCRIPTION dgp with(nolock)
left join RECIPE_DLO.dbo.STATUS_RECIPE srm on srm.STATUS_RESIPE = dgp.STATUS_RECEPTA
left join RECIPE_DLO.dbo.STATUS_RECIPE sra on sra.STATUS_RESIPE = dgp.STATUS_RECEPTA_A
left join PRIV_PRESCR_SERIES pps on pps.SERIYA_RECEPTA_ID = dgp.seriya
left join RECIPE_DLO.dbo.PRICH_ANUL pa on pa.PRICH_ANUL_RECIPE = dgp.annulirovat
left join RECIPE_DLO.dbo.SROK_DEYST_RECIPE sdr on sdr.SROK_DEYST_RESIPE = dgp.DEJSTVITELEN
left join PATIENTS p on p.PATIENTS_ID = dgp.PATIENTS_ID
left join MEDECINS m on m.MEDECINS_ID = dgp.KRN_MODIFY_USER_ID
left join DLO_MEDICAMENTS dm on dm.DLO_LEKS_ID = dgp.LEKARSTVENNOE_SREDSTVO
left join motconsu mot on mot.MOTCONSU_ID = dgp.MOTCONSU_ID
left join medecins m1 on m1.MEDECINS_ID = mot.LEHAHIJ_VRAH

where dgp.DATE_CONSULTATION >= ''2020-01-01'' and dgp.DATE_CONSULTATION <= ''2020-29-06'' --yyyy-dd-mm

--and isnull(dgp.STATUS_RECEPTA_A, '''') = ''''
--and dgp.STATUS_RECEPTA = 0
and dgp.utvergden = 1

order by p.NOM, p.PRENOM, p.PATRONYME, dgp.DATE_CONSULTATION 
          '
      --PRINT @script
       EXEC (@script)
        
        	FETCH NEXT FROM cur INTO @var1
        
       END
        
        CLOSE cur
        DEALLOCATE cur
SELECT * FROM #tbl
DROP TABLE #tbl
GO