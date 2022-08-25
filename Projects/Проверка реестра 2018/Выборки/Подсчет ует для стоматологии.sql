SELECT 

--sl.ID, 
sum(CASE WHEN DATEDIFF(DAY, pa.DR, sl.DATE_2)/365.2524 >= 18 THEN csu.Adult
ELSE csu.Child END )edcol, SUM(ed_col)
--, sl.ED_COL, pa.DR, du.KOL_USL
--UPDATE sl SET ED_COL = ?
FROM D3_ZSL zsl
JOIN PACIENT pa on zsl.D3_PID = pa.ID
join D3_SL sl on sl.d3_zslid=zsl.id
JOIN D3_USL AS du ON du.D3_ZSLID = zsl.ID AND du.D3_SLID = sl.ID
JOIN CalcStomatUet AS csu ON du.VID_VME = csu.Code
WHERE 
zsl.D3_SCID = 2060
AND zsl.OS_SLUCH_REGION IS NULL 
AND sl.PROFIL IN (85,86,87,88,89,90)
 --AND sl.ED_COL=0.00
--GROUP BY sl.ID