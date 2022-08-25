--UPDATE AttachedDoc_ONLINE SET SCurrent = 0, D_Otk = '20160122'
SELECT *
FROM AttachedDoc_ONLINE
WHERE id IN (SELECT MIN(id)
			 FROM AttachedDoc_ONLINE AS ado
			 WHERE ado.SCurrent = 1
			 GROUP BY ado.PID
			 HAVING COUNT(*) > 1)
			 
SELECT *
FROM AttachedDoc_ONLINE
WHERE id IN (SELECT MAX(id)
			 FROM AttachedDoc_ONLINE AS ado
			 WHERE ado.SCurrent = 1
			 GROUP BY ado.PID
			 HAVING COUNT(*) > 1)
			 
SELECT *
FROM AttachedDoc_ONLINE
WHERE pid = 3969832