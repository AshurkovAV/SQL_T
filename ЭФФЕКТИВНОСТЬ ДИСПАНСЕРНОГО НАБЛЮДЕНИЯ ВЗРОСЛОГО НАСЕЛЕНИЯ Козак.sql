use elmed
go

DECLARE @d DATETIME = GETDATE()

SELECT 3 gr, dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
      'Семейный полипоз толстой кишки, синдром Гартнера, синдром Пейца-Егерса, синдром Турко' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'D12.6'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 4 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
      'Полип прямой кишки' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 IN ('D12.8', 'К62.1')
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 5 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
      'Гепатоцеллюлярная аденокарцинома' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'D13.4'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 6 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
      'Полип желчного пузыря' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'D37.6'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 7 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
      'Сахарный диабет инсулиннезависимый' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 LIKE 'E11%'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 8 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
      'Гиперхолестеринемия (при уровне общего холестерина более 8,0 ммоль/л)' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 LIKE 'E78%'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 9 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
      'Болезни с повышенным АД' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND (ds1 LIKE 'I10%' OR ds1 LIKE  'I11%' OR ds1 LIKE 'I12%' OR ds1 LIKE 'I13%' OR ds1 LIKE 'I14%' OR ds1 LIKE 'I15%')
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 10 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
      'ИБС' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND (ds1 LIKE 'I20%' OR ds1 LIKE  'I21%' OR ds1 LIKE 'I22%' OR ds1 LIKE 'I23%' OR ds1 LIKE 'I24%' OR ds1 LIKE 'I25%')
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 11 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
      'Предсердно-желудочковая (атриовентрикулярная) блокада и блокада левой ножки пучка Гиса, другие нарушения проводимости, остановка сердца, пароксизмальная тахикардия, другие нарушения сердечного ритма' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND (ds1 LIKE 'I44%' OR ds1 LIKE  'I45%' OR ds1 LIKE 'I46%' OR ds1 LIKE 'I47%' OR ds1 LIKE 'I49%')
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 12 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
      'Фибрилляция и (или) трепетание предсердий' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 LIKE 'I48%'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 13 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
      'Хроническая сердечная недостаточность I - II ФК по NYHA, но не выше стадии 2а' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 LIKE 'I50%'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 14 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
      'Стеноз внутренней сонной артерии от 40%' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1= 'I65.2' 
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 15 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
      'Другие уточненные поражения сосудов мозга' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'I67.8'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 16 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
      'Последствия субарахноидаль-ного, внутричерепного, другого нетравматического кровоизлияния, инфаркта мозга, неуточненного инсульта' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 IN ('I69.0','I69.1','I69.2','I69.3','I69.4')
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 17 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
      'Состояние после перенесеной пневмонии' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND (ds1 LIKE 'J12%' OR ds1 LIKE 'J13%' OR ds1 LIKE 'J14%')
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 18 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
      'Бронхит хронический и неуточненный' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 IN ('J41.0','J41.1','J41.8')
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 19 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
      'ХОБЛ с острой респираторной инфекцией нижних дыхательных путей' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'J44.0'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 20 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
      'Другая уточненная хроническая обструктивная легочная болезнь' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'J44.8'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 21 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
      'ХОБЛ неуточненная ' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'J44.9'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 22 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
     'Бронхиальная астма' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 IN ('J45.0','J45.1','J45.8','J45.9')
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 23 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
     'Бронхоэктатическая болезнь' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'J47.0' 
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR


UNION 

SELECT 24 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
      'Интерстициальные легочные заболевания' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'J84.1' 
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 25 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
      'Эзофагит' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 LIKE 'K20%' 
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 26 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
      'Гастроэзофагеальный рефлюкс с эзофагитом' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'K21.0' 
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 27 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
      'Ахалазия кардии' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'K22.0' 
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 28 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
      'Непроходимость пищевода ' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'K22.2' 
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 29 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
      'Пищевод Барретта' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'K22.7' 
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 30 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
      'Язвенная болезнь желудка' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 LIKE 'K25%' 
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 31 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
      'Язвенная болезнь двенадцатиперстной кишки' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 LIKE 'K26%' 
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 32 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
      'Хронический атрофический гастрит, неуточненный гастрит' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 IN ('K29.4','K29.5')
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 33 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
      'Полипы желудка и двенадцатиперстной кишки' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'K31.7'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 35 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
      'Болезнь Крона' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 LIKE 'K50%'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 36 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
      'Язвенный колит' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 LIKE 'K51%'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 37 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
      'Цирроз печени' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 IN ('K70.3','K74.3','K74.4','K74.5','K74.6')
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 38 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
      'Хронический панкреатит с внешнесекреторной недостаточностью' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 LIKE 'K86%'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 39 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
      'Остеопороз первичный' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'M81.5'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 40 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
      'Состояние после перенесенной ОПН, Пациенты, страдающие ХБП (независимо от ее причины и стадии), в стабильном состоянии с ХПН 1 стадии' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'N18.1'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 41 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
      'ХБП неуточненная ' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'N18.9'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 42 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
      'Предиабет' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 IN('R73.0','R73.9')
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 43 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
      'Наличие искусственного водителя ритма' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 ='Z95.0'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 44 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
      'Наличие аортокоронарного шунтового трансплантата' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 ='Z95.1'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 45 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [ВзДети],
      DS1_PR [с впервые в жизни установленным диагнозом], 
      'Наличие коронарного ангиопластического импланта и трансплантата' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 ='Z95.5'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR









