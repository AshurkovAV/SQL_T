USE elmed
--Выгрузить данные из медиалога загрузить в Elmed далее выполнить данный скрипт
DECLARE @p INT = 2095 --Номер реестра

SELECT tab.doc, spec, kol, tab1.doc,[kolemk], ([kolemk]*100)/kol procent 
FROM(
SELECT 
(SELECT TOP 1 ISNULL(db.FAM, '') + ' ' + ISNULL(im, '') + ' ' + ISNULL(ot, '')  
 FROM Yamed_Spr_MedicalEmployee AS db WHERE db.SNILS = ds.IDDOKT) doc, 
ISNULL((SELECT scd.NameWithId FROM v021 AS scd WHERE scd.IDSPEC = ds.PRVS),'пусто')spec, COUNT(*) kol
FROM D3_ZSL_OMS AS dz
JOIN D3_SL_OMS AS ds ON ds.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS sc ON sc.ID = dz.D3_SCID 
WHERE dz.USL_OK = 3 AND dz.D3_SCID = @p AND dz.OS_SLUCH_REGION IS NULL
GROUP BY ds.IDDOKT, ds.PRVS) AS tab
FULL JOIN (SELECT doc 
      ,kolemk     
FROM ['Количество принятых пациентов ($']
WHERE  doc not IN (
 'Белоус Надежда Николаевна'
,'Болычева Марина Леонидовна'
,'Мартынов Евгений Геннадьевич'
,'Мулеванова Нина Николаевна'
,'Ольховикова Анастасия Владимировна'
,'Сибилева Елена Анатольевна'
,'Телитченко Лариса Алексеевна'
,'Калашников Андрей Анатольевич'
,'Харланов Денис Николаевич'
,'Мяснянкина Галина Николаевна'
,'Пономаренко Дарья Владимировна'
,'ГЕРАСИМЕНКО СЕРГЕЙ ВЛАДИМИРОВИЧ'
,'Системный администратор'
,'Подкосов Денис Сергеевич'
,'ГЕРАСИМЕНКО СЕРГЕЙ ВЛАДИМИРОВИЧ')) AS tab1 ON tab.doc = tab1.doc 
ORDER BY --spec, 
         tab.doc