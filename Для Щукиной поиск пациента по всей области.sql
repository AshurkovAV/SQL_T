SELECT 
(SELECT f.NameWithID FROM f003 f WHERE f.mcod = dso.CODE_MO), dzo.DATE_Z_1, ds1
FROM D3_SCHET_OMS AS dso
JOIN D3_ZSL_OMS AS dzo ON dzo.D3_SCID = dso.ID
JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
JOIN D3_SL_OMS AS dso2 ON dso2.D3_ZSLID = dzo.ID
WHERE dpo.FAM = '����������' AND dpo.IM = '�����' AND dpo.OT = '�����������' --AND dr='19720920'
AND dso.[YEAR] IN (2020,2021, 2022)