DROP TABLE ztemp_prikrep_not_visit
SELECT t.*
INTO ztemp_prikrep_not_visit
FROM(
	SELECT id PID, FAM, IM, OT, DR, 
		ISNULL(ap.AdrOmsRn, '-') + ' ' + isnull(ap.AdrOmsNaspunkt, '-') + ' ' + isnull(ap.AdrOmsUl, '-') + ' ' + ISNULL(ap.AdrOmsDom, '-') + ' ' + isnull(ap.AdrOmsKorp, '-')  + ' ' + isnull(ap.AdrOmsKv, '-') addr
		FROM sql_cod.DocExchange.dbo.ATTP_People AS ap
		
	WHERE prmo = 460026 AND active = 1 AND dr <= '20050101') AS t
LEFT JOIN( 
	SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR
	FROM D3_SCHET_OMS AS dso2
		JOIN D3_ZSL_OMS AS dzo     ON dzo.D3_SCID  = dso2.ID
		JOIN D3_PACIENT_OMS AS dpo ON dpo.ID       = dzo.D3_PID
		JOIN D3_SL_OMS AS dso      ON dso.D3_ZSLID = dzo.ID
	WHERE (dso2.[YEAR] = 2022 AND dso2.[MONTH] IN (4,5,6,7,8,9,10,11,12)) OR 
	       dso2.[YEAR] = 2023 OR 
	      (dso2.[YEAR] = 2024 AND dso2.[MONTH] IN (1,2,3))
         ) AS t2 ON t2.FAM = t.FAM AND t2.IM = t.IM AND t2.OT = t.OT AND t2.DR = t.DR
WHERE t2.FAM IS NULL


---Отделяем заводскую от союзной-------
SELECT g.*, t.MOBIL_TELEFON, t.mcod, p.*
	FROM ztemp_prikrep_not_visit g
	LEFT JOIN telefon1 AS t ON t.NOM = fam AND t.PRENOM = im AND t.PATRONYME = ot AND t.NE_LE = dr
	LEFT JOIN perepis210723p p ON g.fam = p.fam AND g.im = p.im AND g.ot = p.ot AND g.dr = p.dr
WHERE p.id IS NULL AND 
	(addr NOT LIKE '%заводс%' OR
	addr NOT LIKE '%дейнек%' OR
	addr NOT LIKE '%сумская%' OR 
	addr NOT LIKE '%кулакова%' OR 
	addr NOT LIKE '%парковая%' OR
	addr NOT LIKE '%клыков%' OR 
	addr NOT LIKE '%клыкова%')  
	
	
	SELECT g.*, t.MOBIL_TELEFON, t.mcod, p.*
	FROM ztemp_prikrep_not_visit g
	LEFT JOIN telefon1 AS t ON t.NOM = fam AND t.PRENOM = im AND t.PATRONYME = ot AND t.NE_LE = dr
	LEFT JOIN test.dbo.prikrep7KGP p ON g.fam = p.Фамилия AND g.im = p.Имя AND g.ot = p.Отчество AND g.dr = p.[Дата рождения]
WHERE p.[Номер карты] IS  NULL AND 
	(addr NOT LIKE '%заводс%' OR
	addr NOT LIKE '%дейнек%' OR
	addr NOT LIKE '%сумская%' OR 
	addr NOT LIKE '%кулакова%' OR 
	addr NOT LIKE '%парковая%' OR
	addr NOT LIKE '%клыков%' OR 
	addr NOT LIKE '%клыкова%')  