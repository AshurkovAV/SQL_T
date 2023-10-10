SELECT distinct t.*, dbo.GROUP_CONCAT_DS(DISTINCT DIAG10, N' , ', 1) DS 
FROM [elmed].[dbo].[tel_uch] t
JOIN [SQL_COD].[DocExchange].[dbo].[ATTP_People] as d ON t.фам = d.fam AND t.ИМ = d.im AND t.от = d.ot AND t.др = d.dr
JOIN [SQL_COD].[DocExchange].[dbo].[ATTP_DISP_ACCOUNT] as a ON a.PID=d.ID
WHERE a.DIAG10 BETWEEN 'I10' AND 'I13.9'  
GROUP BY [ФАМ]
      ,[ИМ]
      ,[ОТ]
      ,[ДР]
      ,[Регион]
      ,[Город]
      ,[Улица]
      ,[Дом]
      ,[Корпус]
      ,[Квартира]
      ,[Телефон]
      ,[gb]
      ,[НАШНОМЕРУЧАСТКА]