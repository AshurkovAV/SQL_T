SELECT (SELECT DISTINCT sn.USL + '  ' + sn.NAME_K
          FROM DISP_SPR AS sn WHERE sn.IDDISP = u.DISP_CODE) AS [Код услуги], 
          SUM(CASE WHEN u.UslProv = 1 THEN 1 ELSE 0 END)okazran,
          SUM(CASE WHEN u.Otkaz = 1 THEN 1 ELSE 0 END)otkaz,
          COUNT(*) kol
FROM PacientVisit AS pv
INNER JOIN Uslugi AS u ON u.SluchID = pv.id
WHERE pv.ReestrMedOrgID IN (56)
AND pv.OsobSluch IN (1, 22)
GROUP BY u.DISP_CODE