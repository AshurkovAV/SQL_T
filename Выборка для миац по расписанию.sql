USE tempdb
GO
  
IF OBJECT_ID('tempdb.dbo.#otchet') IS NOT NULL
        DROP TABLE #otchet
       GO
       CREATE TABLE #otchet
        (
        BASE_NAME VARCHAR(60),
        Raspisanie INT,
		Registrator INT,
		Vrach INT,
		Chuzgoy INT,
		infomat int,
		epgu int,
		EMC INT,
		Talon INT,
		vrach_pp INT
       )
          
DECLARE @DBName VARCHAR(60),
        @script VARCHAR(MAX),
        @ds VARCHAR(MAX),
        @de VARCHAR(MAX),
				@r VARCHAR(MAX)
/*тут указываем дату в формате ГГММДД*/
SET @ds = '2022-01-01 00:00:00.000'
SET @de = '2022-10-31 23:59:59.000'
SET @r = 'медицинский регистратор'
DECLARE dbs CURSOR LOCAL FORWARD_ONLY FOR
SELECT
  name
FROM sys.databases
-- WHERE name LIKE 'G_EMISZKO_%' or name like 'Z_EMISZKO_%' ESCAPE '\' -- Город + Железка
 WHERE name LIKE 'R_EMISZKO_%' ESCAPE '\' -- районы
OPEN dbs
FETCH NEXT FROM dbs INTO @DBName
WHILE @@fetch_status = 0
BEGIN
  PRINT '----------Выбрал базу' + CAST(@DBName AS VARCHAR(60))
  SET @script = 'Use [' + @DBName + ']
  
	Declare @RASPISANIE INT SET @RASPISANIE = (SELECT COUNT (*) FROM ' + @DBName + '.dbo.PLANNING WHERE '
	+ @DBName + '.dbo.PLANNING.Status = 0 and
	('+ @DBName + '.dbo.PLANNING.CANCELLED = 0  or ' + @DBName + '.dbo.PLANNING.CANCELLED is NULL) and ' 
+ @DBName + '.dbo.PLANNING.DATE_CONS >= ''' + @ds + ''' AND ' + @DBName + '.dbo.PLANNING.DATE_CONS <= ''' + @de + ''' )
  
	Declare @Registrator INT  SET @Registrator = (SELECT COUNT (*) FROM ' + @DBName + '.dbo.PLANNING LEFT OUTER JOIN ' 
+ @DBName + '.dbo.MEDECINS ON ' + @DBName + '.dbo.MEDECINS.MEDECINS_ID = ' 
+ @DBName + '.dbo.PLANNING.MEDECINS_CREATOR_ID WHERE ' + @DBName + '.dbo.PLANNING.MEDECINS_CREATOR_ID > 0 AND '
+ @DBName + '.dbo.MEDECINS.SPECIALISATION = ''' + @r + ''' and '
+ @DBName + '.dbo.PLANNING.Status = 0 and (' 
+ @DBName + '.dbo.PLANNING.CANCELLED = 0 or ' 
+ @DBName + '.dbo.PLANNING.CANCELLED is NULL) and '
+ @DBName + '.dbo.PLANNING.DATE_CONS >= ''' + @ds + ''' AND ' + @DBName + '.dbo.PLANNING.DATE_CONS <= ''' + @de + '''
)
  
  Declare @Chuzgoy INT SET @Chuzgoy = (SELECT COUNT (*) FROM ' + @DBName + '.dbo.PLANNING LEFT OUTER JOIN ' 
+ @DBName + '.dbo.MEDECINS ON ' + @DBName + '.dbo.MEDECINS.MEDECINS_ID = ' 
+ @DBName + '.dbo.PLANNING.MEDECINS_CREATOR_ID WHERE ' + @DBName + '.dbo.PLANNING.MEDECINS_CREATOR_ID > 0 AND ( '
+ @DBName + '.dbo.MEDECINS.SPECIALISATION like ''%аведую%''
or  ' + @DBName + '.dbo.MEDECINS.SPECIALISATION like ''%лавн%''
or  ' + @DBName + '.dbo.MEDECINS.SPECIALISATION like ''%ператор%''
or  ' + @DBName + '.dbo.MEDECINS.SPECIALISATION like ''%дминистрато%'' )

and '+ @DBName + ' .dbo.PLANNING.Status = 0 and
('+ @DBName + '.dbo.PLANNING.CANCELLED = 0 or ' 
+ @DBName + '.dbo.PLANNING.CANCELLED is NULL) and ' 
+ @DBName + '.dbo.PLANNING.DATE_CONS >= ''' + @ds + ''' AND ' + @DBName + '.dbo.PLANNING.DATE_CONS <= ''' + @de + ''' 

)

  declare @infomat int set @infomat = (select count (*) from ' + @DBName + '.dbo.PLANNING where ' + @DBName + '.dbo.PLANNING.MEDECINS_CREATOR_ID = 12 and '
	+ @DBName + ' .dbo.PLANNING.COMMENTAIRE like ''%ерез термина%'' and '
	+ @DBName + ' .dbo.PLANNING.Status = 0 and
('+ @DBName + '.dbo.PLANNING.CANCELLED = 0 or ' 
+ @DBName + '.dbo.PLANNING.CANCELLED is NULL) and ' 
+ @DBName + '.dbo.PLANNING.DATE_CONS >= ''' + @ds + ''' AND ' + @DBName + '.dbo.PLANNING.DATE_CONS <= ''' + @de + ''' )
  
	 declare @epgu int set @epgu = (select count (*) from ' + @DBName + '.dbo.PLANNING where ' + @DBName + '.dbo.PLANNING.MEDECINS_CREATOR_ID = 12 and ('
	+ @DBName + ' .dbo.PLANNING.COMMENTAIRE like ''%через региональный порт%'' or '
	+ @DBName + ' .dbo.PLANNING.COMMENTAIRE like ''%ЕПГ%'' and '
	+ @DBName + ' .dbo.PLANNING.Status = 0 and 
('+ @DBName + '.dbo.PLANNING.CANCELLED = 0 or ' 
+ @DBName + '.dbo.PLANNING.CANCELLED is NULL)) and ' 
+ @DBName + '.dbo.PLANNING.DATE_CONS >= ''' + @ds + ''' AND ' + @DBName + '.dbo.PLANNING.DATE_CONS <= ''' + @de + ''' )
	
Declare @Vrach INT SET @VRACH = (select @RASPISANIE - (@Registrator + @Chuzgoy + @infomat))
 
 Declare @vrach_pp INT  SET @vrach_pp = (SELECT COUNT (*) FROM ' + @DBName + '.dbo.PLANNING  LEFT OUTER JOIN ' 
+ @DBName + '.dbo.PL_EXAM ON ' 
+ @DBName + '.dbo.PLANNING.pl_exam_id = ' 
+ @DBName + '.dbo.pl_exam.pl_exam_id Left OUTER JOIN ' 
+ @DBName + '.dbo.MEDECINS ON ' 
+ @DBName + '.dbo.planning.MEDECINS_CREATOR_ID = ' 
+ @DBName + '.dbo.MEDECINS.medecins_id 
WHERE (' + @DBName + '.dbo.pl_exam.name like ''%первичный%'' 
OR ' + @DBName + '.dbo.pl_exam.name like ''%повторный%'' ) 
AND ' + @DBName + '.dbo.MEDECINS.SPECIALISATION not like ''%лавны%'' 
AND ' + @DBName + '.dbo.MEDECINS.SPECIALISATION not like ''%ператор%'' 
AND ' + @DBName + '.dbo.MEDECINS.SPECIALISATION not like ''%дминистрато%'' 
AND ' + @DBName + '.dbo.MEDECINS.SPECIALISATION not like ''%аведую%''
AND ' + @DBName + '.dbo.MEDECINS.SPECIALISATION not like ''%фомат%''
AND ' + @DBName + '.dbo.MEDECINS.SPECIALISATION not like ''%регистратор%''
AND ' + @DBName + '.dbo.MEDECINS.NOM not like ''%Web%''

and ' + @DBName + '.dbo.planning.STATUS= 0 
AND (' + @DBName + '.dbo.planning.CANCELLED = 0
or ' + @DBName + '.dbo.planning.CANCELLED is null
) AND ' + @DBName + '.dbo.PLANNING.DATE_CONS >= ''' + @ds + ''' 
AND ' + @DBName + '.dbo.PLANNING.DATE_CONS <= ''' + @de + ''' )

Declare @TALON INT SET @TALON = (SELECT COUNT (distinct dbo.fm_bill.motconsu_id) FROM ' + @DBName + '.dbo.MOTCONSU LEFT OUTER JOIN ' 
+ @DBName + '.dbo.FM_BILL ON ' + @DBName + '.dbo.MOTCONSU.MOTCONSU_ID = ' 
+ @DBName + '.dbo.FM_BILL.MOTCONSU_ID WHERE ' 
+ @DBName + '.dbo.motconsu.MOTCONSU_ID= '
+ @DBName + '.dbo.FM_BILL.MOTCONSU_ID and '
+ @DBName + '.dbo.MOTCONSU.DATE_CONSULTATION >= ''' + @ds + ''' AND ' + @DBName + '.dbo.MOTCONSU.DATE_CONSULTATION <= ''' + @de + '''
)

  Declare @EMC INT SET @EMC = (SELECT COUNT (*) MOTCONSU FROM ' + @DBName + '.dbo.MOTCONSU WHERE ' + @DBName + '.dbo.MOTCONSU.DATE_CONSULTATION >= ''' + @ds + ''' AND ' + @DBName + '.dbo.MOTCONSU.DATE_CONSULTATION <= ''' + @de + ''')
  
  INSERT INTO #otchet (BASE_NAME, Raspisanie, Registrator, Vrach, vrach_pp, Chuzgoy, Talon, EMC, infomat, epgu) VALUES (''' + @DBName + ''', @RASPISANIE, @REGISTRATOR, @VRACH, @vrach_pp, @Chuzgoy, @TALON, @EMC, @infomat, @epgu)'
  EXEC (@script)
  FETCH NEXT FROM dbs INTO @DBName
END
CLOSE dbs
DEALLOCATE dbs
SELECT * FROM #otchet
DROP TABLE #otchet
