SELECT p.FAM, p.IM, p.OT, p.DR, zsl.DATE_Z_1, zsl.DATE_Z_2, sl.DS1
from D3_ZSL zsl
join D3_SL sl on zsl.ID = sl.D3_ZSLID
JOIN PACIENT AS p ON zsl.D3_PID = p.id
where D3_SCID = 2059 AND zsl.OS_SLUCH_REGION = 23
AND sl.DS1 = 'I11.9' AND MONTH(zsl.DATE_Z_2) = 1