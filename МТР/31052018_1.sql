CREATE VIEW [dbo].[ZslEventShortView]
AS
SELECT        t0.ExternalId, t0.MedicalExternalId, t1.AccountId, t1.MedicalAccountId, t0.ZslMedicalEventId AS EventId, t0.PatientId, t2.Surname, t2.PName AS Name, t2.Patronymic, t2.Birthday, t3.POLNAME AS Sex, 
                         t2.BirthPlace,
                             (SELECT        DocSeries
                               FROM            (SELECT        TOP (1) DocSeries
                                                         FROM            dbo.FactDocument AS t12
                                                         WHERE        (PersonId = t2.PersonId)) AS t13) AS DocSeries,
                             (SELECT        DocNum
                               FROM            (SELECT        TOP (1) DocNum
                                                         FROM            dbo.FactDocument AS t14
                                                         WHERE        (PersonId = t2.PersonId)) AS t15) AS DocNum,
                             (SELECT        DocType
                               FROM            (SELECT        TOP (1) DocType
                                                         FROM            dbo.FactDocument AS t14
                                                         WHERE        (PersonId = t2.PersonId)) AS t15_1) AS DocType, t1.INP, t1.InsuranceDocNumber, t1.InsuranceDocSeries, t4.smocod AS Insurance, t5.IDUMP AS AssistanceConditions, 
                         t6.IDDS AS Diagnosis, t0.Price, zme.Rate, zme.Quantity, t0.AcceptPrice, t0.EventBeginZ1, t0.EventEndZ2, t7.IDPR AS Profile, ISNULL(dbo.V015.CODE, dbo.V021.IDSPEC) AS Speciality, t9.IDRMP AS Result, 
                         t10.IDIZ AS Outcome, t11.STNAME AS PaymentStatus, zme.MEC, zme.MEE, zme.EQMA, zme.Comments AS EventComments, dbo.V008.IDVMP AS AssistanceType, t1.InsuranceDocType, t3.Id AS SexCode, 
                         dbo.F010.KOD_OKATO AS TerritoryOkato, t11.IDIDST AS PaymentStatusCode, t0.MoPrice, t0.MoPaymentStatus, dbo.globalMedicalEventType.Name AS EventTypeName, 
                         dbo.globalRegionalAttribute.Name AS RegionalAttributeName, zme.EventType, t0.RegionalAttribute, t5.UMPNAME AS AssistanceConditionsName, dbo.TerritoryAccountView.Type, 
                         dbo.TerritoryAccountView.Direction, dbo.TerritoryAccountView.AccountNumber, dbo.TerritoryAccountView.AccountDate, dbo.TerritoryAccountView.SourceName, dbo.TerritoryAccountView.DestinationName
FROM            dbo.ZslFactMedicalEvent AS t0 INNER JOIN
                         dbo.ZFactMedicalEvent AS zme ON zme.ZslMedicalEventId = t0.ZslMedicalEventId LEFT OUTER JOIN
                         dbo.V008 ON t0.AssistanceType = dbo.V008.Id LEFT OUTER JOIN
                         dbo.FactPatient AS t1 ON t1.PatientId = t0.PatientId LEFT OUTER JOIN
                         dbo.FactPerson AS t2 ON t2.PersonId = t1.PersonalId LEFT OUTER JOIN
                         dbo.V005 AS t3 ON t3.Id = t2.Sex LEFT OUTER JOIN
                         dbo.F002 AS t4 ON t4.Id = t1.InsuranceId LEFT OUTER JOIN
                         dbo.V006 AS t5 ON t5.id = t0.AssistanceConditions LEFT OUTER JOIN
                         dbo.M001 AS t6 ON t6.Id = zme.DiagnosisGeneral LEFT OUTER JOIN
                         dbo.V002 AS t7 ON t7.Id = zme.ProfileCodeId LEFT OUTER JOIN
                         dbo.V009 AS t9 ON t9.Id = t0.Result LEFT OUTER JOIN
                         dbo.V012 AS t10 ON t10.Id = t0.Outcome LEFT OUTER JOIN
                         dbo.F005 AS t11 ON t11.Id = t0.PaymentStatus LEFT OUTER JOIN
                         dbo.F010 ON t1.TerritoryOkato = dbo.F010.Id LEFT OUTER JOIN
                         dbo.globalMedicalEventType ON zme.EventType = dbo.globalMedicalEventType.ID LEFT OUTER JOIN
                         dbo.globalRegionalAttribute ON t0.RegionalAttribute = dbo.globalRegionalAttribute.ID LEFT OUTER JOIN
                         dbo.V015 ON zme.SpecialityCodeV015 = dbo.V015.Id LEFT OUTER JOIN
                         dbo.V021 ON zme.SpecialityCodeV021 = dbo.V021.Id LEFT OUTER JOIN
                         dbo.TerritoryAccountView ON t1.AccountId = dbo.TerritoryAccountView.TerritoryAccountId

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "t0"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 274
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "zme"
            Begin Extent = 
               Top = 6
               Left = 312
               Bottom = 136
               Right = 579
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "V008"
            Begin Extent = 
               Top = 6
               Left = 617
               Bottom = 136
               Right = 791
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t1"
            Begin Extent = 
               Top = 6
               Left = 829
               Bottom = 136
               Right = 1034
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t2"
            Begin Extent = 
               Top = 6
               Left = 1072
               Bottom = 136
               Right = 1299
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t3"
            Begin Extent = 
               Top = 6
               Left = 1337
               Bottom = 119
               Right = 1511
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t4"
            Begin Extent = 
               Top = 120
               Left = 1337
               Bottom = 250
               Right = 1511
            End
            DisplayFlags = 280
            TopColumn = 0
   ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ZslEventShortView'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'      End
         Begin Table = "t5"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t6"
            Begin Extent = 
               Top = 138
               Left = 250
               Bottom = 268
               Right = 424
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t7"
            Begin Extent = 
               Top = 138
               Left = 462
               Bottom = 268
               Right = 636
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t9"
            Begin Extent = 
               Top = 138
               Left = 674
               Bottom = 268
               Right = 848
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t10"
            Begin Extent = 
               Top = 138
               Left = 886
               Bottom = 268
               Right = 1060
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t11"
            Begin Extent = 
               Top = 138
               Left = 1098
               Bottom = 268
               Right = 1272
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "F010"
            Begin Extent = 
               Top = 252
               Left = 1310
               Bottom = 382
               Right = 1484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "globalMedicalEventType"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 366
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "globalRegionalAttribute"
            Begin Extent = 
               Top = 270
               Left = 250
               Bottom = 366
               Right = 424
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "V015"
            Begin Extent = 
               Top = 270
               Left = 462
               Bottom = 400
               Right = 636
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "V021"
            Begin Extent = 
               Top = 270
               Left = 674
               Bottom = 400
               Right = 848
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TerritoryAccountView"
            Begin Extent = 
               Top = 270
               Left = 886
               Bottom = 400
               Right = 1093
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ZslEventShortView'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ZslEventShortView'
GO


