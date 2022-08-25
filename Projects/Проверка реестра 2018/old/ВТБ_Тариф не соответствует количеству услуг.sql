--Тариф не соответствует количеству услуг
 declare @p1 int = 2071

declare @tt table (
tt_COUNT int,
tt_TARIF numeric (15,2),
TBEG datetime,
TEND datetime
)
 
Insert @tt select 1, tarif1, TBEG, TEND from CalcAmbTARIF where OS_SLUCH=11
Insert @tt select 2, tarif2, TBEG, TEND from CalcAmbTARIF where OS_SLUCH=11
Insert @tt select 3, tarif3, TBEG, TEND from CalcAmbTARIF where OS_SLUCH=11
Insert @tt select 4, tarif4, TBEG, TEND from CalcAmbTARIF where OS_SLUCH=11
Insert @tt select 5, tarif5, TBEG, TEND from CalcAmbTARIF where OS_SLUCH=11
Insert @tt select 6, tarif6, TBEG, TEND from CalcAmbTARIF where OS_SLUCH=11
Insert @tt select 7, tarif7, TBEG, TEND from CalcAmbTARIF where OS_SLUCH=11
Insert @tt select 8, TARIF8, TBEG, TEND from CalcAmbTARIF where OS_SLUCH=11
Insert @tt select 9, TARIF9, TBEG, TEND from CalcAmbTARIF where OS_SLUCH=11

Select ID, SUMV, cnt,

 case when tt_TARIF is not null then 'Тариф не соответствует количеству услуг' else 'Неправильный тариф ПО детей' end com
FROM (	select zsl.ID, zsl.SUMV, zsl.DATE_Z_2, count(*) cnt  
		FROM D3_ZSL zsl
		join D3_SL sl on sl.d3_zslid=zsl.id and PROFIL not in (72,73)
		where zsl.D3_SCID = @p1 and zsl.OS_SLUCH_REGION = 11
		group by zsl.ID, zsl.SUMV, zsl.DATE_Z_1, zsl.DATE_Z_2) sl
		
Left Join @tt tt on sl.SUMV = tt.tt_TARIF and sl.DATE_Z_2>=tt.TBEG and sl.DATE_Z_2<=tt.TEND
Where sl.cnt < tt.tt_COUNT or tt_TARIF is null
group by ID, SUMV, cnt, tt_TARIF