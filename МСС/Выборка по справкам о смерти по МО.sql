SELECT docsAll.MO, docsAll.COUNT_DOCS_ALL, docsFull.COUNT_DOCS_FULL, COUNT_DOCS_DAMAGED, COUNT_DOCS_WITHOUT_ECP FROM (
         (SELECT mo.nameFull AS MO,  COUNT(DOC_ID) AS COUNT_DOCS_ALL
          FROM SERT_DEATH s
          JOIN REESTR_MO_RF mo ON s.providerOrganizationId=mo.id
          WHERE DOC_ID NOT IN (19,20)
          GROUP BY mo.nameFull
          ) AS docsAll
          LEFT JOIN 
          (SELECT mo.nameFull AS MO,  COUNT(DOC_ID) AS COUNT_DOCS_FULL
           FROM SERT_DEATH s
           JOIN REESTR_MO_RF mo ON s.providerOrganizationId=mo.id
           WHERE DOC_ID NOT IN (19,20) AND statusId=3
           GROUP BY mo.nameFull
           ) AS docsFull ON docsAll.MO=docsFull.MO
          LEFT JOIN 
         (SELECT mo.nameFull AS MO,  COUNT(DOC_ID) AS COUNT_DOCS_DAMAGED
          FROM SERT_DEATH s
          JOIN REESTR_MO_RF mo ON s.providerOrganizationId=mo.id
          WHERE DOC_ID NOT IN (19,20) AND statusId=7
          GROUP BY mo.nameFull
          ) AS docsDamaged ON docsAll.MO=docsDamaged.MO
          LEFT JOIN 
          (SELECT mo.nameFull AS MO,  COUNT(DOC_ID) AS COUNT_DOCS_WITHOUT_ECP
          FROM SERT_DEATH s
            JOIN REESTR_MO_RF mo ON s.providerOrganizationId=mo.id
          WHERE DOC_ID NOT IN (19,20) AND (edsAuthor IS NULL OR edsLa IS NULL)
          GROUP BY mo.nameFull
          ) AS docsWithoutEcp ON docsFull.MO=docsWithoutEcp.MO
) 
