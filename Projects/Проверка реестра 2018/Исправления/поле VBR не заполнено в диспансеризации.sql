DECLARE @p1 INT=2347
SELECT distinct 
zs.ID, 
zs.SUMV,''com--'поле VBR не заполнено в диспансеризации
    from 
      D3_ZSL_oms zs
        join D3_SCHET_OMS sc on sc.id=zs.D3_SCID AND sc.id=@p1
        join D3_PACIENT_OMS p on p.ID = zs.D3_PID
       	
WHERE  zs.vbr IS null AND  zs.OS_SLUCH_REGION IN (7,8,9,11,12,17,18,22,23,37,38,47,48,49)
