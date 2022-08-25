use RegistrySemd
go

select 
distinct(bb.Organization) 'Организация'
,bb.Name
,(select count (distinct bb.idcasemis)) 'Уникальных направлений на МСЭ'
,count(*) 'Всего попыток отправки'
,sum(case when bb.Status = 4 then 1 else 0 END) 'Успешно зарегистрировано в МЗ'
from (
select 
--top 100
--i.Name, 
IdCaseMis, c.IdCase, rr.Date,r.Organization, ext.Name, r.IdSource, r.IdRemdSource,m.idMedDocumentType, rr.status, rr.Message, rr.MessageId, rr.IdRegistryRemd, rr.IdRequest
from Remd r
join RegistrySemd.dbo.RegistryRemd rr on rr.IdRemd = r.IdRemd and r.IdRemdSource = '1'
join EMK.dbo.MedDocument m on r.IdSource = m.IdMedDocument and m.idMedDocumentType = '16'
--join ExternalDataInstances.dbo.Instance i on i.IdLpu = r.Organization
    --and Status = '5'
    --and rr.Message like "%Code: OBJECT_NOT_FOUND%"
join EMK.dbo.Step s     on m.IdStep=s.IdStep 
join EMK.dbo.[Case] c on c.IdCase=s.IdCase
join ExternalDataInstances.dbo.Instance ext on c.IdLpu=ext.IdLpu
where rr.DATE >= '2021-01-01' --between '2021-01-01' and '2021-25-05' --and IdCaseMIS = 1834475
--order by Date desc
) bb

group by bb.Organization, bb.Name



select 
distinct(bb.Organization) 'Организация'
,bb.Name
,(select distinct(bb.IdCaseMIS)) 'Идентификатор данных в МИС'
,count(*) 'Попыток отправки'
,sum(case when bb.Status = 4 then 1 else 0 END) 'Успешно зарегистрировано в МЗ'
from (
select 
--top 100
--i.Name, 
IdCaseMis, c.IdCase, rr.Date,r.Organization, ext.Name, r.IdSource, r.IdRemdSource,m.idMedDocumentType, rr.status, rr.Message, rr.MessageId, rr.IdRegistryRemd, rr.IdRequest
from Remd r
join RegistrySemd.dbo.RegistryRemd rr on rr.IdRemd = r.IdRemd and r.IdRemdSource = '1'
join EMK.dbo.MedDocument m on r.IdSource = m.IdMedDocument and m.idMedDocumentType = '16'
--join ExternalDataInstances.dbo.Instance i on i.IdLpu = r.Organization
    --and Status = '5'
    --and rr.Message like "%Code: OBJECT_NOT_FOUND%"
join EMK.dbo.Step s     on m.IdStep=s.IdStep 
join EMK.dbo.[Case] c on c.IdCase=s.IdCase
join ExternalDataInstances.dbo.Instance ext on c.IdLpu=ext.IdLpu
where rr.DATE >= '2021-01-01' --between '2021-14-04' and '2021-16-04' and IdCaseMIS = 1834475
--order by Date desc
) bb

group by bb.Organization, bb.IdCaseMIS, bb.Name
