
DECLARE @t TABLE(
	id INT NOT NULL,
	[FAM] [nvarchar](50) NULL,
	[IM] [nvarchar](50) NULL,
	[OT] [nvarchar](50) NULL,
	[DR] [datetime] NULL,
	[ID_ENP] [nvarchar](16) NULL,
	ID_Policy [nvarchar](35) NULL,
    doctor [nvarchar](14) )
DECLARE @id int, @FAM [nvarchar](50), @IM [nvarchar](50), @OT [nvarchar](50), @DR [datetime], @ID_ENP [nvarchar](16), @ID_Policy [nvarchar](35) , @doctor [nvarchar](14)

DECLARE vendor_cursor CURSOR FOR 
SELECT aps.id, aps.FAM, aps.IM, aps.OT, aps.DR, onl.ID_ENP, onl.ID_Policy
FROM(SELECT pon.*, ID_Policy
	FROM [SQL_ONLINE].[ELMED_ONLINE].[dbo].[AttachedPeople_ONLINE] pon
	JOIN [SQL_ONLINE].[ELMED_ONLINE].[dbo].AttachedSmo_ONLINE smo ON smo.PID = pon.ID
	WHERE pon.[ID_MO] = 460026 AND [Osn_Pr_Doct] = 'Требуется прикрепление к врачу') AS onl
JOIN AttachedPeopleSpr AS aps ON aps.ID = onl.ID

OPEN vendor_cursor
FETCH NEXT FROM vendor_cursor INTO @id, @FAM, @IM, @OT, @DR, @ID_ENP, @ID_Policy;
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @doctor = NULL;
	SELECT @doctor = SNILS FROM DoctorBd WHERE id =
	(
	SELECT TOP 1 doctor FROM (
	SELECT doctor, COUNT(*) cnt 
	FROM PacientVisit WHERE
	(
		Polis = @ID_ENP OR Polis = @ID_Policy
		OR (FAM = @FAM AND IM = @IM AND OT = @OT AND DR = @DR)
	) AND profil IN (68,97)
	GROUP BY doctor
) AS t1
	ORDER BY cnt DESC)
	
	INSERT INTO @t (id, FAM, IM, OT, DR, ID_ENP, doctor)
	VALUES (@id, @FAM, @IM, @OT, @DR, @ID_ENP, @doctor)
FETCH NEXT FROM vendor_cursor INTO @id,@FAM, @IM, @OT, @DR, @ID_ENP, @ID_Policy;
END;
CLOSE vendor_cursor;
DEALLOCATE vendor_cursor;

--UPDATE [SQL_ONLINE].[ELMED_ONLINE].[dbo].AttachedPeople_ONLINE 
--SET [ID_DOCT] = iddoc,
--	[Osn_Pr_Doct] = 'Изменение внесено в Регистр МО 30.09.2015'
SELECT *
	FROM [SQL_ONLINE].[ELMED_ONLINE].[dbo].AttachedPeople_ONLINE peop
	JOIN(SELECT t.id idpeop, doc.id iddoc
	FROM [SQL_ONLINE].[ELMED_ONLINE].[dbo].AttachedUchDoct_ONLINE doc
	JOIN @t AS t on t.doctor = doc.snils) tt ON peop.id = tt.idpeop 

--WHERE [SNILS] NOT IN (
--SELECT doctor FROM @t AS t WHERE t.doctor IS NOT NULL GROUP BY t.doctor)