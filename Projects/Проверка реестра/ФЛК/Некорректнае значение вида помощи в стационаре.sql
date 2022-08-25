declare @schetid int = 2055
SELECT ID, 'VIDPOM' IM_POL, 'SLUCH' BAS_EL, IDCASE IDCASE, NULL IDSERV, 
	   'Некорректнае значение вида помощи в стационаре' COMMENT
FROM sluch AS sl
WHERE sl.USL_OK = 2 AND sl.VID_HMP is null AND sl.LPU_1 in (201, 211, 212, 213, 214, 215, 216, 217, 218) and sl.VIDPOM NOT IN (31,4)
and SCHET_ID = @schetid
UNION
SELECT ID, 'VIDPOM' IM_POL, 'SLUCH' BAS_EL, IDCASE IDCASE, NULL IDSERV, 
	   'Некорректнае значение вида помощи в стационаре' COMMENT
FROM sluch AS sl
WHERE sl.USL_OK = 2 AND sl.LPU_1 in (202,203,204,205,206,207,208,209,210) and sl.PROFIL not in (57,68,97) and sl.VIDPOM NOT IN (13,4)
and SCHET_ID = @schetid
UNION
SELECT ID, 'VIDPOM' IM_POL, 'SLUCH' BAS_EL,  IDCASE IDCASE, NULL IDSERV, 
	   'Некорректнае значение вида помощи в стационаре' COMMENT
FROM sluch AS sl
WHERE sl.USL_OK = 2 AND sl.LPU_1 in (202,203,204,205,206,207,208,209,210) and sl.PROFIL in (57,68,97) and sl.VIDPOM NOT IN (12,4)
and SCHET_ID = @schetid
UNION
SELECT ID, 'VIDPOM' IM_POL, 'SLUCH' BAS_EL, IDCASE IDCASE, NULL IDSERV, 
	   'Некорректнае значение вида помощи в стационаре' COMMENT
FROM sluch AS sl
WHERE sl.USL_OK = 1 AND sl.VID_HMP is null AND sl.VIDPOM NOT IN (31,4)
and SCHET_ID = @schetid
UNION
SELECT ID, 'VIDPOM' IM_POL, 'SLUCH' BAS_EL,  IDCASE IDCASE, NULL IDSERV, 
	   'Некорректнае значение вида помощи' COMMENT
FROM sluch AS sl
WHERE sl.VIDPOM IN (1,2,3)
and SCHET_ID = @schetid