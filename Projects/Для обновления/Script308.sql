CREATE FUNCTION [dbo].[ot131t5_]
(
	@zab NVARCHAR(255),
	@nstr NVARCHAR(10),
    @MKB3 NVARCHAR(255),         
    @ReestrMedOrgID INT,
    @OsobSluch NVARCHAR(255)      
)
RETURNS  TABLE
AS 
RETURN
(	
		SELECT 
			@zab zab,
			@MKB3 MKB,  
			@nstr nstr,
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
			isnull(SUM(CASE WHEN pv.W = 2 AND DATEDIFF(YEAR, pv.DR, pv.HelpStart) > 60 THEN 1 ELSE 0 END),0) '> 60G',
			isnull(SUM(CASE WHEN pv.HelpResult = 314 THEN 1 ELSE 0 END),0) disnab			
			FROM PacientVisit AS pv
			WHERE pv.ReestrMedOrgID = @ReestrMedOrgID
			AND pv.OsobSluch IN (SELECT name FROM RASPARS(@OsobSluch))	
			AND pv.MKB IN (SELECT name FROM RASPARS(@MKB3))		
);
