
declare @p1 int =1798;
with z as (
select distinct-- DATEDIFF(DAY, sl.DATE_1, sl.DATE_2), ROW_NUMBER () OVER (partition by zsl.id  order by sl.DATE_2 desc),
zsl.ZSL_ID,
zsl.rslt,sl.date_2,
sch.id sch,sl.sum_m, bt.BZTSZ  ,ks.KOEF_UP,
--------------------------------------------------------------------------------------
                      case when zsl.USL_OK=1 then
          
        --------------------------------------------------------------------------
        case when year(sl.date_2)<=2020     then
          case when  
                         -------------------для дородовых госпитализаций отдельный расчет 
               ( ks.N_KSG in ('st02.001') and  zsl.RSLT in (101,103,104) and  ( DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)>5   or ( DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)>1 and sl.ds1 in ('O14.1','O34.2 ','O36.3','O36.4','O42.2'))       )) 
                or
                         (
                 ROW_NUMBER () OVER (partition by zsl.id order by sl.DATE_2 desc)>1 
                 and 
                DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)>3
              
                ) 
                or 
                (ROW_NUMBER () OVER (partition by zsl.id order by sl.DATE_2 desc)=1 and  RSLT in (101,103,104) and 
                DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)>3
              
                ) 

                or 
                (ROW_NUMBER () OVER (partition by zsl.id order by sl.DATE_2 desc)=1 and  RSLT not in (101,103,104) and 
                DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)>3
                and year(zsl.date_z_2)=2021
              
                ) 



                or 
                (DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)<=3 and calc.kd is not null and  RSLT in (101,103,104)) 

            then case when ks.N_KSG  in ('st12.013.2') and DATE_2>'20201031' then 
                                                                             case when  DATEDIFF(DAY, DATE_1, DATE_2) between 4 and 7 then  0.5  
                                                 when DATEDIFF(DAY, DATE_1, DATE_2) between 8 and 10 then 0.7
                                                  when DATEDIFF(DAY, DATE_1, DATE_2)>10 then 1
                                                  end
                                                                                else  1 end

            
                else 
                   case
                 ---- zsl.RSLT not in (101,103)
    when  ( ( DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)<=3 and calc.kd is null ) or ( (zsl.RSLT not in (101,103,104) ) and  DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)<=3) )   and calc.tip='ter' then 0.2

    when   (  ( DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)<=3 and calc.kd is null)  or ( zsl.RSLT not in (101,103,104) and  DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)<=3) )  and calc.tip='hir' then 0.8 

    when  ( (zsl.RSLT not in (101,103,104) ) and  DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)>3)   and calc.tip='ter' then case when ks.N_KSG  in ('st12.013.2') and DATE_2>'20201031'
                                                                                                      
                                                      then case when  DATEDIFF(DAY, DATE_1, DATE_2) between 4 and 7 then  0.5  
                                                             when DATEDIFF(DAY, DATE_1, DATE_2) between 8 and 10 then 0.7
                                                          when DATEDIFF(DAY, DATE_1, DATE_2)>10 then 0.5
                                                                                                          end
                                                              else   0.5 end
                    
    when  (zsl.RSLT not in (101,103,104) and  DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)>3)     and calc.tip='hir' then 0.9

                    
                  
             end 
          end
    --        end  -----------------------------------------------------------------------------------------------


else 
             
              case when  
                    ( ks.N_KSG in ('st02.001') and  zsl.RSLT in (101,103) and  ( DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)>5   or ( DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)>1 and sl.ds1 in ('O14.1','O34.2 ','O36.3','O36.4','O42.2'))       )) 
                or
                (ROW_NUMBER () OVER (partition by zsl.id order by sl.DATE_2 desc)=1 and  RSLT in (101,103) and 
                DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)>3
                ) 
                or 
                (DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)<=3 and calc.kd is not null and  RSLT in (101,103)
                and  ROW_NUMBER () OVER (partition by zsl.id order by sl.DATE_2 desc)=1
                ) 
            then 1
                else 
                   case
                 ---- zsl.RSLT not in (101,103)
    when ( (ROW_NUMBER () OVER (partition by zsl.id order by sl.DATE_2 desc)>1 and  DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)<=3) or ( ( DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)<=3 and calc.kd is null ) or ( zsl.RSLT not in (101,103) and  DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)<=3) ) )   and calc.tip='ter' then 0.2

    when(  (ROW_NUMBER () OVER (partition by zsl.id order by sl.DATE_2 desc)>1 and  DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)<=3)  or ( ( DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)<=3 and calc.kd is null)  or ( zsl.RSLT not in (101,103) and  DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)<=3) ) ) and calc.tip='hir' then 0.8 

    when(  (ROW_NUMBER () OVER (partition by zsl.id order by sl.DATE_2 desc)>1 and DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)>3) or ( ( zsl.RSLT not in (101,103) and  DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)>3) ))  and calc.tip='ter' then 0.5
                    
    when(  (ROW_NUMBER () OVER (partition by zsl.id order by sl.DATE_2 desc)>1 and DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)>3) or (  (zsl.RSLT not in (101,103) and  DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)>3) ))   and calc.tip='hir' then 0.9

                    
                    end
              end 
          end end as kkkk



,
--,
                     cast(cast(ROUND(
            bt.BZTSZ  
                   *
           ks.KOEF_Z
                     *
                     ks.KOEF_UP--
          -- case when calc.up is null then ks.KOEF_UP else 1 end
                     *
                     ks.KOEF_D
                     *
                     case 
                            when isnull(ks.IT_SL,0)=0
                            then 1
                            else ks.IT_SL
                     end
                     *
           CASE 
            WHEN  zsl.usl_ok=2 
                or ks.N_KSG in (  select [IDKSG] 
                                from CalNotKus
                                Where sl.DATE_2 between TBEG and TEND
                                )
            THEN 1.00
            ELSE ISNULL(ks.KOEF_U,1.00) 
           END
           *
           -----------------------------------------------------------------------------------------
                      case when zsl.USL_OK=1 then
          
        --------------------------------------------------------------------------
        case when year(sl.date_2)<=2020     then
          case when  
                         -------------------для дородовых госпитализаций отдельный расчет 
               ( ks.N_KSG in ('st02.001') and  zsl.RSLT in (101,103,104) and  ( DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)>5   or ( DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)>1 and sl.ds1 in ('O14.1','O34.2 ','O36.3','O36.4','O42.2'))       )) 
                or
                         (
                 ROW_NUMBER () OVER (partition by zsl.id order by sl.DATE_2 desc)>1 
                 and 
                DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)>3
              
                ) 
                or 
                (ROW_NUMBER () OVER (partition by zsl.id order by sl.DATE_2 desc)=1 and  RSLT in (101,103,104) and 
                DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)>3
              
                )


or 
                (ROW_NUMBER () OVER (partition by zsl.id order by sl.DATE_2 desc)=1 and  RSLT not in (101,103,104) and 
                DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)>3
                and year(zsl.date_z_2)=2021
              
                ) 



                or 
                (DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)<=3 and calc.kd is not null and  RSLT in (101,103,104)) 

            then case when ks.N_KSG  in ('st12.013.2') and DATE_2>'20201031' then 
                                                                             case when  DATEDIFF(DAY, DATE_1, DATE_2) between 4 and 7 then  0.5  
                                                 when DATEDIFF(DAY, DATE_1, DATE_2) between 8 and 10 then 0.7
                                                  when DATEDIFF(DAY, DATE_1, DATE_2)>10 then 1
                                                  end
                                                                                else  1 end

            
                else 
                   case
                 ---- zsl.RSLT not in (101,103)
    when  ( ( DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)<=3 and calc.kd is null ) or ( (zsl.RSLT not in (101,103,104) ) and  DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)<=3) )   and calc.tip='ter' then 0.2

    when   (  ( DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)<=3 and calc.kd is null)  or ( zsl.RSLT not in (101,103,104) and  DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)<=3) )  and calc.tip='hir' then 0.8 

    when  ( (zsl.RSLT not in (101,103,104) ) and  DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)>3)   and calc.tip='ter' then case when ks.N_KSG  in ('st12.013.2') and DATE_2>'20201031'
                                                                                                      
                                                      then case when  DATEDIFF(DAY, DATE_1, DATE_2) between 4 and 7 then  0.5  
                                                             when DATEDIFF(DAY, DATE_1, DATE_2) between 8 and 10 then 0.7
                                                          when DATEDIFF(DAY, DATE_1, DATE_2)>10 then 0.5
                                                                                                          end
                                                              else   0.5 end
                    
    when  (zsl.RSLT not in (101,103,104) and  DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)>3)     and calc.tip='hir' then 0.9

                    
                  
             end 
          end
    --        end  -----------------------------------------------------------------------------------------------

                       else 
             
              case when  
                    ( ks.N_KSG in ('st02.001') and  zsl.RSLT in (101,103) and  ( DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)>5   or ( DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)>1 and sl.ds1 in ('O14.1','O34.2 ','O36.3','O36.4','O42.2'))       )) 
                or
                (ROW_NUMBER () OVER (partition by zsl.id order by sl.DATE_2 desc)=1 and  RSLT in (101,103) and 
                DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)>3
                ) 
                or 
                (DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)<=3 and calc.kd is not null and  RSLT in (101,103)
                and  ROW_NUMBER () OVER (partition by zsl.id order by sl.DATE_2 desc)=1
                ) 
            then 1
                else 
                   case
                 ---- zsl.RSLT not in (101,103)
    when ( (ROW_NUMBER () OVER (partition by zsl.id order by sl.DATE_2 desc)>1 and  DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)<=3) or ( ( DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)<=3 and calc.kd is null ) or ( zsl.RSLT not in (101,103) and  DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)<=3) ) )   and calc.tip='ter' then 0.2

    when(  (ROW_NUMBER () OVER (partition by zsl.id order by sl.DATE_2 desc)>1 and  DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)<=3)  or ( ( DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)<=3 and calc.kd is null)  or ( zsl.RSLT not in (101,103) and  DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)<=3) ) ) and calc.tip='hir' then 0.8


when(  (ROW_NUMBER () OVER (partition by zsl.id order by sl.DATE_2 desc)>1 and DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)>3) or ( ( zsl.RSLT not in (101,103) and  DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)>3) ))  and calc.tip='ter' then 0.5
                    
    when(  (ROW_NUMBER () OVER (partition by zsl.id order by sl.DATE_2 desc)>1 and DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)>3) or (  (zsl.RSLT not in (101,103) and  DATEDIFF(DAY, sl.DATE_1, sl.DATE_2)>3) ))   and calc.tip='hir' then 0.9

                    
                    end
              end 
          end
    ---------------------------------------------------------
    -------------------------------------------------------
    when zsl.USL_OK=2 then
         
      case when year(sl.date_2)<=2020     then
          case when  
                       (ROW_NUMBER () OVER (partition by zsl.id order by sl.DATE_2 desc)>1 and 
                sl.kd>3
              
                ) 
                or 

                (ROW_NUMBER () OVER (partition by zsl.id order by sl.DATE_2 desc)=1 and  RSLT in (201,203,204) and 
                sl.kd>3
              
                ) 
                or 
                (sl.kd<=3 and calc.kd is not null and  RSLT in (201,203,204)) 
            then 1 
            
                else 
                   case
                 ---- zsl.RSLT not in (101,103)
    when ( ( sl.kd<=3 and calc.kd is null ) or ( zsl.RSLT not in (201,203,204) and  sl.kd<=3) )    and calc.tip='ter' then 0.2

    when( (  sl.kd<=3 and calc.kd is null)  or ( zsl.RSLT not in (201,203,204) and  sl.kd<=3) )  and calc.tip='hir' then 0.8 

    when zsl.RSLT not in (201,203,204) and sl.kd>3   and calc.tip='ter' then  0.5
                    
    when zsl.RSLT not in (201,203,204) and  sl.kd>3   and calc.tip='hir' then 0.9

                    
                   end
             end 
                       else 
             
              case when  
                (ROW_NUMBER () OVER (partition by zsl.id order by sl.DATE_2 desc)=1 and  RSLT in (201,203) and 
                sl.kd>3
                ) 
                or 
                (sl.kd<=3 and calc.kd is not null and  RSLT in (201,203)) 
            then 1
                else 
                   case
                 ---- zsl.RSLT not in (101,103)
    when ( ( ROW_NUMBER () OVER (partition by zsl.id order by sl.DATE_2 desc)>1 and  sl.kd<=3)  or ( ( sl.kd<=3 and calc.kd is null ) or ( zsl.RSLT not in (201,203) and  sl.kd<=3) ) )    and calc.tip='ter' then 0.2

    when( (ROW_NUMBER () OVER (partition by zsl.id order by sl.DATE_2 desc)>1 and  sl.kd<=3)  or ( ( sl.kd<=3 and calc.kd is null)  or ( zsl.RSLT not in (201,203) and  sl.kd<=3) ) ) and calc.tip='hir' then 0.8 

    when( (ROW_NUMBER () OVER (partition by zsl.id order by sl.DATE_2 desc)>1 and  sl.kd>3) or ( ( zsl.RSLT not in (201,203) and  sl.kd>3) ))  and calc.tip='ter' then 0.5
                    
    when( (ROW_NUMBER () OVER (partition by zsl.id order by sl.DATE_2 desc)>1 and  sl.kd>3) or (  (zsl.RSLT not in (201,203) and  sl.kd>3) ))   and calc.tip='hir' then 0.9

                    
                    end
              end 
          end

      

       --------------------------------




       end


,2) 
     +
     isnull((  SELECT  SUM(isnull(rr.TARIF,0)*u.kol_usl)
          FROM D3_USL_OMS u
          left JOIN CalcUslTarif rr ON rr.UMP=zsl.usl_ok and rr.CODE_USL = u.CODE_USL AND sl.DATE_2 BETWEEN rr.TBEG AND rr.TEND --платные услуги
           WHERE u.D3_SLID = sl.ID
        ),0)
     +
     isnull((  SELECT  SUM(isnull(gg.SUM_G,0))/2
          FROM D3_USL_OMS u
          left JOIN CalcGemTarif gg ON gg.UMP=zsl.usl_ok and gg.CodeUSL = u.VID_VME AND sl.DATE_2 BETWEEN gg.DATEBEG AND gg.DATEEND--гемодиализ
          WHERE u.D3_SLID = sl.ID
        ),0)
     as numeric(15,2)) as nvarchar(50)) as baz
     ,calc.*
     ,ROW_NUMBER () OVER (partition by zsl.id order by sl.DATE_2 desc) RNNNNN,DATEDIFF(DAY, sl.DATE_1, sl.DATE_2) kdz,sl.kd slkd,sch.code_mo,zsl.id as ZID,zsl.sumv
     ,  isnull((  SELECT  SUM(isnull(u.SUMV_USL,0))
          FROM D3_USL_OMS u
        
          WHERE u.D3_SLID = sl.ID
        ),0) as uslugi
      

FROM [D3_SCHET_OMS] sch                  
inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
inner join D3_ZSL_OMS zsl on zsl.D3_PID=p.id  
inner join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID
JOIN D3_KSG_KPG_OMS ks  ON sl.id = ks.D3_SLID
LEFT JOIN CalcKsgTarif ksg  ON ksg.IDKSG = ks.N_KSG AND sl.DATE_2 BETWEEN ksg.DBEG AND ksg.DEND
left join [CalcKsg] calc on calc.K_KSG=ks.N_KSG and sl.DATE_2 between calc.DATEBEG and isnull(calc.DATEEND,'20991231')
left join SprBZTSZ bt on bt.USL_OK=zsl.usl_ok and sl.DATE_2 between bt.DBEG and bt.DEND
 

WHERE 1=1
  and  sum_m<>0 
  and calc.lek is null
  
  --and zsl.id='34459048'
  and sch.id=@p1
  --and ks.N_KSG='st02.01'
  --and zsl.usl_ok in (1)
  --and sch.year=2021
  --and sch.month=1
  --and sch.code_mo='460026'
  --and zsl.id=32713279
  )
  select-- z.*--,
  z.zid as ID,z.sumv
  
  --distinct z.CODE_MO,count (distinct z.zid)
  from z
  where isnull(z.baz,1) not between SUM_M-0.1 and SUM_M+0.1
  --group  by z.CODE_MO
  --z.baz<>sl.SUM_M-0.1 
  --and  z.baz<sl.SUM_M+0.1