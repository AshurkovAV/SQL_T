SELECT distinct t.*, dbo.GROUP_CONCAT_DS(DISTINCT DIAG10, N' , ', 1) DS 
FROM [elmed].[dbo].[tel_uch] t
JOIN [SQL_COD].[DocExchange].[dbo].[ATTP_People] as d ON t.��� = d.fam AND t.�� = d.im AND t.�� = d.ot AND t.�� = d.dr
JOIN [SQL_COD].[DocExchange].[dbo].[ATTP_DISP_ACCOUNT] as a ON a.PID=d.ID
WHERE a.DIAG10 BETWEEN 'I10' AND 'I13.9'  
GROUP BY [���]
      ,[��]
      ,[��]
      ,[��]
      ,[������]
      ,[�����]
      ,[�����]
      ,[���]
      ,[������]
      ,[��������]
      ,[�������]
      ,[gb]
      ,[���������������]