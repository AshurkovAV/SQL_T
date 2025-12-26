SELECT 
    c.CallType,
    c.Client,
    c.Employee,
    c.Position,
    c.Через as ViaNumber,
    CAST(c.Дата as DATE) as CallDate,
    CAST(c.Время as TIME) as CallTime,
    CAST(c.Ожидание as TIME) as WaitTime,
    CAST(c.Длительность as TIME) as Duration,
    DAY(c.Дата) as CallDay,
    m.FullName as OperatorName,
    w.Schedule as OperatorSchedule,
    CASE 
        WHEN CHARINDEX('-', w.Schedule) > 0 
        THEN TRY_CAST(LEFT(w.Schedule, CHARINDEX('-', w.Schedule) - 1) + ':00' AS TIME)
        ELSE NULL 
    END as WorkStartTime,
    CASE 
        WHEN CHARINDEX('-', w.Schedule) > 0 
        THEN TRY_CAST(RIGHT(w.Schedule, LEN(w.Schedule) - CHARINDEX('-', w.Schedule)) + ':00' AS TIME)
        ELSE NULL 
    END as WorkEndTime,
    CASE 
        WHEN w.Schedule = 'В' THEN 'Выходной'
        WHEN w.Schedule = 'б/л' THEN 'Больничный'
        WHEN w.Schedule = 'от' THEN 'Отпуск'
        WHEN CHARINDEX('-', w.Schedule) > 0 
             AND CAST(c.Время as TIME) >= TRY_CAST(LEFT(w.Schedule, CHARINDEX('-', w.Schedule) - 1) + ':00' AS TIME)
             AND CAST(c.Время as TIME) <= TRY_CAST(RIGHT(w.Schedule, LEN(w.Schedule) - CHARINDEX('-', w.Schedule)) + ':00' AS TIME)
        THEN 'В рабочее время'
        ELSE 'Вне рабочего времени'
    END as CallStatus,
    m.Priority
FROM elmed.[dbo].[callc10] c
INNER JOIN EmployeeMapping m ON c.Employee = m.Employee
INNER JOIN WorkSchedule w ON m.FullName = w.FullName AND DAY(c.Дата) = w.[Day]
WHERE CAST(c.Дата as DATE) BETWEEN '2025-10-01' AND '2025-10-31'
    AND CHARINDEX('-', w.Schedule) > 0 
    AND CAST(c.Время as TIME) >= TRY_CAST(LEFT(w.Schedule, CHARINDEX('-', w.Schedule) - 1) + ':00' AS TIME)
    AND CAST(c.Время as TIME) <= TRY_CAST(RIGHT(w.Schedule, LEN(w.Schedule) - CHARINDEX('-', w.Schedule)) + ':00' AS TIME)
ORDER BY c.Дата DESC, c.Время DESC;