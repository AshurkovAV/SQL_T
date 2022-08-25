DECLARE @ID INT = 2115 --id счета
SELECT pa.FAM, pa.IM, pa.OT, pa.DR
FROM D3_PACIENT_OMS pa	
join D3_ZSL_OMS zsl on pa.ID = zsl.D3_PID	
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
WHERE zsl.D3_SCID = @ID AND zsl.USL_OK = 3 
AND zsl.OS_SLUCH_REGION IS NULL --AND zsl.VIDPOM = 13
AND sl.PROFIL IN (63,85,86,87,88,89,90) 
--AND sl.PROFIL = 97
--AND sl.P_CEL25 = '1.1' --dbo.f_GetAge(pa.dr,date_z_1)<18  --AND zsl.VIDPOM = 13

--GROUP BY pa.FAM, pa.IM, pa.OT, pa.DR

--SELECT p.FAM, p.IM, p.OT, p.DR
--FROM SLUCH AS s
--JOIN PACIENT AS p ON p.ID = s.PID
--WHERE s.SCHET_ID = @ID AND s.USL_OK = 1 AND s.VIDPOM = 31
----GROUP BY p.FAM, p.IM, p.OT, p.DR