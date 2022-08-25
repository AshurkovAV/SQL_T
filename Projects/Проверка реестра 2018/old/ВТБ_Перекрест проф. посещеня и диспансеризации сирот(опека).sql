--Перекрест проф. посещеня и диспансеризации сирот(опека)
declare @p1 int=2077
Select zsl.ID, zsl.SUMV, 'Перекрест проф. посещеня и диспансеризации сирот(опека)' com
from	(	Select pa.FAM, pa.IM, pa.OT, pa.DR, zsl.DATE_Z_1, zsl.DATE_Z_2 
			FROM D3_ZSL_OMS zsl
			join D3_PACIENT_OMS pa on pa.ID = zsl.D3_PID
			where zsl.D3_SCID = @p1 and OS_SLUCH_REGION in (7,17)
		) zsl_os
JOIN	(	Select pa.FAM, pa.IM, pa.OT, pa.DR, zsl.DATE_Z_1, zsl.DATE_Z_2, zsl.ID, zsl.SUMV
			FROM D3_ZSL_OMS zsl
			join D3_SL_OMS sl on sl.d3_zslid=zsl.id
			join D3_PACIENT_OMS pa on pa.ID = zsl.D3_PID
			where zsl.D3_SCID = @p1 and OS_SLUCH_REGION is null and sl.P_CEL = '1.1' and sl.PROFIL not in (16)/*игнорируемые профили*/
		) zsl on zsl.DATE_Z_2 >= zsl_os.DATE_Z_1 and zsl.DATE_Z_2 <= zsl_os.DATE_Z_2 
				and zsl_os.FAM = zsl.FAM and zsl_os.IM = zsl.IM and zsl_os.OT = zsl.OT and zsl_os.DR = zsl.DR
group by zsl.id, zsl.SUMV


--UPDATE D3_ZSL_OMS SET D3_SCID = 2070
--WHERE ID IN (
--Select zsl.ID
--from	(	Select pa.FAM, pa.IM, pa.OT, pa.DR, zsl.DATE_Z_1, zsl.DATE_Z_2 
--			FROM D3_ZSL_OMS zsl
--			join D3_PACIENT_OMS pa on pa.ID = zsl.D3_PID
--			where zsl.D3_SCID = @p1 and OS_SLUCH_REGION in (7,17)
--		) zsl_os
--JOIN	(	Select pa.FAM, pa.IM, pa.OT, pa.DR, zsl.DATE_Z_1, zsl.DATE_Z_2, zsl.ID, zsl.SUMV
--			FROM D3_ZSL_OMS zsl
--			join D3_SL_OMS sl on sl.d3_zslid=zsl.id
--			join D3_PACIENT_OMS pa on pa.ID = zsl.D3_PID
--			where zsl.D3_SCID = @p1 and OS_SLUCH_REGION is null and sl.P_CEL = '1.1' and sl.PROFIL not in (16)/*игнорируемые профили*/
--		) zsl on zsl.DATE_Z_2 >= zsl_os.DATE_Z_1 and zsl.DATE_Z_2 <= zsl_os.DATE_Z_2 
--				and zsl_os.FAM = zsl.FAM and zsl_os.IM = zsl.IM and zsl_os.OT = zsl.OT and zsl_os.DR = zsl.DR
--group by zsl.id, zsl.SUMV)