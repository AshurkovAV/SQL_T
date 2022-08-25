DECLARE @uslOk INT = 1
declare @CODEUSLK NVARCHAR(11) = 'TF1.K01.001'
declare @CODEUSLD NVARCHAR(11) = 'TF1.D01.001'
DECLARE @schetID INT = 2115
SELECT p.FAM [Фамилия], p.IM [Имя], CAST(p.DR AS DATE) [Дата рождения], p.NPOLIS, f.NameWithID,
CAST(sl.DATE_1 AS DATE) [Д нач], CAST(sl.DATE_2 AS DATE)[Д окон], 
sl.DS1 [Перв диаг],
sd2.ds [Диаг ослож], 
(SELECT db.FioWithId FROM DoctorBd AS db WHERE db.id = sl.IDDOKTO) [Доктор],
(SELECT v.NameWithID FROM V006 AS v WHERE v.id = sl.USL_OK) [Условия оказания],
isnull(sl.TARIF, u.TARIF) [Тариф],
isnull(sl.SUMV, u.SUMV_USL) [Сумма выс], 
REPLACE((SELECT od.NameWithID FROM OtdelDb AS od WHERE od.Id = u.PODR), '                   ','') [Код отделения],
sl.LPU_1 [Подразделение], sl.NHISTORY [Номер истории болезни],
(SELECT ckt.NameWithID FROM SprKsg AS ckt WHERE ckt.ID = u.IDKSG)[КСГ],
CASE WHEN sl.usl_ok = 1 THEN DATEDIFF(DAY,sl.date_1, sl.date_2) ELSE DATEDIFF(DAY,sl.date_1, sl.date_2) + 1  END
AS Койкодни--, s.[MONTH]
  FROM [SLUCH] sl
  LEFT JOIN (SELECT * FROM USL u WHERE u.CODE_USL IN (SELECT CASE WHEN @uslOk = 1 THEN @CODEUSLK ELSE @CODEUSLD END)  ) AS u  ON u.SLID = sl.ID
  INNER JOIN PACIENT AS p ON p.ID = sl.PID
  LEFT JOIN (SELECT SLID, dbo.GROUP_CONCAT_DS(DISTINCT DS, N' , ', 1) DS FROM SLUCH_DS2 GROUP BY SLID)AS sd2  ON sd2.SLID = sl.ID
  LEFT JOIN F002 AS f ON f.smocod = p.SMO
  JOIN SCHET AS s ON s.ID = sl.SCHET_ID
WHERE 
sl.SCHET_ID = @schetID AND sl.USL_OK = @uslOk AND u.IDKSG IS NOT NULL
ORDER BY p.FAM, p.IM, p.OT