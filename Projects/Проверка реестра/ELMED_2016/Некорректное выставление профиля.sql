--Посещение терапевта(код 97) оплачиваем >или=18лет в поликлинике и >=15 в стационаре, иначе МЭК 5.1.4

declare @p1 int = 2061

SELECT sl.ID, SUMV, sl.USL_OK, 'Некорректное выставление профиля'
from SLUCH sl
join PACIENT pa on sl.PID = pa.ID 
where sl.SCHET_ID = @p1 AND ((datediff(DAY, pa.DR, sl.DATE_2)/365.2524 < 18 AND sl.PROFIL = 97 and usl_ok=3)or(datediff(DAY, pa.DR, sl.DATE_2)/365.2524 < 15 AND sl.PROFIL = 97 and usl_ok in (1,2)))
--UPDATE sl SET PROFIL = 68, MSPID = 22
--from SLUCH sl
--join PACIENT pa on sl.PID = pa.ID 
--where sl.SCHET_ID = @p1 AND ((datediff(DAY, pa.DR, sl.DATE_2)/365.2524 < 18 AND sl.PROFIL = 97 and usl_ok=3))

--Посещение педиатра(код 68) оплачиваем <или=18лет, иначе МЭК 5.1.4. ИСКЛЮЧЕНИЕ беременные, они опл.
UNION
--declare @p1 int = 4114

SELECT sl.ID, SUMV, sl.USL_OK, 'Некорректное выставление профиля'
from SLUCH sl
join PACIENT pa on sl.PID = pa.ID 
where sl.SCHET_ID = @p1 AND datediff(DAY, pa.DR, sl.DATE_2)/365.2524 >= 18 AND sl.PROFIL = 68

--UPDATE sl SET PROFIL = 97, MSPID = 27
--from SLUCH sl
--join PACIENT pa on sl.PID = pa.ID 
--where sl.SCHET_ID = @p1 AND datediff(DAY, pa.DR, sl.DATE_2)/365.2524 >= 18 AND sl.PROFIL = 68