DECLARE @D3_SCID INT = 2071
--без особых случаев региона
Select ID, existTarif, convert(nvarchar(50), trueTarif) com
from(	select isnull(case 
						when sl.P_CEL = '1.1' and zsl.IDSP = 9 then ROUND(ROUND(sl.ED_COL*0.25,2)* t.tarif1, 2)
						when sl.P_CEL = '1.2' and zsl.IDSP = 9 then ROUND(ROUND(sl.ED_COL*0.25,2)* t.tarif2, 2) 
						when sl.P_CEL = '1.3' and zsl.IDSP = 9 then ROUND(ROUND(sl.ED_COL*0.25,2)* t.tarif3, 2) 
						when sl.P_CEL = '2.0' and zsl.IDSP = 9 then ROUND(ROUND(sl.ED_COL*0.25,2)* t.tarif5, 2) 
						when sl.P_CEL = '3.0' and zsl.IDSP = 9 then ROUND(ROUND(sl.ED_COL*0.25,2)* t.tarif3, 2) 
						when sl.P_CEL = '1.1' then t.TARIF1 
						when sl.P_CEL = '1.2' then t.TARIF2 
						when sl.P_CEL = '1.3' then t.TARIF3 
						when sl.P_CEL = '2.0' then t.TARIF4 
						when sl.P_CEL = '3.0' then t.TARIF5 
					end, -999.99) trueTarif, isnull(zsl.SUMV, -1) existTarif, zsl.ID--, zsl.MEK_COUNT
		FROM D3_ZSL zsl
		join D3_SL sl on sl.d3_zslid=zsl.id
		left join CalcAmbTarif t on t.OS_SLUCH is null and sl.USL_OK = t.USL_OK and zsl.idsp = t.IDSP and sl.Profil = t.Profil 
									and zsl.DATE_Z_2 >= t.TBEG and zsl.DATE_Z_2 < t.TEND +1 
		where zsl.D3_SCID = @D3_SCID and sl.usl_ok=3 and zsl.OS_SLUCH_REGION is null
) as tt 
where tt.existTarif <> tt.trueTarif and existTarif <> 0-- and (tt.MEK_COUNT is null or tt.MEK_COUNT=0)
group by ID, existTarif, trueTarif
--гемодиализ
union
Select ID, existTarif, convert(nvarchar(50), trueTarif) 
from(	select isnull(t.TARIF1, -999.99) trueTarif, isnull(zsl.SUMV, -1) existTarif, zsl.ID--, zsl.MEK_COUNT
		FROM D3_ZSL zsl
		join D3_SL sl on sl.d3_zslid=zsl.id
		left join CalcAmbTarif t on t.OS_SLUCH=zsl.OS_SLUCH_REGION and sl.USL_OK = t.USL_OK and zsl.idsp = t.IDSP 
									and sl.Profil = t.Profil and zsl.DATE_Z_2 >= t.TBEG and zsl.DATE_Z_2 < t.TEND +1 
		where zsl.D3_SCID = @D3_SCID and sl.usl_ok=3 and zsl.OS_SLUCH_REGION in (6)
) as tt
where tt.existTarif <> tt.trueTarif and existTarif <> 0-- and (tt.MEK_COUNT is null or tt.MEK_COUNT=0)
group by ID, existTarif, trueTarif
--центры здоровья
union
Select ID, existTarif, convert(nvarchar(50), trueTarif) 
from(	select isnull(t.TARIF1, -999.99) trueTarif, isnull(zsl.SUMV, -1) existTarif, zsl.ID--, zsl.MEK_COUNT
		FROM D3_ZSL zsl
		join D3_SL sl on sl.d3_zslid=zsl.id
		left join CalcAmbTarif t on t.OS_SLUCH=zsl.OS_SLUCH_REGION and sl.USL_OK = t.USL_OK and zsl.idsp = t.IDSP 
									and sl.Profil = t.Profil and zsl.DATE_Z_2 >= t.TBEG and zsl.DATE_Z_2 < t.TEND +1 
		where zsl.D3_SCID = @D3_SCID and sl.usl_ok=3 and zsl.OS_SLUCH_REGION in (4,5)
) as tt
where tt.existTarif <> tt.trueTarif and existTarif <> 0-- and (tt.MEK_COUNT is null or tt.MEK_COUNT=0)
group by ID, existTarif, trueTarif
--ПО взрослых и Период. осмотр детей
union
	Select ID, existTarif, convert(nvarchar(50), trueTarif) 
from(	select isnull(t.TARIF1, -999.99) trueTarif, isnull(zsl.SUMV, -1) existTarif, zsl.ID--, zsl.MEK_COUNT
		FROM D3_ZSL zsl
		join D3_SL sl on sl.d3_zslid=zsl.id
		left join CalcAmbTarif t on t.OS_SLUCH=zsl.OS_SLUCH_REGION and sl.USL_OK = t.USL_OK and zsl.idsp = t.IDSP 
									and zsl.DATE_Z_2 >= t.TBEG and zsl.DATE_Z_2 < t.TEND +1 
where zsl.D3_SCID = @D3_SCID and sl.usl_ok=3 and zsl.OS_SLUCH_REGION in (9,15)
) as tt
where tt.existTarif <> tt.trueTarif and existTarif <> 0-- and (tt.MEK_COUNT is null or tt.MEK_COUNT=0)
group by ID, existTarif, trueTarif
--Скорая помощь
union
Select ID, existTarif, convert(nvarchar(50), trueTarif) com
from(	select isnull(case 
						when zsl.FOR_POM = 2 then t.TARIF4 
						when zsl.FOR_POM = 1 then t.TARIF5 
					end, -999.99) trueTarif, isnull(zsl.SUMV, -1) existTarif, zsl.ID--, zsl.MEK_COUNT
		FROM D3_ZSL zsl
		join D3_SL sl on sl.d3_zslid=zsl.id
		left join CalcAmbTarif t on t.OS_SLUCH is null and sl.USL_OK = t.USL_OK and zsl.idsp = t.IDSP and sl.Profil = t.Profil 
									and zsl.DATE_Z_2 >= t.TBEG and zsl.DATE_Z_2 < t.TEND +1 
		where zsl.D3_SCID = @D3_SCID and sl.usl_ok in (4)
) as tt 
where tt.existTarif <> tt.trueTarif and existTarif <> 0-- and (tt.MEK_COUNT is null or tt.MEK_COUNT=0)
group by ID, existTarif, trueTarif