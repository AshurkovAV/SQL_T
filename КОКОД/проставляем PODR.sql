
--declare @p1 int = 1276

	update sl set sl.podr=podr.podr
--select distinct p.D3_SCID,zsl.id,sl.iddokt,zsl.usl_ok,sl.podr,podr.podr
	FROM D3_PACIENT_OMS p
			inner join D3_ZSL_OMS zsl on zsl.D3_PID=p.id 
				inner join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID
			left join kokod_podr podr --select * from kokod_podr
					--on zsl.zsl_id=podr.zsl_id
					--and sl.sl_id=podr.sl_id
					on podr.IDDOCT=dbo.p_digit_only(sl.IDDOKT)
					and zsl.USL_OK=substring(podr.podr,7,1)
					and len(podr.podr)=12
	where 
p.D3_SCID   IN (16139)
		--p.D3_SCID=@p1
--		--------------
	--AND zsl.zsl_id in ('BC1AF4C6-9AE0-08EE-E053-350AA8C035ED')
--'B312EA10-4CBD-08F4-E053-350AA8C09AA0')
		and sl.PODR is null
		and (
				zsl.USL_OK in (1,2)
				or zsl.OS_SLUCH_REGION=6
			)
		and podr.podr is  not null
	