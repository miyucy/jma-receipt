<?xml version="1.0"?>
<diagram xmlns:dia="http://www.lysator.liu.se/~alla/dia/">
  <dictionarydata>
    <element name="SYSYMD" occurs="1">
      <appinfo>
        <embed object="string" length="22"/>
      </appinfo>
    </element>
    <element name="SRYYMD" occurs="1">
      <appinfo>
        <embed object="string" length="22"/>
      </appinfo>
    </element>
    <element name="PAGE" occurs="1">
      <appinfo>
        <embed object="string" length="3"/>
      </appinfo>
    </element>
    <element name="MIDASI" occurs="1">
      <appinfo>
        <embed object="string" length="10"/>
      </appinfo>
    </element>
    <element name="NYUGAIKBN" occurs="1">
      <appinfo>
        <embed object="string" length="8"/>
      </appinfo>
    </element>
    <element name="GOKEI-G" occurs="11">
      <element name="GMONEY" occurs="1">
        <appinfo>
          <embed object="string" length="9"/>
        </appinfo>
      </element>
      <element name="GHKNTEN" occurs="1">
        <appinfo>
          <embed object="string" length="8"/>
        </appinfo>
      </element>
      <element name="GKENSU" occurs="1">
        <appinfo>
          <embed object="string" length="8"/>
        </appinfo>
      </element>
    </element>
    <element name="MEISAI-G" occurs="30">
      <element name="RENNUM" occurs="1">
        <appinfo>
          <embed object="string" length="3"/>
        </appinfo>
      </element>
      <element name="PTNUM" occurs="1">
        <appinfo>
          <embed object="string" length="10"/>
        </appinfo>
      </element>
      <element name="PTNUM2" occurs="1">
        <appinfo>
          <embed object="string" length="20"/>
        </appinfo>
      </element>
      <element name="NAME" occurs="1">
        <appinfo>
          <embed object="string" length="26"/>
        </appinfo>
      </element>
      <element name="HKNTEN" occurs="1">
        <appinfo>
          <embed object="string" length="8"/>
        </appinfo>
      </element>
    </element>
    <element name="MONEY-G" occurs="10">
      <element name="HKNNAME" occurs="1">
        <appinfo>
          <embed object="string" length="8"/>
        </appinfo>
      </element>
      <element name="MONEY-OCC" occurs="30">
        <element name="MONEY" occurs="1">
          <appinfo>
            <embed object="string" length="9"/>
          </appinfo>
        </element>
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
          <boolean val="false"/>
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
  <layer name="line" visible="true">
    <object type="Standard - Line" version="0" id="O0">
      <attribute name="obj_pos">
        <point val="1,3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.99,2.99;27.91,3.01"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,3"/>
        <point val="27.9,3"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.02"/>
      </attribute>
      <connections>
        <connection handle="0" to="O6" connection="1"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O1">
      <attribute name="obj_pos">
        <point val="1.8,2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.795,1.995;1.805,18.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.8,2"/>
        <point val="1.8,18"/>
      </attribute>
      <attribute name="numcp">
        <int val="31"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O2">
      <attribute name="obj_pos">
        <point val="6,19.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.99,19.49;27.91,19.51"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="6,19.5"/>
        <point val="27.9,19.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.02"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O3">
      <attribute name="obj_pos">
        <point val="1,18"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.99,17.99;27.91,18.01"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,18"/>
        <point val="27.9,18"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.02"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O4">
      <attribute name="obj_pos">
        <point val="1,2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.99,1.99;27.91,2.01"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,2"/>
        <point val="27.9,2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.02"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O5">
      <attribute name="obj_pos">
        <point val="6,18"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.99,17.99;6.01,19.51"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="6,18"/>
        <point val="6,19.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="2"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.02"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O6">
      <attribute name="obj_pos">
        <point val="1,2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.99,1.99;1.01,18.01"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,2"/>
        <point val="1,18"/>
      </attribute>
      <attribute name="numcp">
        <int val="31"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.02"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O7">
      <attribute name="obj_pos">
        <point val="27.9,2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.89,1.99;27.91,19.51"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="27.9,2"/>
        <point val="27.9,19.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="2"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.02"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O8">
      <attribute name="obj_pos">
        <point val="1,3.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,3.495;27.905,3.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,3.5"/>
        <point val="27.9,3.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O6" connection="2"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O9">
      <attribute name="obj_pos">
        <point val="1,5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,4.995;27.905,5.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,5"/>
        <point val="27.9,5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O6" connection="5"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O10">
      <attribute name="obj_pos">
        <point val="1,6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,5.995;27.905,6.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,6"/>
        <point val="27.9,6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O6" connection="7"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O11">
      <attribute name="obj_pos">
        <point val="1,7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,6.995;27.905,7.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,7"/>
        <point val="27.9,7"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O6" connection="9"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O12">
      <attribute name="obj_pos">
        <point val="1,6.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,6.495;27.905,6.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,6.5"/>
        <point val="27.9,6.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O6" connection="8"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O13">
      <attribute name="obj_pos">
        <point val="1,8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,7.995;27.905,8.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,8"/>
        <point val="27.9,8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O14">
      <attribute name="obj_pos">
        <point val="1,9.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,9.495;27.905,9.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,9.5"/>
        <point val="27.9,9.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O15">
      <attribute name="obj_pos">
        <point val="1,10.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,10.495;27.905,10.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,10.5"/>
        <point val="27.9,10.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O16">
      <attribute name="obj_pos">
        <point val="1,4.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,4.495;27.905,4.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,4.5"/>
        <point val="27.9,4.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O17">
      <attribute name="obj_pos">
        <point val="1,5.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,5.495;27.905,5.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,5.5"/>
        <point val="27.9,5.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O6" connection="6"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O18">
      <attribute name="obj_pos">
        <point val="1,7.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,7.495;27.905,7.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,7.5"/>
        <point val="27.9,7.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O6" connection="10"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O19">
      <attribute name="obj_pos">
        <point val="1,9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,8.995;27.905,9.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,9"/>
        <point val="27.9,9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O20">
      <attribute name="obj_pos">
        <point val="1,8.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,8.495;27.905,8.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,8.5"/>
        <point val="27.9,8.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O6" connection="12"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O21">
      <attribute name="obj_pos">
        <point val="1,10"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,9.995;27.905,10.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,10"/>
        <point val="27.9,10"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O22">
      <attribute name="obj_pos">
        <point val="1,4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,3.995;27.905,4.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,4"/>
        <point val="27.9,4"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O23">
      <attribute name="obj_pos">
        <point val="1,15.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,15.495;27.905,15.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,15.5"/>
        <point val="27.9,15.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O6" connection="26"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O24">
      <attribute name="obj_pos">
        <point val="1,15"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,14.995;27.905,15.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,15"/>
        <point val="27.9,15"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O25">
      <attribute name="obj_pos">
        <point val="1,14.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,14.495;27.905,14.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,14.5"/>
        <point val="27.9,14.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O26">
      <attribute name="obj_pos">
        <point val="1,14"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,13.995;27.905,14.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,14"/>
        <point val="27.9,14"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O27">
      <attribute name="obj_pos">
        <point val="1,13.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,13.495;27.905,13.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,13.5"/>
        <point val="27.9,13.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O28">
      <attribute name="obj_pos">
        <point val="1,13"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,12.995;27.905,13.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,13"/>
        <point val="27.9,13"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O29">
      <attribute name="obj_pos">
        <point val="1,12.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,12.495;27.905,12.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,12.5"/>
        <point val="27.9,12.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O6" connection="20"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O30">
      <attribute name="obj_pos">
        <point val="1,12"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,11.995;27.905,12.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,12"/>
        <point val="27.9,12"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O31">
      <attribute name="obj_pos">
        <point val="1,11.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,11.495;27.905,11.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,11.5"/>
        <point val="27.9,11.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O32">
      <attribute name="obj_pos">
        <point val="1,11"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,10.995;27.905,11.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,11"/>
        <point val="27.9,11"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O33">
      <attribute name="obj_pos">
        <point val="1,17.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,17.495;27.905,17.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,17.5"/>
        <point val="27.9,17.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O34">
      <attribute name="obj_pos">
        <point val="1,17"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,16.995;27.905,17.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,17"/>
        <point val="27.9,17"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O6" connection="29"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O35">
      <attribute name="obj_pos">
        <point val="1,16.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,16.495;27.905,16.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,16.5"/>
        <point val="27.9,16.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O36">
      <attribute name="obj_pos">
        <point val="1,16"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,15.995;27.905,16.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,16"/>
        <point val="27.9,16"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O37">
      <attribute name="obj_pos">
        <point val="5,2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.995,1.995;5.005,18.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="5,2"/>
        <point val="5,18"/>
      </attribute>
      <attribute name="numcp">
        <int val="31"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O38">
      <attribute name="obj_pos">
        <point val="9.2,2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.195,1.995;9.205,19.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="9.2,2"/>
        <point val="9.2,19.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="31"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O39">
      <attribute name="obj_pos">
        <point val="10.9,2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.895,1.995;10.905,19.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="10.9,2"/>
        <point val="10.9,19.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="31"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O40">
      <attribute name="obj_pos">
        <point val="12.6,2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.595,1.995;12.605,19.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="12.6,2"/>
        <point val="12.6,19.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="31"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O41">
      <attribute name="obj_pos">
        <point val="14.3,2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.295,1.995;14.305,19.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="14.3,2"/>
        <point val="14.3,19.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="31"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O42">
      <attribute name="obj_pos">
        <point val="16,2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.995,1.995;16.005,19.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="16,2"/>
        <point val="16,19.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="31"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O43">
      <attribute name="obj_pos">
        <point val="17.7,2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.695,1.995;17.705,19.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="17.7,2"/>
        <point val="17.7,19.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="31"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O44">
      <attribute name="obj_pos">
        <point val="24.5,2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.495,1.995;24.505,19.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="24.5,2"/>
        <point val="24.5,19.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="31"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O45">
      <attribute name="obj_pos">
        <point val="22.8,2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.795,1.995;22.805,19.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="22.8,2"/>
        <point val="22.8,19.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="31"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O46">
      <attribute name="obj_pos">
        <point val="21.1,2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.095,1.995;21.105,18.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="21.1,2"/>
        <point val="21.1,18"/>
      </attribute>
      <attribute name="numcp">
        <int val="31"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O47">
      <attribute name="obj_pos">
        <point val="19.4,2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.395,1.995;19.405,19.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="19.4,2"/>
        <point val="19.4,19.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="31"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O48">
      <attribute name="obj_pos">
        <point val="6,18.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.995,18.495;27.905,18.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="6,18.5"/>
        <point val="27.9,18.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O5" connection="0"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O49">
      <attribute name="obj_pos">
        <point val="6,19"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.995,18.995;27.905,19.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="6,19"/>
        <point val="27.9,19"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O50">
      <attribute name="obj_pos">
        <point val="21.1,18"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.095,17.995;21.105,19.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="21.1,18"/>
        <point val="21.1,19.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="2"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O51">
      <attribute name="obj_pos">
        <point val="26.2,2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.195,1.995;26.205,19.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="26.2,2"/>
        <point val="26.2,19.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="31"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
  </layer>
  <layer name="label" visible="true">
    <object type="Standard - Text" version="0" id="O52">
      <attribute name="obj_pos">
        <point val="12.1877,1.42892"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.1877,1.1104;17.4397,1.5104"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#246;&#161;&#246;&#161;&#246;&#161;&#161;&#198;&#252;&#161;&#161;&#183;&#215;&#161;&#161;&#201;&#189;&#161;&#161;&#161;&#246;&#161;&#246;&#161;&#246;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.4"/>
          </attribute>
          <attribute name="pos">
            <point val="12.1877,1.42892"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2424"/>
          </attribute>
          <attribute name="multi">
            <real val="0.202"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O53">
      <attribute name="obj_pos">
        <point val="7,18.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7,18.1213;8.8382,18.4713"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#193;&#237;&#185;&#231;&#183;&#215;(&#177;&#223;)#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7,18.4"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O54">
      <attribute name="obj_pos">
        <point val="7,18.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7,18.6213;8.8382,18.9713"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#193;&#237;&#185;&#231;&#183;&#215;(&#197;&#192;)#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7,18.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O55">
      <attribute name="obj_pos">
        <point val="7,19.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7,19.1213;8.7675,19.4713"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#193;&#237;&#161;&#161;&#183;&#239;&#161;&#161;&#191;&#244;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7,19.4"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O56">
      <attribute name="obj_pos">
        <point val="26.0527,1.3524"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.0527,1.0737;26.4062,1.4237"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#202;&#199;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.0527,1.3524"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O57">
      <attribute name="obj_pos">
        <point val="16.35,19.95"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.35,19.6713;28.369,20.0213"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#162;&#168;&#188;&#171;&#200;&#241;&#205;&#243;&#164;&#206;&#161;&#246;&#164;&#207;&#176;&#229;&#206;&#197;&#202;&#221;&#184;&#177;&#161;&#202;&#207;&#171;&#186;&#210;&#161;&#166;&#188;&#171;&#199;&#229;&#192;&#213;&#161;&#166;&#184;&#248;&#179;&#178;&#164;&#242;&#180;&#222;&#164;&#224;&#161;&#203;&#191;&#199;&#206;&#197;&#187;&#254;&#164;&#206;&#188;&#171;&#200;&#241;&#201;&#233;&#195;&#180;&#202;&#172;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.35,19.95"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O58">
      <attribute name="obj_pos">
        <point val="10.05,2.65"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.343,2.3713;10.757,2.7213"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#202;&#221;&#184;&#177;&#197;&#192;&#191;&#244;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.05,2.65"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O59">
      <attribute name="obj_pos">
        <point val="7.1,2.65"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.07485,2.3713;8.12515,2.7213"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#180;&#181; &#188;&#212; &#187;&#225; &#204;&#190;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,2.65"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O60">
      <attribute name="obj_pos">
        <point val="1.4,2.65"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0465,2.3713;1.7535,2.7213"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#207;&#162;&#200;&#214;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.4,2.65"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O61">
      <attribute name="obj_pos">
        <point val="3.35,2.65"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.643,2.3713;4.057,2.7213"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#180;&#181;&#188;&#212;&#200;&#214;&#185;&#230;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.35,2.65"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
  </layer>
  <layer name="entry2" visible="true">
    <object type="Embed - Text" version="0" id="O62">
      <attribute name="obj_pos">
        <point val="1.85,3.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,3.15093;4.88,3.40093"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[0].PTNUM2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#12345678901234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.25"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,3.35"/>
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
            <real val="0.12625"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O63">
      <attribute name="obj_pos">
        <point val="1.85,3.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,3.65093;4.88,3.90093"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[1].PTNUM2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#12345678901234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.25"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,3.85"/>
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
            <real val="0.12625"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O64">
      <attribute name="obj_pos">
        <point val="1.85,4.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,4.15093;4.88,4.40093"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[2].PTNUM2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#12345678901234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.25"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,4.35"/>
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
            <real val="0.12625"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O65">
      <attribute name="obj_pos">
        <point val="1.85,4.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,4.65093;4.88,4.90093"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[3].PTNUM2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#12345678901234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.25"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,4.85"/>
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
            <real val="0.12625"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O66">
      <attribute name="obj_pos">
        <point val="1.85,5.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,5.15093;4.88,5.40093"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[4].PTNUM2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#12345678901234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.25"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,5.35"/>
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
            <real val="0.12625"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O67">
      <attribute name="obj_pos">
        <point val="1.85,5.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,5.65093;4.88,5.90093"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[5].PTNUM2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#12345678901234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.25"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,5.85"/>
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
            <real val="0.12625"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O68">
      <attribute name="obj_pos">
        <point val="1.85,6.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,6.15093;4.88,6.40093"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[6].PTNUM2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#12345678901234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.25"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,6.35"/>
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
            <real val="0.12625"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O69">
      <attribute name="obj_pos">
        <point val="1.85,6.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,6.65093;4.88,6.90093"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[7].PTNUM2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#12345678901234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.25"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,6.85"/>
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
            <real val="0.12625"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O70">
      <attribute name="obj_pos">
        <point val="1.85,7.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,7.15093;4.88,7.40093"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[8].PTNUM2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#12345678901234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.25"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,7.35"/>
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
            <real val="0.12625"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O71">
      <attribute name="obj_pos">
        <point val="1.85,7.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,7.65093;4.88,7.90093"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[9].PTNUM2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#12345678901234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.25"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,7.85"/>
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
            <real val="0.12625"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O72">
      <attribute name="obj_pos">
        <point val="1.85,8.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,8.15093;4.88,8.40093"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[10].PTNUM2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#12345678901234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.25"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,8.35"/>
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
            <real val="0.12625"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O73">
      <attribute name="obj_pos">
        <point val="1.85,8.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,8.65093;4.88,8.90093"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[11].PTNUM2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#12345678901234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.25"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,8.85"/>
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
            <real val="0.12625"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O74">
      <attribute name="obj_pos">
        <point val="1.85,9.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,9.15093;4.88,9.40093"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[12].PTNUM2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#12345678901234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.25"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,9.35"/>
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
            <real val="0.12625"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O75">
      <attribute name="obj_pos">
        <point val="1.85,9.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,9.65093;4.88,9.90093"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[13].PTNUM2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#12345678901234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.25"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,9.85"/>
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
            <real val="0.12625"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O76">
      <attribute name="obj_pos">
        <point val="1.85,10.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,10.1509;4.88,10.4009"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[14].PTNUM2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#12345678901234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.25"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,10.35"/>
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
            <real val="0.12625"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O77">
      <attribute name="obj_pos">
        <point val="1.85,10.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,10.6509;4.88,10.9009"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[15].PTNUM2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#12345678901234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.25"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,10.85"/>
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
            <real val="0.12625"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O78">
      <attribute name="obj_pos">
        <point val="1.85,11.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,11.1509;4.88,11.4009"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[16].PTNUM2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#12345678901234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.25"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,11.35"/>
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
            <real val="0.12625"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O79">
      <attribute name="obj_pos">
        <point val="1.85,11.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,11.6509;4.88,11.9009"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[17].PTNUM2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#12345678901234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.25"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,11.85"/>
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
            <real val="0.12625"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O80">
      <attribute name="obj_pos">
        <point val="1.85,12.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,12.1509;4.88,12.4009"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[18].PTNUM2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#12345678901234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.25"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,12.35"/>
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
            <real val="0.12625"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O81">
      <attribute name="obj_pos">
        <point val="1.85,12.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,12.6509;4.88,12.9009"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[19].PTNUM2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#12345678901234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.25"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,12.85"/>
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
            <real val="0.12625"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O82">
      <attribute name="obj_pos">
        <point val="1.85,13.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,13.1509;4.88,13.4009"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[20].PTNUM2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#12345678901234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.25"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,13.35"/>
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
            <real val="0.12625"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O83">
      <attribute name="obj_pos">
        <point val="1.85,13.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,13.6509;4.88,13.9009"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[21].PTNUM2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#12345678901234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.25"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,13.85"/>
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
            <real val="0.12625"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O84">
      <attribute name="obj_pos">
        <point val="1.85,14.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,14.1509;4.88,14.4009"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[22].PTNUM2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#12345678901234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.25"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,14.35"/>
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
            <real val="0.12625"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O85">
      <attribute name="obj_pos">
        <point val="1.85,14.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,14.6509;4.88,14.9009"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[23].PTNUM2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#12345678901234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.25"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,14.85"/>
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
            <real val="0.12625"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O86">
      <attribute name="obj_pos">
        <point val="1.85,15.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,15.1509;4.88,15.4009"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[24].PTNUM2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#12345678901234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.25"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,15.35"/>
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
            <real val="0.12625"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O87">
      <attribute name="obj_pos">
        <point val="1.85,15.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,15.6509;4.88,15.9009"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[25].PTNUM2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#12345678901234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.25"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,15.85"/>
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
            <real val="0.12625"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O88">
      <attribute name="obj_pos">
        <point val="1.85,16.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,16.1509;4.88,16.4009"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[26].PTNUM2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#12345678901234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.25"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,16.35"/>
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
            <real val="0.12625"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O89">
      <attribute name="obj_pos">
        <point val="1.85,16.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,16.6509;4.88,16.9009"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[27].PTNUM2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#12345678901234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.25"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,16.85"/>
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
            <real val="0.12625"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O90">
      <attribute name="obj_pos">
        <point val="1.85,17.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,17.1509;4.88,17.4009"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[28].PTNUM2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#12345678901234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.25"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,17.35"/>
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
            <real val="0.12625"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O91">
      <attribute name="obj_pos">
        <point val="1.85,17.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,17.6509;4.88,17.9009"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[29].PTNUM2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#12345678901234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.25"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,17.85"/>
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
            <real val="0.12625"/>
          </attribute>
        </composite>
      </attribute>
    </object>
  </layer>
  <layer name="entry1" visible="true">
    <object type="Embed - Text" version="0" id="O92">
      <attribute name="obj_pos">
        <point val="23.8527,1.8024"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.8527,1.5237;27.7412,1.8737"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#SYSYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#202;&#191;&#192;&#174;&#163;&#177;&#163;&#177;&#199;&#175;&#163;&#177;&#163;&#177;&#183;&#238;&#163;&#177;&#163;&#184;&#198;&#252;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="23.8527,1.8024"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O93">
      <attribute name="obj_pos">
        <point val="3.825,1.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.825,1.5213;7.7135,1.8713"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#SRYYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#202;&#191;&#192;&#174;&#163;&#177;&#163;&#177;&#199;&#175;&#163;&#177;&#163;&#177;&#183;&#238;&#163;&#177;&#163;&#184;&#198;&#252;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.825,1.8"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O94">
      <attribute name="obj_pos">
        <point val="26.4777,1.3024"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.4777,1.0237;27.114,1.3737"/>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.4777,1.3024"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O95">
      <attribute name="obj_pos">
        <point val="1.875,1.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.875,1.5213;3.6425,1.8713"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MIDASI#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#163;&#206;&#163;&#206;&#163;&#206;&#163;&#206;&#163;&#206;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.875,1.8"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O96">
      <attribute name="obj_pos">
        <point val="10.9,18.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2032,18.0713;10.9,18.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#GOKEI-G[0].GMONEY#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.9,18.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O97">
      <attribute name="obj_pos">
        <point val="12.6,18.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.9032,18.0713;12.6,18.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#GOKEI-G[1].GMONEY#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="12.6,18.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O98">
      <attribute name="obj_pos">
        <point val="14.3,18.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.6032,18.0713;14.3,18.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#GOKEI-G[2].GMONEY#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="14.3,18.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O99">
      <attribute name="obj_pos">
        <point val="16,18.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.3032,18.0713;16,18.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#GOKEI-G[3].GMONEY#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16,18.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O100">
      <attribute name="obj_pos">
        <point val="17.7,18.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.0032,18.0713;17.7,18.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#GOKEI-G[4].GMONEY#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="17.7,18.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O101">
      <attribute name="obj_pos">
        <point val="19.4,18.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.7032,18.0713;19.4,18.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#GOKEI-G[5].GMONEY#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.4,18.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O102">
      <attribute name="obj_pos">
        <point val="21.1,18.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.4032,18.0713;21.1,18.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#GOKEI-G[6].GMONEY#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="21.1,18.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O103">
      <attribute name="obj_pos">
        <point val="22.8,18.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.1032,18.0713;22.8,18.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#GOKEI-G[7].GMONEY#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="22.8,18.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O104">
      <attribute name="obj_pos">
        <point val="24.5,18.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.8032,18.0713;24.5,18.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#GOKEI-G[8].GMONEY#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="24.5,18.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O105">
      <attribute name="obj_pos">
        <point val="26.2,18.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.5032,18.0713;26.2,18.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#GOKEI-G[9].GMONEY#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.2,18.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O106">
      <attribute name="obj_pos">
        <point val="10.9,18.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2032,18.5713;10.9,18.9213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#GOKEI-G[0].GHKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.9,18.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O107">
      <attribute name="obj_pos">
        <point val="12.6,18.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.9032,18.5713;12.6,18.9213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#GOKEI-G[1].GHKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="12.6,18.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O108">
      <attribute name="obj_pos">
        <point val="14.3,18.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.6032,18.5713;14.3,18.9213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#GOKEI-G[2].GHKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="14.3,18.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O109">
      <attribute name="obj_pos">
        <point val="16,18.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.3032,18.5713;16,18.9213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#GOKEI-G[3].GHKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16,18.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O110">
      <attribute name="obj_pos">
        <point val="17.7,18.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.0032,18.5713;17.7,18.9213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#GOKEI-G[4].GHKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="17.7,18.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O111">
      <attribute name="obj_pos">
        <point val="19.4,18.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.7032,18.5713;19.4,18.9213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#GOKEI-G[5].GHKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.4,18.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O112">
      <attribute name="obj_pos">
        <point val="21.1,18.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.4032,18.5713;21.1,18.9213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#GOKEI-G[6].GHKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="21.1,18.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O113">
      <attribute name="obj_pos">
        <point val="22.8,18.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.1032,18.5713;22.8,18.9213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#GOKEI-G[7].GHKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="22.8,18.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O114">
      <attribute name="obj_pos">
        <point val="24.5,18.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.8032,18.5713;24.5,18.9213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#GOKEI-G[8].GHKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="24.5,18.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O115">
      <attribute name="obj_pos">
        <point val="26.2,18.8506"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.5032,18.5719;26.2,18.9219"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#GOKEI-G[9].GHKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.2,18.8506"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O116">
      <attribute name="obj_pos">
        <point val="10.9,19.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2032,19.0713;10.9,19.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#GOKEI-G[0].GKENSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.9,19.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O117">
      <attribute name="obj_pos">
        <point val="12.6,19.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.9032,19.0713;12.6,19.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#GOKEI-G[1].GKENSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="12.6,19.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O118">
      <attribute name="obj_pos">
        <point val="14.3,19.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.6032,19.0713;14.3,19.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#GOKEI-G[2].GKENSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="14.3,19.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O119">
      <attribute name="obj_pos">
        <point val="16,19.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.3032,19.0713;16,19.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#GOKEI-G[3].GKENSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16,19.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O120">
      <attribute name="obj_pos">
        <point val="17.7,19.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.0032,19.0713;17.7,19.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#GOKEI-G[4].GKENSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="17.7,19.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O121">
      <attribute name="obj_pos">
        <point val="19.4,19.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.7032,19.0713;19.4,19.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#GOKEI-G[5].GKENSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.4,19.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O122">
      <attribute name="obj_pos">
        <point val="21.1,19.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.4032,19.0713;21.1,19.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#GOKEI-G[6].GKENSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="21.1,19.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O123">
      <attribute name="obj_pos">
        <point val="22.8,19.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.1032,19.0713;22.8,19.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#GOKEI-G[7].GKENSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="22.8,19.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O124">
      <attribute name="obj_pos">
        <point val="24.5,19.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.8032,19.0713;24.5,19.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#GOKEI-G[8].GKENSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="24.5,19.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O125">
      <attribute name="obj_pos">
        <point val="26.2081,19.3506"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.5113,19.0719;26.2081,19.4219"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#GOKEI-G[9].GKENSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.2081,19.3506"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O126">
      <attribute name="obj_pos">
        <point val="1.7,3.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0637,3.0713;1.7,3.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[0].RENNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.7,3.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O127">
      <attribute name="obj_pos">
        <point val="1.7,3.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0637,3.5713;1.7,3.9213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[1].RENNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.7,3.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O128">
      <attribute name="obj_pos">
        <point val="1.7,4.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0637,4.0713;1.7,4.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[2].RENNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.7,4.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O129">
      <attribute name="obj_pos">
        <point val="1.7,4.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0637,4.5713;1.7,4.9213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[3].RENNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.7,4.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O130">
      <attribute name="obj_pos">
        <point val="1.7,5.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0637,5.0713;1.7,5.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[4].RENNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.7,5.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O131">
      <attribute name="obj_pos">
        <point val="1.7,5.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0637,5.5713;1.7,5.9213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[5].RENNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.7,5.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O132">
      <attribute name="obj_pos">
        <point val="1.7,6.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0637,6.0713;1.7,6.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[6].RENNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.7,6.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O133">
      <attribute name="obj_pos">
        <point val="1.7,6.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0637,6.5713;1.7,6.9213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[7].RENNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.7,6.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O134">
      <attribute name="obj_pos">
        <point val="1.7,7.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0637,7.0713;1.7,7.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[8].RENNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.7,7.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O135">
      <attribute name="obj_pos">
        <point val="1.7,7.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0637,7.5713;1.7,7.9213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[9].RENNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.7,7.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O136">
      <attribute name="obj_pos">
        <point val="1.7,8.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0637,8.0713;1.7,8.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[10].RENNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.7,8.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O137">
      <attribute name="obj_pos">
        <point val="1.7,8.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0637,8.5713;1.7,8.9213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[11].RENNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.7,8.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O138">
      <attribute name="obj_pos">
        <point val="1.7,9.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0637,9.0713;1.7,9.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[12].RENNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.7,9.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O139">
      <attribute name="obj_pos">
        <point val="1.7,9.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0637,9.5713;1.7,9.9213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[13].RENNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.7,9.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O140">
      <attribute name="obj_pos">
        <point val="1.7,10.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0637,10.0713;1.7,10.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[14].RENNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.7,10.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O141">
      <attribute name="obj_pos">
        <point val="1.7,10.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0637,10.5713;1.7,10.9213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[15].RENNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.7,10.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O142">
      <attribute name="obj_pos">
        <point val="1.7,11.3538"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0637,11.0751;1.7,11.4251"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[16].RENNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.7,11.3538"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O143">
      <attribute name="obj_pos">
        <point val="1.7,11.8541"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0637,11.5754;1.7,11.9254"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[17].RENNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.7,11.8541"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O144">
      <attribute name="obj_pos">
        <point val="1.7,12.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0637,12.0713;1.7,12.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[18].RENNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.7,12.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O145">
      <attribute name="obj_pos">
        <point val="1.7,12.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0637,12.5713;1.7,12.9213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[19].RENNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.7,12.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O146">
      <attribute name="obj_pos">
        <point val="1.7,13.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0637,13.0713;1.7,13.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[20].RENNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.7,13.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O147">
      <attribute name="obj_pos">
        <point val="1.7,13.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0637,13.5713;1.7,13.9213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[21].RENNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.7,13.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O148">
      <attribute name="obj_pos">
        <point val="1.7,14.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0637,14.0713;1.7,14.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[22].RENNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.7,14.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O149">
      <attribute name="obj_pos">
        <point val="1.7,14.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0637,14.5713;1.7,14.9213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[23].RENNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.7,14.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O150">
      <attribute name="obj_pos">
        <point val="1.7,15.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0637,15.0713;1.7,15.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[24].RENNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.7,15.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O151">
      <attribute name="obj_pos">
        <point val="1.7,15.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0637,15.5713;1.7,15.9213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[25].RENNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.7,15.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O152">
      <attribute name="obj_pos">
        <point val="1.7,16.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0637,16.0713;1.7,16.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[26].RENNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.7,16.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O153">
      <attribute name="obj_pos">
        <point val="1.7,16.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0637,16.5713;1.7,16.9213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[27].RENNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.7,16.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O154">
      <attribute name="obj_pos">
        <point val="1.7,17.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0637,17.0713;1.7,17.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[28].RENNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.7,17.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O155">
      <attribute name="obj_pos">
        <point val="1.7,17.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0637,17.5713;1.7,17.9213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[29].RENNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.7,17.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O156">
      <attribute name="obj_pos">
        <point val="1.85,3.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,3.0713;3.971,3.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[0].PTNUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#1234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,3.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O157">
      <attribute name="obj_pos">
        <point val="1.85,3.85028"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,3.57158;3.971,3.92158"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[1].PTNUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#1234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,3.85028"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O158">
      <attribute name="obj_pos">
        <point val="1.85,4.35056"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,4.07186;3.971,4.42186"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[2].PTNUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#1234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,4.35056"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O159">
      <attribute name="obj_pos">
        <point val="1.85,4.85084"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,4.57214;3.971,4.92214"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[3].PTNUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#1234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,4.85084"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O160">
      <attribute name="obj_pos">
        <point val="1.85,5.35112"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,5.07242;3.971,5.42242"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[4].PTNUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#1234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,5.35112"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O161">
      <attribute name="obj_pos">
        <point val="1.85,5.8514"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,5.5727;3.971,5.9227"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[5].PTNUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#1234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,5.8514"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O162">
      <attribute name="obj_pos">
        <point val="1.85,6.35168"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,6.07298;3.971,6.42298"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[6].PTNUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#1234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,6.35168"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O163">
      <attribute name="obj_pos">
        <point val="1.85,6.85196"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,6.57326;3.971,6.92326"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[7].PTNUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#1234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,6.85196"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O164">
      <attribute name="obj_pos">
        <point val="1.85,7.35224"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,7.07354;3.971,7.42354"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[8].PTNUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#1234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,7.35224"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O165">
      <attribute name="obj_pos">
        <point val="1.85,7.85252"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,7.57382;3.971,7.92382"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[9].PTNUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#1234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,7.85252"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O166">
      <attribute name="obj_pos">
        <point val="1.85,8.3528"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,8.0741;3.971,8.4241"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[10].PTNUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#1234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,8.3528"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O167">
      <attribute name="obj_pos">
        <point val="1.85,8.85308"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,8.57438;3.971,8.92438"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[11].PTNUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#1234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,8.85308"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O168">
      <attribute name="obj_pos">
        <point val="1.85,9.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,9.0713;3.971,9.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[12].PTNUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#1234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,9.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O169">
      <attribute name="obj_pos">
        <point val="1.85,9.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,9.5713;3.971,9.9213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[13].PTNUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#1234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,9.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O170">
      <attribute name="obj_pos">
        <point val="1.85,10.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,10.0713;3.971,10.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[14].PTNUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#1234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,10.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O171">
      <attribute name="obj_pos">
        <point val="1.85,10.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,10.5713;3.971,10.9213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[15].PTNUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#1234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,10.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O172">
      <attribute name="obj_pos">
        <point val="1.85,11.3544"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,11.0757;3.971,11.4257"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[16].PTNUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#1234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,11.3544"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O173">
      <attribute name="obj_pos">
        <point val="1.85,11.8547"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,11.576;3.971,11.926"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[17].PTNUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#1234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,11.8547"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O174">
      <attribute name="obj_pos">
        <point val="1.85,12.355"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,12.0763;3.971,12.4263"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[18].PTNUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#1234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,12.355"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O175">
      <attribute name="obj_pos">
        <point val="1.85,12.8553"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,12.5766;3.971,12.9266"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[19].PTNUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#1234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,12.8553"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O176">
      <attribute name="obj_pos">
        <point val="1.85,13.3556"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,13.0769;3.971,13.4269"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[20].PTNUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#1234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,13.3556"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O177">
      <attribute name="obj_pos">
        <point val="1.85,13.8558"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,13.5771;3.971,13.9271"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[21].PTNUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#1234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,13.8558"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O178">
      <attribute name="obj_pos">
        <point val="1.85,14.3561"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,14.0774;3.971,14.4274"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[22].PTNUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#1234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,14.3561"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O179">
      <attribute name="obj_pos">
        <point val="1.85,14.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,14.5713;3.971,14.9213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[23].PTNUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#1234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,14.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O180">
      <attribute name="obj_pos">
        <point val="1.85,15.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,15.0713;3.971,15.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[24].PTNUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#1234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,15.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O181">
      <attribute name="obj_pos">
        <point val="1.85,15.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,15.5713;3.971,15.9213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[25].PTNUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#1234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,15.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O182">
      <attribute name="obj_pos">
        <point val="1.85,16.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,16.0713;3.971,16.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[26].PTNUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#1234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,16.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O183">
      <attribute name="obj_pos">
        <point val="1.85,16.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,16.5713;3.971,16.9213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[27].PTNUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#1234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,16.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O184">
      <attribute name="obj_pos">
        <point val="1.85,17.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,17.0713;3.971,17.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[28].PTNUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#1234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,17.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O185">
      <attribute name="obj_pos">
        <point val="1.85,17.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.85,17.5713;3.971,17.9213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[29].PTNUM#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#1234567890#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.85,17.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O186">
      <attribute name="obj_pos">
        <point val="5.1,3.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.1,3.11111;9.039,3.41111"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[0].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#171;&#164;&#173;&#164;&#175;&#164;&#177;&#164;&#179;&#164;&#181;&#164;&#183;&#164;&#185;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="5.1,3.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.1818"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O187">
      <attribute name="obj_pos">
        <point val="5.1,3.85028"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.1,3.61139;9.039,3.91139"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[1].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#171;&#164;&#173;&#164;&#175;&#164;&#177;&#164;&#179;&#164;&#181;&#164;&#183;&#164;&#185;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="5.1,3.85028"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.1818"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O188">
      <attribute name="obj_pos">
        <point val="5.1,4.35056"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.1,4.11167;9.039,4.41167"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[2].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#171;&#164;&#173;&#164;&#175;&#164;&#177;&#164;&#179;&#164;&#181;&#164;&#183;&#164;&#185;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="5.1,4.35056"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.1818"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O189">
      <attribute name="obj_pos">
        <point val="5.1,4.85084"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.1,4.61195;9.039,4.91195"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[3].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#171;&#164;&#173;&#164;&#175;&#164;&#177;&#164;&#179;&#164;&#181;&#164;&#183;&#164;&#185;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="5.1,4.85084"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.1818"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O190">
      <attribute name="obj_pos">
        <point val="5.1,5.35112"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.1,5.11223;9.039,5.41223"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[4].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#171;&#164;&#173;&#164;&#175;&#164;&#177;&#164;&#179;&#164;&#181;&#164;&#183;&#164;&#185;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="5.1,5.35112"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.1818"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O191">
      <attribute name="obj_pos">
        <point val="5.1,5.8514"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.1,5.61251;9.039,5.91251"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[5].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#171;&#164;&#173;&#164;&#175;&#164;&#177;&#164;&#179;&#164;&#181;&#164;&#183;&#164;&#185;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="5.1,5.8514"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.1818"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O192">
      <attribute name="obj_pos">
        <point val="5.1,6.35168"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.1,6.11279;9.039,6.41279"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[6].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#171;&#164;&#173;&#164;&#175;&#164;&#177;&#164;&#179;&#164;&#181;&#164;&#183;&#164;&#185;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="5.1,6.35168"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.1818"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O193">
      <attribute name="obj_pos">
        <point val="5.1,6.85196"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.1,6.61307;9.039,6.91307"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[7].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#171;&#164;&#173;&#164;&#175;&#164;&#177;&#164;&#179;&#164;&#181;&#164;&#183;&#164;&#185;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="5.1,6.85196"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.1818"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O194">
      <attribute name="obj_pos">
        <point val="5.1,7.35223"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.1,7.11334;9.039,7.41334"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[8].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#171;&#164;&#173;&#164;&#175;&#164;&#177;&#164;&#179;&#164;&#181;&#164;&#183;&#164;&#185;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="5.1,7.35223"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.1818"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O195">
      <attribute name="obj_pos">
        <point val="5.1,7.85251"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.1,7.61362;9.039,7.91362"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[9].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#171;&#164;&#173;&#164;&#175;&#164;&#177;&#164;&#179;&#164;&#181;&#164;&#183;&#164;&#185;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="5.1,7.85251"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.1818"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O196">
      <attribute name="obj_pos">
        <point val="5.1,8.35279"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.1,8.1139;9.039,8.4139"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[10].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#171;&#164;&#173;&#164;&#175;&#164;&#177;&#164;&#179;&#164;&#181;&#164;&#183;&#164;&#185;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="5.1,8.35279"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.1818"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O197">
      <attribute name="obj_pos">
        <point val="5.1,8.85307"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.1,8.61418;9.039,8.91418"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[11].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#171;&#164;&#173;&#164;&#175;&#164;&#177;&#164;&#179;&#164;&#181;&#164;&#183;&#164;&#185;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="5.1,8.85307"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.1818"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O198">
      <attribute name="obj_pos">
        <point val="5.1,9.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.1,9.11111;9.039,9.41111"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[12].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#171;&#164;&#173;&#164;&#175;&#164;&#177;&#164;&#179;&#164;&#181;&#164;&#183;&#164;&#185;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="5.1,9.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.1818"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O199">
      <attribute name="obj_pos">
        <point val="5.1,9.85363"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.1,9.61474;9.039,9.91474"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[13].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#171;&#164;&#173;&#164;&#175;&#164;&#177;&#164;&#179;&#164;&#181;&#164;&#183;&#164;&#185;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="5.1,9.85363"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.1818"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O200">
      <attribute name="obj_pos">
        <point val="5.1,10.3539"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.1,10.115;9.039,10.415"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[14].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#171;&#164;&#173;&#164;&#175;&#164;&#177;&#164;&#179;&#164;&#181;&#164;&#183;&#164;&#185;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="5.1,10.3539"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.1818"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O201">
      <attribute name="obj_pos">
        <point val="5.1,10.8542"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.1,10.6153;9.039,10.9153"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[15].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#171;&#164;&#173;&#164;&#175;&#164;&#177;&#164;&#179;&#164;&#181;&#164;&#183;&#164;&#185;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="5.1,10.8542"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.1818"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O202">
      <attribute name="obj_pos">
        <point val="5.1,11.3545"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.1,11.1156;9.039,11.4156"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[16].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#171;&#164;&#173;&#164;&#175;&#164;&#177;&#164;&#179;&#164;&#181;&#164;&#183;&#164;&#185;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="5.1,11.3545"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.1818"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O203">
      <attribute name="obj_pos">
        <point val="5.1,11.8547"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.1,11.6158;9.039,11.9158"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[17].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#171;&#164;&#173;&#164;&#175;&#164;&#177;&#164;&#179;&#164;&#181;&#164;&#183;&#164;&#185;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="5.1,11.8547"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.1818"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O204">
      <attribute name="obj_pos">
        <point val="5.1,12.355"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.1,12.1161;9.039,12.4161"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[18].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#171;&#164;&#173;&#164;&#175;&#164;&#177;&#164;&#179;&#164;&#181;&#164;&#183;&#164;&#185;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="5.1,12.355"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.1818"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O205">
      <attribute name="obj_pos">
        <point val="5.1,12.8553"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.1,12.6164;9.039,12.9164"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[19].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#171;&#164;&#173;&#164;&#175;&#164;&#177;&#164;&#179;&#164;&#181;&#164;&#183;&#164;&#185;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="5.1,12.8553"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.1818"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O206">
      <attribute name="obj_pos">
        <point val="5.1,13.3556"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.1,13.1167;9.039,13.4167"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[20].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#171;&#164;&#173;&#164;&#175;&#164;&#177;&#164;&#179;&#164;&#181;&#164;&#183;&#164;&#185;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="5.1,13.3556"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.1818"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O207">
      <attribute name="obj_pos">
        <point val="5.1,13.8559"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.1,13.617;9.039,13.917"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[21].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#171;&#164;&#173;&#164;&#175;&#164;&#177;&#164;&#179;&#164;&#181;&#164;&#183;&#164;&#185;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="5.1,13.8559"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.1818"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O208">
      <attribute name="obj_pos">
        <point val="5.1,14.3561"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.1,14.1172;9.039,14.4172"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[22].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#171;&#164;&#173;&#164;&#175;&#164;&#177;&#164;&#179;&#164;&#181;&#164;&#183;&#164;&#185;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="5.1,14.3561"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.1818"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O209">
      <attribute name="obj_pos">
        <point val="5.1,14.8564"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.1,14.6175;9.039,14.9175"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[23].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#171;&#164;&#173;&#164;&#175;&#164;&#177;&#164;&#179;&#164;&#181;&#164;&#183;&#164;&#185;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="5.1,14.8564"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.1818"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O210">
      <attribute name="obj_pos">
        <point val="5.1,15.3567"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.1,15.1178;9.039,15.4178"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[24].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#171;&#164;&#173;&#164;&#175;&#164;&#177;&#164;&#179;&#164;&#181;&#164;&#183;&#164;&#185;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="5.1,15.3567"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.1818"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O211">
      <attribute name="obj_pos">
        <point val="5.1,15.857"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.1,15.6181;9.039,15.9181"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[25].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#171;&#164;&#173;&#164;&#175;&#164;&#177;&#164;&#179;&#164;&#181;&#164;&#183;&#164;&#185;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="5.1,15.857"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.1818"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O212">
      <attribute name="obj_pos">
        <point val="5.1,16.3573"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.1,16.1184;9.039,16.4184"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[26].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#171;&#164;&#173;&#164;&#175;&#164;&#177;&#164;&#179;&#164;&#181;&#164;&#183;&#164;&#185;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="5.1,16.3573"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.1818"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O213">
      <attribute name="obj_pos">
        <point val="5.1,16.8575"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.1,16.6186;9.039,16.9186"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[27].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#171;&#164;&#173;&#164;&#175;&#164;&#177;&#164;&#179;&#164;&#181;&#164;&#183;&#164;&#185;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="5.1,16.8575"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.1818"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O214">
      <attribute name="obj_pos">
        <point val="5.1,17.3578"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.1,17.1189;9.039,17.4189"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[28].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#171;&#164;&#173;&#164;&#175;&#164;&#177;&#164;&#179;&#164;&#181;&#164;&#183;&#164;&#185;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="5.1,17.3578"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.1818"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O215">
      <attribute name="obj_pos">
        <point val="5.1,17.8581"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.1,17.6192;9.039,17.9192"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[29].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#171;&#164;&#173;&#164;&#175;&#164;&#177;&#164;&#179;&#164;&#181;&#164;&#183;&#164;&#185;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="5.1,17.8581"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.1818"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1515"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O216">
      <attribute name="obj_pos">
        <point val="10.9,3.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2032,3.0713;10.9,3.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[0].HKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.9,3.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O217">
      <attribute name="obj_pos">
        <point val="10.9,3.85028"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2032,3.57158;10.9,3.92158"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[1].HKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.9,3.85028"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O218">
      <attribute name="obj_pos">
        <point val="10.9,4.35056"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2032,4.07186;10.9,4.42186"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[2].HKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.9,4.35056"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O219">
      <attribute name="obj_pos">
        <point val="10.9,4.85084"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2032,4.57214;10.9,4.92214"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[3].HKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.9,4.85084"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O220">
      <attribute name="obj_pos">
        <point val="10.9,5.35112"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2032,5.07242;10.9,5.42242"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[4].HKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.9,5.35112"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O221">
      <attribute name="obj_pos">
        <point val="10.9,5.8514"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2032,5.5727;10.9,5.9227"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[5].HKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.9,5.8514"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O222">
      <attribute name="obj_pos">
        <point val="10.9,6.35168"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2032,6.07298;10.9,6.42298"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[6].HKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.9,6.35168"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O223">
      <attribute name="obj_pos">
        <point val="10.9,6.85196"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2032,6.57326;10.9,6.92326"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[7].HKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.9,6.85196"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O224">
      <attribute name="obj_pos">
        <point val="10.9,7.35224"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2032,7.07354;10.9,7.42354"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[8].HKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.9,7.35224"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O225">
      <attribute name="obj_pos">
        <point val="10.9,7.85252"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2032,7.57382;10.9,7.92382"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[9].HKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.9,7.85252"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O226">
      <attribute name="obj_pos">
        <point val="10.9,8.3528"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2032,8.0741;10.9,8.4241"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[10].HKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.9,8.3528"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O227">
      <attribute name="obj_pos">
        <point val="10.9,8.85308"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2032,8.57438;10.9,8.92438"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[11].HKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.9,8.85308"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O228">
      <attribute name="obj_pos">
        <point val="10.9,9.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2032,9.0713;10.9,9.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[12].HKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.9,9.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O229">
      <attribute name="obj_pos">
        <point val="10.9,9.85364"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2032,9.57494;10.9,9.92494"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[13].HKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.9,9.85364"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O230">
      <attribute name="obj_pos">
        <point val="10.9,10.3539"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2032,10.0752;10.9,10.4252"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[14].HKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.9,10.3539"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O231">
      <attribute name="obj_pos">
        <point val="10.9,10.8542"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2032,10.5755;10.9,10.9255"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[15].HKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.9,10.8542"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O232">
      <attribute name="obj_pos">
        <point val="10.9,11.3544"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2032,11.0757;10.9,11.4257"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[16].HKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.9,11.3544"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O233">
      <attribute name="obj_pos">
        <point val="10.9,11.8547"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2032,11.576;10.9,11.926"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[17].HKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.9,11.8547"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O234">
      <attribute name="obj_pos">
        <point val="10.9,12.355"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2032,12.0763;10.9,12.4263"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[18].HKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.9,12.355"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O235">
      <attribute name="obj_pos">
        <point val="10.9,12.8553"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2032,12.5766;10.9,12.9266"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[19].HKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.9,12.8553"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O236">
      <attribute name="obj_pos">
        <point val="10.9,13.3556"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2032,13.0769;10.9,13.4269"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[20].HKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.9,13.3556"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O237">
      <attribute name="obj_pos">
        <point val="10.9,13.8558"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2032,13.5771;10.9,13.9271"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[21].HKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.9,13.8558"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O238">
      <attribute name="obj_pos">
        <point val="10.9,14.3561"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2032,14.0774;10.9,14.4274"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[22].HKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.9,14.3561"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O239">
      <attribute name="obj_pos">
        <point val="10.9,14.8564"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2032,14.5777;10.9,14.9277"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[23].HKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.9,14.8564"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O240">
      <attribute name="obj_pos">
        <point val="10.9,15.3567"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2032,15.078;10.9,15.428"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[24].HKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.9,15.3567"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O241">
      <attribute name="obj_pos">
        <point val="10.9,15.857"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2032,15.5783;10.9,15.9283"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[25].HKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.9,15.857"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O242">
      <attribute name="obj_pos">
        <point val="10.9,16.3572"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2032,16.0785;10.9,16.4285"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[26].HKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.9,16.3572"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O243">
      <attribute name="obj_pos">
        <point val="10.9,16.8575"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2032,16.5788;10.9,16.9288"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[27].HKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.9,16.8575"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O244">
      <attribute name="obj_pos">
        <point val="10.9,17.3578"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2032,17.0791;10.9,17.4291"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[28].HKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.9,17.3578"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O245">
      <attribute name="obj_pos">
        <point val="10.9,17.8581"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2032,17.5794;10.9,17.9294"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MEISAI-G[29].HKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.9,17.8581"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O246">
      <attribute name="obj_pos">
        <point val="17.5,1.45"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.5,1.13148;19.116,1.53148"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NYUGAIKBN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.4"/>
          </attribute>
          <attribute name="pos">
            <point val="17.5,1.45"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2424"/>
          </attribute>
          <attribute name="multi">
            <real val="0.202"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <group>
      <object type="Embed - Text" version="0" id="O247">
        <attribute name="obj_pos">
          <point val="12.6,3.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.9032,3.0713;12.6,3.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[0].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="12.6,3.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O248">
        <attribute name="obj_pos">
          <point val="12.6,3.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.9032,3.5713;12.6,3.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[1].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="12.6,3.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O249">
        <attribute name="obj_pos">
          <point val="12.6,4.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.9032,4.0713;12.6,4.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[2].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="12.6,4.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O250">
        <attribute name="obj_pos">
          <point val="12.6,4.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.9032,4.5713;12.6,4.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[3].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="12.6,4.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O251">
        <attribute name="obj_pos">
          <point val="12.6,5.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.9032,5.0713;12.6,5.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[4].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="12.6,5.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O252">
        <attribute name="obj_pos">
          <point val="12.6,5.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.9032,5.5713;12.6,5.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[5].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="12.6,5.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O253">
        <attribute name="obj_pos">
          <point val="12.6,6.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.9032,6.0713;12.6,6.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[6].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="12.6,6.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O254">
        <attribute name="obj_pos">
          <point val="12.6,6.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.9032,6.5713;12.6,6.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[7].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="12.6,6.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O255">
        <attribute name="obj_pos">
          <point val="12.6,7.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.9032,7.0713;12.6,7.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[8].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="12.6,7.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O256">
        <attribute name="obj_pos">
          <point val="12.6,7.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.9032,7.5713;12.6,7.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[9].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="12.6,7.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O257">
        <attribute name="obj_pos">
          <point val="12.6,8.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.9032,8.0713;12.6,8.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[10].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="12.6,8.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O258">
        <attribute name="obj_pos">
          <point val="12.6,8.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.9032,8.5713;12.6,8.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[11].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="12.6,8.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O259">
        <attribute name="obj_pos">
          <point val="12.6,9.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.9032,9.0713;12.6,9.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[12].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="12.6,9.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O260">
        <attribute name="obj_pos">
          <point val="12.6,9.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.9032,9.5713;12.6,9.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[13].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="12.6,9.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O261">
        <attribute name="obj_pos">
          <point val="12.6,10.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.9032,10.0713;12.6,10.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[14].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="12.6,10.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O262">
        <attribute name="obj_pos">
          <point val="12.6,10.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.9032,10.5713;12.6,10.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[15].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="12.6,10.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O263">
        <attribute name="obj_pos">
          <point val="12.6,11.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.9032,11.0713;12.6,11.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[16].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="12.6,11.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O264">
        <attribute name="obj_pos">
          <point val="12.6,11.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.9032,11.5713;12.6,11.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[17].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="12.6,11.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O265">
        <attribute name="obj_pos">
          <point val="12.6,12.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.9032,12.0713;12.6,12.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[18].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="12.6,12.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O266">
        <attribute name="obj_pos">
          <point val="12.6,12.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.9032,12.5713;12.6,12.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[19].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="12.6,12.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O267">
        <attribute name="obj_pos">
          <point val="12.6,13.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.9032,13.0713;12.6,13.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[20].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="12.6,13.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O268">
        <attribute name="obj_pos">
          <point val="12.6,13.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.9032,13.5713;12.6,13.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[21].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="12.6,13.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O269">
        <attribute name="obj_pos">
          <point val="12.6,14.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.9032,14.0713;12.6,14.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[22].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="12.6,14.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O270">
        <attribute name="obj_pos">
          <point val="12.6,14.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.9032,14.5713;12.6,14.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[23].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="12.6,14.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O271">
        <attribute name="obj_pos">
          <point val="12.6,15.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.9032,15.0713;12.6,15.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[24].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="12.6,15.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O272">
        <attribute name="obj_pos">
          <point val="12.6,15.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.9032,15.5713;12.6,15.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[25].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="12.6,15.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O273">
        <attribute name="obj_pos">
          <point val="12.6,16.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.9032,16.0713;12.6,16.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[26].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="12.6,16.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O274">
        <attribute name="obj_pos">
          <point val="12.6,16.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.9032,16.5713;12.6,16.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[27].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="12.6,16.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O275">
        <attribute name="obj_pos">
          <point val="12.6,17.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.9032,17.0713;12.6,17.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[28].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="12.6,17.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O276">
        <attribute name="obj_pos">
          <point val="12.6,17.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.9032,17.5713;12.6,17.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[29].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="12.6,17.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
    </group>
    <group>
      <object type="Embed - Text" version="0" id="O277">
        <attribute name="obj_pos">
          <point val="14.3,3.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="12.6032,3.0713;14.3,3.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[0].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="14.3,3.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O278">
        <attribute name="obj_pos">
          <point val="14.3,3.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="12.6032,3.5713;14.3,3.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[1].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="14.3,3.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O279">
        <attribute name="obj_pos">
          <point val="14.3,4.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="12.6032,4.0713;14.3,4.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[2].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="14.3,4.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O280">
        <attribute name="obj_pos">
          <point val="14.3,4.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="12.6032,4.5713;14.3,4.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[3].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="14.3,4.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O281">
        <attribute name="obj_pos">
          <point val="14.3,5.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="12.6032,5.0713;14.3,5.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[4].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="14.3,5.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O282">
        <attribute name="obj_pos">
          <point val="14.3,5.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="12.6032,5.5713;14.3,5.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[5].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="14.3,5.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O283">
        <attribute name="obj_pos">
          <point val="14.3,6.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="12.6032,6.0713;14.3,6.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[6].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="14.3,6.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O284">
        <attribute name="obj_pos">
          <point val="14.3,6.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="12.6032,6.5713;14.3,6.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[7].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="14.3,6.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O285">
        <attribute name="obj_pos">
          <point val="14.3,7.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="12.6032,7.0713;14.3,7.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[8].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="14.3,7.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O286">
        <attribute name="obj_pos">
          <point val="14.3,7.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="12.6032,7.5713;14.3,7.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[9].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="14.3,7.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O287">
        <attribute name="obj_pos">
          <point val="14.3,8.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="12.6032,8.0713;14.3,8.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[10].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="14.3,8.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O288">
        <attribute name="obj_pos">
          <point val="14.3,8.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="12.6032,8.5713;14.3,8.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[11].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="14.3,8.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O289">
        <attribute name="obj_pos">
          <point val="14.3,9.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="12.6032,9.0713;14.3,9.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[12].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="14.3,9.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O290">
        <attribute name="obj_pos">
          <point val="14.3,9.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="12.6032,9.5713;14.3,9.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[13].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="14.3,9.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O291">
        <attribute name="obj_pos">
          <point val="14.3,10.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="12.6032,10.0713;14.3,10.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[14].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="14.3,10.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O292">
        <attribute name="obj_pos">
          <point val="14.3,10.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="12.6032,10.5713;14.3,10.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[15].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="14.3,10.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O293">
        <attribute name="obj_pos">
          <point val="14.3,11.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="12.6032,11.0713;14.3,11.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[16].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="14.3,11.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O294">
        <attribute name="obj_pos">
          <point val="14.3,11.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="12.6032,11.5713;14.3,11.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[17].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="14.3,11.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O295">
        <attribute name="obj_pos">
          <point val="14.3,12.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="12.6032,12.0713;14.3,12.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[18].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="14.3,12.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O296">
        <attribute name="obj_pos">
          <point val="14.3,12.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="12.6032,12.5713;14.3,12.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[19].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="14.3,12.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O297">
        <attribute name="obj_pos">
          <point val="14.3,13.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="12.6032,13.0713;14.3,13.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[20].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="14.3,13.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O298">
        <attribute name="obj_pos">
          <point val="14.3,13.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="12.6032,13.5713;14.3,13.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[21].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="14.3,13.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O299">
        <attribute name="obj_pos">
          <point val="14.3,14.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="12.6032,14.0713;14.3,14.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[22].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="14.3,14.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O300">
        <attribute name="obj_pos">
          <point val="14.3,14.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="12.6032,14.5713;14.3,14.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[23].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="14.3,14.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O301">
        <attribute name="obj_pos">
          <point val="14.3,15.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="12.6032,15.0713;14.3,15.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[24].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="14.3,15.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O302">
        <attribute name="obj_pos">
          <point val="14.3,15.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="12.6032,15.5713;14.3,15.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[25].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="14.3,15.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O303">
        <attribute name="obj_pos">
          <point val="14.3,16.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="12.6032,16.0713;14.3,16.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[26].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="14.3,16.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O304">
        <attribute name="obj_pos">
          <point val="14.3,16.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="12.6032,16.5713;14.3,16.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[27].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="14.3,16.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O305">
        <attribute name="obj_pos">
          <point val="14.3,17.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="12.6032,17.0713;14.3,17.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[28].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="14.3,17.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O306">
        <attribute name="obj_pos">
          <point val="14.3,17.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="12.6032,17.5713;14.3,17.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[29].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="14.3,17.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
    </group>
    <group>
      <object type="Embed - Text" version="0" id="O307">
        <attribute name="obj_pos">
          <point val="16,3.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="14.3032,3.0713;16,3.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[0].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="16,3.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O308">
        <attribute name="obj_pos">
          <point val="16,3.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="14.3032,3.5713;16,3.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[1].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="16,3.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O309">
        <attribute name="obj_pos">
          <point val="16,4.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="14.3032,4.0713;16,4.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[2].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="16,4.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O310">
        <attribute name="obj_pos">
          <point val="16,4.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="14.3032,4.5713;16,4.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[3].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="16,4.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O311">
        <attribute name="obj_pos">
          <point val="16,5.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="14.3032,5.0713;16,5.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[4].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="16,5.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O312">
        <attribute name="obj_pos">
          <point val="16,5.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="14.3032,5.5713;16,5.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[5].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="16,5.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O313">
        <attribute name="obj_pos">
          <point val="16,6.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="14.3032,6.0713;16,6.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[6].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="16,6.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O314">
        <attribute name="obj_pos">
          <point val="16,6.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="14.3032,6.5713;16,6.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[7].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="16,6.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O315">
        <attribute name="obj_pos">
          <point val="16,7.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="14.3032,7.0713;16,7.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[8].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="16,7.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O316">
        <attribute name="obj_pos">
          <point val="16,7.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="14.3032,7.5713;16,7.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[9].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="16,7.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O317">
        <attribute name="obj_pos">
          <point val="16,8.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="14.3032,8.0713;16,8.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[10].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="16,8.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O318">
        <attribute name="obj_pos">
          <point val="16,8.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="14.3032,8.5713;16,8.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[11].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="16,8.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O319">
        <attribute name="obj_pos">
          <point val="16,9.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="14.3032,9.0713;16,9.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[12].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="16,9.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O320">
        <attribute name="obj_pos">
          <point val="16,9.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="14.3032,9.5713;16,9.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[13].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="16,9.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O321">
        <attribute name="obj_pos">
          <point val="16,10.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="14.3032,10.0713;16,10.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[14].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="16,10.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O322">
        <attribute name="obj_pos">
          <point val="16,10.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="14.3032,10.5713;16,10.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[15].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="16,10.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O323">
        <attribute name="obj_pos">
          <point val="16,11.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="14.3032,11.0713;16,11.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[16].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="16,11.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O324">
        <attribute name="obj_pos">
          <point val="16,11.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="14.3032,11.5713;16,11.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[17].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="16,11.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O325">
        <attribute name="obj_pos">
          <point val="16,12.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="14.3032,12.0713;16,12.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[18].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="16,12.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O326">
        <attribute name="obj_pos">
          <point val="16,12.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="14.3032,12.5713;16,12.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[19].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="16,12.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O327">
        <attribute name="obj_pos">
          <point val="16,13.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="14.3032,13.0713;16,13.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[20].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="16,13.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O328">
        <attribute name="obj_pos">
          <point val="16,13.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="14.3032,13.5713;16,13.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[21].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="16,13.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O329">
        <attribute name="obj_pos">
          <point val="16,14.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="14.3032,14.0713;16,14.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[22].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="16,14.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O330">
        <attribute name="obj_pos">
          <point val="16,14.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="14.3032,14.5713;16,14.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[23].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="16,14.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O331">
        <attribute name="obj_pos">
          <point val="16,15.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="14.3032,15.0713;16,15.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[24].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="16,15.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O332">
        <attribute name="obj_pos">
          <point val="16,15.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="14.3032,15.5713;16,15.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[25].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="16,15.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O333">
        <attribute name="obj_pos">
          <point val="16,16.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="14.3032,16.0713;16,16.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[26].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="16,16.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O334">
        <attribute name="obj_pos">
          <point val="16,16.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="14.3032,16.5713;16,16.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[27].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="16,16.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O335">
        <attribute name="obj_pos">
          <point val="16,17.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="14.3032,17.0713;16,17.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[28].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="16,17.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O336">
        <attribute name="obj_pos">
          <point val="16,17.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="14.3032,17.5713;16,17.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[29].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="16,17.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
    </group>
    <group>
      <object type="Embed - Text" version="0" id="O337">
        <attribute name="obj_pos">
          <point val="17.7,3.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="16.0032,3.0713;17.7,3.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[0].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="17.7,3.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O338">
        <attribute name="obj_pos">
          <point val="17.7,3.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="16.0032,3.5713;17.7,3.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[1].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="17.7,3.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O339">
        <attribute name="obj_pos">
          <point val="17.7,4.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="16.0032,4.0713;17.7,4.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[2].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="17.7,4.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O340">
        <attribute name="obj_pos">
          <point val="17.7,4.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="16.0032,4.5713;17.7,4.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[3].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="17.7,4.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O341">
        <attribute name="obj_pos">
          <point val="17.7,5.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="16.0032,5.0713;17.7,5.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[4].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="17.7,5.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O342">
        <attribute name="obj_pos">
          <point val="17.7,5.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="16.0032,5.5713;17.7,5.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[5].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="17.7,5.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O343">
        <attribute name="obj_pos">
          <point val="17.7,6.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="16.0032,6.0713;17.7,6.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[6].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="17.7,6.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O344">
        <attribute name="obj_pos">
          <point val="17.7,6.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="16.0032,6.5713;17.7,6.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[7].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="17.7,6.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O345">
        <attribute name="obj_pos">
          <point val="17.7,7.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="16.0032,7.0713;17.7,7.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[8].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="17.7,7.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O346">
        <attribute name="obj_pos">
          <point val="17.7,7.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="16.0032,7.5713;17.7,7.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[9].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="17.7,7.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O347">
        <attribute name="obj_pos">
          <point val="17.7,8.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="16.0032,8.0713;17.7,8.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[10].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="17.7,8.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O348">
        <attribute name="obj_pos">
          <point val="17.7,8.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="16.0032,8.5713;17.7,8.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[11].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="17.7,8.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O349">
        <attribute name="obj_pos">
          <point val="17.7,9.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="16.0032,9.0713;17.7,9.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[12].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="17.7,9.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O350">
        <attribute name="obj_pos">
          <point val="17.7,9.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="16.0032,9.5713;17.7,9.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[13].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="17.7,9.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O351">
        <attribute name="obj_pos">
          <point val="17.7,10.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="16.0032,10.0713;17.7,10.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[14].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="17.7,10.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O352">
        <attribute name="obj_pos">
          <point val="17.7,10.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="16.0032,10.5713;17.7,10.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[15].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="17.7,10.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O353">
        <attribute name="obj_pos">
          <point val="17.7,11.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="16.0032,11.0713;17.7,11.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[16].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="17.7,11.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O354">
        <attribute name="obj_pos">
          <point val="17.7,11.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="16.0032,11.5713;17.7,11.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[17].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="17.7,11.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O355">
        <attribute name="obj_pos">
          <point val="17.7,12.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="16.0032,12.0713;17.7,12.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[18].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="17.7,12.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O356">
        <attribute name="obj_pos">
          <point val="17.7,12.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="16.0032,12.5713;17.7,12.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[19].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="17.7,12.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O357">
        <attribute name="obj_pos">
          <point val="17.7,13.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="16.0032,13.0713;17.7,13.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[20].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="17.7,13.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O358">
        <attribute name="obj_pos">
          <point val="17.7,13.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="16.0032,13.5713;17.7,13.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[21].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="17.7,13.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O359">
        <attribute name="obj_pos">
          <point val="17.7,14.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="16.0032,14.0713;17.7,14.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[22].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="17.7,14.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O360">
        <attribute name="obj_pos">
          <point val="17.7,14.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="16.0032,14.5713;17.7,14.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[23].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="17.7,14.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O361">
        <attribute name="obj_pos">
          <point val="17.7,15.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="16.0032,15.0713;17.7,15.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[24].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="17.7,15.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O362">
        <attribute name="obj_pos">
          <point val="17.7,15.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="16.0032,15.5713;17.7,15.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[25].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="17.7,15.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O363">
        <attribute name="obj_pos">
          <point val="17.7,16.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="16.0032,16.0713;17.7,16.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[26].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="17.7,16.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O364">
        <attribute name="obj_pos">
          <point val="17.7,16.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="16.0032,16.5713;17.7,16.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[27].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="17.7,16.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O365">
        <attribute name="obj_pos">
          <point val="17.7,17.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="16.0032,17.0713;17.7,17.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[28].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="17.7,17.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O366">
        <attribute name="obj_pos">
          <point val="17.7,17.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="16.0032,17.5713;17.7,17.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[29].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="17.7,17.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
    </group>
    <group>
      <object type="Embed - Text" version="0" id="O367">
        <attribute name="obj_pos">
          <point val="19.4,3.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.7032,3.0713;19.4,3.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[0].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="19.4,3.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O368">
        <attribute name="obj_pos">
          <point val="19.4,3.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.7032,3.5713;19.4,3.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[1].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="19.4,3.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O369">
        <attribute name="obj_pos">
          <point val="19.4,4.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.7032,4.0713;19.4,4.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[2].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="19.4,4.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O370">
        <attribute name="obj_pos">
          <point val="19.4,4.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.7032,4.5713;19.4,4.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[3].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="19.4,4.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O371">
        <attribute name="obj_pos">
          <point val="19.4,5.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.7032,5.0713;19.4,5.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[4].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="19.4,5.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O372">
        <attribute name="obj_pos">
          <point val="19.4,5.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.7032,5.5713;19.4,5.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[5].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="19.4,5.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O373">
        <attribute name="obj_pos">
          <point val="19.4,6.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.7032,6.0713;19.4,6.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[6].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="19.4,6.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O374">
        <attribute name="obj_pos">
          <point val="19.4,6.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.7032,6.5713;19.4,6.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[7].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="19.4,6.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O375">
        <attribute name="obj_pos">
          <point val="19.4,7.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.7032,7.0713;19.4,7.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[8].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="19.4,7.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O376">
        <attribute name="obj_pos">
          <point val="19.4,7.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.7032,7.5713;19.4,7.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[9].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="19.4,7.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O377">
        <attribute name="obj_pos">
          <point val="19.4,8.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.7032,8.0713;19.4,8.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[10].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="19.4,8.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O378">
        <attribute name="obj_pos">
          <point val="19.4,8.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.7032,8.5713;19.4,8.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[11].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="19.4,8.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O379">
        <attribute name="obj_pos">
          <point val="19.4,9.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.7032,9.0713;19.4,9.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[12].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="19.4,9.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O380">
        <attribute name="obj_pos">
          <point val="19.4,9.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.7032,9.5713;19.4,9.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[13].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="19.4,9.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O381">
        <attribute name="obj_pos">
          <point val="19.4,10.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.7032,10.0713;19.4,10.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[14].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="19.4,10.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O382">
        <attribute name="obj_pos">
          <point val="19.4,10.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.7032,10.5713;19.4,10.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[15].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="19.4,10.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O383">
        <attribute name="obj_pos">
          <point val="19.4,11.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.7032,11.0713;19.4,11.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[16].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="19.4,11.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O384">
        <attribute name="obj_pos">
          <point val="19.4,11.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.7032,11.5713;19.4,11.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[17].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="19.4,11.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O385">
        <attribute name="obj_pos">
          <point val="19.4,12.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.7032,12.0713;19.4,12.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[18].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="19.4,12.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O386">
        <attribute name="obj_pos">
          <point val="19.4,12.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.7032,12.5713;19.4,12.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[19].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="19.4,12.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O387">
        <attribute name="obj_pos">
          <point val="19.4,13.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.7032,13.0713;19.4,13.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[20].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="19.4,13.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O388">
        <attribute name="obj_pos">
          <point val="19.4,13.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.7032,13.5713;19.4,13.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[21].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="19.4,13.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O389">
        <attribute name="obj_pos">
          <point val="19.4,14.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.7032,14.0713;19.4,14.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[22].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="19.4,14.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O390">
        <attribute name="obj_pos">
          <point val="19.4,14.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.7032,14.5713;19.4,14.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[23].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="19.4,14.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O391">
        <attribute name="obj_pos">
          <point val="19.4,15.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.7032,15.0713;19.4,15.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[24].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="19.4,15.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O392">
        <attribute name="obj_pos">
          <point val="19.4,15.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.7032,15.5713;19.4,15.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[25].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="19.4,15.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O393">
        <attribute name="obj_pos">
          <point val="19.4,16.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.7032,16.0713;19.4,16.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[26].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="19.4,16.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O394">
        <attribute name="obj_pos">
          <point val="19.4,16.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.7032,16.5713;19.4,16.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[27].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="19.4,16.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O395">
        <attribute name="obj_pos">
          <point val="19.4,17.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.7032,17.0713;19.4,17.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[28].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="19.4,17.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O396">
        <attribute name="obj_pos">
          <point val="19.4,17.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.7032,17.5713;19.4,17.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[29].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="19.4,17.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
    </group>
    <group>
      <object type="Embed - Text" version="0" id="O397">
        <attribute name="obj_pos">
          <point val="21.1,3.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.4032,3.0713;21.1,3.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[0].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="21.1,3.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O398">
        <attribute name="obj_pos">
          <point val="21.1,3.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.4032,3.5713;21.1,3.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[1].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="21.1,3.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O399">
        <attribute name="obj_pos">
          <point val="21.1,4.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.4032,4.0713;21.1,4.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[2].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="21.1,4.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O400">
        <attribute name="obj_pos">
          <point val="21.1,4.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.4032,4.5713;21.1,4.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[3].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="21.1,4.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O401">
        <attribute name="obj_pos">
          <point val="21.1,5.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.4032,5.0713;21.1,5.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[4].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="21.1,5.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O402">
        <attribute name="obj_pos">
          <point val="21.1,5.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.4032,5.5713;21.1,5.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[5].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="21.1,5.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O403">
        <attribute name="obj_pos">
          <point val="21.1,6.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.4032,6.0713;21.1,6.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[6].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="21.1,6.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O404">
        <attribute name="obj_pos">
          <point val="21.1,6.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.4032,6.5713;21.1,6.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[7].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="21.1,6.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O405">
        <attribute name="obj_pos">
          <point val="21.1,7.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.4032,7.0713;21.1,7.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[8].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="21.1,7.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O406">
        <attribute name="obj_pos">
          <point val="21.1,7.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.4032,7.5713;21.1,7.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[9].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="21.1,7.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O407">
        <attribute name="obj_pos">
          <point val="21.1,8.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.4032,8.0713;21.1,8.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[10].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="21.1,8.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O408">
        <attribute name="obj_pos">
          <point val="21.1,8.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.4032,8.5713;21.1,8.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[11].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="21.1,8.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O409">
        <attribute name="obj_pos">
          <point val="21.1,9.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.4032,9.0713;21.1,9.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[12].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="21.1,9.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O410">
        <attribute name="obj_pos">
          <point val="21.1,9.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.4032,9.5713;21.1,9.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[13].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="21.1,9.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O411">
        <attribute name="obj_pos">
          <point val="21.1,10.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.4032,10.0713;21.1,10.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[14].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="21.1,10.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O412">
        <attribute name="obj_pos">
          <point val="21.1,10.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.4032,10.5713;21.1,10.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[15].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="21.1,10.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O413">
        <attribute name="obj_pos">
          <point val="21.1,11.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.4032,11.0713;21.1,11.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[16].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="21.1,11.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O414">
        <attribute name="obj_pos">
          <point val="21.1,11.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.4032,11.5713;21.1,11.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[17].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="21.1,11.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O415">
        <attribute name="obj_pos">
          <point val="21.1,12.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.4032,12.0713;21.1,12.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[18].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="21.1,12.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O416">
        <attribute name="obj_pos">
          <point val="21.1,12.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.4032,12.5713;21.1,12.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[19].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="21.1,12.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O417">
        <attribute name="obj_pos">
          <point val="21.1,13.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.4032,13.0713;21.1,13.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[20].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="21.1,13.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O418">
        <attribute name="obj_pos">
          <point val="21.1,13.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.4032,13.5713;21.1,13.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[21].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="21.1,13.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O419">
        <attribute name="obj_pos">
          <point val="21.1,14.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.4032,14.0713;21.1,14.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[22].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="21.1,14.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O420">
        <attribute name="obj_pos">
          <point val="21.1,14.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.4032,14.5713;21.1,14.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[23].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="21.1,14.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O421">
        <attribute name="obj_pos">
          <point val="21.1,15.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.4032,15.0713;21.1,15.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[24].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="21.1,15.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O422">
        <attribute name="obj_pos">
          <point val="21.1,15.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.4032,15.5713;21.1,15.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[25].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="21.1,15.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O423">
        <attribute name="obj_pos">
          <point val="21.1,16.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.4032,16.0713;21.1,16.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[26].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="21.1,16.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O424">
        <attribute name="obj_pos">
          <point val="21.1,16.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.4032,16.5713;21.1,16.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[27].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="21.1,16.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O425">
        <attribute name="obj_pos">
          <point val="21.1,17.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.4032,17.0713;21.1,17.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[28].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="21.1,17.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O426">
        <attribute name="obj_pos">
          <point val="21.1,17.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.4032,17.5713;21.1,17.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[29].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="21.1,17.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
    </group>
    <group>
      <object type="Embed - Text" version="0" id="O427">
        <attribute name="obj_pos">
          <point val="22.8,3.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="21.1032,3.0713;22.8,3.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[0].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="22.8,3.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O428">
        <attribute name="obj_pos">
          <point val="22.8,3.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="21.1032,3.5713;22.8,3.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[1].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="22.8,3.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O429">
        <attribute name="obj_pos">
          <point val="22.8,4.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="21.1032,4.0713;22.8,4.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[2].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="22.8,4.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O430">
        <attribute name="obj_pos">
          <point val="22.8,4.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="21.1032,4.5713;22.8,4.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[3].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="22.8,4.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O431">
        <attribute name="obj_pos">
          <point val="22.8,5.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="21.1032,5.0713;22.8,5.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[4].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="22.8,5.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O432">
        <attribute name="obj_pos">
          <point val="22.8,5.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="21.1032,5.5713;22.8,5.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[5].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="22.8,5.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O433">
        <attribute name="obj_pos">
          <point val="22.8,6.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="21.1032,6.0713;22.8,6.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[6].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="22.8,6.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O434">
        <attribute name="obj_pos">
          <point val="22.8,6.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="21.1032,6.5713;22.8,6.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[7].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="22.8,6.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O435">
        <attribute name="obj_pos">
          <point val="22.8,7.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="21.1032,7.0713;22.8,7.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[8].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="22.8,7.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O436">
        <attribute name="obj_pos">
          <point val="22.8,7.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="21.1032,7.5713;22.8,7.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[9].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="22.8,7.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O437">
        <attribute name="obj_pos">
          <point val="22.8,8.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="21.1032,8.0713;22.8,8.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[10].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="22.8,8.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O438">
        <attribute name="obj_pos">
          <point val="22.8,8.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="21.1032,8.5713;22.8,8.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[11].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="22.8,8.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O439">
        <attribute name="obj_pos">
          <point val="22.8,9.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="21.1032,9.0713;22.8,9.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[12].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="22.8,9.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O440">
        <attribute name="obj_pos">
          <point val="22.8,9.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="21.1032,9.5713;22.8,9.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[13].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="22.8,9.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O441">
        <attribute name="obj_pos">
          <point val="22.8,10.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="21.1032,10.0713;22.8,10.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[14].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="22.8,10.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O442">
        <attribute name="obj_pos">
          <point val="22.8,10.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="21.1032,10.5713;22.8,10.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[15].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="22.8,10.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O443">
        <attribute name="obj_pos">
          <point val="22.8,11.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="21.1032,11.0713;22.8,11.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[16].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="22.8,11.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O444">
        <attribute name="obj_pos">
          <point val="22.8,11.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="21.1032,11.5713;22.8,11.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[17].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="22.8,11.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O445">
        <attribute name="obj_pos">
          <point val="22.8,12.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="21.1032,12.0713;22.8,12.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[18].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="22.8,12.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O446">
        <attribute name="obj_pos">
          <point val="22.8,12.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="21.1032,12.5713;22.8,12.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[19].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="22.8,12.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O447">
        <attribute name="obj_pos">
          <point val="22.8,13.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="21.1032,13.0713;22.8,13.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[20].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="22.8,13.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O448">
        <attribute name="obj_pos">
          <point val="22.8,13.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="21.1032,13.5713;22.8,13.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[21].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="22.8,13.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O449">
        <attribute name="obj_pos">
          <point val="22.8,14.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="21.1032,14.0713;22.8,14.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[22].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="22.8,14.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O450">
        <attribute name="obj_pos">
          <point val="22.8,14.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="21.1032,14.5713;22.8,14.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[23].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="22.8,14.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O451">
        <attribute name="obj_pos">
          <point val="22.8,15.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="21.1032,15.0713;22.8,15.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[24].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="22.8,15.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O452">
        <attribute name="obj_pos">
          <point val="22.8,15.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="21.1032,15.5713;22.8,15.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[25].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="22.8,15.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O453">
        <attribute name="obj_pos">
          <point val="22.8,16.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="21.1032,16.0713;22.8,16.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[26].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="22.8,16.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O454">
        <attribute name="obj_pos">
          <point val="22.8,16.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="21.1032,16.5713;22.8,16.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[27].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="22.8,16.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O455">
        <attribute name="obj_pos">
          <point val="22.8,17.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="21.1032,17.0713;22.8,17.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[28].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="22.8,17.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O456">
        <attribute name="obj_pos">
          <point val="22.8,17.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="21.1032,17.5713;22.8,17.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[29].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="22.8,17.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
    </group>
    <group>
      <object type="Embed - Text" version="0" id="O457">
        <attribute name="obj_pos">
          <point val="24.5,3.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.8032,3.0713;24.5,3.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[0].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="24.5,3.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O458">
        <attribute name="obj_pos">
          <point val="24.5,3.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.8032,3.5713;24.5,3.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[1].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="24.5,3.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O459">
        <attribute name="obj_pos">
          <point val="24.5,4.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.8032,4.0713;24.5,4.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[2].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="24.5,4.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O460">
        <attribute name="obj_pos">
          <point val="24.5,4.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.8032,4.5713;24.5,4.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[3].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="24.5,4.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O461">
        <attribute name="obj_pos">
          <point val="24.5,5.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.8032,5.0713;24.5,5.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[4].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="24.5,5.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O462">
        <attribute name="obj_pos">
          <point val="24.5,5.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.8032,5.5713;24.5,5.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[5].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="24.5,5.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O463">
        <attribute name="obj_pos">
          <point val="24.5,6.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.8032,6.0713;24.5,6.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[6].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="24.5,6.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O464">
        <attribute name="obj_pos">
          <point val="24.5,6.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.8032,6.5713;24.5,6.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[7].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="24.5,6.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O465">
        <attribute name="obj_pos">
          <point val="24.5,7.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.8032,7.0713;24.5,7.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[8].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="24.5,7.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O466">
        <attribute name="obj_pos">
          <point val="24.5,7.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.8032,7.5713;24.5,7.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[9].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="24.5,7.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O467">
        <attribute name="obj_pos">
          <point val="24.5,8.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.8032,8.0713;24.5,8.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[10].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="24.5,8.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O468">
        <attribute name="obj_pos">
          <point val="24.5,8.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.8032,8.5713;24.5,8.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[11].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="24.5,8.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O469">
        <attribute name="obj_pos">
          <point val="24.5,9.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.8032,9.0713;24.5,9.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[12].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="24.5,9.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O470">
        <attribute name="obj_pos">
          <point val="24.5,9.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.8032,9.5713;24.5,9.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[13].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="24.5,9.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O471">
        <attribute name="obj_pos">
          <point val="24.5,10.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.8032,10.0713;24.5,10.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[14].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="24.5,10.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O472">
        <attribute name="obj_pos">
          <point val="24.5,10.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.8032,10.5713;24.5,10.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[15].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="24.5,10.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O473">
        <attribute name="obj_pos">
          <point val="24.5,11.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.8032,11.0713;24.5,11.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[16].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="24.5,11.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O474">
        <attribute name="obj_pos">
          <point val="24.5,11.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.8032,11.5713;24.5,11.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[17].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="24.5,11.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O475">
        <attribute name="obj_pos">
          <point val="24.5,12.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.8032,12.0713;24.5,12.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[18].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="24.5,12.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O476">
        <attribute name="obj_pos">
          <point val="24.5,12.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.8032,12.5713;24.5,12.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[19].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="24.5,12.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O477">
        <attribute name="obj_pos">
          <point val="24.5,13.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.8032,13.0713;24.5,13.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[20].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="24.5,13.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O478">
        <attribute name="obj_pos">
          <point val="24.5,13.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.8032,13.5713;24.5,13.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[21].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="24.5,13.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O479">
        <attribute name="obj_pos">
          <point val="24.5,14.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.8032,14.0713;24.5,14.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[22].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="24.5,14.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O480">
        <attribute name="obj_pos">
          <point val="24.5,14.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.8032,14.5713;24.5,14.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[23].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="24.5,14.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O481">
        <attribute name="obj_pos">
          <point val="24.5,15.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.8032,15.0713;24.5,15.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[24].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="24.5,15.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O482">
        <attribute name="obj_pos">
          <point val="24.5,15.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.8032,15.5713;24.5,15.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[25].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="24.5,15.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O483">
        <attribute name="obj_pos">
          <point val="24.5,16.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.8032,16.0713;24.5,16.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[26].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="24.5,16.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O484">
        <attribute name="obj_pos">
          <point val="24.5,16.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.8032,16.5713;24.5,16.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[27].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="24.5,16.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O485">
        <attribute name="obj_pos">
          <point val="24.5,17.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.8032,17.0713;24.5,17.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[28].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="24.5,17.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O486">
        <attribute name="obj_pos">
          <point val="24.5,17.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.8032,17.5713;24.5,17.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[29].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="24.5,17.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
    </group>
    <group>
      <object type="Embed - Text" version="0" id="O487">
        <attribute name="obj_pos">
          <point val="26.2,3.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.5032,3.0713;26.2,3.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[0].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="26.2,3.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O488">
        <attribute name="obj_pos">
          <point val="26.2,3.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.5032,3.5713;26.2,3.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[1].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="26.2,3.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O489">
        <attribute name="obj_pos">
          <point val="26.2,4.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.5032,4.0713;26.2,4.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[2].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="26.2,4.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O490">
        <attribute name="obj_pos">
          <point val="26.2,4.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.5032,4.5713;26.2,4.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[3].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="26.2,4.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O491">
        <attribute name="obj_pos">
          <point val="26.2,5.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.5032,5.0713;26.2,5.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[4].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="26.2,5.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O492">
        <attribute name="obj_pos">
          <point val="26.2,5.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.5032,5.5713;26.2,5.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[5].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="26.2,5.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O493">
        <attribute name="obj_pos">
          <point val="26.2,6.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.5032,6.0713;26.2,6.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[6].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="26.2,6.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O494">
        <attribute name="obj_pos">
          <point val="26.2,6.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.5032,6.5713;26.2,6.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[7].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="26.2,6.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O495">
        <attribute name="obj_pos">
          <point val="26.2,7.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.5032,7.0713;26.2,7.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[8].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="26.2,7.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O496">
        <attribute name="obj_pos">
          <point val="26.2,7.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.5032,7.5713;26.2,7.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[9].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="26.2,7.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O497">
        <attribute name="obj_pos">
          <point val="26.2,8.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.5032,8.0713;26.2,8.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[10].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="26.2,8.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O498">
        <attribute name="obj_pos">
          <point val="26.2,8.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.5032,8.5713;26.2,8.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[11].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="26.2,8.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O499">
        <attribute name="obj_pos">
          <point val="26.2,9.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.5032,9.0713;26.2,9.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[12].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="26.2,9.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O500">
        <attribute name="obj_pos">
          <point val="26.2,9.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.5032,9.5713;26.2,9.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[13].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="26.2,9.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O501">
        <attribute name="obj_pos">
          <point val="26.2,10.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.5032,10.0713;26.2,10.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[14].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="26.2,10.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O502">
        <attribute name="obj_pos">
          <point val="26.2,10.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.5032,10.5713;26.2,10.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[15].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="26.2,10.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O503">
        <attribute name="obj_pos">
          <point val="26.2,11.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.5032,11.0713;26.2,11.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[16].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="26.2,11.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O504">
        <attribute name="obj_pos">
          <point val="26.2,11.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.5032,11.5713;26.2,11.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[17].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="26.2,11.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O505">
        <attribute name="obj_pos">
          <point val="26.2,12.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.5032,12.0713;26.2,12.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[18].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="26.2,12.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O506">
        <attribute name="obj_pos">
          <point val="26.2,12.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.5032,12.5713;26.2,12.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[19].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="26.2,12.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O507">
        <attribute name="obj_pos">
          <point val="26.2,13.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.5032,13.0713;26.2,13.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[20].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="26.2,13.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O508">
        <attribute name="obj_pos">
          <point val="26.2,13.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.5032,13.5713;26.2,13.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[21].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="26.2,13.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O509">
        <attribute name="obj_pos">
          <point val="26.2,14.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.5032,14.0713;26.2,14.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[22].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="26.2,14.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O510">
        <attribute name="obj_pos">
          <point val="26.2,14.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.5032,14.5713;26.2,14.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[23].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="26.2,14.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O511">
        <attribute name="obj_pos">
          <point val="26.2,15.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.5032,15.0713;26.2,15.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[24].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="26.2,15.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O512">
        <attribute name="obj_pos">
          <point val="26.2,15.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.5032,15.5713;26.2,15.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[25].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="26.2,15.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O513">
        <attribute name="obj_pos">
          <point val="26.2,16.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.5032,16.0713;26.2,16.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[26].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="26.2,16.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O514">
        <attribute name="obj_pos">
          <point val="26.2,16.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.5032,16.5713;26.2,16.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[27].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="26.2,16.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O515">
        <attribute name="obj_pos">
          <point val="26.2,17.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.5032,17.0713;26.2,17.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[28].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="26.2,17.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O516">
        <attribute name="obj_pos">
          <point val="26.2,17.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.5032,17.5713;26.2,17.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[29].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="26.2,17.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
    </group>
    <group>
      <object type="Embed - Text" version="0" id="O517">
        <attribute name="obj_pos">
          <point val="27.9,3.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,3.0713;27.9,3.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[9].MONEY-OCC[0].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="27.9,3.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O518">
        <attribute name="obj_pos">
          <point val="27.9,3.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,3.5713;27.9,3.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[9].MONEY-OCC[1].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="27.9,3.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O519">
        <attribute name="obj_pos">
          <point val="27.9,4.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,4.0713;27.9,4.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[9].MONEY-OCC[2].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="27.9,4.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O520">
        <attribute name="obj_pos">
          <point val="27.9,4.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,4.5713;27.9,4.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[9].MONEY-OCC[3].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="27.9,4.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O521">
        <attribute name="obj_pos">
          <point val="27.9,5.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,5.0713;27.9,5.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[9].MONEY-OCC[4].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="27.9,5.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O522">
        <attribute name="obj_pos">
          <point val="27.9,5.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,5.5713;27.9,5.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[9].MONEY-OCC[5].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="27.9,5.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O523">
        <attribute name="obj_pos">
          <point val="27.9,6.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,6.0713;27.9,6.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[9].MONEY-OCC[6].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="27.9,6.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O524">
        <attribute name="obj_pos">
          <point val="27.9,6.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,6.5713;27.9,6.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[9].MONEY-OCC[7].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="27.9,6.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O525">
        <attribute name="obj_pos">
          <point val="27.9,7.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,7.0713;27.9,7.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[9].MONEY-OCC[8].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="27.9,7.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O526">
        <attribute name="obj_pos">
          <point val="27.9,7.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,7.5713;27.9,7.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[9].MONEY-OCC[9].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="27.9,7.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O527">
        <attribute name="obj_pos">
          <point val="27.9,8.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,8.0713;27.9,8.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[9].MONEY-OCC[10].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="27.9,8.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O528">
        <attribute name="obj_pos">
          <point val="27.9,8.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,8.5713;27.9,8.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[9].MONEY-OCC[11].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="27.9,8.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O529">
        <attribute name="obj_pos">
          <point val="27.9,9.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,9.0713;27.9,9.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[9].MONEY-OCC[12].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="27.9,9.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O530">
        <attribute name="obj_pos">
          <point val="27.9,9.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,9.5713;27.9,9.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[9].MONEY-OCC[13].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="27.9,9.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O531">
        <attribute name="obj_pos">
          <point val="27.9,10.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,10.0713;27.9,10.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[9].MONEY-OCC[14].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="27.9,10.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O532">
        <attribute name="obj_pos">
          <point val="27.9,10.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,10.5713;27.9,10.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[9].MONEY-OCC[15].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="27.9,10.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O533">
        <attribute name="obj_pos">
          <point val="27.9,11.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,11.0713;27.9,11.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[9].MONEY-OCC[16].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="27.9,11.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O534">
        <attribute name="obj_pos">
          <point val="27.9,11.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,11.5713;27.9,11.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[9].MONEY-OCC[17].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="27.9,11.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O535">
        <attribute name="obj_pos">
          <point val="27.9,12.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,12.0713;27.9,12.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[9].MONEY-OCC[18].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="27.9,12.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O536">
        <attribute name="obj_pos">
          <point val="27.9,12.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,12.5713;27.9,12.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[9].MONEY-OCC[19].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="27.9,12.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O537">
        <attribute name="obj_pos">
          <point val="27.9,13.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,13.0713;27.9,13.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[9].MONEY-OCC[20].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="27.9,13.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O538">
        <attribute name="obj_pos">
          <point val="27.9,13.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,13.5713;27.9,13.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[9].MONEY-OCC[21].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="27.9,13.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O539">
        <attribute name="obj_pos">
          <point val="27.9,14.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,14.0713;27.9,14.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[9].MONEY-OCC[22].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="27.9,14.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O540">
        <attribute name="obj_pos">
          <point val="27.9,14.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,14.5713;27.9,14.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[9].MONEY-OCC[23].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="27.9,14.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O541">
        <attribute name="obj_pos">
          <point val="27.9,15.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,15.0713;27.9,15.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[9].MONEY-OCC[24].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="27.9,15.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O542">
        <attribute name="obj_pos">
          <point val="27.9,15.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,15.5713;27.9,15.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[9].MONEY-OCC[25].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="27.9,15.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O543">
        <attribute name="obj_pos">
          <point val="27.9,16.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,16.0713;27.9,16.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[9].MONEY-OCC[26].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="27.9,16.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O544">
        <attribute name="obj_pos">
          <point val="27.9,16.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,16.5713;27.9,16.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[9].MONEY-OCC[27].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="27.9,16.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O545">
        <attribute name="obj_pos">
          <point val="27.9,17.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,17.0713;27.9,17.4213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[9].MONEY-OCC[28].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="27.9,17.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O546">
        <attribute name="obj_pos">
          <point val="27.9,17.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,17.5713;27.9,17.9213"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[9].MONEY-OCC[29].MONEY#</string>
        </attribute>
        <attribute name="embed_text_string">
          <enum val="0"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#99999999#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="27.9,17.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
    </group>
    <object type="Embed - Text" version="0" id="O547">
      <attribute name="obj_pos">
        <point val="27.9,18.3494"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.2032,18.0707;27.9,18.4207"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#GOKEI-G[10].GMONEY#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="27.9,18.3494"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O548">
      <attribute name="obj_pos">
        <point val="27.9,18.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.2032,18.5713;27.9,18.9213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#GOKEI-G[10].GHKNTEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="27.9,18.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O549">
      <attribute name="obj_pos">
        <point val="27.9,19.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.2032,19.0713;27.9,19.4213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#GOKEI-G[10].GKENSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="27.9,19.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O550">
      <attribute name="obj_pos">
        <point val="11.75,2.65"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="11.043,2.3713;12.457,2.7213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MONEY-G[0].HKNNAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.75,2.65"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O551">
      <attribute name="obj_pos">
        <point val="13.45,2.65"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.743,2.3713;14.157,2.7213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MONEY-G[1].HKNNAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="13.45,2.65"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O552">
      <attribute name="obj_pos">
        <point val="15.15,2.65"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.443,2.3713;15.857,2.7213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MONEY-G[2].HKNNAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.15,2.65"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O553">
      <attribute name="obj_pos">
        <point val="16.85,2.65"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.143,2.3713;17.557,2.7213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MONEY-G[3].HKNNAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.85,2.65"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O554">
      <attribute name="obj_pos">
        <point val="18.55,2.65"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.843,2.3713;19.257,2.7213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MONEY-G[4].HKNNAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.55,2.65"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O555">
      <attribute name="obj_pos">
        <point val="20.25,2.65"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.543,2.3713;20.957,2.7213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MONEY-G[5].HKNNAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="20.25,2.65"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O556">
      <attribute name="obj_pos">
        <point val="21.95,2.65"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.243,2.3713;22.657,2.7213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MONEY-G[6].HKNNAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="21.95,2.65"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O557">
      <attribute name="obj_pos">
        <point val="23.65,2.65"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.943,2.3713;24.357,2.7213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MONEY-G[7].HKNNAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="23.65,2.65"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O558">
      <attribute name="obj_pos">
        <point val="25.35,2.65"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.643,2.3713;26.057,2.7213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MONEY-G[8].HKNNAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="25.35,2.65"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O559">
      <attribute name="obj_pos">
        <point val="27.05,2.65"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.343,2.3713;27.757,2.7213"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MONEY-G[9].HKNNAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="27.05,2.65"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
  </layer>
</diagram>
