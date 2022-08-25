DECLARE @ReestrMedOrgID INT = 5121
----SELECT q, pv.TFR_Q, pv.TFR_COMENT2, SUBSTRING(pv.TFR_COMENT2, 16, 5) FROM PacientVisit AS pv
--UPDATE PacientVisit SET Q = SUBSTRING(TFR_COMENT2, 16, 5)
--WHERE ReestrMedOrgID = @ReestrMedOrgID
--AND TFR_COMENT1 = 'Некорректный код СМО'


SELECT 
CASE WHEN tfr_coment2 LIKE '%Полис нового образца%' THEN 1 ELSE 0 END,
q, pv.TFR_Q, pv.TFR_COMENT2, SUBSTRING(pv.TFR_COMENT2, 16, 5) FROM PacientVisit AS pv
--UPDATE PacientVisit SET Q = SUBSTRING(TFR_COMENT2, 16, 5)
WHERE ReestrMedOrgID = @ReestrMedOrgID
AND (TFR_COMENT2 LIKE 'По ФИО ДР удалось обнаружить следующий(е) ДПФС в РРЗ:%' OR TFR_COMENT2 LIKE 'По ФИО ДР удалось обнаружить следующий(е) ДПФС в ЦС%')

--По ФИО ДР удалось обнаружить следующий(е) ДПФС в РРЗ: Полис нового образца 4693289721000068 СМО: ООО "РОСМЕДСТРАХ-К" выдан: 12.07.2017; 
