--INSERT INTO @D3_SANK_OMS
--(
--	 [S_CODE],[S_SUM],[S_SUM2],[S_TIP],[S_OSN],[S_COM],[S_ZAKL],[S_IST],[S_DATE],[D3_ZSLID],[D3_ZSLGID],[D3_SCID],[IMP_ID],[S_Type]
--      ,[S_TIP2],[CODE_EXP],[DATE_ACT],[NUM_ACT],[USER_ID],[MODEL_ID] 
--)
--SELECT  [S_CODE],[S_SUM],[S_SUM2],[S_TIP],[S_OSN],[S_COM],[S_ZAKL],[S_IST],[S_DATE],[D3_ZSLID],[D3_ZSLGID],[D3_SCID],[IMP_ID],[S_Type]
--      ,[S_TIP2],[CODE_EXP],[DATE_ACT],[NUM_ACT],[USER_ID],[MODEL_ID] 
--FROM [TFOMS].[ELMEDICINENEWFOND].[dbo].[D3_SANK_OMS] AS dso
--WHERE dso.D3_SCID IN (3921
--,3951
--,4144
--,4182
--,4227
--,4287) AND dso.S_TIP = 1

BEGIN TRANSACTION t1
INSERT INTO D3_SANK_OMS
(
	 [S_CODE],    [S_SUM],[S_TIP],   [S_OSN],   [S_COM],         [S_DATE],[D3_ZSLID],[D3_ZSLGID],[D3_SCID]
)
SELECT s.zsl_id, s.sumv, s.S_TIP2,    s.s_osn, s.[комментарий мэк], '20231013',dzo.ID, s.zsl_id, dzo.D3_SCID
FROM sank0923$ s 
JOIN D3_ZSL_OMS AS dzo ON dzo.zsl_id = s.zsl_id
JOIN D3_SCHET_OMS AS dso ON dso.ID = dzo.D3_SCID
WHERE dso.[YEAR] = 2023 AND dso.[MONTH] = 9

COMMIT  TRAN t1 