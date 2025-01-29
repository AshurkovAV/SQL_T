--if OBJECT_ID('ztemp_not13') is not null drop table ztemp_not13

--SELECT t1.* 
--INTO ztemp_not13
--FROM (
--			SELECT DISTINCT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dpo.NPOLIS, dso.IDDOKT, max(dzo.DATE_Z_2)DATE_Z_2, max(dso.DS1)ds1
--			FROM D3_ZSL_OMS AS dzo
--				JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
--					JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
--						JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
--			WHERE dso2.[YEAR] = 2024
--			AND dzo.OS_SLUCH_REGION IN (47, 49)			
--			GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR,dpo.NPOLIS, dso.IDDOKT
			
--) AS t1

--LEFT JOIN (
--			SELECT DISTINCT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dzo.OS_SLUCH_REGION
--			FROM D3_ZSL_OMS AS dzo
--				JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
--					JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
--						JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
--			WHERE dso2.[YEAR] = 2024
--			AND dzo.OS_SLUCH_REGION IN (59)
--) AS t2 ON t2.FAM = t1.FAM AND t2.IM = t1.IM AND t2.OT = t1.OT AND t2.DR = t1.DR
		
--WHERE t2.FAM IS NULL

----SELECT *
----FROM ztemp_du_bsk
--if OBJECT_ID('ztemp_du_bsk') is not null drop table ztemp_du_bsk
--GO
----DROP TABLE ztemp_ztemp_du_bsk_adr
-------------1 шаг.
--SELECT DISTINCT t.Fam, t.Im, t.Ot, t.Dr, IDDOKT, DATE_Z_2, npolis, [Регистр#ДН#Диагнозы] ds, ds1, Адрес
--INTO ztemp_du_bsk
--FROM ztemp_not13 AS t
--	JOIN dbo.dubsk0910$ AS t1 ON t1.Фамилия = t.fam
--														AND t1.Имя = t.IM
--														AND t1.Отчество = t.ot
--														AND t1.[ДР] = t.dr

														
--SELECT Fam, Im, Ot, Dr, IDDOKT, DATE_Z_2, ds1, npolis
--FROM ztemp_du_bsk
--WHERE DATE_Z_2 >= '20240801'
--AND ds LIKE '%'+ ds1+'%'






SET NOCOUNT ON;

DECLARE @fam NVARCHAR(50),
@im NVARCHAR(50),
@ot NVARCHAR(50),
@dr DATETIME,
@doc NVARCHAR(50),
@d2 DATETIME,
@ds1 NVARCHAR(50),
@npolis NVARCHAR(50);




DECLARE vendor_cursor CURSOR FOR

SELECT Fam, Im, Ot, Dr, IDDOKT, DATE_Z_2, ds1, npolis
FROM ztemp_du_bsk
WHERE DATE_Z_2 >= '20240801'
AND ds LIKE '%'+ ds1+'%'

--SELECT dt.Фамилия fam, dt.Имя im, dt.Отчество ot, dt.[Дата рождения пациента] dr, 
--(SELECT TOP 1 ysme.SNILS
--   FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.fam LIKE '%' + SUBSTRING(dt.[Выдавший врач], 1, CHARINDEX(' ', dt.[Выдавший врач], 1) - 1) + '%')doc , dt.По d2, dt.mkb_ais ds1
--FROM ztemp_1410 AS dt
--	LEFT JOIN ztemp_du_pred AS dp ON dt.[Фамилия] = dp.FAM AND dt.[Имя] = dp.IM AND dt.[Отчество] = dp.OT AND dt.[Дата рождения пациента] = dp.DR
--WHERE dp.fam IS null

OPEN vendor_cursor

FETCH NEXT FROM vendor_cursor
INTO @fam, @im, @ot, @dr, @doc, @d2, @ds1,@npolis

WHILE @@FETCH_STATUS = 0
BEGIN
   
   
   DECLARE @zsl_id UNIQUEIDENTIFIER 
        DECLARE @ID_PAC UNIQUEIDENTIFIER
        DECLARE @SL_ID UNIQUEIDENTIFIER 
        DECLARE  @D3_USLGID UNIQUEIDENTIFIER
        DECLARE  @D3_USLGID_2 UNIQUEIDENTIFIER
        DECLARE  @D3_USLGID_3 UNIQUEIDENTIFIER
        DECLARE  @D3_USLGID_4 UNIQUEIDENTIFIER

        DECLARE @D3_PID INT
        declare @D3_ZSLID INT
        DECLARE @D3_SLID INT

        SET @zsl_id = NEWID() 
        SET @ID_PAC = NEWID()
        SET @SL_ID = NEWID()
        SET @D3_USLGID = NEWID()


        INSERT INTO D3_PACIENT_OMS ( D3_SCID, ID_PAC, FAM, IM, OT,  DR, w,   VPOLIS,  NPOLIS,  SMO, NOVOR)
                            VALUES('23402', @ID_PAC,  @fam, @im, @ot,  @dr, 1,   3,  @npolis,  '46003', '0')

        SET @D3_PID = (SELECT id FROM D3_PACIENT_OMS WHERE ID_PAC = @ID_PAC)

        INSERT INTO D3_ZSL_OMS ( ZSL_ID, D3_PID, D3_PGID, D3_SCID, DATE_Z_1, DATE_Z_2,                   MTR, USERID,  LPU, USL_OK, VIDPOM, FOR_POM, RSLT, ISHOD, IDSP, os_sluch_region)
                          VALUES(@zsl_id, @D3_PID, @ID_PAC, '23402', @d2 + 1, @d2 + 1,   0, 1,        460026, 3, 12, 3, 314, 306, 30, 59)                
              
        SET @D3_ZSLID = (SELECT id FROM d3_zsl_oms WHERE ZSL_ID = @zsl_id)                
                
        INSERT INTO D3_SL_OMS ( D3_ZSLID, D3_ZSLGID, SL_ID, DATE_1, DATE_2, DS1, VERS_SPEC, WEI, prvs, profil, det,  LPU_1, IDDOKT, p_cel, p_cel25,dn)
        VALUES(@D3_ZSLID, @zsl_id, @SL_ID, @d2 + 1, @d2 + 1,@ds1, 'V021', 0, 76, 97,  0,  301,  @doc, '1.3', '1.3', 1)
   
   
   
   
        -- Get the next vendor.
    FETCH NEXT FROM vendor_cursor
    INTO @fam, @im, @ot, @dr, @doc, @d2, @ds1,@npolis
END
CLOSE vendor_cursor;
DEALLOCATE vendor_cursor;