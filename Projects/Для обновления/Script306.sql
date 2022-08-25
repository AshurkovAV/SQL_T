CREATE FUNCTION [dbo].[ot131t4]
(
	@factris NVARCHAR(255),
    @MKB NVARCHAR(255),  
    @ReestrMedOrgID INT  
)
RETURNS TABLE
AS 
RETURN
(
    SELECT 
    @factris factris,
	@MKB MKB,  
	isnull(COUNT(*),0) kol,
	isnull(SUM(CASE WHEN DATEDIFF(YEAR, pv.DR, pv.HelpStart) BETWEEN 21 AND 36 THEN 1 ELSE 0 END),0) '21 36',
	isnull(SUM(CASE WHEN DATEDIFF(YEAR, pv.DR, pv.HelpStart) BETWEEN 39 AND 60 THEN 1 ELSE 0 END),0) '39 60',
	isnull(SUM(CASE WHEN DATEDIFF(YEAR, pv.DR, pv.HelpStart) > 60 THEN 1 ELSE 0 END),0) '> 60',
	isnull(SUM(CASE WHEN pv.W = 1 THEN 1 ELSE 0 END ),0) kolM,
	isnull(SUM(CASE WHEN pv.W = 1 AND DATEDIFF(YEAR, pv.DR, pv.HelpStart) BETWEEN 21 AND 36 THEN 1 ELSE 0 END),0) '21 36M',
	isnull(SUM(CASE WHEN pv.W = 1 AND DATEDIFF(YEAR, pv.DR, pv.HelpStart) BETWEEN 39 AND 60 THEN 1 ELSE 0 END),0) '39 60M',
	isnull(SUM(CASE WHEN pv.W = 1 AND DATEDIFF(YEAR, pv.DR, pv.HelpStart) > 60 THEN 1 ELSE 0 END),0) '> 60M',
	isnull(SUM(CASE WHEN pv.W = 2 THEN 1 ELSE 0 END ),0) kolG,
	isnull(SUM(CASE WHEN pv.W = 2 AND DATEDIFF(YEAR, pv.DR, pv.HelpStart) BETWEEN 21 AND 36 THEN 1 ELSE 0 END),0) '21 36G',
	isnull(SUM(CASE WHEN pv.W = 2 AND DATEDIFF(YEAR, pv.DR, pv.HelpStart) BETWEEN 39 AND 60 THEN 1 ELSE 0 END),0) '39 60G',
	isnull(SUM(CASE WHEN pv.W = 2 AND DATEDIFF(YEAR, pv.DR, pv.HelpStart) > 60 THEN 1 ELSE 0 END),0) '> 60G'
	
	FROM PacientVisit AS pv
	WHERE pv.ReestrMedOrgID = @ReestrMedOrgID
	AND pv.OsobSluch IN (2, 23)	
	AND pv.MKB IN (SELECT name FROM RASPARS(@MKB))
);