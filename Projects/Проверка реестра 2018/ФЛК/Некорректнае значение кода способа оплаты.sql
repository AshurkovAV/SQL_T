SELECT sl.ds1, *
FROM D3_ZSL AS dz
JOIN D3_SL AS sl ON dz.ID = sl.D3_ZSLID
JOIN PACIENT AS p ON dz.D3_PID = p.ID
WHERE dz.D3_SCID = 2071 AND 
--(sl.USL_OK = 1 AND dz.IDSP <> 33) 
--or (sl.USL_OK = 2 AND dz.IDSP <> 43)  
 (sl.USL_OK = 3 AND left(P_CEL, 1) = '1' and OS_SLUCH_REGION is null and dz.IDSP not in (23,29,11))
OR (sl.USL_OK = 3 AND left(P_CEL, 1) = '2' and dz.IDSP not in (29, 41)) 
OR (sl.USL_OK = 3 AND left(P_CEL, 1) = '3' and dz.IDSP <> 30)  
OR (sl.USL_OK = 4 and dz.IDSP <> 24)
OR (dz.OS_SLUCH_REGION in (6,21,29,30,31,32,33,34,35,36,37,38,39,40) and dz.IDSP <> 28)
OR (dz.OS_SLUCH_REGION in (7,8,9,11,12,17,18,22,23) and dz.IDSP <> 11)
