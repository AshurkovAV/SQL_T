DECLARE @p_guid VARCHAR(36) = 'FC696545-59DC-4401-9471-E8F8B2CDE66B' --ввести гуид пациента из запроса 
,@pat_id INT 
SET @pat_id = (SELECT patients_id FROM dbo.PATIENTS AS p WHERE p.KRN_GUID = @p_guid)

SELECT patients_id 
,p.NOM,prenom
,p.PATRONYME
FROM dbo.PATIENTS AS p
WHERE krn_guid LIKE @p_guid

select KRN_GUID FROM PATIENTS where KRN_GUID = @p_guid
--go
alter table patients disable trigger all
--go
UPDATE PATIENTS
set KRN_GUID = NEWID()
WHERE KRN_GUID = @p_guid
--go
alter table patients enable trigger all
--go
select KRN_GUID FROM PATIENTS where patients_id = @pat_id