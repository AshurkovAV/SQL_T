
GO

declare @motconsu int = 619887,
@patients_id int, @sluchai int

select top 10 * from view_emk3_GetAddCase
where IdCaseMis = @motconsu

set @patients_id = (select patients_id from motconsu where motconsu_id = @motconsu)
set @sluchai = (select motconsu_id_sluCHAI_ZABOL from (select * from view_emk3_GetAddCase where IdCaseMis = @motconsu)bb )
exec emk4_GetReferralMse @patients_id,@sluchai

select * from view_emk3_MedicalStaff
where MOTCONSU_ID = @sluchai

select convert(xml, cast(MSE_BodyPreparedReport as varbinary(max)), 1) AS 'Скопируй и вставь в notepad' from motconsu where motconsu_id = @sluchai 