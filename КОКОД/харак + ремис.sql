UPDATE dso SET C_ZAB = 3
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
WHERE dzo.D3_SCID = 4114 AND dzo.EXP_COMENT LIKE '%’арактер заболевани€ не соответствует установленному диагнозу%'
AND dso.C_ZAB = 1

UPDATE dzo SET ISHOD = 302, EXP_COMENT = NULL
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
WHERE dzo.D3_SCID = 2516 AND dzo.EXP_COMENT LIKE '% Ќесоответствие между установленным характером заболевани€ и исходом заболевани€ %'
--AND dso.C_ZAB = 1

UPDATE dso SET C_ZAB = 3
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
WHERE dzo.D3_SCID = 2516 AND dzo.EXP_COMENT LIKE '%Ќесоответствие между установленным характером заболевани€ и исходом заболевани€ (— характером заболевани€ ќстрое - не может быть исход заболевани€ –емисси€%'
AND dso.C_ZAB = 1

UPDATE dzo SET EXP_COMENT = NULL
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
WHERE dzo.D3_SCID = 2516 AND dzo.EXP_COMENT LIKE '%Ќесоответствие между установленным характером заболевани€ и исходом заболевани€ (— характером заболевани€ ќстрое - не может быть исход заболевани€ –емисси€%'