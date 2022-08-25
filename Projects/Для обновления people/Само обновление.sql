 --208

--IF (SELECT OBJECT_ID(N'[dbo].[people_temp]')) is not null
--DROP TABLE [dbo].[people_temp]
 
-- select id
-- into people_temp
-- from [SQL_NACH].[srz_mini].[dbo].[PEOPLE] as p1
--           where not exists (select id
--						       from people p
--							   where p1.id = p.pid) 

INSERT INTO [people]
           ([FAM]
      ,[IM]
      ,[OT]
      ,[W]
      ,[DR]
      ,[DS]
      ,[RN]
      ,[INDX]
      ,[RNNAME]
      ,[CITY]
      ,[NP]
      ,[UL]
      ,[DOM]
      ,[KOR]
      ,[KV]
      ,[Q]
      ,[SPOL]
      ,[NPOL]
      ,[ENP]
      ,[OPDOC]
      ,[DBEG]
      ,[DEND]
      ,[PID]
      ,[DSTOP]
      ,[DEDIT])
    select [FAM]
      ,[IM]
      ,[OT]
      ,[W]
      ,[DR]
      ,[DS]
      ,[RN]
      ,[INDX]
      ,[RNNAME]
      ,[CITY]
      ,[NP]
      ,[UL]
      ,[DOM]
      ,[KOR]
      ,[KV]
      ,[Q]
      ,[SPOL]
      ,[NPOL]
      ,[ENP]
      ,[OPDOC]
      ,[DBEG]
      ,[DEND]
      ,[ID]
      ,[DSTOP]
      ,[DEDIT]
           from [SQL_NACH].[srz_mini].[dbo].[PEOPLE] as p1
           where p1.id in (select id from people_temp)