
SELECT --duo.* 
(SELECT TOP 1 ysme.NameWithID  FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = dso.IDDOKT), COUNT(*)
FROM D3_ZSL_OMS AS dzo
	JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
		JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
			JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
				JOIN D3_USL_OMS AS duo ON duo.D3_SLID = dso.ID
WHERE dso2.[YEAR] = 2025 AND dso2.[MONTH] = 7 AND duo.VID_VME IN ('A26.06.041', 'A26.06.041.002', 'A26.06.041.001.01', 'A26.05.019.001', 'A26.06.036', 'A26.06.040') 
AND dzo.OS_SLUCH_REGION IN (47,49) 
GROUP BY dso.IDDOKT




---вставляем код

--INSERT INTO D3_USL_OMS
--(D3_SLID,
--	D3_ZSLID,
--	D3_SLGID,
--	LPU,
--	PROFIL,
--	VID_VME,
--	DET,
--	DATE_IN,
--	DATE_OUT,
--	DS,
--	CODE_USL,
--	KOL_USL,
--	PRVS,
--	CODE_MD,
--	VERS_SPEC
--)
--SELECT DISTINCT 
--	D3_SLID,
--	D3_ZSLID,
--	D3_SLGID,
--	LPU,
--	PROFIL,
--	VID_VME,
--	DET,
--	dp,
--	dp,
--	DS,
--	CODE_USL,
--	KOL_USL,
--	PRVS,
--	CODE_MD,
--	VERS_SPEC
--FROM (SELECT p.FAM, p.IM, p.OT, p.DR, max(dp)dp FROM gepc$ p GROUP BY p.FAM, p.IM, p.OT, p.DR ) as g
-- JOIN (
--SELECT p.FAM, p.IM, p.OT, p.DR, s.ID D3_SLID, zs.ID D3_ZSLID, s.SL_ID D3_SLGID, 460026 LPU, s.PROFIL, 'A26.06.041.002' VID_VME, 0 det, s.DATE_1 DATE_IN, s.DATE_2 DATE_OUT, s.DS1 DS, 'A01.30.026' CODE_USL, 1 KOL_USL, s.PRVS, s.IDDOKT CODE_MD, 'V021' VERS_SPEC
--FROM [D3_SCHET_OMS] sch                  
-- /*inner*/left join D3_PACIENT_OMS p on p.d3_scid=sch.id
-- inner join D3_ZSL_OMS zs on zs.D3_PID=p.id 
--											AND sch.YEAR = 2025
--											AND sch.[MONTH] IN (7)   
--	join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
--		join D3_USL_OMS u ON u.D3_SLID=s.id
--WHERE zs.OS_SLUCH_REGION IN (47,49) 
--AND   u.VID_VME NOT IN ('A26.06.041', 
--						'A26.06.041.002', 
--						'A26.06.041.001.01', 
--						'A26.05.019.001', 
--						'A26.06.036', 
--						'A26.06.040')) AS t 
--											ON t.FAM = g.fam AND 
--											   t.IM = g.im AND 
--											   t.OT = g.ot AND 
--											   t.DR = g.dr 