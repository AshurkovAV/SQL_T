--select osp.Pol2Q,osp.Pol2PolTp,osp.Pol2Npol,osp.pol2enp,case when osp.Pol2PolTp=3 then osp.Pol2Enp else osp.Pol2Npol end ,p.smo,p.VPOLIS,p.SPOLIS,p.NPOLIS,zsl.date_z_2,zsl.ZSL_ID
   update p set p.SMO=osp.Pol2Q,p.VPOLIS=osp.Pol2PolTp,p.NPOLIS=case when osp.Pol2PolTp=3 then osp.Pol2Enp else osp.Pol2Npol end 
    FROM D3_SCHET_oms sch 
      inner join D3_PACIENT_OMS p on sch.id=p.D3_SCID
        inner join D3_ZSL_OMS zsl on zsl.D3_PID=p.id 
          inner join 
            (
              select *
              from osp_kokod
              where coments in 
                (
                  'Некорректные данные ДПФС'
                  --,'Некорректный код СМО'
                  ,'Нет действующих ДПФС на дату выписки'
                )
            ) osp
            on osp.ftype=left(sch.SchetType,1)
            and osp.zsl_id=zsl.zsl_id
            ------------------------------------
            and isnull(osp.polactive,0)=0 and osp.polid2 is NOT NULL
  
  
  --select osp.Pol2Q,osp.Pol2PolTp,osp.Pol2Npol,osp.pol2enp,case when osp.Pol2PolTp=3 then osp.Pol2Enp else osp.Pol2Npol end ,p.smo,p.VPOLIS,p.SPOLIS,p.NPOLIS,zsl.date_z_2,zsl.ZSL_ID
--   update p set p.SMO=osp.Pol2Q,p.VPOLIS=osp.Pol2PolTp,p.NPOLIS=case when osp.Pol2PolTp=3 then osp.Pol2Enp else osp.Pol2Npol end
UPDATE p SET fam = osp.PplFam, im = osp.Pplim, ot = osp.Pplot, dr = osp.Ppldr 
    FROM D3_SCHET_oms sch 
      inner join D3_PACIENT_OMS p on sch.id=p.D3_SCID
        inner join D3_ZSL_OMS zsl on zsl.D3_PID=p.id 
          inner join 
            (
              select *
              from osp_kokod
              where coments in 
                (
                  'Некорректные данные ЗЛ'
                )
            ) osp
            on osp.ftype=left(sch.SchetType,1)
            and osp.zsl_id=zsl.zsl_id
            ------------------------------------
       --     and isnull(osp.polactive,0)=0 and osp.polid2 is not null   