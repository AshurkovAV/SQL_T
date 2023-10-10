SELECT*
FROM OtdelDb AS od
WHERE od.OTDID_REGION_NOTEDIT like '4600262068%'-- od.PROFIL = 97 AND od.ConditionID = 2
ORDER BY od.Id

ALTER TABLE OtdelDb ADD idportal NVARCHAR(12)
ALTER TABLE OtdelDb ADD OTDID_REGION_NOTEDIT_portal NVARCHAR(12)
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Код отделения портал' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OtdelDb', @level2type=N'COLUMN',@level2name=N'idportal'
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Код отделения при сохрании случая' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OtdelDb', @level2type=N'COLUMN',@level2name=N'idportal'