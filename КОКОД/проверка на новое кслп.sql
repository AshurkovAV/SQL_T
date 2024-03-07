
--вставляем новый критерий SUPT%
 
 --INSERT INTO [D3_CRIT_OMS] ( 
 --     [D3_KSGID]
 --     ,[D3_KSGGID]
 --     ,[CRIT])
 --SELECT DISTINCT  ksg.id, Ksg.KSG_ID,'supt05'

declare @p1 int = 18504
select 
          
          zsl.id as ID, zsl.sumv as SUMV, '''' com
          , SlKoef.IDSL, dbo.f_GetAge(p.DR,sl.DATE_1), ksg.N_KSG, k.*, Crit.ID, LekPr.id
           -----------
          
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS        p on p.d3_scid=sch.id and sch.ID = @p1
  inner join D3_ZSL_OMS            zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id
    inner join D3_SL_OMS             sl on sl.D3_ZSLID=zsl.ID
  --химиопрепараты
  left join D3_ONK_SL_OMS          OnkSl on OnkSl.D3_SLID=sl.id 
  left join D3_ONK_USL_OMS         OnkUsl on OnkUsl.D3_ONKSLID=OnkSl.ID 
  left join D3_LEK_PR_OMS          LekPr on LekPr.D3_ONKUSLID=OnkUsl.id and LekPr.REGNUM in (002212,000764,002400)
  inner join D3_KSG_KPG_OMS        Ksg on Ksg.D3_SLID=sl.id
  inner join D3_SL_KOEF_OMS        SlKoef on SlKoef.D3_KSGID=Ksg.ID and SlKoef.IDSL in (4122,4132) --есть КСЛП
  left join D3_CRIT_OMS            Crit on Crit.D3_KSGID=ksg.id and Crit.CRIT like 'supt%'
  left join FLK_KSLP_KSG_ALLOW     k on k.K_KSG=ksg.N_KSG and DATE_2 between k.[DATEBEG] and k.[DATEEND]
WHERE  --есть ошибки
          (k.id is null --недопустимый код КСГ
      OR SlKoef.IDSL!=k.IDSL --код КСЛП не соответствует условию оказания
      OR dbo.f_GetAge(p.DR,sl.DATE_1)<18  --не взрослый
      OR Crit.ID is null --нет критерия like 'supt%'
          OR LekPr.id is not null --среди назначенных в схеме есть препараты
      )