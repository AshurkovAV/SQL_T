SELECT dl.*,
CASE WHEN MONTH(dr) IN (1,2,3) THEN 1
	WHEN MONTH(dr) IN (4,5,6) THEN 2
	WHEN MONTH(dr) IN (7,8,9) THEN 3
	WHEN MONTH(dr) IN (10,11,12) THEN 4 ELSE 100 END,
	1, 0
--UPDATE [DISP_Lists] SET TargetQuarter = CASE WHEN MONTH(dr) IN (1,2,3) THEN 1
--	WHEN MONTH(dr) IN (4,5,6) THEN 2
--	WHEN MONTH(dr) IN (7,8,9) THEN 3
--	WHEN MONTH(dr) IN (10,11,12) THEN 4 ELSE 100 END, MoSolutionId = 1, RejectMoResonId = 0
FROM [DISP_Lists] dl
JOIN ATTP_People AS ap ON ap.ID = dl.PID
WHERE dl.Mo = 460026 AND dl.TargetYear = 2022 --AND dl.DispType='ƒ¬3' 
AND dl.MoSolutionId = 1
AND dl.RejectTFReasonId = 0
AND dl.Reserve = 0 AND TargetQuarter = 3













----ÌÓ‚˚È ÔËÍ‡Á 2019

UPDATE dl SET dl.TargetQuarter = 4, dl.MoSolutionId = 1, dl.Reserve = 0
FROM DISP_Lists AS dl
WHERE id IN (
SELECT TOP 210 dl.ID-- dl.TargetQuarter, COUNT(*)
FROM [DISP_Lists] dl
JOIN ATTP_People AS ap ON ap.ID = dl.PID
WHERE  dl.Mo = 460026 
AND dl.TargetYear = 2022 
AND dl.DispType='Œœ¬' 
AND dl.MoSolutionId = 0
AND dl.RejectTFReasonId = 0
--AND dl.Reserve = 1 --AND TargetQuarter = 2
)


UPDATE dl SET dl.Reserve = 1
FROM DISP_Lists AS dl
WHERE id IN (
SELECT TOP 36053 dl.ID-- dl.TargetQuarter, COUNT(*)
FROM [DISP_Lists] dl
JOIN ATTP_People AS ap ON ap.ID = dl.PID
WHERE  dl.Mo = 460026 
AND dl.TargetYear = 2022 
AND dl.DispType='Œœ¬' 
AND dl.MoSolutionId = 0
AND dl.RejectTFReasonId = 0
--AND dl.Reserve = 1 --AND TargetQuarter = 2
)



SELECT  dl.TargetQuarter, COUNT(*)
FROM [DISP_Lists] dl
JOIN ATTP_People AS ap ON ap.ID = dl.PID
WHERE dl.PrMo = 460026 
AND dl.DispType = 'Œœ¬' 
AND dl.TargetYear = 2022
AND dl.MoSolutionId = 1
AND dl.Reserve = 0
AND dl.RejectTFReasonId = 0
--AND TargetQuarter = 0
GROUP BY dl.TargetQuarter
----ÌÓ‚˚È ÔËÍ‡Á 2019






UPDATE dl SET dl.Reserve = 0, dl.MoSolutionId = 1, dl.RejectMoResonId = 0, dl.TargetQuarter = 4
FROM DISP_Lists AS dl
WHERE id IN (
SELECT TOP 1386 dl.ID-- dl.TargetQuarter, COUNT(*)
FROM [DISP_Lists] dl
JOIN ATTP_People AS ap ON ap.ID = dl.PID
WHERE  dl.Mo = 460026 AND dl.TargetYear = 2019 
AND dl.DispType='Œœ¬' 
AND dl.MoSolutionId = 1
AND dl.RejectTFReasonId = 0
--AND ap.Fam = '«¿¬¿À»ÿ»Õ¿' AND ap.Im='ÀﬁƒÃ»À¿'
AND dl.Reserve = 1 
and TargetQuarter = 4
)


















--SELECT *
--FROM ATTP_People AS ap WHERE ap.ID = 213098