CREATE FUNCTION [dbo].[RASPARS]
(
    @MKB NVARCHAR(255)     
)
RETURNS @TAB TABLE
(
	name VARCHAR(255)
)
AS 
BEGIN
	DECLARE @t TABLE (name VARCHAR(255))
	INSERT INTO @t
	SELECT @MKB
	INSERT @TAB
	SELECT SUBSTRING( name, i2 + 1, i1 - i2 -1 ) name
	FROM
	(
	SELECT t1.name
		 , charindex( ' ', t1.name + ' ', number ) i1
		 , case when number = 0 then 0 else charindex( ' ', t1.name + ' ', number - 1 ) end i2
	FROM @t t1 
		INNER JOIN master.dbo.spt_values t2
		  ON t2.type = 'P' and number between 0 and len( t1.name )
	) t WHERE i1 != i2
	RETURN
END;