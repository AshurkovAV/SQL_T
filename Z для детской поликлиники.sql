SELECT 
SUM( case when dso.ds1 like 'Z01.0' then 1 else 0 end ) as 'Z01.0',
SUM( case when dso.ds1 like 'Z01.1' then 1 else 0 end ) as 'Z01.1',
SUM( case when dso.ds1 like 'Z01.2' then 1 else 0 end ) as 'Z01.2',
SUM( case when dso.ds1 like 'Z01.3' then 1 else 0 end ) as 'Z01.3',
SUM( case when dso.ds1 like 'Z01.4' then 1 else 0 end ) as 'Z01.4',
SUM( case when dso.ds1 like 'Z01.5' then 1 else 0 end ) as 'Z01.5'
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID --AND dso2.NSCHET LIKE '%+%'
JOIN Yamed_Spr_MedicalEmployee AS ysme ON ysme.SNILS = dso.IDDOKT -- AND ysme.LPU_ID = 460026
WHERE dso.DS1 IN ('Z01.0', 'Z01.1', 'Z01.2', 'Z01.3', 'Z01.4', 'Z01.5' )  
AND dso2.[YEAR] = 2022 AND dso2.[MONTH] IN(1,2,3,4,5,6,7,8)
and  (datediff(dd,dpo.DR,dso.DATE_1)/365.25)<18


SELECT 
SUM( case when dso.ds1 like 'Z01.6' then 1 else 0 end ) as 'Z01.6',
SUM( case when dso.ds1 like 'Z01.8' then 1 else 0 end ) as 'Z01.8',
SUM( case when dso.ds1 like 'Z02.4' then 1 else 0 end ) as 'Z02.4',
SUM( case when dso.ds1 like 'Z02.5' then 1 else 0 end ) as 'Z02.5',
SUM( case when dso.ds1 like 'Z02.7' then 1 else 0 end ) as 'Z02.7',
SUM( case when dso.ds1 like 'Z02.8' then 1 else 0 end ) as 'Z02.8',
SUM( case when dso.ds1 like 'Z03.8' then 1 else 0 end ) as 'Z03.8',
SUM( case when dso.ds1 like 'Z11.5' then 1 else 0 end ) as 'Z11.5',
SUM( case when dso.ds1 like 'Z20.8' then 1 else 0 end ) as 'Z20.8',
SUM( case when dso.ds1 BETWEEN 'Z22.0' AND 'Z22.9' then 1 else 0 end ) as 'Z22',
SUM( case when dso.ds1 like 'Z22.8' then 1 else 0 end ) as 'Z22.8',
SUM( case when dso.ds1 like 'Z20.8' then 1 else 0 end ) as 'Z20.8',
SUM( case when dso.ds1 BETWEEN 'Z23.0' AND 'Z27.9' then 1 else 0 end ) as 'Z23-Z27',
SUM( case when dso.ds1 BETWEEN 'Z30.0' AND 'Z39.9' then 1 else 0 end ) as 'Z30-Z39',
SUM( case when dso.ds1 like 'Z20.8' then 1 else 0 end ) as 'Z20.8',
SUM( case when dso.ds1 like 'Z72.0' then 1 else 0 end ) as 'Z72.0',
SUM( case when dso.ds1 like 'Z76.0' then 1 else 0 end ) as 'Z76.0'
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID --AND dso2.NSCHET LIKE '%+%'
JOIN Yamed_Spr_MedicalEmployee AS ysme ON ysme.SNILS = dso.IDDOKT -- AND ysme.LPU_ID = 460026
WHERE (dso.DS1 IN ('Z01.6', 'Z01.8', 'Z02.4', 'Z02.5', 'Z02.7', 'Z02.8',  'Z03.8', 'Z11.5', 'Z20.8', 'Z22.8', 'Z72.0', 'Z76.0') OR 
(dso.DS1 BETWEEN 'Z23.0' AND 'Z27.9' ) OR 
(dso.DS1 BETWEEN 'Z22.0' AND 'Z22.9' ) OR
(dso.DS1 BETWEEN 'Z30.0' AND 'Z39.9' ) 
)  
AND dso2.[YEAR] = 2022 AND dso2.[MONTH] IN(1,2,3,4,5,6,7,8)
and  (datediff(dd,dpo.DR,dso.DATE_1)/365.25)<18