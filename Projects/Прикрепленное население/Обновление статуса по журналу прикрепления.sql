--UPDATE AttachedPeople_ONLINE SET id_mo = ajo.ID_MO_AKTIV, hid = ajo.hid, attach_doct_date = ajo.DATA_ZAYAVLENIYA
SELECT *
FROM AttachedPeople_ONLINE p
INNER JOIN AttachedJournal_ONLINE AS ajo ON p.ID = ajo.pid
WHERE p.id IN (
SELECT id
FROM AttachedPeople_ONLINE p
WHERE p.id IN 
(SELECT pid 
 FROM [AttachedJournal_ONLINE] as j 
 WHERE j.ID_MO_AKTIV = 460023
AND j.[STATUS] = 4 AND j.x_Status IS NULL
AND p.ID_MO <> j.ID_MO_AKTIV
) )--AND id = 156011