declare @sc int = 7047
UPDATE dzo SET VIDPOM = d.vidpom2
FROM D3_ZSL_OMS AS dzo 
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN doct_v002_v015_v021 d ON d.SNILS = dso.IDDOKT
WHERE dzo.D3_SCID = @sc

UPDATE dso SET PROFIL = d.profil2, PRVS = d.prvs2
FROM D3_ZSL_OMS AS dzo 
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN doct_v002_v015_v021 d ON d.SNILS = dso.IDDOKT
WHERE dzo.D3_SCID = @sc

UPDATE duo SET PROFIL = d.profil2, PRVS = d.prvs2
FROM D3_ZSL_OMS AS dzo 
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_USL_OMS AS duo ON duo.D3_SLID = dso.ID
JOIN doct_v002_v015_v021 d ON d.SNILS = dso.IDDOKT
WHERE dzo.D3_SCID = @sc