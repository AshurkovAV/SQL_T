SELECT 
(SELECT fo.mcod + ' ' + fo.nam_mok FROM F003_ONLINE AS fo WHERE fo.mcod = ID_MO) MO, 
(SELECT audo.SNILS
   FROM AttachedUchDoct_ONLINE AS audo WHERE audo.ID = ID_DOCT) doc, count(*)kol
FROM AttachedPeople_ONLINE
GROUP BY ID_MO, ID_DOCT
ORDER BY MO