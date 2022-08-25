DECLARE @schnew INT = 2143
DECLARE @zid INT, @schold INT, @scom NVARCHAR(500)
DECLARE vendor_cursor CURSOR FOR 
	SELECT dzo.id, dzo.D3_SCID, dso.S_COM
	FROM D3_ZSL_OMS AS dzo
	JOIN D3_SANK_OMS AS dso ON dso.D3_ZSLID = dzo.ID
	WHERE dso.S_COM NOT LIKE 'Перекрест%' 
	AND dso.S_COM NOT LIKE 'Не удалось идентифицировать по%'
	AND dso.S_COM NOT LIKE 'Нет действующего страхован%'
	AND dso.S_COM NOT LIKE 'Пациент не прикреплен к данной%'
	
OPEN vendor_cursor

FETCH NEXT FROM vendor_cursor INTO @zid, @schold, @scom

WHILE @@FETCH_STATUS = 0
BEGIN	
	EXEC p_copy_zap @schnew, @schold, @zid, @scom
	
	FETCH NEXT FROM vendor_cursor INTO @zid, @schold, @scom
END;
CLOSE vendor_cursor;
DEALLOCATE vendor_cursor;