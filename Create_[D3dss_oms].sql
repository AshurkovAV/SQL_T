Create  VIEW [dbo].[D3dss_oms]
AS
SELECT m.MOTCONSU_ID, 
m.KRN_GUID,
 MKB1.CODE [DS]
,NULL AS [DS_PR],2 AS [DS_TYPE]
,NULL AS [PR_DS2_N]
FROM DATA_DIAGNOSIS DD2
JOIN MOTCONSU AS m ON m.MOTCONSU_ID = DD2.MOTCONSU_ID
LEFT JOIN CIM10 MKB1 on MKB1.CIM10_ID = DD2.SS_LKA_CIM10
WHERE dd2.VID_ZABOLEVANIQ = 2
GO

GRANT INSERT ON [dbo].[D3dss_oms] TO [fer]
GO
GRANT SELECT ON [dbo].[D3dss_oms] TO [fer]
GO
GRANT ALTER ON [dbo].[D3dss_oms] TO [fer]
GO
GRANT UPDATE ON [dbo].[D3dss_oms] TO [fer]
GO
GRANT DELETE ON [dbo].[D3dss_oms] TO [fer]
GO
GRANT CONTROL ON [dbo].[D3dss_oms] TO [fer]
GO
GRANT INSERT ON [dbo].[D3dss_oms] TO [iemk_user]
GO
GRANT SELECT ON [dbo].[D3dss_oms] TO [iemk_user]
GO
GRANT ALTER ON [dbo].[D3dss_oms] TO [iemk_user]
GO
GRANT UPDATE ON [dbo].[D3dss_oms] TO [iemk_user]
GO
GRANT DELETE ON [dbo].[D3dss_oms] TO [iemk_user]
GO
GRANT CONTROL ON [dbo].[D3dss_oms] TO [iemk_user]
GO

