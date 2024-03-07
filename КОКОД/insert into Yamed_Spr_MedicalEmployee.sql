--select * from  Yamed_Spr_UslCode
--where id like 'r%'




insert into Yamed_Spr_MedicalEmployee (id, fam, im, ot, snils)

select 
id, fam, im, ot,
substring(snils,1,3) + '-' + substring(snils,4,3) + '-' + substring(snils,7,3) + ' ' +  substring(snils,10,2) snils
 
 from person_all

--where snils is not null



select * from Yamed_Spr_MedicalEmployee