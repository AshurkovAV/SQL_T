



 SELECT t.*, v.fam fam1 , v.im im1, v.ot ot1, v.dr dr1, v.ds1 ds11, v.stad stad1
 INTO temp_onko_stadia_Nat
 FROM   temp_onko_stadia t 
 left join (SELECT distinct p.npolis,p.fam, p.im,p.ot,p.dr, s.ds1,MAX(onk.stad) stad
--into temp_disp_10
            FROM 
           [D3_SCHET_OMS] sch                  
          inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
            inner join D3_ZSL_OMS zs on zs.D3_PID=p.id     --AND zs.id=20906231
           join D3_SL_OMS s on s.D3_ZSLID=zs.ID   
         JOIN temp_onko_stadia t ON t.npolis=p.npolis AND t.ds1=s.DS1
              join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id AND stad IS NOT NULL
            GROUP BY p.npolis,p.fam, p.im,p.ot,p.dr, s.ds1 ) v ON t.npolis=v.npolis AND t.ds1=v.DS1