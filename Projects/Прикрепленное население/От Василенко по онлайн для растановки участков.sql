SELECT lpu.UCH_ID, u.Uchastok, p.HID 
FROM [dbo].[AttachedLpu_ONLINE] lpu
JOIN [dbo].[AttachedPeople_ONLINE] p ON p.ID = lpu.PID 
LEFT JOIN [dbo].[AttachedUchastok_ONLINE] u ON u.ID = lpu.UCH_ID
WHERE u.HID <> p.HID
GROUP BY lpu.UCH_ID, u.Uchastok, p.HID
