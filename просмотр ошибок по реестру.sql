SELECT rtrim(ltrim(dzo.EXP_COMENT)), 
(SELECT yu.UserName FROM Yamed_Users AS yu WHERE yu.ID =  dzo.USERID)u, COUNT(*) kol
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
 WHERE dzo.D3_SCID = 3862 AND dzo.EXP_COMENT IS NOT NULL
group by dzo.EXP_COMENT, dzo.USERID
ORDER BY u, kol