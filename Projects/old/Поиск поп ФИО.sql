SELECT pv.FAM, pv.IM, pv.OT, pv.DR, pv.HelpEnd,
(SELECT db.FIO FROM DoctorBd AS db WHERE pv
.Doctor = db.id)
FROM PacientVisit AS pv
WHERE pv.FAM = '��������'
AND pv.IM = '��������'
AND pv.OT = '��������'
AND pv.OsobSluch = 11
