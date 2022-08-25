UPDATE [Elmed].[dbo].[PEOPLE]
   SET   
   ENP = 3150999795000269
  --[FAM] = 'ВОРОБЬЕВА'
  --    , [IM] = 'МАРИЯ'
  --    , [OT] = 'РОМАНОВНА' 
FROM [PEOPLE] p
WHERE 
  
    --[FAM] = 'Савенко'
    --  AND [IM] = 'екатерина'
    --  AND [OT] = 'алексеевна' 
p.ENP = 4650999795000056  
--id = 1657588   
     
SELECT p.*     
FROM [PEOPLE] p    
WHERE 
[FAM] = 'Бочарова'
      AND [IM] = 'екатерина'
      AND [OT] = 'владимировна' 
 --p.ENP = 4650999795000056
GO

INSERT INTO PEOPLE
(
	FAM,
	IM,
	OT,
	W,
	DR,
	Q,
	NPOL,
	ENP
	
)
VALUES
(
'Луценко','Светлана','Алексеевна' , 2, '19800228', 46002, '5757910871000430', '5757910871000430'
)

DELETE people 


