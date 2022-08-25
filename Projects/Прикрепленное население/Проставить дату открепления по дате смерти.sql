UPDATE AttachedLpu_ONLINE SET D_Otk = p.ds
FROM AttachedLpu_ONLINE AS alo
JOIN AttachedPeople_ONLINE AS p ON p.ID = alo.PID
WHERE p.HID = 17 AND p.DS IS NOT null