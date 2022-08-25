BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[version�heck] 532

DECLARE @XML_TEXT XML;
DECLARE @idoc INT;

DECLARE @V002 TABLE (	
	[IDPR] [numeric](3, 0) NULL,
	[PRNAME] [nvarchar](254) NULL,
	[DATEBEG] [datetime] NULL,
	[DATEEND] [datetime] NULL)		
	
--SELECT @XML_TEXT = t.BulkColumn
--FROM    (SELECT *    
--    FROM OPENROWSET (BULK 'D:\V002.xml', SINGLE_CLOB) 
-- AS xCol) AS t
--SET @XML_TEXT = REPLACE(@XML_TEXT, '<?xml version="1.0" encoding="windows-1251"?>', '')

SELECT @XML_TEXT = '<packet>
  <zglv>
    <type>ProfOt</type>
    <version>3.0</version>
    <date>30.03.2018</date>
  </zglv>
  <zap>
    <IDPR>1</IDPR>
    <PRNAME>�������� (�������������)</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>3</IDPR>
    <PRNAME>����������� ����</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>4</IDPR>
    <PRNAME>������������ � �����������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>5</IDPR>
    <PRNAME>�������������� � ��������������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>6</IDPR>
    <PRNAME>�������������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>7</IDPR>
    <PRNAME>�����������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>8</IDPR>
    <PRNAME>������-��������� ����������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>10</IDPR>
    <PRNAME>��������-������ ����������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>11</IDPR>
    <PRNAME>�����������������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>12</IDPR>
    <PRNAME>�����������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>13</IDPR>
    <PRNAME>��������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>14</IDPR>
    <PRNAME>���������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>15</IDPR>
    <PRNAME>����������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>16</IDPR>
    <PRNAME>������������������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>17</IDPR>
    <PRNAME>������� �����������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>18</IDPR>
    <PRNAME>������� ���������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>19</IDPR>
    <PRNAME>������� ��������-����������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>20</IDPR>
    <PRNAME>������� ��������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>21</IDPR>
    <PRNAME>������� ��������������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>22</IDPR>
    <PRNAME>������������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>23</IDPR>
    <PRNAME>����������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>27</IDPR>
    <PRNAME>������ ��������������� ��������� ������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>28</IDPR>
    <PRNAME>������������ ��������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>29</IDPR>
    <PRNAME>�����������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>30</IDPR>
    <PRNAME>���������������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>34</IDPR>
    <PRNAME>����������� ������������ �����������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>35</IDPR>
    <PRNAME>����������� ���������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>36</IDPR>
    <PRNAME>����������� ������������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>37</IDPR>
    <PRNAME>������������� ����</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>38</IDPR>
    <PRNAME>������������ �����������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>39</IDPR>
    <PRNAME>������������ ���������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>40</IDPR>
    <PRNAME>������������ ��������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>41</IDPR>
    <PRNAME>�������� ����������� � ���������� ��������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>42</IDPR>
    <PRNAME>��������� ����</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>43</IDPR>
    <PRNAME>���������� �������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>45</IDPR>
    <PRNAME>����������� ��������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>46</IDPR>
    <PRNAME>������������ �������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>47</IDPR>
    <PRNAME>����������� ������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>48</IDPR>
    <PRNAME>����������� �������� (���������������, �������������)</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>49</IDPR>
    <PRNAME>����������� �������� (������������, �������������)</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>50</IDPR>
    <PRNAME>����������� �������� (������������, �������������)</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>51</IDPR>
    <PRNAME>����������� ����������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>53</IDPR>
    <PRNAME>����������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>54</IDPR>
    <PRNAME>�������������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>55</IDPR>
    <PRNAME>������������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>56</IDPR>
    <PRNAME>����������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>57</IDPR>
    <PRNAME>����� ��������� �������� (�������� ��������)</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>58</IDPR>
    <PRNAME>����� ��������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>60</IDPR>
    <PRNAME>���������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>61</IDPR>
    <PRNAME>������������� ����</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>62</IDPR>
    <PRNAME>����������� ������������ ����</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>63</IDPR>
    <PRNAME>����������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>65</IDPR>
    <PRNAME>�������������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>66</IDPR>
    <PRNAME>�������������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>67</IDPR>
    <PRNAME>�������������� ��������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>68</IDPR>
    <PRNAME>���������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>71</IDPR>
    <PRNAME>�������������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>72</IDPR>
    <PRNAME>����������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>73</IDPR>
    <PRNAME>����������-����������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>74</IDPR>
    <PRNAME>������������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>75</IDPR>
    <PRNAME>�������������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>76</IDPR>
    <PRNAME>����������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>77</IDPR>
    <PRNAME>������������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>78</IDPR>
    <PRNAME>�������������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>79</IDPR>
    <PRNAME>���������������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>80</IDPR>
    <PRNAME>����������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>81</IDPR>
    <PRNAME>��������-���������� ��������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>82</IDPR>
    <PRNAME>������������ ����</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>83</IDPR>
    <PRNAME>������������ ���� � ���������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>84</IDPR>
    <PRNAME>������ ����������� ������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>85</IDPR>
    <PRNAME>������������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>86</IDPR>
    <PRNAME>������������ �������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>87</IDPR>
    <PRNAME>������������ ����������������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>88</IDPR>
    <PRNAME>������������ ��������������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>89</IDPR>
    <PRNAME>������������ ���������������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>90</IDPR>
    <PRNAME>������������ �������������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>91</IDPR>
    <PRNAME>�������-����������� ����������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>93</IDPR>
    <PRNAME>�������-����������� ���������� � ������������ �����</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>94</IDPR>
    <PRNAME>�������-����������� ���������� � ������������ �����������, ���������� � ������ ���</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>95</IDPR>
    <PRNAME>�������-��������������� ����������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>96</IDPR>
    <PRNAME>����������-�������������������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>97</IDPR>
    <PRNAME>�������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>98</IDPR>
    <PRNAME>������������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>99</IDPR>
    <PRNAME>����������� ��������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>100</IDPR>
    <PRNAME>������������� � ���������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>103</IDPR>
    <PRNAME>��������������� ��������������� ��������� ������ � �������� �����</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>104</IDPR>
    <PRNAME>��������������� ������� � (���) ������ �������� ��� ��������������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>105</IDPR>
    <PRNAME>���������������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>106</IDPR>
    <PRNAME>�������������� �����������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>107</IDPR>
    <PRNAME>���������� ����������� �������������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>108</IDPR>
    <PRNAME>��������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>109</IDPR>
    <PRNAME>������������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>110</IDPR>
    <PRNAME>����������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>111</IDPR>
    <PRNAME>�������������� �����������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>112</IDPR>
    <PRNAME>��������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>113</IDPR>
    <PRNAME>�������� (�������������� ������� � (���) ������)</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND>07.07.2013</DATEEND>
  </zap>
  <zap>
    <IDPR>114</IDPR>
    <PRNAME>�������� (��������������)</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>115</IDPR>
    <PRNAME>�������� ��������������� ��������� ������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>116</IDPR>
    <PRNAME>��������-������� ��������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>117</IDPR>
    <PRNAME>���������� ��������� ������������������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>120</IDPR>
    <PRNAME>���������� ���������������� �����������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>121</IDPR>
    <PRNAME>���������� ����� ����������� � ����������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>122</IDPR>
    <PRNAME>��������������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>123</IDPR>
    <PRNAME>����������</PRNAME>
    <DATEBEG>01.01.2011</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>135</IDPR>
    <PRNAME>����������� � ����������� ��������</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>136</IDPR>
    <PRNAME>���������� � ����������� (�� ����������� ������������� ��������������� �������������� ����������)</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND>11.12.2017</DATEEND>
  </zap>
  <zap>
    <IDPR>136</IDPR>
    <PRNAME>���������� � ����������� (�� ����������� ������������� ��������������� �������������� ���������� � �������������� ���������� ������������)</PRNAME>
    <DATEBEG>12.12.2017</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>137</IDPR>
    <PRNAME>���������� � ����������� (������������� ��������������� �������������� ����������)</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>138</IDPR>
    <PRNAME>���������� (���������� ���������������� ��������)</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>139</IDPR>
    <PRNAME>���������� ��������</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>140</IDPR>
    <PRNAME>������� � ������������</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>141</IDPR>
    <PRNAME>�������������� ����������</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>142</IDPR>
    <PRNAME>���������������</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>143</IDPR>
    <PRNAME>������, ��������������� � �������� ������� ������ � ������ �������������� �������</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>144</IDPR>
    <PRNAME>���������, �������� ��������� ����� � (���) �� �����������</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>145</IDPR>
    <PRNAME>������� � �������� ������� � (���) ������ �������� ��� ��������������</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>146</IDPR>
    <PRNAME>������������</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>147</IDPR>
    <PRNAME>�������� �����������</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>148</IDPR>
    <PRNAME>������-���������� ����������</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>149</IDPR>
    <PRNAME>������-���������� ������</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>150</IDPR>
    <PRNAME>����������� �������� (�����������, ������������)</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>151</IDPR>
    <PRNAME>����������� �������� ����������������</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>152</IDPR>
    <PRNAME>������������ ������������������� ���������� � �����������, ������� (����������) ��� �������� ��������</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>153</IDPR>
    <PRNAME>������������ ������������������� �� ��������� ���-��������</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>154</IDPR>
    <PRNAME>������������ ������������������� �� ������� ������������ �����������, �������������� ��������� ��� ���������� � ���������� ���������� ��� ������ ����������� ��������� � ����� ��� ����������� � ������ ���� ������������� ���������� �� ��������� ����������, ��� ���� �� ����������, ��� ���������� �� ������ � ���������� ���������</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>155</IDPR>
    <PRNAME>������������ ������������������� �� ������� ����������� ���������������� � ���������� ������������ ���������</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>156</IDPR>
    <PRNAME>������������ ������������������� �� ������� ����������� ���������������� � �������� �������</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>157</IDPR>
    <PRNAME>������������ ������������������� �� ��������� ��������� (������������, �������������� ��� ����� ������������)</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>158</IDPR>
    <PRNAME>����������� ������������</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>159</IDPR>
    <PRNAME>����������</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>160</IDPR>
    <PRNAME>���������� ����������� ������</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>161</IDPR>
    <PRNAME>����������� ��������������� � ������������� ��������</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>162</IDPR>
    <PRNAME>������������������� (�� ����������� ���������� �����������)</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>163</IDPR>
    <PRNAME>������������������� (���������� �����������)</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>164</IDPR>
    <PRNAME>������������ ��������</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>165</IDPR>
    <PRNAME>���������������� �������������������</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>166</IDPR>
    <PRNAME>������������</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>167</IDPR>
    <PRNAME>��������������</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>168</IDPR>
    <PRNAME>���������������������� ����������� � �������</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>169</IDPR>
    <PRNAME>���������-������������� ������������ �������������</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>170</IDPR>
    <PRNAME>������������ ���� � ������������</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>171</IDPR>
    <PRNAME>������������ ����� ��������</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>172</IDPR>
    <PRNAME>�������-����������� ���������� ������������ ������������� � ������������ ������������� �������� (�������������, ������������, ������-������������������, ������������������, �������-�������������, �������-���������������, �������-����������, �������-��������������, ������-�����������������)</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>173</IDPR>
    <PRNAME>���������� ������������ �������-��������������� ����������</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>174</IDPR>
    <PRNAME>����������� ������������ �������-��������������� ����������</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>175</IDPR>
    <PRNAME>���������� ������������ �������-��������������� ����������</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>176</IDPR>
    <PRNAME>����������� ������������ �������-��������������� ���������� (���������-���������������, ���������-���������������)</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>177</IDPR>
    <PRNAME>�������������� �������� ����� � ��������������� ��������� ������</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>178</IDPR>
    <PRNAME>��������������� ������� ������ � (���) ������ �������������� �������</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>179</IDPR>
    <PRNAME>�������� (�������������� ������� � (���) ������)_2013</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>180</IDPR>
    <PRNAME>���������� �������� ����������� ������</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>181</IDPR>
    <PRNAME>�����������</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>182</IDPR>
    <PRNAME>�������������</PRNAME>
    <DATEBEG>08.07.2013</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>184</IDPR>
    <PRNAME>���������� � ����������� (�������������� ���������� ������������)</PRNAME>
    <DATEBEG>12.12.2017</DATEBEG>
    <DATEEND/>
  </zap>
  <zap>
    <IDPR>185</IDPR>
    <PRNAME>����������</PRNAME>
    <DATEBEG>07.07.2017</DATEBEG>
    <DATEEND/>
  </zap>
</packet>'

EXEC sp_xml_preparedocument @idoc OUTPUT, @XML_TEXT;
BEGIN TRY
INSERT INTO @V002 (IDPR,PRNAME,DATEBEG,DATEEND)
SELECT IDPR,PRNAME,DATEBEG,DATEEND
FROM OPENXML (@idoc, N'/packet/zap', 2)
WITH (IDPR [numeric](3, 0) ,
	PRNAME NVARCHAR(254) ,	
	DATEBEG NVARCHAR(10) ,
	DATEEND NVARCHAR(10)  ) 
END TRY
BEGIN CATCH
	PRINT '������ �������� XML �����.';
END CATCH

UPDATE @V002 SET DATEEND = NULL WHERE DATEEND = '19000101' 
--SELECT * FROM @V002 AS v

UPDATE V002
SET V002.IDPR = t1.IDPR
      ,V002.PRNAME = t1.PRNAME      
      ,V002.[DATEBEG] = t1.[DATEBEG]
      ,V002.[DATEEND] = t1.[DATEEND]
FROM V002 as t
JOIN @V002 as t1 on ISNULL(t.IDPR, t.Id) = t1.IDPR

INSERT INTO V002
       (ID,   IDPR,PRNAME,DATEBEG,DATEEND)
SELECT  IDPR, IDPR,PRNAME,DATEBEG,DATEEND
FROM @V002
WHERE IDPR NOT IN (
        SELECT t1.IDPR  
        FROM V002 AS t
JOIN @V002 AS t1 ON t.IDPR = t1.IDPR)


EXEC [dbo].[versionUpdate] 533
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