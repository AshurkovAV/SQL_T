 SELECT distinct dpo.FAM, dpo.IM, dpo.OT, cast(dpo.DR AS DATE) [дата рождения], duo.COMENTU, duo.DATE_IN, dzo.OS_SLUCH_REGION, ds1, cast(dso.DATE_1 AS DATE)[дата начала], cast(dso.DATE_2 AS DATE) [дата окончания], 
  (SELECT TOP 1 ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = dso.IDDOKT)[Доктор], 
  (SELECT v002.NameWithID FROM v002 WHERE IDPR = dso.PROFIL)[профиль],
  ap.AdrOmsRegion, ap.AdrOmsNaspunkt ,ap.AdrOmsUl, ap.AdrOmsDom, ap.AdrOmsKorp, ap.AdrOmsKv
FROM D3_ZSL_OMS AS dzo
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
LEFT JOIN D3_USL_OMS AS duo ON duo.D3_SLID = dso.ID
JOIN Yamed_Spr_MedicalEmployee AS ysme ON dso.IDDOKT = ysme.SNILS
LEFT JOIN (SELECT fam, im, ot, dr, 
ap.AdrOmsRegion, ap.AdrOmsNaspunkt ,ap.AdrOmsUl, ap.AdrOmsDom, ap.AdrOmsKorp, ap.AdrOmsKv
 FROM [SQL_COD].[DocExchange].[dbo].[ATTP_People] ap )ap ON ap.FAM = dpo.FAM AND ap.IM = dpo.IM AND ap.OT = dpo.OT AND ap.DR = dpo.DR 
JOIN (SELECT -- SUBSTRING(ambk, 12, LEN(ambk) - 11) ambk, 
			SUBSTRING(fio, 1, CHARINDEX(' ', fio, 1))fam, 
			SUBSTRING(fio, CHARINDEX(' ', fio, 1) + 1, CHARINDEX(' ', fio, CHARINDEX(' ', fio, 1) + 1) - CHARINDEX(' ', fio, 1)) im, npolis
  FROM [elmed].[dbo].FileQueryVtb) AS t ON dpo.FAM = t.fam AND t.IM = dpo.IM --AND dpo.NPOLIS = t.npolis
WHERE 
--dso.NHISTORY IN(SELECT SUBSTRING(ambk, 12, LEN(ambk) - 11)
--  FROM [elmed].[dbo].[Rep_Sel_spis1_2_mee$]) AND 
 ysme.OTD_ID = 15 AND
  dzo.DATE_Z_1 BETWEEN CAST('20190901' AS DATE) AND CAST('20200131' AS DATE)
  ORDER BY dpo.FAM, dpo.IM, dpo.OT