--UPDATE p SET PRIMEHANIE = '�������� ' + OS_SLUCH_REGION + ' ���� ' + iddokt1 + ' �� ' + CONVERT(NVARCHAR(12), d2, 111) 
--FROM(
--SELECT 
--dpo.FAM, dpo.IM, dpo.ot, cast(dpo.DR AS DATE) dr, cast(dzo.DATE_Z_2 AS DATE)d2, ds1, dso2.[MONTH] '����� ������', --dzo.OS_SLUCH_REGION,
--(SELECT TOP  1 v017.NameWithID FROM v017 WHERE IDDR =  dzo.RSLT_D)RSLT_D, 
--(SELECT TOP 1 ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = iddokt)iddokt1,
--(SELECT osd.NameWithID FROM OsobSluchDb AS osd WHERE osd.Id = dzo.OS_SLUCH_REGION ) OS_SLUCH_REGION  --, dso.IDDOKT
--FROM D3_ZSL_OMS AS dzo
--JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
--JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
--JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID --AND dso2.NSCHET LIKE '%����%'
--LEFT JOIN Yamed_Spr_MedicalEmployee AS ysme ON ysme.SNILS = dso.IDDOKT
--WHERE dzo.OS_SLUCH_REGION IN (47,49) 
--AND dso2.[MONTH] IN (1,2,3,4,5,6,7,8,9,10) 
--AND dso2.[YEAR] = 2023
--AND dso2.NSCHET NOT LIKE '%�����%'
--) AS t 
--JOIN codmiac.G_EMISZKO_KGP7.dbo.PATIENTS AS p ON t.FAM = nom collate Cyrillic_General_CI_AS
--AND t.IM = prenom collate Cyrillic_General_CI_AS
--AND t.ot = PATRONYME collate Cyrillic_General_CI_AS
--AND t.dr = NE_LE


-------//7 �����������//--------
DECLARE @fam NVARCHAR(40), @im NVARCHAR(40), @ot NVARCHAR(40), @dr datetime, @d2 DATETIME, @doc NVARCHAR(100), @os NVARCHAR(100)  

DECLARE vendor_cursor CURSOR FOR 
	SELECT 
		dpo.FAM, dpo.IM, dpo.ot, cast(dpo.DR AS DATE) d, cast(dzo.DATE_Z_2 AS DATE)d2,
		(SELECT TOP 1 ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = iddokt)iddokt1,
		(SELECT osd.NameWithID FROM OsobSluchDb AS osd WHERE osd.Id = dzo.OS_SLUCH_REGION ) OS_SLUCH_REGION
		FROM D3_ZSL_OMS AS dzo
		JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
		JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
		JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID --AND dso2.NSCHET LIKE '%����%'
		LEFT JOIN Yamed_Spr_MedicalEmployee AS ysme ON ysme.SNILS = dso.IDDOKT
		WHERE dzo.OS_SLUCH_REGION IN (47,49) 
		AND dso2.[MONTH] IN (9,10,11) 
		AND dso2.[YEAR] = 2023
		AND dso2.NSCHET NOT LIKE '%�����%'
OPEN vendor_cursor

FETCH NEXT FROM vendor_cursor INTO @fam,@im,@ot,@dr, @d2, @doc, @os;
WHILE @@FETCH_STATUS = 0
BEGIN
	
	BEGIN TRY
		UPDATE p SET PRIMEHANIE = '�������� ' + @os + ' ���� ' + @doc + ' �� ' + CONVERT(NVARCHAR(12), @d2, 111) 
	--SELECT 	'�������� ' + @os + ' ���� ' + @doc + ' �� ' + CONVERT(NVARCHAR(12), @d2, 111)
	FROM codmiac.G_EMISZKO_KGP7.dbo.PATIENTS AS p  
		WHERE nom = @fam -- collate Cyrillic_General_CI_AS
AND prenom = @im -- collate Cyrillic_General_CI_AS
AND PATRONYME = @ot -- collate Cyrillic_General_CI_AS
AND NE_LE = @dr
	END TRY
	BEGIN CATCH	
		PRINT '������ '
	END CATCH
	
				
	FETCH NEXT FROM vendor_cursor INTO @fam,@im,@ot,@dr, @d2, @doc, @os;
END;
CLOSE vendor_cursor;
DEALLOCATE vendor_cursor