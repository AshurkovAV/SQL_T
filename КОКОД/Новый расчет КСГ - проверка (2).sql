
declare @zsl int = (select id from d3_zsl_oms where zsl_id='c67a5478-1bfc-4f77-8a31-74af446cc9a2')
declare @scid int = 2155
declare @marker nvarchar(10) = 'scid'



declare @ks_base numeric (17,2) = 22563.91
declare @ds_base numeric (17,2) = 12272.64

declare @ksg0 table (ksg nvarchar(20))
declare @ksgh table (ksg nvarchar(20))

insert @ksg0 values('st02.001')
insert @ksg0 values('st02.002')
insert @ksg0 values('st02.003')
insert @ksg0 values('st02.004')
insert @ksg0 values('st02.010')
insert @ksg0 values('st02.011')
insert @ksg0 values('st03.002')
insert @ksg0 values('st05.008')
insert @ksg0 values('st08.001')
insert @ksg0 values('st08.002')
insert @ksg0 values('st08.003')
insert @ksg0 values('st12.010')
insert @ksg0 values('st12.011')
insert @ksg0 values('st14.002')
insert @ksg0 values('st15.008')
insert @ksg0 values('st15.009')
insert @ksg0 values('st16.005')
insert @ksg0 values('st19.007')
insert @ksg0 values('st19.027')
insert @ksg0 values('st19.028')
insert @ksg0 values('st19.029')
insert @ksg0 values('st19.030')
insert @ksg0 values('st19.031')
insert @ksg0 values('st19.032')
insert @ksg0 values('st19.033')
insert @ksg0 values('st19.034')
insert @ksg0 values('st19.035')
insert @ksg0 values('st19.036')
insert @ksg0 values('st19.056')
insert @ksg0 values('st19.057')
insert @ksg0 values('st19.058')
insert @ksg0 values('st19.038')
insert @ksg0 values('st19.059')
insert @ksg0 values('st19.060')
insert @ksg0 values('st19.061')
insert @ksg0 values('st20.005')
insert @ksg0 values('st20.006')
insert @ksg0 values('st20.010')
insert @ksg0 values('st21.001')
insert @ksg0 values('st21.002')
insert @ksg0 values('st21.003')
insert @ksg0 values('st21.004')
insert @ksg0 values('st21.005')
insert @ksg0 values('st21.006')
insert @ksg0 values('st25.004')
insert @ksg0 values('st27.012')
insert @ksg0 values('st30.006')
insert @ksg0 values('st30.010')
insert @ksg0 values('st30.011')
insert @ksg0 values('st30.012')
insert @ksg0 values('st30.014')
insert @ksg0 values('st31.017')
insert @ksg0 values('st32.002')
insert @ksg0 values('st32.012')
insert @ksg0 values('st32.016')
insert @ksg0 values('st34.002')
insert @ksg0 values('st36.001')
insert @ksg0 values('st36.003')
insert @ksg0 values('st36.007')
insert @ksg0 values('st36.009')
insert @ksg0 values('st36.010')
insert @ksg0 values('st36.011')
insert @ksg0 values('ds02.001')
insert @ksg0 values('ds02.006')
insert @ksg0 values('ds02.007')
insert @ksg0 values('ds05.005')
insert @ksg0 values('ds08.001')
insert @ksg0 values('ds08.002')
insert @ksg0 values('ds08.003')
insert @ksg0 values('ds15.002')
insert @ksg0 values('ds15.003')
insert @ksg0 values('ds19.018')
insert @ksg0 values('ds19.019')
insert @ksg0 values('ds19.020')
insert @ksg0 values('ds19.021')
insert @ksg0 values('ds19.022')
insert @ksg0 values('ds19.023')
insert @ksg0 values('ds19.024')
insert @ksg0 values('ds19.025')
insert @ksg0 values('ds19.026')
insert @ksg0 values('ds19.027')
insert @ksg0 values('ds19.030')
insert @ksg0 values('ds19.031')
insert @ksg0 values('ds19.032')
insert @ksg0 values('ds19.028')
insert @ksg0 values('ds19.029')
insert @ksg0 values('ds19.033')
insert @ksg0 values('ds19.034')
insert @ksg0 values('ds19.035')
insert @ksg0 values('ds19.036')
insert @ksg0 values('ds20.002')
insert @ksg0 values('ds20.003')
insert @ksg0 values('ds20.006')
insert @ksg0 values('ds21.002')
insert @ksg0 values('ds21.003')
insert @ksg0 values('ds21.004')
insert @ksg0 values('ds21.005')
insert @ksg0 values('ds21.006')
insert @ksg0 values('ds25.001')
insert @ksg0 values('ds27.001')
insert @ksg0 values('ds34.002')
insert @ksg0 values('ds36.001')
insert @ksg0 values('ds36.004')

insert @ksgh values('st02.003')
insert @ksgh values('st02.004')
insert @ksgh values('st02.010')
insert @ksgh values('st02.011')
insert @ksgh values('st02.012')
insert @ksgh values('st02.013')
insert @ksgh values('st09.001')
insert @ksgh values('st09.002')
insert @ksgh values('st09.003')
insert @ksgh values('st09.004')
insert @ksgh values('st09.005')
insert @ksgh values('st09.006')
insert @ksgh values('st09.007')
insert @ksgh values('st09.008')
insert @ksgh values('st09.009')
insert @ksgh values('st09.010')
insert @ksgh values('st10.001')
insert @ksgh values('st10.002')
insert @ksgh values('st10.003')
insert @ksgh values('st10.004')
insert @ksgh values('st10.005')
insert @ksgh values('st10.006')
insert @ksgh values('st10.007')
insert @ksgh values('st13.002')
insert @ksgh values('st13.003')
insert @ksgh values('st13.005')
insert @ksgh values('st13.007')
insert @ksgh values('st14.001')
insert @ksgh values('st14.002')
insert @ksgh values('st14.003')
insert @ksgh values('st15.015')
insert @ksgh values('st15.016')
insert @ksgh values('st16.007')
insert @ksgh values('st16.008')
insert @ksgh values('st16.009')
insert @ksgh values('st16.010')
insert @ksgh values('st16.011')
insert @ksgh values('st18.002')
insert @ksgh values('st19.001')
insert @ksgh values('st19.002')
insert @ksgh values('st19.003')
insert @ksgh values('st19.004')
insert @ksgh values('st19.005')
insert @ksgh values('st19.006')
insert @ksgh values('st19.007')
insert @ksgh values('st19.008')
insert @ksgh values('st19.009')
insert @ksgh values('st19.010')
insert @ksgh values('st19.011')
insert @ksgh values('st19.012')
insert @ksgh values('st19.013')
insert @ksgh values('st19.014')
insert @ksgh values('st19.015')
insert @ksgh values('st19.016')
insert @ksgh values('st19.017')
insert @ksgh values('st19.018')
insert @ksgh values('st19.019')
insert @ksgh values('st19.020')
insert @ksgh values('st19.021')
insert @ksgh values('st19.022')
insert @ksgh values('st19.023')
insert @ksgh values('st19.024')
insert @ksgh values('st19.025')
insert @ksgh values('st19.026')
insert @ksgh values('st19.038')
insert @ksgh values('st20.005')
insert @ksgh values('st20.006')
insert @ksgh values('st20.007')
insert @ksgh values('st20.008')
insert @ksgh values('st20.009')
insert @ksgh values('st20.010')
insert @ksgh values('st21.001')
insert @ksgh values('st21.002')
insert @ksgh values('st21.003')
insert @ksgh values('st21.004')
insert @ksgh values('st21.005')
insert @ksgh values('st21.006')
insert @ksgh values('st24.004')
insert @ksgh values('st25.004')
insert @ksgh values('st25.005')
insert @ksgh values('st25.006')
insert @ksgh values('st25.007')
insert @ksgh values('st25.008')
insert @ksgh values('st25.009')
insert @ksgh values('st25.010')
insert @ksgh values('st25.011')
insert @ksgh values('st25.012')
insert @ksgh values('st27.007')
insert @ksgh values('st27.009')
insert @ksgh values('st28.002')
insert @ksgh values('st28.003')
insert @ksgh values('st28.004')
insert @ksgh values('st28.005')
insert @ksgh values('st29.008')
insert @ksgh values('st29.009')
insert @ksgh values('st29.010')
insert @ksgh values('st29.011')
insert @ksgh values('st29.012')
insert @ksgh values('st29.013')
insert @ksgh values('st30.006')
insert @ksgh values('st30.007')
insert @ksgh values('st30.008')
insert @ksgh values('st30.009')
insert @ksgh values('st30.010')
insert @ksgh values('st30.011')
insert @ksgh values('st30.012')
insert @ksgh values('st30.013')
insert @ksgh values('st30.014')
insert @ksgh values('st30.015')
insert @ksgh values('st31.002')
insert @ksgh values('st31.003')
insert @ksgh values('st31.004')
insert @ksgh values('st31.005')
insert @ksgh values('st31.006')
insert @ksgh values('st31.007')
insert @ksgh values('st31.008')
insert @ksgh values('st31.009')
insert @ksgh values('st31.010')
insert @ksgh values('st31.015')
insert @ksgh values('st31.019')
insert @ksgh values('st32.001')
insert @ksgh values('st32.002')
insert @ksgh values('st32.003')
insert @ksgh values('st32.004')
insert @ksgh values('st32.005')
insert @ksgh values('st32.006')
insert @ksgh values('st32.007')
insert @ksgh values('st32.008')
insert @ksgh values('st32.009')
insert @ksgh values('st32.010')
insert @ksgh values('st32.011')
insert @ksgh values('st32.012')
insert @ksgh values('st32.013')
insert @ksgh values('st32.014')
insert @ksgh values('st32.015')
insert @ksgh values('st32.016')
insert @ksgh values('st32.017')
insert @ksgh values('st32.018')
insert @ksgh values('st34.002')
insert @ksgh values('st34.003')
insert @ksgh values('st34.004')
insert @ksgh values('st34.005')
insert @ksgh values('st36.009')
insert @ksgh values('st36.010')
insert @ksgh values('st36.011')
insert @ksgh values('ds02.006')
insert @ksgh values('ds02.003')
insert @ksgh values('ds02.004')
insert @ksgh values('ds09.001')
insert @ksgh values('ds09.002')
insert @ksgh values('ds10.001')
insert @ksgh values('ds13.002')
insert @ksgh values('ds14.001')
insert @ksgh values('ds14.002')
insert @ksgh values('ds16.002')
insert @ksgh values('ds18.003')
insert @ksgh values('ds19.016')
insert @ksgh values('ds19.017')
insert @ksgh values('ds19.028')
insert @ksgh values('ds20.002')
insert @ksgh values('ds20.003')
insert @ksgh values('ds20.004')
insert @ksgh values('ds20.005')
insert @ksgh values('ds20.006')
insert @ksgh values('ds21.002')
insert @ksgh values('ds21.003')
insert @ksgh values('ds21.004')
insert @ksgh values('ds21.005')
insert @ksgh values('ds21.006')
insert @ksgh values('ds25.001')
insert @ksgh values('ds25.002')
insert @ksgh values('ds25.003')
insert @ksgh values('ds28.001')
insert @ksgh values('ds29.001')
insert @ksgh values('ds29.002')
insert @ksgh values('ds29.003')
insert @ksgh values('ds30.002')
insert @ksgh values('ds30.003')
insert @ksgh values('ds30.004')
insert @ksgh values('ds30.005')
insert @ksgh values('ds30.006')
insert @ksgh values('ds31.002')
insert @ksgh values('ds31.003')
insert @ksgh values('ds31.004')
insert @ksgh values('ds31.005')
insert @ksgh values('ds31.006')
insert @ksgh values('ds32.001')
insert @ksgh values('ds32.002')
insert @ksgh values('ds32.003')
insert @ksgh values('ds32.004')
insert @ksgh values('ds32.005')
insert @ksgh values('ds32.006')
insert @ksgh values('ds32.007')
insert @ksgh values('ds32.008')
insert @ksgh values('ds34.002')
insert @ksgh values('ds34.003')


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

declare @temp_ksg table(
	DATE_1 datetime,
	DATE_2 datetime,
	DATE_Z_1 datetime,
	DATE_Z_2 datetime,
	LPU_1 nvarchar(20),
	RSLT nvarchar(20),
	mkb_class int,
	[USL_OK] int null,
	[SLID] [int] NULL,
	[ID] [int] NULL,
	[vm_ID] [int] NULL,
	[NKSG] [nvarchar](20) NULL,
	[IDKSG] [nvarchar](20) NOT NULL,
	[USL] [nvarchar](16) NULL,
	[DS1] [nvarchar](10) NULL,
	[DS2] [nvarchar](10) NULL,
	[DS3] [nvarchar](10) NULL,

	[VOZR] [int] NULL,
	[POL] [int] NULL,
	[DLIT] [int] NULL,
	[DOP_KR] nvarchar(20),
	[DFR] nvarchar(20),
	[tf_idksg] [nvarchar](20) NULL,
	[tf_ds] [nvarchar](10) NULL,
	[sl_ds2] [nvarchar](10) NULL,
	[sl_ds3] [nvarchar](10) NULL,

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
	IT_SL numeric (17,2) NULL
)

declare @temp_ksg_calc table(
	per int,
	rn_itog int,
	sur_ksg int default (0),
	rn int,
	DATE_1 datetime,
	DATE_2 datetime,
	DATE_Z_1 datetime,
	DATE_Z_2 datetime,
	LPU_1 nvarchar(20),
	RSLT nvarchar(20),
	mkb_class int,
	[USL_OK] int null,
	[SLID] [int] NULL,
	[ID] [int] NULL,
	[vm_ID] [int] NULL,
	[NKSG] [nvarchar](20) NULL,
	[IDKSG] [nvarchar](20) NOT NULL,
	[USL] [nvarchar](16) NULL,
	[DS1] [nvarchar](10) NULL,
	[DS2] [nvarchar](10) NULL,
		[DS3] [nvarchar](10) NULL,

	[VOZR] [int] NULL,
	[POL] [int] NULL,
	[DLIT] [int] NULL,
	[DOP_KR] nvarchar(20),
	DFR nvarchar(20),
	[tf_idksg] [nvarchar](20) NULL,
	[tf_ds] [nvarchar](10) NULL,
	[sl_ds2] [nvarchar](10) NULL,
		[sl_ds3] [nvarchar](10) NULL,

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
	IT_SL numeric (17,2) NULL,

	[KDAY] [int] NULL,
	[SUMV_USL] [numeric](10, 2) NULL,
	[TARIF] [numeric](10, 2) NULL
)

declare @temp_ksg_itog table(
	sur_ksg int default (0),
	rn int,
	DATE_1 datetime,
	DATE_2 datetime,
	DATE_Z_1 datetime,
	DATE_Z_2 datetime,
	LPU_1 nvarchar(20),
	RSLT nvarchar(20),
	mkb_class int,
	[USL_OK] int null,
	[SLID] [int] NULL,
	[ID] [int] NULL,
	[vm_ID] [int] NULL,
	[NKSG] [nvarchar](20) NULL,
	[IDKSG] [nvarchar](20) NOT NULL,
	[USL] [nvarchar](16) NULL,
	[DS1] [nvarchar](10) NULL,
	[DS2] [nvarchar](10) NULL,
		[DS3] [nvarchar](10) NULL,

	[VOZR] [int] NULL,
	[POL] [int] NULL,
	[DLIT] [int] NULL,
	[DOP_KR] nvarchar(20),
	DFR nvarchar(20),
	[tf_idksg] [nvarchar](20) NULL,
	[tf_ds] [nvarchar](10) NULL,
	[sl_ds2] [nvarchar](10) NULL,
		[sl_ds3] [nvarchar](10) NULL,

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
	IT_SL numeric (17,2) NULL

)

--INSERT INTO [dbo].[D3_KSG_KPG_OMS]
--           ([D3_SLID]
--           ,[D3_SLGID]
--           ,[KSG_ID])
--select sl.ID, sl.SL_ID, newid() nid 
--from D3_SL_OMS sl 
--join D3_ZSL_OMS z on sl.D3_ZSLID = z.ID and z.USL_OK in (1,2)
--left join D3_KSG_KPG_OMS ksg on sl.ID = ksg.D3_SLID
--where (
--	z.id = @zsl and @marker = 'zsl'
--	or
--	z.d3_scid = @scid and @marker = 'scid'
--	) and sl.METOD_HMP is null and ksg.ID is null

Insert @temp_ksg
select 	DATE_1,	DATE_2,	DATE_Z_1, DATE_Z_2,	tf.LPU_1, RSLT, m1.class, sl.USL_OK, tf.D3_ZSLID as SLID, tf.ID, vm.ID vm_id, ksg.NKSG, v23.K_KSG as IDKSG, ksg.USL, ksg.DS1, ksg.DS2, ksg.DS3, ksg.VOZR as VOZR, ksg.POL, ksg.DLIT, ksg.[DOP_KR], ksg.DFR,
	d3_ksg.N_KSG tf_idksg, tf.DS1 tf_ds, ds2.ds sl_ds2, ds3.ds sl_ds3, vm.VID_VME vm_vid_vme, tf.kd tf_kday, tf.sum_m tf_sumv_usl, tf.tarif tf_tarif, sl.sumv sl_sumv, tf.podr tf_podr,-- tf.DATE_1 tf_DATE_1, tf.DATE_2 tf_DATE_2, 
	v23.KOEF_Z, upr.UPR, kf.KUS, d3_ksg.IT_SL
from D3_SL_OMS tf
join M001 m1 on m1.IDDS=tf.DS1 
join D3_KSG_KPG_OMS d3_ksg on d3_ksg.D3_SLID = tf.ID
left join D3_SL_KOEF_OMS d3_koef on d3_koef.D3_KSGID = d3_ksg.ID
--left join D3_CRIT_OMS d3_cr on d3_cr.D3_KSGID = d3_ksg.ID
left join D3_USL_OMS vm on tf.ID = vm.D3_SLID --and tf.PODR = vm.PODR
join D3_ZSL_OMS sl on tf.D3_ZSLID = sl.ID
left join D3_DSS_OMS ds2 on tf.ID = ds2.D3_SLID and ds2.DS_TYPE = 2
left join D3_DSS_OMS ds3 on tf.ID = ds3.D3_SLID and ds3.DS_TYPE = 3
join D3_PACIENT_OMS pa on sl.d3_PID = pa.ID
join SprKSGDecode ksg on sl.USL_OK = ksg.STYPE and (tf.DATE_2 >= ksg.DBEG and tf.DATE_2 < ksg.DEND +1)							
and (ksg.DS1 = tf.DS1 or ksg.DS1 = (left(tf.DS1, 1)+'.') or (ksg.DS1 = 'C00-C80' and tf.DS1 between 'C00' and 'C80.9') or (ksg.DS1 = 'D00-D09' and tf.DS1 between 'D00' and 'D09.9') or (ksg.DS1 = 'Q20-Q28' and tf.DS1 between 'Q20' and 'Q28.9') or ksg.DS1 is null)
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
--join CalcKsgTarif t2 on v23.K_KSG = t2.IDKSG  and (tf.DATE_2 >= t2.DBEG and tf.DATE_2 < t2.DEND +1)
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
			Select ROW_NUMBER () OVER (partition by SLID, ID, vm_ID order by (CASE WHEN USL IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DS1 IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DS2 IS NOT NULL or DS3 IS NOT NULL THEN 1 ELSE 0 END ) desc, (CASE WHEN VOZR IS NULL THEN 10 ELSE VOZR END ), (CASE WHEN POL IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DLIT IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DOP_KR IS NULL THEN 0 ELSE 1 END ) desc, KZ desc) rn, *
			from @temp_ksg ) tt1 where rn = 1
			UNION
			Select 0, * From(
			Select ROW_NUMBER () OVER (partition by SLID, ID, vm_ID order by (CASE WHEN USL IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DS2 IS NOT NULL or DS3 IS NOT NULL THEN 1 ELSE 0 END ) desc, (CASE WHEN DS1 IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN VOZR IS NULL THEN 10 ELSE VOZR END ), (CASE WHEN POL IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DLIT IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DOP_KR IS NULL THEN 0 ELSE 1 END ) desc, KZ desc) rn, *
			from @temp_ksg ) tt2 where rn = 1
			UNION
			Select 0, * From(
			Select ROW_NUMBER () OVER (partition by SLID, ID order by (CASE WHEN DS1 IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DS2 IS NOT NULL or DS3 IS NOT NULL THEN 1 ELSE 0 END ) desc, (CASE WHEN USL IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN VOZR IS NULL THEN 10 ELSE VOZR END ), (CASE WHEN POL IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DLIT IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DOP_KR IS NULL THEN 0 ELSE 1 END ) desc, KZ desc) rn, *
			from @temp_ksg ) tt3 where rn = 1 
			UNION
			Select 0, * From(
			Select ROW_NUMBER () OVER (partition by SLID, ID order by (CASE WHEN DS1 IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN USL IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DS2 IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN VOZR IS NULL THEN 10 ELSE VOZR END ), (CASE WHEN POL IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DLIT IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DOP_KR IS NULL THEN 0 ELSE 1 END ) desc, KZ desc) rn, *
			from @temp_ksg ) tt4 where rn = 1 
			UNION
			Select 0, * From(
			Select ROW_NUMBER () OVER (partition by SLID, ID order by (CASE WHEN DS2 IS NOT NULL or DS3 IS NOT NULL THEN 1 ELSE 0 END ) desc, (CASE WHEN DS1 IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN USL IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN VOZR IS NULL THEN 10 ELSE VOZR END ), (CASE WHEN POL IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DLIT IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DOP_KR IS NULL THEN 0 ELSE 1 END ) desc, KZ desc) rn, *
			from @temp_ksg ) tt5 where rn = 1 
			UNION
			Select 0, * From(
			Select ROW_NUMBER () OVER (partition by SLID, ID order by (CASE WHEN DS2 IS NOT NULL or DS3 IS NOT NULL THEN 1 ELSE 0 END ) desc, (CASE WHEN USL IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DS1 IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN VOZR IS NULL THEN 10 ELSE VOZR END ), (CASE WHEN POL IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DLIT IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DOP_KR IS NULL THEN 0 ELSE 1 END ) desc, KZ desc) rn, *
			from @temp_ksg ) tt6 where rn = 1
			UNION
			Select 0, * From(						
			Select ROW_NUMBER () OVER (partition by SLID, ID, vm_ID order by (CASE WHEN DOP_KR IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN USL IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DS1 IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DS2 IS NOT NULL or DS3 IS NOT NULL THEN 1 ELSE 0 END ) desc, (CASE WHEN VOZR IS NULL THEN 10 ELSE VOZR END ), (CASE WHEN POL IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DLIT IS NULL THEN 0 ELSE 1 END ) desc, KZ desc) rn, *
			from @temp_ksg ) tt7 where rn = 1
			UNION
			Select 0, * From(						
			Select ROW_NUMBER () OVER (partition by SLID, ID, vm_ID order by (CASE WHEN DOP_KR IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DS1 IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN USL IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DS2 IS NOT NULL or DS3 IS NOT NULL THEN 1 ELSE 0 END ) desc, (CASE WHEN VOZR IS NULL THEN 10 ELSE VOZR END ), (CASE WHEN POL IS NULL THEN 0 ELSE 1 END ) desc, (CASE WHEN DLIT IS NULL THEN 0 ELSE 1 END ) desc, KZ desc) rn, *
			from @temp_ksg ) tt8 where rn = 1

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

	--Обработка реабилитации
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

    FETCH NEXT FROM sur_cursor   
    INTO @slid 
END   
CLOSE sur_cursor;  
DEALLOCATE sur_cursor;  

--
UPDATE @temp_ksg_itog SET sur_ksg = 1 where usl_ok = 2 and USL is not null


insert @temp_ksg_calc 
Select ROW_NUMBER () OVER (partition by SLID order by DATE_2 desc), *,
						KDAY = 
							(CASE 
							  WHEN USL_OK = 1 THEN (CASE WHEN cast(DATE_1 as date)= cast(DATE_2 as date) THEN 1 ELSE DATEDIFF(DAY, DATE_1, DATE_2) END)
							  WHEN USL_OK = 2 THEN DATEDIFF(DAY, DATE_1, DATE_2) + 1 -
								(SELECT COUNT(*) FROM dbo.WORK_DAY wd WHERE wd.LPU = LPU and wd.PODR_ID = LPU_1 and H_DATE BETWEEN DATE_1 AND DATE_2)
                            END),
						SUMV_USL =
                            CAST(ROUND(
							(CASE 

							--хирургическая операция (@ksgh)
							
                            WHEN USL_OK = 1 and NKSG in (select ksg from @ksgh) THEN 
							(CASE
								WHEN (RSLT in (101,103,104) or ROW_NUMBER () OVER (partition by SLID order by DATE_2 desc) > 1) 
									and (
										case when COUNT(ID) OVER (partition by mkb_class, ID) > 1 then DATEDIFF(DAY, DATE_Z_1, DATE_Z_2) else DATEDIFF(DAY, DATE_1, DATE_2) end > 3 
										or NKSG in (select ksg from @ksg0)
									)  THEN 
									@ks_base*KZ*ISNULL(UP,1.00)*(CASE WHEN NKSG in (select [IDKSG] from [dbo].[CalNotKus] Where DATE_2 >= TBEG and DATE_2 < TEND +1) THEN 1.00 ELSE ISNULL(U,1.00) END)
												*ISNULL(IT_SL,1.00) * 1 
								ELSE
								(CASE
									WHEN case when COUNT(ID) OVER (partition by mkb_class, ID) > 1 then DATEDIFF(DAY, DATE_Z_1, DATE_Z_2) else DATEDIFF(DAY, DATE_1, DATE_2) end > 3 or NKSG in (select ksg from @ksg0) THEN 
										@ks_base*KZ*ISNULL(UP,1.00)*(CASE WHEN NKSG in (select [IDKSG] from [dbo].[CalNotKus] Where DATE_2 >= TBEG and DATE_2 < TEND +1) THEN 1.00 ELSE ISNULL(U,1.00) END)
												*ISNULL(IT_SL,1.00) * 0.9 
									ELSE 
										@ks_base*KZ*ISNULL(UP,1.00)*(CASE WHEN NKSG in (select [IDKSG] from [dbo].[CalNotKus] Where DATE_2 >= TBEG and DATE_2 < TEND +1) THEN 1.00 ELSE ISNULL(U,1.00) END)
												*ISNULL(IT_SL,1.00) * 0.8
								END)
							END)

							-- терапевтическая ксг 

							WHEN USL_OK = 1 and NKSG not in (select ksg from @ksgh) THEN 
							(CASE
								WHEN (RSLT in (101,103,104) or ROW_NUMBER () OVER (partition by SLID order by DATE_2 desc) > 1) and NKSG not in ('st27.014')
									and (
										case when COUNT(ID) OVER (partition by mkb_class, ID) > 1 then DATEDIFF(DAY, DATE_Z_1, DATE_Z_2) else DATEDIFF(DAY, DATE_1, DATE_2) end > 3 
										or NKSG in (select ksg from @ksg0)
									)  THEN 
									@ks_base*KZ*ISNULL(UP,1.00)*(CASE WHEN NKSG in (select [IDKSG] from [dbo].[CalNotKus] Where DATE_2 >= TBEG and DATE_2 < TEND +1) THEN 1.00 ELSE ISNULL(U,1.00) END)
												*ISNULL(IT_SL,1.00) * 1 
								ELSE
								(CASE
									WHEN case when COUNT(ID) OVER (partition by mkb_class, ID) > 1 then DATEDIFF(DAY, DATE_Z_1, DATE_Z_2) else DATEDIFF(DAY, DATE_1, DATE_2) end > 3 or NKSG in (select ksg from @ksg0) THEN 
										@ks_base*KZ*ISNULL(UP,1.00)*(CASE WHEN NKSG in (select [IDKSG] from [dbo].[CalNotKus] Where DATE_2 >= TBEG and DATE_2 < TEND +1) THEN 1.00 ELSE ISNULL(U,1.00) END)
												*ISNULL(IT_SL,1.00) * 0.5 
									ELSE 
										@ks_base*KZ*ISNULL(UP,1.00)*(CASE WHEN NKSG in (select [IDKSG] from [dbo].[CalNotKus] Where DATE_2 >= TBEG and DATE_2 < TEND +1) THEN 1.00 ELSE ISNULL(U,1.00) END)
												*ISNULL(IT_SL,1.00) * 0.2
								END)
							END)

							-- хирургическая КСГ ДС

							WHEN USL_OK = 2 and NKSG in (select ksg from @ksgh) THEN 
							(CASE
								WHEN (RSLT in (201,203,204) or ROW_NUMBER () OVER (partition by SLID order by DATE_2 desc) > 1) and (DATEDIFF(DAY, DATE_1, DATE_2) + 1 - (SELECT COUNT(*) FROM dbo.WORK_DAY wd WHERE wd.LPU = LPU and LPU=LPU and wd.PODR_ID = LPU_1 and H_DATE BETWEEN DATE_1 AND DATE_2) > 3 or NKSG in (select ksg from @ksg0)) THEN 
									@ds_base*KZ*ISNULL(UP,1.00)*ISNULL(IT_SL,1.00) * 1 
								ELSE
								(CASE
									WHEN (DATEDIFF(DAY, DATE_1, DATE_2) + 1 - (SELECT COUNT(*) FROM dbo.WORK_DAY wd WHERE wd.LPU = LPU and LPU=LPU and wd.PODR_ID = LPU_1 and H_DATE BETWEEN DATE_1 AND DATE_2) > 3 or NKSG in (select ksg from @ksg0)) THEN 
										@ds_base*KZ*ISNULL(UP,1.00)*ISNULL(IT_SL,1.00) * 0.9 
									ELSE 
										@ds_base*KZ*ISNULL(UP,1.00)*ISNULL(IT_SL,1.00) * 0.8
								END)
							END)
							
							-- терапевтическая КСГ ДС

							WHEN USL_OK = 2 and NKSG not in (select ksg from @ksgh) THEN 
							(CASE
								WHEN (RSLT in (201,203,204) or ROW_NUMBER () OVER (partition by SLID order by DATE_2 desc) > 1) and (DATEDIFF(DAY, DATE_1, DATE_2) + 1 - (SELECT COUNT(*) FROM dbo.WORK_DAY wd WHERE wd.LPU = LPU and LPU=LPU and wd.PODR_ID = LPU_1 and H_DATE BETWEEN DATE_1 AND DATE_2) > 3 or NKSG in (select ksg from @ksg0))
								THEN 
									@ds_base*KZ*ISNULL(UP,1.00)*ISNULL(IT_SL,1.00) * 1 
								ELSE
								(CASE
									WHEN (DATEDIFF(DAY, DATE_1, DATE_2) + 1 - (SELECT COUNT(*) FROM dbo.WORK_DAY wd WHERE wd.LPU = LPU and LPU=LPU and wd.PODR_ID = LPU_1 and H_DATE BETWEEN DATE_1 AND DATE_2) > 3 or NKSG in (select ksg from @ksg0))
								    THEN 
										@ds_base*KZ*ISNULL(UP,1.00)*ISNULL(IT_SL,1.00) * 0.5 
									ELSE 
										@ds_base*KZ*ISNULL(UP,1.00)*ISNULL(IT_SL,1.00) * 0.2
								END)
							END)
                            END),2) AS NUMERIC (10 ,2)),
                        TARIF=
                            CAST(ROUND(
							(CASE 
                            WHEN USL_OK = 1 THEN @ks_base*KZ*ISNULL(UP,1.00)*(CASE WHEN NKSG in (select [IDKSG] from [dbo].[CalNotKus] Where DATE_2 >= TBEG and DATE_2 < TEND +1) THEN 1.00 ELSE ISNULL(U,1.00) END)*ISNULL(IT_SL,1.00)
                            WHEN USL_OK = 2 THEN @ds_base*KZ*ISNULL(UP,1.00)*ISNULL(IT_SL,1.00)
                            END),2) AS NUMERIC (10 ,2))
FROM (	Select ROW_NUMBER () OVER (partition by SLID, ID order by sur_ksg desc, KZ desc, (case when USL is NULL THEN 0 ELSE 1 end) desc)  rn_itog, * FROM @temp_ksg_itog
) itog where rn_itog =1

DECLARE sum0_cursor CURSOR FOR   
			select slid from @temp_ksg_calc
			group by SLID having count(*) > 1
declare @slid0 int  

OPEN sum0_cursor  
  
FETCH NEXT FROM sum0_cursor   
INTO @slid0
  
WHILE @@FETCH_STATUS = 0  
BEGIN  

--патологии беременности 
	IF (select count(*) from @temp_ksg_calc 
	where slid =@slid0 and 
			'st02.001' in (select IDKSG from @temp_ksg_calc where slid =@slid0) 
			and ('st02.003' in (select IDKSG from @temp_ksg_calc where slid =@slid0) or 'st02.004' in (select IDKSG from @temp_ksg_calc where slid =@slid0))
			and not ((select top 1 KDAY from @temp_ksg_calc where slid =@slid0 and NKSG = 'st02.001') > 1
			and (select top 1 tf_ds from @temp_ksg_calc where slid =@slid0 and NKSG = 'st02.001') in ('O14.1', 'O34.2', 'O36.3', 'O36.4', 'O42.2')
													 or (select top 1 KDAY from @temp_ksg_calc where slid =@slid0 and NKSG = 'st02.001') > 5)
	) > 0
	UPDATE @temp_ksg_calc SET SUMV_USL = 0 where slid =@slid0 and IDKSG = 'st02.001'

    FETCH NEXT FROM sum0_cursor   
    INTO @slid0 
END   
CLOSE sum0_cursor;  
DEALLOCATE sum0_cursor; 

Select zsl.zsl_id, itog.*
 --rn_itog, ID, IDKSG, KDAY, SUMV_USL SUMV, TARIF -- ��
 --SLID, sl_sumv, ISNULL(CONVERT(nvarchar(250 ), SUMV_USL), '') com -- ���
 --into tempKsg201803
 From @temp_ksg_calc itog
  join d3_zsl_oms zsl on itog.slid=zsl.id
  join D3_SCHET_OMS sc on zsl.d3_scid = sc.id
and
( (NKSG <> tf_idksg or SUMV_USL <> tf_sumv_usl) and tf_sumv_usl <> 0 
		--and not ((tf_idksg in (700,702,703,1126,1128,1129) and tf_sumv_usl = 0) or tf_idksg in (1344,1560,1561,1562,1563))
)

