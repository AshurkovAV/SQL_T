UPDATE duo SET VID_VME = 'A03.16.001'
FROM D3_PACIENT_OMS AS dpo 
JOIN D3_ZSL_OMS AS dzo ON dzo.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_USL_OMS AS duo ON duo.D3_SLID = dso.ID
WHERE dzo.D3_SCID = 2898 AND dzo.EXP_COMENT LIKE '%медицинская услуга заполнена не из v001%'
AND duo.CODE_USL = 'R01.001.004.002'

UPDATE duo SET VID_VME = 'A03.18.001'
FROM D3_PACIENT_OMS AS dpo 
JOIN D3_ZSL_OMS AS dzo ON dzo.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_USL_OMS AS duo ON duo.D3_SLID = dso.ID
WHERE dzo.D3_SCID = 2898 AND dzo.EXP_COMENT LIKE '%медицинская услуга заполнена не из v001%'
AND duo.CODE_USL = 'R01.001.004.004'

UPDATE duo SET VID_VME = null
FROM D3_PACIENT_OMS AS dpo 
JOIN D3_ZSL_OMS AS dzo ON dzo.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_USL_OMS AS duo ON duo.D3_SLID = dso.ID
WHERE dzo.D3_SCID = 2898 AND dzo.EXP_COMENT LIKE '%медицинская услуга заполнена не из v001%'
AND duo.CODE_USL = 'R01.001.004.005'

UPDATE duo SET VID_VME = null
FROM D3_PACIENT_OMS AS dpo 
JOIN D3_ZSL_OMS AS dzo ON dzo.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_USL_OMS AS duo ON duo.D3_SLID = dso.ID
WHERE dzo.D3_SCID = 2898 AND dzo.EXP_COMENT LIKE '%медицинская услуга заполнена не из v001%'
AND duo.CODE_USL IN ( 'R01.001.003.003', 'R01.001.003.002', 'R01.001.003.001')



SELECT duo.CODE_USL, duo.VID_VME
FROM D3_PACIENT_OMS AS dpo 
JOIN D3_ZSL_OMS AS dzo ON dzo.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_USL_OMS AS duo ON duo.D3_SLID = dso.ID
WHERE dzo.D3_SCID = 2898 AND dzo.EXP_COMENT LIKE '%медицинская услуга заполнена не из v001%'
--AND duo.CODE_USL = 'R01.001.004.002'
GROUP BY duo.CODE_USL, duo.VID_VME