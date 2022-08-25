SELECT 
( SELECT v.NameWithID
    FROM V002 AS v WHERE v.IDPR =  dso.PROFIL)PROFIL, 
(SELECT f003.NameWithID
   FROM f003 WHERE mcod =  dzo.LPU)LPU, dpo.FAM, dso.IDDOKT, dzo.DATE_Z_1, 
   (SELECT v.NameWithID
    FROM V006 AS v WHERE v.IDUMP =  dzo.USL_OK) usl_ok
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dzo ON dzo.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE --dpo.FAM = 'Морозова' AND dpo.IM = 'Татьяна' AND dpo.OT = 'Георгиевна' AND dpo.DR = '19621102'
      dpo.FAM = 'Жиляев' AND dpo.IM = 'Валерий' AND dpo.OT = 'Владимирович' AND dpo.DR = '19571023'     
      
ORDER BY dso.DATE_1