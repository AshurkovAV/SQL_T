--SELECT id, username, org_code, org_type, dt, report_code, wtime, parameters, comment,  resultFileName, resultFileDt, resultFileSize, StatusRepots
UPDATE s SET s.dt = '2022-02-06 15:25:36.973', s.resultFileDt = '2022-02-06 15:56:39.813', s.resultFileName = 'Списки прикрепленного к МО населения_02.06.2022 15-56-38.zip' 
FROM DOX_Reports s 
WHERE username = '460026_s' AND id = 8977