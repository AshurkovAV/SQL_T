DECLARE @p1 INT =15105

SELECT        TOP (200) ID,[ID_PAC]      ,[FAM]      ,[IM]      ,[OT]      ,[W]      
		,[DR],DOST      ,[TEL]      ,[FAM_P]      ,[IM_P]      
		,[OT_P]      ,[W_P]      ,[DR_P],DOST_P      ,[MR]      ,[DOCTYPE]      ,[DOCSER]
      ,[DOCNUM] ,DOCDATE,DOCORG     ,[SNILS]      ,[OKATOG]      ,[OKATOP]      ,[COMENTP]
FROM            D3_PACIENT_OMS
WHERE        (ID_PAC IN
                             (SELECT        id_pac
                               FROM            (SELECT DISTINCT 
                                                                                   p.ID_PAC, p.FAM, p.IM, p.OT, p.W, CONVERT(varchar(10), p.DR, 20) AS DR, p.DOST, p.TEL, p.FAM_P, p.IM_P, p.OT_P, p.W_P, p.DR_P, 
                                                                                   p.DOST_P, p.MR, p.DOCTYPE, p.DOCSER, p.DOCNUM, p.DOCDATE, p.DOCORG, p.SNILS, p.OKATOG, p.OKATOP, p.COMENTP
                                                         FROM            D3_ZSL_OMS AS zsl INNER JOIN
                                                                                   D3_PACIENT_OMS AS p ON zsl.D3_PID = p.ID
                                                         WHERE        (zsl.D3_SCID = @p1)) AS T
                               GROUP BY ID_PAC
                               HAVING         (COUNT(*) > 1)))
                               
ORDER BY ID_PAC