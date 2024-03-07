--declare @p1 int = 85
--без особых случаев региона
Select ID, existTarif, convert(nvarchar(50), trueTarif) com
from(  select isnull(case 
            when sl.P_CEL = '1.1' then ROUND(sl.ED_COL*0.25*t.tarif1, 2)
            when sl.P_CEL = '1.2' then ROUND(sl.ED_COL*0.25*t.tarif2, 2) 
            when sl.P_CEL = '1.3' then ROUND(sl.ED_COL*0.25*t.tarif3, 2) 
            when sl.P_CEL = '2.0' then ROUND(sl.ED_COL*0.25*t.tarif4, 2) 
          end, -999.99) trueTarif, isnull(zsl.SUMV, -1) existTarif, zsl.ID--, zsl.MEK_COUNT
    FROM D3_ZSL_MTR zsl
  join D3_SL_OMS sl on sl.d3_zslid=zsl.id and sl.PROFIL in (63,85,86,87,88,89,90) 
    left join CalcAmbTarif t on t.OS_SLUCH is null and zsl.USL_OK = t.USL_OK and sl.Profil = t.Profil 
                  and zsl.DATE_Z_2 >= t.TBEG and zsl.DATE_Z_2 < t.TEND +1 
    where zsl.D3_SCID = @p1 and sl.usl_ok=3 and zsl.OS_SLUCH_REGION is null and sl.P_CEL<>'3.0' and DATE_Z_2<='20180630'
) as tt 
where tt.existTarif <> tt.trueTarif and existTarif <> 0-- and (tt.MEK_COUNT is null or tt.MEK_COUNT=0)
group by ID, existTarif, trueTarif
union
Select ID, existTarif, convert(nvarchar(50), trueTarif) com
from(  select isnull(case 
            when sl.P_CEL25 = '1.0' then t.TARIF1*isnull(tt.KZMP,1)
            when sl.P_CEL25 = '1.1' then t.TARIF2
            when sl.P_CEL25 = '1.2' then t.TARIF3*isnull(tt.KZMP,1)
            when sl.P_CEL25 = '1.3' then t.TARIF4*isnull(tt.KZMP,1)
            when sl.P_CEL25 = '2.1' then t.TARIF5*isnull(tt.KZMP,1) 
            when sl.P_CEL25 = '2.2' then t.TARIF6*isnull(tt.KZMP,1) 
            when sl.P_CEL25 = '2.3' then t.TARIF7*isnull(tt.KZMP,1) 
            when sl.P_CEL25 = '2.5' then t.TARIF8*isnull(tt.KZMP,1) 
            when sl.P_CEL25 = '2.6' then t.TARIF9*isnull(tt.KZMP,1) 
          end, -999.99) trueTarif, isnull(zsl.SUMV, -1) existTarif, zsl.ID--, zsl.MEK_COUNT
    FROM D3_ZSL_MTR zsl
  join D3_SL_OMS sl on sl.d3_zslid=zsl.id and sl.PROFIL not in (63,85,86,87,88,89,90,171)
    left join CalcAmbTarif t on t.OS_SLUCH is null and zsl.USL_OK = t.USL_OK and sl.Profil = t.Profil 
                  and zsl.DATE_Z_2 >= t.TBEG and zsl.DATE_Z_2 < t.TEND +1 
    left join CalcMok tt on tt.KOD_LPU=zsl.LPU and zsl.DATE_Z_2>=tt.DATESTART and zsl.DATE_Z_2<tt.DATEEND+1
    where zsl.D3_SCID = @p1 and zsl.usl_ok=3 and zsl.OS_SLUCH_REGION is null and sl.P_CEL25 not in ('3.0','3.1') and DATE_Z_2>'20180630'
) as tt 
where tt.existTarif <> tt.trueTarif and existTarif <> 0-- and (tt.MEK_COUNT is null or tt.MEK_COUNT=0)
group by ID, existTarif, trueTarif
--ПО взрослых и Период. осмотр детей
union
Select ID, existTarif, convert(nvarchar(50), trueTarif) 
from(  select isnull(t.TARIF1, -999.99) trueTarif, isnull(zsl.SUMV, -1) existTarif, zsl.ID--, zsl.MEK_COUNT
    FROM D3_ZSL_MTR zsl
  join D3_SL_OMS sl on sl.d3_zslid=zsl.id
    left join CalcAmbTarif t on t.OS_SLUCH=zsl.OS_SLUCH_REGION and zsl.USL_OK = t.USL_OK
                  and zsl.DATE_Z_2 >= t.TBEG and zsl.DATE_Z_2 < t.TEND +1 
where zsl.D3_SCID = @p1 and zsl.usl_ok=3 and zsl.OS_SLUCH_REGION in (9,15)
) as tt
where tt.existTarif <> tt.trueTarif and existTarif <> 0-- and (tt.MEK_COUNT is null or tt.MEK_COUNT=0)
group by ID, existTarif, trueTarif
--Скорая помощь
union
Select ID, existTarif, convert(nvarchar(50), trueTarif) com
from(  select isnull(case 
            when zsl.FOR_POM = 2 then t.TARIF2 
            when zsl.FOR_POM = 1 then t.TARIF1 
          end, -999.99) trueTarif, isnull(zsl.SUMV, -1) existTarif, zsl.ID--, zsl.MEK_COUNT
    FROM D3_ZSL_MTR zsl
  join D3_SL_OMS sl on sl.d3_zslid=zsl.id
    left join CalcAmbTarif t on t.OS_SLUCH is null and zsl.USL_OK = t.USL_OK
                  and zsl.DATE_Z_2 >= t.TBEG and zsl.DATE_Z_2 < t.TEND +1 
    where zsl.D3_SCID = @p1 and zsl.usl_ok in (4)
) as tt 
where tt.existTarif <> tt.trueTarif and existTarif <> 0-- and (tt.MEK_COUNT is null or tt.MEK_COUNT=0)
group by ID, existTarif, trueTarif