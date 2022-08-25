BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
EXEC [dbo].[versionСheck] 533

DROP TABLE [dbo].[V023]

CREATE TABLE [dbo].[V023](
	[IDUMP] [numeric](1, 0) NULL,
	[K_KSG] [nvarchar](20) NOT NULL,
	[N_KSG] [nvarchar](254) NULL,
	[KOEF_Z] [numeric](4, 2) NULL,
	[DATEBEG] [date] NULL,
	[DATEEND] [date] NULL
) ON [PRIMARY]

DECLARE @XML_TEXT XML;
DECLARE @idoc INT;

DECLARE @V023 TABLE (	
	[IDUMP] [numeric](1, 0) NULL,
	[K_KSG] [nvarchar](20) NOT NULL,
	[N_KSG] [nvarchar](254) NULL,
	[KOEF_Z] [numeric](4, 2) NULL,
	[DATEBEG] [date] NULL,
	[DATEEND] [date] NULL)		
	
SELECT @XML_TEXT = '<packet>
  <zglv>
    <type>KSG</type>
    <version>1.2</version>
    <date>26.12.2018</date>
  </zglv>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>1</K_KSG>
    <N_KSG>Беременность без патологии, дородовая госпитализация в отделение сестринского ухода</N_KSG>
    <KOEF_Z>0.50</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>2</K_KSG>
    <N_KSG>Осложнения, связанные с беременностью</N_KSG>
    <KOEF_Z>0.93</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>3</K_KSG>
    <N_KSG>Беременность, закончившаяся абортивным исходом</N_KSG>
    <KOEF_Z>0.28</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>4</K_KSG>
    <N_KSG>Родоразрешение</N_KSG>
    <KOEF_Z>0.98</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>5</K_KSG>
    <N_KSG>Кесарево сечение</N_KSG>
    <KOEF_Z>1.01</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>6</K_KSG>
    <N_KSG>Осложнения послеродового периода</N_KSG>
    <KOEF_Z>0.74</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>7</K_KSG>
    <N_KSG>Послеродовой сепсис</N_KSG>
    <KOEF_Z>3.21</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>8</K_KSG>
    <N_KSG>Воспалительные болезни женских половых органов</N_KSG>
    <KOEF_Z>0.71</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>9</K_KSG>
    <N_KSG>Доброкачественные новообразования, новообразования in situ, неопределенного и неизвестного характера женских половых органов</N_KSG>
    <KOEF_Z>0.89</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>10</K_KSG>
    <N_KSG>Другие болезни, врожденные аномалии, повреждения женских половых органов</N_KSG>
    <KOEF_Z>0.46</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>11</K_KSG>
    <N_KSG>Операции на женских половых органах (уровень 1)</N_KSG>
    <KOEF_Z>0.39</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>12</K_KSG>
    <N_KSG>Операции на женских половых органах (уровень 2)</N_KSG>
    <KOEF_Z>0.58</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>13</K_KSG>
    <N_KSG>Операции на женских половых органах (уровень 3)</N_KSG>
    <KOEF_Z>1.17</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>14</K_KSG>
    <N_KSG>Операции на женских половых органах (уровень 4)</N_KSG>
    <KOEF_Z>2.20</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>15</K_KSG>
    <N_KSG>Нарушения с вовлечением иммунного механизма</N_KSG>
    <KOEF_Z>1.15</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>16</K_KSG>
    <N_KSG>Ангионевротический отек, анафилактический шок</N_KSG>
    <KOEF_Z>0.27</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>17</K_KSG>
    <N_KSG>Язва желудка и двенадцатиперстной кишки</N_KSG>
    <KOEF_Z>0.89</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>18</K_KSG>
    <N_KSG>Воспалительные заболевания кишечника</N_KSG>
    <KOEF_Z>2.01</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>19</K_KSG>
    <N_KSG>Болезни печени, невирусные (уровень 1)</N_KSG>
    <KOEF_Z>0.86</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>20</K_KSG>
    <N_KSG>Болезни печени, невирусные (уровень 2)</N_KSG>
    <KOEF_Z>1.21</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>21</K_KSG>
    <N_KSG>Болезни поджелудочной железы</N_KSG>
    <KOEF_Z>0.93</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>22</K_KSG>
    <N_KSG>Анемии (уровень 1)</N_KSG>
    <KOEF_Z>1.12</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>23</K_KSG>
    <N_KSG>Анемии (уровень 2)</N_KSG>
    <KOEF_Z>1.49</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>24</K_KSG>
    <N_KSG>Анемии (уровень 3)</N_KSG>
    <KOEF_Z>5.32</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>25</K_KSG>
    <N_KSG>Нарушения свертываемости крови</N_KSG>
    <KOEF_Z>1.04</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>26</K_KSG>
    <N_KSG>Другие болезни крови и кроветворных органов</N_KSG>
    <KOEF_Z>1.09</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>27</K_KSG>
    <N_KSG>Редкие и тяжелые дерматозы</N_KSG>
    <KOEF_Z>1.72</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>28</K_KSG>
    <N_KSG>Среднетяжелые дерматозы</N_KSG>
    <KOEF_Z>0.74</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>29</K_KSG>
    <N_KSG>Легкие дерматозы</N_KSG>
    <KOEF_Z>0.36</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>30</K_KSG>
    <N_KSG>Врожденные аномалии сердечно-сосудистой системы, дети</N_KSG>
    <KOEF_Z>1.84</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>31</K_KSG>
    <N_KSG>Лекарственная терапия при остром лейкозе, дети</N_KSG>
    <KOEF_Z>7.82</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>32</K_KSG>
    <N_KSG>Лекарственная терапия при других злокачественных новообразованиях лимфоидной и кроветворной тканей, дети</N_KSG>
    <KOEF_Z>5.68</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>33</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях других локализаций (кроме лимфоидной и кроветворной тканей), дети</N_KSG>
    <KOEF_Z>4.37</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>34</K_KSG>
    <N_KSG>Операции на мужских половых органах, дети (уровень 1)</N_KSG>
    <KOEF_Z>0.97</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>35</K_KSG>
    <N_KSG>Операции на мужских половых органах, дети (уровень 2)</N_KSG>
    <KOEF_Z>1.11</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>36</K_KSG>
    <N_KSG>Операции на мужских половых органах, дети (уровень 3)</N_KSG>
    <KOEF_Z>1.97</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>37</K_KSG>
    <N_KSG>Операции на мужских половых органах, дети (уровень 4)</N_KSG>
    <KOEF_Z>2.78</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>38</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, дети (уровень 1)</N_KSG>
    <KOEF_Z>1.15</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>39</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, дети (уровень 2)</N_KSG>
    <KOEF_Z>1.22</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>40</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, дети (уровень 3)</N_KSG>
    <KOEF_Z>1.78</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>41</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, дети (уровень 4)</N_KSG>
    <KOEF_Z>2.23</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>42</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, дети (уровень 5)</N_KSG>
    <KOEF_Z>2.36</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>43</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, дети (уровень 6)</N_KSG>
    <KOEF_Z>4.28</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>44</K_KSG>
    <N_KSG>Детская хирургия (уровень 1)</N_KSG>
    <KOEF_Z>2.95</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>45</K_KSG>
    <N_KSG>Детская хирургия (уровень 2)</N_KSG>
    <KOEF_Z>5.33</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>46</K_KSG>
    <N_KSG>Аппендэктомия, дети (уровень 1)</N_KSG>
    <KOEF_Z>0.77</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>47</K_KSG>
    <N_KSG>Аппендэктомия, дети (уровень 2)</N_KSG>
    <KOEF_Z>0.97</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>48</K_KSG>
    <N_KSG>Операции по поводу грыж, дети (уровень 1)</N_KSG>
    <KOEF_Z>0.88</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>49</K_KSG>
    <N_KSG>Операции по поводу грыж, дети (уровень 2)</N_KSG>
    <KOEF_Z>1.05</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>50</K_KSG>
    <N_KSG>Операции по поводу грыж, дети (уровень 3)</N_KSG>
    <KOEF_Z>1.25</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>51</K_KSG>
    <N_KSG>Сахарный диабет, дети</N_KSG>
    <KOEF_Z>1.51</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>52</K_KSG>
    <N_KSG>Заболевания гипофиза, дети</N_KSG>
    <KOEF_Z>2.26</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>53</K_KSG>
    <N_KSG>Другие болезни эндокринной системы, дети (уровень 1)</N_KSG>
    <KOEF_Z>1.38</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>54</K_KSG>
    <N_KSG>Другие болезни эндокринной системы, дети (уровень 2)</N_KSG>
    <KOEF_Z>2.82</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>55</K_KSG>
    <N_KSG>Кишечные инфекции, взрослые</N_KSG>
    <KOEF_Z>0.58</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>56</K_KSG>
    <N_KSG>Кишечные инфекции, дети</N_KSG>
    <KOEF_Z>0.62</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>57</K_KSG>
    <N_KSG>Вирусный гепатит острый</N_KSG>
    <KOEF_Z>1.40</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>58</K_KSG>
    <N_KSG>Вирусный гепатит хронический</N_KSG>
    <KOEF_Z>1.27</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>59</K_KSG>
    <N_KSG>Сепсис, взрослые</N_KSG>
    <KOEF_Z>3.12</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>60</K_KSG>
    <N_KSG>Сепсис, дети</N_KSG>
    <KOEF_Z>4.51</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>61</K_KSG>
    <N_KSG>Другие инфекционные и паразитарные болезни, взрослые</N_KSG>
    <KOEF_Z>1.18</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>62</K_KSG>
    <N_KSG>Другие инфекционные и паразитарные болезни, дети</N_KSG>
    <KOEF_Z>0.98</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>63</K_KSG>
    <N_KSG>Респираторные инфекции верхних дыхательных путей с осложнениями, взрослые</N_KSG>
    <KOEF_Z>0.35</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>64</K_KSG>
    <N_KSG>Респираторные инфекции верхних дыхательных путей, дети</N_KSG>
    <KOEF_Z>0.50</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>65</K_KSG>
    <N_KSG>Грипп, вирус гриппа идентифицирован</N_KSG>
    <KOEF_Z>1.01</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>66</K_KSG>
    <N_KSG>Клещевой энцефалит</N_KSG>
    <KOEF_Z>2.30</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>67</K_KSG>
    <N_KSG>Нестабильная стенокардия, инфаркт миокарда, легочная эмболия (уровень 1)</N_KSG>
    <KOEF_Z>1.42</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>68</K_KSG>
    <N_KSG>Нестабильная стенокардия, инфаркт миокарда, легочная эмболия (уровень 2)</N_KSG>
    <KOEF_Z>2.81</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>69</K_KSG>
    <N_KSG>Инфаркт миокарда, легочная эмболия, лечение с применением тромболитической терапии</N_KSG>
    <KOEF_Z>3.48</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>70</K_KSG>
    <N_KSG>Нарушения ритма и проводимости (уровень 1)</N_KSG>
    <KOEF_Z>1.12</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>71</K_KSG>
    <N_KSG>Нарушения ритма и проводимости (уровень 2)</N_KSG>
    <KOEF_Z>2.01</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>72</K_KSG>
    <N_KSG>Эндокардит, миокардит, перикардит, кардиомиопатии (уровень 1)</N_KSG>
    <KOEF_Z>1.42</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>73</K_KSG>
    <N_KSG>Эндокардит, миокардит, перикардит, кардиомиопатии (уровень 2)</N_KSG>
    <KOEF_Z>2.38</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>74</K_KSG>
    <N_KSG>Операции на кишечнике и анальной области (уровень 1)</N_KSG>
    <KOEF_Z>0.84</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>75</K_KSG>
    <N_KSG>Операции на кишечнике и анальной области (уровень 2)</N_KSG>
    <KOEF_Z>1.74</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>76</K_KSG>
    <N_KSG>Операции на кишечнике и анальной области (уровень 3)</N_KSG>
    <KOEF_Z>2.49</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>77</K_KSG>
    <N_KSG>Воспалительные заболевания ЦНС, взрослые</N_KSG>
    <KOEF_Z>0.98</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>78</K_KSG>
    <N_KSG>Воспалительные заболевания ЦНС, дети</N_KSG>
    <KOEF_Z>1.55</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>79</K_KSG>
    <N_KSG>Дегенеративные болезни нервной системы</N_KSG>
    <KOEF_Z>0.84</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>80</K_KSG>
    <N_KSG>Демиелинизирующие болезни нервной системы</N_KSG>
    <KOEF_Z>1.33</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>81</K_KSG>
    <N_KSG>Эпилепсия, судороги (уровень 1)</N_KSG>
    <KOEF_Z>0.96</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>82</K_KSG>
    <N_KSG>Эпилепсия, судороги (уровень 2)</N_KSG>
    <KOEF_Z>2.01</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>83</K_KSG>
    <N_KSG>Расстройства периферической нервной системы</N_KSG>
    <KOEF_Z>1.02</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>84</K_KSG>
    <N_KSG>Неврологические заболевания, лечение с применением ботулотоксина</N_KSG>
    <KOEF_Z>1.95</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>85</K_KSG>
    <N_KSG>Другие нарушения нервной системы (уровень 1)</N_KSG>
    <KOEF_Z>0.74</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>86</K_KSG>
    <N_KSG>Другие нарушения нервной системы (уровень 2)</N_KSG>
    <KOEF_Z>0.99</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>87</K_KSG>
    <N_KSG>Транзиторные ишемические приступы, сосудистые мозговые синдромы</N_KSG>
    <KOEF_Z>1.15</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>88</K_KSG>
    <N_KSG>Кровоизлияние в мозг</N_KSG>
    <KOEF_Z>2.82</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>89</K_KSG>
    <N_KSG>Инфаркт мозга (уровень 1)</N_KSG>
    <KOEF_Z>2.52</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>90</K_KSG>
    <N_KSG>Инфаркт мозга (уровень 2)</N_KSG>
    <KOEF_Z>3.12</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>91</K_KSG>
    <N_KSG>Инфаркт мозга (уровень 3)</N_KSG>
    <KOEF_Z>4.51</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>92</K_KSG>
    <N_KSG>Другие цереброваскулярные болезни</N_KSG>
    <KOEF_Z>0.82</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>93</K_KSG>
    <N_KSG>Паралитические синдромы, травма спинного мозга (уровень 1)</N_KSG>
    <KOEF_Z>0.98</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>94</K_KSG>
    <N_KSG>Паралитические синдромы, травма спинного мозга (уровень 2)</N_KSG>
    <KOEF_Z>1.49</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>95</K_KSG>
    <N_KSG>Дорсопатии, спондилопатии, остеопатии</N_KSG>
    <KOEF_Z>0.68</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>96</K_KSG>
    <N_KSG>Травмы позвоночника</N_KSG>
    <KOEF_Z>1.01</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>97</K_KSG>
    <N_KSG>Сотрясение головного мозга</N_KSG>
    <KOEF_Z>0.40</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>98</K_KSG>
    <N_KSG>Переломы черепа, внутричерепная травма</N_KSG>
    <KOEF_Z>1.54</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>99</K_KSG>
    <N_KSG>Операции на центральной нервной системе и головном мозге (уровень 1)</N_KSG>
    <KOEF_Z>4.13</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>100</K_KSG>
    <N_KSG>Операции на центральной нервной системе и головном мозге (уровень 2)</N_KSG>
    <KOEF_Z>5.82</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>101</K_KSG>
    <N_KSG>Операции на периферической нервной системе (уровень 1)</N_KSG>
    <KOEF_Z>1.41</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>102</K_KSG>
    <N_KSG>Операции на периферической нервной системе (уровень 2)</N_KSG>
    <KOEF_Z>2.19</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>103</K_KSG>
    <N_KSG>Операции на периферической нервной системе (уровень 3)</N_KSG>
    <KOEF_Z>2.42</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>104</K_KSG>
    <N_KSG>Доброкачественные новообразования нервной системы</N_KSG>
    <KOEF_Z>1.02</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>105</K_KSG>
    <N_KSG>Малая масса тела при рождении, недоношенность</N_KSG>
    <KOEF_Z>4.21</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>106</K_KSG>
    <N_KSG>Крайне малая масса тела при рождении, крайняя незрелость</N_KSG>
    <KOEF_Z>16.02</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>107</K_KSG>
    <N_KSG>Лечение новорожденных с тяжелой патологией с применением аппаратных методов поддержки или замещения витальных функций</N_KSG>
    <KOEF_Z>7.40</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>108</K_KSG>
    <N_KSG>Геморрагические и гемолитические нарушения у новорожденных</N_KSG>
    <KOEF_Z>1.92</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>109</K_KSG>
    <N_KSG>Другие нарушения, возникшие в перинатальном периоде (уровень 1)</N_KSG>
    <KOEF_Z>1.39</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>110</K_KSG>
    <N_KSG>Другие нарушения, возникшие в перинатальном периоде (уровень 2)</N_KSG>
    <KOEF_Z>1.89</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>111</K_KSG>
    <N_KSG>Другие нарушения, возникшие в перинатальном периоде (уровень 3)</N_KSG>
    <KOEF_Z>2.56</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>112</K_KSG>
    <N_KSG>Почечная недостаточность</N_KSG>
    <KOEF_Z>1.66</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>113</K_KSG>
    <N_KSG>Формирование, имплантация, реконструкция, удаление, смена доступа для диализа</N_KSG>
    <KOEF_Z>1.82</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>114</K_KSG>
    <N_KSG>Гломерулярные болезни</N_KSG>
    <KOEF_Z>1.71</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>115</K_KSG>
    <N_KSG>Операции на женских половых органах при злокачественных новообразованиях (уровень 1)</N_KSG>
    <KOEF_Z>1.98</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>116</K_KSG>
    <N_KSG>Операции на женских половых органах при злокачественных новообразованиях (уровень 2)</N_KSG>
    <KOEF_Z>3.66</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>117</K_KSG>
    <N_KSG>Операции на женских половых органах при злокачественных новообразованиях (уровень 3)</N_KSG>
    <KOEF_Z>4.05</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>118</K_KSG>
    <N_KSG>Операции на кишечнике и анальной области при злокачественных новообразованиях (уровень 1)</N_KSG>
    <KOEF_Z>2.45</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>119</K_KSG>
    <N_KSG>Операции на кишечнике и анальной области при злокачественных новообразованиях (уровень 2)</N_KSG>
    <KOEF_Z>4.24</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>120</K_KSG>
    <N_KSG>Операции при злокачественных новообразованиях почки и мочевыделительной системы (уровень 1)</N_KSG>
    <KOEF_Z>1.40</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>121</K_KSG>
    <N_KSG>Операции при злокачественных новообразованиях почки и мочевыделительной системы (уровень 2)</N_KSG>
    <KOEF_Z>2.46</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>122</K_KSG>
    <N_KSG>Операции при злокачественных новообразованиях почки и мочевыделительной системы (уровень 3)</N_KSG>
    <KOEF_Z>3.24</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>123</K_KSG>
    <N_KSG>Операции при злокачественных новообразованиях кожи (уровень 1)</N_KSG>
    <KOEF_Z>1.09</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>124</K_KSG>
    <N_KSG>Операции при злокачественных новообразованиях кожи (уровень 2)</N_KSG>
    <KOEF_Z>1.36</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>125</K_KSG>
    <N_KSG>Операции при злокачественных новообразованиях кожи (уровень 3)</N_KSG>
    <KOEF_Z>1.41</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>126</K_KSG>
    <N_KSG>Операции при злокачественном новообразовании щитовидной железы (уровень 1)</N_KSG>
    <KOEF_Z>1.88</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>127</K_KSG>
    <N_KSG>Операции при злокачественном новообразовании щитовидной железы (уровень 2)</N_KSG>
    <KOEF_Z>1.92</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>128</K_KSG>
    <N_KSG>Мастэктомия, другие операции при злокачественном новообразовании молочной железы (уровень 1)</N_KSG>
    <KOEF_Z>2.29</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>129</K_KSG>
    <N_KSG>Мастэктомия, другие операции при злокачественном новообразовании молочной железы (уровень 2)</N_KSG>
    <KOEF_Z>3.12</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>130</K_KSG>
    <N_KSG>Операции при злокачественном новообразовании желчного пузыря, желчных протоков (уровень 1)</N_KSG>
    <KOEF_Z>1.96</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>131</K_KSG>
    <N_KSG>Операции при злокачественном новообразовании желчного пузыря, желчных протоков (уровень 2)</N_KSG>
    <KOEF_Z>2.17</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>132</K_KSG>
    <N_KSG>Операции при злокачественном новообразовании пищевода, желудка (уровень 1)</N_KSG>
    <KOEF_Z>2.02</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>133</K_KSG>
    <N_KSG>Операции при злокачественном новообразовании пищевода, желудка (уровень 2)</N_KSG>
    <KOEF_Z>2.57</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>134</K_KSG>
    <N_KSG>Операции при злокачественном новообразовании пищевода, желудка (уровень 3)</N_KSG>
    <KOEF_Z>3.14</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>135</K_KSG>
    <N_KSG>Другие операции при злокачественном новообразовании брюшной полости</N_KSG>
    <KOEF_Z>2.48</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>136</K_KSG>
    <N_KSG>Злокачественное новообразование без специального противоопухолевого лечения</N_KSG>
    <KOEF_Z>0.50</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>137</K_KSG>
    <N_KSG>Операции на органе слуха, придаточных пазухах носа и верхних дыхательных путях при злокачественных новообразованиях</N_KSG>
    <KOEF_Z>1.91</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>138</K_KSG>
    <N_KSG>Операции на нижних дыхательных путях и легочной ткани при злокачественных новообразованиях (уровень 1)</N_KSG>
    <KOEF_Z>2.88</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>139</K_KSG>
    <N_KSG>Операции на нижних дыхательных путях и легочной ткани при злокачественных новообразованиях (уровень 2)</N_KSG>
    <KOEF_Z>4.25</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>140</K_KSG>
    <N_KSG>Операции при злокачественных новообразованиях мужских половых органов (уровень 1)</N_KSG>
    <KOEF_Z>2.56</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>141</K_KSG>
    <N_KSG>Операции при злокачественных новообразованиях мужских половых органов (уровень 2)</N_KSG>
    <KOEF_Z>3.60</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>142</K_KSG>
    <N_KSG>Лекарственная терапия при остром лейкозе, взрослые</N_KSG>
    <KOEF_Z>4.27</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>143</K_KSG>
    <N_KSG>Лекарственная терапия при других злокачественных новообразованиях лимфоидной и кроветворной тканей, взрослые</N_KSG>
    <KOEF_Z>3.46</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>144</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях других локализаций (кроме лимфоидной и кроветворной тканей) (уровень 1), доброкачественных заболеваниях крови и пузырном заносе</N_KSG>
    <KOEF_Z>2.05</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>145</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях других локализаций (кроме лимфоидной и кроветворной тканей) (уровень 2)</N_KSG>
    <KOEF_Z>2.80</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>146</K_KSG>
    <N_KSG>Лекарственная терапия злокачественных новообразований с применением моноклональных антител, ингибиторов протеинкиназы</N_KSG>
    <KOEF_Z>7.92</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>147</K_KSG>
    <N_KSG>Лучевая терапия (уровень 1)</N_KSG>
    <KOEF_Z>2.00</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>148</K_KSG>
    <N_KSG>Лучевая терапия (уровень 2)</N_KSG>
    <KOEF_Z>2.21</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>149</K_KSG>
    <N_KSG>Лучевая терапия (уровень 3)</N_KSG>
    <KOEF_Z>3.53</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>150</K_KSG>
    <N_KSG>Доброкачественные новообразования, новообразования in situ уха, горла, носа, полости рта</N_KSG>
    <KOEF_Z>0.66</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>151</K_KSG>
    <N_KSG>Средний отит, мастоидит, нарушения вестибулярной функции</N_KSG>
    <KOEF_Z>0.47</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>152</K_KSG>
    <N_KSG>Другие болезни уха</N_KSG>
    <KOEF_Z>0.61</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>153</K_KSG>
    <N_KSG>Другие болезни и врожденные аномалии верхних дыхательных путей, симптомы и признаки, относящиеся к органам дыхания, нарушения речи</N_KSG>
    <KOEF_Z>0.71</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>154</K_KSG>
    <N_KSG>Операции на органе слуха, придаточных пазухах носа и верхних дыхательных путях (уровень 1)</N_KSG>
    <KOEF_Z>0.84</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>155</K_KSG>
    <N_KSG>Операции на органе слуха, придаточных пазухах носа и верхних дыхательных путях (уровень 2)</N_KSG>
    <KOEF_Z>0.91</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>156</K_KSG>
    <N_KSG>Операции на органе слуха, придаточных пазухах носа и верхних дыхательных путях (уровень 3)</N_KSG>
    <KOEF_Z>1.10</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>157</K_KSG>
    <N_KSG>Операции на органе слуха, придаточных пазухах носа и верхних дыхательных путях (уровень 4)</N_KSG>
    <KOEF_Z>1.35</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>158</K_KSG>
    <N_KSG>Операции на органе слуха, придаточных пазухах носа и верхних дыхательных путях (уровень 5)</N_KSG>
    <KOEF_Z>1.96</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>159</K_KSG>
    <N_KSG>Замена речевого процессора</N_KSG>
    <KOEF_Z>25.00</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>160</K_KSG>
    <N_KSG>Операции на органе зрения (уровень 1)</N_KSG>
    <KOEF_Z>0.49</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>161</K_KSG>
    <N_KSG>Операции на органе зрения (уровень 2)</N_KSG>
    <KOEF_Z>0.79</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>162</K_KSG>
    <N_KSG>Операции на органе зрения (уровень 3)</N_KSG>
    <KOEF_Z>1.07</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>163</K_KSG>
    <N_KSG>Операции на органе зрения (уровень 4)</N_KSG>
    <KOEF_Z>1.19</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>164</K_KSG>
    <N_KSG>Операции на органе зрения (уровень 5)</N_KSG>
    <KOEF_Z>2.11</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>165</K_KSG>
    <N_KSG>Операции на органе зрения (уровень 6)</N_KSG>
    <KOEF_Z>2.33</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>166</K_KSG>
    <N_KSG>Болезни глаза</N_KSG>
    <KOEF_Z>0.51</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>167</K_KSG>
    <N_KSG>Травмы глаза</N_KSG>
    <KOEF_Z>0.66</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>168</K_KSG>
    <N_KSG>Нарушения всасывания, дети</N_KSG>
    <KOEF_Z>1.11</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>169</K_KSG>
    <N_KSG>Другие болезни органов пищеварения, дети</N_KSG>
    <KOEF_Z>0.39</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>170</K_KSG>
    <N_KSG>Воспалительные артропатии, спондилопатии, дети</N_KSG>
    <KOEF_Z>1.85</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>171</K_KSG>
    <N_KSG>Врожденные аномалии головного и спинного мозга, дети</N_KSG>
    <KOEF_Z>2.12</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>172</K_KSG>
    <N_KSG>Другие болезни органов дыхания</N_KSG>
    <KOEF_Z>0.85</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>173</K_KSG>
    <N_KSG>Интерстициальные болезни легких, врожденные аномалии развития легких, бронхо-легочная дисплазия, дети</N_KSG>
    <KOEF_Z>2.48</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>174</K_KSG>
    <N_KSG>Доброкачественные новообразования, новообразования in situ органов дыхания, других и неуточненных органов грудной клетки</N_KSG>
    <KOEF_Z>0.91</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>175</K_KSG>
    <N_KSG>Пневмония, плеврит, другие болезни плевры</N_KSG>
    <KOEF_Z>1.29</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>176</K_KSG>
    <N_KSG>Астма, взрослые</N_KSG>
    <KOEF_Z>1.11</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>177</K_KSG>
    <N_KSG>Астма, дети</N_KSG>
    <KOEF_Z>1.25</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>178</K_KSG>
    <N_KSG>Системные поражения соединительной ткани</N_KSG>
    <KOEF_Z>1.78</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>179</K_KSG>
    <N_KSG>Артропатии и спондилопатии</N_KSG>
    <KOEF_Z>1.67</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>180</K_KSG>
    <N_KSG>Ревматические болезни сердца (уровень 1)</N_KSG>
    <KOEF_Z>0.87</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>181</K_KSG>
    <N_KSG>Ревматические болезни сердца (уровень 2)</N_KSG>
    <KOEF_Z>1.57</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>182</K_KSG>
    <N_KSG>Флебит и тромбофлебит, варикозное расширение вен нижних конечностей</N_KSG>
    <KOEF_Z>0.85</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>183</K_KSG>
    <N_KSG>Другие болезни, врожденные аномалии вен</N_KSG>
    <KOEF_Z>1.32</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>184</K_KSG>
    <N_KSG>Болезни артерий, артериол и капилляров</N_KSG>
    <KOEF_Z>1.05</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>185</K_KSG>
    <N_KSG>Диагностическое обследование сердечно-сосудистой системы</N_KSG>
    <KOEF_Z>1.01</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>186</K_KSG>
    <N_KSG>Операции на сердце и коронарных сосудах (уровень 1)</N_KSG>
    <KOEF_Z>2.11</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>187</K_KSG>
    <N_KSG>Операции на сердце и коронарных сосудах (уровень 2)</N_KSG>
    <KOEF_Z>3.97</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>188</K_KSG>
    <N_KSG>Операции на сердце и коронарных сосудах (уровень 3)</N_KSG>
    <KOEF_Z>4.31</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>189</K_KSG>
    <N_KSG>Операции на сосудах (уровень 1)</N_KSG>
    <KOEF_Z>1.20</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>190</K_KSG>
    <N_KSG>Операции на сосудах (уровень 2)</N_KSG>
    <KOEF_Z>2.37</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>191</K_KSG>
    <N_KSG>Операции на сосудах (уровень 3)</N_KSG>
    <KOEF_Z>4.13</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>192</K_KSG>
    <N_KSG>Операции на сосудах (уровень 4)</N_KSG>
    <KOEF_Z>6.08</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>193</K_KSG>
    <N_KSG>Операции на сосудах (уровень 5)</N_KSG>
    <KOEF_Z>7.12</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>194</K_KSG>
    <N_KSG>Болезни полости рта, слюнных желез и челюстей, врожденные аномалии лица и шеи, дети</N_KSG>
    <KOEF_Z>0.79</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>195</K_KSG>
    <N_KSG>Болезни пищевода, гастрит, дуоденит, другие болезни желудка и двенадцатиперстной кишки</N_KSG>
    <KOEF_Z>0.74</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>196</K_KSG>
    <N_KSG>Новообразования доброкачественные, in situ, неопределенного и неуточненного характера органов пищеварения</N_KSG>
    <KOEF_Z>0.69</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>197</K_KSG>
    <N_KSG>Болезни желчного пузыря</N_KSG>
    <KOEF_Z>0.72</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>198</K_KSG>
    <N_KSG>Другие болезни органов пищеварения, взрослые</N_KSG>
    <KOEF_Z>0.59</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>199</K_KSG>
    <N_KSG>Гипертоническая болезнь в стадии обострения</N_KSG>
    <KOEF_Z>0.70</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>200</K_KSG>
    <N_KSG>Стенокардия (кроме нестабильной), хроническая ишемическая болезнь сердца (уровень 1)</N_KSG>
    <KOEF_Z>0.78</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>201</K_KSG>
    <N_KSG>Стенокардия (кроме нестабильной), хроническая ишемическая болезнь сердца (уровень 2)</N_KSG>
    <KOEF_Z>2.38</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>202</K_KSG>
    <N_KSG>Другие болезни сердца (уровень 1)</N_KSG>
    <KOEF_Z>0.78</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>203</K_KSG>
    <N_KSG>Другие болезни сердца (уровень 2)</N_KSG>
    <KOEF_Z>1.54</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>204</K_KSG>
    <N_KSG>Бронхит необструктивный, симптомы и признаки, относящиеся к органам дыхания</N_KSG>
    <KOEF_Z>0.75</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>205</K_KSG>
    <N_KSG>ХОБЛ, эмфизема, бронхоэктатическая болезнь</N_KSG>
    <KOEF_Z>0.89</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>206</K_KSG>
    <N_KSG>Отравления и другие воздействия внешних причин (уровень 1)</N_KSG>
    <KOEF_Z>0.27</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>207</K_KSG>
    <N_KSG>Отравления и другие воздействия внешних причин (уровень 2)</N_KSG>
    <KOEF_Z>0.63</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>208</K_KSG>
    <N_KSG>Госпитализация в диагностических целях с постановкой/ подтверждением диагноза злокачественного новообразования</N_KSG>
    <KOEF_Z>1.00</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>209</K_KSG>
    <N_KSG>Гнойные состояния нижних дыхательных путей</N_KSG>
    <KOEF_Z>2.05</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>210</K_KSG>
    <N_KSG>Операции на нижних дыхательных путях и легочной ткани, органах средостения (уровень 1)</N_KSG>
    <KOEF_Z>1.54</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>211</K_KSG>
    <N_KSG>Операции на нижних дыхательных путях и легочной ткани, органах средостения (уровень 2)</N_KSG>
    <KOEF_Z>1.92</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>212</K_KSG>
    <N_KSG>Операции на нижних дыхательных путях и легочной ткани, органах средостения (уровень 3)</N_KSG>
    <KOEF_Z>2.56</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>213</K_KSG>
    <N_KSG>Операции на нижних дыхательных путях и легочной ткани, органах средостения (уровень 4)</N_KSG>
    <KOEF_Z>4.12</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>214</K_KSG>
    <N_KSG>Приобретенные и врожденные костно-мышечные деформации</N_KSG>
    <KOEF_Z>0.99</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>215</K_KSG>
    <N_KSG>Переломы шейки бедра и костей таза</N_KSG>
    <KOEF_Z>1.52</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>216</K_KSG>
    <N_KSG>Переломы бедренной кости, другие травмы области бедра и тазобедренного сустава</N_KSG>
    <KOEF_Z>0.69</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>217</K_KSG>
    <N_KSG>Переломы, вывихи, растяжения области грудной клетки, верхней конечности и стопы</N_KSG>
    <KOEF_Z>0.56</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>218</K_KSG>
    <N_KSG>Переломы, вывихи, растяжения области колена и голени</N_KSG>
    <KOEF_Z>0.74</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>219</K_KSG>
    <N_KSG>Множественные переломы, травматические ампутации, размозжения и последствия травм</N_KSG>
    <KOEF_Z>1.44</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>220</K_KSG>
    <N_KSG>Тяжелая множественная и сочетанная травма (политравма)</N_KSG>
    <KOEF_Z>5.54</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>221</K_KSG>
    <N_KSG>Эндопротезирование суставов</N_KSG>
    <KOEF_Z>4.46</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>222</K_KSG>
    <N_KSG>Операции на костно-мышечной системе и суставах (уровень 1)</N_KSG>
    <KOEF_Z>0.79</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>223</K_KSG>
    <N_KSG>Операции на костно-мышечной системе и суставах (уровень 2)</N_KSG>
    <KOEF_Z>0.93</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>224</K_KSG>
    <N_KSG>Операции на костно-мышечной системе и суставах (уровень 3)</N_KSG>
    <KOEF_Z>1.37</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>225</K_KSG>
    <N_KSG>Операции на костно-мышечной системе и суставах (уровень 4)</N_KSG>
    <KOEF_Z>2.42</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>226</K_KSG>
    <N_KSG>Операции на костно-мышечной системе и суставах (уровень 5)</N_KSG>
    <KOEF_Z>3.15</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>227</K_KSG>
    <N_KSG>Тубулоинтерстициальные болезни почек, другие болезни мочевой системы</N_KSG>
    <KOEF_Z>0.86</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>228</K_KSG>
    <N_KSG>Камни мочевой системы; симптомы, относящиеся к мочевой системе</N_KSG>
    <KOEF_Z>0.49</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>229</K_KSG>
    <N_KSG>Доброкачественные новообразования, новообразования in situ, неопределенного и неизвестного характера мочевых органов и мужских половых органов</N_KSG>
    <KOEF_Z>0.64</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>230</K_KSG>
    <N_KSG>Болезни предстательной железы</N_KSG>
    <KOEF_Z>0.73</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>231</K_KSG>
    <N_KSG>Другие болезни, врожденные аномалии, повреждения мочевой системы и мужских половых органов</N_KSG>
    <KOEF_Z>0.67</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>232</K_KSG>
    <N_KSG>Операции на мужских половых органах, взрослые (уровень 1)</N_KSG>
    <KOEF_Z>1.20</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>233</K_KSG>
    <N_KSG>Операции на мужских половых органах, взрослые (уровень 2)</N_KSG>
    <KOEF_Z>1.42</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>234</K_KSG>
    <N_KSG>Операции на мужских половых органах, взрослые (уровень 3)</N_KSG>
    <KOEF_Z>2.31</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>235</K_KSG>
    <N_KSG>Операции на мужских половых органах, взрослые (уровень 4)</N_KSG>
    <KOEF_Z>3.12</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>236</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, взрослые (уровень 1)</N_KSG>
    <KOEF_Z>1.08</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>237</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, взрослые (уровень 2)</N_KSG>
    <KOEF_Z>1.12</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>238</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, взрослые (уровень 3)</N_KSG>
    <KOEF_Z>1.62</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>239</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, взрослые (уровень 4)</N_KSG>
    <KOEF_Z>1.95</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>240</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, взрослые (уровень 5)</N_KSG>
    <KOEF_Z>2.14</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>241</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, взрослые (уровень 6)</N_KSG>
    <KOEF_Z>4.13</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>242</K_KSG>
    <N_KSG>Болезни лимфатических сосудов и лимфатических узлов</N_KSG>
    <KOEF_Z>0.61</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>243</K_KSG>
    <N_KSG>Операции на коже, подкожной клетчатке, придатках кожи (уровень 1)</N_KSG>
    <KOEF_Z>0.55</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>244</K_KSG>
    <N_KSG>Операции на коже, подкожной клетчатке, придатках кожи (уровень 2)</N_KSG>
    <KOEF_Z>0.71</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>245</K_KSG>
    <N_KSG>Операции на коже, подкожной клетчатке, придатках кожи (уровень 3)</N_KSG>
    <KOEF_Z>1.38</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>246</K_KSG>
    <N_KSG>Операции на коже, подкожной клетчатке, придатках кожи (уровень 4)</N_KSG>
    <KOEF_Z>2.41</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>247</K_KSG>
    <N_KSG>Операции на органах кроветворения и иммунной системы (уровень 1)</N_KSG>
    <KOEF_Z>1.43</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>248</K_KSG>
    <N_KSG>Операции на органах кроветворения и иммунной системы (уровень 2)</N_KSG>
    <KOEF_Z>1.83</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>249</K_KSG>
    <N_KSG>Операции на органах кроветворения и иммунной системы (уровень 3)</N_KSG>
    <KOEF_Z>2.16</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>250</K_KSG>
    <N_KSG>Операции на эндокринных железах кроме гипофиза (уровень 1)</N_KSG>
    <KOEF_Z>1.81</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>251</K_KSG>
    <N_KSG>Операции на эндокринных железах кроме гипофиза (уровень 2)</N_KSG>
    <KOEF_Z>2.67</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>252</K_KSG>
    <N_KSG>Болезни молочной железы, новообразования молочной железы доброкачественные, in situ, неопределенного и неизвестного характера</N_KSG>
    <KOEF_Z>0.73</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>253</K_KSG>
    <N_KSG>Артрозы, другие поражения суставов, болезни мягких тканей</N_KSG>
    <KOEF_Z>0.76</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>254</K_KSG>
    <N_KSG>Остеомиелит (уровень 1)</N_KSG>
    <KOEF_Z>2.42</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>255</K_KSG>
    <N_KSG>Остеомиелит (уровень 2)</N_KSG>
    <KOEF_Z>3.51</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>256</K_KSG>
    <N_KSG>Остеомиелит (уровень 3)</N_KSG>
    <KOEF_Z>4.02</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>257</K_KSG>
    <N_KSG>Доброкачественные новообразования костно-мышечной системы и соединительной ткани</N_KSG>
    <KOEF_Z>0.84</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>258</K_KSG>
    <N_KSG>Доброкачественные новообразования, новообразования in situ кожи, жировой ткани</N_KSG>
    <KOEF_Z>0.66</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>259</K_KSG>
    <N_KSG>Открытые раны, поверхностные, другие и неуточненные травмы</N_KSG>
    <KOEF_Z>0.37</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>260</K_KSG>
    <N_KSG>Операции на молочной железе (кроме злокачественных новообразований)</N_KSG>
    <KOEF_Z>1.19</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>261</K_KSG>
    <N_KSG>Операции на желчном пузыре и желчевыводящих путях (уровень 1)</N_KSG>
    <KOEF_Z>1.15</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>262</K_KSG>
    <N_KSG>Операции на желчном пузыре и желчевыводящих путях (уровень 2)</N_KSG>
    <KOEF_Z>1.43</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>263</K_KSG>
    <N_KSG>Операции на желчном пузыре и желчевыводящих путях (уровень 3)</N_KSG>
    <KOEF_Z>3.00</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>264</K_KSG>
    <N_KSG>Операции на желчном пузыре и желчевыводящих путях (уровень 4)</N_KSG>
    <KOEF_Z>4.30</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>265</K_KSG>
    <N_KSG>Операции на печени и поджелудочной железе (уровень 1)</N_KSG>
    <KOEF_Z>2.42</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>266</K_KSG>
    <N_KSG>Операции на печени и поджелудочной железе (уровень 2)</N_KSG>
    <KOEF_Z>2.69</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>267</K_KSG>
    <N_KSG>Панкреатит, хирургическое лечение</N_KSG>
    <KOEF_Z>4.12</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>268</K_KSG>
    <N_KSG>Операции на пищеводе, желудке, двенадцатиперстной кишке (уровень 1)</N_KSG>
    <KOEF_Z>1.16</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>269</K_KSG>
    <N_KSG>Операции на пищеводе, желудке, двенадцатиперстной кишке (уровень 2)</N_KSG>
    <KOEF_Z>1.95</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>270</K_KSG>
    <N_KSG>Операции на пищеводе, желудке, двенадцатиперстной кишке (уровень 3)</N_KSG>
    <KOEF_Z>2.46</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>271</K_KSG>
    <N_KSG>Аппендэктомия, взрослые (уровень 1)</N_KSG>
    <KOEF_Z>0.73</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>272</K_KSG>
    <N_KSG>Аппендэктомия, взрослые (уровень 2)</N_KSG>
    <KOEF_Z>0.91</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>273</K_KSG>
    <N_KSG>Операции по поводу грыж, взрослые (уровень 1)</N_KSG>
    <KOEF_Z>0.86</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>274</K_KSG>
    <N_KSG>Операции по поводу грыж, взрослые (уровень 2)</N_KSG>
    <KOEF_Z>1.24</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>275</K_KSG>
    <N_KSG>Операции по поводу грыж, взрослые (уровень 3)</N_KSG>
    <KOEF_Z>1.78</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>276</K_KSG>
    <N_KSG>Другие операции на органах брюшной полости (уровень 1)</N_KSG>
    <KOEF_Z>1.13</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>277</K_KSG>
    <N_KSG>Другие операции на органах брюшной полости (уровень 2)</N_KSG>
    <KOEF_Z>1.19</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>278</K_KSG>
    <N_KSG>Другие операции на органах брюшной полости (уровень 3)</N_KSG>
    <KOEF_Z>2.13</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>279</K_KSG>
    <N_KSG>Отморожения (уровень 1)</N_KSG>
    <KOEF_Z>1.17</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>280</K_KSG>
    <N_KSG>Отморожения (уровень 2)</N_KSG>
    <KOEF_Z>2.91</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>281</K_KSG>
    <N_KSG>Ожоги (уровень 1)</N_KSG>
    <KOEF_Z>1.21</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>282</K_KSG>
    <N_KSG>Ожоги (уровень 2)</N_KSG>
    <KOEF_Z>2.03</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>283</K_KSG>
    <N_KSG>Ожоги (уровень 3)</N_KSG>
    <KOEF_Z>3.54</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>284</K_KSG>
    <N_KSG>Ожоги (уровень 4)</N_KSG>
    <KOEF_Z>5.21</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>285</K_KSG>
    <N_KSG>Ожоги (уровень 5)</N_KSG>
    <KOEF_Z>11.12</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>286</K_KSG>
    <N_KSG>Болезни полости рта, слюнных желез и челюстей, врожденные аномалии лица и шеи, взрослые</N_KSG>
    <KOEF_Z>0.89</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>287</K_KSG>
    <N_KSG>Операции на органах полости рта (уровень 1)</N_KSG>
    <KOEF_Z>0.74</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>288</K_KSG>
    <N_KSG>Операции на органах полости рта (уровень 2)</N_KSG>
    <KOEF_Z>1.27</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>289</K_KSG>
    <N_KSG>Операции на органах полости рта (уровень 3)</N_KSG>
    <KOEF_Z>1.63</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>290</K_KSG>
    <N_KSG>Операции на органах полости рта (уровень 4)</N_KSG>
    <KOEF_Z>1.90</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>291</K_KSG>
    <N_KSG>Сахарный диабет, взрослые (уровень 1)</N_KSG>
    <KOEF_Z>1.02</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>292</K_KSG>
    <N_KSG>Сахарный диабет, взрослые (уровень 2)</N_KSG>
    <KOEF_Z>1.49</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>293</K_KSG>
    <N_KSG>Заболевания гипофиза, взрослые</N_KSG>
    <KOEF_Z>2.14</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>294</K_KSG>
    <N_KSG>Другие болезни эндокринной системы, взрослые (уровень 1)</N_KSG>
    <KOEF_Z>1.25</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>295</K_KSG>
    <N_KSG>Другие болезни эндокринной системы, взрослые (уровень 2)</N_KSG>
    <KOEF_Z>2.76</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>296</K_KSG>
    <N_KSG>Новообразования эндокринных желез доброкачественные, in situ, неопределенного и неизвестного характера</N_KSG>
    <KOEF_Z>0.76</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>297</K_KSG>
    <N_KSG>Расстройства питания</N_KSG>
    <KOEF_Z>1.06</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>298</K_KSG>
    <N_KSG>Другие нарушения обмена веществ</N_KSG>
    <KOEF_Z>1.16</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>299</K_KSG>
    <N_KSG>Кистозный фиброз</N_KSG>
    <KOEF_Z>3.32</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>300</K_KSG>
    <N_KSG>Комплексное лечение с применением препаратов иммуноглобулина</N_KSG>
    <KOEF_Z>4.32</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>301</K_KSG>
    <N_KSG>Редкие генетические заболевания</N_KSG>
    <KOEF_Z>3.50</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>302</K_KSG>
    <N_KSG>Лечение с применением генно-инженерных биологических препаратов в случае отсутствия эффективности базисной терапии</N_KSG>
    <KOEF_Z>5.35</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>303</K_KSG>
    <N_KSG>Факторы, влияющие на состояние здоровья населения и обращения в учреждения здравоохранения</N_KSG>
    <KOEF_Z>0.32</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>304</K_KSG>
    <N_KSG>Госпитализация в диагностических целях с постановкой диагноза туберкулеза, ВИЧ-инфекции, психического заболевания</N_KSG>
    <KOEF_Z>0.46</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>305</K_KSG>
    <N_KSG>Отторжение, отмирание трансплантата органов и тканей</N_KSG>
    <KOEF_Z>8.40</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>306</K_KSG>
    <N_KSG>Установка, замена, заправка помп для лекарственных препаратов</N_KSG>
    <KOEF_Z>2.32</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>307</K_KSG>
    <N_KSG>Медицинская нейрореабилитация</N_KSG>
    <KOEF_Z>3.00</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>308</K_KSG>
    <N_KSG>Медицинская кардиореабилитация</N_KSG>
    <KOEF_Z>1.50</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>309</K_KSG>
    <N_KSG>Медицинская реабилитация после перенесенных травм и операций на опорно-двигательной системе</N_KSG>
    <KOEF_Z>2.25</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>310</K_KSG>
    <N_KSG>Медицинская реабилитация детей, перенесших заболевания перинатального периода</N_KSG>
    <KOEF_Z>1.50</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>311</K_KSG>
    <N_KSG>Медицинская реабилитация при других соматических заболеваниях</N_KSG>
    <KOEF_Z>0.70</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>312</K_KSG>
    <N_KSG>Медицинская реабилитация детей с нарушениями слуха без замены речевого процессора системы кохлеарной имплантации</N_KSG>
    <KOEF_Z>1.80</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>313</K_KSG>
    <N_KSG>Медицинская реабилитация детей с онкологическими, гематологическими и иммунологическими заболеваниями в тяжелых формах продолжительного течения</N_KSG>
    <KOEF_Z>4.81</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>314</K_KSG>
    <N_KSG>Медицинская реабилитация детей с поражениями центральной нервной системы</N_KSG>
    <KOEF_Z>2.75</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>315</K_KSG>
    <N_KSG>Медицинская реабилитация детей, после хирургической коррекции врожденных пороков развития органов и систем</N_KSG>
    <KOEF_Z>2.35</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>1</K_KSG>
    <N_KSG>Беременность без патологии, дородовая госпитализация в отделение сестринского ухода</N_KSG>
    <KOEF_Z>0.50</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>2</K_KSG>
    <N_KSG>Осложнения, связанные с беременностью</N_KSG>
    <KOEF_Z>0.93</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>3</K_KSG>
    <N_KSG>Беременность, закончившаяся абортивным исходом</N_KSG>
    <KOEF_Z>0.28</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>4</K_KSG>
    <N_KSG>Родоразрешение</N_KSG>
    <KOEF_Z>0.98</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>5</K_KSG>
    <N_KSG>Кесарево сечение</N_KSG>
    <KOEF_Z>1.01</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>6</K_KSG>
    <N_KSG>Осложнения послеродового периода</N_KSG>
    <KOEF_Z>0.74</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>7</K_KSG>
    <N_KSG>Послеродовой сепсис</N_KSG>
    <KOEF_Z>3.21</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>8</K_KSG>
    <N_KSG>Воспалительные болезни женских половых органов</N_KSG>
    <KOEF_Z>0.71</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>9</K_KSG>
    <N_KSG>Доброкачественные новообразования, новообразования in situ, неопределенного и неизвестного характера женских половых органов</N_KSG>
    <KOEF_Z>0.89</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>10</K_KSG>
    <N_KSG>Другие болезни, врожденные аномалии, повреждения женских половых органов</N_KSG>
    <KOEF_Z>0.46</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>11</K_KSG>
    <N_KSG>Операции на женских половых органах (уровень 1)</N_KSG>
    <KOEF_Z>0.39</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>12</K_KSG>
    <N_KSG>Операции на женских половых органах (уровень 2)</N_KSG>
    <KOEF_Z>0.58</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>13</K_KSG>
    <N_KSG>Операции на женских половых органах (уровень 3)</N_KSG>
    <KOEF_Z>1.17</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>14</K_KSG>
    <N_KSG>Операции на женских половых органах (уровень 4)</N_KSG>
    <KOEF_Z>2.20</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>15</K_KSG>
    <N_KSG>Нарушения с вовлечением иммунного механизма</N_KSG>
    <KOEF_Z>4.52</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>16</K_KSG>
    <N_KSG>Ангионевротический отек, анафилактический шок</N_KSG>
    <KOEF_Z>0.27</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>17</K_KSG>
    <N_KSG>Язва желудка и двенадцатиперстной кишки</N_KSG>
    <KOEF_Z>0.89</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>18</K_KSG>
    <N_KSG>Воспалительные заболевания кишечника</N_KSG>
    <KOEF_Z>2.01</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>19</K_KSG>
    <N_KSG>Болезни печени, невирусные (уровень 1)</N_KSG>
    <KOEF_Z>0.86</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>20</K_KSG>
    <N_KSG>Болезни печени, невирусные (уровень 2)</N_KSG>
    <KOEF_Z>1.21</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>21</K_KSG>
    <N_KSG>Болезни поджелудочной железы</N_KSG>
    <KOEF_Z>0.87</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>22</K_KSG>
    <N_KSG>Панкреатит с синдромом органной дисфункции</N_KSG>
    <KOEF_Z>4.19</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>23</K_KSG>
    <N_KSG>Анемии (уровень 1)</N_KSG>
    <KOEF_Z>0.94</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>24</K_KSG>
    <N_KSG>Анемии (уровень 2)</N_KSG>
    <KOEF_Z>5.32</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>25</K_KSG>
    <N_KSG>Нарушения свертываемости крови</N_KSG>
    <KOEF_Z>4.50</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>26</K_KSG>
    <N_KSG>Другие болезни крови и кроветворных органов (уровень 1)</N_KSG>
    <KOEF_Z>1.09</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>27</K_KSG>
    <N_KSG>Другие болезни крови и кроветворных органов (уровень 2)</N_KSG>
    <KOEF_Z>4.51</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>28</K_KSG>
    <N_KSG>Редкие и тяжелые дерматозы</N_KSG>
    <KOEF_Z>1.72</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>29</K_KSG>
    <N_KSG>Среднетяжелые дерматозы</N_KSG>
    <KOEF_Z>0.74</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>30</K_KSG>
    <N_KSG>Легкие дерматозы</N_KSG>
    <KOEF_Z>0.36</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>31</K_KSG>
    <N_KSG>Врожденные аномалии сердечно-сосудистой системы, дети</N_KSG>
    <KOEF_Z>1.84</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>32</K_KSG>
    <N_KSG>Лекарственная терапия при остром лейкозе, дети</N_KSG>
    <KOEF_Z>7.82</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>33</K_KSG>
    <N_KSG>Лекарственная терапия при других злокачественных новообразованиях лимфоидной и кроветворной тканей, дети</N_KSG>
    <KOEF_Z>5.68</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>34</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях других локализаций (кроме лимфоидной и кроветворной тканей), дети</N_KSG>
    <KOEF_Z>4.37</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>35</K_KSG>
    <N_KSG>Операции на мужских половых органах, дети (уровень 1)</N_KSG>
    <KOEF_Z>0.97</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>36</K_KSG>
    <N_KSG>Операции на мужских половых органах, дети (уровень 2)</N_KSG>
    <KOEF_Z>1.11</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>37</K_KSG>
    <N_KSG>Операции на мужских половых органах, дети (уровень 3)</N_KSG>
    <KOEF_Z>1.97</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>38</K_KSG>
    <N_KSG>Операции на мужских половых органах, дети (уровень 4)</N_KSG>
    <KOEF_Z>2.78</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>39</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, дети (уровень 1)</N_KSG>
    <KOEF_Z>1.15</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>40</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, дети (уровень 2)</N_KSG>
    <KOEF_Z>1.22</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>41</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, дети (уровень 3)</N_KSG>
    <KOEF_Z>1.78</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>42</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, дети (уровень 4)</N_KSG>
    <KOEF_Z>2.23</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>43</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, дети (уровень 5)</N_KSG>
    <KOEF_Z>2.36</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>44</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, дети (уровень 6)</N_KSG>
    <KOEF_Z>4.28</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>45</K_KSG>
    <N_KSG>Детская хирургия (уровень 1)</N_KSG>
    <KOEF_Z>2.95</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>46</K_KSG>
    <N_KSG>Детская хирургия (уровень 2)</N_KSG>
    <KOEF_Z>5.33</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>47</K_KSG>
    <N_KSG>Аппендэктомия, дети (уровень 1)</N_KSG>
    <KOEF_Z>0.77</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>48</K_KSG>
    <N_KSG>Аппендэктомия, дети (уровень 2)</N_KSG>
    <KOEF_Z>0.97</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>49</K_KSG>
    <N_KSG>Операции по поводу грыж, дети (уровень 1)</N_KSG>
    <KOEF_Z>0.88</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>50</K_KSG>
    <N_KSG>Операции по поводу грыж, дети (уровень 2)</N_KSG>
    <KOEF_Z>1.05</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>51</K_KSG>
    <N_KSG>Операции по поводу грыж, дети (уровень 3)</N_KSG>
    <KOEF_Z>1.25</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>52</K_KSG>
    <N_KSG>Сахарный диабет, дети</N_KSG>
    <KOEF_Z>1.51</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>53</K_KSG>
    <N_KSG>Заболевания гипофиза, дети</N_KSG>
    <KOEF_Z>2.26</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>54</K_KSG>
    <N_KSG>Другие болезни эндокринной системы, дети (уровень 1)</N_KSG>
    <KOEF_Z>1.38</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>55</K_KSG>
    <N_KSG>Другие болезни эндокринной системы, дети (уровень 2)</N_KSG>
    <KOEF_Z>2.82</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>56</K_KSG>
    <N_KSG>Кишечные инфекции, взрослые</N_KSG>
    <KOEF_Z>0.58</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>57</K_KSG>
    <N_KSG>Кишечные инфекции, дети</N_KSG>
    <KOEF_Z>0.62</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>58</K_KSG>
    <N_KSG>Вирусный гепатит острый</N_KSG>
    <KOEF_Z>1.40</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>59</K_KSG>
    <N_KSG>Вирусный гепатит хронический</N_KSG>
    <KOEF_Z>1.27</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>60</K_KSG>
    <N_KSG>Сепсис, взрослые</N_KSG>
    <KOEF_Z>3.12</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>61</K_KSG>
    <N_KSG>Сепсис, дети</N_KSG>
    <KOEF_Z>4.51</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>62</K_KSG>
    <N_KSG>Сепсис с синдромом органной дисфункции</N_KSG>
    <KOEF_Z>7.20</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>63</K_KSG>
    <N_KSG>Другие инфекционные и паразитарные болезни, взрослые</N_KSG>
    <KOEF_Z>1.18</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>64</K_KSG>
    <N_KSG>Другие инфекционные и паразитарные болезни, дети</N_KSG>
    <KOEF_Z>0.98</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>65</K_KSG>
    <N_KSG>Респираторные инфекции верхних дыхательных путей с осложнениями, взрослые</N_KSG>
    <KOEF_Z>0.35</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>66</K_KSG>
    <N_KSG>Респираторные инфекции верхних дыхательных путей, дети</N_KSG>
    <KOEF_Z>0.50</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>67</K_KSG>
    <N_KSG>Грипп, вирус гриппа идентифицирован</N_KSG>
    <KOEF_Z>1.01</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>68</K_KSG>
    <N_KSG>Клещевой энцефалит</N_KSG>
    <KOEF_Z>2.30</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>69</K_KSG>
    <N_KSG>Нестабильная стенокардия, инфаркт миокарда, легочная эмболия (уровень 1)</N_KSG>
    <KOEF_Z>1.42</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>70</K_KSG>
    <N_KSG>Нестабильная стенокардия, инфаркт миокарда, легочная эмболия (уровень 2)</N_KSG>
    <KOEF_Z>2.81</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>71</K_KSG>
    <N_KSG>Инфаркт миокарда, легочная эмболия, лечение с применением тромболитической терапии</N_KSG>
    <KOEF_Z>3.48</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>72</K_KSG>
    <N_KSG>Нарушения ритма и проводимости (уровень 1)</N_KSG>
    <KOEF_Z>1.12</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>73</K_KSG>
    <N_KSG>Нарушения ритма и проводимости (уровень 2)</N_KSG>
    <KOEF_Z>2.01</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>74</K_KSG>
    <N_KSG>Эндокардит, миокардит, перикардит, кардиомиопатии (уровень 1)</N_KSG>
    <KOEF_Z>1.42</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>75</K_KSG>
    <N_KSG>Эндокардит, миокардит, перикардит, кардиомиопатии (уровень 2)</N_KSG>
    <KOEF_Z>2.38</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>76</K_KSG>
    <N_KSG>Операции на кишечнике и анальной области (уровень 1)</N_KSG>
    <KOEF_Z>0.84</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>77</K_KSG>
    <N_KSG>Операции на кишечнике и анальной области (уровень 2)</N_KSG>
    <KOEF_Z>1.74</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>78</K_KSG>
    <N_KSG>Операции на кишечнике и анальной области (уровень 3)</N_KSG>
    <KOEF_Z>2.49</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>79</K_KSG>
    <N_KSG>Воспалительные заболевания ЦНС, взрослые</N_KSG>
    <KOEF_Z>0.98</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>80</K_KSG>
    <N_KSG>Воспалительные заболевания ЦНС, дети</N_KSG>
    <KOEF_Z>1.55</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>81</K_KSG>
    <N_KSG>Дегенеративные болезни нервной системы</N_KSG>
    <KOEF_Z>0.84</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>82</K_KSG>
    <N_KSG>Демиелинизирующие болезни нервной системы</N_KSG>
    <KOEF_Z>1.33</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>83</K_KSG>
    <N_KSG>Эпилепсия, судороги (уровень 1)</N_KSG>
    <KOEF_Z>0.96</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>84</K_KSG>
    <N_KSG>Эпилепсия, судороги (уровень 2)</N_KSG>
    <KOEF_Z>2.01</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>85</K_KSG>
    <N_KSG>Расстройства периферической нервной системы</N_KSG>
    <KOEF_Z>1.02</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>86</K_KSG>
    <N_KSG>Неврологические заболевания, лечение с применением ботулотоксина</N_KSG>
    <KOEF_Z>1.95</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>87</K_KSG>
    <N_KSG>Другие нарушения нервной системы (уровень 1)</N_KSG>
    <KOEF_Z>0.74</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>88</K_KSG>
    <N_KSG>Другие нарушения нервной системы (уровень 2)</N_KSG>
    <KOEF_Z>0.99</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>89</K_KSG>
    <N_KSG>Транзиторные ишемические приступы, сосудистые мозговые синдромы</N_KSG>
    <KOEF_Z>1.15</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>90</K_KSG>
    <N_KSG>Кровоизлияние в мозг</N_KSG>
    <KOEF_Z>2.82</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>91</K_KSG>
    <N_KSG>Инфаркт мозга (уровень 1)</N_KSG>
    <KOEF_Z>2.52</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>92</K_KSG>
    <N_KSG>Инфаркт мозга (уровень 2)</N_KSG>
    <KOEF_Z>3.12</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>93</K_KSG>
    <N_KSG>Инфаркт мозга (уровень 3)</N_KSG>
    <KOEF_Z>4.51</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>94</K_KSG>
    <N_KSG>Другие цереброваскулярные болезни</N_KSG>
    <KOEF_Z>0.82</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>95</K_KSG>
    <N_KSG>Паралитические синдромы, травма спинного мозга (уровень 1)</N_KSG>
    <KOEF_Z>0.98</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>96</K_KSG>
    <N_KSG>Паралитические синдромы, травма спинного мозга (уровень 2)</N_KSG>
    <KOEF_Z>1.49</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>97</K_KSG>
    <N_KSG>Дорсопатии, спондилопатии, остеопатии</N_KSG>
    <KOEF_Z>0.68</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>98</K_KSG>
    <N_KSG>Травмы позвоночника</N_KSG>
    <KOEF_Z>1.01</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>99</K_KSG>
    <N_KSG>Сотрясение головного мозга</N_KSG>
    <KOEF_Z>0.40</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>100</K_KSG>
    <N_KSG>Переломы черепа, внутричерепная травма</N_KSG>
    <KOEF_Z>1.54</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>101</K_KSG>
    <N_KSG>Операции на центральной нервной системе и головном мозге (уровень 1)</N_KSG>
    <KOEF_Z>4.13</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>102</K_KSG>
    <N_KSG>Операции на центральной нервной системе и головном мозге (уровень 2)</N_KSG>
    <KOEF_Z>5.82</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>103</K_KSG>
    <N_KSG>Операции на периферической нервной системе (уровень 1)</N_KSG>
    <KOEF_Z>1.41</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>104</K_KSG>
    <N_KSG>Операции на периферической нервной системе (уровень 2)</N_KSG>
    <KOEF_Z>2.19</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>105</K_KSG>
    <N_KSG>Операции на периферической нервной системе (уровень 3)</N_KSG>
    <KOEF_Z>2.42</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>106</K_KSG>
    <N_KSG>Доброкачественные новообразования нервной системы</N_KSG>
    <KOEF_Z>1.02</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>107</K_KSG>
    <N_KSG>Малая масса тела при рождении, недоношенность</N_KSG>
    <KOEF_Z>4.21</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>108</K_KSG>
    <N_KSG>Крайне малая масса тела при рождении, крайняя незрелость</N_KSG>
    <KOEF_Z>16.02</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>109</K_KSG>
    <N_KSG>Лечение новорожденных с тяжелой патологией с применением аппаратных методов поддержки или замещения витальных функций</N_KSG>
    <KOEF_Z>7.40</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>110</K_KSG>
    <N_KSG>Геморрагические и гемолитические нарушения у новорожденных</N_KSG>
    <KOEF_Z>1.92</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>111</K_KSG>
    <N_KSG>Другие нарушения, возникшие в перинатальном периоде (уровень 1)</N_KSG>
    <KOEF_Z>1.39</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>112</K_KSG>
    <N_KSG>Другие нарушения, возникшие в перинатальном периоде (уровень 2)</N_KSG>
    <KOEF_Z>1.89</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>113</K_KSG>
    <N_KSG>Другие нарушения, возникшие в перинатальном периоде (уровень 3)</N_KSG>
    <KOEF_Z>2.56</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>114</K_KSG>
    <N_KSG>Почечная недостаточность</N_KSG>
    <KOEF_Z>1.66</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>115</K_KSG>
    <N_KSG>Формирование, имплантация, реконструкция, удаление, смена доступа для диализа</N_KSG>
    <KOEF_Z>1.82</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>116</K_KSG>
    <N_KSG>Гломерулярные болезни</N_KSG>
    <KOEF_Z>1.71</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>117</K_KSG>
    <N_KSG>Операции на женских половых органах при злокачественных новообразованиях (уровень 1)</N_KSG>
    <KOEF_Z>1.98</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>118</K_KSG>
    <N_KSG>Операции на женских половых органах при злокачественных новообразованиях (уровень 2)</N_KSG>
    <KOEF_Z>3.66</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>119</K_KSG>
    <N_KSG>Операции на женских половых органах при злокачественных новообразованиях (уровень 3)</N_KSG>
    <KOEF_Z>4.05</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>120</K_KSG>
    <N_KSG>Операции на кишечнике и анальной области при злокачественных новообразованиях (уровень 1)</N_KSG>
    <KOEF_Z>2.45</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>121</K_KSG>
    <N_KSG>Операции на кишечнике и анальной области при злокачественных новообразованиях (уровень 2)</N_KSG>
    <KOEF_Z>4.24</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>122</K_KSG>
    <N_KSG>Операции при злокачественных новообразованиях почки и мочевыделительной системы (уровень 1)</N_KSG>
    <KOEF_Z>1.40</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>123</K_KSG>
    <N_KSG>Операции при злокачественных новообразованиях почки и мочевыделительной системы (уровень 2)</N_KSG>
    <KOEF_Z>2.46</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>124</K_KSG>
    <N_KSG>Операции при злокачественных новообразованиях почки и мочевыделительной системы (уровень 3)</N_KSG>
    <KOEF_Z>3.24</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>125</K_KSG>
    <N_KSG>Операции при злокачественных новообразованиях кожи (уровень 1)</N_KSG>
    <KOEF_Z>1.09</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>126</K_KSG>
    <N_KSG>Операции при злокачественных новообразованиях кожи (уровень 2)</N_KSG>
    <KOEF_Z>1.36</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>127</K_KSG>
    <N_KSG>Операции при злокачественных новообразованиях кожи (уровень 3)</N_KSG>
    <KOEF_Z>1.41</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>128</K_KSG>
    <N_KSG>Операции при злокачественном новообразовании щитовидной железы (уровень 1)</N_KSG>
    <KOEF_Z>1.88</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>129</K_KSG>
    <N_KSG>Операции при злокачественном новообразовании щитовидной железы (уровень 2)</N_KSG>
    <KOEF_Z>1.92</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>130</K_KSG>
    <N_KSG>Мастэктомия, другие операции при злокачественном новообразовании молочной железы (уровень 1)</N_KSG>
    <KOEF_Z>2.29</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>131</K_KSG>
    <N_KSG>Мастэктомия, другие операции при злокачественном новообразовании молочной железы (уровень 2)</N_KSG>
    <KOEF_Z>3.12</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>132</K_KSG>
    <N_KSG>Операции при злокачественном новообразовании желчного пузыря, желчных протоков (уровень 1)</N_KSG>
    <KOEF_Z>1.96</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>133</K_KSG>
    <N_KSG>Операции при злокачественном новообразовании желчного пузыря, желчных протоков (уровень 2)</N_KSG>
    <KOEF_Z>2.17</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>134</K_KSG>
    <N_KSG>Операции при злокачественном новообразовании пищевода, желудка (уровень 1)</N_KSG>
    <KOEF_Z>2.02</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>135</K_KSG>
    <N_KSG>Операции при злокачественном новообразовании пищевода, желудка (уровень 2)</N_KSG>
    <KOEF_Z>2.57</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>136</K_KSG>
    <N_KSG>Операции при злокачественном новообразовании пищевода, желудка (уровень 3)</N_KSG>
    <KOEF_Z>3.14</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>137</K_KSG>
    <N_KSG>Другие операции при злокачественном новообразовании брюшной полости</N_KSG>
    <KOEF_Z>2.48</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>138</K_KSG>
    <N_KSG>Злокачественное новообразование без специального противоопухолевого лечения</N_KSG>
    <KOEF_Z>0.50</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>139</K_KSG>
    <N_KSG>Операции на органе слуха, придаточных пазухах носа и верхних дыхательных путях при злокачественных новообразованиях</N_KSG>
    <KOEF_Z>1.91</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>140</K_KSG>
    <N_KSG>Операции на нижних дыхательных путях и легочной ткани при злокачественных новообразованиях (уровень 1)</N_KSG>
    <KOEF_Z>2.88</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>141</K_KSG>
    <N_KSG>Операции на нижних дыхательных путях и легочной ткани при злокачественных новообразованиях (уровень 2)</N_KSG>
    <KOEF_Z>4.25</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>142</K_KSG>
    <N_KSG>Операции при злокачественных новообразованиях мужских половых органов (уровень 1)</N_KSG>
    <KOEF_Z>2.56</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>143</K_KSG>
    <N_KSG>Операции при злокачественных новообразованиях мужских половых органов (уровень 2)</N_KSG>
    <KOEF_Z>3.60</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>144</K_KSG>
    <N_KSG>Лекарственная терапия при остром лейкозе, взрослые</N_KSG>
    <KOEF_Z>4.27</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>145</K_KSG>
    <N_KSG>Лекарственная терапия при других злокачественных новообразованиях лимфоидной и кроветворной тканей, взрослые</N_KSG>
    <KOEF_Z>3.46</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>146</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях (кроме лимфоидной и кроветворной тканей), взрослые (уровень 1)</N_KSG>
    <KOEF_Z>0.56</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>147</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях (кроме лимфоидной и кроветворной тканей), взрослые (уровень 2)</N_KSG>
    <KOEF_Z>1.04</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>148</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях (кроме лимфоидной и кроветворной тканей), взрослые (уровень 3)</N_KSG>
    <KOEF_Z>1.56</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>149</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях (кроме лимфоидной и кроветворной тканей), взрослые (уровень 4)</N_KSG>
    <KOEF_Z>2.23</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>150</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях (кроме лимфоидной и кроветворной тканей), взрослые (уровень 5)</N_KSG>
    <KOEF_Z>2.40</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>151</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях (кроме лимфоидной и кроветворной тканей), взрослые (уровень 6)</N_KSG>
    <KOEF_Z>2.92</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>152</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях (кроме лимфоидной и кроветворной тканей), взрослые (уровень 7)</N_KSG>
    <KOEF_Z>3.30</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>153</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях (кроме лимфоидной и кроветворной тканей), взрослые (уровень 8)</N_KSG>
    <KOEF_Z>4.22</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>154</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях (кроме лимфоидной и кроветворной тканей), взрослые (уровень 9)</N_KSG>
    <KOEF_Z>5.30</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>155</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях (кроме лимфоидной и кроветворной тканей), взрослые (уровень 10)</N_KSG>
    <KOEF_Z>11.02</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>156</K_KSG>
    <N_KSG>Лекарственная терапия при доброкачественных заболеваниях крови и пузырном заносе</N_KSG>
    <KOEF_Z>2.05</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>157</K_KSG>
    <N_KSG>Лекарственная терапия злокачественных новообразований лимфоидной и кроветворной тканей с применением моноклональных антител, ингибиторов протеинкиназы</N_KSG>
    <KOEF_Z>7.92</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>158</K_KSG>
    <N_KSG>Фебрильная нейтропения, агранулоцитоз вследствие проведения лекарственной терапии злокачественных новообразований (кроме лимфоидной и кроветворной тканей)</N_KSG>
    <KOEF_Z>2.93</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>159</K_KSG>
    <N_KSG>Установка, замена порт системы (катетера) для лекарственной терапии злокачественных новообразований (кроме лимфоидной и кроветворной тканей)</N_KSG>
    <KOEF_Z>1.02</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>160</K_KSG>
    <N_KSG>Лучевая терапия (уровень 1)</N_KSG>
    <KOEF_Z>2.00</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>161</K_KSG>
    <N_KSG>Лучевая терапия (уровень 2)</N_KSG>
    <KOEF_Z>2.21</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>162</K_KSG>
    <N_KSG>Лучевая терапия (уровень 3)</N_KSG>
    <KOEF_Z>3.53</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>163</K_KSG>
    <N_KSG>Доброкачественные новообразования, новообразования in situ уха, горла, носа, полости рта</N_KSG>
    <KOEF_Z>0.66</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>164</K_KSG>
    <N_KSG>Средний отит, мастоидит, нарушения вестибулярной функции</N_KSG>
    <KOEF_Z>0.47</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>165</K_KSG>
    <N_KSG>Другие болезни уха</N_KSG>
    <KOEF_Z>0.61</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>166</K_KSG>
    <N_KSG>Другие болезни и врожденные аномалии верхних дыхательных путей, симптомы и признаки, относящиеся к органам дыхания, нарушения речи</N_KSG>
    <KOEF_Z>0.71</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>167</K_KSG>
    <N_KSG>Операции на органе слуха, придаточных пазухах носа и верхних дыхательных путях (уровень 1)</N_KSG>
    <KOEF_Z>0.84</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>168</K_KSG>
    <N_KSG>Операции на органе слуха, придаточных пазухах носа и верхних дыхательных путях (уровень 2)</N_KSG>
    <KOEF_Z>0.91</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>169</K_KSG>
    <N_KSG>Операции на органе слуха, придаточных пазухах носа и верхних дыхательных путях (уровень 3)</N_KSG>
    <KOEF_Z>1.10</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>170</K_KSG>
    <N_KSG>Операции на органе слуха, придаточных пазухах носа и верхних дыхательных путях (уровень 4)</N_KSG>
    <KOEF_Z>1.35</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>171</K_KSG>
    <N_KSG>Операции на органе слуха, придаточных пазухах носа и верхних дыхательных путях (уровень 5)</N_KSG>
    <KOEF_Z>1.96</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>172</K_KSG>
    <N_KSG>Замена речевого процессора</N_KSG>
    <KOEF_Z>25.00</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>173</K_KSG>
    <N_KSG>Операции на органе зрения (уровень 1)</N_KSG>
    <KOEF_Z>0.49</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>174</K_KSG>
    <N_KSG>Операции на органе зрения (уровень 2)</N_KSG>
    <KOEF_Z>0.79</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>175</K_KSG>
    <N_KSG>Операции на органе зрения (уровень 3)</N_KSG>
    <KOEF_Z>1.07</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>176</K_KSG>
    <N_KSG>Операции на органе зрения (уровень 4)</N_KSG>
    <KOEF_Z>1.19</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>177</K_KSG>
    <N_KSG>Операции на органе зрения (уровень 5)</N_KSG>
    <KOEF_Z>2.11</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>178</K_KSG>
    <N_KSG>Операции на органе зрения (уровень 6)</N_KSG>
    <KOEF_Z>2.33</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>179</K_KSG>
    <N_KSG>Болезни глаза</N_KSG>
    <KOEF_Z>0.51</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>180</K_KSG>
    <N_KSG>Травмы глаза</N_KSG>
    <KOEF_Z>0.66</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>181</K_KSG>
    <N_KSG>Нарушения всасывания, дети</N_KSG>
    <KOEF_Z>1.11</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>182</K_KSG>
    <N_KSG>Другие болезни органов пищеварения, дети</N_KSG>
    <KOEF_Z>0.39</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>183</K_KSG>
    <N_KSG>Воспалительные артропатии, спондилопатии, дети</N_KSG>
    <KOEF_Z>1.85</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>184</K_KSG>
    <N_KSG>Врожденные аномалии головного и спинного мозга, дети</N_KSG>
    <KOEF_Z>2.12</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>185</K_KSG>
    <N_KSG>Другие болезни органов дыхания</N_KSG>
    <KOEF_Z>0.85</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>186</K_KSG>
    <N_KSG>Интерстициальные болезни легких, врожденные аномалии развития легких, бронхо-легочная дисплазия, дети</N_KSG>
    <KOEF_Z>2.48</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>187</K_KSG>
    <N_KSG>Доброкачественные новообразования, новообразования in situ органов дыхания, других и неуточненных органов грудной клетки</N_KSG>
    <KOEF_Z>0.91</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>188</K_KSG>
    <N_KSG>Пневмония, плеврит, другие болезни плевры</N_KSG>
    <KOEF_Z>1.29</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>189</K_KSG>
    <N_KSG>Астма, взрослые</N_KSG>
    <KOEF_Z>1.11</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>190</K_KSG>
    <N_KSG>Астма, дети</N_KSG>
    <KOEF_Z>1.25</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>191</K_KSG>
    <N_KSG>Системные поражения соединительной ткани</N_KSG>
    <KOEF_Z>1.78</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>192</K_KSG>
    <N_KSG>Артропатии и спондилопатии</N_KSG>
    <KOEF_Z>1.67</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>193</K_KSG>
    <N_KSG>Ревматические болезни сердца (уровень 1)</N_KSG>
    <KOEF_Z>0.87</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>194</K_KSG>
    <N_KSG>Ревматические болезни сердца (уровень 2)</N_KSG>
    <KOEF_Z>1.57</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>195</K_KSG>
    <N_KSG>Флебит и тромбофлебит, варикозное расширение вен нижних конечностей</N_KSG>
    <KOEF_Z>0.85</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>196</K_KSG>
    <N_KSG>Другие болезни, врожденные аномалии вен</N_KSG>
    <KOEF_Z>1.32</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>197</K_KSG>
    <N_KSG>Болезни артерий, артериол и капилляров</N_KSG>
    <KOEF_Z>1.05</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>198</K_KSG>
    <N_KSG>Диагностическое обследование сердечно-сосудистой системы</N_KSG>
    <KOEF_Z>1.01</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>199</K_KSG>
    <N_KSG>Операции на сердце и коронарных сосудах (уровень 1)</N_KSG>
    <KOEF_Z>2.11</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>200</K_KSG>
    <N_KSG>Операции на сердце и коронарных сосудах (уровень 2)</N_KSG>
    <KOEF_Z>3.97</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>201</K_KSG>
    <N_KSG>Операции на сердце и коронарных сосудах (уровень 3)</N_KSG>
    <KOEF_Z>4.31</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>202</K_KSG>
    <N_KSG>Операции на сосудах (уровень 1)</N_KSG>
    <KOEF_Z>1.20</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>203</K_KSG>
    <N_KSG>Операции на сосудах (уровень 2)</N_KSG>
    <KOEF_Z>2.37</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>204</K_KSG>
    <N_KSG>Операции на сосудах (уровень 3)</N_KSG>
    <KOEF_Z>4.13</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>205</K_KSG>
    <N_KSG>Операции на сосудах (уровень 4)</N_KSG>
    <KOEF_Z>6.08</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>206</K_KSG>
    <N_KSG>Операции на сосудах (уровень 5)</N_KSG>
    <KOEF_Z>7.12</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>207</K_KSG>
    <N_KSG>Болезни полости рта, слюнных желез и челюстей, врожденные аномалии лица и шеи, дети</N_KSG>
    <KOEF_Z>0.79</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>208</K_KSG>
    <N_KSG>Болезни пищевода, гастрит, дуоденит, другие болезни желудка и двенадцатиперстной кишки</N_KSG>
    <KOEF_Z>0.74</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>209</K_KSG>
    <N_KSG>Новообразования доброкачественные, in situ, неопределенного и неуточненного характера органов пищеварения</N_KSG>
    <KOEF_Z>0.69</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>210</K_KSG>
    <N_KSG>Болезни желчного пузыря</N_KSG>
    <KOEF_Z>0.72</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>211</K_KSG>
    <N_KSG>Другие болезни органов пищеварения, взрослые</N_KSG>
    <KOEF_Z>0.59</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>212</K_KSG>
    <N_KSG>Гипертоническая болезнь в стадии обострения</N_KSG>
    <KOEF_Z>0.70</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>213</K_KSG>
    <N_KSG>Стенокардия (кроме нестабильной), хроническая ишемическая болезнь сердца (уровень 1)</N_KSG>
    <KOEF_Z>0.78</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>214</K_KSG>
    <N_KSG>Стенокардия (кроме нестабильной), хроническая ишемическая болезнь сердца (уровень 2)</N_KSG>
    <KOEF_Z>1.70</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>215</K_KSG>
    <N_KSG>Другие болезни сердца (уровень 1)</N_KSG>
    <KOEF_Z>0.78</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>216</K_KSG>
    <N_KSG>Другие болезни сердца (уровень 2)</N_KSG>
    <KOEF_Z>1.54</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>217</K_KSG>
    <N_KSG>Бронхит необструктивный, симптомы и признаки, относящиеся к органам дыхания</N_KSG>
    <KOEF_Z>0.75</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>218</K_KSG>
    <N_KSG>ХОБЛ, эмфизема, бронхоэктатическая болезнь</N_KSG>
    <KOEF_Z>0.89</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>219</K_KSG>
    <N_KSG>Отравления и другие воздействия внешних причин</N_KSG>
    <KOEF_Z>0.53</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>220</K_KSG>
    <N_KSG>Отравления и другие воздействия внешних причин с синдромом органной дисфункции</N_KSG>
    <KOEF_Z>4.07</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>221</K_KSG>
    <N_KSG>Госпитализация в диагностических целях с постановкой/ подтверждением диагноза злокачественного новообразования</N_KSG>
    <KOEF_Z>1.00</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>222</K_KSG>
    <N_KSG>Гнойные состояния нижних дыхательных путей</N_KSG>
    <KOEF_Z>2.05</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>223</K_KSG>
    <N_KSG>Операции на нижних дыхательных путях и легочной ткани, органах средостения (уровень 1)</N_KSG>
    <KOEF_Z>1.54</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>224</K_KSG>
    <N_KSG>Операции на нижних дыхательных путях и легочной ткани, органах средостения (уровень 2)</N_KSG>
    <KOEF_Z>1.92</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>225</K_KSG>
    <N_KSG>Операции на нижних дыхательных путях и легочной ткани, органах средостения (уровень 3)</N_KSG>
    <KOEF_Z>2.56</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>226</K_KSG>
    <N_KSG>Операции на нижних дыхательных путях и легочной ткани, органах средостения (уровень 4)</N_KSG>
    <KOEF_Z>4.12</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>227</K_KSG>
    <N_KSG>Приобретенные и врожденные костно-мышечные деформации</N_KSG>
    <KOEF_Z>0.99</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>228</K_KSG>
    <N_KSG>Переломы шейки бедра и костей таза</N_KSG>
    <KOEF_Z>1.52</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>229</K_KSG>
    <N_KSG>Переломы бедренной кости, другие травмы области бедра и тазобедренного сустава</N_KSG>
    <KOEF_Z>0.69</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>230</K_KSG>
    <N_KSG>Переломы, вывихи, растяжения области грудной клетки, верхней конечности и стопы</N_KSG>
    <KOEF_Z>0.56</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>231</K_KSG>
    <N_KSG>Переломы, вывихи, растяжения области колена и голени</N_KSG>
    <KOEF_Z>0.74</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>232</K_KSG>
    <N_KSG>Множественные переломы, травматические ампутации, размозжения и последствия травм</N_KSG>
    <KOEF_Z>1.44</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>233</K_KSG>
    <N_KSG>Тяжелая множественная и сочетанная травма (политравма)</N_KSG>
    <KOEF_Z>7.07</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>234</K_KSG>
    <N_KSG>Эндопротезирование суставов</N_KSG>
    <KOEF_Z>4.46</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>235</K_KSG>
    <N_KSG>Операции на костно-мышечной системе и суставах (уровень 1)</N_KSG>
    <KOEF_Z>0.79</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>236</K_KSG>
    <N_KSG>Операции на костно-мышечной системе и суставах (уровень 2)</N_KSG>
    <KOEF_Z>0.93</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>237</K_KSG>
    <N_KSG>Операции на костно-мышечной системе и суставах (уровень 3)</N_KSG>
    <KOEF_Z>1.37</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>238</K_KSG>
    <N_KSG>Операции на костно-мышечной системе и суставах (уровень 4)</N_KSG>
    <KOEF_Z>2.42</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>239</K_KSG>
    <N_KSG>Операции на костно-мышечной системе и суставах (уровень 5)</N_KSG>
    <KOEF_Z>3.15</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>240</K_KSG>
    <N_KSG>Тубулоинтерстициальные болезни почек, другие болезни мочевой системы</N_KSG>
    <KOEF_Z>0.86</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>241</K_KSG>
    <N_KSG>Камни мочевой системы; симптомы, относящиеся к мочевой системе</N_KSG>
    <KOEF_Z>0.49</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>242</K_KSG>
    <N_KSG>Доброкачественные новообразования, новообразования in situ, неопределенного и неизвестного характера мочевых органов и мужских половых органов</N_KSG>
    <KOEF_Z>0.64</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>243</K_KSG>
    <N_KSG>Болезни предстательной железы</N_KSG>
    <KOEF_Z>0.73</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>244</K_KSG>
    <N_KSG>Другие болезни, врожденные аномалии, повреждения мочевой системы и мужских половых органов</N_KSG>
    <KOEF_Z>0.67</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>245</K_KSG>
    <N_KSG>Операции на мужских половых органах, взрослые (уровень 1)</N_KSG>
    <KOEF_Z>1.20</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>246</K_KSG>
    <N_KSG>Операции на мужских половых органах, взрослые (уровень 2)</N_KSG>
    <KOEF_Z>1.42</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>247</K_KSG>
    <N_KSG>Операции на мужских половых органах, взрослые (уровень 3)</N_KSG>
    <KOEF_Z>2.31</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>248</K_KSG>
    <N_KSG>Операции на мужских половых органах, взрослые (уровень 4)</N_KSG>
    <KOEF_Z>3.12</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>249</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, взрослые (уровень 1)</N_KSG>
    <KOEF_Z>1.08</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>250</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, взрослые (уровень 2)</N_KSG>
    <KOEF_Z>1.12</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>251</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, взрослые (уровень 3)</N_KSG>
    <KOEF_Z>1.62</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>252</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, взрослые (уровень 4)</N_KSG>
    <KOEF_Z>1.95</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>253</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, взрослые (уровень 5)</N_KSG>
    <KOEF_Z>2.14</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>254</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, взрослые (уровень 6)</N_KSG>
    <KOEF_Z>4.13</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>255</K_KSG>
    <N_KSG>Болезни лимфатических сосудов и лимфатических узлов</N_KSG>
    <KOEF_Z>0.61</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>256</K_KSG>
    <N_KSG>Операции на коже, подкожной клетчатке, придатках кожи (уровень 1)</N_KSG>
    <KOEF_Z>0.55</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>257</K_KSG>
    <N_KSG>Операции на коже, подкожной клетчатке, придатках кожи (уровень 2)</N_KSG>
    <KOEF_Z>0.71</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>258</K_KSG>
    <N_KSG>Операции на коже, подкожной клетчатке, придатках кожи (уровень 3)</N_KSG>
    <KOEF_Z>1.38</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>259</K_KSG>
    <N_KSG>Операции на коже, подкожной клетчатке, придатках кожи (уровень 4)</N_KSG>
    <KOEF_Z>2.41</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>260</K_KSG>
    <N_KSG>Операции на органах кроветворения и иммунной системы (уровень 1)</N_KSG>
    <KOEF_Z>1.43</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>261</K_KSG>
    <N_KSG>Операции на органах кроветворения и иммунной системы (уровень 2)</N_KSG>
    <KOEF_Z>1.83</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>262</K_KSG>
    <N_KSG>Операции на органах кроветворения и иммунной системы (уровень 3)</N_KSG>
    <KOEF_Z>2.16</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>263</K_KSG>
    <N_KSG>Операции на эндокринных железах кроме гипофиза (уровень 1)</N_KSG>
    <KOEF_Z>1.81</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>264</K_KSG>
    <N_KSG>Операции на эндокринных железах кроме гипофиза (уровень 2)</N_KSG>
    <KOEF_Z>2.67</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>265</K_KSG>
    <N_KSG>Болезни молочной железы, новообразования молочной железы доброкачественные, in situ, неопределенного и неизвестного характера</N_KSG>
    <KOEF_Z>0.73</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>266</K_KSG>
    <N_KSG>Артрозы, другие поражения суставов, болезни мягких тканей</N_KSG>
    <KOEF_Z>0.76</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>267</K_KSG>
    <N_KSG>Остеомиелит (уровень 1)</N_KSG>
    <KOEF_Z>2.42</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>268</K_KSG>
    <N_KSG>Остеомиелит (уровень 2)</N_KSG>
    <KOEF_Z>3.51</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>269</K_KSG>
    <N_KSG>Остеомиелит (уровень 3)</N_KSG>
    <KOEF_Z>4.02</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>270</K_KSG>
    <N_KSG>Доброкачественные новообразования костно-мышечной системы и соединительной ткани</N_KSG>
    <KOEF_Z>0.84</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>271</K_KSG>
    <N_KSG>Доброкачественные новообразования, новообразования in situ кожи, жировой ткани и другие болезни кожи</N_KSG>
    <KOEF_Z>0.50</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>272</K_KSG>
    <N_KSG>Открытые раны, поверхностные, другие и неуточненные травмы</N_KSG>
    <KOEF_Z>0.37</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>273</K_KSG>
    <N_KSG>Операции на молочной железе (кроме злокачественных новообразований)</N_KSG>
    <KOEF_Z>1.19</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>274</K_KSG>
    <N_KSG>Операции на желчном пузыре и желчевыводящих путях (уровень 1)</N_KSG>
    <KOEF_Z>1.15</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>275</K_KSG>
    <N_KSG>Операции на желчном пузыре и желчевыводящих путях (уровень 2)</N_KSG>
    <KOEF_Z>1.43</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>276</K_KSG>
    <N_KSG>Операции на желчном пузыре и желчевыводящих путях (уровень 3)</N_KSG>
    <KOEF_Z>3.00</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>277</K_KSG>
    <N_KSG>Операции на желчном пузыре и желчевыводящих путях (уровень 4)</N_KSG>
    <KOEF_Z>4.30</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>278</K_KSG>
    <N_KSG>Операции на печени и поджелудочной железе (уровень 1)</N_KSG>
    <KOEF_Z>2.42</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>279</K_KSG>
    <N_KSG>Операции на печени и поджелудочной железе (уровень 2)</N_KSG>
    <KOEF_Z>2.69</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>280</K_KSG>
    <N_KSG>Панкреатит, хирургическое лечение</N_KSG>
    <KOEF_Z>4.12</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>281</K_KSG>
    <N_KSG>Операции на пищеводе, желудке, двенадцатиперстной кишке (уровень 1)</N_KSG>
    <KOEF_Z>1.16</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>282</K_KSG>
    <N_KSG>Операции на пищеводе, желудке, двенадцатиперстной кишке (уровень 2)</N_KSG>
    <KOEF_Z>1.95</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>283</K_KSG>
    <N_KSG>Операции на пищеводе, желудке, двенадцатиперстной кишке (уровень 3)</N_KSG>
    <KOEF_Z>2.46</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>284</K_KSG>
    <N_KSG>Аппендэктомия, взрослые (уровень 1)</N_KSG>
    <KOEF_Z>0.73</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>285</K_KSG>
    <N_KSG>Аппендэктомия, взрослые (уровень 2)</N_KSG>
    <KOEF_Z>0.91</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>286</K_KSG>
    <N_KSG>Операции по поводу грыж, взрослые (уровень 1)</N_KSG>
    <KOEF_Z>0.86</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>287</K_KSG>
    <N_KSG>Операции по поводу грыж, взрослые (уровень 2)</N_KSG>
    <KOEF_Z>1.24</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>288</K_KSG>
    <N_KSG>Операции по поводу грыж, взрослые (уровень 3)</N_KSG>
    <KOEF_Z>1.78</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>289</K_KSG>
    <N_KSG>Другие операции на органах брюшной полости (уровень 1)</N_KSG>
    <KOEF_Z>1.13</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>290</K_KSG>
    <N_KSG>Другие операции на органах брюшной полости (уровень 2)</N_KSG>
    <KOEF_Z>1.19</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>291</K_KSG>
    <N_KSG>Другие операции на органах брюшной полости (уровень 3)</N_KSG>
    <KOEF_Z>2.13</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>292</K_KSG>
    <N_KSG>Отморожения (уровень 1)</N_KSG>
    <KOEF_Z>1.17</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>293</K_KSG>
    <N_KSG>Отморожения (уровень 2)</N_KSG>
    <KOEF_Z>2.91</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>294</K_KSG>
    <N_KSG>Ожоги (уровень 1)</N_KSG>
    <KOEF_Z>1.21</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>295</K_KSG>
    <N_KSG>Ожоги (уровень 2)</N_KSG>
    <KOEF_Z>2.03</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>296</K_KSG>
    <N_KSG>Ожоги (уровень 3)</N_KSG>
    <KOEF_Z>3.54</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>297</K_KSG>
    <N_KSG>Ожоги (уровень 4)</N_KSG>
    <KOEF_Z>5.20</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>298</K_KSG>
    <N_KSG>Ожоги (уровень 5)</N_KSG>
    <KOEF_Z>11.11</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>299</K_KSG>
    <N_KSG>Ожоги (уровень 4,5) с синдромом органной дисфункции</N_KSG>
    <KOEF_Z>14.07</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>300</K_KSG>
    <N_KSG>Болезни полости рта, слюнных желез и челюстей, врожденные аномалии лица и шеи, взрослые</N_KSG>
    <KOEF_Z>0.89</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>301</K_KSG>
    <N_KSG>Операции на органах полости рта (уровень 1)</N_KSG>
    <KOEF_Z>0.74</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>302</K_KSG>
    <N_KSG>Операции на органах полости рта (уровень 2)</N_KSG>
    <KOEF_Z>1.27</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>303</K_KSG>
    <N_KSG>Операции на органах полости рта (уровень 3)</N_KSG>
    <KOEF_Z>1.63</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>304</K_KSG>
    <N_KSG>Операции на органах полости рта (уровень 4)</N_KSG>
    <KOEF_Z>1.90</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>305</K_KSG>
    <N_KSG>Сахарный диабет, взрослые (уровень 1)</N_KSG>
    <KOEF_Z>1.02</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>306</K_KSG>
    <N_KSG>Сахарный диабет, взрослые (уровень 2)</N_KSG>
    <KOEF_Z>1.49</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>307</K_KSG>
    <N_KSG>Заболевания гипофиза, взрослые</N_KSG>
    <KOEF_Z>2.14</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>308</K_KSG>
    <N_KSG>Другие болезни эндокринной системы, взрослые (уровень 1)</N_KSG>
    <KOEF_Z>1.25</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>309</K_KSG>
    <N_KSG>Другие болезни эндокринной системы, взрослые (уровень 2)</N_KSG>
    <KOEF_Z>2.76</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>310</K_KSG>
    <N_KSG>Новообразования эндокринных желез доброкачественные, in situ, неопределенного и неизвестного характера</N_KSG>
    <KOEF_Z>0.76</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>311</K_KSG>
    <N_KSG>Расстройства питания</N_KSG>
    <KOEF_Z>1.06</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>312</K_KSG>
    <N_KSG>Другие нарушения обмена веществ</N_KSG>
    <KOEF_Z>1.16</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>313</K_KSG>
    <N_KSG>Кистозный фиброз</N_KSG>
    <KOEF_Z>3.32</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>314</K_KSG>
    <N_KSG>Комплексное лечение с применением препаратов иммуноглобулина</N_KSG>
    <KOEF_Z>4.32</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>315</K_KSG>
    <N_KSG>Редкие генетические заболевания</N_KSG>
    <KOEF_Z>3.50</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>316</K_KSG>
    <N_KSG>Лечение с применением генно-инженерных биологических препаратов в случае отсутствия эффективности базисной терапии</N_KSG>
    <KOEF_Z>5.35</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>317</K_KSG>
    <N_KSG>Факторы, влияющие на состояние здоровья населения и обращения в учреждения здравоохранения</N_KSG>
    <KOEF_Z>0.32</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>318</K_KSG>
    <N_KSG>Госпитализация в диагностических целях с постановкой диагноза туберкулеза, ВИЧ-инфекции, психического заболевания</N_KSG>
    <KOEF_Z>0.46</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>319</K_KSG>
    <N_KSG>Отторжение, отмирание трансплантата органов и тканей</N_KSG>
    <KOEF_Z>8.40</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>320</K_KSG>
    <N_KSG>Установка, замена, заправка помп для лекарственных препаратов</N_KSG>
    <KOEF_Z>2.32</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>321</K_KSG>
    <N_KSG>Интенсивная терапия пациентов с нейрогенными нарушениями жизненно важных функций, нуждающихся в их длительном искусственном замещении</N_KSG>
    <KOEF_Z>18.15</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>322</K_KSG>
    <N_KSG>Реинфузия аутокрови</N_KSG>
    <KOEF_Z>2.05</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>323</K_KSG>
    <N_KSG>Баллонная внутриаортальная контрпульсация</N_KSG>
    <KOEF_Z>7.81</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>324</K_KSG>
    <N_KSG>Экстракорпоральная мембранная оксигенация</N_KSG>
    <KOEF_Z>15.57</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>325</K_KSG>
    <N_KSG>Медицинская реабилитация пациентов с заболеваниями центральной нервной системы (3 балла по ШРМ)</N_KSG>
    <KOEF_Z>1.31</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>326</K_KSG>
    <N_KSG>Медицинская реабилитация пациентов с заболеваниями центральной нервной системы (4 балла по ШРМ)</N_KSG>
    <KOEF_Z>1.82</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>327</K_KSG>
    <N_KSG>Медицинская реабилитация пациентов с заболеваниями центральной нервной системы (5 баллов по ШРМ)</N_KSG>
    <KOEF_Z>3.12</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>328</K_KSG>
    <N_KSG>Медицинская реабилитация пациентов с заболеваниями центральной нервной системы (6 баллов по ШРМ)</N_KSG>
    <KOEF_Z>8.60</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>329</K_KSG>
    <N_KSG>Медицинская реабилитация пациентов с заболеваниями опорно-двигательного аппарата и периферической нервной системы (3 балла по ШРМ)</N_KSG>
    <KOEF_Z>1.24</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>330</K_KSG>
    <N_KSG>Медицинская реабилитация пациентов с заболеваниями опорно-двигательного аппарата и периферической нервной системы (4 баллов по ШРМ)</N_KSG>
    <KOEF_Z>1.67</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>331</K_KSG>
    <N_KSG>Медицинская реабилитация пациентов с заболеваниями опорно-двигательного аппарата и периферической нервной системы (5 баллов по ШРМ)</N_KSG>
    <KOEF_Z>3.03</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>332</K_KSG>
    <N_KSG>Медицинская кардиореабилитация (3 балла по ШРМ)</N_KSG>
    <KOEF_Z>1.02</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>333</K_KSG>
    <N_KSG>Медицинская кардиореабилитация (4 балла по ШРМ)</N_KSG>
    <KOEF_Z>1.38</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>334</K_KSG>
    <N_KSG>Медицинская кардиореабилитация (5 балла по ШРМ)</N_KSG>
    <KOEF_Z>2.00</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>335</K_KSG>
    <N_KSG>Медицинская реабилитация при других соматических заболеваниях (3 балла по ШРМ)</N_KSG>
    <KOEF_Z>0.59</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>336</K_KSG>
    <N_KSG>Медицинская реабилитация при других соматических заболеваниях (4 баллов по ШРМ)</N_KSG>
    <KOEF_Z>0.84</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>337</K_KSG>
    <N_KSG>Медицинская реабилитация при других соматических заболеваниях (5 баллов по ШРМ)</N_KSG>
    <KOEF_Z>1.17</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>338</K_KSG>
    <N_KSG>Медицинская реабилитация детей, перенесших заболевания перинатального периода</N_KSG>
    <KOEF_Z>1.50</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>339</K_KSG>
    <N_KSG>Медицинская реабилитация детей с нарушениями слуха без замены речевого процессора системы кохлеарной имплантации</N_KSG>
    <KOEF_Z>1.80</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>340</K_KSG>
    <N_KSG>Медицинская реабилитация детей с онкологическими, гематологическими и иммунологическими заболеваниями в тяжелых формах продолжительного течения</N_KSG>
    <KOEF_Z>4.81</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>341</K_KSG>
    <N_KSG>Медицинская реабилитация детей с поражениями центральной нервной системы</N_KSG>
    <KOEF_Z>2.75</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>342</K_KSG>
    <N_KSG>Медицинская реабилитация детей, после хирургической коррекции врожденных пороков развития органов и систем</N_KSG>
    <KOEF_Z>2.35</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>343</K_KSG>
    <N_KSG>Старческая астения</N_KSG>
    <KOEF_Z>1.50</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>325</K_KSG>
    <N_KSG>Медицинская реабилитация пациентов с заболеваниями центральной нервной системы (4 балла по ШРМ)</N_KSG>
    <KOEF_Z>1.82</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>326</K_KSG>
    <N_KSG>Медицинская реабилитация пациентов с заболеваниями центральной нервной системы (5 баллов по ШРМ)</N_KSG>
    <KOEF_Z>3.12</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>327</K_KSG>
    <N_KSG>Медицинская реабилитация пациентов с заболеваниями центральной нервной системы (6 баллов по ШРМ)</N_KSG>
    <KOEF_Z>8.60</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>328</K_KSG>
    <N_KSG>Медицинская реабилитация пациентов с заболеваниями опорно-двигательного аппарата и периферической нервной системы (4 балла по ШРМ)</N_KSG>
    <KOEF_Z>0.85</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>329</K_KSG>
    <N_KSG>Медицинская реабилитация пациентов с заболеваниями опорно-двигательного аппарата и периферической нервной системы (5 баллов по ШРМ)</N_KSG>
    <KOEF_Z>1.12</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>330</K_KSG>
    <N_KSG>Медицинская реабилитация пациентов с заболеваниями опорно-двигательного аппарата и периферической нервной системы (6 баллов по ШРМ)</N_KSG>
    <KOEF_Z>3.35</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>331</K_KSG>
    <N_KSG>Медицинская реабилитация пациентов с соматическими заболеваниями (4 балла по ШРМ)</N_KSG>
    <KOEF_Z>0.41</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>332</K_KSG>
    <N_KSG>Медицинская реабилитация пациентов с соматическими заболеваниями (5 баллов по ШРМ)</N_KSG>
    <KOEF_Z>0.61</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>333</K_KSG>
    <N_KSG>Медицинская реабилитация пациентов с соматическими заболеваниями (6 баллов по ШРМ)</N_KSG>
    <KOEF_Z>1.10</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>334</K_KSG>
    <N_KSG>Медицинская реабилитация детей, перенесших заболевания перинатального периода</N_KSG>
    <KOEF_Z>1.50</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>335</K_KSG>
    <N_KSG>Медицинская реабилитация детей с нарушениями слуха без замены речевого процессора системы кохлеарной имплантации</N_KSG>
    <KOEF_Z>1.80</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>336</K_KSG>
    <N_KSG>Медицинская реабилитация детей с онкологическими, гематологическими и иммунологическими заболеваниями в тяжелых формах продолжительного течения</N_KSG>
    <KOEF_Z>4.81</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>337</K_KSG>
    <N_KSG>Медицинская реабилитация детей с поражениями центральной нервной системы</N_KSG>
    <KOEF_Z>2.75</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>338</K_KSG>
    <N_KSG>Медицинская реабилитация детей, после хирургической коррекции врожденных пороков развития органов и систем</N_KSG>
    <KOEF_Z>2.35</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>339</K_KSG>
    <N_KSG>Старческая астения</N_KSG>
    <KOEF_Z>1.50</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st01.001</K_KSG>
    <N_KSG>Беременность без патологии, дородовая госпитализация в отделение сестринского ухода</N_KSG>
    <KOEF_Z>0.50</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st02.001</K_KSG>
    <N_KSG>Осложнения, связанные с беременностью</N_KSG>
    <KOEF_Z>0.93</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st02.002</K_KSG>
    <N_KSG>Беременность, закончившаяся абортивным исходом</N_KSG>
    <KOEF_Z>0.28</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st02.003</K_KSG>
    <N_KSG>Родоразрешение</N_KSG>
    <KOEF_Z>0.98</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st02.004</K_KSG>
    <N_KSG>Кесарево сечение</N_KSG>
    <KOEF_Z>1.01</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st02.005</K_KSG>
    <N_KSG>Осложнения послеродового периода</N_KSG>
    <KOEF_Z>0.74</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st02.006</K_KSG>
    <N_KSG>Послеродовой сепсис</N_KSG>
    <KOEF_Z>3.21</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st02.007</K_KSG>
    <N_KSG>Воспалительные болезни женских половых органов</N_KSG>
    <KOEF_Z>0.71</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st02.008</K_KSG>
    <N_KSG>Доброкачественные новообразования, новообразования in situ, неопределенного и неизвестного характера женских половых органов</N_KSG>
    <KOEF_Z>0.89</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st02.009</K_KSG>
    <N_KSG>Другие болезни, врожденные аномалии, повреждения женских половых органов</N_KSG>
    <KOEF_Z>0.46</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st02.010</K_KSG>
    <N_KSG>Операции на женских половых органах (уровень 1)</N_KSG>
    <KOEF_Z>0.39</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st02.011</K_KSG>
    <N_KSG>Операции на женских половых органах (уровень 2)</N_KSG>
    <KOEF_Z>0.58</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st02.012</K_KSG>
    <N_KSG>Операции на женских половых органах (уровень 3)</N_KSG>
    <KOEF_Z>1.17</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st02.013</K_KSG>
    <N_KSG>Операции на женских половых органах (уровень 4)</N_KSG>
    <KOEF_Z>2.20</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st03.001</K_KSG>
    <N_KSG>Нарушения с вовлечением иммунного механизма</N_KSG>
    <KOEF_Z>4.52</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st03.002</K_KSG>
    <N_KSG>Ангионевротический отек, анафилактический шок</N_KSG>
    <KOEF_Z>0.27</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st04.001</K_KSG>
    <N_KSG>Язва желудка и двенадцатиперстной кишки</N_KSG>
    <KOEF_Z>0.89</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st04.002</K_KSG>
    <N_KSG>Воспалительные заболевания кишечника</N_KSG>
    <KOEF_Z>2.01</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st04.003</K_KSG>
    <N_KSG>Болезни печени, невирусные (уровень 1)</N_KSG>
    <KOEF_Z>0.86</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st04.004</K_KSG>
    <N_KSG>Болезни печени, невирусные (уровень 2)</N_KSG>
    <KOEF_Z>1.21</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st04.005</K_KSG>
    <N_KSG>Болезни поджелудочной железы</N_KSG>
    <KOEF_Z>0.87</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st04.006</K_KSG>
    <N_KSG>Панкреатит с синдромом органной дисфункции</N_KSG>
    <KOEF_Z>4.19</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st05.001</K_KSG>
    <N_KSG>Анемии (уровень 1)</N_KSG>
    <KOEF_Z>0.94</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st05.002</K_KSG>
    <N_KSG>Анемии (уровень 2)</N_KSG>
    <KOEF_Z>5.32</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st05.003</K_KSG>
    <N_KSG>Нарушения свертываемости крови</N_KSG>
    <KOEF_Z>4.50</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st05.004</K_KSG>
    <N_KSG>Другие болезни крови и кроветворных органов (уровень 1)</N_KSG>
    <KOEF_Z>1.09</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st05.005</K_KSG>
    <N_KSG>Другие болезни крови и кроветворных органов (уровень 2)</N_KSG>
    <KOEF_Z>4.51</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st05.006</K_KSG>
    <N_KSG>Лекарственная терапия при остром лейкозе, взрослые</N_KSG>
    <KOEF_Z>4.27</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st05.007</K_KSG>
    <N_KSG>Лекарственная терапия при других злокачественных новообразованиях лимфоидной и кроветворной тканей, взрослые</N_KSG>
    <KOEF_Z>3.46</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st05.008</K_KSG>
    <N_KSG>Лекарственная терапия при доброкачественных заболеваниях крови и пузырном заносе</N_KSG>
    <KOEF_Z>2.05</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st05.009</K_KSG>
    <N_KSG>Лекарственная терапия злокачественных новообразований лимфоидной и кроветворной тканей с применением моноклональных антител, ингибиторов протеинкиназы</N_KSG>
    <KOEF_Z>7.92</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st05.010</K_KSG>
    <N_KSG>Лекарственная терапия при остром лейкозе, дети</N_KSG>
    <KOEF_Z>7.82</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st05.011</K_KSG>
    <N_KSG>Лекарственная терапия при других злокачественных новообразованиях лимфоидной и кроветворной тканей, дети</N_KSG>
    <KOEF_Z>5.68</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st06.001</K_KSG>
    <N_KSG>Редкие и тяжелые дерматозы</N_KSG>
    <KOEF_Z>1.72</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st06.002</K_KSG>
    <N_KSG>Среднетяжелые дерматозы</N_KSG>
    <KOEF_Z>0.74</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st06.003</K_KSG>
    <N_KSG>Легкие дерматозы</N_KSG>
    <KOEF_Z>0.36</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st07.001</K_KSG>
    <N_KSG>Врожденные аномалии сердечно-сосудистой системы, дети</N_KSG>
    <KOEF_Z>1.84</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st08.001</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях других локализаций (кроме лимфоидной и кроветворной тканей), дети</N_KSG>
    <KOEF_Z>4.37</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st09.001</K_KSG>
    <N_KSG>Операции на мужских половых органах, дети (уровень 1)</N_KSG>
    <KOEF_Z>0.97</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st09.002</K_KSG>
    <N_KSG>Операции на мужских половых органах, дети (уровень 2)</N_KSG>
    <KOEF_Z>1.11</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st09.003</K_KSG>
    <N_KSG>Операции на мужских половых органах, дети (уровень 3)</N_KSG>
    <KOEF_Z>1.97</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st09.004</K_KSG>
    <N_KSG>Операции на мужских половых органах, дети (уровень 4)</N_KSG>
    <KOEF_Z>2.78</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st09.005</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, дети (уровень 1)</N_KSG>
    <KOEF_Z>1.15</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st09.006</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, дети (уровень 2)</N_KSG>
    <KOEF_Z>1.22</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st09.007</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, дети (уровень 3)</N_KSG>
    <KOEF_Z>1.78</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st09.008</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, дети (уровень 4)</N_KSG>
    <KOEF_Z>2.23</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st09.009</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, дети (уровень 5)</N_KSG>
    <KOEF_Z>2.36</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st09.010</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, дети (уровень 6)</N_KSG>
    <KOEF_Z>4.28</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st10.001</K_KSG>
    <N_KSG>Детская хирургия (уровень 1)</N_KSG>
    <KOEF_Z>2.95</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st10.002</K_KSG>
    <N_KSG>Детская хирургия (уровень 2)</N_KSG>
    <KOEF_Z>5.33</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st10.003</K_KSG>
    <N_KSG>Аппендэктомия, дети (уровень 1)</N_KSG>
    <KOEF_Z>0.77</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st10.004</K_KSG>
    <N_KSG>Аппендэктомия, дети (уровень 2)</N_KSG>
    <KOEF_Z>0.97</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st10.005</K_KSG>
    <N_KSG>Операции по поводу грыж, дети (уровень 1)</N_KSG>
    <KOEF_Z>0.88</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st10.006</K_KSG>
    <N_KSG>Операции по поводу грыж, дети (уровень 2)</N_KSG>
    <KOEF_Z>1.05</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st10.007</K_KSG>
    <N_KSG>Операции по поводу грыж, дети (уровень 3)</N_KSG>
    <KOEF_Z>1.25</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st11.001</K_KSG>
    <N_KSG>Сахарный диабет, дети</N_KSG>
    <KOEF_Z>1.51</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st11.002</K_KSG>
    <N_KSG>Заболевания гипофиза, дети</N_KSG>
    <KOEF_Z>2.26</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st11.003</K_KSG>
    <N_KSG>Другие болезни эндокринной системы, дети (уровень 1)</N_KSG>
    <KOEF_Z>1.38</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st11.004</K_KSG>
    <N_KSG>Другие болезни эндокринной системы, дети (уровень 2)</N_KSG>
    <KOEF_Z>2.82</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st12.001</K_KSG>
    <N_KSG>Кишечные инфекции, взрослые</N_KSG>
    <KOEF_Z>0.58</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st12.002</K_KSG>
    <N_KSG>Кишечные инфекции, дети</N_KSG>
    <KOEF_Z>0.62</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st12.003</K_KSG>
    <N_KSG>Вирусный гепатит острый</N_KSG>
    <KOEF_Z>1.40</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st12.004</K_KSG>
    <N_KSG>Вирусный гепатит хронический</N_KSG>
    <KOEF_Z>1.27</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st12.005</K_KSG>
    <N_KSG>Сепсис, взрослые</N_KSG>
    <KOEF_Z>3.12</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st12.006</K_KSG>
    <N_KSG>Сепсис, дети</N_KSG>
    <KOEF_Z>4.51</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st12.007</K_KSG>
    <N_KSG>Сепсис с синдромом органной дисфункции</N_KSG>
    <KOEF_Z>7.20</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st12.008</K_KSG>
    <N_KSG>Другие инфекционные и паразитарные болезни, взрослые</N_KSG>
    <KOEF_Z>1.18</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st12.009</K_KSG>
    <N_KSG>Другие инфекционные и паразитарные болезни, дети</N_KSG>
    <KOEF_Z>0.98</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st12.010</K_KSG>
    <N_KSG>Респираторные инфекции верхних дыхательных путей с осложнениями, взрослые</N_KSG>
    <KOEF_Z>0.35</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st12.011</K_KSG>
    <N_KSG>Респираторные инфекции верхних дыхательных путей, дети</N_KSG>
    <KOEF_Z>0.50</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st12.012</K_KSG>
    <N_KSG>Грипп, вирус гриппа идентифицирован</N_KSG>
    <KOEF_Z>1.00</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st12.013</K_KSG>
    <N_KSG>Грипп и пневмония с синдромом органной дисфункции</N_KSG>
    <KOEF_Z>4.40</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st12.014</K_KSG>
    <N_KSG>Клещевой энцефалит</N_KSG>
    <KOEF_Z>2.30</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st13.001</K_KSG>
    <N_KSG>Нестабильная стенокардия, инфаркт миокарда, легочная эмболия (уровень 1)</N_KSG>
    <KOEF_Z>1.42</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st13.002</K_KSG>
    <N_KSG>Нестабильная стенокардия, инфаркт миокарда, легочная эмболия (уровень 2)</N_KSG>
    <KOEF_Z>2.81</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st13.003</K_KSG>
    <N_KSG>Инфаркт миокарда, легочная эмболия, лечение с применением тромболитической терапии</N_KSG>
    <KOEF_Z>3.48</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st13.004</K_KSG>
    <N_KSG>Нарушения ритма и проводимости (уровень 1)</N_KSG>
    <KOEF_Z>1.12</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st13.005</K_KSG>
    <N_KSG>Нарушения ритма и проводимости (уровень 2)</N_KSG>
    <KOEF_Z>2.01</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st13.006</K_KSG>
    <N_KSG>Эндокардит, миокардит, перикардит, кардиомиопатии (уровень 1)</N_KSG>
    <KOEF_Z>1.42</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st13.007</K_KSG>
    <N_KSG>Эндокардит, миокардит, перикардит, кардиомиопатии (уровень 2)</N_KSG>
    <KOEF_Z>2.38</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st14.001</K_KSG>
    <N_KSG>Операции на кишечнике и анальной области (уровень 1)</N_KSG>
    <KOEF_Z>0.84</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st14.002</K_KSG>
    <N_KSG>Операции на кишечнике и анальной области (уровень 2)</N_KSG>
    <KOEF_Z>1.74</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st14.003</K_KSG>
    <N_KSG>Операции на кишечнике и анальной области (уровень 3)</N_KSG>
    <KOEF_Z>2.49</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st15.001</K_KSG>
    <N_KSG>Воспалительные заболевания ЦНС, взрослые</N_KSG>
    <KOEF_Z>0.98</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st15.002</K_KSG>
    <N_KSG>Воспалительные заболевания ЦНС, дети</N_KSG>
    <KOEF_Z>1.55</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st15.003</K_KSG>
    <N_KSG>Дегенеративные болезни нервной системы</N_KSG>
    <KOEF_Z>0.84</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st15.004</K_KSG>
    <N_KSG>Демиелинизирующие болезни нервной системы</N_KSG>
    <KOEF_Z>1.33</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st15.005</K_KSG>
    <N_KSG>Эпилепсия, судороги (уровень 1)</N_KSG>
    <KOEF_Z>0.96</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st15.006</K_KSG>
    <N_KSG>Эпилепсия, судороги (уровень 2)</N_KSG>
    <KOEF_Z>2.01</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st15.007</K_KSG>
    <N_KSG>Расстройства периферической нервной системы</N_KSG>
    <KOEF_Z>1.02</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st15.008</K_KSG>
    <N_KSG>Неврологические заболевания, лечение с применением ботулотоксина (уровень1)</N_KSG>
    <KOEF_Z>1.61</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st15.009</K_KSG>
    <N_KSG>Неврологические заболевания, лечение с применением ботулотоксина (уровень 2)</N_KSG>
    <KOEF_Z>2.05</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st15.010</K_KSG>
    <N_KSG>Другие нарушения нервной системы (уровень 1)</N_KSG>
    <KOEF_Z>0.74</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st15.011</K_KSG>
    <N_KSG>Другие нарушения нервной системы (уровень 2)</N_KSG>
    <KOEF_Z>0.99</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st15.012</K_KSG>
    <N_KSG>Транзиторные ишемические приступы, сосудистые мозговые синдромы</N_KSG>
    <KOEF_Z>1.15</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st15.013</K_KSG>
    <N_KSG>Кровоизлияние в мозг</N_KSG>
    <KOEF_Z>2.82</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st15.014</K_KSG>
    <N_KSG>Инфаркт мозга (уровень 1)</N_KSG>
    <KOEF_Z>2.52</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st15.015</K_KSG>
    <N_KSG>Инфаркт мозга (уровень 2)</N_KSG>
    <KOEF_Z>3.12</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st15.016</K_KSG>
    <N_KSG>Инфаркт мозга (уровень 3)</N_KSG>
    <KOEF_Z>4.51</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st15.017</K_KSG>
    <N_KSG>Другие цереброваскулярные болезни</N_KSG>
    <KOEF_Z>0.82</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st16.001</K_KSG>
    <N_KSG>Паралитические синдромы, травма спинного мозга (уровень 1)</N_KSG>
    <KOEF_Z>0.98</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st16.002</K_KSG>
    <N_KSG>Паралитические синдромы, травма спинного мозга (уровень 2)</N_KSG>
    <KOEF_Z>1.49</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st16.003</K_KSG>
    <N_KSG>Дорсопатии, спондилопатии, остеопатии</N_KSG>
    <KOEF_Z>0.68</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st16.004</K_KSG>
    <N_KSG>Травмы позвоночника</N_KSG>
    <KOEF_Z>1.01</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st16.005</K_KSG>
    <N_KSG>Сотрясение головного мозга</N_KSG>
    <KOEF_Z>0.40</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st16.006</K_KSG>
    <N_KSG>Переломы черепа, внутричерепная травма</N_KSG>
    <KOEF_Z>1.54</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st16.007</K_KSG>
    <N_KSG>Операции на центральной нервной системе и головном мозге (уровень 1)</N_KSG>
    <KOEF_Z>4.13</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st16.008</K_KSG>
    <N_KSG>Операции на центральной нервной системе и головном мозге (уровень 2)</N_KSG>
    <KOEF_Z>5.82</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st16.009</K_KSG>
    <N_KSG>Операции на периферической нервной системе (уровень 1)</N_KSG>
    <KOEF_Z>1.41</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st16.010</K_KSG>
    <N_KSG>Операции на периферической нервной системе (уровень 2)</N_KSG>
    <KOEF_Z>2.19</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st16.011</K_KSG>
    <N_KSG>Операции на периферической нервной системе (уровень 3)</N_KSG>
    <KOEF_Z>2.42</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st16.012</K_KSG>
    <N_KSG>Доброкачественные новообразования нервной системы</N_KSG>
    <KOEF_Z>1.02</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st17.001</K_KSG>
    <N_KSG>Малая масса тела при рождении, недоношенность</N_KSG>
    <KOEF_Z>4.21</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st17.002</K_KSG>
    <N_KSG>Крайне малая масса тела при рождении, крайняя незрелость</N_KSG>
    <KOEF_Z>16.02</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st17.003</K_KSG>
    <N_KSG>Лечение новорожденных с тяжелой патологией с применением аппаратных методов поддержки или замещения витальных функций</N_KSG>
    <KOEF_Z>7.40</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st17.004</K_KSG>
    <N_KSG>Геморрагические и гемолитические нарушения у новорожденных</N_KSG>
    <KOEF_Z>1.92</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st17.005</K_KSG>
    <N_KSG>Другие нарушения, возникшие в перинатальном периоде (уровень 1)</N_KSG>
    <KOEF_Z>1.39</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st17.006</K_KSG>
    <N_KSG>Другие нарушения, возникшие в перинатальном периоде (уровень 2)</N_KSG>
    <KOEF_Z>1.89</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st17.007</K_KSG>
    <N_KSG>Другие нарушения, возникшие в перинатальном периоде (уровень 3)</N_KSG>
    <KOEF_Z>2.56</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st18.001</K_KSG>
    <N_KSG>Почечная недостаточность</N_KSG>
    <KOEF_Z>1.66</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st18.002</K_KSG>
    <N_KSG>Формирование, имплантация, реконструкция, удаление, смена доступа для диализа</N_KSG>
    <KOEF_Z>1.82</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st18.003</K_KSG>
    <N_KSG>Гломерулярные болезни</N_KSG>
    <KOEF_Z>1.71</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.001</K_KSG>
    <N_KSG>Операции на женских половых органах при злокачественных новообразованиях (уровень 1)</N_KSG>
    <KOEF_Z>1.98</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.002</K_KSG>
    <N_KSG>Операции на женских половых органах при злокачественных новообразованиях (уровень 2)</N_KSG>
    <KOEF_Z>3.66</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.003</K_KSG>
    <N_KSG>Операции на женских половых органах при злокачественных новообразованиях (уровень 3)</N_KSG>
    <KOEF_Z>4.05</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.004</K_KSG>
    <N_KSG>Операции на кишечнике и анальной области при злокачественных новообразованиях (уровень 1)</N_KSG>
    <KOEF_Z>2.45</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.005</K_KSG>
    <N_KSG>Операции на кишечнике и анальной области при злокачественных новообразованиях (уровень 2)</N_KSG>
    <KOEF_Z>4.24</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.006</K_KSG>
    <N_KSG>Операции при злокачественных новообразованиях почки и мочевыделительной системы (уровень 1)</N_KSG>
    <KOEF_Z>1.40</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.007</K_KSG>
    <N_KSG>Операции при злокачественных новообразованиях почки и мочевыделительной системы (уровень 2)</N_KSG>
    <KOEF_Z>2.46</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.008</K_KSG>
    <N_KSG>Операции при злокачественных новообразованиях почки и мочевыделительной системы (уровень 3)</N_KSG>
    <KOEF_Z>3.24</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.009</K_KSG>
    <N_KSG>Операции при злокачественных новообразованиях кожи (уровень 1)</N_KSG>
    <KOEF_Z>1.09</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.010</K_KSG>
    <N_KSG>Операции при злокачественных новообразованиях кожи (уровень 2)</N_KSG>
    <KOEF_Z>1.36</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.011</K_KSG>
    <N_KSG>Операции при злокачественных новообразованиях кожи (уровень 3)</N_KSG>
    <KOEF_Z>1.41</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.012</K_KSG>
    <N_KSG>Операции при злокачественном новообразовании щитовидной железы (уровень 1)</N_KSG>
    <KOEF_Z>1.88</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.013</K_KSG>
    <N_KSG>Операции при злокачественном новообразовании щитовидной железы (уровень 2)</N_KSG>
    <KOEF_Z>1.92</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.014</K_KSG>
    <N_KSG>Мастэктомия, другие операции при злокачественном новообразовании молочной железы (уровень 1)</N_KSG>
    <KOEF_Z>2.29</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.015</K_KSG>
    <N_KSG>Мастэктомия, другие операции при злокачественном новообразовании молочной железы (уровень 2)</N_KSG>
    <KOEF_Z>3.12</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.016</K_KSG>
    <N_KSG>Операции при злокачественном новообразовании желчного пузыря, желчных протоков (уровень 1)</N_KSG>
    <KOEF_Z>1.96</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.017</K_KSG>
    <N_KSG>Операции при злокачественном новообразовании желчного пузыря, желчных протоков (уровень 2)</N_KSG>
    <KOEF_Z>2.17</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.018</K_KSG>
    <N_KSG>Операции при злокачественном новообразовании пищевода, желудка (уровень 1)</N_KSG>
    <KOEF_Z>2.02</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.019</K_KSG>
    <N_KSG>Операции при злокачественном новообразовании пищевода, желудка (уровень 2)</N_KSG>
    <KOEF_Z>2.57</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.020</K_KSG>
    <N_KSG>Операции при злокачественном новообразовании пищевода, желудка (уровень 3)</N_KSG>
    <KOEF_Z>3.14</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.021</K_KSG>
    <N_KSG>Другие операции при злокачественном новообразовании брюшной полости</N_KSG>
    <KOEF_Z>2.48</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.022</K_KSG>
    <N_KSG>Операции на органе слуха, придаточных пазухах носа и верхних дыхательных путях при злокачественных новообразованиях</N_KSG>
    <KOEF_Z>1.91</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.023</K_KSG>
    <N_KSG>Операции на нижних дыхательных путях и легочной ткани при злокачественных новообразованиях (уровень 1)</N_KSG>
    <KOEF_Z>2.88</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.024</K_KSG>
    <N_KSG>Операции на нижних дыхательных путях и легочной ткани при злокачественных новообразованиях (уровень 2)</N_KSG>
    <KOEF_Z>4.25</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.025</K_KSG>
    <N_KSG>Операции при злокачественных новообразованиях мужских половых органов (уровень 1)</N_KSG>
    <KOEF_Z>2.56</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.026</K_KSG>
    <N_KSG>Операции при злокачественных новообразованиях мужских половых органов (уровень 2)</N_KSG>
    <KOEF_Z>3.60</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.027</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях (кроме лимфоидной и кроветворной тканей), взрослые (уровень 1)</N_KSG>
    <KOEF_Z>0.57</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.028</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях (кроме лимфоидной и кроветворной тканей), взрослые (уровень 2)</N_KSG>
    <KOEF_Z>1.00</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.029</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях (кроме лимфоидной и кроветворной тканей), взрослые (уровень 3)</N_KSG>
    <KOEF_Z>1.67</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.030</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях (кроме лимфоидной и кроветворной тканей), взрослые (уровень 4)</N_KSG>
    <KOEF_Z>2.18</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.031</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях (кроме лимфоидной и кроветворной тканей), взрослые (уровень 5)</N_KSG>
    <KOEF_Z>2.69</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.032</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях (кроме лимфоидной и кроветворной тканей), взрослые (уровень 6)</N_KSG>
    <KOEF_Z>3.44</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.033</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях (кроме лимфоидной и кроветворной тканей), взрослые (уровень 7)</N_KSG>
    <KOEF_Z>4.42</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.034</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях (кроме лимфоидной и кроветворной тканей), взрослые (уровень 8)</N_KSG>
    <KOEF_Z>5.39</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.035</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях (кроме лимфоидной и кроветворной тканей), взрослые (уровень 9)</N_KSG>
    <KOEF_Z>8.65</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.036</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях (кроме лимфоидной и кроветворной тканей), взрослые (уровень 10)</N_KSG>
    <KOEF_Z>14.64</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.037</K_KSG>
    <N_KSG>Фебрильная нейтропения, агранулоцитоз вследствие проведения лекарственной терапии злокачественных новообразований (кроме лимфоидной и кроветворной тканей)</N_KSG>
    <KOEF_Z>3.02</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.038</K_KSG>
    <N_KSG>Установка, замена порт системы (катетера) для лекарственной терапии злокачественных новообразований (кроме лимфоидной и кроветворной тканей)</N_KSG>
    <KOEF_Z>1.42</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.039</K_KSG>
    <N_KSG>Лучевая терапия (уровень 1)</N_KSG>
    <KOEF_Z>1.04</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.040</K_KSG>
    <N_KSG>Лучевая терапия (уровень 2)</N_KSG>
    <KOEF_Z>1.49</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.041</K_KSG>
    <N_KSG>Лучевая терапия (уровень 3)</N_KSG>
    <KOEF_Z>4.15</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.042</K_KSG>
    <N_KSG>Лучевая терапия (уровень 4)</N_KSG>
    <KOEF_Z>4.32</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.043</K_KSG>
    <N_KSG>Лучевая терапия (уровень 5)</N_KSG>
    <KOEF_Z>4.68</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.044</K_KSG>
    <N_KSG>Лучевая терапия (уровень 6)</N_KSG>
    <KOEF_Z>7.47</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.045</K_KSG>
    <N_KSG>Лучевая терапия (уровень 7)</N_KSG>
    <KOEF_Z>8.71</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.046</K_KSG>
    <N_KSG>Лучевая терапия (уровень 8)</N_KSG>
    <KOEF_Z>9.42</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.047</K_KSG>
    <N_KSG>Лучевая терапия (уровень 9)</N_KSG>
    <KOEF_Z>12.87</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.048</K_KSG>
    <N_KSG>Лучевая терапия (уровень 10)</N_KSG>
    <KOEF_Z>19.73</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.049</K_KSG>
    <N_KSG>Лучевая терапия в сочетании с лекарственной терапией (уровень 1)</N_KSG>
    <KOEF_Z>3.85</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.050</K_KSG>
    <N_KSG>Лучевая терапия в сочетании с лекарственной терапией (уровень 2)</N_KSG>
    <KOEF_Z>9.47</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.051</K_KSG>
    <N_KSG>Лучевая терапия в сочетании с лекарственной терапией (уровень 3)</N_KSG>
    <KOEF_Z>10.95</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.052</K_KSG>
    <N_KSG>Лучевая терапия в сочетании с лекарственной терапией (уровень 4)</N_KSG>
    <KOEF_Z>13.16</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.053</K_KSG>
    <N_KSG>Лучевая терапия в сочетании с лекарственной терапией (уровень 5)</N_KSG>
    <KOEF_Z>14.63</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.054</K_KSG>
    <N_KSG>Лучевая терапия в сочетании с лекарственной терапией (уровень 6)</N_KSG>
    <KOEF_Z>19.17</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st19.055</K_KSG>
    <N_KSG>Лучевая терапия в сочетании с лекарственной терапией (уровень 7)</N_KSG>
    <KOEF_Z>31.29</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st20.001</K_KSG>
    <N_KSG>Доброкачественные новообразования, новообразования in situ уха, горла, носа, полости рта</N_KSG>
    <KOEF_Z>0.66</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st20.002</K_KSG>
    <N_KSG>Средний отит, мастоидит, нарушения вестибулярной функции</N_KSG>
    <KOEF_Z>0.47</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st20.003</K_KSG>
    <N_KSG>Другие болезни уха</N_KSG>
    <KOEF_Z>0.61</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st20.004</K_KSG>
    <N_KSG>Другие болезни и врожденные аномалии верхних дыхательных путей, симптомы и признаки, относящиеся к органам дыхания, нарушения речи</N_KSG>
    <KOEF_Z>0.71</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st20.005</K_KSG>
    <N_KSG>Операции на органе слуха, придаточных пазухах носа и верхних дыхательных путях (уровень 1)</N_KSG>
    <KOEF_Z>0.84</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st20.006</K_KSG>
    <N_KSG>Операции на органе слуха, придаточных пазухах носа и верхних дыхательных путях (уровень 2)</N_KSG>
    <KOEF_Z>0.91</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st20.007</K_KSG>
    <N_KSG>Операции на органе слуха, придаточных пазухах носа и верхних дыхательных путях (уровень 3)</N_KSG>
    <KOEF_Z>1.10</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st20.008</K_KSG>
    <N_KSG>Операции на органе слуха, придаточных пазухах носа и верхних дыхательных путях (уровень 4)</N_KSG>
    <KOEF_Z>1.35</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st20.009</K_KSG>
    <N_KSG>Операции на органе слуха, придаточных пазухах носа и верхних дыхательных путях (уровень 5)</N_KSG>
    <KOEF_Z>1.96</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st20.010</K_KSG>
    <N_KSG>Замена речевого процессора</N_KSG>
    <KOEF_Z>25.00</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st21.001</K_KSG>
    <N_KSG>Операции на органе зрения (уровень 1)</N_KSG>
    <KOEF_Z>0.49</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st21.002</K_KSG>
    <N_KSG>Операции на органе зрения (уровень 2)</N_KSG>
    <KOEF_Z>0.79</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st21.003</K_KSG>
    <N_KSG>Операции на органе зрения (уровень 3)</N_KSG>
    <KOEF_Z>1.07</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st21.004</K_KSG>
    <N_KSG>Операции на органе зрения (уровень 4)</N_KSG>
    <KOEF_Z>1.19</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st21.005</K_KSG>
    <N_KSG>Операции на органе зрения (уровень 5)</N_KSG>
    <KOEF_Z>2.11</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st21.006</K_KSG>
    <N_KSG>Операции на органе зрения (уровень 6)</N_KSG>
    <KOEF_Z>2.33</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st21.007</K_KSG>
    <N_KSG>Болезни глаза</N_KSG>
    <KOEF_Z>0.51</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st21.008</K_KSG>
    <N_KSG>Травмы глаза</N_KSG>
    <KOEF_Z>0.66</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st22.001</K_KSG>
    <N_KSG>Нарушения всасывания, дети</N_KSG>
    <KOEF_Z>1.11</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st22.002</K_KSG>
    <N_KSG>Другие болезни органов пищеварения, дети</N_KSG>
    <KOEF_Z>0.39</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st22.003</K_KSG>
    <N_KSG>Воспалительные артропатии, спондилопатии, дети</N_KSG>
    <KOEF_Z>1.85</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st22.004</K_KSG>
    <N_KSG>Врожденные аномалии головного и спинного мозга, дети</N_KSG>
    <KOEF_Z>2.12</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st23.001</K_KSG>
    <N_KSG>Другие болезни органов дыхания</N_KSG>
    <KOEF_Z>0.85</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st23.002</K_KSG>
    <N_KSG>Интерстициальные болезни легких, врожденные аномалии развития легких, бронхо-легочная дисплазия, дети</N_KSG>
    <KOEF_Z>2.48</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st23.003</K_KSG>
    <N_KSG>Доброкачественные новообразования, новообразования in situ органов дыхания, других и неуточненных органов грудной клетки</N_KSG>
    <KOEF_Z>0.91</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st23.004</K_KSG>
    <N_KSG>Пневмония, плеврит, другие болезни плевры</N_KSG>
    <KOEF_Z>1.28</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st23.005</K_KSG>
    <N_KSG>Астма, взрослые</N_KSG>
    <KOEF_Z>1.11</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st23.006</K_KSG>
    <N_KSG>Астма, дети</N_KSG>
    <KOEF_Z>1.25</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st24.001</K_KSG>
    <N_KSG>Системные поражения соединительной ткани</N_KSG>
    <KOEF_Z>1.78</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st24.002</K_KSG>
    <N_KSG>Артропатии и спондилопатии</N_KSG>
    <KOEF_Z>1.67</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st24.003</K_KSG>
    <N_KSG>Ревматические болезни сердца (уровень 1)</N_KSG>
    <KOEF_Z>0.87</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st24.004</K_KSG>
    <N_KSG>Ревматические болезни сердца (уровень 2)</N_KSG>
    <KOEF_Z>1.57</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st25.001</K_KSG>
    <N_KSG>Флебит и тромбофлебит, варикозное расширение вен нижних конечностей</N_KSG>
    <KOEF_Z>0.85</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st25.002</K_KSG>
    <N_KSG>Другие болезни, врожденные аномалии вен</N_KSG>
    <KOEF_Z>1.32</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st25.003</K_KSG>
    <N_KSG>Болезни артерий, артериол и капилляров</N_KSG>
    <KOEF_Z>1.05</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st25.004</K_KSG>
    <N_KSG>Диагностическое обследование сердечно-сосудистой системы</N_KSG>
    <KOEF_Z>1.01</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st25.005</K_KSG>
    <N_KSG>Операции на сердце и коронарных сосудах (уровень 1)</N_KSG>
    <KOEF_Z>2.11</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st25.006</K_KSG>
    <N_KSG>Операции на сердце и коронарных сосудах (уровень 2)</N_KSG>
    <KOEF_Z>3.97</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st25.007</K_KSG>
    <N_KSG>Операции на сердце и коронарных сосудах (уровень 3)</N_KSG>
    <KOEF_Z>4.31</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st25.008</K_KSG>
    <N_KSG>Операции на сосудах (уровень 1)</N_KSG>
    <KOEF_Z>1.20</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st25.009</K_KSG>
    <N_KSG>Операции на сосудах (уровень 2)</N_KSG>
    <KOEF_Z>2.37</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st25.010</K_KSG>
    <N_KSG>Операции на сосудах (уровень 3)</N_KSG>
    <KOEF_Z>4.13</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st25.011</K_KSG>
    <N_KSG>Операции на сосудах (уровень 4)</N_KSG>
    <KOEF_Z>6.08</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st25.012</K_KSG>
    <N_KSG>Операции на сосудах (уровень 5)</N_KSG>
    <KOEF_Z>7.12</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st26.001</K_KSG>
    <N_KSG>Болезни полости рта, слюнных желез и челюстей, врожденные аномалии лица и шеи, дети</N_KSG>
    <KOEF_Z>0.79</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st27.001</K_KSG>
    <N_KSG>Болезни пищевода, гастрит, дуоденит, другие болезни желудка и двенадцатиперстной кишки</N_KSG>
    <KOEF_Z>0.74</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st27.002</K_KSG>
    <N_KSG>Новообразования доброкачественные, in situ, неопределенного и неуточненного характера органов пищеварения</N_KSG>
    <KOEF_Z>0.69</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st27.003</K_KSG>
    <N_KSG>Болезни желчного пузыря</N_KSG>
    <KOEF_Z>0.72</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st27.004</K_KSG>
    <N_KSG>Другие болезни органов пищеварения, взрослые</N_KSG>
    <KOEF_Z>0.59</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st27.005</K_KSG>
    <N_KSG>Гипертоническая болезнь в стадии обострения</N_KSG>
    <KOEF_Z>0.70</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st27.006</K_KSG>
    <N_KSG>Стенокардия (кроме нестабильной), хроническая ишемическая болезнь сердца (уровень 1)</N_KSG>
    <KOEF_Z>0.78</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st27.007</K_KSG>
    <N_KSG>Стенокардия (кроме нестабильной), хроническая ишемическая болезнь сердца (уровень 2)</N_KSG>
    <KOEF_Z>1.70</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st27.008</K_KSG>
    <N_KSG>Другие болезни сердца (уровень 1)</N_KSG>
    <KOEF_Z>0.78</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st27.009</K_KSG>
    <N_KSG>Другие болезни сердца (уровень 2)</N_KSG>
    <KOEF_Z>1.54</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st27.010</K_KSG>
    <N_KSG>Бронхит необструктивный, симптомы и признаки, относящиеся к органам дыхания</N_KSG>
    <KOEF_Z>0.75</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st27.011</K_KSG>
    <N_KSG>ХОБЛ, эмфизема, бронхоэктатическая болезнь</N_KSG>
    <KOEF_Z>0.89</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st27.012</K_KSG>
    <N_KSG>Отравления и другие воздействия внешних причин</N_KSG>
    <KOEF_Z>0.53</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st27.013</K_KSG>
    <N_KSG>Отравления и другие воздействия внешних причин с синдромом органной дисфункции</N_KSG>
    <KOEF_Z>4.07</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st27.014</K_KSG>
    <N_KSG>Госпитализация в диагностических целях с постановкой/ подтверждением диагноза злокачественного новообразования</N_KSG>
    <KOEF_Z>1.00</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st28.001</K_KSG>
    <N_KSG>Гнойные состояния нижних дыхательных путей</N_KSG>
    <KOEF_Z>2.05</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st28.002</K_KSG>
    <N_KSG>Операции на нижних дыхательных путях и легочной ткани, органах средостения (уровень 1)</N_KSG>
    <KOEF_Z>1.54</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st28.003</K_KSG>
    <N_KSG>Операции на нижних дыхательных путях и легочной ткани, органах средостения (уровень 2)</N_KSG>
    <KOEF_Z>1.92</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st28.004</K_KSG>
    <N_KSG>Операции на нижних дыхательных путях и легочной ткани, органах средостения (уровень 3)</N_KSG>
    <KOEF_Z>2.56</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st28.005</K_KSG>
    <N_KSG>Операции на нижних дыхательных путях и легочной ткани, органах средостения (уровень 4)</N_KSG>
    <KOEF_Z>4.12</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st29.001</K_KSG>
    <N_KSG>Приобретенные и врожденные костно-мышечные деформации</N_KSG>
    <KOEF_Z>0.99</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st29.002</K_KSG>
    <N_KSG>Переломы шейки бедра и костей таза</N_KSG>
    <KOEF_Z>1.52</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st29.003</K_KSG>
    <N_KSG>Переломы бедренной кости, другие травмы области бедра и тазобедренного сустава</N_KSG>
    <KOEF_Z>0.69</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st29.004</K_KSG>
    <N_KSG>Переломы, вывихи, растяжения области грудной клетки, верхней конечности и стопы</N_KSG>
    <KOEF_Z>0.56</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st29.005</K_KSG>
    <N_KSG>Переломы, вывихи, растяжения области колена и голени</N_KSG>
    <KOEF_Z>0.74</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st29.006</K_KSG>
    <N_KSG>Множественные переломы, травматические ампутации, размозжения и последствия травм</N_KSG>
    <KOEF_Z>1.44</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st29.007</K_KSG>
    <N_KSG>Тяжелая множественная и сочетанная травма (политравма)</N_KSG>
    <KOEF_Z>7.07</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st29.008</K_KSG>
    <N_KSG>Эндопротезирование суставов</N_KSG>
    <KOEF_Z>4.46</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st29.009</K_KSG>
    <N_KSG>Операции на костно-мышечной системе и суставах (уровень 1)</N_KSG>
    <KOEF_Z>0.79</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st29.010</K_KSG>
    <N_KSG>Операции на костно-мышечной системе и суставах (уровень 2)</N_KSG>
    <KOEF_Z>0.93</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st29.011</K_KSG>
    <N_KSG>Операции на костно-мышечной системе и суставах (уровень 3)</N_KSG>
    <KOEF_Z>1.37</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st29.012</K_KSG>
    <N_KSG>Операции на костно-мышечной системе и суставах (уровень 4)</N_KSG>
    <KOEF_Z>2.42</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st29.013</K_KSG>
    <N_KSG>Операции на костно-мышечной системе и суставах (уровень 5)</N_KSG>
    <KOEF_Z>3.15</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st30.001</K_KSG>
    <N_KSG>Тубулоинтерстициальные болезни почек, другие болезни мочевой системы</N_KSG>
    <KOEF_Z>0.86</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st30.002</K_KSG>
    <N_KSG>Камни мочевой системы; симптомы, относящиеся к мочевой системе</N_KSG>
    <KOEF_Z>0.49</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st30.003</K_KSG>
    <N_KSG>Доброкачественные новообразования, новообразования in situ, неопределенного и неизвестного характера мочевых органов и мужских половых органов</N_KSG>
    <KOEF_Z>0.64</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st30.004</K_KSG>
    <N_KSG>Болезни предстательной железы</N_KSG>
    <KOEF_Z>0.73</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st30.005</K_KSG>
    <N_KSG>Другие болезни, врожденные аномалии, повреждения мочевой системы и мужских половых органов</N_KSG>
    <KOEF_Z>0.67</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st30.006</K_KSG>
    <N_KSG>Операции на мужских половых органах, взрослые (уровень 1)</N_KSG>
    <KOEF_Z>1.20</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st30.007</K_KSG>
    <N_KSG>Операции на мужских половых органах, взрослые (уровень 2)</N_KSG>
    <KOEF_Z>1.42</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st30.008</K_KSG>
    <N_KSG>Операции на мужских половых органах, взрослые (уровень 3)</N_KSG>
    <KOEF_Z>2.31</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st30.009</K_KSG>
    <N_KSG>Операции на мужских половых органах, взрослые (уровень 4)</N_KSG>
    <KOEF_Z>3.12</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st30.010</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, взрослые (уровень 1)</N_KSG>
    <KOEF_Z>1.08</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st30.011</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, взрослые (уровень 2)</N_KSG>
    <KOEF_Z>1.12</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st30.012</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, взрослые (уровень 3)</N_KSG>
    <KOEF_Z>1.62</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st30.013</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, взрослые (уровень 4)</N_KSG>
    <KOEF_Z>1.95</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st30.014</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, взрослые (уровень 5)</N_KSG>
    <KOEF_Z>2.14</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st30.015</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, взрослые (уровень 6)</N_KSG>
    <KOEF_Z>4.13</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st31.001</K_KSG>
    <N_KSG>Болезни лимфатических сосудов и лимфатических узлов</N_KSG>
    <KOEF_Z>0.61</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st31.002</K_KSG>
    <N_KSG>Операции на коже, подкожной клетчатке, придатках кожи (уровень 1)</N_KSG>
    <KOEF_Z>0.55</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st31.003</K_KSG>
    <N_KSG>Операции на коже, подкожной клетчатке, придатках кожи (уровень 2)</N_KSG>
    <KOEF_Z>0.71</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st31.004</K_KSG>
    <N_KSG>Операции на коже, подкожной клетчатке, придатках кожи (уровень 3)</N_KSG>
    <KOEF_Z>1.38</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st31.005</K_KSG>
    <N_KSG>Операции на коже, подкожной клетчатке, придатках кожи (уровень 4)</N_KSG>
    <KOEF_Z>2.41</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st31.006</K_KSG>
    <N_KSG>Операции на органах кроветворения и иммунной системы (уровень 1)</N_KSG>
    <KOEF_Z>1.43</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st31.007</K_KSG>
    <N_KSG>Операции на органах кроветворения и иммунной системы (уровень 2)</N_KSG>
    <KOEF_Z>1.83</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st31.008</K_KSG>
    <N_KSG>Операции на органах кроветворения и иммунной системы (уровень 3)</N_KSG>
    <KOEF_Z>2.16</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st31.009</K_KSG>
    <N_KSG>Операции на эндокринных железах кроме гипофиза (уровень 1)</N_KSG>
    <KOEF_Z>1.81</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st31.010</K_KSG>
    <N_KSG>Операции на эндокринных железах кроме гипофиза (уровень 2)</N_KSG>
    <KOEF_Z>2.67</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st31.011</K_KSG>
    <N_KSG>Болезни молочной железы, новообразования молочной железы доброкачественные, in situ, неопределенного и неизвестного характера</N_KSG>
    <KOEF_Z>0.73</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st31.012</K_KSG>
    <N_KSG>Артрозы, другие поражения суставов, болезни мягких тканей</N_KSG>
    <KOEF_Z>0.76</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st31.013</K_KSG>
    <N_KSG>Остеомиелит (уровень 1)</N_KSG>
    <KOEF_Z>2.42</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st31.014</K_KSG>
    <N_KSG>Остеомиелит (уровень 2)</N_KSG>
    <KOEF_Z>3.51</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st31.015</K_KSG>
    <N_KSG>Остеомиелит (уровень 3)</N_KSG>
    <KOEF_Z>4.02</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st31.016</K_KSG>
    <N_KSG>Доброкачественные новообразования костно-мышечной системы и соединительной ткани</N_KSG>
    <KOEF_Z>0.84</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st31.017</K_KSG>
    <N_KSG>Доброкачественные новообразования, новообразования in situ кожи, жировой ткани и другие болезни кожи</N_KSG>
    <KOEF_Z>0.50</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st31.018</K_KSG>
    <N_KSG>Открытые раны, поверхностные, другие и неуточненные травмы</N_KSG>
    <KOEF_Z>0.37</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st31.019</K_KSG>
    <N_KSG>Операции на молочной железе (кроме злокачественных новообразований)</N_KSG>
    <KOEF_Z>1.19</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st32.001</K_KSG>
    <N_KSG>Операции на желчном пузыре и желчевыводящих путях (уровень 1)</N_KSG>
    <KOEF_Z>1.15</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st32.002</K_KSG>
    <N_KSG>Операции на желчном пузыре и желчевыводящих путях (уровень 2)</N_KSG>
    <KOEF_Z>1.43</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st32.003</K_KSG>
    <N_KSG>Операции на желчном пузыре и желчевыводящих путях (уровень 3)</N_KSG>
    <KOEF_Z>3.00</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st32.004</K_KSG>
    <N_KSG>Операции на желчном пузыре и желчевыводящих путях (уровень 4)</N_KSG>
    <KOEF_Z>4.30</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st32.005</K_KSG>
    <N_KSG>Операции на печени и поджелудочной железе (уровень 1)</N_KSG>
    <KOEF_Z>2.42</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st32.006</K_KSG>
    <N_KSG>Операции на печени и поджелудочной железе (уровень 2)</N_KSG>
    <KOEF_Z>2.69</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st32.007</K_KSG>
    <N_KSG>Панкреатит, хирургическое лечение</N_KSG>
    <KOEF_Z>4.12</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st32.008</K_KSG>
    <N_KSG>Операции на пищеводе, желудке, двенадцатиперстной кишке (уровень 1)</N_KSG>
    <KOEF_Z>1.16</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st32.009</K_KSG>
    <N_KSG>Операции на пищеводе, желудке, двенадцатиперстной кишке (уровень 2)</N_KSG>
    <KOEF_Z>1.95</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st32.010</K_KSG>
    <N_KSG>Операции на пищеводе, желудке, двенадцатиперстной кишке (уровень 3)</N_KSG>
    <KOEF_Z>2.46</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st32.011</K_KSG>
    <N_KSG>Аппендэктомия, взрослые (уровень 1)</N_KSG>
    <KOEF_Z>0.73</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st32.012</K_KSG>
    <N_KSG>Аппендэктомия, взрослые (уровень 2)</N_KSG>
    <KOEF_Z>0.91</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st32.013</K_KSG>
    <N_KSG>Операции по поводу грыж, взрослые (уровень 1)</N_KSG>
    <KOEF_Z>0.86</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st32.014</K_KSG>
    <N_KSG>Операции по поводу грыж, взрослые (уровень 2)</N_KSG>
    <KOEF_Z>1.24</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st32.015</K_KSG>
    <N_KSG>Операции по поводу грыж, взрослые (уровень 3)</N_KSG>
    <KOEF_Z>1.78</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st32.016</K_KSG>
    <N_KSG>Другие операции на органах брюшной полости (уровень 1)</N_KSG>
    <KOEF_Z>1.13</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st32.017</K_KSG>
    <N_KSG>Другие операции на органах брюшной полости (уровень 2)</N_KSG>
    <KOEF_Z>1.19</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st32.018</K_KSG>
    <N_KSG>Другие операции на органах брюшной полости (уровень 3)</N_KSG>
    <KOEF_Z>2.13</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st33.001</K_KSG>
    <N_KSG>Отморожения (уровень 1)</N_KSG>
    <KOEF_Z>1.17</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st33.002</K_KSG>
    <N_KSG>Отморожения (уровень 2)</N_KSG>
    <KOEF_Z>2.91</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st33.003</K_KSG>
    <N_KSG>Ожоги (уровень 1)</N_KSG>
    <KOEF_Z>1.21</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st33.004</K_KSG>
    <N_KSG>Ожоги (уровень 2)</N_KSG>
    <KOEF_Z>2.03</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st33.005</K_KSG>
    <N_KSG>Ожоги (уровень 3)</N_KSG>
    <KOEF_Z>3.54</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st33.006</K_KSG>
    <N_KSG>Ожоги (уровень 4)</N_KSG>
    <KOEF_Z>5.20</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st33.007</K_KSG>
    <N_KSG>Ожоги (уровень 5)</N_KSG>
    <KOEF_Z>11.11</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st33.008</K_KSG>
    <N_KSG>Ожоги (уровень 4,5) с синдромом органной дисфункции</N_KSG>
    <KOEF_Z>14.07</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st34.001</K_KSG>
    <N_KSG>Болезни полости рта, слюнных желез и челюстей, врожденные аномалии лица и шеи, взрослые</N_KSG>
    <KOEF_Z>0.89</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st34.002</K_KSG>
    <N_KSG>Операции на органах полости рта (уровень 1)</N_KSG>
    <KOEF_Z>0.74</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st34.003</K_KSG>
    <N_KSG>Операции на органах полости рта (уровень 2)</N_KSG>
    <KOEF_Z>1.27</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st34.004</K_KSG>
    <N_KSG>Операции на органах полости рта (уровень 3)</N_KSG>
    <KOEF_Z>1.63</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st34.005</K_KSG>
    <N_KSG>Операции на органах полости рта (уровень 4)</N_KSG>
    <KOEF_Z>1.90</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st35.001</K_KSG>
    <N_KSG>Сахарный диабет, взрослые (уровень 1)</N_KSG>
    <KOEF_Z>1.02</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st35.002</K_KSG>
    <N_KSG>Сахарный диабет, взрослые (уровень 2)</N_KSG>
    <KOEF_Z>1.49</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st35.003</K_KSG>
    <N_KSG>Заболевания гипофиза, взрослые</N_KSG>
    <KOEF_Z>2.14</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st35.004</K_KSG>
    <N_KSG>Другие болезни эндокринной системы, взрослые (уровень 1)</N_KSG>
    <KOEF_Z>1.25</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st35.005</K_KSG>
    <N_KSG>Другие болезни эндокринной системы, взрослые (уровень 2)</N_KSG>
    <KOEF_Z>2.76</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st35.006</K_KSG>
    <N_KSG>Новообразования эндокринных желез доброкачественные, in situ, неопределенного и неизвестного характера</N_KSG>
    <KOEF_Z>0.76</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st35.007</K_KSG>
    <N_KSG>Расстройства питания</N_KSG>
    <KOEF_Z>1.06</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st35.008</K_KSG>
    <N_KSG>Другие нарушения обмена веществ</N_KSG>
    <KOEF_Z>1.16</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st35.009</K_KSG>
    <N_KSG>Кистозный фиброз</N_KSG>
    <KOEF_Z>3.32</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st36.001</K_KSG>
    <N_KSG>Комплексное лечение с применением препаратов иммуноглобулина</N_KSG>
    <KOEF_Z>4.32</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st36.002</K_KSG>
    <N_KSG>Редкие генетические заболевания</N_KSG>
    <KOEF_Z>3.50</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st36.003</K_KSG>
    <N_KSG>Лечение с применением генно-инженерных биологических препаратов и селективных иммунодепрессантов</N_KSG>
    <KOEF_Z>5.35</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st36.004</K_KSG>
    <N_KSG>Факторы, влияющие на состояние здоровья населения и обращения в учреждения здравоохранения</N_KSG>
    <KOEF_Z>0.32</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st36.005</K_KSG>
    <N_KSG>Госпитализация в диагностических целях с постановкой диагноза туберкулеза, ВИЧ-инфекции, психического заболевания</N_KSG>
    <KOEF_Z>0.46</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st36.006</K_KSG>
    <N_KSG>Отторжение, отмирание трансплантата органов и тканей</N_KSG>
    <KOEF_Z>8.40</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st36.007</K_KSG>
    <N_KSG>Установка, замена, заправка помп для лекарственных препаратов</N_KSG>
    <KOEF_Z>2.32</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st36.008</K_KSG>
    <N_KSG>Интенсивная терапия пациентов с нейрогенными нарушениями жизненно важных функций, нуждающихся в их длительном искусственном замещении</N_KSG>
    <KOEF_Z>18.15</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st36.009</K_KSG>
    <N_KSG>Реинфузия аутокрови</N_KSG>
    <KOEF_Z>2.05</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st36.010</K_KSG>
    <N_KSG>Баллонная внутриаортальная контрпульсация</N_KSG>
    <KOEF_Z>7.81</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st36.011</K_KSG>
    <N_KSG>Экстракорпоральная мембранная оксигенация</N_KSG>
    <KOEF_Z>15.57</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st36.012</K_KSG>
    <N_KSG>Злокачественное новообразование без специального противоопухолевого лечения</N_KSG>
    <KOEF_Z>0.50</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st37.001</K_KSG>
    <N_KSG>Медицинская реабилитация пациентов с заболеваниями центральной нервной системы (3 балла по ШРМ)</N_KSG>
    <KOEF_Z>1.31</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st37.002</K_KSG>
    <N_KSG>Медицинская реабилитация пациентов с заболеваниями центральной нервной системы (4 балла по ШРМ)</N_KSG>
    <KOEF_Z>1.82</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st37.003</K_KSG>
    <N_KSG>Медицинская реабилитация пациентов с заболеваниями центральной нервной системы (5 баллов по ШРМ)</N_KSG>
    <KOEF_Z>3.12</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st37.004</K_KSG>
    <N_KSG>Медицинская реабилитация пациентов с заболеваниями центральной нервной системы (6 баллов по ШРМ)</N_KSG>
    <KOEF_Z>8.60</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st37.005</K_KSG>
    <N_KSG>Медицинская реабилитация пациентов с заболеваниями опорно-двигательного аппарата и периферической нервной системы (3 балла по ШРМ)</N_KSG>
    <KOEF_Z>1.24</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st37.006</K_KSG>
    <N_KSG>Медицинская реабилитация пациентов с заболеваниями опорно-двигательного аппарата и периферической нервной системы (4 балла по ШРМ)</N_KSG>
    <KOEF_Z>1.67</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st37.007</K_KSG>
    <N_KSG>Медицинская реабилитация пациентов с заболеваниями опорно-двигательного аппарата и периферической нервной системы (5 баллов по ШРМ)</N_KSG>
    <KOEF_Z>3.03</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st37.008</K_KSG>
    <N_KSG>Медицинская кардиореабилитация (3 балла по ШРМ)</N_KSG>
    <KOEF_Z>1.02</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st37.009</K_KSG>
    <N_KSG>Медицинская кардиореабилитация (4 балла по ШРМ)</N_KSG>
    <KOEF_Z>1.38</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st37.010</K_KSG>
    <N_KSG>Медицинская кардиореабилитация (5 баллов по ШРМ)</N_KSG>
    <KOEF_Z>2.00</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st37.011</K_KSG>
    <N_KSG>Медицинская реабилитация при других соматических заболеваниях (3 балла по ШРМ)</N_KSG>
    <KOEF_Z>0.59</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st37.012</K_KSG>
    <N_KSG>Медицинская реабилитация при других соматических заболеваниях (4 балла по ШРМ)</N_KSG>
    <KOEF_Z>0.84</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st37.013</K_KSG>
    <N_KSG>Медицинская реабилитация при других соматических заболеваниях (5 баллов по ШРМ)</N_KSG>
    <KOEF_Z>1.17</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st37.014</K_KSG>
    <N_KSG>Медицинская реабилитация детей, перенесших заболевания перинатального периода</N_KSG>
    <KOEF_Z>1.50</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st37.015</K_KSG>
    <N_KSG>Медицинская реабилитация детей с нарушениями слуха без замены речевого процессора системы кохлеарной имплантации</N_KSG>
    <KOEF_Z>1.80</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st37.016</K_KSG>
    <N_KSG>Медицинская реабилитация детей с онкологическими, гематологическими и иммунологическими заболеваниями в тяжелых формах продолжительного течения</N_KSG>
    <KOEF_Z>4.81</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st37.017</K_KSG>
    <N_KSG>Медицинская реабилитация детей с поражениями центральной нервной системы</N_KSG>
    <KOEF_Z>2.75</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st37.018</K_KSG>
    <N_KSG>Медицинская реабилитация детей, после хирургической коррекции врожденных пороков развития органов и систем</N_KSG>
    <KOEF_Z>2.35</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>1</IDUMP>
    <K_KSG>st38.001</K_KSG>
    <N_KSG>Старческая астения</N_KSG>
    <KOEF_Z>1.50</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>1</K_KSG>
    <N_KSG>Осложнения беременности, родов, послеродового периода</N_KSG>
    <KOEF_Z>0.83</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>2</K_KSG>
    <N_KSG>Болезни женских половых органов</N_KSG>
    <KOEF_Z>0.66</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>3</K_KSG>
    <N_KSG>Операции на женских половых органах (уровень 1)</N_KSG>
    <KOEF_Z>0.71</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>4</K_KSG>
    <N_KSG>Операции на женских половых органах (уровень 2)</N_KSG>
    <KOEF_Z>1.06</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>5</K_KSG>
    <N_KSG>Экстракорпоральное оплодотворение</N_KSG>
    <KOEF_Z>9.83</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>6</K_KSG>
    <N_KSG>Искусственное прерывание беременности (аборт)</N_KSG>
    <KOEF_Z>0.33</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>7</K_KSG>
    <N_KSG>Аборт медикаментозный</N_KSG>
    <KOEF_Z>1.04</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>8</K_KSG>
    <N_KSG>Нарушения с вовлечением иммунного механизма</N_KSG>
    <KOEF_Z>0.98</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>9</K_KSG>
    <N_KSG>Болезни органов пищеварения, взрослые</N_KSG>
    <KOEF_Z>0.89</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>10</K_KSG>
    <N_KSG>Болезни крови</N_KSG>
    <KOEF_Z>1.17</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>11</K_KSG>
    <N_KSG>Дерматозы</N_KSG>
    <KOEF_Z>1.54</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>12</K_KSG>
    <N_KSG>Болезни системы кровообращения, дети</N_KSG>
    <KOEF_Z>0.98</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>13</K_KSG>
    <N_KSG>Лекарственная терапия при остром лейкозе, дети</N_KSG>
    <KOEF_Z>14.23</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>14</K_KSG>
    <N_KSG>Лекарственная терапия при других злокачественных новообразованиях лимфоидной и кроветворной тканей, дети</N_KSG>
    <KOEF_Z>10.34</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>15</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях других локализаций (кроме лимфоидной и кроветворной тканей), дети</N_KSG>
    <KOEF_Z>7.95</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>16</K_KSG>
    <N_KSG>Операции на мужских половых органах, дети</N_KSG>
    <KOEF_Z>1.38</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>17</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, дети</N_KSG>
    <KOEF_Z>2.09</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>18</K_KSG>
    <N_KSG>Операции по поводу грыж, дети</N_KSG>
    <KOEF_Z>1.60</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>19</K_KSG>
    <N_KSG>Сахарный диабет, дети</N_KSG>
    <KOEF_Z>1.49</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>20</K_KSG>
    <N_KSG>Другие болезни эндокринной системы, дети</N_KSG>
    <KOEF_Z>1.36</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>21</K_KSG>
    <N_KSG>Вирусный гепатит B хронический, лекарственная терапия</N_KSG>
    <KOEF_Z>2.75</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>22</K_KSG>
    <N_KSG>Вирусный гепатит C хронический, лекарственная терапия при инфицировании вирусом генотипа 2, 3</N_KSG>
    <KOEF_Z>1.10</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>23</K_KSG>
    <N_KSG>Вирусный гепатит C хронический на стадии цирроза печени, лекарственная терапия при инфицировании вирусом генотипа 2, 3</N_KSG>
    <KOEF_Z>9.00</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>24</K_KSG>
    <N_KSG>Вирусный гепатит С хронический, лекарственная терапия при инфицировании вирусом генотипа 1, 4 (уровень 1)</N_KSG>
    <KOEF_Z>4.90</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>25</K_KSG>
    <N_KSG>Вирусный гепатит С хронический, лекарственная терапия при инфицировании вирусом генотипа 1, 4 (уровень 2)</N_KSG>
    <KOEF_Z>22.20</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>26</K_KSG>
    <N_KSG>Другие вирусные гепатиты</N_KSG>
    <KOEF_Z>0.97</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>27</K_KSG>
    <N_KSG>Инфекционные и паразитарные болезни, взрослые</N_KSG>
    <KOEF_Z>1.16</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>28</K_KSG>
    <N_KSG>Инфекционные и паразитарные болезни, дети</N_KSG>
    <KOEF_Z>0.97</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>29</K_KSG>
    <N_KSG>Респираторные инфекции верхних дыхательных путей, взрослые</N_KSG>
    <KOEF_Z>0.52</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>30</K_KSG>
    <N_KSG>Респираторные инфекции верхних дыхательных путей, дети</N_KSG>
    <KOEF_Z>0.65</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>31</K_KSG>
    <N_KSG>Болезни системы кровообращения, взрослые</N_KSG>
    <KOEF_Z>0.80</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>32</K_KSG>
    <N_KSG>Болезни системы кровообращения с применением инвазивных методов</N_KSG>
    <KOEF_Z>3.39</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>33</K_KSG>
    <N_KSG>Операции на кишечнике и анальной области (уровень 1)</N_KSG>
    <KOEF_Z>1.53</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>34</K_KSG>
    <N_KSG>Операции на кишечнике и анальной области (уровень 2)</N_KSG>
    <KOEF_Z>3.17</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>35</K_KSG>
    <N_KSG>Болезни нервной системы, хромосомные аномалии</N_KSG>
    <KOEF_Z>0.98</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>36</K_KSG>
    <N_KSG>Неврологические заболевания, лечение с применением ботулотоксина</N_KSG>
    <KOEF_Z>2.79</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>37</K_KSG>
    <N_KSG>Болезни и травмы позвоночника, спинного мозга, последствия внутричерепной травмы, сотрясение головного мозга</N_KSG>
    <KOEF_Z>0.94</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>38</K_KSG>
    <N_KSG>Операции на периферической нервной системе</N_KSG>
    <KOEF_Z>2.57</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>39</K_KSG>
    <N_KSG>Нарушения, возникшие в перинатальном периоде</N_KSG>
    <KOEF_Z>1.79</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>40</K_KSG>
    <N_KSG>Гломерулярные болезни, почечная недостаточность (без диализа)</N_KSG>
    <KOEF_Z>1.60</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>41</K_KSG>
    <N_KSG>Лекарственная терапия у пациентов, получающих диализ</N_KSG>
    <KOEF_Z>3.25</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>42</K_KSG>
    <N_KSG>Формирование, имплантация, удаление, смена доступа для диализа</N_KSG>
    <KOEF_Z>3.18</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>43</K_KSG>
    <N_KSG>Другие болезни почек</N_KSG>
    <KOEF_Z>0.80</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>44</K_KSG>
    <N_KSG>Лучевая терапия (уровень 1)</N_KSG>
    <KOEF_Z>3.64</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>45</K_KSG>
    <N_KSG>Лучевая терапия (уровень 2)</N_KSG>
    <KOEF_Z>4.02</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>46</K_KSG>
    <N_KSG>Лучевая терапия (уровень 3)</N_KSG>
    <KOEF_Z>6.42</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>47</K_KSG>
    <N_KSG>Операции при злокачественных новообразованиях кожи (уровень 1)</N_KSG>
    <KOEF_Z>2.35</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>48</K_KSG>
    <N_KSG>Операции при злокачественных новообразованиях кожи (уровень 2)</N_KSG>
    <KOEF_Z>2.48</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>49</K_KSG>
    <N_KSG>Злокачественное новообразование без специального противоопухолевого лечения</N_KSG>
    <KOEF_Z>0.50</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>50</K_KSG>
    <N_KSG>Лекарственная терапия при остром лейкозе, взрослые</N_KSG>
    <KOEF_Z>7.77</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>51</K_KSG>
    <N_KSG>Лекарственная терапия при других злокачественных новообразованиях лимфоидной и кроветворной тканей, взрослые</N_KSG>
    <KOEF_Z>6.30</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>52</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях других локализаций (кроме лимфоидной и кроветворной тканей), взрослые (уровень 1), доброкачественных заболеваниях крови и пузырном заносе</N_KSG>
    <KOEF_Z>3.73</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>53</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях других локализаций (кроме лимфоидной и кроветворной тканей), взрослые (уровень 2)</N_KSG>
    <KOEF_Z>5.10</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>54</K_KSG>
    <N_KSG>Лекарственная терапия злокачественных новообразований с применением моноклональных антител, ингибиторов протеинкиназы</N_KSG>
    <KOEF_Z>14.41</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>55</K_KSG>
    <N_KSG>Болезни уха, горла, носа</N_KSG>
    <KOEF_Z>0.74</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>56</K_KSG>
    <N_KSG>Операции на органе слуха, придаточных пазухах носа и верхних дыхательных путях (уровень 1)</N_KSG>
    <KOEF_Z>1.12</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>57</K_KSG>
    <N_KSG>Операции на органе слуха, придаточных пазухах носа и верхних дыхательных путях (уровень 2)</N_KSG>
    <KOEF_Z>1.66</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>58</K_KSG>
    <N_KSG>Операции на органе слуха, придаточных пазухах носа и верхних дыхательных путях (уровень 3)</N_KSG>
    <KOEF_Z>2.00</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>59</K_KSG>
    <N_KSG>Операции на органе слуха, придаточных пазухах носа и верхних дыхательных путях (уровень 4)</N_KSG>
    <KOEF_Z>2.46</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>60</K_KSG>
    <N_KSG>Замена речевого процессора</N_KSG>
    <KOEF_Z>45.50</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>61</K_KSG>
    <N_KSG>Болезни и травмы глаза</N_KSG>
    <KOEF_Z>0.39</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>62</K_KSG>
    <N_KSG>Операции на органе зрения (уровень 1)</N_KSG>
    <KOEF_Z>0.96</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>63</K_KSG>
    <N_KSG>Операции на органе зрения (уровень 2)</N_KSG>
    <KOEF_Z>1.44</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>64</K_KSG>
    <N_KSG>Операции на органе зрения (уровень 3)</N_KSG>
    <KOEF_Z>1.95</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>65</K_KSG>
    <N_KSG>Операции на органе зрения (уровень 4)</N_KSG>
    <KOEF_Z>2.17</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>66</K_KSG>
    <N_KSG>Операции на органе зрения (уровень 5)</N_KSG>
    <KOEF_Z>3.84</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>67</K_KSG>
    <N_KSG>Системные поражения соединительной ткани, артропатии, спондилопатии, дети</N_KSG>
    <KOEF_Z>2.31</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>68</K_KSG>
    <N_KSG>Болезни органов пищеварения, дети</N_KSG>
    <KOEF_Z>0.89</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>69</K_KSG>
    <N_KSG>Болезни органов дыхания</N_KSG>
    <KOEF_Z>0.90</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>70</K_KSG>
    <N_KSG>Системные поражения соединительной ткани, артропатии, спондилопатии, взрослые</N_KSG>
    <KOEF_Z>1.46</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>71</K_KSG>
    <N_KSG>Диагностическое обследование при болезнях системы кровообращения</N_KSG>
    <KOEF_Z>1.84</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>72</K_KSG>
    <N_KSG>Операции на сосудах (уровень 1)</N_KSG>
    <KOEF_Z>2.18</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>73</K_KSG>
    <N_KSG>Операции на сосудах (уровень 2)</N_KSG>
    <KOEF_Z>4.31</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>74</K_KSG>
    <N_KSG>Болезни полости рта, слюнных желез и челюстей, врожденные аномалии лица и шеи, дети</N_KSG>
    <KOEF_Z>0.98</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>75</K_KSG>
    <N_KSG>Отравления и другие воздействия внешних причин</N_KSG>
    <KOEF_Z>0.74</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>76</K_KSG>
    <N_KSG>Операции на нижних дыхательных путях и легочной ткани, органах средостения</N_KSG>
    <KOEF_Z>1.32</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>77</K_KSG>
    <N_KSG>Операции на костно-мышечной системе и суставах (уровень 1)</N_KSG>
    <KOEF_Z>1.44</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>78</K_KSG>
    <N_KSG>Операции на костно-мышечной системе и суставах (уровень 2)</N_KSG>
    <KOEF_Z>1.69</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>79</K_KSG>
    <N_KSG>Операции на костно-мышечной системе и суставах (уровень 3)</N_KSG>
    <KOEF_Z>2.49</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>80</K_KSG>
    <N_KSG>Заболевания опорно-двигательного аппарата, травмы, болезни мягких тканей</N_KSG>
    <KOEF_Z>1.05</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>81</K_KSG>
    <N_KSG>Болезни, врожденные аномалии, повреждения мочевой системы и мужских половых органов</N_KSG>
    <KOEF_Z>0.80</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>82</K_KSG>
    <N_KSG>Операции на мужских половых органах, взрослые (уровень 1)</N_KSG>
    <KOEF_Z>2.18</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>83</K_KSG>
    <N_KSG>Операции на мужских половых органах, взрослые (уровень 2)</N_KSG>
    <KOEF_Z>2.58</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>84</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, взрослые (уровень 1)</N_KSG>
    <KOEF_Z>1.97</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>85</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, взрослые (уровень 2)</N_KSG>
    <KOEF_Z>2.04</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>86</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, взрослые (уровень 3)</N_KSG>
    <KOEF_Z>2.95</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>87</K_KSG>
    <N_KSG>Болезни, новообразования молочной железы</N_KSG>
    <KOEF_Z>0.89</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>88</K_KSG>
    <N_KSG>Операции на коже, подкожной клетчатке, придатках кожи (уровень 1)</N_KSG>
    <KOEF_Z>0.75</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>89</K_KSG>
    <N_KSG>Операции на коже, подкожной клетчатке, придатках кожи (уровень 2)</N_KSG>
    <KOEF_Z>1.00</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>90</K_KSG>
    <N_KSG>Операции на коже, подкожной клетчатке, придатках кожи (уровень 3)</N_KSG>
    <KOEF_Z>4.34</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>91</K_KSG>
    <N_KSG>Операции на органах кроветворения и иммунной системы</N_KSG>
    <KOEF_Z>1.29</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>92</K_KSG>
    <N_KSG>Операции на молочной железе</N_KSG>
    <KOEF_Z>2.60</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>93</K_KSG>
    <N_KSG>Операции на пищеводе, желудке, двенадцатиперстной кишке (уровень 1)</N_KSG>
    <KOEF_Z>2.11</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>94</K_KSG>
    <N_KSG>Операции на пищеводе, желудке, двенадцатиперстной кишке (уровень 2)</N_KSG>
    <KOEF_Z>3.55</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>95</K_KSG>
    <N_KSG>Операции по поводу грыж, взрослые (уровень 1)</N_KSG>
    <KOEF_Z>1.57</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>96</K_KSG>
    <N_KSG>Операции по поводу грыж, взрослые (уровень 2)</N_KSG>
    <KOEF_Z>2.26</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>97</K_KSG>
    <N_KSG>Операции по поводу грыж, взрослые (уровень 3)</N_KSG>
    <KOEF_Z>3.24</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>98</K_KSG>
    <N_KSG>Другие операции на органах брюшной полости (уровень 1)</N_KSG>
    <KOEF_Z>2.06</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>99</K_KSG>
    <N_KSG>Другие операции на органах брюшной полости (уровень 2)</N_KSG>
    <KOEF_Z>2.17</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>100</K_KSG>
    <N_KSG>Ожоги и отморожения</N_KSG>
    <KOEF_Z>1.10</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>101</K_KSG>
    <N_KSG>Болезни полости рта, слюнных желез и челюстей, врожденные аномалии лица и шеи, взрослые</N_KSG>
    <KOEF_Z>0.88</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>102</K_KSG>
    <N_KSG>Операции на органах полости рта (уровень 1)</N_KSG>
    <KOEF_Z>0.92</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>103</K_KSG>
    <N_KSG>Операции на органах полости рта (уровень 2)</N_KSG>
    <KOEF_Z>1.56</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>104</K_KSG>
    <N_KSG>Сахарный диабет, взрослые</N_KSG>
    <KOEF_Z>1.08</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>105</K_KSG>
    <N_KSG>Другие болезни эндокринной системы, новообразования эндокринных желез доброкачественные, in situ, неопределенного и неизвестного характера, расстройства питания, другие нарушения обмена веществ</N_KSG>
    <KOEF_Z>1.41</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>106</K_KSG>
    <N_KSG>Кистозный фиброз</N_KSG>
    <KOEF_Z>2.58</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>107</K_KSG>
    <N_KSG>Лечение кистозного фиброза с применением ингаляционной антибактериальной терапии</N_KSG>
    <KOEF_Z>12.27</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>108</K_KSG>
    <N_KSG>Комплексное лечение с применением препаратов иммуноглобулина</N_KSG>
    <KOEF_Z>7.86</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>109</K_KSG>
    <N_KSG>Факторы, влияющие на состояние здоровья населения и обращения в учреждения здравоохранения</N_KSG>
    <KOEF_Z>0.56</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>110</K_KSG>
    <N_KSG>Госпитализация в дневной стационар в диагностических целях с постановкой диагноза туберкулеза, ВИЧ-инфекции, психического заболевания</N_KSG>
    <KOEF_Z>0.46</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>111</K_KSG>
    <N_KSG>Лечение с применением генно-инженерных биологических препаратов</N_KSG>
    <KOEF_Z>9.74</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>112</K_KSG>
    <N_KSG>Отторжение, отмирание трансплантата органов и тканей</N_KSG>
    <KOEF_Z>7.40</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>113</K_KSG>
    <N_KSG>Медицинская нейрореабилитация</N_KSG>
    <KOEF_Z>3.00</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>114</K_KSG>
    <N_KSG>Медицинская кардиореабилитация</N_KSG>
    <KOEF_Z>1.50</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>115</K_KSG>
    <N_KSG>Медицинская реабилитация после перенесенных травм и заболеваний опорно-двигательной системы</N_KSG>
    <KOEF_Z>2.25</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>116</K_KSG>
    <N_KSG>Медицинская реабилитация детей, перенесших заболевания перинатального периода</N_KSG>
    <KOEF_Z>1.50</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>117</K_KSG>
    <N_KSG>Медицинская реабилитация при других соматических заболеваниях</N_KSG>
    <KOEF_Z>0.70</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>118</K_KSG>
    <N_KSG>Медицинская реабилитация детей с нарушениями слуха без замены речевого процессора системы кохлеарной имплантации</N_KSG>
    <KOEF_Z>1.80</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>119</K_KSG>
    <N_KSG>Медицинская реабилитация детей с поражениями центральной нервной системы</N_KSG>
    <KOEF_Z>2.75</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>120</K_KSG>
    <N_KSG>Медицинская реабилитация детей после хирургической коррекции врожденных пороков развития органов и систем</N_KSG>
    <KOEF_Z>2.35</KOEF_Z>
    <DATEBEG>01.01.2017</DATEBEG>
    <DATEEND>31.12.2018</DATEEND>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>1</K_KSG>
    <N_KSG>Осложнения беременности, родов, послеродового периода</N_KSG>
    <KOEF_Z>0.83</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>2</K_KSG>
    <N_KSG>Болезни женских половых органов</N_KSG>
    <KOEF_Z>0.66</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>3</K_KSG>
    <N_KSG>Операции на женских половых органах (уровень 1)</N_KSG>
    <KOEF_Z>0.71</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>4</K_KSG>
    <N_KSG>Операции на женских половых органах (уровень 2)</N_KSG>
    <KOEF_Z>1.06</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>5</K_KSG>
    <N_KSG>Экстракорпоральное оплодотворение</N_KSG>
    <KOEF_Z>9.83</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>6</K_KSG>
    <N_KSG>Искусственное прерывание беременности (аборт)</N_KSG>
    <KOEF_Z>0.33</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>7</K_KSG>
    <N_KSG>Аборт медикаментозный</N_KSG>
    <KOEF_Z>1.04</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>8</K_KSG>
    <N_KSG>Нарушения с вовлечением иммунного механизма</N_KSG>
    <KOEF_Z>0.98</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>9</K_KSG>
    <N_KSG>Болезни органов пищеварения, взрослые</N_KSG>
    <KOEF_Z>0.89</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>10</K_KSG>
    <N_KSG>Болезни крови (уровень 1)</N_KSG>
    <KOEF_Z>0.91</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>11</K_KSG>
    <N_KSG>Болезни крови (уровень 2)</N_KSG>
    <KOEF_Z>2.41</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>12</K_KSG>
    <N_KSG>Дерматозы</N_KSG>
    <KOEF_Z>1.54</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>13</K_KSG>
    <N_KSG>Болезни системы кровообращения, дети</N_KSG>
    <KOEF_Z>0.98</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>14</K_KSG>
    <N_KSG>Лекарственная терапия при остром лейкозе, дети</N_KSG>
    <KOEF_Z>14.23</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>15</K_KSG>
    <N_KSG>Лекарственная терапия при других злокачественных новообразованиях лимфоидной и кроветворной тканей, дети</N_KSG>
    <KOEF_Z>10.34</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>16</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях других локализаций (кроме лимфоидной и кроветворной тканей), дети</N_KSG>
    <KOEF_Z>7.95</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>17</K_KSG>
    <N_KSG>Операции на мужских половых органах, дети</N_KSG>
    <KOEF_Z>1.38</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>18</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, дети</N_KSG>
    <KOEF_Z>2.09</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>19</K_KSG>
    <N_KSG>Операции по поводу грыж, дети</N_KSG>
    <KOEF_Z>1.60</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>20</K_KSG>
    <N_KSG>Сахарный диабет, дети</N_KSG>
    <KOEF_Z>1.49</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>21</K_KSG>
    <N_KSG>Другие болезни эндокринной системы, дети</N_KSG>
    <KOEF_Z>1.36</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>22</K_KSG>
    <N_KSG>Вирусный гепатит B хронический, лекарственная терапия</N_KSG>
    <KOEF_Z>2.75</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>23</K_KSG>
    <N_KSG>Вирусный гепатит C хронический, лекарственная терапия при инфицировании вирусом генотипа 2, 3</N_KSG>
    <KOEF_Z>1.10</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>24</K_KSG>
    <N_KSG>Вирусный гепатит C хронический на стадии цирроза печени, лекарственная терапия при инфицировании вирусом генотипа 2, 3</N_KSG>
    <KOEF_Z>9.00</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>25</K_KSG>
    <N_KSG>Вирусный гепатит С хронический, лекарственная терапия при инфицировании вирусом генотипа 1, 4 (уровень 1)</N_KSG>
    <KOEF_Z>4.90</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>26</K_KSG>
    <N_KSG>Вирусный гепатит С хронический, лекарственная терапия при инфицировании вирусом генотипа 1, 4 (уровень 2)</N_KSG>
    <KOEF_Z>22.20</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>27</K_KSG>
    <N_KSG>Другие вирусные гепатиты</N_KSG>
    <KOEF_Z>0.97</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>28</K_KSG>
    <N_KSG>Инфекционные и паразитарные болезни, взрослые</N_KSG>
    <KOEF_Z>1.16</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>29</K_KSG>
    <N_KSG>Инфекционные и паразитарные болезни, дети</N_KSG>
    <KOEF_Z>0.97</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>30</K_KSG>
    <N_KSG>Респираторные инфекции верхних дыхательных путей, взрослые</N_KSG>
    <KOEF_Z>0.52</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>31</K_KSG>
    <N_KSG>Респираторные инфекции верхних дыхательных путей, дети</N_KSG>
    <KOEF_Z>0.65</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>32</K_KSG>
    <N_KSG>Болезни системы кровообращения, взрослые</N_KSG>
    <KOEF_Z>0.80</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>33</K_KSG>
    <N_KSG>Болезни системы кровообращения с применением инвазивных методов</N_KSG>
    <KOEF_Z>3.39</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>34</K_KSG>
    <N_KSG>Лечение наследственных атерогенных нарушений липидного обмена с применением методов афереза (липидная фильтрация, афинная и иммуносорбция липопротеидов) в случае отсутствия эффективности базисной терапии</N_KSG>
    <KOEF_Z>5.07</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>35</K_KSG>
    <N_KSG>Операции на кишечнике и анальной области (уровень 1)</N_KSG>
    <KOEF_Z>1.53</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>36</K_KSG>
    <N_KSG>Операции на кишечнике и анальной области (уровень 2)</N_KSG>
    <KOEF_Z>3.17</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>37</K_KSG>
    <N_KSG>Болезни нервной системы, хромосомные аномалии</N_KSG>
    <KOEF_Z>0.98</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>38</K_KSG>
    <N_KSG>Неврологические заболевания, лечение с применением ботулотоксина</N_KSG>
    <KOEF_Z>2.79</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>39</K_KSG>
    <N_KSG>Болезни и травмы позвоночника, спинного мозга, последствия внутричерепной травмы, сотрясение головного мозга</N_KSG>
    <KOEF_Z>0.94</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>40</K_KSG>
    <N_KSG>Операции на периферической нервной системе</N_KSG>
    <KOEF_Z>2.57</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>41</K_KSG>
    <N_KSG>Нарушения, возникшие в перинатальном периоде</N_KSG>
    <KOEF_Z>1.79</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>42</K_KSG>
    <N_KSG>Гломерулярные болезни, почечная недостаточность (без диализа)</N_KSG>
    <KOEF_Z>1.60</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>43</K_KSG>
    <N_KSG>Лекарственная терапия у пациентов, получающих диализ</N_KSG>
    <KOEF_Z>3.25</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>44</K_KSG>
    <N_KSG>Формирование, имплантация, удаление, смена доступа для диализа</N_KSG>
    <KOEF_Z>3.18</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>45</K_KSG>
    <N_KSG>Другие болезни почек</N_KSG>
    <KOEF_Z>0.80</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>46</K_KSG>
    <N_KSG>Лучевая терапия (уровень 1)</N_KSG>
    <KOEF_Z>3.64</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>47</K_KSG>
    <N_KSG>Лучевая терапия (уровень 2)</N_KSG>
    <KOEF_Z>4.02</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>48</K_KSG>
    <N_KSG>Лучевая терапия (уровень 3)</N_KSG>
    <KOEF_Z>6.42</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>49</K_KSG>
    <N_KSG>Операции при злокачественных новообразованиях кожи (уровень 1)</N_KSG>
    <KOEF_Z>2.35</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>50</K_KSG>
    <N_KSG>Операции при злокачественных новообразованиях кожи (уровень 2)</N_KSG>
    <KOEF_Z>2.48</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>51</K_KSG>
    <N_KSG>Злокачественное новообразование без специального противоопухолевого лечения</N_KSG>
    <KOEF_Z>0.40</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>52</K_KSG>
    <N_KSG>Лекарственная терапия при остром лейкозе, взрослые</N_KSG>
    <KOEF_Z>7.77</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>53</K_KSG>
    <N_KSG>Лекарственная терапия при других злокачественных новообразованиях лимфоидной и кроветворной тканей, взрослые</N_KSG>
    <KOEF_Z>6.30</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>54</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях (кроме лимфоидной и кроветворной тканей), взрослые (уровень 1)</N_KSG>
    <KOEF_Z>0.45</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>55</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях (кроме лимфоидной и кроветворной тканей), взрослые (уровень 2)</N_KSG>
    <KOEF_Z>1.20</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>56</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях (кроме лимфоидной и кроветворной тканей), взрослые (уровень 3)</N_KSG>
    <KOEF_Z>2.19</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>57</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях (кроме лимфоидной и кроветворной тканей), взрослые (уровень 4)</N_KSG>
    <KOEF_Z>3.65</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>58</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях (кроме лимфоидной и кроветворной тканей), взрослые (уровень 5)</N_KSG>
    <KOEF_Z>5.05</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>59</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях (кроме лимфоидной и кроветворной тканей), взрослые (уровень 6)</N_KSG>
    <KOEF_Z>7.06</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>60</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях (кроме лимфоидной и кроветворной тканей), взрослые (уровень 7)</N_KSG>
    <KOEF_Z>8.92</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>61</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях (кроме лимфоидной и кроветворной тканей), взрослые (уровень 8)</N_KSG>
    <KOEF_Z>18.44</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>62</K_KSG>
    <N_KSG>Лекарственная терапия при доброкачественных заболеваниях крови и пузырном заносе</N_KSG>
    <KOEF_Z>3.73</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>63</K_KSG>
    <N_KSG>Лекарственная терапия злокачественных новообразований лимфоидной и кроветворной тканей с применением моноклональных антител, ингибиторов протеинкиназы</N_KSG>
    <KOEF_Z>14.41</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>64</K_KSG>
    <N_KSG>Болезни уха, горла, носа</N_KSG>
    <KOEF_Z>0.74</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>65</K_KSG>
    <N_KSG>Операции на органе слуха, придаточных пазухах носа и верхних дыхательных путях (уровень 1)</N_KSG>
    <KOEF_Z>1.12</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>66</K_KSG>
    <N_KSG>Операции на органе слуха, придаточных пазухах носа и верхних дыхательных путях (уровень 2)</N_KSG>
    <KOEF_Z>1.66</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>67</K_KSG>
    <N_KSG>Операции на органе слуха, придаточных пазухах носа и верхних дыхательных путях (уровень 3)</N_KSG>
    <KOEF_Z>2.00</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>68</K_KSG>
    <N_KSG>Операции на органе слуха, придаточных пазухах носа и верхних дыхательных путях (уровень 4)</N_KSG>
    <KOEF_Z>2.46</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>69</K_KSG>
    <N_KSG>Замена речевого процессора</N_KSG>
    <KOEF_Z>45.50</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>70</K_KSG>
    <N_KSG>Болезни и травмы глаза</N_KSG>
    <KOEF_Z>0.39</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>71</K_KSG>
    <N_KSG>Операции на органе зрения (уровень 1)</N_KSG>
    <KOEF_Z>0.96</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>72</K_KSG>
    <N_KSG>Операции на органе зрения (уровень 2)</N_KSG>
    <KOEF_Z>1.44</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>73</K_KSG>
    <N_KSG>Операции на органе зрения (уровень 3)</N_KSG>
    <KOEF_Z>1.95</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>74</K_KSG>
    <N_KSG>Операции на органе зрения (уровень 4)</N_KSG>
    <KOEF_Z>2.17</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>75</K_KSG>
    <N_KSG>Операции на органе зрения (уровень 5)</N_KSG>
    <KOEF_Z>3.84</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>76</K_KSG>
    <N_KSG>Системные поражения соединительной ткани, артропатии, спондилопатии, дети</N_KSG>
    <KOEF_Z>2.31</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>77</K_KSG>
    <N_KSG>Болезни органов пищеварения, дети</N_KSG>
    <KOEF_Z>0.89</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>78</K_KSG>
    <N_KSG>Болезни органов дыхания</N_KSG>
    <KOEF_Z>0.90</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>79</K_KSG>
    <N_KSG>Системные поражения соединительной ткани, артропатии, спондилопатии, взрослые</N_KSG>
    <KOEF_Z>1.46</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>80</K_KSG>
    <N_KSG>Диагностическое обследование при болезнях системы кровообращения</N_KSG>
    <KOEF_Z>1.84</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>81</K_KSG>
    <N_KSG>Операции на сосудах (уровень 1)</N_KSG>
    <KOEF_Z>2.18</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>82</K_KSG>
    <N_KSG>Операции на сосудах (уровень 2)</N_KSG>
    <KOEF_Z>4.31</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>83</K_KSG>
    <N_KSG>Болезни полости рта, слюнных желез и челюстей, врожденные аномалии лица и шеи, дети</N_KSG>
    <KOEF_Z>0.98</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>84</K_KSG>
    <N_KSG>Отравления и другие воздействия внешних причин</N_KSG>
    <KOEF_Z>0.74</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>85</K_KSG>
    <N_KSG>Операции на нижних дыхательных путях и легочной ткани, органах средостения</N_KSG>
    <KOEF_Z>1.32</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>86</K_KSG>
    <N_KSG>Операции на костно-мышечной системе и суставах (уровень 1)</N_KSG>
    <KOEF_Z>1.44</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>87</K_KSG>
    <N_KSG>Операции на костно-мышечной системе и суставах (уровень 2)</N_KSG>
    <KOEF_Z>1.69</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>88</K_KSG>
    <N_KSG>Операции на костно-мышечной системе и суставах (уровень 3)</N_KSG>
    <KOEF_Z>2.49</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>89</K_KSG>
    <N_KSG>Заболевания опорно-двигательного аппарата, травмы, болезни мягких тканей</N_KSG>
    <KOEF_Z>1.05</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>90</K_KSG>
    <N_KSG>Болезни, врожденные аномалии, повреждения мочевой системы и мужских половых органов</N_KSG>
    <KOEF_Z>0.80</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>91</K_KSG>
    <N_KSG>Операции на мужских половых органах, взрослые (уровень 1)</N_KSG>
    <KOEF_Z>2.18</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>92</K_KSG>
    <N_KSG>Операции на мужских половых органах, взрослые (уровень 2)</N_KSG>
    <KOEF_Z>2.58</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>93</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, взрослые (уровень 1)</N_KSG>
    <KOEF_Z>1.97</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>94</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, взрослые (уровень 2)</N_KSG>
    <KOEF_Z>2.04</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>95</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, взрослые (уровень 3)</N_KSG>
    <KOEF_Z>2.95</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>96</K_KSG>
    <N_KSG>Болезни, новообразования молочной железы</N_KSG>
    <KOEF_Z>0.89</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>97</K_KSG>
    <N_KSG>Операции на коже, подкожной клетчатке, придатках кожи (уровень 1)</N_KSG>
    <KOEF_Z>0.75</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>98</K_KSG>
    <N_KSG>Операции на коже, подкожной клетчатке, придатках кожи (уровень 2)</N_KSG>
    <KOEF_Z>1.00</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>99</K_KSG>
    <N_KSG>Операции на коже, подкожной клетчатке, придатках кожи (уровень 3)</N_KSG>
    <KOEF_Z>4.34</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>100</K_KSG>
    <N_KSG>Операции на органах кроветворения и иммунной системы</N_KSG>
    <KOEF_Z>1.29</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>101</K_KSG>
    <N_KSG>Операции на молочной железе</N_KSG>
    <KOEF_Z>2.60</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>102</K_KSG>
    <N_KSG>Операции на пищеводе, желудке, двенадцатиперстной кишке (уровень 1)</N_KSG>
    <KOEF_Z>2.11</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>103</K_KSG>
    <N_KSG>Операции на пищеводе, желудке, двенадцатиперстной кишке (уровень 2)</N_KSG>
    <KOEF_Z>3.55</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>104</K_KSG>
    <N_KSG>Операции по поводу грыж, взрослые (уровень 1)</N_KSG>
    <KOEF_Z>1.57</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>105</K_KSG>
    <N_KSG>Операции по поводу грыж, взрослые (уровень 2)</N_KSG>
    <KOEF_Z>2.26</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>106</K_KSG>
    <N_KSG>Операции по поводу грыж, взрослые (уровень 3)</N_KSG>
    <KOEF_Z>3.24</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>107</K_KSG>
    <N_KSG>Операции на желчном пузыре и желчевыводящих путях</N_KSG>
    <KOEF_Z>1.70</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>108</K_KSG>
    <N_KSG>Другие операции на органах брюшной полости (уровень 1)</N_KSG>
    <KOEF_Z>2.06</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>109</K_KSG>
    <N_KSG>Другие операции на органах брюшной полости (уровень 2)</N_KSG>
    <KOEF_Z>2.17</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>110</K_KSG>
    <N_KSG>Ожоги и отморожения</N_KSG>
    <KOEF_Z>1.10</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>111</K_KSG>
    <N_KSG>Болезни полости рта, слюнных желез и челюстей, врожденные аномалии лица и шеи, взрослые</N_KSG>
    <KOEF_Z>0.88</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>112</K_KSG>
    <N_KSG>Операции на органах полости рта (уровень 1)</N_KSG>
    <KOEF_Z>0.92</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>113</K_KSG>
    <N_KSG>Операции на органах полости рта (уровень 2)</N_KSG>
    <KOEF_Z>1.56</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>114</K_KSG>
    <N_KSG>Сахарный диабет, взрослые</N_KSG>
    <KOEF_Z>1.08</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>115</K_KSG>
    <N_KSG>Другие болезни эндокринной системы, новообразования эндокринных желез доброкачественные, in situ, неопределенного и неизвестного характера, расстройства питания, другие нарушения обмена веществ</N_KSG>
    <KOEF_Z>1.41</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>116</K_KSG>
    <N_KSG>Кистозный фиброз</N_KSG>
    <KOEF_Z>2.58</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>117</K_KSG>
    <N_KSG>Лечение кистозного фиброза с применением ингаляционной антибактериальной терапии</N_KSG>
    <KOEF_Z>12.27</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>118</K_KSG>
    <N_KSG>Комплексное лечение с применением препаратов иммуноглобулина</N_KSG>
    <KOEF_Z>7.86</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>119</K_KSG>
    <N_KSG>Факторы, влияющие на состояние здоровья населения и обращения в учреждения здравоохранения</N_KSG>
    <KOEF_Z>0.56</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>120</K_KSG>
    <N_KSG>Госпитализация в дневной стационар в диагностических целях с постановкой диагноза туберкулеза, ВИЧ-инфекции, психического заболевания</N_KSG>
    <KOEF_Z>0.46</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>121</K_KSG>
    <N_KSG>Лечение с применением генно-инженерных биологических препаратов</N_KSG>
    <KOEF_Z>9.74</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>122</K_KSG>
    <N_KSG>Отторжение, отмирание трансплантата органов и тканей</N_KSG>
    <KOEF_Z>7.40</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>123</K_KSG>
    <N_KSG>Медицинская реабилитация пациентов с заболеваниями центральной нервной системы (2 балла по ШРМ)</N_KSG>
    <KOEF_Z>1.61</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>124</K_KSG>
    <N_KSG>Медицинская реабилитация пациентов с заболеваниями центральной нервной системы (3 балла по ШРМ)</N_KSG>
    <KOEF_Z>1.94</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>125</K_KSG>
    <N_KSG>Медицинская реабилитация пациентов с заболеваниями опорно-двигательного аппарата и периферической нервной системы (2 балла по ШРМ)</N_KSG>
    <KOEF_Z>1.52</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>126</K_KSG>
    <N_KSG>Медицинская реабилитация пациентов с заболеваниями опорно-двигательного аппарата и периферической нервной системы (3 балла по ШРМ)</N_KSG>
    <KOEF_Z>1.82</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>127</K_KSG>
    <N_KSG>Медицинская кардиореабилитация (2 балла по ШРМ)</N_KSG>
    <KOEF_Z>1.39</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>128</K_KSG>
    <N_KSG>Медицинская кардиореабилитация (3 балла по ШРМ)</N_KSG>
    <KOEF_Z>1.67</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>129</K_KSG>
    <N_KSG>Медицинская реабилитация при других соматических заболеваниях (2 балла по ШРМ)</N_KSG>
    <KOEF_Z>0.85</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>130</K_KSG>
    <N_KSG>Медицинская реабилитация при других соматических заболеваниях (3 балла по ШРМ)</N_KSG>
    <KOEF_Z>1.09</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>131</K_KSG>
    <N_KSG>Медицинская реабилитация детей, перенесших заболевания перинатального периода</N_KSG>
    <KOEF_Z>1.50</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>132</K_KSG>
    <N_KSG>Медицинская реабилитация детей с нарушениями слуха без замены речевого процессора системы кохлеарной имплантации</N_KSG>
    <KOEF_Z>1.80</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>133</K_KSG>
    <N_KSG>Медицинская реабилитация детей с поражениями центральной нервной системы</N_KSG>
    <KOEF_Z>2.75</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>134</K_KSG>
    <N_KSG>Медицинская реабилитация детей после хирургической коррекции врожденных пороков развития органов и систем</N_KSG>
    <KOEF_Z>2.35</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>123</K_KSG>
    <N_KSG>Медицинская реабилитация пациентов с заболеваниями центральной нервной системы (2 балла по ШРМ)</N_KSG>
    <KOEF_Z>1.56</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>124</K_KSG>
    <N_KSG>Медицинская реабилитация пациентов с заболеваниями центральной нервной системы (3 балла по ШРМ)</N_KSG>
    <KOEF_Z>1.95</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>125</K_KSG>
    <N_KSG>Медицинская реабилитация пациентов с заболеваниями опорно-двигательного аппарата и периферической нервной системы (2 балла по ШРМ)</N_KSG>
    <KOEF_Z>1.30</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>126</K_KSG>
    <N_KSG>Медицинская реабилитация пациентов с заболеваниями опорно-двигательного аппарата и периферической нервной системы (3 балла по ШРМ)</N_KSG>
    <KOEF_Z>1.63</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>127</K_KSG>
    <N_KSG>Медицинская реабилитация пациентов с соматическими заболеваниями (2 балла по ШРМ)</N_KSG>
    <KOEF_Z>0.53</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>128</K_KSG>
    <N_KSG>Медицинская реабилитация пациентов с соматическими заболеваниями (3 балла по ШРМ)</N_KSG>
    <KOEF_Z>0.66</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>129</K_KSG>
    <N_KSG>Медицинская реабилитация детей, перенесших заболевания перинатального периода</N_KSG>
    <KOEF_Z>1.50</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>130</K_KSG>
    <N_KSG>Медицинская реабилитация детей с нарушениями слуха без замены речевого процессора системы кохлеарной имплантации</N_KSG>
    <KOEF_Z>1.80</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>131</K_KSG>
    <N_KSG>Медицинская реабилитация детей с поражениями центральной нервной системы</N_KSG>
    <KOEF_Z>2.75</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>132</K_KSG>
    <N_KSG>Медицинская реабилитация детей после хирургической коррекции врожденных пороков развития органов и систем</N_KSG>
    <KOEF_Z>2.35</KOEF_Z>
    <DATEBEG>01.01.2018</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds02.001</K_KSG>
    <N_KSG>Осложнения беременности, родов, послеродового периода</N_KSG>
    <KOEF_Z>0.83</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds02.002</K_KSG>
    <N_KSG>Болезни женских половых органов</N_KSG>
    <KOEF_Z>0.66</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds02.003</K_KSG>
    <N_KSG>Операции на женских половых органах (уровень 1)</N_KSG>
    <KOEF_Z>0.71</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds02.004</K_KSG>
    <N_KSG>Операции на женских половых органах (уровень 2)</N_KSG>
    <KOEF_Z>1.06</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds02.005</K_KSG>
    <N_KSG>Экстракорпоральное оплодотворение</N_KSG>
    <KOEF_Z>9.79</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds02.006</K_KSG>
    <N_KSG>Искусственное прерывание беременности (аборт)</N_KSG>
    <KOEF_Z>0.33</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds02.007</K_KSG>
    <N_KSG>Аборт медикаментозный</N_KSG>
    <KOEF_Z>1.04</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds03.001</K_KSG>
    <N_KSG>Нарушения с вовлечением иммунного механизма</N_KSG>
    <KOEF_Z>0.98</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds04.001</K_KSG>
    <N_KSG>Болезни органов пищеварения, взрослые</N_KSG>
    <KOEF_Z>0.89</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds05.001</K_KSG>
    <N_KSG>Болезни крови (уровень 1)</N_KSG>
    <KOEF_Z>0.91</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds05.002</K_KSG>
    <N_KSG>Болезни крови (уровень 2)</N_KSG>
    <KOEF_Z>2.41</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds05.003</K_KSG>
    <N_KSG>Лекарственная терапия при остром лейкозе, взрослые</N_KSG>
    <KOEF_Z>7.77</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds05.004</K_KSG>
    <N_KSG>Лекарственная терапия при других злокачественных новообразованиях лимфоидной и кроветворной тканей, взрослые</N_KSG>
    <KOEF_Z>6.30</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds05.005</K_KSG>
    <N_KSG>Лекарственная терапия при доброкачественных заболеваниях крови и пузырном заносе</N_KSG>
    <KOEF_Z>3.73</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds05.006</K_KSG>
    <N_KSG>Лекарственная терапия злокачественных новообразований лимфоидной и кроветворной тканей с применением моноклональных антител, ингибиторов протеинкиназы</N_KSG>
    <KOEF_Z>14.41</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds05.007</K_KSG>
    <N_KSG>Лекарственная терапия при остром лейкозе, дети</N_KSG>
    <KOEF_Z>14.23</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds05.008</K_KSG>
    <N_KSG>Лекарственная терапия при других злокачественных новообразованиях лимфоидной и кроветворной тканей, дети</N_KSG>
    <KOEF_Z>10.34</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds06.001</K_KSG>
    <N_KSG>Дерматозы</N_KSG>
    <KOEF_Z>1.54</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds07.001</K_KSG>
    <N_KSG>Болезни системы кровообращения, дети</N_KSG>
    <KOEF_Z>0.98</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds08.001</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях других локализаций (кроме лимфоидной и кроветворной тканей), дети</N_KSG>
    <KOEF_Z>7.95</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds09.001</K_KSG>
    <N_KSG>Операции на мужских половых органах, дети</N_KSG>
    <KOEF_Z>1.38</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds09.002</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, дети</N_KSG>
    <KOEF_Z>2.09</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds10.001</K_KSG>
    <N_KSG>Операции по поводу грыж, дети</N_KSG>
    <KOEF_Z>1.60</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds11.001</K_KSG>
    <N_KSG>Сахарный диабет, дети</N_KSG>
    <KOEF_Z>1.49</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds11.002</K_KSG>
    <N_KSG>Другие болезни эндокринной системы, дети</N_KSG>
    <KOEF_Z>1.36</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds12.001</K_KSG>
    <N_KSG>Вирусный гепатит B хронический, лекарственная терапия</N_KSG>
    <KOEF_Z>2.75</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds12.002</K_KSG>
    <N_KSG>Вирусный гепатит C хронический, лекарственная терапия (уровень 1)</N_KSG>
    <KOEF_Z>1.10</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds12.003</K_KSG>
    <N_KSG>Вирусный гепатит C хронический, лекарственная терапия (уровень 2)</N_KSG>
    <KOEF_Z>4.90</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds12.004</K_KSG>
    <N_KSG>Вирусный гепатит C хронический, лекарственная терапия (уровень 3)</N_KSG>
    <KOEF_Z>22.20</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds12.005</K_KSG>
    <N_KSG>Другие вирусные гепатиты</N_KSG>
    <KOEF_Z>0.97</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds12.006</K_KSG>
    <N_KSG>Инфекционные и паразитарные болезни, взрослые</N_KSG>
    <KOEF_Z>1.16</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds12.007</K_KSG>
    <N_KSG>Инфекционные и паразитарные болезни, дети</N_KSG>
    <KOEF_Z>0.97</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds12.008</K_KSG>
    <N_KSG>Респираторные инфекции верхних дыхательных путей, взрослые</N_KSG>
    <KOEF_Z>0.52</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds12.009</K_KSG>
    <N_KSG>Респираторные инфекции верхних дыхательных путей, дети</N_KSG>
    <KOEF_Z>0.65</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds13.001</K_KSG>
    <N_KSG>Болезни системы кровообращения, взрослые</N_KSG>
    <KOEF_Z>0.80</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds13.002</K_KSG>
    <N_KSG>Болезни системы кровообращения с применением инвазивных методов</N_KSG>
    <KOEF_Z>3.39</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds13.003</K_KSG>
    <N_KSG>Лечение наследственных атерогенных нарушений липидного обмена с применением методов афереза (липидная фильтрация, афинная и иммуносорбция липопротеидов) в случае отсутствия эффективности базисной терапии</N_KSG>
    <KOEF_Z>5.07</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds14.001</K_KSG>
    <N_KSG>Операции на кишечнике и анальной области (уровень 1)</N_KSG>
    <KOEF_Z>1.53</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds14.002</K_KSG>
    <N_KSG>Операции на кишечнике и анальной области (уровень 2)</N_KSG>
    <KOEF_Z>3.17</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds15.001</K_KSG>
    <N_KSG>Болезни нервной системы, хромосомные аномалии</N_KSG>
    <KOEF_Z>0.98</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds15.002</K_KSG>
    <N_KSG>Неврологические заболевания, лечение с применением ботулотоксина (уровень 1)</N_KSG>
    <KOEF_Z>1.75</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds15.003</K_KSG>
    <N_KSG>Неврологические заболевания, лечение с применением ботулотоксина (уровень 2)</N_KSG>
    <KOEF_Z>2.89</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds16.001</K_KSG>
    <N_KSG>Болезни и травмы позвоночника, спинного мозга, последствия внутричерепной травмы, сотрясение головного мозга</N_KSG>
    <KOEF_Z>0.94</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds16.002</K_KSG>
    <N_KSG>Операции на периферической нервной системе</N_KSG>
    <KOEF_Z>2.57</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds17.001</K_KSG>
    <N_KSG>Нарушения, возникшие в перинатальном периоде</N_KSG>
    <KOEF_Z>1.79</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds18.001</K_KSG>
    <N_KSG>Гломерулярные болезни, почечная недостаточность (без диализа)</N_KSG>
    <KOEF_Z>1.60</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds18.002</K_KSG>
    <N_KSG>Лекарственная терапия у пациентов, получающих диализ</N_KSG>
    <KOEF_Z>3.25</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds18.003</K_KSG>
    <N_KSG>Формирование, имплантация, удаление, смена доступа для диализа</N_KSG>
    <KOEF_Z>3.18</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds18.004</K_KSG>
    <N_KSG>Другие болезни почек</N_KSG>
    <KOEF_Z>0.80</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds19.001</K_KSG>
    <N_KSG>Лучевая терапия (уровень 1)</N_KSG>
    <KOEF_Z>1.06</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds19.002</K_KSG>
    <N_KSG>Лучевая терапия (уровень 2)</N_KSG>
    <KOEF_Z>1.83</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds19.003</K_KSG>
    <N_KSG>Лучевая терапия (уровень 3)</N_KSG>
    <KOEF_Z>2.31</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds19.004</K_KSG>
    <N_KSG>Лучевая терапия (уровень 4)</N_KSG>
    <KOEF_Z>2.84</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds19.005</K_KSG>
    <N_KSG>Лучевая терапия (уровень 5)</N_KSG>
    <KOEF_Z>4.16</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds19.006</K_KSG>
    <N_KSG>Лучевая терапия (уровень 6)</N_KSG>
    <KOEF_Z>4.50</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds19.007</K_KSG>
    <N_KSG>Лучевая терапия (уровень 7)</N_KSG>
    <KOEF_Z>6.31</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds19.008</K_KSG>
    <N_KSG>Лучевая терапия (уровень 8)</N_KSG>
    <KOEF_Z>11.19</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds19.009</K_KSG>
    <N_KSG>Лучевая терапия (уровень 9)</N_KSG>
    <KOEF_Z>15.29</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds19.010</K_KSG>
    <N_KSG>Лучевая терапия (уровень 10)</N_KSG>
    <KOEF_Z>17.42</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds19.011</K_KSG>
    <N_KSG>Лучевая терапия в сочетании с лекарственной терапией (уровень 1)</N_KSG>
    <KOEF_Z>3.92</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds19.012</K_KSG>
    <N_KSG>Лучевая терапия в сочетании с лекарственной терапией (уровень 2)</N_KSG>
    <KOEF_Z>7.49</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds19.013</K_KSG>
    <N_KSG>Лучевая терапия в сочетании с лекарственной терапией (уровень 3)</N_KSG>
    <KOEF_Z>13.98</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds19.014</K_KSG>
    <N_KSG>Лучевая терапия в сочетании с лекарственной терапией (уровень 4)</N_KSG>
    <KOEF_Z>25.11</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds19.015</K_KSG>
    <N_KSG>Лучевая терапия в сочетании с лекарственной терапией (уровень 5)</N_KSG>
    <KOEF_Z>44.65</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds19.016</K_KSG>
    <N_KSG>Операции при злокачественных новообразованиях кожи (уровень 1)</N_KSG>
    <KOEF_Z>2.35</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds19.017</K_KSG>
    <N_KSG>Операции при злокачественных новообразованиях кожи (уровень 2)</N_KSG>
    <KOEF_Z>2.48</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds19.018</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях (кроме лимфоидной и кроветворной тканей), взрослые (уровень 1)</N_KSG>
    <KOEF_Z>0.76</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds19.019</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях (кроме лимфоидной и кроветворной тканей), взрослые (уровень 2)</N_KSG>
    <KOEF_Z>1.06</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds19.020</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях (кроме лимфоидной и кроветворной тканей), взрослые (уровень 3)</N_KSG>
    <KOEF_Z>1.51</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds19.021</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях (кроме лимфоидной и кроветворной тканей), взрослые (уровень 4)</N_KSG>
    <KOEF_Z>2.40</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds19.022</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях (кроме лимфоидной и кроветворной тканей), взрослые (уровень 5)</N_KSG>
    <KOEF_Z>4.26</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds19.023</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях (кроме лимфоидной и кроветворной тканей), взрослые (уровень 6)</N_KSG>
    <KOEF_Z>7.09</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds19.024</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях (кроме лимфоидной и кроветворной тканей), взрослые (уровень 7)</N_KSG>
    <KOEF_Z>9.46</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds19.025</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях (кроме лимфоидной и кроветворной тканей), взрослые (уровень 8)</N_KSG>
    <KOEF_Z>14.57</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds19.026</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях (кроме лимфоидной и кроветворной тканей), взрослые (уровень 9)</N_KSG>
    <KOEF_Z>20.01</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds19.027</K_KSG>
    <N_KSG>Лекарственная терапия при злокачественных новообразованиях (кроме лимфоидной и кроветворной тканей), взрослые (уровень 10)</N_KSG>
    <KOEF_Z>38.10</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds19.028</K_KSG>
    <N_KSG>Установка, замена порт системы (катетера) для лекарственной терапии злокачественных новообразований (кроме лимфоидной и кроветворной тканей)</N_KSG>
    <KOEF_Z>2.40</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds19.029</K_KSG>
    <N_KSG>Госпитализация в диагностических целях с постановкой/ подтверждением диагноза злокачественного новообразования с использованием ПЭТ КТ</N_KSG>
    <KOEF_Z>2.65</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds20.001</K_KSG>
    <N_KSG>Болезни уха, горла, носа</N_KSG>
    <KOEF_Z>0.74</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds20.002</K_KSG>
    <N_KSG>Операции на органе слуха, придаточных пазухах носа и верхних дыхательных путях (уровень 1)</N_KSG>
    <KOEF_Z>1.12</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds20.003</K_KSG>
    <N_KSG>Операции на органе слуха, придаточных пазухах носа и верхних дыхательных путях (уровень 2)</N_KSG>
    <KOEF_Z>1.66</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds20.004</K_KSG>
    <N_KSG>Операции на органе слуха, придаточных пазухах носа и верхних дыхательных путях (уровень 3)</N_KSG>
    <KOEF_Z>2.00</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds20.005</K_KSG>
    <N_KSG>Операции на органе слуха, придаточных пазухах носа и верхних дыхательных путях (уровень 4)</N_KSG>
    <KOEF_Z>2.46</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds20.006</K_KSG>
    <N_KSG>Замена речевого процессора</N_KSG>
    <KOEF_Z>45.50</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds21.001</K_KSG>
    <N_KSG>Болезни и травмы глаза</N_KSG>
    <KOEF_Z>0.39</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds21.002</K_KSG>
    <N_KSG>Операции на органе зрения (уровень 1)</N_KSG>
    <KOEF_Z>0.96</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds21.003</K_KSG>
    <N_KSG>Операции на органе зрения (уровень 2)</N_KSG>
    <KOEF_Z>1.44</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds21.004</K_KSG>
    <N_KSG>Операции на органе зрения (уровень 3)</N_KSG>
    <KOEF_Z>1.95</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds21.005</K_KSG>
    <N_KSG>Операции на органе зрения (уровень 4)</N_KSG>
    <KOEF_Z>2.17</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds21.006</K_KSG>
    <N_KSG>Операции на органе зрения (уровень 5)</N_KSG>
    <KOEF_Z>3.84</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds22.001</K_KSG>
    <N_KSG>Системные поражения соединительной ткани, артропатии, спондилопатии, дети</N_KSG>
    <KOEF_Z>2.31</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds22.002</K_KSG>
    <N_KSG>Болезни органов пищеварения, дети</N_KSG>
    <KOEF_Z>0.89</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds23.001</K_KSG>
    <N_KSG>Болезни органов дыхания</N_KSG>
    <KOEF_Z>0.90</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds24.001</K_KSG>
    <N_KSG>Системные поражения соединительной ткани, артропатии, спондилопатии, взрослые</N_KSG>
    <KOEF_Z>1.46</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds25.001</K_KSG>
    <N_KSG>Диагностическое обследование при болезнях системы кровообращения</N_KSG>
    <KOEF_Z>1.84</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds25.002</K_KSG>
    <N_KSG>Операции на сосудах (уровень 1)</N_KSG>
    <KOEF_Z>2.18</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds25.003</K_KSG>
    <N_KSG>Операции на сосудах (уровень 2)</N_KSG>
    <KOEF_Z>4.31</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds26.001</K_KSG>
    <N_KSG>Болезни полости рта, слюнных желез и челюстей, врожденные аномалии лица и шеи, дети</N_KSG>
    <KOEF_Z>0.98</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds27.001</K_KSG>
    <N_KSG>Отравления и другие воздействия внешних причин</N_KSG>
    <KOEF_Z>0.74</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds28.001</K_KSG>
    <N_KSG>Операции на нижних дыхательных путях и легочной ткани, органах средостения</N_KSG>
    <KOEF_Z>1.32</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds29.001</K_KSG>
    <N_KSG>Операции на костно-мышечной системе и суставах (уровень 1)</N_KSG>
    <KOEF_Z>1.44</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds29.002</K_KSG>
    <N_KSG>Операции на костно-мышечной системе и суставах (уровень 2)</N_KSG>
    <KOEF_Z>1.69</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds29.003</K_KSG>
    <N_KSG>Операции на костно-мышечной системе и суставах (уровень 3)</N_KSG>
    <KOEF_Z>2.49</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds29.004</K_KSG>
    <N_KSG>Заболевания опорно-двигательного аппарата, травмы, болезни мягких тканей</N_KSG>
    <KOEF_Z>1.05</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds30.001</K_KSG>
    <N_KSG>Болезни, врожденные аномалии, повреждения мочевой системы и мужских половых органов</N_KSG>
    <KOEF_Z>0.80</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds30.002</K_KSG>
    <N_KSG>Операции на мужских половых органах, взрослые (уровень 1)</N_KSG>
    <KOEF_Z>2.18</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds30.003</K_KSG>
    <N_KSG>Операции на мужских половых органах, взрослые (уровень 2)</N_KSG>
    <KOEF_Z>2.58</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds30.004</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, взрослые (уровень 1)</N_KSG>
    <KOEF_Z>1.97</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds30.005</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, взрослые (уровень 2)</N_KSG>
    <KOEF_Z>2.04</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds30.006</K_KSG>
    <N_KSG>Операции на почке и мочевыделительной системе, взрослые (уровень 3)</N_KSG>
    <KOEF_Z>2.95</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds31.001</K_KSG>
    <N_KSG>Болезни, новообразования молочной железы</N_KSG>
    <KOEF_Z>0.89</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds31.002</K_KSG>
    <N_KSG>Операции на коже, подкожной клетчатке, придатках кожи (уровень 1)</N_KSG>
    <KOEF_Z>0.75</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds31.003</K_KSG>
    <N_KSG>Операции на коже, подкожной клетчатке, придатках кожи (уровень 2)</N_KSG>
    <KOEF_Z>1.00</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds31.004</K_KSG>
    <N_KSG>Операции на коже, подкожной клетчатке, придатках кожи (уровень 3)</N_KSG>
    <KOEF_Z>4.34</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds31.005</K_KSG>
    <N_KSG>Операции на органах кроветворения и иммунной системы</N_KSG>
    <KOEF_Z>1.29</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds31.006</K_KSG>
    <N_KSG>Операции на молочной железе</N_KSG>
    <KOEF_Z>2.60</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds32.001</K_KSG>
    <N_KSG>Операции на пищеводе, желудке, двенадцатиперстной кишке (уровень 1)</N_KSG>
    <KOEF_Z>2.11</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds32.002</K_KSG>
    <N_KSG>Операции на пищеводе, желудке, двенадцатиперстной кишке (уровень 2)</N_KSG>
    <KOEF_Z>3.55</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds32.003</K_KSG>
    <N_KSG>Операции по поводу грыж, взрослые (уровень 1)</N_KSG>
    <KOEF_Z>1.57</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds32.004</K_KSG>
    <N_KSG>Операции по поводу грыж, взрослые (уровень 2)</N_KSG>
    <KOEF_Z>2.26</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds32.005</K_KSG>
    <N_KSG>Операции по поводу грыж, взрослые (уровень 3)</N_KSG>
    <KOEF_Z>3.24</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds32.006</K_KSG>
    <N_KSG>Операции на желчном пузыре и желчевыводящих путях</N_KSG>
    <KOEF_Z>1.70</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds32.007</K_KSG>
    <N_KSG>Другие операции на органах брюшной полости (уровень 1)</N_KSG>
    <KOEF_Z>2.06</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds32.008</K_KSG>
    <N_KSG>Другие операции на органах брюшной полости (уровень 2)</N_KSG>
    <KOEF_Z>2.17</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds33.001</K_KSG>
    <N_KSG>Ожоги и отморожения</N_KSG>
    <KOEF_Z>1.10</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds34.001</K_KSG>
    <N_KSG>Болезни полости рта, слюнных желез и челюстей, врожденные аномалии лица и шеи, взрослые</N_KSG>
    <KOEF_Z>0.88</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds34.002</K_KSG>
    <N_KSG>Операции на органах полости рта (уровень 1)</N_KSG>
    <KOEF_Z>0.92</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds34.003</K_KSG>
    <N_KSG>Операции на органах полости рта (уровень 2)</N_KSG>
    <KOEF_Z>1.56</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds35.001</K_KSG>
    <N_KSG>Сахарный диабет, взрослые</N_KSG>
    <KOEF_Z>1.08</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds35.002</K_KSG>
    <N_KSG>Другие болезни эндокринной системы, новообразования эндокринных желез доброкачественные, in situ, неопределенного и неизвестного характера, расстройства питания, другие нарушения обмена веществ</N_KSG>
    <KOEF_Z>1.41</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds35.003</K_KSG>
    <N_KSG>Кистозный фиброз</N_KSG>
    <KOEF_Z>2.58</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds35.004</K_KSG>
    <N_KSG>Лечение кистозного фиброза с применением ингаляционной антибактериальной терапии</N_KSG>
    <KOEF_Z>12.27</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds36.001</K_KSG>
    <N_KSG>Комплексное лечение с применением препаратов иммуноглобулина</N_KSG>
    <KOEF_Z>7.86</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds36.002</K_KSG>
    <N_KSG>Факторы, влияющие на состояние здоровья населения и обращения в учреждения здравоохранения</N_KSG>
    <KOEF_Z>0.56</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds36.003</K_KSG>
    <N_KSG>Госпитализация в дневной стационар в диагностических целях с постановкой диагноза туберкулеза, ВИЧ-инфекции, психического заболевания</N_KSG>
    <KOEF_Z>0.46</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds36.004</K_KSG>
    <N_KSG>Лечение с применением генно-инженерных биологических препаратов и селективных иммунодепрессантов</N_KSG>
    <KOEF_Z>9.74</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds36.005</K_KSG>
    <N_KSG>Отторжение, отмирание трансплантата органов и тканей</N_KSG>
    <KOEF_Z>7.40</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds36.006</K_KSG>
    <N_KSG>Злокачественное новообразование без специального противоопухолевого лечения</N_KSG>
    <KOEF_Z>0.40</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds37.001</K_KSG>
    <N_KSG>Медицинская реабилитация пациентов с заболеваниями центральной нервной системы (2 балла по ШРМ)</N_KSG>
    <KOEF_Z>1.61</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds37.002</K_KSG>
    <N_KSG>Медицинская реабилитация пациентов с заболеваниями центральной нервной системы (3 балла по ШРМ)</N_KSG>
    <KOEF_Z>1.94</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds37.003</K_KSG>
    <N_KSG>Медицинская реабилитация пациентов с заболеваниями опорно-двигательного аппарата и периферической нервной системы (2 балла по ШРМ)</N_KSG>
    <KOEF_Z>1.52</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds37.004</K_KSG>
    <N_KSG>Медицинская реабилитация пациентов с заболеваниями опорно-двигательного аппарата и периферической нервной системы (3 балла по ШРМ)</N_KSG>
    <KOEF_Z>1.82</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds37.005</K_KSG>
    <N_KSG>Медицинская кардиореабилитация (2 балла по ШРМ)</N_KSG>
    <KOEF_Z>1.39</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds37.006</K_KSG>
    <N_KSG>Медицинская кардиореабилитация (3 балла по ШРМ)</N_KSG>
    <KOEF_Z>1.67</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds37.007</K_KSG>
    <N_KSG>Медицинская реабилитация при других соматических заболеваниях (2 балла по ШРМ)</N_KSG>
    <KOEF_Z>0.85</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds37.008</K_KSG>
    <N_KSG>Медицинская реабилитация при других соматических заболеваниях (3 балла по ШРМ)</N_KSG>
    <KOEF_Z>1.09</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds37.009</K_KSG>
    <N_KSG>Медицинская реабилитация детей, перенесших заболевания перинатального периода</N_KSG>
    <KOEF_Z>1.50</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds37.010</K_KSG>
    <N_KSG>Медицинская реабилитация детей с нарушениями слуха без замены речевого процессора системы кохлеарной имплантации</N_KSG>
    <KOEF_Z>1.80</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds37.011</K_KSG>
    <N_KSG>Медицинская реабилитация детей с поражениями центральной нервной системы</N_KSG>
    <KOEF_Z>2.75</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDUMP>2</IDUMP>
    <K_KSG>ds37.012</K_KSG>
    <N_KSG>Медицинская реабилитация детей после хирургической коррекции врожденных пороков развития органов и систем</N_KSG>
    <KOEF_Z>2.35</KOEF_Z>
    <DATEBEG>01.01.2019</DATEBEG>
    <DATEEND/>
  </zap>
</packet>'

EXEC sp_xml_preparedocument @idoc OUTPUT, @XML_TEXT;
BEGIN TRY
INSERT INTO @V023 ([IDUMP],[K_KSG],[N_KSG],[KOEF_Z],[DATEBEG],[DATEEND])
SELECT             [IDUMP],[K_KSG],[N_KSG],[KOEF_Z],[DATEBEG],[DATEEND]
FROM OPENXML (@idoc, N'/packet/zap', 2)
WITH ([IDUMP] [numeric](1, 0) ,
	[K_KSG] [nvarchar](20),
	[N_KSG] [nvarchar](254),
	[KOEF_Z] [numeric](4, 2),	
	DATEBEG NVARCHAR(10) ,
	DATEEND NVARCHAR(10)  ) 
END TRY
BEGIN CATCH
	PRINT 'Ошибка загрузки XML файла.';
END CATCH

UPDATE @V023 SET DATEEND = NULL WHERE DATEEND = '19000101' 
INSERT INTO V023 ([IDUMP],[K_KSG],[N_KSG],[KOEF_Z],[DATEBEG],[DATEEND])
SELECT [IDUMP],[K_KSG],[N_KSG],[KOEF_Z],[DATEBEG],[DATEEND] 
FROM @V023 AS v


EXEC [dbo].[versionUpdate] 534
COMMIT TRAN;		
END TRY
		BEGIN CATCH			
			SET @ErrorMessage= ERROR_MESSAGE()
			SET @ErrorSeverity= ERROR_SEVERITY()
			SET @ErrorState= ERROR_STATE()
			RAISERROR (@ErrorMessage,@ErrorSeverity,@ErrorState)
			IF (@@trancount > 0) ROLLBACK TRAN						
		END CATCH
IF (@@trancount > 0) ROLLBACK TRAN;