--SELECT s.DNAPR, DATEADD(DAY, -1, s.DATE_1), *
UPDATE s SET s.DNAPR = DATEADD(DAY, -1, s.DATE_1)
FROM SLUCH AS s
WHERE s.SCHET_ID = 2136 AND s.EKMP_COMENT like '%NPR_DATE%'

 --Не заполнено обязательное поле код МО, направившей на лечение, NPR_MO в ЗАКОНЧЕННОМ СЛУЧАЕ;  Не заполнено поле NPR_DATE дата направления на лечение для круглосут стационара и Плановой формы МП; 
 
--SELECT s.NPR_MO, *
UPDATE s SET s.NPR_MO = 460026
FROM SLUCH AS s
WHERE s.SCHET_ID = 2136 AND s.EKMP_COMENT like '%NPR_MO%'