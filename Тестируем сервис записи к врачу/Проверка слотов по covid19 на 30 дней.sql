DECLARE @dateStart DATETIME = '20210724'
DECLARE @periodAllowCreate14 INT = 14
DECLARE @periodAllowCreate30 INT = 30
DECLARE @depart_oid NVARCHAR(50) = '1.2.643.5.1.13.13.12.2.46.4358.0.403653'

SELECT *
FROM  [GetPositionListGosDb2] (@dateStart, @periodAllowCreate14, 0, @depart_oid) 
SELECT *
FROM  [GetPositionListGosDb2] ('20210724', @periodAllowCreate30, 0, @depart_oid) 

SELECT *
FROM GetDoctorListGosPodrOid ('20210724', 14, 193, 0, @depart_oid )
SELECT *
FROM GetDoctorListGosPodrOid ('20210724', 30, 193, 0, @depart_oid )


SELECT *
FROM GetAvaibleAppointmentsDb('', 260407, '', '20210724', '20210823')