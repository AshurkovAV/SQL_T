/* всего по каждой группе  */
use elmed
go

DECLARE @d DATETIME = GETDATE()

SELECT 3 gr, dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      '—емейный полипоз толстой кишки, синдром √артнера, синдром ѕейца-≈герса, синдром “урко' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'D12.6'



UNION 

SELECT 4 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'ѕолип пр€мой кишки' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 IN ('D12.8', ' 62.1')



UNION 

SELECT 5 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      '√епатоцеллюл€рна€ аденокарцинома' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'D13.4'



UNION 

SELECT 6 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'ѕолип желчного пузыр€' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'D37.6'



UNION 

SELECT 7 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      '—ахарный диабет инсулиннезависимый' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'E11%'



UNION 

SELECT 8 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      '√иперхолестеринеми€ (при уровне общего холестерина более 8,0 ммоль/л)' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'E78%'



UNION 

SELECT 9 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'Ѕолезни с повышенным јƒ' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND (ds1 LIKE 'I10%' OR ds1 LIKE  'I11%' OR ds1 LIKE 'I12%' OR ds1 LIKE 'I13%' OR ds1 LIKE 'I14%' OR ds1 LIKE 'I15%')



UNION 

SELECT 10 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      '»Ѕ—' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND (ds1 LIKE 'I20%' OR ds1 LIKE  'I21%' OR ds1 LIKE 'I22%' OR ds1 LIKE 'I23%' OR ds1 LIKE 'I24%' OR ds1 LIKE 'I25%')



UNION 

SELECT 11 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'ѕредсердно-желудочкова€ (атриовентрикул€рна€) блокада и блокада левой ножки пучка √иса, другие нарушени€ проводимости, остановка сердца, пароксизмальна€ тахикарди€, другие нарушени€ сердечного ритма' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND (ds1 LIKE 'I44%' OR ds1 LIKE  'I45%' OR ds1 LIKE 'I46%' OR ds1 LIKE 'I47%' OR ds1 LIKE 'I49%')



UNION 

SELECT 12 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      '‘ибрилл€ци€ и (или) трепетание предсердий' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'I48%'



UNION 

SELECT 13 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      '’роническа€ сердечна€ недостаточность I - II ‘  по NYHA, но не выше стадии 2а' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'I50%'



UNION 

SELECT 14 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      '—теноз внутренней сонной артерии от 40%' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1= 'I65.2' 



UNION 

SELECT 15 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'ƒругие уточненные поражени€ сосудов мозга' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'I67.8'



UNION 

SELECT 16 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'ѕоследстви€ субарахноидаль-ного, внутричерепного, другого нетравматического кровоизли€ни€, инфаркта мозга, неуточненного инсульта' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 IN ('I69.0','I69.1','I69.2','I69.3','I69.4')



UNION 

SELECT 17 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      '—осто€ние после перенесеной пневмонии' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND (ds1 LIKE 'J12%' OR ds1 LIKE 'J13%' OR ds1 LIKE 'J14%')



UNION 

SELECT 18 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'Ѕронхит хронический и неуточненный' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 IN ('J41.0','J41.1','J41.8')



UNION 

SELECT 19 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      '’ќЅЋ с острой респираторной инфекцией нижних дыхательных путей' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'J44.0'



UNION 

SELECT 20 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'ƒруга€ уточненна€ хроническа€ обструктивна€ легочна€ болезнь' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'J44.8'



UNION 

SELECT 21 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      '’ќЅЋ неуточненна€ ' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'J44.9'



UNION 

SELECT 22 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
     'Ѕронхиальна€ астма' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 IN ('J45.0','J45.1','J45.8','J45.9')



UNION 

SELECT 23 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
     'Ѕронхоэктатическа€ болезнь' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'J47.0' 




UNION 

SELECT 24 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      '»нтерстициальные легочные заболевани€' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'J84.1' 



UNION 

SELECT 25 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'Ёзофагит' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'K20%' 



UNION 

SELECT 26 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      '√астроэзофагеальный рефлюкс с эзофагитом' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'K21.0' 



UNION 

SELECT 27 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'јхалази€ кардии' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'K22.0' 



UNION 

SELECT 28 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'Ќепроходимость пищевода ' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'K22.2' 



UNION 

SELECT 29 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'ѕищевод Ѕарретта' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'K22.7' 



UNION 

SELECT 30 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'язвенна€ болезнь желудка' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'K25%' 



UNION 

SELECT 31 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'язвенна€ болезнь двенадцатиперстной кишки' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'K26%' 



UNION 

SELECT 32 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      '’ронический атрофический гастрит, неуточненный гастрит' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 IN ('K29.4','K29.5')



UNION 

SELECT 33 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'ѕолипы желудка и двенадцатиперстной кишки' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'K31.7'



UNION

SELECT 35 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'Ѕолезнь  рона' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'K50%'



UNION

SELECT 36 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'язвенный колит' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'K51%'



UNION

SELECT 37 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      '÷ирроз печени' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 IN ('K70.3','K74.3','K74.4','K74.5','K74.6')



UNION

SELECT 38 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      '’ронический панкреатит с внешнесекреторной недостаточностью' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'K86%'



UNION

SELECT 39 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'ќстеопороз первичный' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'M81.5'



UNION

SELECT 40 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      '—осто€ние после перенесенной ќѕЌ, ѕациенты, страдающие ’Ѕѕ (независимо от ее причины и стадии), в стабильном состо€нии с ’ѕЌ 1 стадии' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'N18.1'



UNION

SELECT 41 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      '’Ѕѕ неуточненна€ ' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'N18.9'



UNION

SELECT 42 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'ѕредиабет' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 IN('R73.0','R73.9')



UNION

SELECT 43 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'Ќаличие искусственного водител€ ритма' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 ='Z95.0'



UNION

SELECT 44 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'Ќаличие аортокоронарного шунтового трансплантата' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 ='Z95.1'



UNION

SELECT 45 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'Ќаличие коронарного ангиопластического импланта и трансплантата' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 ='Z95.5'



UNION

SELECT 47 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'Ќарушение обмена липопротеинов и другие липидемии' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'E78%'



UNION

SELECT 48 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      '’роническа€ ревматическа€ болезнь сердца (при пороках сердца и крупных сосудов)' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND (ds1 LIKE 'I05%' OR ds1 LIKE 'I06%' OR ds1 LIKE 'I07%' OR ds1 LIKE 'I08%' OR ds1 LIKE 'I09%')



UNION

SELECT 49 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'Ѕолезни, характеризующиес€ повышенным кров€ным давлением, при артериальной гипертензии, резистентной и медикаментозной терапии и(или) в сочетании с сахарным диабетом и(или) хронической болезнью почек —4 и выше стадии' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND (ds1 LIKE 'I10%' OR ds1 LIKE 'I11%' OR ds1 LIKE 'I12%' OR ds1 LIKE 'I13%' OR ds1 LIKE 'I14%'  OR ds1 LIKE 'I15%')



UNION

SELECT 50 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      '»шемическа€ болезнь сердца' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND (ds1 LIKE 'I20%' OR ds1 LIKE 'I21%' OR ds1 LIKE 'I22%' OR ds1 LIKE 'I23%' OR ds1 LIKE 'I24%'  OR ds1 LIKE 'I25%')



UNION

SELECT 51 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'Ћегочна€ эмболи€' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'I26%'



UNION

SELECT 52 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'ѕервична€ легочна€ гмпертензи€, другие болезни легочных сосудов, друга€ вторична€ легочна€ гипертензи€, другие уточненные формы легочно-сердечной недостаточности' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND (ds1 = 'I27.0' OR ds1 LIKE 'I28%' OR ds1 = 'I27.2' OR ds1 = 'I27.8')



UNION

SELECT 53 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'ќстрый и подострый эндокардит. Ёндокардит, клапан не уточнен, эндокардит и поражение клапанов сердца при болезн€х,  классифицированных в другихз рубриках' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND (ds1 LIKE 'I33%' OR ds1 LIKE 'I38%' OR ds1 LIKE 'I39%')



UNION

SELECT 54 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'Ќеревматические поражени€ митрального клапана, аортального клапана, трехстворчатого клапана, поражени€ клапана легочной артерии' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND (ds1 LIKE 'I34%' OR ds1 LIKE 'I35%' OR ds1 LIKE 'I36%' OR ds1 LIKE 'I37%')



UNION

SELECT 55 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'ќстрый миокардит. ћиокардит при болезн€х, классифицированных в других рубриках. ћиокардит неуточненный' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND (ds1 LIKE 'I40%' OR ds1 LIKE 'I41%' OR ds1 = 'I51.4')



UNION

SELECT 56 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      ' ардиомиопати€' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'I42%'



UNION

SELECT 57 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'ѕредсердно-желудочкова€ (атриовентрикул€рна€) блокада и блокада левой ножки пучка √иса, другие нарушени€ проводимости, остановка сердца, пароксизмальна€ тахикарди€, другие нарушени€ сердечного ритма' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND (ds1 LIKE 'I44%' OR ds1 LIKE 'I45%' OR ds1 LIKE 'I46%' OR ds1 LIKE 'I47%' OR ds1 LIKE 'I49%')



UNION

SELECT 58 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      '‘ибрилл€ци€ и (или) трепетание предсердий' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'I48%'



UNION

SELECT 59 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      '—ердечна€ недостаточность' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'I50%'



UNION

SELECT 60 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'ƒефект перегородки сердца приобретенный, разрыв сухожилий хорды, не классифицированный в других рубриках, разрыв сосочковой мышцы, не классифицированный в других рубриках' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 IN('I51.0','I51.1','I51.2')



UNION 

SELECT 61 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      '«акупорка и стеноз сонной артерии' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'I65.2'



UNION 

SELECT 62 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'јневризма и расслоение аорты' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'I71%'



UNION 

SELECT 63 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      '¬рожденные аномалии (пороки развити€) системы кровообращени€ (состо€ние после оперативного лечени€)  врожденных аномалий (пороков развити€) системы кровообращени€' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND (ds1 LIKE 'Q20%' OR ds1 LIKE 'Q21%' OR ds1 LIKE 'Q22%' OR ds1 LIKE 'Q23%' OR ds1 LIKE 'Q24%' OR ds1 LIKE 'Q25%' OR ds1 LIKE 'Q26%' OR ds1 LIKE 'Q27%' OR ds1 LIKE 'Q28%')



UNION 

SELECT 64 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'Ќаличие искусственного водител€ сердечного ритма' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'Z95.0'



UNION 

SELECT 65 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'Ќаличие аорто-коронарного шунтового трансплантанта' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'Z95.1'



UNION

SELECT 66 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'Ќаличие протеза сердечного клапана, наличие ксеногенного сердечного клапана, наличие другого заменител€ сердечного клапана, наличие других сердечных и сосудистых имплантов и трансплантатов, наличие сердечного и сосудистого импланта и трансплантата неуточненных' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 IN('Z95.2','Z95.3','Z95.4','Z95.8','Z95.9')



UNION

SELECT 67 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'Ќаличие коронарного ангиопластичного импланта трансплантата' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 ='Z95.5'



UNION

SELECT 69 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],     
      '’ронический вирусный гепатит ¬ и (или) хронический вирусный гепатит —' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 IN ('B18.0','B18.1','B18.2')



UNION

SELECT 70 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],     
      'Ѕолезнь, вызванна€ вирусом иммунодефицита человека (¬»„)' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND (ds1 LIKE 'B20%' OR ds1 LIKE 'B21%' OR ds1 LIKE 'B22%' OR ds1 LIKE 'B23%' OR ds1 LIKE 'B24%')


UNION

SELECT 72 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],     
      'јденома надпочечника' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 = 'D35.0'


UNION

SELECT 73 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],     
      'јденома паращитовидной железы. ѕервичный гиперпаратиреоз' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 IN ('D35.1','E21.0')


UNION

SELECT 74 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],     
      'ћножественна€ эндокринна€ неоплази€: тип 2ј (синдром —иппла); тип 2¬ (синдром √орлина)' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 IN ('D44.8','D35.0','D35.1','D35.8')


UNION

SELECT 75 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],     
      'Ќетоксический одноузловой  зоб, нетоксический многоузловой зоб, тиреотоксикоз с токсическим одноузловым зобом, тиреотоксикоз с токсическим многоузловым зобом' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 IN ('E04.1','E04.2','E05.1','E05.2')


UNION

SELECT 76 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],     
      'јкромегали€' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 = 'E22.0'


UNION

SELECT 77 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],     
      '√руппа заболеваний с нарушением формировани€ пола (варианты дисгенезии гонад и синдромов резистентности к андрогенам)' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 = 'E34.5'


UNION

SELECT 78 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],     
      'ћножественный эндокринный аденоматоз, тип I (ћЁј-1, синдром ¬ернера)' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 IN ('E34.8','D13.7','D35.0','D35.1','D35.2','D35.8')


UNION

SELECT 80 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],     
      '“уберозный склероз' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 = 'Q85.1'


UNION

SELECT 82 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],     
      'ƒоброкачественное новообразование больших слюнных желез' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'D11%'


UNION

SELECT 83 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],     
      'ѕолиостозна€ фиброзна€ дисплази€' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 = 'Q78.1'


UNION

SELECT 85 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],     
      'ѕростатическа€ интраэпителиальна€ неоплази€ простаты' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 = 'D29.1'


UNION

SELECT 86 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],     
      'јнгиомиолипома почки' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 = 'D30.0'


UNION

SELECT 87 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],     
      'ѕапилломы, полипы мочевого пузыр€' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 = 'D30.3'


UNION

SELECT 88 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],     
      'ѕапилломы, полипы мочеиспускательного канала' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 = 'D30.4'


UNION

SELECT 89 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],     
      '—ложные кисты почек' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 = 'D41.0'


UNION

SELECT 90 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],     
      'Ћейкоплаки€ полового члена' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 = 'N48.0'


UNION

SELECT 92 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],     
      '—олитарные и множественные остеохондромы' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'D16%'


UNION

SELECT 93 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],     
      'Ёнхондроматоз (дисхондроплази€, болезнь ќллье)' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 = 'Q78.4'


UNION

SELECT 94 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],     
      '‘иброзна€ дисплази€' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'M85%'


UNION

SELECT 95 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],     
      'Ѕолезнь ѕеджета (костей) деформирующий остеит' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'M88%'


UNION

SELECT 96 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],     
      'ѕоражение костно-мышечной системы после медицинских процедур на опрно-двигательном аппарате в св€зи с опухолевым и системным поражением' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'M96%'


UNION

SELECT 98 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],     
      'ƒоброкачественное новообразование глаза и его придаточного аппарата. ƒоброкачественное новообразование кожи века, включа€ спайку век' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND (ds1 LIKE 'D31%' OR ds1 = 'D23.1')


UNION

SELECT 100 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'ƒоброкачественное новообразование миндалины, доброкачественное новообразование других частей ротоглотки, доброкачественное новообразование носоглотки, доброкачественное новообразование гортаноглотки,доброкачественное новообразование глотки неуточненной локализации' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 IN ('D10.4','D10.5','D10.6','D10.7','D10.9')


UNION

SELECT 101 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'Ќовообразование среднего уха' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'D14%'


UNION

SELECT 102 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      '»нвертированна€ папиллома полости носа' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'D14.0'


UNION

SELECT 103 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'ѕапилломатоз, фиброматоз гортани' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'D14.1'


UNION

SELECT 104 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'ƒоброкачественное новообразование трахеи' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'D14.2'


UNION

SELECT 105 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      '’ронический ринит, назофарингит, фарингит' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'J31%'


UNION

SELECT 106 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'ѕолип носа' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'J33%'


UNION

SELECT 107 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      '’ронический ларингит и ларинготрахеит' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'J37%'


UNION

SELECT 108 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'ѕолип голосовой складки и гортани' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'J38.1'


UNION

SELECT 110 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'ƒоброкачественное новообразование губы, доброкачественное новообразование €зыка, доброкачественное новообразование дна по-лости рта, доброкачественное новообразо-вание других неуточненных частей рта' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 IN ('D10.0','D10.1','D10.2','D10.3')


UNION

SELECT 111 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'јбразивный хейлит ћанганотти, органичес-кий гиперкератоз, бородавчатый предрак' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'K13.0'


UNION

SELECT 112 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'Ћейкоплаки€ и другие изменени€ эпители€ полости рта, включа€ €зык' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'K13.2'


UNION

SELECT 113 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'меланоз полости рта' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'K13.7'


UNION

SELECT 114 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'красный плоский лишай (плоский лишай слизистой оболчки рта)' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'L43%'


UNION

SELECT 115 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'полиостозна€ фиброзна€ дисплази€' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'Q78.1'


UNION

SELECT 117 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      '—индром диспластических невусов, синдром FAMM (семейный синдром атипических множественных невусов), синдром FAMM (семейный синдром анипических множественных невусов с мелономой)' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'D22%'


UNION

SELECT 118 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'Ќевус ядассона, синдром √орлина-√ольца, синдром Ѕазекса, синдром –ембо' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'D23%'


UNION

SELECT 119 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'јктинический кератоз' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'L57.1'


UNION

SELECT 120 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'Ёруптивный себорейный кератоз (как про€вление фотоповреждени€ кожи)' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'L82%'


UNION

SELECT 121 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      ' серодерма пигмента€' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'Q82.1'


UNION

SELECT 122 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      '¬рожденные гигантские и крупные невусы' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'Q82.5'


UNION

SELECT 124 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'Ќовообразовани€ неопределенного или неизвестного характера €ичника' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'D39.1'


UNION

SELECT 125 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'ѕолипы шейки матки и эндометри€' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'N84%'


UNION

SELECT 126 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      '∆елезиста€ гиперплази€ эндометри€' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'N85.0'


UNION

SELECT 127 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'јденоматозна€ гиперплази€ эндометри€' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'N85.1'


UNION

SELECT 128 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      '”меренна€ дисплази€ шейки матки, цервикальна€ интраэпителиальна€ неоплази€ (CIN) II степени' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'N87.1'


UNION

SELECT 129 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      '–езко выраженна€ дисплази€ шейки матки, не классифицированна€ в других рубриках, цервикальна€ интраэпителиальна€ неоплази€ (CIN) III степени' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'N87.2'


UNION

SELECT 130 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'Ћейкоплаки€ шейки матки' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'N88.0'


UNION

SELECT 131 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      '—индром поликистоза €ичников' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'E28.2'


UNION

SELECT 133 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'ƒоброкачественное новообразование молочной железы' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'D24%'


UNION

SELECT 134 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '¬зрослые'
ELSE 'ƒети' END [¬зƒети],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN 'старше трудоспособ-ного возраста '
      ELSE 'трудоспособ-ного возраста' END [¬зƒети],
       
      'ƒоброкачественна€ дисплази€ молочной железы' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'N60%'






















