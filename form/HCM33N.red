<?xml version="1.0"?>
<diagram xmlns:dia="http://www.lysator.liu.se/~alla/dia/">
  <dictionarydata>
    <element name="PTNUM" occurs="1">
      <appinfo>
        <embed object="string" length="20"/>
      </appinfo>
    </element>
    <element name="TANJYOBI" occurs="1">
      <appinfo>
        <embed object="string" length="24"/>
      </appinfo>
    </element>
    <element name="SEX" occurs="1">
      <appinfo>
        <embed object="string" length="2"/>
      </appinfo>
    </element>
    <element name="NAME" occurs="1">
      <appinfo>
        <embed object="string" length="30"/>
      </appinfo>
    </element>
    <element name="HKNSYUBETU" occurs="1">
      <appinfo>
        <embed object="string" length="124"/>
      </appinfo>
    </element>
    <element name="PAGE" occurs="1">
      <appinfo>
        <embed object="string" length="3"/>
      </appinfo>
    </element>
    <element name="SRYKA" occurs="1">
      <appinfo>
        <embed object="string" length="10"/>
      </appinfo>
    </element>
    <element name="SRYYM" occurs="1">
      <appinfo>
        <embed object="string" length="34"/>
      </appinfo>
    </element>
    <element name="A-TBL" occurs="40">
      <element name="NUM" occurs="1">
        <appinfo>
          <embed object="string" length="2"/>
        </appinfo>
      </element>
      <element name="SRYMD" occurs="1">
        <appinfo>
          <embed object="string" length="5"/>
        </appinfo>
      </element>
      <element name="NAIYO" occurs="11">
        <appinfo>
          <embed object="string" length="8"/>
        </appinfo>
      </element>
    </element>
  </dictionarydata>
  <diagramdata>
    <attribute name="background">
      <color val="#ffffff"/>
    </attribute>
    <attribute name="paper">
      <composite type="paper">
        <attribute name="name">
          <string>#A4#</string>
        </attribute>
        <attribute name="pswidth">
          <real val="21"/>
        </attribute>
        <attribute name="psheight">
          <real val="29.7"/>
        </attribute>
        <attribute name="tmargin">
          <real val="0"/>
        </attribute>
        <attribute name="bmargin">
          <real val="0"/>
        </attribute>
        <attribute name="lmargin">
          <real val="0"/>
        </attribute>
        <attribute name="rmargin">
          <real val="0"/>
        </attribute>
        <attribute name="is_portrait">
          <boolean val="true"/>
        </attribute>
        <attribute name="scaling">
          <real val="1"/>
        </attribute>
        <attribute name="fitto">
          <boolean val="false"/>
        </attribute>
      </composite>
    </attribute>
  </diagramdata>
  <layer name="&#199;&#216;&#183;&#202;" visible="true">
    <object type="Standard - Line" version="0" id="O0">
      <attribute name="obj_pos">
        <point val="1.4,28.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.385,28.685;20.015,28.715"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,28.7"/>
        <point val="20,28.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.03"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O1">
      <attribute name="obj_pos">
        <point val="1.4,3.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.385,3.485;1.415,28.715"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,3.5"/>
        <point val="1.4,28.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="41"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.03"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O2">
      <attribute name="obj_pos">
        <point val="1.4,3.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.385,3.485;20.015,3.515"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,3.5"/>
        <point val="20,3.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.03"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O3">
      <attribute name="obj_pos">
        <point val="20,3.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.985,3.485;20.015,28.715"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="20,3.5"/>
        <point val="20,28.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="41"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.03"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O4">
      <attribute name="obj_pos">
        <point val="1.4,4.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.385,4.685;20.015,4.715"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,4.7"/>
        <point val="20,4.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.03"/>
      </attribute>
      <connections>
        <connection handle="0" to="O1" connection="1"/>
        <connection handle="1" to="O3" connection="1"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O5">
      <attribute name="obj_pos">
        <point val="1.4,6.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.395,6.495;20.005,6.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,6.5"/>
        <point val="20,6.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O1" connection="4"/>
        <connection handle="1" to="O3" connection="4"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O6">
      <attribute name="obj_pos">
        <point val="1.4,7.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.395,7.095;20.005,7.105"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,7.1"/>
        <point val="20,7.1"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O1" connection="5"/>
        <connection handle="1" to="O3" connection="5"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O7">
      <attribute name="obj_pos">
        <point val="1.4,7.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.395,7.695;20.005,7.705"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,7.7"/>
        <point val="20,7.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O1" connection="6"/>
        <connection handle="1" to="O3" connection="6"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O8">
      <attribute name="obj_pos">
        <point val="1.4,8.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.395,8.295;20.005,8.305"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,8.3"/>
        <point val="20,8.3"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O1" connection="7"/>
        <connection handle="1" to="O3" connection="7"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O9">
      <attribute name="obj_pos">
        <point val="1.4,8.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.395,8.895;20.005,8.905"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,8.9"/>
        <point val="20,8.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O1" connection="8"/>
        <connection handle="1" to="O3" connection="8"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O10">
      <attribute name="obj_pos">
        <point val="1.4,9.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.395,9.495;20.005,9.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,9.5"/>
        <point val="20,9.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O1" connection="9"/>
        <connection handle="1" to="O3" connection="9"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O11">
      <attribute name="obj_pos">
        <point val="1.4,10.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.395,10.095;20.005,10.105"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,10.1"/>
        <point val="20,10.1"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O1" connection="10"/>
        <connection handle="1" to="O3" connection="10"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O12">
      <attribute name="obj_pos">
        <point val="1.4,10.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.395,10.695;20.005,10.705"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,10.7"/>
        <point val="20,10.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O1" connection="11"/>
        <connection handle="1" to="O3" connection="11"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O13">
      <attribute name="obj_pos">
        <point val="1.4,11.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.395,11.295;20.005,11.305"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,11.3"/>
        <point val="20,11.3"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O1" connection="12"/>
        <connection handle="1" to="O3" connection="12"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O14">
      <attribute name="obj_pos">
        <point val="1.4,11.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.395,11.895;20.005,11.905"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,11.9"/>
        <point val="20,11.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O1" connection="13"/>
        <connection handle="1" to="O3" connection="13"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O15">
      <attribute name="obj_pos">
        <point val="1.4,12.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.395,12.495;20.005,12.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,12.5"/>
        <point val="20,12.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O1" connection="14"/>
        <connection handle="1" to="O3" connection="14"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O16">
      <attribute name="obj_pos">
        <point val="1.4,13.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.395,13.095;20.005,13.105"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,13.1"/>
        <point val="20,13.1"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O1" connection="15"/>
        <connection handle="1" to="O3" connection="15"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O17">
      <attribute name="obj_pos">
        <point val="1.4,13.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.395,13.695;20.005,13.705"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,13.7"/>
        <point val="20,13.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O1" connection="16"/>
        <connection handle="1" to="O3" connection="16"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O18">
      <attribute name="obj_pos">
        <point val="1.4,14.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.395,14.295;20.005,14.305"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,14.3"/>
        <point val="20,14.3"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O1" connection="17"/>
        <connection handle="1" to="O3" connection="17"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O19">
      <attribute name="obj_pos">
        <point val="1.4,14.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.395,14.895;20.005,14.905"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,14.9"/>
        <point val="20,14.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O1" connection="18"/>
        <connection handle="1" to="O3" connection="18"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O20">
      <attribute name="obj_pos">
        <point val="1.4,15.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.395,15.495;20.005,15.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,15.5"/>
        <point val="20,15.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O1" connection="19"/>
        <connection handle="1" to="O3" connection="19"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O21">
      <attribute name="obj_pos">
        <point val="1.4,16.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.395,16.095;20.005,16.105"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,16.1"/>
        <point val="20,16.1"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O1" connection="20"/>
        <connection handle="1" to="O3" connection="20"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O22">
      <attribute name="obj_pos">
        <point val="1.4,16.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.395,16.695;20.005,16.705"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,16.7"/>
        <point val="20,16.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O1" connection="21"/>
        <connection handle="1" to="O3" connection="21"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O23">
      <attribute name="obj_pos">
        <point val="1.4,17.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.395,17.295;20.005,17.305"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,17.3"/>
        <point val="20,17.3"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O1" connection="22"/>
        <connection handle="1" to="O3" connection="22"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O24">
      <attribute name="obj_pos">
        <point val="1.4,17.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.395,17.895;20.005,17.905"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,17.9"/>
        <point val="20,17.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O1" connection="23"/>
        <connection handle="1" to="O3" connection="23"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O25">
      <attribute name="obj_pos">
        <point val="1.4,18.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.395,18.495;20.005,18.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,18.5"/>
        <point val="20,18.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O1" connection="24"/>
        <connection handle="1" to="O3" connection="24"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O26">
      <attribute name="obj_pos">
        <point val="1.4,19.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.395,19.095;20.005,19.105"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,19.1"/>
        <point val="20,19.1"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O1" connection="25"/>
        <connection handle="1" to="O3" connection="25"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O27">
      <attribute name="obj_pos">
        <point val="1.4,19.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.395,19.695;20.005,19.705"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,19.7"/>
        <point val="20,19.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O1" connection="26"/>
        <connection handle="1" to="O3" connection="26"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O28">
      <attribute name="obj_pos">
        <point val="1.4,20.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.395,20.295;20.005,20.305"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,20.3"/>
        <point val="20,20.3"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O1" connection="27"/>
        <connection handle="1" to="O3" connection="27"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O29">
      <attribute name="obj_pos">
        <point val="1.4,20.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.395,20.895;20.005,20.905"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,20.9"/>
        <point val="20,20.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O1" connection="28"/>
        <connection handle="1" to="O3" connection="28"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O30">
      <attribute name="obj_pos">
        <point val="1.4,21.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.395,21.495;20.005,21.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,21.5"/>
        <point val="20,21.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O1" connection="29"/>
        <connection handle="1" to="O3" connection="29"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O31">
      <attribute name="obj_pos">
        <point val="1.4,22.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.395,22.095;20.005,22.105"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,22.1"/>
        <point val="20,22.1"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O1" connection="30"/>
        <connection handle="1" to="O3" connection="30"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O32">
      <attribute name="obj_pos">
        <point val="1.4,22.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.395,22.695;20.005,22.705"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,22.7"/>
        <point val="20,22.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O1" connection="31"/>
        <connection handle="1" to="O3" connection="31"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O33">
      <attribute name="obj_pos">
        <point val="1.4,23.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.395,23.295;20.005,23.305"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,23.3"/>
        <point val="20,23.3"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O1" connection="32"/>
        <connection handle="1" to="O3" connection="32"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O34">
      <attribute name="obj_pos">
        <point val="1.4,23.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.395,23.895;20.005,23.905"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,23.9"/>
        <point val="20,23.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O1" connection="33"/>
        <connection handle="1" to="O3" connection="33"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O35">
      <attribute name="obj_pos">
        <point val="1.4,24.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.395,24.495;20.005,24.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,24.5"/>
        <point val="20,24.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O1" connection="34"/>
        <connection handle="1" to="O3" connection="34"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O36">
      <attribute name="obj_pos">
        <point val="1.4,25.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.395,25.095;20.005,25.105"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,25.1"/>
        <point val="20,25.1"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O1" connection="35"/>
        <connection handle="1" to="O3" connection="35"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O37">
      <attribute name="obj_pos">
        <point val="1.4,25.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.395,25.695;20.005,25.705"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,25.7"/>
        <point val="20,25.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O1" connection="36"/>
        <connection handle="1" to="O3" connection="36"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O38">
      <attribute name="obj_pos">
        <point val="1.4,26.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.395,26.295;20.005,26.305"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,26.3"/>
        <point val="20,26.3"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O1" connection="37"/>
        <connection handle="1" to="O3" connection="37"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O39">
      <attribute name="obj_pos">
        <point val="1.4,26.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.395,26.895;20.005,26.905"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,26.9"/>
        <point val="20,26.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O1" connection="38"/>
        <connection handle="1" to="O3" connection="38"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O40">
      <attribute name="obj_pos">
        <point val="1.4,27.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.395,27.495;20.005,27.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,27.5"/>
        <point val="20,27.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O1" connection="39"/>
        <connection handle="1" to="O3" connection="39"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O41">
      <attribute name="obj_pos">
        <point val="1.4,28.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.395,28.095;20.005,28.105"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,28.1"/>
        <point val="20,28.1"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O1" connection="40"/>
        <connection handle="1" to="O3" connection="40"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O42">
      <attribute name="obj_pos">
        <point val="1.4,5.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.395,5.895;20.005,5.905"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,5.9"/>
        <point val="20,5.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O1" connection="3"/>
        <connection handle="1" to="O3" connection="3"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O43">
      <attribute name="obj_pos">
        <point val="1.4,5.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.395,5.295;20.005,5.305"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,5.3"/>
        <point val="20,5.3"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O1" connection="2"/>
        <connection handle="1" to="O3" connection="2"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O44">
      <attribute name="obj_pos">
        <point val="2.4,3.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.395,3.495;2.405,28.705"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="2.4,3.5"/>
        <point val="2.4,28.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="41"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O45">
      <attribute name="obj_pos">
        <point val="1.4,3.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.395,3.495;2.405,4.705"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.4,3.5"/>
        <point val="2.4,4.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="1" to="O44" connection="1"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O46">
      <attribute name="obj_pos">
        <point val="5.6,3.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.595,3.495;5.605,28.705"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="5.6,3.5"/>
        <point val="5.6,28.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="41"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O47">
      <attribute name="obj_pos">
        <point val="7.2,3.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.195,3.495;7.205,28.705"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="7.2,3.5"/>
        <point val="7.2,28.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="41"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O48">
      <attribute name="obj_pos">
        <point val="8.8,3.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.795,3.495;8.805,28.705"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="8.8,3.5"/>
        <point val="8.8,28.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="41"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O49">
      <attribute name="obj_pos">
        <point val="10.4,3.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.395,3.495;10.405,28.705"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="10.4,3.5"/>
        <point val="10.4,28.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="41"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O50">
      <attribute name="obj_pos">
        <point val="12,3.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="11.995,3.495;12.005,28.705"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="12,3.5"/>
        <point val="12,28.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="41"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O51">
      <attribute name="obj_pos">
        <point val="13.6,3.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.595,3.495;13.605,28.705"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="13.6,3.5"/>
        <point val="13.6,28.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="41"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O52">
      <attribute name="obj_pos">
        <point val="15.2,3.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.195,3.495;15.205,28.705"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="15.2,3.5"/>
        <point val="15.2,28.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="41"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O53">
      <attribute name="obj_pos">
        <point val="18.4,3.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.395,3.495;18.405,28.705"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="18.4,3.5"/>
        <point val="18.4,28.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="41"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O54">
      <attribute name="obj_pos">
        <point val="4,3.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.995,3.495;4.005,28.705"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="4,3.5"/>
        <point val="4,28.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="41"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O55">
      <attribute name="obj_pos">
        <point val="16.8,3.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.795,3.495;16.805,28.705"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="16.8,3.5"/>
        <point val="16.8,28.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="41"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
  </layer>
  <layer name="&#202;&#184;&#187;&#250;" visible="true">
    <object type="Standard - Text" version="0" id="O56">
      <attribute name="obj_pos">
        <point val="10.5,1.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.7225,0.97;13.2775,1.47"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#191;&#199;&#161;&#161;&#206;&#197;&#161;&#161;&#164;&#206;&#161;&#161;&#197;&#192;&#161;&#161;&#191;&#244;&#161;&#161;&#197;&#249;#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.5"/>
          </attribute>
          <attribute name="pos">
            <point val="10.5,1.4"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.2525"/>
          </attribute>
          <attribute name="multi">
            <real val="0.2525"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O57">
      <attribute name="obj_pos">
        <point val="19.2,1.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.0485,1.242;19.3515,1.542"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#163;&#208;#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="19.2,1.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.1515"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O58">
      <attribute name="obj_pos">
        <point val="2.1,3.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.9485,3.542;2.2515,4.142"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#188;&#239;
&#202;&#204;#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="2.1,3.8"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.1515"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O59">
      <attribute name="obj_pos">
        <point val="1.7,4.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.5485,4.042;1.8515,4.642"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#183;&#238;
&#198;&#252;#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="1.7,4.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.1515"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O60">
      <attribute name="obj_pos">
        <point val="3.2,3.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.0485,3.642;3.3515,4.542"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#191;&#199;

&#187;&#161;#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="3.2,3.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.1515"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O61">
      <attribute name="obj_pos">
        <point val="4.8,3.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.6485,3.642;4.9515,4.542"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#197;&#234;

&#204;&#244;#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="4.8,3.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.1515"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O62">
      <attribute name="obj_pos">
        <point val="6.4,3.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.2485,3.642;6.5515,4.542"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#195;&#237;

&#188;&#205;#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.4,3.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.1515"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O63">
      <attribute name="obj_pos">
        <point val="8.4,3.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.2485,3.642;8.5515,4.542"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#188;&#234;

&#189;&#209;#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="8.4,3.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.1515"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O64">
      <attribute name="obj_pos">
        <point val="9.6,3.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.4485,3.642;9.7515,4.542"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#184;&#161;

&#186;&#186;#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="9.6,3.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.1515"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O65">
      <attribute name="obj_pos">
        <point val="11,3.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.8485,3.642;11.1515,4.542"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#178;&#232;

&#193;&#252;#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="11,3.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.1515"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O66">
      <attribute name="obj_pos">
        <point val="12.8,3.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.6485,3.642;12.9515,4.542"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#189;
&#164;&#206;
&#194;&#190;#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="12.8,3.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.1515"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O67">
      <attribute name="obj_pos">
        <point val="16.2,3.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.0485,3.642;16.3515,4.542"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#197;&#192;

&#191;&#244;#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="16.2,3.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.1515"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O68">
      <attribute name="obj_pos">
        <point val="15.8,3.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.497,3.642;16.103,4.542"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#185;&#231;
&#161;&#161;&#161;&#161;
&#183;&#215;#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="15.8,3.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.1515"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O69">
      <attribute name="obj_pos">
        <point val="7.6,3.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.4485,3.642;7.7515,4.542"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#189;&#232;

&#195;&#214;#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="7.6,3.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.1515"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O70">
      <attribute name="obj_pos">
        <point val="11.4,3.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="11.2485,3.642;11.5515,4.542"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#191;&#199;

&#195;&#199;#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="11.4,3.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.1515"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O71">
      <attribute name="obj_pos">
        <point val="8,3.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.8485,3.642;8.1515,4.242"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#
&#161;&#166;#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="8,3.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.1515"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O72">
      <attribute name="obj_pos">
        <point val="14.4,3.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.2485,3.642;14.5515,4.542"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#198;&#254;
&#177;&#161;
&#206;&#193;#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="14.4,3.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.1515"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O73">
      <attribute name="obj_pos">
        <point val="19.2,3.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.0485,3.642;19.3515,4.542"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#202;&#221;
&#184;&#177;
&#179;&#176;#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="19.2,3.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.1515"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O74">
      <attribute name="obj_pos">
        <point val="14.9,1.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.9,1.042;16.415,1.342"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#227;&#198;&#254;&#161;&#161;&#177;&#161;&#161;&#228;#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="14.9,1.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.1515"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O75">
      <attribute name="obj_pos">
        <point val="17.8,3.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.6485,3.642;17.9515,4.542"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#206;&#197;
&#205;&#220;
&#200;&#241;#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="17.8,3.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.1515"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O76">
      <attribute name="obj_pos">
        <point val="17.4,3.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.2485,3.642;17.5515,4.542"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#191;&#169;

&#187;&#246;#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="17.4,3.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.1515"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
  </layer>
  <layer name="&#186;&#185;&#164;&#183;&#185;&#254;&#164;&#223;" visible="true">
    <object type="Embed - Text" version="0" id="O77">
      <attribute name="obj_pos">
        <point val="1.4,2.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.4,1.856;5.44,2.256"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#PTNUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999999999999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.4"/>
          </attribute>
          <attribute name="pos">
            <point val="1.4,2.2"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.202"/>
          </attribute>
          <attribute name="multi">
            <real val="0.202"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O78">
      <attribute name="obj_pos">
        <point val="12.3,2.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.3,2.442;12.603,2.742"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#SEX#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="12.3,2.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.1515"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O79">
      <attribute name="obj_pos">
        <point val="8.5,2.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.5,2.442;12.136,2.742"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#TANJYOBI#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="8.5,2.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.1515"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O80">
      <attribute name="obj_pos">
        <point val="1.4,3.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.4,3.042;20.186,3.342"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKNSYUBETU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="1.4,3.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.1515"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O81">
      <attribute name="obj_pos">
        <point val="1.4,2.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.4,2.356;7.46,2.756"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.4"/>
          </attribute>
          <attribute name="pos">
            <point val="1.4,2.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.202"/>
          </attribute>
          <attribute name="multi">
            <real val="0.202"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O82">
      <attribute name="obj_pos">
        <point val="20,1.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.4698,1.199;20,1.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#PAGE#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="20,1.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O83">
      <attribute name="obj_pos">
        <point val="20,2.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.849,2.442;20,2.742"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#SRYYM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="20,2.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.1515"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O84">
      <attribute name="obj_pos">
        <point val="14.9,1.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.9,1.456;16.92,1.856"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#SRYKA#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.4"/>
          </attribute>
          <attribute name="pos">
            <point val="14.9,1.8"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.202"/>
          </attribute>
          <attribute name="multi">
            <real val="0.202"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O85">
      <attribute name="obj_pos">
        <point val="3.9,5.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.486,4.799;3.9,5.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[0].NAIYO[0]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,5.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O86">
      <attribute name="obj_pos">
        <point val="5.5,5.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.086,4.799;5.5,5.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[0].NAIYO[1]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="5.5,5.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O87">
      <attribute name="obj_pos">
        <point val="7.1,5.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.686,4.799;7.1,5.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[0].NAIYO[2]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,5.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O88">
      <attribute name="obj_pos">
        <point val="8.7,5.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.286,4.799;8.7,5.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[0].NAIYO[3]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,5.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O89">
      <attribute name="obj_pos">
        <point val="10.3,5.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.886,4.799;10.3,5.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[0].NAIYO[4]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.3,5.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O90">
      <attribute name="obj_pos">
        <point val="11.9,5.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.486,4.799;11.9,5.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[0].NAIYO[5]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.9,5.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O91">
      <attribute name="obj_pos">
        <point val="13.5,5.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.086,4.799;13.5,5.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[0].NAIYO[6]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,5.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O92">
      <attribute name="obj_pos">
        <point val="15.1,5.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.686,4.799;15.1,5.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[0].NAIYO[7]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.1,5.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O93">
      <attribute name="obj_pos">
        <point val="16.7,5.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.286,4.799;16.7,5.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[0].NAIYO[8]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.7,5.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O94">
      <attribute name="obj_pos">
        <point val="1.3,5.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.9465,4.799;1.3,5.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[0].NUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.3,5.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O95">
      <attribute name="obj_pos">
        <point val="1.9,5.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.45812,4.799;2.34187,5.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[0].SRYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,5.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O96">
      <attribute name="obj_pos">
        <point val="18.3,5.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.886,4.799;18.3,5.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[0].NAIYO[9]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.3,5.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O97">
      <attribute name="obj_pos">
        <point val="19.9,5.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.486,4.799;19.9,5.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[0].NAIYO[10]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,5.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O98">
      <attribute name="obj_pos">
        <point val="3.9,5.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.486,5.399;3.9,5.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[1].NAIYO[0]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,5.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O99">
      <attribute name="obj_pos">
        <point val="5.5,5.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.086,5.399;5.5,5.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[1].NAIYO[1]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="5.5,5.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O100">
      <attribute name="obj_pos">
        <point val="7.1,5.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.686,5.399;7.1,5.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[1].NAIYO[2]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,5.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O101">
      <attribute name="obj_pos">
        <point val="8.7,5.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.286,5.399;8.7,5.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[1].NAIYO[3]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,5.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O102">
      <attribute name="obj_pos">
        <point val="10.3,5.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.886,5.399;10.3,5.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[1].NAIYO[4]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.3,5.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O103">
      <attribute name="obj_pos">
        <point val="11.9,5.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.486,5.399;11.9,5.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[1].NAIYO[5]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.9,5.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O104">
      <attribute name="obj_pos">
        <point val="13.5,5.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.086,5.399;13.5,5.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[1].NAIYO[6]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,5.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O105">
      <attribute name="obj_pos">
        <point val="15.1,5.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.686,5.399;15.1,5.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[1].NAIYO[7]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.1,5.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O106">
      <attribute name="obj_pos">
        <point val="16.7,5.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.286,5.399;16.7,5.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[1].NAIYO[8]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.7,5.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O107">
      <attribute name="obj_pos">
        <point val="1.3,5.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.9465,5.399;1.3,5.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[1].NUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.3,5.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O108">
      <attribute name="obj_pos">
        <point val="1.9,5.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.45812,5.399;2.34187,5.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[1].SRYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,5.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O109">
      <attribute name="obj_pos">
        <point val="18.3,5.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.886,5.399;18.3,5.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[1].NAIYO[9]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.3,5.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O110">
      <attribute name="obj_pos">
        <point val="19.9,5.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.486,5.399;19.9,5.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[1].NAIYO[10]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,5.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O111">
      <attribute name="obj_pos">
        <point val="3.9,6.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.486,5.999;3.9,6.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[2].NAIYO[0]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,6.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O112">
      <attribute name="obj_pos">
        <point val="5.5,6.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.086,5.999;5.5,6.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[2].NAIYO[1]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="5.5,6.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O113">
      <attribute name="obj_pos">
        <point val="7.1,6.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.686,5.999;7.1,6.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[2].NAIYO[2]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,6.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O114">
      <attribute name="obj_pos">
        <point val="8.7,6.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.286,5.999;8.7,6.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[2].NAIYO[3]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,6.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O115">
      <attribute name="obj_pos">
        <point val="10.3,6.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.886,5.999;10.3,6.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[2].NAIYO[4]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.3,6.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O116">
      <attribute name="obj_pos">
        <point val="11.9,6.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.486,5.999;11.9,6.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[2].NAIYO[5]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.9,6.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O117">
      <attribute name="obj_pos">
        <point val="13.5,6.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.086,5.999;13.5,6.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[2].NAIYO[6]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,6.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O118">
      <attribute name="obj_pos">
        <point val="15.1,6.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.686,5.999;15.1,6.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[2].NAIYO[7]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.1,6.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O119">
      <attribute name="obj_pos">
        <point val="16.7,6.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.286,5.999;16.7,6.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[2].NAIYO[8]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.7,6.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O120">
      <attribute name="obj_pos">
        <point val="1.3,6.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.9465,5.999;1.3,6.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[2].NUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.3,6.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O121">
      <attribute name="obj_pos">
        <point val="1.9,6.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.45812,5.999;2.34187,6.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[2].SRYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,6.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O122">
      <attribute name="obj_pos">
        <point val="18.3,6.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.886,5.999;18.3,6.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[2].NAIYO[9]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.3,6.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O123">
      <attribute name="obj_pos">
        <point val="19.9,6.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.486,5.999;19.9,6.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[2].NAIYO[10]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,6.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O124">
      <attribute name="obj_pos">
        <point val="3.9,6.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.486,6.599;3.9,6.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[3].NAIYO[0]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,6.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O125">
      <attribute name="obj_pos">
        <point val="5.5,6.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.086,6.599;5.5,6.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[3].NAIYO[1]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="5.5,6.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O126">
      <attribute name="obj_pos">
        <point val="7.1,6.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.686,6.599;7.1,6.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[3].NAIYO[2]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,6.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O127">
      <attribute name="obj_pos">
        <point val="8.7,6.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.286,6.599;8.7,6.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[3].NAIYO[3]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,6.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O128">
      <attribute name="obj_pos">
        <point val="10.3,6.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.886,6.599;10.3,6.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[3].NAIYO[4]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.3,6.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O129">
      <attribute name="obj_pos">
        <point val="11.9,6.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.486,6.599;11.9,6.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[3].NAIYO[5]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.9,6.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O130">
      <attribute name="obj_pos">
        <point val="13.5,6.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.086,6.599;13.5,6.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[3].NAIYO[6]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,6.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O131">
      <attribute name="obj_pos">
        <point val="15.1,6.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.686,6.599;15.1,6.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[3].NAIYO[7]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.1,6.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O132">
      <attribute name="obj_pos">
        <point val="16.7,6.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.286,6.599;16.7,6.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[3].NAIYO[8]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.7,6.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O133">
      <attribute name="obj_pos">
        <point val="1.3,6.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.9465,6.599;1.3,6.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[3].NUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.3,6.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O134">
      <attribute name="obj_pos">
        <point val="1.9,6.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.45812,6.599;2.34187,6.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[3].SRYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,6.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O135">
      <attribute name="obj_pos">
        <point val="18.3,6.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.886,6.599;18.3,6.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[3].NAIYO[9]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.3,6.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O136">
      <attribute name="obj_pos">
        <point val="19.9,6.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.486,6.599;19.9,6.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[3].NAIYO[10]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,6.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O137">
      <attribute name="obj_pos">
        <point val="3.9,7.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.486,7.199;3.9,7.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[4].NAIYO[0]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,7.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O138">
      <attribute name="obj_pos">
        <point val="5.5,7.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.086,7.199;5.5,7.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[4].NAIYO[1]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="5.5,7.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O139">
      <attribute name="obj_pos">
        <point val="7.1,7.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.686,7.199;7.1,7.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[4].NAIYO[2]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,7.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O140">
      <attribute name="obj_pos">
        <point val="8.7,7.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.286,7.199;8.7,7.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[4].NAIYO[3]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,7.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O141">
      <attribute name="obj_pos">
        <point val="10.3,7.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.886,7.199;10.3,7.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[4].NAIYO[4]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.3,7.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O142">
      <attribute name="obj_pos">
        <point val="11.9,7.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.486,7.199;11.9,7.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[4].NAIYO[5]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.9,7.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O143">
      <attribute name="obj_pos">
        <point val="13.5,7.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.086,7.199;13.5,7.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[4].NAIYO[6]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,7.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O144">
      <attribute name="obj_pos">
        <point val="15.1,7.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.686,7.199;15.1,7.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[4].NAIYO[7]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.1,7.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O145">
      <attribute name="obj_pos">
        <point val="16.7,7.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.286,7.199;16.7,7.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[4].NAIYO[8]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.7,7.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O146">
      <attribute name="obj_pos">
        <point val="1.3,7.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.9465,7.199;1.3,7.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[4].NUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.3,7.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O147">
      <attribute name="obj_pos">
        <point val="1.9,7.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.45812,7.199;2.34187,7.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[4].SRYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,7.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O148">
      <attribute name="obj_pos">
        <point val="18.3,7.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.886,7.199;18.3,7.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[4].NAIYO[9]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.3,7.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O149">
      <attribute name="obj_pos">
        <point val="19.9,7.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.486,7.199;19.9,7.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[4].NAIYO[10]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,7.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O150">
      <attribute name="obj_pos">
        <point val="3.9,8.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.486,7.799;3.9,8.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[5].NAIYO[0]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,8.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O151">
      <attribute name="obj_pos">
        <point val="5.5,8.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.086,7.799;5.5,8.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[5].NAIYO[1]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="5.5,8.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O152">
      <attribute name="obj_pos">
        <point val="7.1,8.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.686,7.799;7.1,8.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[5].NAIYO[2]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,8.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O153">
      <attribute name="obj_pos">
        <point val="8.7,8.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.286,7.799;8.7,8.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[5].NAIYO[3]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,8.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O154">
      <attribute name="obj_pos">
        <point val="10.3,8.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.886,7.799;10.3,8.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[5].NAIYO[4]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.3,8.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O155">
      <attribute name="obj_pos">
        <point val="11.9,8.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.486,7.799;11.9,8.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[5].NAIYO[5]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.9,8.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O156">
      <attribute name="obj_pos">
        <point val="13.5,8.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.086,7.799;13.5,8.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[5].NAIYO[6]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,8.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O157">
      <attribute name="obj_pos">
        <point val="15.1,8.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.686,7.799;15.1,8.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[5].NAIYO[7]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.1,8.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O158">
      <attribute name="obj_pos">
        <point val="16.7,8.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.286,7.799;16.7,8.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[5].NAIYO[8]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.7,8.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O159">
      <attribute name="obj_pos">
        <point val="1.3,8.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.9465,7.799;1.3,8.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[5].NUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.3,8.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O160">
      <attribute name="obj_pos">
        <point val="1.9,8.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.45812,7.799;2.34187,8.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[5].SRYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,8.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O161">
      <attribute name="obj_pos">
        <point val="18.3,8.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.886,7.799;18.3,8.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[5].NAIYO[9]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.3,8.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O162">
      <attribute name="obj_pos">
        <point val="19.9,8.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.486,7.799;19.9,8.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[5].NAIYO[10]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,8.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O163">
      <attribute name="obj_pos">
        <point val="3.9,8.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.486,8.399;3.9,8.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[6].NAIYO[0]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,8.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O164">
      <attribute name="obj_pos">
        <point val="5.5,8.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.086,8.399;5.5,8.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[6].NAIYO[1]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="5.5,8.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O165">
      <attribute name="obj_pos">
        <point val="7.1,8.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.686,8.399;7.1,8.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[6].NAIYO[2]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,8.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O166">
      <attribute name="obj_pos">
        <point val="8.7,8.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.286,8.399;8.7,8.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[6].NAIYO[3]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,8.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O167">
      <attribute name="obj_pos">
        <point val="10.3,8.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.886,8.399;10.3,8.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[6].NAIYO[4]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.3,8.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O168">
      <attribute name="obj_pos">
        <point val="11.9,8.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.486,8.399;11.9,8.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[6].NAIYO[5]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.9,8.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O169">
      <attribute name="obj_pos">
        <point val="13.5,8.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.086,8.399;13.5,8.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[6].NAIYO[6]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,8.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O170">
      <attribute name="obj_pos">
        <point val="15.1,8.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.686,8.399;15.1,8.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[6].NAIYO[7]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.1,8.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O171">
      <attribute name="obj_pos">
        <point val="16.7,8.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.286,8.399;16.7,8.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[6].NAIYO[8]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.7,8.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O172">
      <attribute name="obj_pos">
        <point val="1.3,8.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.9465,8.399;1.3,8.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[6].NUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.3,8.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O173">
      <attribute name="obj_pos">
        <point val="1.9,8.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.45812,8.399;2.34187,8.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[6].SRYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,8.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O174">
      <attribute name="obj_pos">
        <point val="18.3,8.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.886,8.399;18.3,8.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[6].NAIYO[9]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.3,8.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O175">
      <attribute name="obj_pos">
        <point val="19.9,8.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.486,8.399;19.9,8.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[6].NAIYO[10]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,8.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O176">
      <attribute name="obj_pos">
        <point val="3.9,9.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.486,8.999;3.9,9.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[7].NAIYO[0]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,9.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O177">
      <attribute name="obj_pos">
        <point val="5.5,9.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.086,8.999;5.5,9.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[7].NAIYO[1]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="5.5,9.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O178">
      <attribute name="obj_pos">
        <point val="7.1,9.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.686,8.999;7.1,9.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[7].NAIYO[2]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,9.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O179">
      <attribute name="obj_pos">
        <point val="8.7,9.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.286,8.999;8.7,9.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[7].NAIYO[3]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,9.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O180">
      <attribute name="obj_pos">
        <point val="10.3,9.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.886,8.999;10.3,9.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[7].NAIYO[4]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.3,9.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O181">
      <attribute name="obj_pos">
        <point val="11.9,9.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.486,8.999;11.9,9.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[7].NAIYO[5]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.9,9.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O182">
      <attribute name="obj_pos">
        <point val="13.5,9.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.086,8.999;13.5,9.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[7].NAIYO[6]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,9.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O183">
      <attribute name="obj_pos">
        <point val="15.1,9.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.686,8.999;15.1,9.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[7].NAIYO[7]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.1,9.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O184">
      <attribute name="obj_pos">
        <point val="16.7,9.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.286,8.999;16.7,9.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[7].NAIYO[8]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.7,9.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O185">
      <attribute name="obj_pos">
        <point val="1.3,9.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.9465,8.999;1.3,9.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[7].NUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.3,9.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O186">
      <attribute name="obj_pos">
        <point val="1.9,9.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.45812,8.999;2.34187,9.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[7].SRYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,9.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O187">
      <attribute name="obj_pos">
        <point val="18.3,9.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.886,8.999;18.3,9.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[7].NAIYO[9]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.3,9.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O188">
      <attribute name="obj_pos">
        <point val="19.9,9.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.486,8.999;19.9,9.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[7].NAIYO[10]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,9.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O189">
      <attribute name="obj_pos">
        <point val="3.9,9.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.486,9.599;3.9,9.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[8].NAIYO[0]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,9.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O190">
      <attribute name="obj_pos">
        <point val="5.5,9.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.086,9.599;5.5,9.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[8].NAIYO[1]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="5.5,9.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O191">
      <attribute name="obj_pos">
        <point val="7.1,9.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.686,9.599;7.1,9.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[8].NAIYO[2]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,9.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O192">
      <attribute name="obj_pos">
        <point val="8.7,9.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.286,9.599;8.7,9.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[8].NAIYO[3]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,9.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O193">
      <attribute name="obj_pos">
        <point val="10.3,9.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.886,9.599;10.3,9.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[8].NAIYO[4]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.3,9.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O194">
      <attribute name="obj_pos">
        <point val="11.9,9.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.486,9.599;11.9,9.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[8].NAIYO[5]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.9,9.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O195">
      <attribute name="obj_pos">
        <point val="13.5,9.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.086,9.599;13.5,9.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[8].NAIYO[6]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,9.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O196">
      <attribute name="obj_pos">
        <point val="15.1,9.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.686,9.599;15.1,9.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[8].NAIYO[7]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.1,9.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O197">
      <attribute name="obj_pos">
        <point val="16.7,9.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.286,9.599;16.7,9.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[8].NAIYO[8]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.7,9.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O198">
      <attribute name="obj_pos">
        <point val="1.3,9.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.9465,9.599;1.3,9.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[8].NUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.3,9.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O199">
      <attribute name="obj_pos">
        <point val="1.9,9.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.45812,9.599;2.34187,9.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[8].SRYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,9.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O200">
      <attribute name="obj_pos">
        <point val="18.3,9.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.886,9.599;18.3,9.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[8].NAIYO[9]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.3,9.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O201">
      <attribute name="obj_pos">
        <point val="19.9,9.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.486,9.599;19.9,9.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[8].NAIYO[10]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,9.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O202">
      <attribute name="obj_pos">
        <point val="3.9,10.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.486,10.199;3.9,10.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[9].NAIYO[0]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,10.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O203">
      <attribute name="obj_pos">
        <point val="5.5,10.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.086,10.199;5.5,10.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[9].NAIYO[1]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="5.5,10.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O204">
      <attribute name="obj_pos">
        <point val="7.1,10.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.686,10.199;7.1,10.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[9].NAIYO[2]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,10.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O205">
      <attribute name="obj_pos">
        <point val="8.7,10.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.286,10.199;8.7,10.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[9].NAIYO[3]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,10.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O206">
      <attribute name="obj_pos">
        <point val="10.3,10.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.886,10.199;10.3,10.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[9].NAIYO[4]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.3,10.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O207">
      <attribute name="obj_pos">
        <point val="11.9,10.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.486,10.199;11.9,10.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[9].NAIYO[5]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.9,10.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O208">
      <attribute name="obj_pos">
        <point val="13.5,10.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.086,10.199;13.5,10.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[9].NAIYO[6]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,10.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O209">
      <attribute name="obj_pos">
        <point val="15.1,10.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.686,10.199;15.1,10.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[9].NAIYO[7]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.1,10.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O210">
      <attribute name="obj_pos">
        <point val="16.7,10.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.286,10.199;16.7,10.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[9].NAIYO[8]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.7,10.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O211">
      <attribute name="obj_pos">
        <point val="1.3,10.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.9465,10.199;1.3,10.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[9].NUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.3,10.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O212">
      <attribute name="obj_pos">
        <point val="1.9,10.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.45812,10.199;2.34187,10.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[9].SRYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,10.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O213">
      <attribute name="obj_pos">
        <point val="18.3,10.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.886,10.199;18.3,10.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[9].NAIYO[9]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.3,10.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O214">
      <attribute name="obj_pos">
        <point val="19.9,10.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.486,10.199;19.9,10.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[9].NAIYO[10]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,10.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O215">
      <attribute name="obj_pos">
        <point val="3.9,11.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.486,10.799;3.9,11.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[10].NAIYO[0]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,11.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O216">
      <attribute name="obj_pos">
        <point val="5.5,11.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.086,10.799;5.5,11.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[10].NAIYO[1]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="5.5,11.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O217">
      <attribute name="obj_pos">
        <point val="7.1,11.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.686,10.799;7.1,11.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[10].NAIYO[2]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,11.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O218">
      <attribute name="obj_pos">
        <point val="8.7,11.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.286,10.799;8.7,11.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[10].NAIYO[3]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,11.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O219">
      <attribute name="obj_pos">
        <point val="10.3,11.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.886,10.799;10.3,11.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[10].NAIYO[4]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.3,11.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O220">
      <attribute name="obj_pos">
        <point val="11.9,11.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.486,10.799;11.9,11.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[10].NAIYO[5]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.9,11.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O221">
      <attribute name="obj_pos">
        <point val="13.5,11.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.086,10.799;13.5,11.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[10].NAIYO[6]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,11.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O222">
      <attribute name="obj_pos">
        <point val="15.1,11.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.686,10.799;15.1,11.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[10].NAIYO[7]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.1,11.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O223">
      <attribute name="obj_pos">
        <point val="16.7,11.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.286,10.799;16.7,11.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[10].NAIYO[8]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.7,11.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O224">
      <attribute name="obj_pos">
        <point val="1.3,11.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.9465,10.799;1.3,11.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[10].NUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.3,11.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O225">
      <attribute name="obj_pos">
        <point val="1.9,11.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.45812,10.799;2.34187,11.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[10].SRYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,11.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O226">
      <attribute name="obj_pos">
        <point val="18.3,11.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.886,10.799;18.3,11.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[10].NAIYO[9]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.3,11.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O227">
      <attribute name="obj_pos">
        <point val="19.9,11.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.486,10.799;19.9,11.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[10].NAIYO[10]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,11.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O228">
      <attribute name="obj_pos">
        <point val="3.9,11.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.486,11.399;3.9,11.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[11].NAIYO[0]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,11.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O229">
      <attribute name="obj_pos">
        <point val="5.5,11.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.086,11.399;5.5,11.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[11].NAIYO[1]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="5.5,11.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O230">
      <attribute name="obj_pos">
        <point val="7.1,11.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.686,11.399;7.1,11.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[11].NAIYO[2]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,11.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O231">
      <attribute name="obj_pos">
        <point val="8.7,11.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.286,11.399;8.7,11.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[11].NAIYO[3]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,11.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O232">
      <attribute name="obj_pos">
        <point val="10.3,11.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.886,11.399;10.3,11.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[11].NAIYO[4]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.3,11.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O233">
      <attribute name="obj_pos">
        <point val="11.9,11.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.486,11.399;11.9,11.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[11].NAIYO[5]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.9,11.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O234">
      <attribute name="obj_pos">
        <point val="13.5,11.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.086,11.399;13.5,11.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[11].NAIYO[6]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,11.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O235">
      <attribute name="obj_pos">
        <point val="15.1,11.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.686,11.399;15.1,11.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[11].NAIYO[7]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.1,11.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O236">
      <attribute name="obj_pos">
        <point val="16.7,11.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.286,11.399;16.7,11.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[11].NAIYO[8]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.7,11.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O237">
      <attribute name="obj_pos">
        <point val="1.3,11.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.9465,11.399;1.3,11.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[11].NUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.3,11.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O238">
      <attribute name="obj_pos">
        <point val="1.9,11.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.45812,11.399;2.34187,11.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[11].SRYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,11.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O239">
      <attribute name="obj_pos">
        <point val="18.3,11.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.886,11.399;18.3,11.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[11].NAIYO[9]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.3,11.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O240">
      <attribute name="obj_pos">
        <point val="19.9,11.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.486,11.399;19.9,11.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[11].NAIYO[10]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,11.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O241">
      <attribute name="obj_pos">
        <point val="3.9,12.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.486,11.999;3.9,12.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[12].NAIYO[0]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,12.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O242">
      <attribute name="obj_pos">
        <point val="5.5,12.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.086,11.999;5.5,12.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[12].NAIYO[1]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="5.5,12.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O243">
      <attribute name="obj_pos">
        <point val="7.1,12.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.686,11.999;7.1,12.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[12].NAIYO[2]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,12.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O244">
      <attribute name="obj_pos">
        <point val="8.7,12.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.286,11.999;8.7,12.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[12].NAIYO[3]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,12.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O245">
      <attribute name="obj_pos">
        <point val="10.3,12.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.886,11.999;10.3,12.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[12].NAIYO[4]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.3,12.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O246">
      <attribute name="obj_pos">
        <point val="11.9,12.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.486,11.999;11.9,12.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[12].NAIYO[5]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.9,12.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O247">
      <attribute name="obj_pos">
        <point val="13.5,12.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.086,11.999;13.5,12.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[12].NAIYO[6]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,12.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O248">
      <attribute name="obj_pos">
        <point val="15.1,12.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.686,11.999;15.1,12.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[12].NAIYO[7]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.1,12.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O249">
      <attribute name="obj_pos">
        <point val="16.7,12.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.286,11.999;16.7,12.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[12].NAIYO[8]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.7,12.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O250">
      <attribute name="obj_pos">
        <point val="1.3,12.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.9465,11.999;1.3,12.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[12].NUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.3,12.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O251">
      <attribute name="obj_pos">
        <point val="1.9,12.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.45812,11.999;2.34187,12.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[12].SRYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,12.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O252">
      <attribute name="obj_pos">
        <point val="18.3,12.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.886,11.999;18.3,12.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[12].NAIYO[9]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.3,12.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O253">
      <attribute name="obj_pos">
        <point val="19.9,12.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.486,11.999;19.9,12.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[12].NAIYO[10]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,12.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O254">
      <attribute name="obj_pos">
        <point val="3.9,12.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.486,12.599;3.9,12.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[13].NAIYO[0]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,12.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O255">
      <attribute name="obj_pos">
        <point val="5.5,12.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.086,12.599;5.5,12.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[13].NAIYO[1]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="5.5,12.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O256">
      <attribute name="obj_pos">
        <point val="7.1,12.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.686,12.599;7.1,12.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[13].NAIYO[2]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,12.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O257">
      <attribute name="obj_pos">
        <point val="8.7,12.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.286,12.599;8.7,12.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[13].NAIYO[3]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,12.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O258">
      <attribute name="obj_pos">
        <point val="10.3,12.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.886,12.599;10.3,12.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[13].NAIYO[4]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.3,12.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O259">
      <attribute name="obj_pos">
        <point val="11.9,12.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.486,12.599;11.9,12.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[13].NAIYO[5]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.9,12.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O260">
      <attribute name="obj_pos">
        <point val="13.5,12.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.086,12.599;13.5,12.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[13].NAIYO[6]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,12.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O261">
      <attribute name="obj_pos">
        <point val="15.1,12.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.686,12.599;15.1,12.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[13].NAIYO[7]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.1,12.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O262">
      <attribute name="obj_pos">
        <point val="16.7,12.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.286,12.599;16.7,12.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[13].NAIYO[8]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.7,12.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O263">
      <attribute name="obj_pos">
        <point val="1.3,12.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.9465,12.599;1.3,12.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[13].NUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.3,12.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O264">
      <attribute name="obj_pos">
        <point val="1.9,12.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.45812,12.599;2.34187,12.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[13].SRYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,12.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O265">
      <attribute name="obj_pos">
        <point val="18.3,12.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.886,12.599;18.3,12.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[13].NAIYO[9]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.3,12.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O266">
      <attribute name="obj_pos">
        <point val="19.9,12.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.486,12.599;19.9,12.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[13].NAIYO[10]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,12.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O267">
      <attribute name="obj_pos">
        <point val="3.9,13.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.486,13.199;3.9,13.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[14].NAIYO[0]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,13.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O268">
      <attribute name="obj_pos">
        <point val="5.5,13.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.086,13.199;5.5,13.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[14].NAIYO[1]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="5.5,13.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O269">
      <attribute name="obj_pos">
        <point val="7.1,13.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.686,13.199;7.1,13.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[14].NAIYO[2]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,13.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O270">
      <attribute name="obj_pos">
        <point val="8.7,13.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.286,13.199;8.7,13.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[14].NAIYO[3]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,13.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O271">
      <attribute name="obj_pos">
        <point val="10.3,13.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.886,13.199;10.3,13.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[14].NAIYO[4]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.3,13.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O272">
      <attribute name="obj_pos">
        <point val="11.9,13.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.486,13.199;11.9,13.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[14].NAIYO[5]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.9,13.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O273">
      <attribute name="obj_pos">
        <point val="13.5,13.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.086,13.199;13.5,13.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[14].NAIYO[6]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,13.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O274">
      <attribute name="obj_pos">
        <point val="15.1,13.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.686,13.199;15.1,13.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[14].NAIYO[7]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.1,13.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O275">
      <attribute name="obj_pos">
        <point val="16.7,13.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.286,13.199;16.7,13.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[14].NAIYO[8]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.7,13.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O276">
      <attribute name="obj_pos">
        <point val="1.3,13.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.9465,13.199;1.3,13.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[14].NUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.3,13.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O277">
      <attribute name="obj_pos">
        <point val="1.9,13.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.45812,13.199;2.34187,13.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[14].SRYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,13.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O278">
      <attribute name="obj_pos">
        <point val="18.3,13.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.886,13.199;18.3,13.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[14].NAIYO[9]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.3,13.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O279">
      <attribute name="obj_pos">
        <point val="19.9,13.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.486,13.199;19.9,13.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[14].NAIYO[10]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,13.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O280">
      <attribute name="obj_pos">
        <point val="3.9,14.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.486,13.799;3.9,14.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[15].NAIYO[0]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,14.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O281">
      <attribute name="obj_pos">
        <point val="5.5,14.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.086,13.799;5.5,14.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[15].NAIYO[1]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="5.5,14.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O282">
      <attribute name="obj_pos">
        <point val="7.1,14.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.686,13.799;7.1,14.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[15].NAIYO[2]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,14.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O283">
      <attribute name="obj_pos">
        <point val="8.7,14.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.286,13.799;8.7,14.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[15].NAIYO[3]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,14.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O284">
      <attribute name="obj_pos">
        <point val="10.3,14.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.886,13.799;10.3,14.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[15].NAIYO[4]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.3,14.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O285">
      <attribute name="obj_pos">
        <point val="11.9,14.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.486,13.799;11.9,14.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[15].NAIYO[5]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.9,14.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O286">
      <attribute name="obj_pos">
        <point val="13.5,14.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.086,13.799;13.5,14.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[15].NAIYO[6]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,14.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O287">
      <attribute name="obj_pos">
        <point val="15.1,14.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.686,13.799;15.1,14.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[15].NAIYO[7]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.1,14.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O288">
      <attribute name="obj_pos">
        <point val="16.7,14.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.286,13.799;16.7,14.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[15].NAIYO[8]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.7,14.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O289">
      <attribute name="obj_pos">
        <point val="1.3,14.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.9465,13.799;1.3,14.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[15].NUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.3,14.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O290">
      <attribute name="obj_pos">
        <point val="1.9,14.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.45812,13.799;2.34187,14.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[15].SRYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,14.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O291">
      <attribute name="obj_pos">
        <point val="18.3,14.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.886,13.799;18.3,14.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[15].NAIYO[9]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.3,14.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O292">
      <attribute name="obj_pos">
        <point val="19.9,14.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.486,13.799;19.9,14.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[15].NAIYO[10]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,14.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O293">
      <attribute name="obj_pos">
        <point val="3.9,14.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.486,14.399;3.9,14.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[16].NAIYO[0]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,14.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O294">
      <attribute name="obj_pos">
        <point val="5.5,14.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.086,14.399;5.5,14.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[16].NAIYO[1]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="5.5,14.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O295">
      <attribute name="obj_pos">
        <point val="7.1,14.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.686,14.399;7.1,14.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[16].NAIYO[2]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,14.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O296">
      <attribute name="obj_pos">
        <point val="8.7,14.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.286,14.399;8.7,14.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[16].NAIYO[3]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,14.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O297">
      <attribute name="obj_pos">
        <point val="10.3,14.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.886,14.399;10.3,14.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[16].NAIYO[4]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.3,14.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O298">
      <attribute name="obj_pos">
        <point val="11.9,14.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.486,14.399;11.9,14.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[16].NAIYO[5]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.9,14.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O299">
      <attribute name="obj_pos">
        <point val="13.5,14.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.086,14.399;13.5,14.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[16].NAIYO[6]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,14.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O300">
      <attribute name="obj_pos">
        <point val="15.1,14.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.686,14.399;15.1,14.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[16].NAIYO[7]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.1,14.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O301">
      <attribute name="obj_pos">
        <point val="16.7,14.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.286,14.399;16.7,14.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[16].NAIYO[8]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.7,14.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O302">
      <attribute name="obj_pos">
        <point val="1.3,14.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.9465,14.399;1.3,14.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[16].NUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.3,14.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O303">
      <attribute name="obj_pos">
        <point val="1.9,14.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.45812,14.399;2.34187,14.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[16].SRYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,14.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O304">
      <attribute name="obj_pos">
        <point val="18.3,14.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.886,14.399;18.3,14.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[16].NAIYO[9]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.3,14.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O305">
      <attribute name="obj_pos">
        <point val="19.9,14.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.486,14.399;19.9,14.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[16].NAIYO[10]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,14.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O306">
      <attribute name="obj_pos">
        <point val="3.9,15.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.486,14.999;3.9,15.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[17].NAIYO[0]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,15.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O307">
      <attribute name="obj_pos">
        <point val="5.5,15.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.086,14.999;5.5,15.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[17].NAIYO[1]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="5.5,15.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O308">
      <attribute name="obj_pos">
        <point val="7.1,15.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.686,14.999;7.1,15.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[17].NAIYO[2]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,15.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O309">
      <attribute name="obj_pos">
        <point val="8.7,15.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.286,14.999;8.7,15.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[17].NAIYO[3]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,15.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O310">
      <attribute name="obj_pos">
        <point val="10.3,15.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.886,14.999;10.3,15.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[17].NAIYO[4]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.3,15.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O311">
      <attribute name="obj_pos">
        <point val="11.9,15.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.486,14.999;11.9,15.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[17].NAIYO[5]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.9,15.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O312">
      <attribute name="obj_pos">
        <point val="13.5,15.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.086,14.999;13.5,15.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[17].NAIYO[6]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,15.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O313">
      <attribute name="obj_pos">
        <point val="15.1,15.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.686,14.999;15.1,15.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[17].NAIYO[7]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.1,15.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O314">
      <attribute name="obj_pos">
        <point val="16.7,15.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.286,14.999;16.7,15.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[17].NAIYO[8]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.7,15.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O315">
      <attribute name="obj_pos">
        <point val="1.3,15.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.9465,14.999;1.3,15.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[17].NUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.3,15.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O316">
      <attribute name="obj_pos">
        <point val="1.9,15.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.45812,14.999;2.34187,15.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[17].SRYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,15.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O317">
      <attribute name="obj_pos">
        <point val="18.3,15.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.886,14.999;18.3,15.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[17].NAIYO[9]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.3,15.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O318">
      <attribute name="obj_pos">
        <point val="19.9,15.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.486,14.999;19.9,15.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[17].NAIYO[10]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,15.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O319">
      <attribute name="obj_pos">
        <point val="3.9,15.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.486,15.599;3.9,15.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[18].NAIYO[0]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,15.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O320">
      <attribute name="obj_pos">
        <point val="5.5,15.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.086,15.599;5.5,15.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[18].NAIYO[1]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="5.5,15.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O321">
      <attribute name="obj_pos">
        <point val="7.1,15.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.686,15.599;7.1,15.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[18].NAIYO[2]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,15.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O322">
      <attribute name="obj_pos">
        <point val="8.7,15.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.286,15.599;8.7,15.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[18].NAIYO[3]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,15.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O323">
      <attribute name="obj_pos">
        <point val="10.3,15.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.886,15.599;10.3,15.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[18].NAIYO[4]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.3,15.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O324">
      <attribute name="obj_pos">
        <point val="11.9,15.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.486,15.599;11.9,15.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[18].NAIYO[5]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.9,15.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O325">
      <attribute name="obj_pos">
        <point val="13.5,15.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.086,15.599;13.5,15.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[18].NAIYO[6]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,15.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O326">
      <attribute name="obj_pos">
        <point val="15.1,15.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.686,15.599;15.1,15.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[18].NAIYO[7]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.1,15.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O327">
      <attribute name="obj_pos">
        <point val="16.7,15.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.286,15.599;16.7,15.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[18].NAIYO[8]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.7,15.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O328">
      <attribute name="obj_pos">
        <point val="1.3,15.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.9465,15.599;1.3,15.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[18].NUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.3,15.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O329">
      <attribute name="obj_pos">
        <point val="1.9,15.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.45812,15.599;2.34187,15.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[18].SRYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,15.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O330">
      <attribute name="obj_pos">
        <point val="18.3,15.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.886,15.599;18.3,15.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[18].NAIYO[9]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.3,15.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O331">
      <attribute name="obj_pos">
        <point val="19.9,15.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.486,15.599;19.9,15.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[18].NAIYO[10]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,15.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O332">
      <attribute name="obj_pos">
        <point val="3.9,16.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.486,16.199;3.9,16.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[19].NAIYO[0]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,16.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O333">
      <attribute name="obj_pos">
        <point val="5.5,16.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.086,16.199;5.5,16.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[19].NAIYO[1]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="5.5,16.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O334">
      <attribute name="obj_pos">
        <point val="7.1,16.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.686,16.199;7.1,16.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[19].NAIYO[2]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,16.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O335">
      <attribute name="obj_pos">
        <point val="8.7,16.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.286,16.199;8.7,16.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[19].NAIYO[3]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,16.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O336">
      <attribute name="obj_pos">
        <point val="10.3,16.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.886,16.199;10.3,16.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[19].NAIYO[4]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.3,16.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O337">
      <attribute name="obj_pos">
        <point val="11.9,16.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.486,16.199;11.9,16.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[19].NAIYO[5]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.9,16.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O338">
      <attribute name="obj_pos">
        <point val="13.5,16.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.086,16.199;13.5,16.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[19].NAIYO[6]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,16.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O339">
      <attribute name="obj_pos">
        <point val="15.1,16.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.686,16.199;15.1,16.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[19].NAIYO[7]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.1,16.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O340">
      <attribute name="obj_pos">
        <point val="16.7,16.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.286,16.199;16.7,16.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[19].NAIYO[8]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.7,16.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O341">
      <attribute name="obj_pos">
        <point val="1.3,16.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.9465,16.199;1.3,16.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[19].NUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.3,16.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O342">
      <attribute name="obj_pos">
        <point val="1.9,16.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.45812,16.199;2.34187,16.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[19].SRYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,16.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O343">
      <attribute name="obj_pos">
        <point val="18.3,16.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.886,16.199;18.3,16.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[19].NAIYO[9]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.3,16.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O344">
      <attribute name="obj_pos">
        <point val="19.9,16.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.486,16.199;19.9,16.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[19].NAIYO[10]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,16.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O345">
      <attribute name="obj_pos">
        <point val="3.9,17.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.486,16.799;3.9,17.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[20].NAIYO[0]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,17.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O346">
      <attribute name="obj_pos">
        <point val="5.5,17.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.086,16.799;5.5,17.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[20].NAIYO[1]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="5.5,17.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O347">
      <attribute name="obj_pos">
        <point val="7.1,17.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.686,16.799;7.1,17.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[20].NAIYO[2]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,17.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O348">
      <attribute name="obj_pos">
        <point val="8.7,17.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.286,16.799;8.7,17.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[20].NAIYO[3]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,17.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O349">
      <attribute name="obj_pos">
        <point val="10.3,17.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.886,16.799;10.3,17.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[20].NAIYO[4]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.3,17.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O350">
      <attribute name="obj_pos">
        <point val="11.9,17.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.486,16.799;11.9,17.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[20].NAIYO[5]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.9,17.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O351">
      <attribute name="obj_pos">
        <point val="13.5,17.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.086,16.799;13.5,17.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[20].NAIYO[6]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,17.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O352">
      <attribute name="obj_pos">
        <point val="15.1,17.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.686,16.799;15.1,17.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[20].NAIYO[7]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.1,17.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O353">
      <attribute name="obj_pos">
        <point val="16.7,17.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.286,16.799;16.7,17.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[20].NAIYO[8]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.7,17.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O354">
      <attribute name="obj_pos">
        <point val="1.3,17.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.9465,16.799;1.3,17.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[20].NUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.3,17.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O355">
      <attribute name="obj_pos">
        <point val="1.9,17.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.45812,16.799;2.34187,17.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[20].SRYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,17.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O356">
      <attribute name="obj_pos">
        <point val="18.3,17.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.886,16.799;18.3,17.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[20].NAIYO[9]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.3,17.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O357">
      <attribute name="obj_pos">
        <point val="19.9,17.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.486,16.799;19.9,17.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[20].NAIYO[10]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,17.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O358">
      <attribute name="obj_pos">
        <point val="3.9,17.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.486,17.399;3.9,17.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[21].NAIYO[0]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,17.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O359">
      <attribute name="obj_pos">
        <point val="5.5,17.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.086,17.399;5.5,17.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[21].NAIYO[1]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="5.5,17.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O360">
      <attribute name="obj_pos">
        <point val="7.1,17.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.686,17.399;7.1,17.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[21].NAIYO[2]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,17.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O361">
      <attribute name="obj_pos">
        <point val="8.7,17.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.286,17.399;8.7,17.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[21].NAIYO[3]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,17.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O362">
      <attribute name="obj_pos">
        <point val="10.3,17.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.886,17.399;10.3,17.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[21].NAIYO[4]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.3,17.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O363">
      <attribute name="obj_pos">
        <point val="11.9,17.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.486,17.399;11.9,17.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[21].NAIYO[5]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.9,17.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O364">
      <attribute name="obj_pos">
        <point val="13.5,17.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.086,17.399;13.5,17.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[21].NAIYO[6]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,17.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O365">
      <attribute name="obj_pos">
        <point val="15.1,17.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.686,17.399;15.1,17.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[21].NAIYO[7]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.1,17.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O366">
      <attribute name="obj_pos">
        <point val="16.7,17.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.286,17.399;16.7,17.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[21].NAIYO[8]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.7,17.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O367">
      <attribute name="obj_pos">
        <point val="1.3,17.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.9465,17.399;1.3,17.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[21].NUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.3,17.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O368">
      <attribute name="obj_pos">
        <point val="1.9,17.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.45812,17.399;2.34187,17.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[21].SRYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,17.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O369">
      <attribute name="obj_pos">
        <point val="18.3,17.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.886,17.399;18.3,17.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[21].NAIYO[9]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.3,17.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O370">
      <attribute name="obj_pos">
        <point val="19.9,17.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.486,17.399;19.9,17.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[21].NAIYO[10]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,17.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O371">
      <attribute name="obj_pos">
        <point val="3.9,18.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.486,17.999;3.9,18.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[22].NAIYO[0]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,18.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O372">
      <attribute name="obj_pos">
        <point val="5.5,18.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.086,17.999;5.5,18.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[22].NAIYO[1]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="5.5,18.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O373">
      <attribute name="obj_pos">
        <point val="7.1,18.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.686,17.999;7.1,18.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[22].NAIYO[2]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,18.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O374">
      <attribute name="obj_pos">
        <point val="8.7,18.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.286,17.999;8.7,18.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[22].NAIYO[3]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,18.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O375">
      <attribute name="obj_pos">
        <point val="10.3,18.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.886,17.999;10.3,18.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[22].NAIYO[4]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.3,18.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O376">
      <attribute name="obj_pos">
        <point val="11.9,18.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.486,17.999;11.9,18.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[22].NAIYO[5]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.9,18.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O377">
      <attribute name="obj_pos">
        <point val="13.5,18.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.086,17.999;13.5,18.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[22].NAIYO[6]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,18.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O378">
      <attribute name="obj_pos">
        <point val="15.1,18.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.686,17.999;15.1,18.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[22].NAIYO[7]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.1,18.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O379">
      <attribute name="obj_pos">
        <point val="16.7,18.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.286,17.999;16.7,18.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[22].NAIYO[8]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.7,18.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O380">
      <attribute name="obj_pos">
        <point val="1.3,18.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.9465,17.999;1.3,18.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[22].NUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.3,18.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O381">
      <attribute name="obj_pos">
        <point val="1.9,18.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.45812,17.999;2.34187,18.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[22].SRYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,18.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O382">
      <attribute name="obj_pos">
        <point val="18.3,18.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.886,17.999;18.3,18.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[22].NAIYO[9]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.3,18.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O383">
      <attribute name="obj_pos">
        <point val="19.9,18.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.486,17.999;19.9,18.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[22].NAIYO[10]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,18.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O384">
      <attribute name="obj_pos">
        <point val="3.9,18.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.486,18.599;3.9,18.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[23].NAIYO[0]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,18.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O385">
      <attribute name="obj_pos">
        <point val="5.5,18.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.086,18.599;5.5,18.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[23].NAIYO[1]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="5.5,18.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O386">
      <attribute name="obj_pos">
        <point val="7.1,18.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.686,18.599;7.1,18.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[23].NAIYO[2]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,18.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O387">
      <attribute name="obj_pos">
        <point val="8.7,18.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.286,18.599;8.7,18.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[23].NAIYO[3]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,18.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O388">
      <attribute name="obj_pos">
        <point val="10.3,18.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.886,18.599;10.3,18.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[23].NAIYO[4]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.3,18.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O389">
      <attribute name="obj_pos">
        <point val="11.9,18.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.486,18.599;11.9,18.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[23].NAIYO[5]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.9,18.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O390">
      <attribute name="obj_pos">
        <point val="13.5,18.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.086,18.599;13.5,18.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[23].NAIYO[6]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,18.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O391">
      <attribute name="obj_pos">
        <point val="15.1,18.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.686,18.599;15.1,18.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[23].NAIYO[7]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.1,18.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O392">
      <attribute name="obj_pos">
        <point val="16.7,18.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.286,18.599;16.7,18.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[23].NAIYO[8]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.7,18.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O393">
      <attribute name="obj_pos">
        <point val="1.3,18.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.9465,18.599;1.3,18.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[23].NUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.3,18.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O394">
      <attribute name="obj_pos">
        <point val="1.9,18.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.45812,18.599;2.34187,18.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[23].SRYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,18.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O395">
      <attribute name="obj_pos">
        <point val="18.3,18.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.886,18.599;18.3,18.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[23].NAIYO[9]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.3,18.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O396">
      <attribute name="obj_pos">
        <point val="19.9,18.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.486,18.599;19.9,18.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[23].NAIYO[10]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,18.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O397">
      <attribute name="obj_pos">
        <point val="3.9,19.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.486,19.199;3.9,19.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[24].NAIYO[0]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,19.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O398">
      <attribute name="obj_pos">
        <point val="5.5,19.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.086,19.199;5.5,19.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[24].NAIYO[1]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="5.5,19.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O399">
      <attribute name="obj_pos">
        <point val="7.1,19.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.686,19.199;7.1,19.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[24].NAIYO[2]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,19.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O400">
      <attribute name="obj_pos">
        <point val="8.7,19.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.286,19.199;8.7,19.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[24].NAIYO[3]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,19.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O401">
      <attribute name="obj_pos">
        <point val="10.3,19.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.886,19.199;10.3,19.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[24].NAIYO[4]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.3,19.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O402">
      <attribute name="obj_pos">
        <point val="11.9,19.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.486,19.199;11.9,19.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[24].NAIYO[5]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.9,19.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O403">
      <attribute name="obj_pos">
        <point val="13.5,19.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.086,19.199;13.5,19.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[24].NAIYO[6]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,19.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O404">
      <attribute name="obj_pos">
        <point val="15.1,19.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.686,19.199;15.1,19.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[24].NAIYO[7]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.1,19.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O405">
      <attribute name="obj_pos">
        <point val="16.7,19.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.286,19.199;16.7,19.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[24].NAIYO[8]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.7,19.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O406">
      <attribute name="obj_pos">
        <point val="1.3,19.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.9465,19.199;1.3,19.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[24].NUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.3,19.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O407">
      <attribute name="obj_pos">
        <point val="1.9,19.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.45812,19.199;2.34187,19.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[24].SRYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,19.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O408">
      <attribute name="obj_pos">
        <point val="18.3,19.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.886,19.199;18.3,19.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[24].NAIYO[9]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.3,19.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O409">
      <attribute name="obj_pos">
        <point val="19.9,19.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.486,19.199;19.9,19.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[24].NAIYO[10]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,19.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O410">
      <attribute name="obj_pos">
        <point val="3.9,20.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.486,19.799;3.9,20.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[25].NAIYO[0]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,20.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O411">
      <attribute name="obj_pos">
        <point val="5.5,20.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.086,19.799;5.5,20.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[25].NAIYO[1]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="5.5,20.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O412">
      <attribute name="obj_pos">
        <point val="7.1,20.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.686,19.799;7.1,20.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[25].NAIYO[2]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,20.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O413">
      <attribute name="obj_pos">
        <point val="8.7,20.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.286,19.799;8.7,20.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[25].NAIYO[3]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,20.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O414">
      <attribute name="obj_pos">
        <point val="10.3,20.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.886,19.799;10.3,20.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[25].NAIYO[4]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.3,20.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O415">
      <attribute name="obj_pos">
        <point val="11.9,20.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.486,19.799;11.9,20.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[25].NAIYO[5]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.9,20.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O416">
      <attribute name="obj_pos">
        <point val="13.5,20.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.086,19.799;13.5,20.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[25].NAIYO[6]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,20.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O417">
      <attribute name="obj_pos">
        <point val="15.1,20.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.686,19.799;15.1,20.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[25].NAIYO[7]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.1,20.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O418">
      <attribute name="obj_pos">
        <point val="16.7,20.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.286,19.799;16.7,20.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[25].NAIYO[8]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.7,20.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O419">
      <attribute name="obj_pos">
        <point val="1.3,20.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.9465,19.799;1.3,20.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[25].NUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.3,20.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O420">
      <attribute name="obj_pos">
        <point val="1.9,20.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.45812,19.799;2.34187,20.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[25].SRYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,20.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O421">
      <attribute name="obj_pos">
        <point val="18.3,20.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.886,19.799;18.3,20.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[25].NAIYO[9]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.3,20.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O422">
      <attribute name="obj_pos">
        <point val="19.9,20.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.486,19.799;19.9,20.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[25].NAIYO[10]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,20.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O423">
      <attribute name="obj_pos">
        <point val="3.9,20.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.486,20.399;3.9,20.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[26].NAIYO[0]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,20.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O424">
      <attribute name="obj_pos">
        <point val="5.5,20.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.086,20.399;5.5,20.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[26].NAIYO[1]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="5.5,20.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O425">
      <attribute name="obj_pos">
        <point val="7.1,20.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.686,20.399;7.1,20.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[26].NAIYO[2]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,20.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O426">
      <attribute name="obj_pos">
        <point val="8.7,20.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.286,20.399;8.7,20.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[26].NAIYO[3]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,20.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O427">
      <attribute name="obj_pos">
        <point val="10.3,20.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.886,20.399;10.3,20.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[26].NAIYO[4]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.3,20.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O428">
      <attribute name="obj_pos">
        <point val="11.9,20.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.486,20.399;11.9,20.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[26].NAIYO[5]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.9,20.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O429">
      <attribute name="obj_pos">
        <point val="13.5,20.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.086,20.399;13.5,20.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[26].NAIYO[6]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,20.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O430">
      <attribute name="obj_pos">
        <point val="15.1,20.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.686,20.399;15.1,20.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[26].NAIYO[7]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.1,20.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O431">
      <attribute name="obj_pos">
        <point val="16.7,20.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.286,20.399;16.7,20.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[26].NAIYO[8]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.7,20.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O432">
      <attribute name="obj_pos">
        <point val="1.3,20.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.9465,20.399;1.3,20.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[26].NUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.3,20.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O433">
      <attribute name="obj_pos">
        <point val="1.9,20.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.45812,20.399;2.34187,20.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[26].SRYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,20.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O434">
      <attribute name="obj_pos">
        <point val="18.3,20.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.886,20.399;18.3,20.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[26].NAIYO[9]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.3,20.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O435">
      <attribute name="obj_pos">
        <point val="19.9,20.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.486,20.399;19.9,20.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[26].NAIYO[10]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,20.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O436">
      <attribute name="obj_pos">
        <point val="3.9,21.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.486,20.999;3.9,21.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[27].NAIYO[0]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,21.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O437">
      <attribute name="obj_pos">
        <point val="5.5,21.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.086,20.999;5.5,21.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[27].NAIYO[1]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="5.5,21.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O438">
      <attribute name="obj_pos">
        <point val="7.1,21.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.686,20.999;7.1,21.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[27].NAIYO[2]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,21.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O439">
      <attribute name="obj_pos">
        <point val="8.7,21.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.286,20.999;8.7,21.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[27].NAIYO[3]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,21.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O440">
      <attribute name="obj_pos">
        <point val="10.3,21.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.886,20.999;10.3,21.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[27].NAIYO[4]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.3,21.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O441">
      <attribute name="obj_pos">
        <point val="11.9,21.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.486,20.999;11.9,21.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[27].NAIYO[5]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.9,21.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O442">
      <attribute name="obj_pos">
        <point val="13.5,21.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.086,20.999;13.5,21.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[27].NAIYO[6]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,21.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O443">
      <attribute name="obj_pos">
        <point val="15.1,21.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.686,20.999;15.1,21.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[27].NAIYO[7]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.1,21.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O444">
      <attribute name="obj_pos">
        <point val="16.7,21.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.286,20.999;16.7,21.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[27].NAIYO[8]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.7,21.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O445">
      <attribute name="obj_pos">
        <point val="1.3,21.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.9465,20.999;1.3,21.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[27].NUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.3,21.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O446">
      <attribute name="obj_pos">
        <point val="1.9,21.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.45812,20.999;2.34187,21.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[27].SRYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,21.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O447">
      <attribute name="obj_pos">
        <point val="18.3,21.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.886,20.999;18.3,21.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[27].NAIYO[9]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.3,21.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O448">
      <attribute name="obj_pos">
        <point val="19.9,21.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.486,20.999;19.9,21.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[27].NAIYO[10]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,21.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O449">
      <attribute name="obj_pos">
        <point val="3.9,21.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.486,21.599;3.9,21.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[28].NAIYO[0]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,21.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O450">
      <attribute name="obj_pos">
        <point val="5.5,21.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.086,21.599;5.5,21.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[28].NAIYO[1]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="5.5,21.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O451">
      <attribute name="obj_pos">
        <point val="7.1,21.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.686,21.599;7.1,21.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[28].NAIYO[2]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,21.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O452">
      <attribute name="obj_pos">
        <point val="8.7,21.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.286,21.599;8.7,21.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[28].NAIYO[3]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,21.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O453">
      <attribute name="obj_pos">
        <point val="10.3,21.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.886,21.599;10.3,21.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[28].NAIYO[4]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.3,21.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O454">
      <attribute name="obj_pos">
        <point val="11.9,21.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.486,21.599;11.9,21.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[28].NAIYO[5]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.9,21.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O455">
      <attribute name="obj_pos">
        <point val="13.5,21.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.086,21.599;13.5,21.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[28].NAIYO[6]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,21.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O456">
      <attribute name="obj_pos">
        <point val="15.1,21.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.686,21.599;15.1,21.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[28].NAIYO[7]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.1,21.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O457">
      <attribute name="obj_pos">
        <point val="16.7,21.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.286,21.599;16.7,21.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[28].NAIYO[8]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.7,21.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O458">
      <attribute name="obj_pos">
        <point val="1.3,21.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.9465,21.599;1.3,21.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[28].NUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.3,21.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O459">
      <attribute name="obj_pos">
        <point val="1.9,21.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.45812,21.599;2.34187,21.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[28].SRYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,21.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O460">
      <attribute name="obj_pos">
        <point val="18.3,21.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.886,21.599;18.3,21.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[28].NAIYO[9]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.3,21.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O461">
      <attribute name="obj_pos">
        <point val="19.9,21.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.486,21.599;19.9,21.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[28].NAIYO[10]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,21.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O462">
      <attribute name="obj_pos">
        <point val="3.9,22.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.486,22.199;3.9,22.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[29].NAIYO[0]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,22.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O463">
      <attribute name="obj_pos">
        <point val="5.5,22.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.086,22.199;5.5,22.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[29].NAIYO[1]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="5.5,22.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O464">
      <attribute name="obj_pos">
        <point val="7.1,22.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.686,22.199;7.1,22.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[29].NAIYO[2]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,22.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O465">
      <attribute name="obj_pos">
        <point val="8.7,22.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.286,22.199;8.7,22.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[29].NAIYO[3]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,22.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O466">
      <attribute name="obj_pos">
        <point val="10.3,22.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.886,22.199;10.3,22.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[29].NAIYO[4]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.3,22.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O467">
      <attribute name="obj_pos">
        <point val="11.9,22.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.486,22.199;11.9,22.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[29].NAIYO[5]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.9,22.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O468">
      <attribute name="obj_pos">
        <point val="13.5,22.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.086,22.199;13.5,22.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[29].NAIYO[6]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,22.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O469">
      <attribute name="obj_pos">
        <point val="15.1,22.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.686,22.199;15.1,22.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[29].NAIYO[7]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.1,22.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O470">
      <attribute name="obj_pos">
        <point val="16.7,22.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.286,22.199;16.7,22.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[29].NAIYO[8]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.7,22.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O471">
      <attribute name="obj_pos">
        <point val="1.3,22.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.9465,22.199;1.3,22.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[29].NUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.3,22.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O472">
      <attribute name="obj_pos">
        <point val="1.9,22.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.45812,22.199;2.34187,22.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[29].SRYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,22.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O473">
      <attribute name="obj_pos">
        <point val="18.3,22.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.886,22.199;18.3,22.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[29].NAIYO[9]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.3,22.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O474">
      <attribute name="obj_pos">
        <point val="19.9,22.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.486,22.199;19.9,22.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[29].NAIYO[10]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,22.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O475">
      <attribute name="obj_pos">
        <point val="3.9,23.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.486,22.799;3.9,23.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[30].NAIYO[0]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,23.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O476">
      <attribute name="obj_pos">
        <point val="5.5,23.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.086,22.799;5.5,23.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[30].NAIYO[1]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="5.5,23.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O477">
      <attribute name="obj_pos">
        <point val="7.1,23.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.686,22.799;7.1,23.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[30].NAIYO[2]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,23.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O478">
      <attribute name="obj_pos">
        <point val="8.7,23.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.286,22.799;8.7,23.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[30].NAIYO[3]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,23.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O479">
      <attribute name="obj_pos">
        <point val="10.3,23.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.886,22.799;10.3,23.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[30].NAIYO[4]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.3,23.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O480">
      <attribute name="obj_pos">
        <point val="11.9,23.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.486,22.799;11.9,23.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[30].NAIYO[5]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.9,23.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O481">
      <attribute name="obj_pos">
        <point val="13.5,23.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.086,22.799;13.5,23.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[30].NAIYO[6]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,23.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O482">
      <attribute name="obj_pos">
        <point val="15.1,23.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.686,22.799;15.1,23.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[30].NAIYO[7]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.1,23.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O483">
      <attribute name="obj_pos">
        <point val="16.7,23.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.286,22.799;16.7,23.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[30].NAIYO[8]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.7,23.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O484">
      <attribute name="obj_pos">
        <point val="1.3,23.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.9465,22.799;1.3,23.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[30].NUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.3,23.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O485">
      <attribute name="obj_pos">
        <point val="1.9,23.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.45812,22.799;2.34187,23.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[30].SRYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,23.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O486">
      <attribute name="obj_pos">
        <point val="18.3,23.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.886,22.799;18.3,23.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[30].NAIYO[9]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.3,23.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O487">
      <attribute name="obj_pos">
        <point val="19.9,23.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.486,22.799;19.9,23.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[30].NAIYO[10]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,23.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O488">
      <attribute name="obj_pos">
        <point val="3.9,23.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.486,23.399;3.9,23.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[31].NAIYO[0]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,23.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O489">
      <attribute name="obj_pos">
        <point val="5.5,23.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.086,23.399;5.5,23.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[31].NAIYO[1]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="5.5,23.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O490">
      <attribute name="obj_pos">
        <point val="7.1,23.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.686,23.399;7.1,23.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[31].NAIYO[2]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,23.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O491">
      <attribute name="obj_pos">
        <point val="8.7,23.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.286,23.399;8.7,23.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[31].NAIYO[3]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,23.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O492">
      <attribute name="obj_pos">
        <point val="10.3,23.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.886,23.399;10.3,23.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[31].NAIYO[4]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.3,23.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O493">
      <attribute name="obj_pos">
        <point val="11.9,23.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.486,23.399;11.9,23.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[31].NAIYO[5]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.9,23.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O494">
      <attribute name="obj_pos">
        <point val="13.5,23.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.086,23.399;13.5,23.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[31].NAIYO[6]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,23.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O495">
      <attribute name="obj_pos">
        <point val="15.1,23.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.686,23.399;15.1,23.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[31].NAIYO[7]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.1,23.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O496">
      <attribute name="obj_pos">
        <point val="16.7,23.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.286,23.399;16.7,23.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[31].NAIYO[8]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.7,23.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O497">
      <attribute name="obj_pos">
        <point val="1.3,23.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.9465,23.399;1.3,23.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[31].NUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.3,23.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O498">
      <attribute name="obj_pos">
        <point val="1.9,23.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.45812,23.399;2.34187,23.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[31].SRYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,23.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O499">
      <attribute name="obj_pos">
        <point val="18.3,23.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.886,23.399;18.3,23.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[31].NAIYO[9]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.3,23.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O500">
      <attribute name="obj_pos">
        <point val="19.9,23.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.486,23.399;19.9,23.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[31].NAIYO[10]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,23.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O501">
      <attribute name="obj_pos">
        <point val="3.9,24.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.486,23.999;3.9,24.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[32].NAIYO[0]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,24.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O502">
      <attribute name="obj_pos">
        <point val="5.5,24.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.086,23.999;5.5,24.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[32].NAIYO[1]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="5.5,24.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O503">
      <attribute name="obj_pos">
        <point val="7.1,24.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.686,23.999;7.1,24.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[32].NAIYO[2]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,24.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O504">
      <attribute name="obj_pos">
        <point val="8.7,24.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.286,23.999;8.7,24.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[32].NAIYO[3]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,24.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O505">
      <attribute name="obj_pos">
        <point val="10.3,24.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.886,23.999;10.3,24.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[32].NAIYO[4]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.3,24.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O506">
      <attribute name="obj_pos">
        <point val="11.9,24.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.486,23.999;11.9,24.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[32].NAIYO[5]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.9,24.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O507">
      <attribute name="obj_pos">
        <point val="13.5,24.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.086,23.999;13.5,24.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[32].NAIYO[6]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,24.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O508">
      <attribute name="obj_pos">
        <point val="15.1,24.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.686,23.999;15.1,24.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[32].NAIYO[7]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.1,24.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O509">
      <attribute name="obj_pos">
        <point val="16.7,24.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.286,23.999;16.7,24.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[32].NAIYO[8]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.7,24.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O510">
      <attribute name="obj_pos">
        <point val="1.3,24.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.9465,23.999;1.3,24.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[32].NUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.3,24.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O511">
      <attribute name="obj_pos">
        <point val="1.9,24.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.45812,23.999;2.34187,24.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[32].SRYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,24.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O512">
      <attribute name="obj_pos">
        <point val="18.3,24.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.886,23.999;18.3,24.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[32].NAIYO[9]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.3,24.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O513">
      <attribute name="obj_pos">
        <point val="19.9,24.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.486,23.999;19.9,24.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[32].NAIYO[10]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,24.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O514">
      <attribute name="obj_pos">
        <point val="3.9,24.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.486,24.599;3.9,24.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[33].NAIYO[0]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,24.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O515">
      <attribute name="obj_pos">
        <point val="5.5,24.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.086,24.599;5.5,24.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[33].NAIYO[1]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="5.5,24.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O516">
      <attribute name="obj_pos">
        <point val="7.1,24.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.686,24.599;7.1,24.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[33].NAIYO[2]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,24.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O517">
      <attribute name="obj_pos">
        <point val="8.7,24.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.286,24.599;8.7,24.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[33].NAIYO[3]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,24.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O518">
      <attribute name="obj_pos">
        <point val="10.3,24.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.886,24.599;10.3,24.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[33].NAIYO[4]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.3,24.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O519">
      <attribute name="obj_pos">
        <point val="11.9,24.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.486,24.599;11.9,24.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[33].NAIYO[5]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.9,24.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O520">
      <attribute name="obj_pos">
        <point val="13.5,24.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.086,24.599;13.5,24.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[33].NAIYO[6]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,24.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O521">
      <attribute name="obj_pos">
        <point val="15.1,24.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.686,24.599;15.1,24.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[33].NAIYO[7]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.1,24.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O522">
      <attribute name="obj_pos">
        <point val="16.7,24.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.286,24.599;16.7,24.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[33].NAIYO[8]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.7,24.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O523">
      <attribute name="obj_pos">
        <point val="1.3,24.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.9465,24.599;1.3,24.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[33].NUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.3,24.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O524">
      <attribute name="obj_pos">
        <point val="1.9,24.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.45812,24.599;2.34187,24.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[33].SRYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,24.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O525">
      <attribute name="obj_pos">
        <point val="18.3,24.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.886,24.599;18.3,24.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[33].NAIYO[9]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.3,24.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O526">
      <attribute name="obj_pos">
        <point val="19.9,24.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.486,24.599;19.9,24.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[33].NAIYO[10]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,24.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O527">
      <attribute name="obj_pos">
        <point val="3.9,25.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.486,25.199;3.9,25.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[34].NAIYO[0]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,25.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O528">
      <attribute name="obj_pos">
        <point val="5.5,25.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.086,25.199;5.5,25.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[34].NAIYO[1]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="5.5,25.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O529">
      <attribute name="obj_pos">
        <point val="7.1,25.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.686,25.199;7.1,25.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[34].NAIYO[2]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,25.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O530">
      <attribute name="obj_pos">
        <point val="8.7,25.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.286,25.199;8.7,25.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[34].NAIYO[3]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,25.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O531">
      <attribute name="obj_pos">
        <point val="10.3,25.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.886,25.199;10.3,25.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[34].NAIYO[4]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.3,25.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O532">
      <attribute name="obj_pos">
        <point val="11.9,25.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.486,25.199;11.9,25.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[34].NAIYO[5]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.9,25.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O533">
      <attribute name="obj_pos">
        <point val="13.5,25.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.086,25.199;13.5,25.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[34].NAIYO[6]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,25.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O534">
      <attribute name="obj_pos">
        <point val="15.1,25.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.686,25.199;15.1,25.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[34].NAIYO[7]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.1,25.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O535">
      <attribute name="obj_pos">
        <point val="16.7,25.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.286,25.199;16.7,25.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[34].NAIYO[8]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.7,25.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O536">
      <attribute name="obj_pos">
        <point val="1.3,25.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.9465,25.199;1.3,25.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[34].NUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.3,25.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O537">
      <attribute name="obj_pos">
        <point val="1.9,25.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.45812,25.199;2.34187,25.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[34].SRYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,25.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O538">
      <attribute name="obj_pos">
        <point val="18.3,25.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.886,25.199;18.3,25.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[34].NAIYO[9]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.3,25.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O539">
      <attribute name="obj_pos">
        <point val="19.9,25.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.486,25.199;19.9,25.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[34].NAIYO[10]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,25.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O540">
      <attribute name="obj_pos">
        <point val="3.9,26.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.486,25.799;3.9,26.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[35].NAIYO[0]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,26.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O541">
      <attribute name="obj_pos">
        <point val="5.5,26.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.086,25.799;5.5,26.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[35].NAIYO[1]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="5.5,26.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O542">
      <attribute name="obj_pos">
        <point val="7.1,26.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.686,25.799;7.1,26.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[35].NAIYO[2]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,26.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O543">
      <attribute name="obj_pos">
        <point val="8.7,26.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.286,25.799;8.7,26.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[35].NAIYO[3]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,26.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O544">
      <attribute name="obj_pos">
        <point val="10.3,26.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.886,25.799;10.3,26.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[35].NAIYO[4]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.3,26.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O545">
      <attribute name="obj_pos">
        <point val="11.9,26.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.486,25.799;11.9,26.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[35].NAIYO[5]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.9,26.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O546">
      <attribute name="obj_pos">
        <point val="13.5,26.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.086,25.799;13.5,26.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[35].NAIYO[6]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,26.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O547">
      <attribute name="obj_pos">
        <point val="15.1,26.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.686,25.799;15.1,26.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[35].NAIYO[7]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.1,26.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O548">
      <attribute name="obj_pos">
        <point val="16.7,26.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.286,25.799;16.7,26.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[35].NAIYO[8]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.7,26.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O549">
      <attribute name="obj_pos">
        <point val="1.3,26.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.9465,25.799;1.3,26.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[35].NUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.3,26.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O550">
      <attribute name="obj_pos">
        <point val="1.9,26.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.45812,25.799;2.34187,26.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[35].SRYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,26.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O551">
      <attribute name="obj_pos">
        <point val="18.3,26.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.886,25.799;18.3,26.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[35].NAIYO[9]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.3,26.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O552">
      <attribute name="obj_pos">
        <point val="19.9,26.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.486,25.799;19.9,26.149"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[35].NAIYO[10]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,26.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O553">
      <attribute name="obj_pos">
        <point val="3.9,26.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.486,26.399;3.9,26.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[36].NAIYO[0]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,26.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O554">
      <attribute name="obj_pos">
        <point val="5.5,26.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.086,26.399;5.5,26.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[36].NAIYO[1]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="5.5,26.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O555">
      <attribute name="obj_pos">
        <point val="7.1,26.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.686,26.399;7.1,26.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[36].NAIYO[2]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,26.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O556">
      <attribute name="obj_pos">
        <point val="8.7,26.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.286,26.399;8.7,26.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[36].NAIYO[3]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,26.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O557">
      <attribute name="obj_pos">
        <point val="10.3,26.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.886,26.399;10.3,26.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[36].NAIYO[4]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.3,26.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O558">
      <attribute name="obj_pos">
        <point val="11.9,26.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.486,26.399;11.9,26.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[36].NAIYO[5]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.9,26.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O559">
      <attribute name="obj_pos">
        <point val="13.5,26.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.086,26.399;13.5,26.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[36].NAIYO[6]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,26.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O560">
      <attribute name="obj_pos">
        <point val="15.1,26.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.686,26.399;15.1,26.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[36].NAIYO[7]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.1,26.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O561">
      <attribute name="obj_pos">
        <point val="16.7,26.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.286,26.399;16.7,26.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[36].NAIYO[8]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.7,26.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O562">
      <attribute name="obj_pos">
        <point val="1.3,26.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.9465,26.399;1.3,26.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[36].NUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.3,26.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O563">
      <attribute name="obj_pos">
        <point val="1.9,26.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.45812,26.399;2.34187,26.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[36].SRYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,26.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O564">
      <attribute name="obj_pos">
        <point val="18.3,26.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.886,26.399;18.3,26.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[36].NAIYO[9]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.3,26.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O565">
      <attribute name="obj_pos">
        <point val="19.9,26.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.486,26.399;19.9,26.749"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[36].NAIYO[10]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,26.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O566">
      <attribute name="obj_pos">
        <point val="3.9,27.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.486,26.999;3.9,27.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[37].NAIYO[0]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,27.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O567">
      <attribute name="obj_pos">
        <point val="5.5,27.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.086,26.999;5.5,27.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[37].NAIYO[1]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="5.5,27.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O568">
      <attribute name="obj_pos">
        <point val="7.1,27.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.686,26.999;7.1,27.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[37].NAIYO[2]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,27.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O569">
      <attribute name="obj_pos">
        <point val="8.7,27.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.286,26.999;8.7,27.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[37].NAIYO[3]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,27.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O570">
      <attribute name="obj_pos">
        <point val="10.3,27.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.886,26.999;10.3,27.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[37].NAIYO[4]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.3,27.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O571">
      <attribute name="obj_pos">
        <point val="11.9,27.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.486,26.999;11.9,27.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[37].NAIYO[5]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.9,27.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O572">
      <attribute name="obj_pos">
        <point val="13.5,27.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.086,26.999;13.5,27.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[37].NAIYO[6]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,27.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O573">
      <attribute name="obj_pos">
        <point val="15.1,27.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.686,26.999;15.1,27.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[37].NAIYO[7]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.1,27.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O574">
      <attribute name="obj_pos">
        <point val="16.7,27.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.286,26.999;16.7,27.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[37].NAIYO[8]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.7,27.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O575">
      <attribute name="obj_pos">
        <point val="1.3,27.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.9465,26.999;1.3,27.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[37].NUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.3,27.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O576">
      <attribute name="obj_pos">
        <point val="1.9,27.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.45812,26.999;2.34187,27.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[37].SRYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,27.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O577">
      <attribute name="obj_pos">
        <point val="18.3,27.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.886,26.999;18.3,27.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[37].NAIYO[9]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.3,27.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O578">
      <attribute name="obj_pos">
        <point val="19.9,27.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.486,26.999;19.9,27.349"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[37].NAIYO[10]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,27.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O579">
      <attribute name="obj_pos">
        <point val="3.9,27.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.486,27.599;3.9,27.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[38].NAIYO[0]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,27.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O580">
      <attribute name="obj_pos">
        <point val="5.5,27.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.086,27.599;5.5,27.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[38].NAIYO[1]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="5.5,27.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O581">
      <attribute name="obj_pos">
        <point val="7.1,27.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.686,27.599;7.1,27.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[38].NAIYO[2]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,27.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O582">
      <attribute name="obj_pos">
        <point val="8.7,27.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.286,27.599;8.7,27.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[38].NAIYO[3]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,27.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O583">
      <attribute name="obj_pos">
        <point val="10.3,27.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.886,27.599;10.3,27.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[38].NAIYO[4]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.3,27.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O584">
      <attribute name="obj_pos">
        <point val="11.9,27.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.486,27.599;11.9,27.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[38].NAIYO[5]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.9,27.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O585">
      <attribute name="obj_pos">
        <point val="13.5,27.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.086,27.599;13.5,27.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[38].NAIYO[6]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,27.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O586">
      <attribute name="obj_pos">
        <point val="15.1,27.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.686,27.599;15.1,27.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[38].NAIYO[7]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.1,27.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O587">
      <attribute name="obj_pos">
        <point val="16.7,27.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.286,27.599;16.7,27.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[38].NAIYO[8]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.7,27.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O588">
      <attribute name="obj_pos">
        <point val="1.3,27.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.9465,27.599;1.3,27.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[38].NUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.3,27.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O589">
      <attribute name="obj_pos">
        <point val="1.9,27.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.45812,27.599;2.34187,27.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[38].SRYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,27.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O590">
      <attribute name="obj_pos">
        <point val="18.3,27.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.886,27.599;18.3,27.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[38].NAIYO[9]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.3,27.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O591">
      <attribute name="obj_pos">
        <point val="19.9,27.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.486,27.599;19.9,27.949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[38].NAIYO[10]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,27.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O592">
      <attribute name="obj_pos">
        <point val="3.9,28.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.486,28.199;3.9,28.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[39].NAIYO[0]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,28.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O593">
      <attribute name="obj_pos">
        <point val="5.5,28.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.086,28.199;5.5,28.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[39].NAIYO[1]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="5.5,28.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O594">
      <attribute name="obj_pos">
        <point val="7.1,28.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.686,28.199;7.1,28.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[39].NAIYO[2]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,28.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O595">
      <attribute name="obj_pos">
        <point val="8.7,28.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.286,28.199;8.7,28.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[39].NAIYO[3]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,28.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O596">
      <attribute name="obj_pos">
        <point val="10.3,28.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.886,28.199;10.3,28.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[39].NAIYO[4]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.3,28.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O597">
      <attribute name="obj_pos">
        <point val="11.9,28.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.486,28.199;11.9,28.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[39].NAIYO[5]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.9,28.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O598">
      <attribute name="obj_pos">
        <point val="13.5,28.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.086,28.199;13.5,28.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[39].NAIYO[6]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,28.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O599">
      <attribute name="obj_pos">
        <point val="15.1,28.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.686,28.199;15.1,28.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[39].NAIYO[7]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.1,28.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O600">
      <attribute name="obj_pos">
        <point val="16.7,28.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.286,28.199;16.7,28.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[39].NAIYO[8]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.7,28.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O601">
      <attribute name="obj_pos">
        <point val="1.3,28.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.9465,28.199;1.3,28.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[39].NUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.3,28.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O602">
      <attribute name="obj_pos">
        <point val="1.9,28.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.45812,28.199;2.34187,28.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[39].SRYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,28.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O603">
      <attribute name="obj_pos">
        <point val="18.3,28.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.886,28.199;18.3,28.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[39].NAIYO[9]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.3,28.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O604">
      <attribute name="obj_pos">
        <point val="19.9,28.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.486,28.199;19.9,28.549"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[39].NAIYO[10]#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Mincho"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,28.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.17675"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
  </layer>
</diagram>
