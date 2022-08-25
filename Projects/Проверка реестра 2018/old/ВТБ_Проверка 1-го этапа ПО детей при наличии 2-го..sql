
--Проверка 1-го этапа ПО детей при наличии 2-го.

declare  @p1 int
Set  @p1=2077
Select zsl.ID, zsl.SUMV, '' com 
FROM D3_ZSL_OMS zsl
Where zsl.d3_SCID = @p1 and zsl.OS_SLUCH_REGION = 12
		and zsl.ID not in (	Select t1.ID 
							From (	Select zsl.ID, pa.FAM, pa.IM, pa.OT, pa.DR, DATE_Z_1 
									FROM D3_ZSL_OMS zsl
									Join D3_PACIENT_OMS pa on zsl.d3_PID = pa.ID
									Where zsl.d3_SCID = @p1 and zsl.OS_SLUCH_REGION = 12
								 ) as t1
							Join (	Select pa.FAM, pa.IM, pa.OT, pa.DR, max(DATE_Z_2) DATE_Z_2
									FROM D3_ZSL_OMS zsl
									Join D3_PACIENT_OMS pa on zsl.d3_PID = pa.ID
									Where zsl.OS_SLUCH_REGION = 11
									group by pa.FAM, pa.IM, pa.OT, pa.DR
								 ) as t2  on t1.FAM = t2.FAM and t1.IM = t2.IM and t1.OT = t2.OT and t1.DR = t2.DR and t2.DATE_Z_2-t1.DATE_Z_1>=45
						  )
GROUP BY zsl.ID, zsl.SUMV