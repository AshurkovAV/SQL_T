USE tempdb
GO
  
IF OBJECT_ID('tempdb.dbo.#tbl') IS NOT NULL
        DROP TABLE #tbl
       GO
       CREATE TABLE #tbl
(
[МО] nvarchar(200),
[Выписан от имени врача + код ДЛО] nvarchar(200) ,
[ФИО пациента] nvarchar(200),
[Снилс пациента] nvarchar(100), 
[Серия рецепта] nvarchar(100),
[Номер рецепта] nvarchar(100),
[Утвержден] nvarchar(100),
[Статус рецепта в МИС] nvarchar(100),
[Бюджет] nvarchar(30),
[Признак ВК] nvarchar(100),
[Тип рецепта] NVARCHAR(200),
[Статус рецепта в Аптеке] nvarchar(100),
[Причина аннулирования] nvarchar(100),
[Дата выдачи рецепта] nvarchar(100),
[Срок действия рецепта] nvarchar(100),
[Срок действия рецепта завершен?] nvarchar(200),
[Выписан] nvarchar(500),
[Количество] nvarchar(100),
[Дозировка] nvarchar(100),
[Отпущено в аптеке] nvarchar(450),
[Отпущено ЛС] nvarchar(500),
[Отпущено шт.] nvarchar(100)
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
( [МО], 
  [Выписан от имени врача + код ДЛО], 
          [ФИО пациента], 
          [Снилс пациента], 
          [Серия рецепта], 
          [Номер рецепта], 
          [Утвержден], 
          [Статус рецепта в МИС],
          [Бюджет], 
          [Признак ВК],
          [Тип рецепта], 
          [Статус рецепта в Аптеке], 
          [Причина аннулирования], 
          [Дата выдачи рецепта], 
          [Срок действия рецепта], 
          [Срок действия рецепта завершен?], 
          [Выписан],
          [Количество], 
          [Дозировка], 
          [Отпущено в аптеке], 
          [Отпущено ЛС], 
          [Отпущено шт.] )
  

select 

(select short_label from fm_org where fm_org_id = 1) [МО], 
''код '' + isnull(m1.KOD5, ''НЕТ'') + '' '' + m1.NOM + '' '' + m1.PRENOM [Выписан от имени врача + код ДЛО],

p.NOM + '' '' + p.prenom + '' '' + p.patronyme [ФИО пациента],
p.SYS_SNILS [Снилс пациента],
pps.SERIYA [Серия рецепта],
dgp.nomer [Номер рецепта],
Case when dgp.utvergden = 1 THEN ''Да'' When dgp.utvergden = 0 THEN ''Нет'' END [Утвержден],
isnull(srm.STATUS_NAME, '''') [Статус рецепта в МИС],

case when isnull(dgp.reg_recept, 0) <> 0 THEN ''Региональный''
     when isnull(dgp.federal_nyy_recept, 0) <> 0 THEN ''Федеральный''      
          ELSE '''' END [Бюджет],

case when isnull(dgp.VK, 0) <> 0 THEN ''ВК''  
          when isnull(dgp.VK, 0) <> 0 and isnull(dgp.VK_LS, 0) <> 0 THEN ''ВК + ВК по ЛС''
          when isnull(dgp.VK, 0) <> 1 and isnull(dgp.VK_LS, 0) <> 0 THEN ''ВК по ЛС''
          ELSE '''' END [Признак ВК],   

case when isnull(dgp.narkoticheskiy_recept, 0) <> 0 THEN ''Наркотический''
          when isnull(dgp.nozolog, 0) <> 0 THEN ''20 нозологий''
          when isnull(dgp.orfan, 0) <> 0 THEN ''Орфан.''
          when isnull(dgp.bsz, 0) <> 0 THEN ''БСЗ''
         -- when isnull(dgp.narkoticheskiy_recept, 0) <> 0 and isnull(dgp.nozolog, 0) <> 0 and isnull(dgp.orfan, 0) <> 0 and isnull(dgp.bsz, 0) <> 0 THEN ''Наркотический + 20 нозологий + Орфан. + БСЗ''
         -- when isnull(dgp.nozolog, 0) <> 0 and isnull(dgp.bsz, 0) <> 0 THEN ''20 нозологий + БСЗ'' 
         ELSE '''' END [Тип рецепта],

isnull(sra.STATUS_NAME, '''') [Статус рецепта в Аптеке],

isnull(pa.PRICH_ANUL_NAME, '''') [Причина аннулирования],
convert(varchar(10), dgp.date_consultation, 104) [Дата выдачи рецепта],
ISNULL(sdr.SROK_DEYST_NAME, '''') [Срок действия рецепта],

case 
when dgp.utvergden = 0 THEN ''Рецепт не передавался в аптеку'' 

when 
dgp.STATUS_RECEPTA !=1 and isnull(dgp.STATUS_RECEPTA_A, '''') = '''' 
and dgp.DEJSTVITELEN = 1 and DATEDIFF(DAY, ( dgp.DATE_CONSULTATION ), (GETDATE() - 91)) >= 0
THEN ''срок 90 дней истек''
 ELSE 
  (case when dgp.STATUS_RECEPTA !=1 and isnull(dgp.STATUS_RECEPTA_A, '''') = '''' 
  and dgp.DEJSTVITELEN = 0 and DATEDIFF(DAY, ( dgp.DATE_CONSULTATION ), (GETDATE() - 31)) >= 0
  THEN ''срок 30 дней истек''
  ELSE
   (case when dgp.STATUS_RECEPTA !=1 and isnull(dgp.STATUS_RECEPTA_A, '''') = '''' 
   and dgp.DEJSTVITELEN = 2 and DATEDIFF(DAY, ( dgp.DATE_CONSULTATION ), (GETDATE() - 16)) >= 0
  THEN ''срок 15 дней истек''
  

ELSE (case when dgp.STATUS_RECEPTA_A = 2 
    THEN ''Отпущен в аптеке '' + convert(varchar(10), dgp.DATA_VYDACHI_PREPARATA_V_, 104)
    when dgp.STATUS_RECEPTA_A = 3 and isnull(dgp.DATA_VYDACHI_PREPARATA_V_, '''') = '''' 
    THEN ''На отсроченном обслуживании с '' + convert(varchar(10), dgp.DATA_OTSROCHKI, 104)
      ELSE (case when dgp.utvergden = 1 and dgp.STATUS_RECEPTA != 1 
        THEN ''Прошло '' + convert(varchar, datediff(day, dgp.DATE_CONSULTATION, getdate())) + '' суток с момента выдачи'' 
        ELSE ''Аннулирован в МО '' + convert(varchar(10), dgp.KRN_MODIFY_DATE, 104) + '' пользователем '' + m.NOM + '' '' + m.PRENOM
        END)
  END)
  END)
 END)
END [Срок действия рецепта завершен], 
case when isnull(dm.name_mnn_lat,'''') != '''' 
		THEN dm.name_mnn_lat
		ELSE (CASE WHEN isnull(dm.name_mnn_lat_dop,'''') != '''' 
					THEN dm.name_mnn_lat_dop
					ELSE (CASE WHEN isnull(dm.name_mnn,'''') != '''' 
								THEN dm.name_mnn 
								ELSE (CASE WHEN isnull(dm.name_mnn_dop,'''') != ''''
											THEN dm.name_mnn_dop
											ELSE (CASE WHEN isnull(dm.torg_name,'''') != ''''
														THEN dm.torg_name END)END)END)END)END ''Выписан'',
dgp.KOLIHESTVO [Количество],
dgp.DOZIROVKA [Дозировка],
dgp.name_apteka [Отпущено в аптеке],
dgp.OTPUSK_APTEKA [Отпущено ЛС],
convert(int, dgp.summa_otpuschennyh_medika) [Отпущено шт.]

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