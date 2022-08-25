DECLARE @XML_TEXT XML;
DECLARE @idoc INT;

DECLARE @V009 TABLE (	
	id INT IDENTITY(93,1)  NOT NULL,
	[IDRMP] [int] NULL,
	[RMPNAME] [nvarchar](254) NULL,
	[DL_USLOV] [int] NULL,
	[DATEBEG] [datetime] NULL,
	[DATEEND] [datetime] NULL)		

SELECT @XML_TEXT = '<packet>
  <zglv>
    <type>Rezult</type>
    <version>3.1</version>
    <date>13.04.2018</date>
  </zglv>
  <zap>
    <IDRMP>101</IDRMP>
    <RMPNAME>Выписан</RMPNAME>
    <DL_USLOV>1</DL_USLOV>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>102</IDRMP>
    <RMPNAME>Переведён в др. ЛПУ</RMPNAME>
    <DL_USLOV>1</DL_USLOV>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>103</IDRMP>
    <RMPNAME>Переведён в дневной стационар</RMPNAME>
    <DL_USLOV>1</DL_USLOV>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>104</IDRMP>
    <RMPNAME>Переведён на другой профиль коек</RMPNAME>
    <DL_USLOV>1</DL_USLOV>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>105</IDRMP>
    <RMPNAME>Умер</RMPNAME>
    <DL_USLOV>1</DL_USLOV>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>106</IDRMP>
    <RMPNAME>Умер в приёмном покое</RMPNAME>
    <DL_USLOV>1</DL_USLOV>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>107</IDRMP>
    <RMPNAME>Лечение прервано по инициативе пациента</RMPNAME>
    <DL_USLOV>1</DL_USLOV>
    <DATEBEG>16.12.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>108</IDRMP>
    <RMPNAME>Лечение прервано по инициативе ЛПУ</RMPNAME>
    <DL_USLOV>1</DL_USLOV>
    <DATEBEG>16.12.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>109</IDRMP>
    <RMPNAME>Лечение продолжено</RMPNAME>
    <DL_USLOV>1</DL_USLOV>
    <DATEBEG>16.12.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>110</IDRMP>
    <RMPNAME>Самовольно прерванное лечение</RMPNAME>
    <DL_USLOV>1</DL_USLOV>
    <DATEBEG>23.01.2012</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>201</IDRMP>
    <RMPNAME>Выписан</RMPNAME>
    <DL_USLOV>2</DL_USLOV>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>202</IDRMP>
    <RMPNAME>Переведён в др. ЛПУ</RMPNAME>
    <DL_USLOV>2</DL_USLOV>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>203</IDRMP>
    <RMPNAME>Переведён в стационар</RMPNAME>
    <DL_USLOV>2</DL_USLOV>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>204</IDRMP>
    <RMPNAME>Переведён на другой профиль коек</RMPNAME>
    <DL_USLOV>2</DL_USLOV>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>205</IDRMP>
    <RMPNAME>Умер</RMPNAME>
    <DL_USLOV>2</DL_USLOV>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>206</IDRMP>
    <RMPNAME>Умер в приёмном покое</RMPNAME>
    <DL_USLOV>2</DL_USLOV>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>207</IDRMP>
    <RMPNAME>Лечение прервано по инициативе пациента</RMPNAME>
    <DL_USLOV>2</DL_USLOV>
    <DATEBEG>04.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>208</IDRMP>
    <RMPNAME>Лечение прервано по инициативе ЛПУ</RMPNAME>
    <DL_USLOV>2</DL_USLOV>
    <DATEBEG>04.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>301</IDRMP>
    <RMPNAME>Лечение завершено</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>302</IDRMP>
    <RMPNAME>Лечение прервано по инициативе пациента</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>303</IDRMP>
    <RMPNAME>Лечение прервано по инициативе ЛПУ</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>304</IDRMP>
    <RMPNAME>Лечение продолжено</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>305</IDRMP>
    <RMPNAME>Направлен на госпитализацию</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>306</IDRMP>
    <RMPNAME>Направлен в дневной стационар</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>307</IDRMP>
    <RMPNAME>Направлен в стационар на дому</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>308</IDRMP>
    <RMPNAME>Направлен на консультацию</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>309</IDRMP>
    <RMPNAME>Направлен на консультацию в другое ЛПУ</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>310</IDRMP>
    <RMPNAME>Направлен в реабилитационное отделение</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>311</IDRMP>
    <RMPNAME>Направлен на санаторно-курортное лечение</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>312</IDRMP>
    <RMPNAME>Проведена дополнительная диспансеризация</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND>31.12.2017</DATEEND>
  </zap>
  <zap>
    <IDRMP>313</IDRMP>
    <RMPNAME>Констатация факта смерти</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>314</IDRMP>
    <RMPNAME>Динамическое наблюдение</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>23.01.2012</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>315</IDRMP>
    <RMPNAME>Направлен на обследования</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>23.01.2012</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>316</IDRMP>
    <RMPNAME>Направлен на II этап диспансеризации определенных групп взрослого населения</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>25.04.2013</DATEBEG>
    <DATEEND>31.03.2018</DATEEND>
  </zap>
  <zap>
    <IDRMP>317</IDRMP>
    <RMPNAME>Проведена диспансеризация определенных групп взрослого населения - присвоена I группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>25.04.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>318</IDRMP>
    <RMPNAME>Проведена диспансеризация определенных групп взрослого населения - присвоена II группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>25.04.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>319</IDRMP>
    <RMPNAME>Проведена диспансеризация определенных групп взрослого населения - присвоена III группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>25.04.2013</DATEBEG>
    <DATEEND>31.03.2016</DATEEND>
  </zap>
  <zap>
    <IDRMP>320</IDRMP>
    <RMPNAME>Направлен на II этап диспансеризации пребывающих в стационарных учреждениях детей-сирот и детей, находящихся в трудной жизненной ситуации</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>25.04.2013</DATEBEG>
    <DATEEND>22.05.2013</DATEEND>
  </zap>
  <zap>
    <IDRMP>321</IDRMP>
    <RMPNAME>Проведена диспансеризация пребывающих в стационарных учреждениях детей-сирот и детей, находящихся в трудной жизненной ситуации - присвоена I группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>25.04.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>322</IDRMP>
    <RMPNAME>Проведена диспансеризация пребывающих в стационарных учреждениях детей-сирот и детей, находящихся в трудной жизненной ситуации - присвоена II группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>25.04.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>323</IDRMP>
    <RMPNAME>Проведена диспансеризация пребывающих в стационарных учреждениях детей-сирот и детей, находящихся в трудной жизненной ситуации - присвоена III группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>25.04.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>324</IDRMP>
    <RMPNAME>Проведена диспансеризация пребывающих в стационарных учреждениях детей-сирот и детей, находящихся в трудной жизненной ситуации - присвоена IV группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>25.04.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>325</IDRMP>
    <RMPNAME>Проведена диспансеризация пребывающих в стационарных учреждениях детей-сирот и детей, находящихся в трудной жизненной ситуации - присвоена V группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>25.04.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>326</IDRMP>
    <RMPNAME>Направлен на II этап медицинского осмотра</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>25.04.2013</DATEBEG>
    <DATEEND>22.05.2013</DATEEND>
  </zap>
  <zap>
    <IDRMP>327</IDRMP>
    <RMPNAME>Проведен медицинский осмотр несовершеннолетнему - присвоена I группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>25.04.2013</DATEBEG>
    <DATEEND>22.05.2013</DATEEND>
  </zap>
  <zap>
    <IDRMP>328</IDRMP>
    <RMPNAME>Проведен медицинский осмотр несовершеннолетнему - присвоена II группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>25.04.2013</DATEBEG>
    <DATEEND>22.05.2013</DATEEND>
  </zap>
  <zap>
    <IDRMP>329</IDRMP>
    <RMPNAME>Проведен медицинский осмотр несовершеннолетнему - присвоена III группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>25.04.2013</DATEBEG>
    <DATEEND>22.05.2013</DATEEND>
  </zap>
  <zap>
    <IDRMP>330</IDRMP>
    <RMPNAME>Проведен медицинский осмотр несовершеннолетнему - присвоена IV группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>25.04.2013</DATEBEG>
    <DATEEND>22.05.2013</DATEEND>
  </zap>
  <zap>
    <IDRMP>331</IDRMP>
    <RMPNAME>Проведен медицинский осмотр несовершеннолетнему - присвоена V группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>25.04.2013</DATEBEG>
    <DATEEND>22.05.2013</DATEEND>
  </zap>
  <zap>
    <IDRMP>332</IDRMP>
    <RMPNAME>Проведен профилактический медицинский осмотр несовершеннолетнему - присвоена I группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>22.05.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>333</IDRMP>
    <RMPNAME>Проведен профилактический медицинский осмотр несовершеннолетнему - присвоена II группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>22.05.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>334</IDRMP>
    <RMPNAME>Проведен профилактический медицинский осмотр несовершеннолетнему - присвоена III группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>22.05.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>335</IDRMP>
    <RMPNAME>Проведен профилактический медицинский осмотр несовершеннолетнему - присвоена IV группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>22.05.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>336</IDRMP>
    <RMPNAME>Проведен профилактический медицинский осмотр несовершеннолетнему - присвоена V группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>22.05.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>337</IDRMP>
    <RMPNAME>Проведен предварительный медицинский осмотр несовершеннолетнему - присвоена I группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>22.05.2013</DATEBEG>
    <DATEEND>31.12.2017</DATEEND>
  </zap>
  <zap>
    <IDRMP>338</IDRMP>
    <RMPNAME>Проведен предварительный медицинский осмотр несовершеннолетнему - присвоена II группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>22.05.2013</DATEBEG>
    <DATEEND>31.12.2017</DATEEND>
  </zap>
  <zap>
    <IDRMP>339</IDRMP>
    <RMPNAME>Проведен предварительный медицинский осмотр несовершеннолетнему - присвоена III группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>22.05.2013</DATEBEG>
    <DATEEND>31.12.2017</DATEEND>
  </zap>
  <zap>
    <IDRMP>340</IDRMP>
    <RMPNAME>Проведен предварительный медицинский осмотр несовершеннолетнему - присвоена IV группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>22.05.2013</DATEBEG>
    <DATEEND>31.12.2017</DATEEND>
  </zap>
  <zap>
    <IDRMP>341</IDRMP>
    <RMPNAME>Проведен предварительный медицинский осмотр несовершеннолетнему - присвоена V группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>22.05.2013</DATEBEG>
    <DATEEND>31.12.2017</DATEEND>
  </zap>
  <zap>
    <IDRMP>342</IDRMP>
    <RMPNAME>Проведен периодический медицинский осмотр несовершеннолетнему</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>22.05.2013</DATEBEG>
    <DATEEND>31.12.2017</DATEEND>
  </zap>
  <zap>
    <IDRMP>343</IDRMP>
    <RMPNAME>Проведен профилактический медицинский осмотр взрослого населения - присвоена I группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>22.05.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>344</IDRMP>
    <RMPNAME>Проведен профилактический медицинский осмотр взрослого населения - присвоена II группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>22.05.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>345</IDRMP>
    <RMPNAME>Проведен профилактический медицинский осмотр взрослого населения - присвоена III группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>22.05.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>346</IDRMP>
    <RMPNAME>Проходит II этап диспансеризации определенных групп взрослого населения</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>22.05.2013</DATEBEG>
    <DATEEND>06.03.2014</DATEEND>
  </zap>
  <zap>
    <IDRMP>347</IDRMP>
    <RMPNAME>Проведена диспансеризация детей-сирот и детей, оставшихся без попечения родителей, в том числе усыновленных (удочеренных), принятых под опеку, в приемную или патронатную семью - присвоена I группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>09.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>348</IDRMP>
    <RMPNAME>Проведена диспансеризация детей-сирот и детей, оставшихся без попечения родителей, в том числе усыновленных (удочеренных), принятых под опеку, в приемную или патронатную семью - присвоена II группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>09.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>349</IDRMP>
    <RMPNAME>Проведена диспансеризация детей-сирот и детей, оставшихся без попечения родителей, в том числе усыновленных (удочеренных), принятых под опеку, в приемную или патронатную семью - присвоена III группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>09.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>350</IDRMP>
    <RMPNAME>Проведена диспансеризация детей-сирот и детей, оставшихся без попечения родителей, в том числе усыновленных (удочеренных), принятых под опеку, в приемную или патронатную семью - присвоена IV группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>09.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>351</IDRMP>
    <RMPNAME>Проведена диспансеризация детей-сирот и детей, оставшихся без попечения родителей, в том числе усыновленных (удочеренных), принятых под опеку, в приемную или патронатную семью - присвоена V группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>09.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>352</IDRMP>
    <RMPNAME>Направлен на II этап диспансеризации определенных групп взрослого населения, предварительно присвоена I группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>06.03.2014</DATEBEG>
    <DATEEND>31.03.2018</DATEEND>
  </zap>
  <zap>
    <IDRMP>353</IDRMP>
    <RMPNAME>Направлен на II этап диспансеризации определенных групп взрослого населения, предварительно присвоена II группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>06.03.2014</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>354</IDRMP>
    <RMPNAME>Направлен на II этап диспансеризации определенных групп взрослого населения, предварительно присвоена III группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>06.03.2014</DATEBEG>
    <DATEEND>31.03.2016</DATEEND>
  </zap>
  <zap>
    <IDRMP>355</IDRMP>
    <RMPNAME>Проведена диспансеризация определенных групп взрослого населения – присвоена IIIа группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>01.04.2015</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>356</IDRMP>
    <RMPNAME>Проведена диспансеризация определенных групп взрослого населения – присвоена IIIб группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>01.04.2015</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>357</IDRMP>
    <RMPNAME>Направлен на II этап диспансеризации определенных групп взрослого населения, предварительно присвоена IIIа группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>01.04.2015</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>358</IDRMP>
    <RMPNAME>Направлен на II этап диспансеризации определенных групп взрослого населения, предварительно присвоена IIIб группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>01.04.2015</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>359</IDRMP>
    <RMPNAME>Проведен I этап диспансеризации определенных групп взрослого населения с периодичностью 1 раз в 2 года</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>361</IDRMP>
    <RMPNAME>Направлен на II этап  профилактического медицинского осмотра несовершеннолетних, предварительно присвоена II группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>01.04.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>362</IDRMP>
    <RMPNAME>Направлен на II этап  профилактического медицинского осмотра несовершеннолетних, предварительно присвоена III группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>01.04.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>363</IDRMP>
    <RMPNAME>Направлен на II этап профилактического медицинского осмотра несовершеннолетних, предварительно присвоена IV группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>01.04.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>364</IDRMP>
    <RMPNAME>Направлен на II этап профилактического медицинского осмотра несовершеннолетних, предварительно присвоена V группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>01.04.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>365</IDRMP>
    <RMPNAME>Направлен на II этап диспансеризации пребывающих в стационарных учреждениях детей-сирот и детей, находящихся в трудной жизненной ситуации, предварительно присвоена II группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>01.04.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>366</IDRMP>
    <RMPNAME>Направлен на II этап диспансеризации пребывающих в стационарных учреждениях детей-сирот и детей, находящихся в трудной жизненной ситуации, предварительно присвоена III группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>01.04.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>367</IDRMP>
    <RMPNAME>Направлен на II этап диспансеризации пребывающих в стационарных учреждениях детей-сирот и детей, находящихся в трудной жизненной ситуации, предварительно присвоена IV группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>01.04.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>368</IDRMP>
    <RMPNAME>Направлен на II этап диспансеризации пребывающих в стационарных учреждениях детей-сирот и детей, находящихся в трудной жизненной ситуации, предварительно присвоена V группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>01.04.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>369</IDRMP>
    <RMPNAME>Направлен на II этап диспансеризации детей-сирот и детей, оставшихся без попечения родителей, в том числе усыновленных (удочеренных), принятых под опеку, в приемную или патронатную семью, предварительно присвоена II группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>01.04.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>370</IDRMP>
    <RMPNAME>Направлен на II этап диспансеризации детей-сирот и детей, оставшихся без попечения родителей, в том числе усыновленных (удочеренных), принятых под опеку, в приемную или патронатную семью, предварительно присвоена III группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>01.04.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>371</IDRMP>
    <RMPNAME>Направлен на II этап диспансеризации детей-сирот и детей, оставшихся без попечения родителей, в том числе усыновленных (удочеренных), принятых под опеку, в приемную или патронатную семью, предварительно присвоена IV группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>01.04.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>372</IDRMP>
    <RMPNAME>Направлен на II этап диспансеризации детей-сирот и детей, оставшихся без попечения родителей, в том числе усыновленных (удочеренных), принятых под опеку, в приемную или патронатную семью, предварительно присвоена V группа здоровья</RMPNAME>
    <DL_USLOV>3</DL_USLOV>
    <DATEBEG>01.04.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>401</IDRMP>
    <RMPNAME>Оказана помощь, больной оставлен на месте</RMPNAME>
    <DL_USLOV>4</DL_USLOV>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>402</IDRMP>
    <RMPNAME>Доставлен в травмпункт</RMPNAME>
    <DL_USLOV>4</DL_USLOV>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>403</IDRMP>
    <RMPNAME>Доставлен в больницу</RMPNAME>
    <DL_USLOV>4</DL_USLOV>
    <DATEBEG>06.03.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>404</IDRMP>
    <RMPNAME>Передан специализированной бригаде СМП</RMPNAME>
    <DL_USLOV>4</DL_USLOV>
    <DATEBEG>06.03.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>405</IDRMP>
    <RMPNAME>Смерть в присутствии бригады СМП</RMPNAME>
    <DL_USLOV>4</DL_USLOV>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>406</IDRMP>
    <RMPNAME>Смерть в автомобиле СМП</RMPNAME>
    <DL_USLOV>4</DL_USLOV>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>407</IDRMP>
    <RMPNAME>Больной не найден на месте</RMPNAME>
    <DL_USLOV>4</DL_USLOV>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>408</IDRMP>
    <RMPNAME>Отказ от помощи</RMPNAME>
    <DL_USLOV>4</DL_USLOV>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>409</IDRMP>
    <RMPNAME>Адрес не найден</RMPNAME>
    <DL_USLOV>4</DL_USLOV>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>410</IDRMP>
    <RMPNAME>Ложный вызов</RMPNAME>
    <DL_USLOV>4</DL_USLOV>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>411</IDRMP>
    <RMPNAME>Смерть до приезда бригады СМП</RMPNAME>
    <DL_USLOV>4</DL_USLOV>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>412</IDRMP>
    <RMPNAME>Больной увезён до прибытия СМП</RMPNAME>
    <DL_USLOV>4</DL_USLOV>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>413</IDRMP>
    <RMPNAME>Больной обслужен врачом поликлиники до приб. СМП</RMPNAME>
    <DL_USLOV>4</DL_USLOV>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>414</IDRMP>
    <RMPNAME>Вызов отменён</RMPNAME>
    <DL_USLOV>4</DL_USLOV>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>415</IDRMP>
    <RMPNAME>Пациент практически здоров</RMPNAME>
    <DL_USLOV>4</DL_USLOV>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>416</IDRMP>
    <RMPNAME>Дежурство</RMPNAME>
    <DL_USLOV>4</DL_USLOV>
    <DATEBEG>01.01.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDRMP>417</IDRMP>
    <RMPNAME>Отказ от транспортировки для госпитализации в стационар</RMPNAME>
    <DL_USLOV>4</DL_USLOV>
    <DATEBEG>01.01.2013</DATEBEG>
    <DATEEND/>
  </zap>
</packet>'

--SELECT @XML_TEXT = t.BulkColumn
--FROM    (SELECT *    
--    FROM OPENROWSET (BULK 'D:\V009.xml', SINGLE_CLOB) 
-- AS xCol) AS t
--SET @XML_TEXT = REPLACE(@XML_TEXT, '<?xml version="1.0" encoding="windows-1251"?>', '')

--SELECT @XML_TEXT = [XMLCODE] FROM [SprUpdate] WHERE NAME_SPR = 'V012'

EXEC sp_xml_preparedocument @idoc OUTPUT, @XML_TEXT;
INSERT INTO @V009 ([IDRMP],[RMPNAME],[DL_USLOV],[DATEBEG],[DATEEND])
SELECT             [IDRMP],[RMPNAME],[DL_USLOV],[DATEBEG],[DATEEND]
FROM OPENXML (@idoc, N'/packet/zap', 2)
WITH ([IDRMP] INT,
	[RMPNAME] [nvarchar](254),
	[DL_USLOV] INT,
	DATEBEG NVARCHAR(10),
	DATEEND NVARCHAR(10))  

UPDATE @V009 SET DATEEND = NULL WHERE DATEEND = '19000101' 
SELECT * FROM @V009

UPDATE t
SET [IDRMP] = t1.[IDRMP]      
,[RMPNAME] = t.[RMPNAME]
      ,[DATEBEG] = t1.[DATEBEG]
      ,[DATEEND] = t1.[DATEEND]
      ,[DL_USLOV] = t1.[DL_USLOV]      
FROM V009 AS t
JOIN @V009 AS t1 ON t.[IDRMP] = t1.[IDRMP]

INSERT INTO V009
       (id, [IDRMP],[RMPNAME],[DL_USLOV],[DATEBEG],[DATEEND])
SELECT  id, [IDRMP],[RMPNAME],[DL_USLOV],[DATEBEG],[DATEEND]
FROM @V009
WHERE [IDRMP] NOT IN (
        SELECT t1.[IDRMP]  
        FROM V009 AS t
JOIN @V009 AS t1 ON t.[IDRMP] = t1.[IDRMP])