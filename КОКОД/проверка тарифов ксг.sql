--190+196+200+202 (это телемед)+209+2010 (это случай с ксг) + 212 (гистология)
DECLARE @p1 INT=348
declare @zsl int = @p1
declare @scid int = @p1
declare @marker nvarchar(10) = 'scid'


declare @ks_base numeric (17,2) = 22563.91
declare @ds_base numeric (17,2) = 12272.64


declare @CalcBaseKoefDS table(
	baseKoefDS [numeric](6, 4) NOT NULL,
	[TBEG] [datetime] NOT NULL,
	[TEND] [datetime] NOT NULL)

Insert @CalcBaseKoefDS VALUES (1, '20170101', '20170331')
Insert @CalcBaseKoefDS VALUES (1, '20170401', '20170630')
Insert @CalcBaseKoefDS VALUES (1, '20170701', '20171231')
Insert @CalcBaseKoefDS VALUES (1, '20180101', '20181231')
Insert @CalcBaseKoefDS VALUES (1, '20190101', '20191231')
Insert @CalcBaseKoefDS VALUES (1, '20200101', '20201231')


declare @CalcUslTarif table(
	UslCode nvarchar(20) NOT NULL,
	Tarif numeric (17,2) , 
	[TBEG] [datetime] NULL,
	[TEND] [datetime] NULL)

insert @calcusltarif (UslCode, Tarif) Values('A18.05.002', 5949.00		)
insert @calcusltarif (UslCode, Tarif) Values('A18.05.002.002', 5949.00	)
insert @calcusltarif (UslCode, Tarif) Values('A18.05.002.001', 6246.00	)
insert @calcusltarif (UslCode, Tarif) Values('A18.05.011', 6425.00		)
insert @calcusltarif (UslCode, Tarif) Values('A18.05.004', 5473.00		)
insert @calcusltarif (UslCode, Tarif) Values('A18.05.002.003', 16419.00	)
insert @calcusltarif (UslCode, Tarif) Values('A18.05.003', 17133.00		)
insert @calcusltarif (UslCode, Tarif) Values('A18.05.004.001', 14932.00	)
insert @calcusltarif (UslCode, Tarif) Values('A18.05.011.001', 17906.00	)
insert @calcusltarif (UslCode, Tarif) Values('A18.05.002.005', 31113.00	)
insert @calcusltarif (UslCode, Tarif) Values('A18.05.003.002', 32601.00	)
insert @calcusltarif (UslCode, Tarif) Values('A18.05.011.002', 34088.00	)
insert @calcusltarif (UslCode, Tarif) Values('A18.30.001',	5949.00		)
insert @calcusltarif (UslCode, Tarif) Values('A18.30.001.001', 29269.00	)
insert @calcusltarif (UslCode, Tarif) Values('A18.30.001.002', 7377.00	)
insert @calcusltarif (UslCode, Tarif) Values('A18.30.001.003', 6484.00	)



declare @temp_ksg table(
	[USL_OK] int null,
	[SLID] [int] NULL,
	[ID] [int] NULL,
	[vm_ID] [int] NULL,
	[NKSG] [nvarchar](20) NULL,
	[IDKSG] [nvarchar](20) NOT NULL,
	[USL] [nvarchar](16) NULL,
	[DS1] [nvarchar](10) NULL,
	[DS2] [nvarchar](10) NULL,
	[VOZR] [int] NULL,
	[POL] [int] NULL,
	[DLIT] [int] NULL,
	[DOP_KR] nvarchar(20),
	[DFR] nvarchar(20),
	[tf_idksg] [nvarchar](20) NULL,
	[tf_ds] [nvarchar](10) NULL,
	[sl_ds2] [nvarchar](10) NULL,
	--[KSG_DKK] [nvarchar](20) NULL,
	[vm_vid_vme] [nvarchar](16) NULL,
	[tf_kday] [int] NULL,
	[tf_sumv_usl] [numeric](15, 2) NULL,
	[tf_tarif] [numeric](15, 2) NULL,
	[sl_sumv] [numeric](15, 2) NULL,
	[tf_podr] nvarchar(20),
	--[tf_DATE_1] datetime,
	--[tf_DATE_2] datetime,
	KZ numeric (17,2) NULL,
	UP numeric (17,2) NULL,
	U numeric (17,2) NULL,
	[KDAY] [int] NULL,
	[SUMV_USL] [numeric](10, 2) NULL,
	[TARIF] [numeric](10, 2) NULL
)

declare @temp_ksg_itog table(
	sur_ksg int default (0),
	rn int,
	[USL_OK] int null,
	[SLID] [int] NULL,
	[ID] [int] NULL,
	[vm_ID] [int] NULL,
	[NKSG] [nvarchar](20) NULL,
	[IDKSG] [nvarchar](20) NOT NULL,
	[USL] [nvarchar](16) NULL,
	[DS1] [nvarchar](10) NULL,
	[DS2] [nvarchar](10) NULL,
	[VOZR] [int] NULL,
	[POL] [int] NULL,
	[DLIT] [int] NULL,
	[DOP_KR] nvarchar(20),
	DFR nvarchar(20),
	[tf_idksg] [nvarchar](20) NULL,
	[tf_ds] [nvarchar](10) NULL,
	[sl_ds2] [nvarchar](10) NULL,
	--[KSG_DKK] [nvarchar](20) NULL,
	[vm_vid_vme] [nvarchar](16) NULL,
	[tf_kday] [int] NULL,
	[tf_sumv_usl] [numeric](15, 2) NULL,
	[tf_tarif] [numeric](15, 2) NULL,
	[sl_sumv] [numeric](15, 2) NULL,
	[tf_podr] nvarchar(20),
	--[tf_DATE_1] datetime,
	--[tf_DATE_2] datetime,
	KZ numeric (17,2) NULL,
	UP numeric (17,2) NULL,
	U numeric (17,2) NULL,
	[KDAY] [int] NULL,
	[SUMV_USL] [numeric](10, 2) NULL,
	[TARIF] [numeric](10, 2) NULL

)

INSERT INTO [dbo].[D3_KSG_KPG_OMS]
           ([D3_SLID]
           ,[D3_SLGID]
           ,[KSG_ID])
select sl.ID, sl.SL_ID, newid() nid 
from D3_SL_OMS sl 
join D3_ZSL_OMS z on sl.D3_ZSLID = z.ID and z.USL_OK in (1,2)
left join D3_KSG_KPG_OMS ksg on sl.ID = ksg.D3_SLID
where (
	z.id = @zsl and @marker = 'zsl'
	or
	z.d3_scid = @scid and @marker = 'scid'
	) and sl.METOD_HMP is null and ksg.ID is null

Insert @temp_ksg
select sl.USL_OK, tf.D3_ZSLID as SLID, tf.ID, vm.ID vm_id, ksg.NKSG, v23.K_KSG as IDKSG, ksg.USL, ksg.DS1, ksg.DS2, ksg.VOZR as VOZR, ksg.POL, ksg.DLIT, ksg.[DOP_KR], ksg.DFR,
	d3_ksg.N_KSG tf_idksg, tf.DS1 tf_ds, ds2.ds sl_ds2, vm.VID_VME vm_vid_vme, tf.kd tf_kday, tf.sum_m tf_sumv_usl, tf.tarif tf_tarif, sl.sumv sl_sumv, tf.podr tf_podr,-- tf.DATE_1 tf_DATE_1, tf.DATE_2 tf_DATE_2, 
	t2.KZ, upr.UPR, kf.KUS,
						KDAY = 
							(CASE 
							  WHEN sl.USL_OK = 1 THEN (CASE WHEN cast(tf.DATE_1 as date)= cast(tf.DATE_2 as date) THEN 1 ELSE DATEDIFF(DAY, tf.DATE_1, tf.DATE_2) END)
							  WHEN sl.USL_OK = 2 THEN DATEDIFF(DAY, tf.DATE_1, tf.DATE_2) + 1 -
								(SELECT COUNT(*) FROM dbo.WORK_DAY wd WHERE wd.LPU = sl.LPU and wd.PODR_ID = tf.LPU_1 and H_DATE BETWEEN tf.DATE_1 AND tf.DATE_2)
                            END),
						SUMV_USL =
                            CAST(ROUND((CASE 
							--политравма


                            WHEN sl.USL_OK = 1 and t2.[SSL] > 0 THEN 
                            (CASE 
								WHEN (sl.RSLT in (102, 105, 106, 107, 108, 110)) THEN 
                            		(CASE
									    WHEN d3_ksg.N_KSG in ('1634', '1655', '1656', 'st13.003') and DATEDIFF(DAY, tf.DATE_1, tf.DATE_2) < 4
											THEN ROUND(t2.TARIF*ISNULL(upr.UPR,1.00)*(CASE WHEN d3_ksg.N_KSG in (select [IDKSG] from [dbo].[CalNotKus] Where tf.DATE_2 >= TBEG and tf.DATE_2 < TEND +1) THEN 1.00 ELSE ISNULL(kf.KUS,1.00) END)
												*ISNULL(d3_ksg.IT_SL,1.00) * case when DATEDIFF(DAY, tf.DATE_1, tf.DATE_2) < 4 then  0.80 else 1.00 end , 2)
									    else
											ROUND(t2.TARIF*ISNULL(upr.UPR,1.00)*(CASE WHEN d3_ksg.N_KSG in (select [IDKSG] from [dbo].[CalNotKus] Where tf.DATE_2 >= TBEG and tf.DATE_2 < TEND +1) THEN 1.00 ELSE ISNULL(kf.KUS,1.00) END)
												*ISNULL(d3_ksg.IT_SL,1.00) * case when DATEDIFF(DAY, tf.DATE_1, tf.DATE_2) < 4 then  0.20 else 0.50 end , 2)

									END)
								else
                            		(CASE 
									    WHEN d3_ksg.N_KSG in ('1634', '1655', '1656', 'st13.003') and DATEDIFF(DAY, tf.DATE_1, tf.DATE_2) < 4
											THEN ROUND(t2.TARIF*ISNULL(upr.UPR,1.00)*(CASE WHEN d3_ksg.N_KSG in (select [IDKSG] from [dbo].[CalNotKus] Where tf.DATE_2 >= TBEG and tf.DATE_2 < TEND +1) THEN 1.00 ELSE ISNULL(kf.KUS,1.00) END)
												*ISNULL(d3_ksg.IT_SL,1.00) * case when DATEDIFF(DAY, tf.DATE_1, tf.DATE_2) < 4 then  0.80 else 1.00 end, 2)
									    else	
											ROUND(t2.TARIF*ISNULL(upr.UPR,1.00)*(CASE WHEN d3_ksg.N_KSG in (select [IDKSG] from [dbo].[CalNotKus] Where tf.DATE_2 >= TBEG and tf.DATE_2 < TEND +1) THEN 1.00 ELSE ISNULL(kf.KUS,1.00) END)
												*ISNULL(d3_ksg.IT_SL,1.00) * case when DATEDIFF(DAY, tf.DATE_1, tf.DATE_2) < 4 then  0.20 else 1.00 end, 2)	

									END)
							END)
 
                            WHEN sl.USL_OK = 1 and (t2.[SSL] = -4) THEN 
                            (CASE 
                            WHEN (sl.RSLT in (102, 105, 106, 107, 108, 110)) THEN 
                            	(CASE 
                            		WHEN DATEDIFF(DAY, tf.DATE_1, tf.DATE_2) < 4
										THEN ROUND(t2.TARIF*ISNULL(upr.UPR,1.00)*(CASE WHEN d3_ksg.N_KSG in (select [IDKSG] from [dbo].[CalNotKus] Where tf.DATE_2 >= TBEG and tf.DATE_2 < TEND +1) THEN 1.00 ELSE ISNULL(kf.KUS,1.00) END)*ISNULL(d3_ksg.IT_SL,1.00) * 0.80, 2)
									ELSE ROUND(t2.TARIF*ISNULL(upr.UPR,1.00)*(CASE WHEN d3_ksg.N_KSG in (select [IDKSG] from [dbo].[CalNotKus] Where tf.DATE_2 >= TBEG and tf.DATE_2 < TEND +1) THEN 1.00 ELSE ISNULL(kf.KUS,1.00) END)*ISNULL(d3_ksg.IT_SL,1.00) ,2) 
								END)
							WHEN (sl.RSLT not in (102, 105, 106, 107, 108, 110)) THEN 
                            	(CASE 
                            		WHEN DATEDIFF(DAY, tf.DATE_1, tf.DATE_2) < 4
										THEN ROUND(t2.TARIF*ISNULL(upr.UPR,1.00)*(CASE WHEN d3_ksg.N_KSG in (select [IDKSG] from [dbo].[CalNotKus] Where tf.DATE_2 >= TBEG and tf.DATE_2 < TEND +1) THEN 1.00 ELSE ISNULL(kf.KUS,1.00) END)*ISNULL(d3_ksg.IT_SL,1.00) * 0.80, 2)
									ELSE ROUND(t2.TARIF*ISNULL(upr.UPR,1.00)*(CASE WHEN d3_ksg.N_KSG in (select [IDKSG] from [dbo].[CalNotKus] Where tf.DATE_2 >= TBEG and tf.DATE_2 < TEND +1) THEN 1.00 ELSE ISNULL(kf.KUS,1.00) END)*ISNULL(d3_ksg.IT_SL,1.00) ,2) 
								END)
							END)

							WHEN sl.USL_OK = 1 and (t2.[SSL] = 0 OR t2.[SSL] < -4)
							THEN ROUND(t2.TARIF*ISNULL(upr.UPR,1.00)*(CASE WHEN d3_ksg.N_KSG in (select [IDKSG] from [dbo].[CalNotKus] Where tf.DATE_2 >= TBEG and tf.DATE_2 < TEND +1) THEN 1.00 ELSE ISNULL(kf.KUS,1.00) END)*ISNULL(d3_ksg.IT_SL,1.00) ,2)

                            WHEN sl.USL_OK = 2 and t2.[SSL] > 0 THEN
                            (CASE 
								WHEN (sl.RSLT in (202, 205, 206, 207, 208)) THEN 
								   (CASE 
								   WHEN (DATEDIFF(DAY, tf.DATE_1, tf.DATE_2) + 1 - 
												(SELECT COUNT(*) FROM dbo.WORK_DAY wd
												 WHERE wd.LPU = sl.LPU and LPU=sl.LPU and wd.PODR_ID = tf.LPU_1 and H_DATE BETWEEN tf.DATE_1 AND tf.DATE_2)) < 4
											THEN ROUND(t2.TARIF * ISNULL(d3_ksg.IT_SL,1.00) * ISNULL(upr.UPR, 1.00)* 0.20, 2)
											ELSE ROUND(t2.TARIF * ISNULL(d3_ksg.IT_SL,1.00) * ISNULL(upr.UPR, 1.00)* 0.50, 2)
									END)
								WHEN (sl.RSLT not in (202, 205, 206, 207, 208)) THEN 
								   (CASE 
								   WHEN (DATEDIFF(DAY, tf.DATE_1, tf.DATE_2) + 1 - 
												(SELECT COUNT(*) FROM dbo.WORK_DAY wd
												 WHERE wd.LPU = sl.LPU and LPU=sl.LPU and wd.PODR_ID = tf.LPU_1 and H_DATE BETWEEN tf.DATE_1 AND tf.DATE_2)) < 4
											THEN ROUND(t2.TARIF * ISNULL(d3_ksg.IT_SL,1.00) * ISNULL(upr.UPR, 1.00)* 0.20, 2)
											ELSE ROUND(t2.TARIF * ISNULL(d3_ksg.IT_SL,1.00) * ISNULL(upr.UPR, 1.00)* 1.00, 2)
									END)
                            END)                        
                           
                            WHEN sl.USL_OK = 2 and t2.[SSL] = -4 THEN
                            (CASE 
								WHEN (sl.RSLT in (202, 205, 206, 207, 208)) THEN 
								   (CASE 
								   WHEN (DATEDIFF(DAY, tf.DATE_1, tf.DATE_2) + 1 - 
												(SELECT COUNT(*) FROM dbo.WORK_DAY wd
												 WHERE wd.LPU = sl.LPU and LPU=sl.LPU and wd.PODR_ID = tf.LPU_1 and H_DATE BETWEEN tf.DATE_1 AND tf.DATE_2)) < 4
											THEN ROUND(t2.TARIF * ISNULL(d3_ksg.IT_SL,1.00) * ISNULL(upr.UPR, 1.00)* 0.80, 2)
											ELSE ROUND(t2.TARIF * ISNULL(d3_ksg.IT_SL,1.00) * ISNULL(upr.UPR, 1.00)* 1.00, 2)
									END)
								WHEN (sl.RSLT not in (202, 205, 206, 207, 208)) THEN 
								   (CASE 
								   WHEN (DATEDIFF(DAY, tf.DATE_1, tf.DATE_2) + 1 - 
												(SELECT COUNT(*) FROM dbo.WORK_DAY wd
												 WHERE wd.LPU = sl.LPU and LPU=sl.LPU and wd.PODR_ID = tf.LPU_1 and H_DATE BETWEEN tf.DATE_1 AND tf.DATE_2)) < 4
											THEN ROUND(t2.TARIF * ISNULL(d3_ksg.IT_SL,1.00) * ISNULL(upr.UPR, 1.00)* 0.80, 2)
											ELSE ROUND(t2.TARIF * ISNULL(d3_ksg.IT_SL,1.00) * ISNULL(upr.UPR, 1.00)* 1.00, 2)
									END)
                            END)

							WHEN sl.USL_OK = 2 and (t2.[SSL] = 0 OR t2.[SSL] < -4)
								THEN ROUND(t2.TARIF * ISNULL(d3_ksg.IT_SL,1.00) * ISNULL(upr.UPR, 1.00), 2)
                            END),2) AS NUMERIC (10 ,2)),
                        TARIF=
                            CAST((CASE 
                            WHEN sl.USL_OK = 1 THEN t2.TARIF
                            WHEN sl.USL_OK = 2 THEN t2.TARIF
                            END) AS NUMERIC (10 ,2))
from D3_SL_OMS tf
join D3_KSG_KPG_OMS d3_ksg on d3_ksg.D3_SLID = tf.ID
left join D3_SL_KOEF_OMS d3_koef on d3_koef.D3_KSGID = d3_ksg.ID
--left join D3_CRIT_OMS d3_cr on d3_cr.D3_KSGID = d3_ksg.ID
left join D3_USL_OMS vm on tf.ID = vm.D3_SLID --and tf.PODR = vm.PODR
join D3_ZSL_OMS sl on tf.D3_ZSLID = sl.ID
left join D3_DSS_OMS ds2 on tf.ID = ds2.D3_SLID and ds2.DS_TYPE = 2
left join D3_DSS_OMS ds3 on tf.ID = ds2.D3_SLID and ds3.DS_TYPE = 3
join D3_PACIENT_OMS pa on sl.d3_PID = pa.ID
join SprKSGDecode ksg on sl.USL_OK = ksg.STYPE and (tf.DATE_2 >= ksg.DBEG and tf.DATE_2 < ksg.DEND +1)							
and (ksg.DS1 = tf.DS1 or ksg.DS1 = (left(tf.DS1, 1)+'.') or (ksg.DS1 = 'C00-C80' and tf.DS1 between 'C00' and 'C80.9') or (ksg.DS1 = 'D00-D09' and tf.DS1 between 'D00' and 'D09.9') or ksg.DS1 is null)
and (ksg.DS2 = ds2.DS or ksg.DS2 is null)
and (ksg.DS3 = ds3.DS or ksg.DS3 is null)
and (ksg.USL = vm.VID_VME or ksg.USL is null)
and (ksg.VOZR =
case 
	when DATEDIFF(DAY, pa.DR, tf.DATE_1) between 0 and 28 then 1
	when DATEDIFF(DAY, pa.DR, tf.DATE_1) between 29 and 90 then 2
	when DATEDIFF(DAY, pa.DR, tf.DATE_1) between 91 and 365 then 3
	when DATEDIFF(DAY, pa.DR, tf.DATE_1) between 0 and 365.25*2 then 4
	when DATEDIFF(DAY, pa.DR, tf.DATE_1) between 0 and 365.25*18 then 5
	when DATEDIFF(DAY, pa.DR, tf.DATE_1) > 365.25*18 then 6
end
or ksg.VOZR =
case 
	when DATEDIFF(DAY, pa.DR, tf.DATE_1) between 0 and 365.25*2 then 4
	when DATEDIFF(DAY, pa.DR, tf.DATE_1) between 0 and 365.25*18 then 5
	when DATEDIFF(DAY, pa.DR, tf.DATE_1) > 365.25*18 then 6
end
or ksg.VOZR =
case 
	when DATEDIFF(DAY, pa.DR, tf.DATE_1) between 0 and 365.25*18 then 5
	when DATEDIFF(DAY, pa.DR, tf.DATE_1) > 365.25*18 then 6
end
or ksg.VOZR is null)
and (ksg.POL = pa.W or ksg.POL is null)
and (ksg.DLIT = 
case when (cast(tf.DATE_2 as date) = cast(tf.DATE_1 as date))
		  or
		  (sl.USL_OK = 1 and datediff(day, cast(tf.DATE_1 as date), cast(tf.DATE_2 as date)) <= 3)
		  or
		  (sl.USL_OK = 2 and datediff(day, cast(tf.DATE_1 as date), cast(tf.DATE_2 as date)) +1 <= 3)
     then 1
	 else 0
end
or ksg.DLIT is null)
--and (ksg.DOP_KR = d3_cr.CRIT or ksg.DOP_KR is null)
and (ksg.DOP_KR in (select CRIT from D3_CRIT_OMS cr where cr.D3_KSGID = d3_ksg.ID) or (ksg.DOP_KR='OS.24' and sl.OS_SLUCH_REGION=24) or ksg.DOP_KR is null)
--and (ksg.DFR = d3_cr.CRIT or ksg.DFR is null)
and (ksg.DFR in (select CRIT from D3_CRIT_OMS cr where cr.D3_KSGID = d3_ksg.ID) or ksg.DFR is null)
join V023 v23 on ksg.NKSG = v23.K_KSG and ksg.STYPE = v23.IDUMP and /*ksg.DBEG >= v23.DATEBEG*/ (tf.DATE_2 >= v23.DATEBEG and tf.DATE_2 < isnull((v23.DATEEND +1), '20991231'))	
join CalcKsgTarif t2 on v23.K_KSG = t2.IDKSG  and (tf.DATE_2 >= t2.DBEG and tf.DATE_2 < t2.DEND +1)
left join KSG_SOD as ksgsod on (tf.DATE_2 >= ksgsod.TarifDateStart and tf.DATE_2 < ksgsod.TarifDateEnd +1)
left join CalcUprk upr on v23.K_KSG = upr.IDKSG and (tf.DATE_2 >= upr.TBEG and tf.DATE_2 < upr.TEND +1)
left join @CalcBaseKoefDS bkds on (tf.DATE_2 >= bkds.TBEG and tf.DATE_2 < bkds.TEND +1)
left join CalcMok as kf on kf.KOD_LPU = sl.LPU AND (tf.DATE_2 >= kf.DATESTART and (kf.DATEEND is NULL OR tf.DATE_2 < kf.DATEEND +1))
where (
	sl.id = @zsl and @marker = 'zsl'
	or
	sl.d3_scid = @scid and @marker = 'scid'
	) and 
tf.METOD_HMP is null -- ���
   and tf.DATE_2 >= '20190101'
Insert into @temp_ksg_itog
			Select 0, * From(						
			Select ROW_NUMBER () OVER (partition by SLID, ID, vm_ID order by (CASE WHEN USL IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DS1 IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DS2 IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN VOZR IS NULL THEN 10 ELSE VOZR END ), (CASE WHEN POL IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DLIT IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DOP_KR IS NULL THEN 0 ELSE 1 END ) desc, SUMV_USL desc) rn, *
			from @temp_ksg ) tt1 where rn = 1
			UNION
			Select 0, * From(
			Select ROW_NUMBER () OVER (partition by SLID, ID, vm_ID order by (CASE WHEN USL IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DS2 IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DS1 IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN VOZR IS NULL THEN 10 ELSE VOZR END ), (CASE WHEN POL IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DLIT IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DOP_KR IS NULL THEN 0 ELSE 1 END ) desc, SUMV_USL desc) rn, *
			from @temp_ksg ) tt2 where rn = 1
			UNION
			Select 0, * From(
			Select ROW_NUMBER () OVER (partition by SLID, ID order by (CASE WHEN DS1 IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DS2 IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN USL IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN VOZR IS NULL THEN 10 ELSE VOZR END ), (CASE WHEN POL IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DLIT IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DOP_KR IS NULL THEN 0 ELSE 1 END ) desc, SUMV_USL desc) rn, *
			from @temp_ksg ) tt3 where rn = 1 
			UNION
			Select 0, * From(
			Select ROW_NUMBER () OVER (partition by SLID, ID order by (CASE WHEN DS1 IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN USL IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DS2 IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN VOZR IS NULL THEN 10 ELSE VOZR END ), (CASE WHEN POL IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DLIT IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DOP_KR IS NULL THEN 0 ELSE 1 END ) desc, SUMV_USL desc) rn, *
			from @temp_ksg ) tt4 where rn = 1 
			UNION
			Select 0, * From(
			Select ROW_NUMBER () OVER (partition by SLID, ID order by (CASE WHEN DS2 IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DS1 IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN USL IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN VOZR IS NULL THEN 10 ELSE VOZR END ), (CASE WHEN POL IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DLIT IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DOP_KR IS NULL THEN 0 ELSE 1 END ) desc, SUMV_USL desc) rn, *
			from @temp_ksg ) tt5 where rn = 1 
			UNION
			Select 0, * From(
			Select ROW_NUMBER () OVER (partition by SLID, ID order by (CASE WHEN DS2 IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN USL IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DS1 IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN VOZR IS NULL THEN 10 ELSE VOZR END ), (CASE WHEN POL IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DLIT IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DOP_KR IS NULL THEN 0 ELSE 1 END ) desc, SUMV_USL desc) rn, *
			from @temp_ksg ) tt6 where rn = 1
			UNION
			Select 0, * From(						
			Select ROW_NUMBER () OVER (partition by SLID, ID, vm_ID order by (CASE WHEN DOP_KR IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN USL IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DS1 IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DS2 IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN VOZR IS NULL THEN 10 ELSE VOZR END ), (CASE WHEN POL IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DLIT IS NULL THEN 0 ELSE 1 END ) desc, SUMV_USL desc) rn, *
			from @temp_ksg ) tt7 where rn = 1
			UNION
			Select 0, * From(						
			Select ROW_NUMBER () OVER (partition by SLID, ID, vm_ID order by (CASE WHEN DOP_KR IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DS1 IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN USL IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DS2 IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN VOZR IS NULL THEN 10 ELSE VOZR END ), (CASE WHEN POL IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DLIT IS NULL THEN 0 ELSE 1 END ) desc, SUMV_USL desc) rn, *
			from @temp_ksg ) tt1 where rn = 1

DECLARE sur_cursor CURSOR FOR   
			select slid from @temp_ksg_itog
			group by SLID having count(*) > 1
declare @slid int  

OPEN sur_cursor  
  
FETCH NEXT FROM sur_cursor   
INTO @slid 
  
WHILE @@FETCH_STATUS = 0  
BEGIN  


 IF (select count(*) from @temp_ksg_itog where slid =@slid and 'st02.010' in (select IDKSG from @temp_ksg_itog where slid =@slid) and 'st02.008' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'st02.010'
 IF (select count(*) from @temp_ksg_itog where slid =@slid and 'st02.011' in (select IDKSG from @temp_ksg_itog where slid =@slid) and 'st02.008' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'st02.011'
 IF (select count(*) from @temp_ksg_itog where slid =@slid and 'st02.010' in (select IDKSG from @temp_ksg_itog where slid =@slid) and 'st02.009' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'st02.010'
 IF (select count(*) from @temp_ksg_itog where slid =@slid and 'st14.001' in (select IDKSG from @temp_ksg_itog where slid =@slid) and 'st04.002' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'st14.001'
 IF (select count(*) from @temp_ksg_itog where slid =@slid and 'st14.002' in (select IDKSG from @temp_ksg_itog where slid =@slid) and 'st04.002' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'st14.002'
 IF (select count(*) from @temp_ksg_itog where slid =@slid and 'st21.001' in (select IDKSG from @temp_ksg_itog where slid =@slid) and 'st21.007' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'st21.001'
 IF (select count(*) from @temp_ksg_itog where slid =@slid and 'st34.002' in (select IDKSG from @temp_ksg_itog where slid =@slid) and 'st34.001' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'st34.002'
 IF (select count(*) from @temp_ksg_itog where slid =@slid and 'st34.002' in (select IDKSG from @temp_ksg_itog where slid =@slid) and 'st26.001' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'st34.002'
 IF (select count(*) from @temp_ksg_itog where slid =@slid and 'st30.006' in (select IDKSG from @temp_ksg_itog where slid =@slid) and 'st30.003' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'st30.006'
 IF (select count(*) from @temp_ksg_itog where slid =@slid and 'st09.001' in (select IDKSG from @temp_ksg_itog where slid =@slid) and 'st30.005' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'st09.001'
 IF (select count(*) from @temp_ksg_itog where slid =@slid and 'st31.002' in (select IDKSG from @temp_ksg_itog where slid =@slid) and 'st31.017' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'st31.002'

	--Обработка реабилитации
IF (select count(*) from @temp_ksg_itog where slid =@slid and 'st37.001' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'st37.001'
IF (select count(*) from @temp_ksg_itog where slid =@slid and 'st37.002' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'st37.002'
IF (select count(*) from @temp_ksg_itog where slid =@slid and 'st37.003' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'st37.003'
IF (select count(*) from @temp_ksg_itog where slid =@slid and 'st37.004' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'st37.004'
IF (select count(*) from @temp_ksg_itog where slid =@slid and 'st37.005' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'st37.005'
IF (select count(*) from @temp_ksg_itog where slid =@slid and 'st37.006' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'st37.006'
IF (select count(*) from @temp_ksg_itog where slid =@slid and 'st37.007' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'st37.007'
IF (select count(*) from @temp_ksg_itog where slid =@slid and 'st37.008' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'st37.008'
IF (select count(*) from @temp_ksg_itog where slid =@slid and 'st37.009' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'st37.009'
IF (select count(*) from @temp_ksg_itog where slid =@slid and 'st37.010' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'st37.010'
IF (select count(*) from @temp_ksg_itog where slid =@slid and 'st37.011' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'st37.011'
IF (select count(*) from @temp_ksg_itog where slid =@slid and 'st37.012' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'st37.012'
IF (select count(*) from @temp_ksg_itog where slid =@slid and 'st37.013' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'st37.013'
IF (select count(*) from @temp_ksg_itog where slid =@slid and 'st37.014' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'st37.014'
IF (select count(*) from @temp_ksg_itog where slid =@slid and 'st37.015' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'st37.015'
IF (select count(*) from @temp_ksg_itog where slid =@slid and 'st37.016' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'st37.016'
IF (select count(*) from @temp_ksg_itog where slid =@slid and 'st37.017' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'st37.017'
IF (select count(*) from @temp_ksg_itog where slid =@slid and 'st37.018' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'st37.018'


IF (select count(*) from @temp_ksg_itog where slid =@slid and 'ds37.001' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'ds37.001'
IF (select count(*) from @temp_ksg_itog where slid =@slid and 'ds37.002' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'ds37.002'
IF (select count(*) from @temp_ksg_itog where slid =@slid and 'ds37.003' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'ds37.003'
IF (select count(*) from @temp_ksg_itog where slid =@slid and 'ds37.004' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'ds37.004'
IF (select count(*) from @temp_ksg_itog where slid =@slid and 'ds37.005' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'ds37.005'
IF (select count(*) from @temp_ksg_itog where slid =@slid and 'ds37.006' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'ds37.006'
IF (select count(*) from @temp_ksg_itog where slid =@slid and 'ds37.007' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'ds37.007'
IF (select count(*) from @temp_ksg_itog where slid =@slid and 'ds37.008' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'ds37.008'
IF (select count(*) from @temp_ksg_itog where slid =@slid and 'ds37.009' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'ds37.009'
IF (select count(*) from @temp_ksg_itog where slid =@slid and 'ds37.010' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'ds37.010'
IF (select count(*) from @temp_ksg_itog where slid =@slid and 'ds37.011' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'ds37.011'
IF (select count(*) from @temp_ksg_itog where slid =@slid and 'ds37.012' in (select IDKSG from @temp_ksg_itog where slid =@slid)) > 0
	UPDATE @temp_ksg_itog SET sur_ksg = 1 where slid =@slid and IDKSG = 'ds37.012'



	--обработка двойных ксг

	-- патология
 IF (select count(*) from @temp_ksg_itog 
	where slid =@slid and 'st02.001' in (select IDKSG from @temp_ksg_itog where slid =@slid) and 
	('st02.003' in (select IDKSG from @temp_ksg_itog where slid =@slid) or 'st02.004' in (select IDKSG from @temp_ksg_itog where slid =@slid))
	and not ((select top 1 KDAY from @temp_ksg_itog where slid =@slid and NKSG = 'st02.001') > 1
			 and (select top 1 tf_ds from @temp_ksg_itog where slid =@slid and NKSG = 'st02.001') in ('O14.1', 'O34.2', 'O36.3', 'O36.4', 'O42.2')
													 or (select top 1 KDAY from @temp_ksg_itog where slid =@slid and NKSG = 'st02.001') > 5)
	) > 0
	UPDATE @temp_ksg_itog SET SUMV_USL = 0 where slid =@slid and IDKSG = 'st02.001'


    FETCH NEXT FROM sur_cursor   
    INTO @slid 
END   
CLOSE sur_cursor;  
DEALLOCATE sur_cursor;  

-- выбор КСГ ДС по услуге
UPDATE @temp_ksg_itog SET sur_ksg = 1 where usl_ok = 2 and USL is not null

Select zsl.zsl_id, itog.* 
 --rn_itog, ID, IDKSG, KDAY, SUMV_USL SUMV, TARIF -- МО
 --SLID, sl_sumv, ISNULL(CONVERT(nvarchar(250 ), SUMV_USL), '') com -- СМО
 --into tempKsg201803
 From (
	Select ROW_NUMBER () OVER (partition by SLID, ID order by sur_ksg desc, SUMV_USL desc, (case when USL is NULL THEN 0 ELSE 1 end) desc)  rn_itog, * FROM @temp_ksg_itog
) itog
  join d3_zsl_oms zsl on itog.slid=zsl.id
  join D3_SCHET_OMS sc on zsl.d3_scid = sc.id
 where --zsl_id ='8AA61B97-AD46-5E14-E053-350AA8C0D9E6'
rn_itog =1 
and
( (NKSG <> tf_idksg or SUMV_USL <> tf_sumv_usl) and tf_sumv_usl <> 0 
		--and not ((tf_idksg in (700,702,703,1126,1128,1129) and tf_sumv_usl = 0) or tf_idksg in (1344,1560,1561,1562,1563))
)

             
