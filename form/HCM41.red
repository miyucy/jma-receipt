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
    <element name="GOKEI-G" occurs="10">
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
    <element name="MONEY-G" occurs="9">
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
  <layer name="&#192;&#254;" visible="true">
    <object type="Standard - Line" version="0" id="O0">
      <attribute name="obj_pos">
        <point val="1,3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.99,2.99;28.01,3.01"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,3"/>
        <point val="28,3"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.02"/>
      </attribute>
      <connections>
        <connection handle="0" to="O6" connection="1"/>
        <connection handle="1" to="O7" connection="1"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O1">
      <attribute name="obj_pos">
        <point val="1.8,2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.79,1.99;1.81,18.01"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.8,2"/>
        <point val="1.8,18"/>
      </attribute>
      <attribute name="numcp">
        <int val="31"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.02"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O2">
      <attribute name="obj_pos">
        <point val="6,19.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.99,19.49;28.01,19.51"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="6,19.5"/>
        <point val="28,19.5"/>
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
        <rectangle val="0.99,17.99;28.01,18.01"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,18"/>
        <point val="28,18"/>
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
        <rectangle val="0.99,1.99;28.01,2.01"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,2"/>
        <point val="28,2"/>
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
        <point val="28,2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.99,1.99;28.01,18.01"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="28,2"/>
        <point val="28,18"/>
      </attribute>
      <attribute name="numcp">
        <int val="31"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.02"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O8">
      <attribute name="obj_pos">
        <point val="28,18"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.99,17.99;28.01,19.51"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="28,18"/>
        <point val="28,19.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="2"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.02"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O9">
      <attribute name="obj_pos">
        <point val="1,3.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,3.495;28.005,3.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,3.5"/>
        <point val="28,3.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O10">
      <attribute name="obj_pos">
        <point val="1,5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,4.995;28.005,5.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,5"/>
        <point val="28,5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O11">
      <attribute name="obj_pos">
        <point val="1,6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,5.995;28.005,6.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,6"/>
        <point val="28,6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O12">
      <attribute name="obj_pos">
        <point val="1,7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,6.995;28.005,7.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,7"/>
        <point val="28,7"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O13">
      <attribute name="obj_pos">
        <point val="1,6.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,6.495;28.005,6.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,6.5"/>
        <point val="28,6.5"/>
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
        <point val="1,8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,7.995;28.005,8.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,8"/>
        <point val="28,8"/>
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
        <point val="1,9.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,9.495;28.005,9.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,9.5"/>
        <point val="28,9.5"/>
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
        <point val="1,10.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,10.495;28.005,10.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,10.5"/>
        <point val="28,10.5"/>
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
        <point val="1,4.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,4.495;28.005,4.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,4.5"/>
        <point val="28,4.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O18">
      <attribute name="obj_pos">
        <point val="1,5.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,5.495;28.005,5.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,5.5"/>
        <point val="28,5.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O19">
      <attribute name="obj_pos">
        <point val="1,7.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,7.495;28.005,7.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,7.5"/>
        <point val="28,7.5"/>
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
        <point val="1,9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,8.995;28.005,9.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,9"/>
        <point val="28,9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O21">
      <attribute name="obj_pos">
        <point val="1,8.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,8.495;28.005,8.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,8.5"/>
        <point val="28,8.5"/>
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
        <point val="1,10"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,9.995;28.005,10.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,10"/>
        <point val="28,10"/>
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
        <point val="1,4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,3.995;28.005,4.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,4"/>
        <point val="28,4"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O24">
      <attribute name="obj_pos">
        <point val="1,15.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,15.495;28.005,15.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,15.5"/>
        <point val="28,15.5"/>
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
        <point val="1,15"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,14.995;28.005,15.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,15"/>
        <point val="28,15"/>
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
        <point val="1,14.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,14.495;28.005,14.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,14.5"/>
        <point val="28,14.5"/>
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
        <point val="1,14"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,13.995;28.005,14.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,14"/>
        <point val="28,14"/>
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
        <point val="1,13.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,13.495;28.005,13.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,13.5"/>
        <point val="28,13.5"/>
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
        <point val="1,13"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,12.995;28.005,13.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,13"/>
        <point val="28,13"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O30">
      <attribute name="obj_pos">
        <point val="1,12.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,12.495;28.005,12.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,12.5"/>
        <point val="28,12.5"/>
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
        <point val="1,12"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,11.995;28.005,12.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,12"/>
        <point val="28,12"/>
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
        <point val="1,11.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,11.495;28.005,11.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,11.5"/>
        <point val="28,11.5"/>
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
        <point val="1,11"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,10.995;28.005,11.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,11"/>
        <point val="28,11"/>
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
        <point val="1,17.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,17.495;28.005,17.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,17.5"/>
        <point val="28,17.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O35">
      <attribute name="obj_pos">
        <point val="1,17"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,16.995;28.005,17.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,17"/>
        <point val="28,17"/>
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
        <point val="1,16.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,16.495;28.005,16.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,16.5"/>
        <point val="28,16.5"/>
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
        <point val="1,16"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.995,15.995;28.005,16.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,16"/>
        <point val="28,16"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O38">
      <attribute name="obj_pos">
        <point val="6,2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.995,1.995;6.005,18.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="6,2"/>
        <point val="6,18"/>
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
        <point val="10,2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.995,1.995;10.005,18.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="10,2"/>
        <point val="10,18"/>
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
        <point val="11.8,2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="11.795,1.995;11.805,18.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="11.8,2"/>
        <point val="11.8,18"/>
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
        <point val="13.6,2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.595,1.995;13.605,18.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="13.6,2"/>
        <point val="13.6,18"/>
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
        <point val="15.4,2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.395,1.995;15.405,18.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="15.4,2"/>
        <point val="15.4,18"/>
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
        <point val="17.2,2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.195,1.995;17.205,18.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="17.2,2"/>
        <point val="17.2,18"/>
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
        <point val="19,2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.995,1.995;19.005,18.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="19,2"/>
        <point val="19,18"/>
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
        <point val="26.2,2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.195,1.995;26.205,18.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="26.2,2"/>
        <point val="26.2,18"/>
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
        <point val="24.4,2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.395,1.995;24.405,18.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="24.4,2"/>
        <point val="24.4,18"/>
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
        <point val="22.6,2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.595,1.995;22.605,18.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="22.6,2"/>
        <point val="22.6,18"/>
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
        <point val="20.8,2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="20.795,1.995;20.805,18.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="20.8,2"/>
        <point val="20.8,18"/>
      </attribute>
      <attribute name="numcp">
        <int val="31"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O49">
      <attribute name="obj_pos">
        <point val="6,18.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.995,18.495;28.005,18.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="6,18.5"/>
        <point val="28,18.5"/>
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
        <point val="6,19"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.995,18.995;28.005,19.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="6,19"/>
        <point val="28,19"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O51">
      <attribute name="obj_pos">
        <point val="10,18"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.995,17.995;10.005,19.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="10,18"/>
        <point val="10,19.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="2"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O52">
      <attribute name="obj_pos">
        <point val="11.8,18"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="11.795,17.995;11.805,19.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="11.8,18"/>
        <point val="11.8,19.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="2"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O53">
      <attribute name="obj_pos">
        <point val="13.6,18"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.595,17.995;13.605,19.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="13.6,18"/>
        <point val="13.6,19.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="2"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O54">
      <attribute name="obj_pos">
        <point val="15.4,18"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.395,17.995;15.405,19.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="15.4,18"/>
        <point val="15.4,19.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="2"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O55">
      <attribute name="obj_pos">
        <point val="17.2,18"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.195,17.995;17.205,19.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="17.2,18"/>
        <point val="17.2,19.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="2"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O56">
      <attribute name="obj_pos">
        <point val="19,18"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.995,17.995;19.005,19.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="19,18"/>
        <point val="19,19.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="2"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O57">
      <attribute name="obj_pos">
        <point val="20.8,18"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="20.795,17.995;20.805,19.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="20.8,18"/>
        <point val="20.8,19.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="2"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O58">
      <attribute name="obj_pos">
        <point val="22.6,18"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.595,17.995;22.605,19.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="22.6,18"/>
        <point val="22.6,19.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="2"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O59">
      <attribute name="obj_pos">
        <point val="24.4,18"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.395,17.995;24.405,19.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="24.4,18"/>
        <point val="24.4,19.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="2"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O60">
      <attribute name="obj_pos">
        <point val="26.2,18"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.195,17.995;26.205,19.505"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="26.2,18"/>
        <point val="26.2,19.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="2"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
  </layer>
  <layer name="&#202;&#184;&#187;&#250;" visible="true">
    <object type="Standard - Text" version="0" id="O61">
      <attribute name="obj_pos">
        <point val="12.1877,1.42892"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.1877,1.11619;17.4397,1.51619"/>
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
    <object type="Standard - Text" version="0" id="O62">
      <attribute name="obj_pos">
        <point val="7,18.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7,18.1264;8.8382,18.4764"/>
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
    <object type="Standard - Text" version="0" id="O63">
      <attribute name="obj_pos">
        <point val="7,18.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7,18.6264;8.8382,18.9764"/>
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
    <object type="Standard - Text" version="0" id="O64">
      <attribute name="obj_pos">
        <point val="7,19.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7,19.1264;8.7675,19.4764"/>
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
    <object type="Standard - Text" version="0" id="O65">
      <attribute name="obj_pos">
        <point val="26.0527,1.3524"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.0527,1.07876;26.4062,1.42876"/>
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
    <object type="Standard - Text" version="0" id="O66">
      <attribute name="obj_pos">
        <point val="16.9278,19.9605"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.9278,19.6869;27.5328,20.0369"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#162;&#168;&#188;&#171;&#200;&#241;&#205;&#243;&#164;&#206;&#161;&#246;&#164;&#207;&#176;&#229;&#206;&#197;&#202;&#221;&#184;&#177;&#161;&#202;&#207;&#171;&#186;&#210;&#161;&#166;&#188;&#171;&#199;&#229;&#164;&#242;&#180;&#222;&#164;&#224;&#161;&#203;&#191;&#199;&#206;&#197;&#187;&#254;&#164;&#206;&#188;&#171;&#200;&#241;&#201;&#233;&#195;&#180;&#202;&#172;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.9278,19.9605"/>
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
    <object type="Standard - Text" version="0" id="O67">
      <attribute name="obj_pos">
        <point val="10.9,2.65"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.193,2.37636;11.607,2.72636"/>
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
            <point val="10.9,2.65"/>
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
    <object type="Standard - Text" version="0" id="O68">
      <attribute name="obj_pos">
        <point val="12.7,2.65"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="11.993,2.37636;13.407,2.72636"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#188;&#210;&#202;&#221;&#203;&#220;&#191;&#205;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="12.7,2.65"/>
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
    <object type="Standard - Text" version="0" id="O69">
      <attribute name="obj_pos">
        <point val="14.5,2.65"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.793,2.37636;15.207,2.72636"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#188;&#210;&#202;&#221;&#178;&#200;&#194;&#178;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="14.5,2.65"/>
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
    <object type="Standard - Text" version="0" id="O70">
      <attribute name="obj_pos">
        <point val="16.3,2.65"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.593,2.37636;17.007,2.72636"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#188;&#210;&#202;&#221;&#207;&#183;&#191;&#205;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.3,2.65"/>
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
    <object type="Standard - Text" version="0" id="O71">
      <attribute name="obj_pos">
        <point val="18.1,2.65"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.393,2.37636;18.807,2.72636"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#185;&#241;&#202;&#221;&#176;&#236;&#200;&#204;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.1,2.65"/>
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
    <object type="Standard - Text" version="0" id="O72">
      <attribute name="obj_pos">
        <point val="19.9,2.65"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.193,2.37636;20.607,2.72636"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#185;&#241;&#202;&#221;&#207;&#183;&#191;&#205;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="19.9,2.65"/>
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
    <object type="Standard - Text" version="0" id="O73">
      <attribute name="obj_pos">
        <point val="21.7,2.65"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="20.993,2.37636;22.407,2.72636"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#184;&#248;&#200;&#241;&#195;&#177;&#198;&#200;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="21.7,2.65"/>
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
    <object type="Standard - Text" version="0" id="O74">
      <attribute name="obj_pos">
        <point val="27.1,2.65"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.5698,2.37636;27.6303,2.72636"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#188;&#171;&#199;&#229;&#192;&#213;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="27.1,2.65"/>
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
    <object type="Standard - Text" version="0" id="O75">
      <attribute name="obj_pos">
        <point val="25.3,2.65"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.7698,2.37636;25.8303,2.72636"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#207;&#171;&#161;&#161;&#186;&#210;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="25.3,2.65"/>
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
    <object type="Standard - Text" version="0" id="O76">
      <attribute name="obj_pos">
        <point val="23.5,2.65"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.9698,2.37636;24.0303,2.72636"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#188;&#171;&#161;&#161;&#200;&#241;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="23.5,2.65"/>
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
    <object type="Standard - Text" version="0" id="O77">
      <attribute name="obj_pos">
        <point val="8,2.65"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.97485,2.37636;9.02515,2.72636"/>
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
            <point val="8,2.65"/>
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
    <object type="Standard - Text" version="0" id="O78">
      <attribute name="obj_pos">
        <point val="1.4,2.65"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0465,2.37636;1.7535,2.72636"/>
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
    <object type="Standard - Text" version="0" id="O79">
      <attribute name="obj_pos">
        <point val="3.9,2.65"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.66275,2.37636;5.13725,2.72636"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#180;&#181;&#161;&#161;&#188;&#212;&#161;&#161;&#200;&#214;&#161;&#161;&#185;&#230;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.9,2.65"/>
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
  <layer name="&#186;&#185;&#164;&#183;&#185;&#254;&#164;&#223;" visible="true">
    <object type="Embed - Text" version="0" id="O80">
      <attribute name="obj_pos">
        <point val="23.8527,1.8024"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.8527,1.52876;27.7412,1.87876"/>
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
    <object type="Embed - Text" version="0" id="O81">
      <attribute name="obj_pos">
        <point val="3.825,1.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.825,1.52636;7.7135,1.87636"/>
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
    <object type="Embed - Text" version="0" id="O82">
      <attribute name="obj_pos">
        <point val="26.4777,1.3024"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.4777,1.02876;27.114,1.37876"/>
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
    <object type="Embed - Text" version="0" id="O83">
      <attribute name="obj_pos">
        <point val="1.875,1.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.875,1.52636;3.6425,1.87636"/>
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
    <object type="Embed - Text" version="0" id="O84">
      <attribute name="obj_pos">
        <point val="11.7,18.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.0032,18.0764;11.7,18.4264"/>
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
            <point val="11.7,18.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O85">
      <attribute name="obj_pos">
        <point val="13.5,18.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="11.8032,18.0764;13.5,18.4264"/>
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
            <point val="13.5,18.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O86">
      <attribute name="obj_pos">
        <point val="15.3,18.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.6032,18.0764;15.3,18.4264"/>
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
            <point val="15.3,18.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O87">
      <attribute name="obj_pos">
        <point val="17.1,18.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.4032,18.0764;17.1,18.4264"/>
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
            <point val="17.1,18.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O88">
      <attribute name="obj_pos">
        <point val="18.9,18.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.2032,18.0764;18.9,18.4264"/>
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
            <point val="18.9,18.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O89">
      <attribute name="obj_pos">
        <point val="20.7,18.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.0032,18.0764;20.7,18.4264"/>
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
            <point val="20.7,18.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O90">
      <attribute name="obj_pos">
        <point val="22.5,18.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="20.8032,18.0764;22.5,18.4264"/>
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
            <point val="22.5,18.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O91">
      <attribute name="obj_pos">
        <point val="24.3,18.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.6032,18.0764;24.3,18.4264"/>
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
            <point val="24.3,18.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O92">
      <attribute name="obj_pos">
        <point val="26.1,18.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.4032,18.0764;26.1,18.4264"/>
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
            <point val="26.1,18.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="27.8946,18.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.1978,18.0764;27.8946,18.4264"/>
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
            <point val="27.8946,18.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="11.7,18.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.0032,18.5764;11.7,18.9264"/>
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
            <point val="11.7,18.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="13.5,18.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="11.8032,18.5764;13.5,18.9264"/>
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
            <point val="13.5,18.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="15.3,18.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.6032,18.5764;15.3,18.9264"/>
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
            <point val="15.3,18.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="17.1,18.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.4032,18.5764;17.1,18.9264"/>
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
            <point val="17.1,18.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="18.9,18.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.2032,18.5764;18.9,18.9264"/>
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
            <point val="18.9,18.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="20.7,18.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.0032,18.5764;20.7,18.9264"/>
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
            <point val="20.7,18.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="22.5,18.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="20.8032,18.5764;22.5,18.9264"/>
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
            <point val="22.5,18.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="24.3,18.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.6032,18.5764;24.3,18.9264"/>
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
            <point val="24.3,18.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="26.1,18.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.4032,18.5764;26.1,18.9264"/>
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
            <point val="26.1,18.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="27.8946,18.8506"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.1978,18.577;27.8946,18.927"/>
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
            <point val="27.8946,18.8506"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="11.7,19.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.0032,19.0764;11.7,19.4264"/>
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
            <point val="11.7,19.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="13.5,19.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="11.8032,19.0764;13.5,19.4264"/>
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
            <point val="13.5,19.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="15.3,19.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.6032,19.0764;15.3,19.4264"/>
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
            <point val="15.3,19.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="17.1,19.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.4032,19.0764;17.1,19.4264"/>
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
            <point val="17.1,19.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="18.9,19.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.2032,19.0764;18.9,19.4264"/>
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
            <point val="18.9,19.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="20.7,19.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.0032,19.0764;20.7,19.4264"/>
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
            <point val="20.7,19.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="22.5,19.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="20.8032,19.0764;22.5,19.4264"/>
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
            <point val="22.5,19.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="24.3,19.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.6032,19.0764;24.3,19.4264"/>
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
            <point val="24.3,19.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="26.1,19.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.4032,19.0764;26.1,19.4264"/>
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
            <point val="26.1,19.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="27.9027,19.3506"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.2059,19.077;27.9027,19.427"/>
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
            <point val="27.9027,19.3506"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <group>
      <object type="Embed - Text" version="0" id="O114">
        <attribute name="obj_pos">
          <point val="1.7,3.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.0637,3.07636;1.7,3.42636"/>
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
      <object type="Embed - Text" version="0" id="O115">
        <attribute name="obj_pos">
          <point val="1.7,3.85028"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.0637,3.57664;1.7,3.92664"/>
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
              <point val="1.7,3.85028"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="1.7,4.35056"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.0637,4.07692;1.7,4.42692"/>
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
              <point val="1.7,4.35056"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="1.7,4.85084"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.0637,4.5772;1.7,4.9272"/>
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
              <point val="1.7,4.85084"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="1.7,5.35112"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.0637,5.07748;1.7,5.42748"/>
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
              <point val="1.7,5.35112"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="1.7,5.8514"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.0637,5.57776;1.7,5.92776"/>
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
              <point val="1.7,5.8514"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="1.6927,6.35168"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.0564,6.07804;1.6927,6.42804"/>
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
              <point val="1.6927,6.35168"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="1.7,6.85196"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.0637,6.57832;1.7,6.92832"/>
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
              <point val="1.7,6.85196"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="1.7,7.35224"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.0637,7.0786;1.7,7.4286"/>
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
              <point val="1.7,7.35224"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="1.7,7.85252"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.0637,7.57888;1.7,7.92888"/>
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
              <point val="1.7,7.85252"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="1.7,8.3528"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.0637,8.07916;1.7,8.42916"/>
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
              <point val="1.7,8.3528"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="1.7,8.85308"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.0637,8.57944;1.7,8.92944"/>
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
              <point val="1.7,8.85308"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="1.7,9.35336"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.0637,9.07972;1.7,9.42972"/>
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
              <point val="1.7,9.35336"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="1.7,9.85364"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.0637,9.58;1.7,9.93"/>
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
              <point val="1.7,9.85364"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="1.7,10.3539"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.0637,10.0803;1.7,10.4303"/>
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
              <point val="1.7,10.3539"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="1.7,10.8542"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.0637,10.5806;1.7,10.9306"/>
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
              <point val="1.7,10.8542"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="1.7,11.3544"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.0637,11.0808;1.7,11.4308"/>
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
              <point val="1.7,11.3544"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="1.7,11.8547"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.0637,11.5811;1.7,11.9311"/>
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
              <point val="1.7,11.8547"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="1.7,12.355"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.0637,12.0814;1.7,12.4314"/>
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
              <point val="1.7,12.355"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="1.7177,12.8553"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.0814,12.5817;1.7177,12.9317"/>
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
              <point val="1.7177,12.8553"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="1.725,13.3556"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.0887,13.082;1.725,13.432"/>
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
              <point val="1.725,13.3556"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="1.725,13.8558"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.0887,13.5822;1.725,13.9322"/>
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
              <point val="1.725,13.8558"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="1.725,14.3561"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.0887,14.0825;1.725,14.4325"/>
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
              <point val="1.725,14.3561"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="1.725,14.8564"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.0887,14.5828;1.725,14.9328"/>
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
              <point val="1.725,14.8564"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="1.725,15.3567"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.0887,15.0831;1.725,15.4331"/>
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
              <point val="1.725,15.3567"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="1.725,15.857"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.0887,15.5834;1.725,15.9334"/>
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
              <point val="1.725,15.857"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="1.72304,16.3572"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.08674,16.0836;1.72304,16.4336"/>
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
              <point val="1.72304,16.3572"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="1.725,16.8575"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.0887,16.5839;1.725,16.9339"/>
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
              <point val="1.725,16.8575"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="1.725,17.3578"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.0887,17.0842;1.725,17.4342"/>
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
              <point val="1.725,17.3578"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="1.71798,17.8581"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.08168,17.5845;1.71798,17.9345"/>
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
              <point val="1.71798,17.8581"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
      <object type="Embed - Text" version="0" id="O144">
        <attribute name="obj_pos">
          <point val="1.9,3.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.9,3.07636;6.142,3.42636"/>
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
              <string>#12345678901234567890#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="1.9,3.35"/>
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
      <object type="Embed - Text" version="0" id="O145">
        <attribute name="obj_pos">
          <point val="1.9,3.85028"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.9,3.57664;6.142,3.92664"/>
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
              <string>#12345678901234567890#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="1.9,3.85028"/>
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
      <object type="Embed - Text" version="0" id="O146">
        <attribute name="obj_pos">
          <point val="1.9,4.35056"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.9,4.07692;6.142,4.42692"/>
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
              <string>#12345678901234567890#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="1.9,4.35056"/>
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
      <object type="Embed - Text" version="0" id="O147">
        <attribute name="obj_pos">
          <point val="1.9,4.85084"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.9,4.5772;6.142,4.9272"/>
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
              <string>#12345678901234567890#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="1.9,4.85084"/>
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
      <object type="Embed - Text" version="0" id="O148">
        <attribute name="obj_pos">
          <point val="1.9,5.35112"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.9,5.07748;6.142,5.42748"/>
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
              <string>#12345678901234567890#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="1.9,5.35112"/>
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
      <object type="Embed - Text" version="0" id="O149">
        <attribute name="obj_pos">
          <point val="1.9,5.8514"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.9,5.57776;6.142,5.92776"/>
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
              <string>#12345678901234567890#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="1.9,5.8514"/>
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
      <object type="Embed - Text" version="0" id="O150">
        <attribute name="obj_pos">
          <point val="1.9,6.35168"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.9,6.07804;6.142,6.42804"/>
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
              <string>#12345678901234567890#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="1.9,6.35168"/>
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
      <object type="Embed - Text" version="0" id="O151">
        <attribute name="obj_pos">
          <point val="1.9,6.85196"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.9,6.57832;6.142,6.92832"/>
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
              <string>#12345678901234567890#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="1.9,6.85196"/>
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
      <object type="Embed - Text" version="0" id="O152">
        <attribute name="obj_pos">
          <point val="1.9,7.35224"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.9,7.0786;6.142,7.4286"/>
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
              <string>#12345678901234567890#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="1.9,7.35224"/>
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
      <object type="Embed - Text" version="0" id="O153">
        <attribute name="obj_pos">
          <point val="1.9,7.85252"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.9,7.57888;6.142,7.92888"/>
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
              <string>#12345678901234567890#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="1.9,7.85252"/>
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
      <object type="Embed - Text" version="0" id="O154">
        <attribute name="obj_pos">
          <point val="1.9,8.3528"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.9,8.07916;6.142,8.42916"/>
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
              <string>#12345678901234567890#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="1.9,8.3528"/>
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
      <object type="Embed - Text" version="0" id="O155">
        <attribute name="obj_pos">
          <point val="1.9,8.85308"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.9,8.57944;6.142,8.92944"/>
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
              <string>#12345678901234567890#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="1.9,8.85308"/>
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
      <object type="Embed - Text" version="0" id="O156">
        <attribute name="obj_pos">
          <point val="1.9,9.35336"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.9,9.07972;6.142,9.42972"/>
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
              <string>#12345678901234567890#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="1.9,9.35336"/>
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
          <point val="1.9,9.85364"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.9,9.58;6.142,9.93"/>
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
              <string>#12345678901234567890#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="1.9,9.85364"/>
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
          <point val="1.9,10.3539"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.9,10.0803;6.142,10.4303"/>
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
              <string>#12345678901234567890#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="1.9,10.3539"/>
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
          <point val="1.9,10.8542"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.9,10.5806;6.142,10.9306"/>
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
              <string>#12345678901234567890#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="1.9,10.8542"/>
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
          <point val="1.9,11.3544"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.9,11.0808;6.142,11.4308"/>
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
              <string>#12345678901234567890#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="1.9,11.3544"/>
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
          <point val="1.9,11.8547"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.9,11.5811;6.142,11.9311"/>
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
              <string>#12345678901234567890#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="1.9,11.8547"/>
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
          <point val="1.9,12.355"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.9,12.0814;6.142,12.4314"/>
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
              <string>#12345678901234567890#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="1.9,12.355"/>
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
          <point val="1.9,12.8553"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.9,12.5817;6.142,12.9317"/>
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
              <string>#12345678901234567890#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="1.9,12.8553"/>
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
          <point val="1.875,13.3556"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.875,13.082;6.117,13.432"/>
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
              <string>#12345678901234567890#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="1.875,13.3556"/>
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
          <point val="1.875,13.8558"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.875,13.5822;6.117,13.9322"/>
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
              <string>#12345678901234567890#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="1.875,13.8558"/>
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
          <point val="1.875,14.3561"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.875,14.0825;6.117,14.4325"/>
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
              <string>#12345678901234567890#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="1.875,14.3561"/>
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
          <point val="1.9,14.8564"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.9,14.5828;6.142,14.9328"/>
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
              <string>#12345678901234567890#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="1.9,14.8564"/>
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
          <point val="1.875,15.3567"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.875,15.0831;6.117,15.4331"/>
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
              <string>#12345678901234567890#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="1.875,15.3567"/>
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
          <point val="1.875,15.857"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.875,15.5834;6.117,15.9334"/>
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
              <string>#12345678901234567890#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="1.875,15.857"/>
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
          <point val="1.875,16.3572"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.875,16.0836;6.117,16.4336"/>
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
              <string>#12345678901234567890#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="1.875,16.3572"/>
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
          <point val="1.875,16.8575"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.875,16.5839;6.117,16.9339"/>
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
              <string>#12345678901234567890#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="1.875,16.8575"/>
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
          <point val="1.875,17.3578"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.875,17.0842;6.117,17.4342"/>
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
              <string>#12345678901234567890#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="1.875,17.3578"/>
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
          <point val="1.875,17.8581"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="1.875,17.5845;6.117,17.9345"/>
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
              <string>#12345678901234567890#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.35"/>
            </attribute>
            <attribute name="pos">
              <point val="1.875,17.8581"/>
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
    </group>
    <group>
      <object type="Embed - Text" version="0" id="O174">
        <attribute name="obj_pos">
          <point val="6.1,3.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="6.1,3.11545;10.039,3.41545"/>
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
              <point val="6.1,3.35"/>
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
      <object type="Embed - Text" version="0" id="O175">
        <attribute name="obj_pos">
          <point val="6.1,3.85028"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="6.1,3.61573;10.039,3.91573"/>
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
              <point val="6.1,3.85028"/>
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
      <object type="Embed - Text" version="0" id="O176">
        <attribute name="obj_pos">
          <point val="6.1,4.35056"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="6.1,4.11601;10.039,4.41601"/>
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
              <point val="6.1,4.35056"/>
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
      <object type="Embed - Text" version="0" id="O177">
        <attribute name="obj_pos">
          <point val="6.1,4.85084"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="6.1,4.61629;10.039,4.91629"/>
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
              <point val="6.1,4.85084"/>
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
      <object type="Embed - Text" version="0" id="O178">
        <attribute name="obj_pos">
          <point val="6.1,5.35112"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="6.1,5.11657;10.039,5.41657"/>
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
              <point val="6.1,5.35112"/>
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
      <object type="Embed - Text" version="0" id="O179">
        <attribute name="obj_pos">
          <point val="6.1,5.8514"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="6.1,5.61685;10.039,5.91685"/>
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
              <point val="6.1,5.8514"/>
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
      <object type="Embed - Text" version="0" id="O180">
        <attribute name="obj_pos">
          <point val="6.1,6.35168"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="6.1,6.11713;10.039,6.41713"/>
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
              <point val="6.1,6.35168"/>
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
      <object type="Embed - Text" version="0" id="O181">
        <attribute name="obj_pos">
          <point val="6.1,6.85196"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="6.1,6.61741;10.039,6.91741"/>
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
              <point val="6.1,6.85196"/>
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
      <object type="Embed - Text" version="0" id="O182">
        <attribute name="obj_pos">
          <point val="6.1,7.35224"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="6.1,7.11769;10.039,7.41769"/>
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
              <point val="6.1,7.35224"/>
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
      <object type="Embed - Text" version="0" id="O183">
        <attribute name="obj_pos">
          <point val="6.1,7.85252"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="6.1,7.61797;10.039,7.91797"/>
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
              <point val="6.1,7.85252"/>
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
      <object type="Embed - Text" version="0" id="O184">
        <attribute name="obj_pos">
          <point val="6.1,8.3528"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="6.1,8.11825;10.039,8.41825"/>
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
              <point val="6.1,8.3528"/>
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
      <object type="Embed - Text" version="0" id="O185">
        <attribute name="obj_pos">
          <point val="6.1,8.85308"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="6.1,8.61853;10.039,8.91853"/>
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
              <point val="6.1,8.85308"/>
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
      <object type="Embed - Text" version="0" id="O186">
        <attribute name="obj_pos">
          <point val="6.1,9.35336"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="6.1,9.11881;10.039,9.41881"/>
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
              <point val="6.1,9.35336"/>
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
          <point val="6.1,9.85364"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="6.1,9.61909;10.039,9.91909"/>
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
              <point val="6.1,9.85364"/>
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
          <point val="6.1,10.3539"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="6.1,10.1194;10.039,10.4194"/>
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
              <point val="6.1,10.3539"/>
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
          <point val="6.1,10.8542"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="6.1,10.6197;10.039,10.9197"/>
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
              <point val="6.1,10.8542"/>
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
          <point val="6.1,11.3545"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="6.1,11.12;10.039,11.42"/>
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
              <point val="6.1,11.3545"/>
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
          <point val="6.1,11.8548"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="6.1,11.6203;10.039,11.9203"/>
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
              <point val="6.1,11.8548"/>
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
          <point val="6.1,12.355"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="6.1,12.1205;10.039,12.4205"/>
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
              <point val="6.1,12.355"/>
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
          <point val="6.125,12.8553"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="6.125,12.6208;10.064,12.9208"/>
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
              <point val="6.125,12.8553"/>
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
          <point val="6.125,13.3556"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="6.125,13.1211;10.064,13.4211"/>
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
              <point val="6.125,13.3556"/>
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
          <point val="6.125,13.8559"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="6.125,13.6214;10.064,13.9214"/>
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
              <point val="6.125,13.8559"/>
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
          <point val="6.125,14.3562"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="6.125,14.1217;10.064,14.4217"/>
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
              <point val="6.125,14.3562"/>
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
          <point val="6.125,14.8564"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="6.125,14.6219;10.064,14.9219"/>
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
              <point val="6.125,14.8564"/>
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
          <point val="6.125,15.3567"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="6.125,15.1222;10.064,15.4222"/>
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
              <point val="6.125,15.3567"/>
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
          <point val="6.125,15.857"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="6.125,15.6225;10.064,15.9225"/>
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
              <point val="6.125,15.857"/>
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
          <point val="6.125,16.3573"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="6.125,16.1228;10.064,16.4228"/>
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
              <point val="6.125,16.3573"/>
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
          <point val="6.125,16.8576"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="6.125,16.6231;10.064,16.9231"/>
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
              <point val="6.125,16.8576"/>
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
          <point val="6.125,17.3578"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="6.125,17.1233;10.064,17.4233"/>
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
              <point val="6.125,17.3578"/>
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
          <point val="6.15,17.8581"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="6.15,17.6236;10.089,17.9236"/>
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
              <point val="6.15,17.8581"/>
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
    </group>
    <group>
      <object type="Embed - Text" version="0" id="O204">
        <attribute name="obj_pos">
          <point val="11.7,3.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.0032,3.07636;11.7,3.42636"/>
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
              <point val="11.7,3.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O205">
        <attribute name="obj_pos">
          <point val="11.7,3.85028"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.0032,3.57664;11.7,3.92664"/>
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
              <point val="11.7,3.85028"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O206">
        <attribute name="obj_pos">
          <point val="11.7,4.35056"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.0032,4.07692;11.7,4.42692"/>
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
              <point val="11.7,4.35056"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O207">
        <attribute name="obj_pos">
          <point val="11.7,4.85084"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.0032,4.5772;11.7,4.9272"/>
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
              <point val="11.7,4.85084"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O208">
        <attribute name="obj_pos">
          <point val="11.7,5.35112"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.0032,5.07748;11.7,5.42748"/>
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
              <point val="11.7,5.35112"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O209">
        <attribute name="obj_pos">
          <point val="11.7,5.8514"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.0032,5.57776;11.7,5.92776"/>
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
              <point val="11.7,5.8514"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O210">
        <attribute name="obj_pos">
          <point val="11.7,6.35168"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.0032,6.07804;11.7,6.42804"/>
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
              <point val="11.7,6.35168"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O211">
        <attribute name="obj_pos">
          <point val="11.7,6.85196"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.0032,6.57832;11.7,6.92832"/>
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
              <point val="11.7,6.85196"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O212">
        <attribute name="obj_pos">
          <point val="11.7,7.35224"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.0032,7.0786;11.7,7.4286"/>
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
              <point val="11.7,7.35224"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O213">
        <attribute name="obj_pos">
          <point val="11.7,7.85252"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.0032,7.57888;11.7,7.92888"/>
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
              <point val="11.7,7.85252"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O214">
        <attribute name="obj_pos">
          <point val="11.7,8.3528"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.0032,8.07916;11.7,8.42916"/>
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
              <point val="11.7,8.3528"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O215">
        <attribute name="obj_pos">
          <point val="11.7,8.85308"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.0032,8.57944;11.7,8.92944"/>
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
              <point val="11.7,8.85308"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O216">
        <attribute name="obj_pos">
          <point val="11.7,9.35336"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.0032,9.07972;11.7,9.42972"/>
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
              <point val="11.7,9.35336"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="11.7,9.85364"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.0032,9.58;11.7,9.93"/>
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
              <point val="11.7,9.85364"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="11.7,10.3539"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.0032,10.0803;11.7,10.4303"/>
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
              <point val="11.7,10.3539"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="11.7,10.8542"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.0032,10.5806;11.7,10.9306"/>
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
              <point val="11.7,10.8542"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="11.7,11.3544"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.0032,11.0808;11.7,11.4308"/>
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
              <point val="11.7,11.3544"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="11.7,11.8547"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.0032,11.5811;11.7,11.9311"/>
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
              <point val="11.7,11.8547"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="11.7,12.355"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.0032,12.0814;11.7,12.4314"/>
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
              <point val="11.7,12.355"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="11.7,12.8553"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.0032,12.5817;11.7,12.9317"/>
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
              <point val="11.7,12.8553"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="11.7,13.3556"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.0032,13.082;11.7,13.432"/>
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
              <point val="11.7,13.3556"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="11.7,13.8558"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.0032,13.5822;11.7,13.9322"/>
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
              <point val="11.7,13.8558"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="11.7,14.3561"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.0032,14.0825;11.7,14.4325"/>
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
              <point val="11.7,14.3561"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="11.7,14.8564"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.0032,14.5828;11.7,14.9328"/>
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
              <point val="11.7,14.8564"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="11.7,15.3567"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.0032,15.0831;11.7,15.4331"/>
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
              <point val="11.7,15.3567"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="11.7,15.857"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.0032,15.5834;11.7,15.9334"/>
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
              <point val="11.7,15.857"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="11.7,16.3572"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.0032,16.0836;11.7,16.4336"/>
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
              <point val="11.7,16.3572"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="11.7,16.8575"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.0032,16.5839;11.7,16.9339"/>
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
              <point val="11.7,16.8575"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="11.7,17.3578"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.0032,17.0842;11.7,17.4342"/>
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
              <point val="11.7,17.3578"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="11.6793,17.8581"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="9.9825,17.5845;11.6793,17.9345"/>
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
              <point val="11.6793,17.8581"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
      <object type="Embed - Text" version="0" id="O234">
        <attribute name="obj_pos">
          <point val="13.5,3.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="11.8032,3.07636;13.5,3.42636"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[0].MONEY#</string>
        </attribute>
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
              <point val="13.5,3.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="13.5,3.85028"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="11.8032,3.57664;13.5,3.92664"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[1].MONEY#</string>
        </attribute>
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
              <point val="13.5,3.85028"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="13.5,4.35056"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="11.8032,4.07692;13.5,4.42692"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[2].MONEY#</string>
        </attribute>
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
              <point val="13.5,4.35056"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="13.5,4.85084"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="11.8032,4.5772;13.5,4.9272"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[3].MONEY#</string>
        </attribute>
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
              <point val="13.5,4.85084"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="13.5,5.35112"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="11.8032,5.07748;13.5,5.42748"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[4].MONEY#</string>
        </attribute>
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
              <point val="13.5,5.35112"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="13.5,5.8514"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="11.8032,5.57776;13.5,5.92776"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[5].MONEY#</string>
        </attribute>
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
              <point val="13.5,5.8514"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="13.5,6.35168"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="11.8032,6.07804;13.5,6.42804"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[6].MONEY#</string>
        </attribute>
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
              <point val="13.5,6.35168"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="13.5,6.85196"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="11.8032,6.57832;13.5,6.92832"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[7].MONEY#</string>
        </attribute>
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
              <point val="13.5,6.85196"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="13.5,7.35224"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="11.8032,7.0786;13.5,7.4286"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[8].MONEY#</string>
        </attribute>
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
              <point val="13.5,7.35224"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="13.5,7.85252"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="11.8032,7.57888;13.5,7.92888"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[9].MONEY#</string>
        </attribute>
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
              <point val="13.5,7.85252"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="13.5,8.3528"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="11.8032,8.07916;13.5,8.42916"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[10].MONEY#</string>
        </attribute>
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
              <point val="13.5,8.3528"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="13.5,8.85308"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="11.8032,8.57944;13.5,8.92944"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[11].MONEY#</string>
        </attribute>
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
              <point val="13.5,8.85308"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="13.5,9.35336"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="11.8032,9.07972;13.5,9.42972"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[12].MONEY#</string>
        </attribute>
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
              <point val="13.5,9.35336"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O247">
        <attribute name="obj_pos">
          <point val="13.5,9.85364"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="11.8032,9.58;13.5,9.93"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[13].MONEY#</string>
        </attribute>
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
              <point val="13.5,9.85364"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="13.5,10.3539"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="11.8032,10.0803;13.5,10.4303"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[14].MONEY#</string>
        </attribute>
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
              <point val="13.5,10.3539"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="13.5,10.8542"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="11.8032,10.5806;13.5,10.9306"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[15].MONEY#</string>
        </attribute>
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
              <point val="13.5,10.8542"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="13.5,11.3544"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="11.8032,11.0808;13.5,11.4308"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[16].MONEY#</string>
        </attribute>
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
              <point val="13.5,11.3544"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="13.5,11.8547"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="11.8032,11.5811;13.5,11.9311"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[17].MONEY#</string>
        </attribute>
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
              <point val="13.5,11.8547"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="13.5,12.355"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="11.8032,12.0814;13.5,12.4314"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[18].MONEY#</string>
        </attribute>
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
              <point val="13.5,12.355"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="13.5,12.8553"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="11.8032,12.5817;13.5,12.9317"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[19].MONEY#</string>
        </attribute>
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
              <point val="13.5,12.8553"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="13.5,13.3556"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="11.8032,13.082;13.5,13.432"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[20].MONEY#</string>
        </attribute>
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
              <point val="13.5,13.3556"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="13.5,13.8558"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="11.8032,13.5822;13.5,13.9322"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[21].MONEY#</string>
        </attribute>
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
              <point val="13.5,13.8558"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="13.5,14.3561"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="11.8032,14.0825;13.5,14.4325"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[22].MONEY#</string>
        </attribute>
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
              <point val="13.5,14.3561"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="13.5,14.8564"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="11.8032,14.5828;13.5,14.9328"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[23].MONEY#</string>
        </attribute>
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
              <point val="13.5,14.8564"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="13.5,15.3567"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="11.8032,15.0831;13.5,15.4331"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[24].MONEY#</string>
        </attribute>
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
              <point val="13.5,15.3567"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="13.5,15.857"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="11.8032,15.5834;13.5,15.9334"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[25].MONEY#</string>
        </attribute>
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
              <point val="13.5,15.857"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="13.5,16.3572"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="11.8032,16.0836;13.5,16.4336"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[26].MONEY#</string>
        </attribute>
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
              <point val="13.5,16.3572"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="13.5,16.8575"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="11.8032,16.5839;13.5,16.9339"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[27].MONEY#</string>
        </attribute>
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
              <point val="13.5,16.8575"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="13.5,17.3578"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="11.8032,17.0842;13.5,17.4342"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[28].MONEY#</string>
        </attribute>
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
              <point val="13.5,17.3578"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="13.5,17.8581"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="11.8032,17.5845;13.5,17.9345"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[0].MONEY-OCC[29].MONEY#</string>
        </attribute>
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
              <point val="13.5,17.8581"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
      <object type="Embed - Text" version="0" id="O264">
        <attribute name="obj_pos">
          <point val="15.3,3.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="13.6032,3.07636;15.3,3.42636"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[0].MONEY#</string>
        </attribute>
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
              <point val="15.3,3.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="15.3,3.85028"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="13.6032,3.57664;15.3,3.92664"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[1].MONEY#</string>
        </attribute>
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
              <point val="15.3,3.85028"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="15.3,4.35056"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="13.6032,4.07692;15.3,4.42692"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[2].MONEY#</string>
        </attribute>
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
              <point val="15.3,4.35056"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="15.3,4.85084"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="13.6032,4.5772;15.3,4.9272"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[3].MONEY#</string>
        </attribute>
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
              <point val="15.3,4.85084"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="15.3,5.35112"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="13.6032,5.07748;15.3,5.42748"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[4].MONEY#</string>
        </attribute>
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
              <point val="15.3,5.35112"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="15.3,5.8514"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="13.6032,5.57776;15.3,5.92776"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[5].MONEY#</string>
        </attribute>
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
              <point val="15.3,5.8514"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="15.3,6.35168"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="13.6032,6.07804;15.3,6.42804"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[6].MONEY#</string>
        </attribute>
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
              <point val="15.3,6.35168"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="15.3,6.85196"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="13.6032,6.57832;15.3,6.92832"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[7].MONEY#</string>
        </attribute>
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
              <point val="15.3,6.85196"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="15.3,7.35224"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="13.6032,7.0786;15.3,7.4286"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[8].MONEY#</string>
        </attribute>
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
              <point val="15.3,7.35224"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="15.3,7.85252"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="13.6032,7.57888;15.3,7.92888"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[9].MONEY#</string>
        </attribute>
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
              <point val="15.3,7.85252"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="15.3,8.3528"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="13.6032,8.07916;15.3,8.42916"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[10].MONEY#</string>
        </attribute>
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
              <point val="15.3,8.3528"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="15.3,8.85308"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="13.6032,8.57944;15.3,8.92944"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[11].MONEY#</string>
        </attribute>
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
              <point val="15.3,8.85308"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="15.3,9.35336"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="13.6032,9.07972;15.3,9.42972"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[12].MONEY#</string>
        </attribute>
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
              <point val="15.3,9.35336"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O277">
        <attribute name="obj_pos">
          <point val="15.3,9.85364"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="13.6032,9.58;15.3,9.93"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[13].MONEY#</string>
        </attribute>
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
              <point val="15.3,9.85364"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="15.3,10.3539"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="13.6032,10.0803;15.3,10.4303"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[14].MONEY#</string>
        </attribute>
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
              <point val="15.3,10.3539"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="15.3,10.8542"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="13.6032,10.5806;15.3,10.9306"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[15].MONEY#</string>
        </attribute>
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
              <point val="15.3,10.8542"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="15.3,11.3544"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="13.6032,11.0808;15.3,11.4308"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[16].MONEY#</string>
        </attribute>
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
              <point val="15.3,11.3544"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="15.3,11.8547"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="13.6032,11.5811;15.3,11.9311"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[17].MONEY#</string>
        </attribute>
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
              <point val="15.3,11.8547"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="15.3,12.355"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="13.6032,12.0814;15.3,12.4314"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[18].MONEY#</string>
        </attribute>
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
              <point val="15.3,12.355"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="15.3,12.8553"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="13.6032,12.5817;15.3,12.9317"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[19].MONEY#</string>
        </attribute>
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
              <point val="15.3,12.8553"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="15.3,13.3556"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="13.6032,13.082;15.3,13.432"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[20].MONEY#</string>
        </attribute>
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
              <point val="15.3,13.3556"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="15.3,13.8558"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="13.6032,13.5822;15.3,13.9322"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[21].MONEY#</string>
        </attribute>
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
              <point val="15.3,13.8558"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="15.3,14.3561"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="13.6032,14.0825;15.3,14.4325"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[22].MONEY#</string>
        </attribute>
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
              <point val="15.3,14.3561"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="15.3,14.8564"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="13.6032,14.5828;15.3,14.9328"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[23].MONEY#</string>
        </attribute>
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
              <point val="15.3,14.8564"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="15.3,15.3567"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="13.6032,15.0831;15.3,15.4331"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[24].MONEY#</string>
        </attribute>
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
              <point val="15.3,15.3567"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="15.3,15.857"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="13.6032,15.5834;15.3,15.9334"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[25].MONEY#</string>
        </attribute>
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
              <point val="15.3,15.857"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="15.3,16.3572"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="13.6032,16.0836;15.3,16.4336"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[26].MONEY#</string>
        </attribute>
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
              <point val="15.3,16.3572"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="15.3,16.8575"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="13.6032,16.5839;15.3,16.9339"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[27].MONEY#</string>
        </attribute>
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
              <point val="15.3,16.8575"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="15.3,17.3578"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="13.6032,17.0842;15.3,17.4342"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[28].MONEY#</string>
        </attribute>
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
              <point val="15.3,17.3578"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="15.3,17.8581"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="13.6032,17.5845;15.3,17.9345"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[1].MONEY-OCC[29].MONEY#</string>
        </attribute>
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
              <point val="15.3,17.8581"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
      <object type="Embed - Text" version="0" id="O294">
        <attribute name="obj_pos">
          <point val="17.1,3.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="15.4032,3.07636;17.1,3.42636"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[0].MONEY#</string>
        </attribute>
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
              <point val="17.1,3.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="17.1,3.85028"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="15.4032,3.57664;17.1,3.92664"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[1].MONEY#</string>
        </attribute>
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
              <point val="17.1,3.85028"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="17.1,4.35056"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="15.4032,4.07692;17.1,4.42692"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[2].MONEY#</string>
        </attribute>
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
              <point val="17.1,4.35056"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="17.1,4.85084"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="15.4032,4.5772;17.1,4.9272"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[3].MONEY#</string>
        </attribute>
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
              <point val="17.1,4.85084"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="17.1,5.35112"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="15.4032,5.07748;17.1,5.42748"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[4].MONEY#</string>
        </attribute>
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
              <point val="17.1,5.35112"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="17.1,5.8514"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="15.4032,5.57776;17.1,5.92776"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[5].MONEY#</string>
        </attribute>
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
              <point val="17.1,5.8514"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="17.1,6.35168"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="15.4032,6.07804;17.1,6.42804"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[6].MONEY#</string>
        </attribute>
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
              <point val="17.1,6.35168"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="17.1,6.85196"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="15.4032,6.57832;17.1,6.92832"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[7].MONEY#</string>
        </attribute>
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
              <point val="17.1,6.85196"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="17.1,7.35224"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="15.4032,7.0786;17.1,7.4286"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[8].MONEY#</string>
        </attribute>
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
              <point val="17.1,7.35224"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="17.1,7.85252"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="15.4032,7.57888;17.1,7.92888"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[9].MONEY#</string>
        </attribute>
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
              <point val="17.1,7.85252"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="17.1,8.3528"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="15.4032,8.07916;17.1,8.42916"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[10].MONEY#</string>
        </attribute>
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
              <point val="17.1,8.3528"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="17.1,8.85308"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="15.4032,8.57944;17.1,8.92944"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[11].MONEY#</string>
        </attribute>
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
              <point val="17.1,8.85308"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="17.1,9.35336"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="15.4032,9.07972;17.1,9.42972"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[12].MONEY#</string>
        </attribute>
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
              <point val="17.1,9.35336"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O307">
        <attribute name="obj_pos">
          <point val="17.1,9.85364"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="15.4032,9.58;17.1,9.93"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[13].MONEY#</string>
        </attribute>
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
              <point val="17.1,9.85364"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="17.1,10.3539"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="15.4032,10.0803;17.1,10.4303"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[14].MONEY#</string>
        </attribute>
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
              <point val="17.1,10.3539"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="17.1,10.8542"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="15.4032,10.5806;17.1,10.9306"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[15].MONEY#</string>
        </attribute>
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
              <point val="17.1,10.8542"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="17.1,11.3544"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="15.4032,11.0808;17.1,11.4308"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[16].MONEY#</string>
        </attribute>
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
              <point val="17.1,11.3544"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="17.1,11.8547"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="15.4032,11.5811;17.1,11.9311"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[17].MONEY#</string>
        </attribute>
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
              <point val="17.1,11.8547"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="17.1,12.355"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="15.4032,12.0814;17.1,12.4314"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[18].MONEY#</string>
        </attribute>
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
              <point val="17.1,12.355"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="17.1,12.8553"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="15.4032,12.5817;17.1,12.9317"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[19].MONEY#</string>
        </attribute>
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
              <point val="17.1,12.8553"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="17.1,13.3556"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="15.4032,13.082;17.1,13.432"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[20].MONEY#</string>
        </attribute>
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
              <point val="17.1,13.3556"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="17.1,13.8558"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="15.4032,13.5822;17.1,13.9322"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[21].MONEY#</string>
        </attribute>
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
              <point val="17.1,13.8558"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="17.1,14.3561"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="15.4032,14.0825;17.1,14.4325"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[22].MONEY#</string>
        </attribute>
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
              <point val="17.1,14.3561"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="17.1,14.8564"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="15.4032,14.5828;17.1,14.9328"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[23].MONEY#</string>
        </attribute>
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
              <point val="17.1,14.8564"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="17.1,15.3567"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="15.4032,15.0831;17.1,15.4331"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[24].MONEY#</string>
        </attribute>
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
              <point val="17.1,15.3567"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="17.1,15.857"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="15.4032,15.5834;17.1,15.9334"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[25].MONEY#</string>
        </attribute>
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
              <point val="17.1,15.857"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="17.1,16.3572"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="15.4032,16.0836;17.1,16.4336"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[26].MONEY#</string>
        </attribute>
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
              <point val="17.1,16.3572"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="17.1,16.8575"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="15.4032,16.5839;17.1,16.9339"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[27].MONEY#</string>
        </attribute>
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
              <point val="17.1,16.8575"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="17.1,17.3578"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="15.4032,17.0842;17.1,17.4342"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[28].MONEY#</string>
        </attribute>
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
              <point val="17.1,17.3578"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="17.1,17.8581"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="15.4032,17.5845;17.1,17.9345"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[2].MONEY-OCC[29].MONEY#</string>
        </attribute>
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
              <point val="17.1,17.8581"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
      <object type="Embed - Text" version="0" id="O324">
        <attribute name="obj_pos">
          <point val="18.9,3.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.2032,3.07636;18.9,3.42636"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[0].MONEY#</string>
        </attribute>
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
              <point val="18.9,3.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="18.9,3.85028"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.2032,3.57664;18.9,3.92664"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[1].MONEY#</string>
        </attribute>
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
              <point val="18.9,3.85028"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="18.9,4.35056"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.2032,4.07692;18.9,4.42692"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[2].MONEY#</string>
        </attribute>
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
              <point val="18.9,4.35056"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="18.9,4.85084"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.2032,4.5772;18.9,4.9272"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[3].MONEY#</string>
        </attribute>
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
              <point val="18.9,4.85084"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="18.9,5.35112"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.2032,5.07748;18.9,5.42748"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[4].MONEY#</string>
        </attribute>
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
              <point val="18.9,5.35112"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="18.9,5.8514"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.2032,5.57776;18.9,5.92776"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[5].MONEY#</string>
        </attribute>
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
              <point val="18.9,5.8514"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="18.9,6.35168"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.2032,6.07804;18.9,6.42804"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[6].MONEY#</string>
        </attribute>
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
              <point val="18.9,6.35168"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="18.9,6.85196"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.2032,6.57832;18.9,6.92832"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[7].MONEY#</string>
        </attribute>
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
              <point val="18.9,6.85196"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="18.9,7.35224"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.2032,7.0786;18.9,7.4286"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[8].MONEY#</string>
        </attribute>
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
              <point val="18.9,7.35224"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="18.9,7.85252"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.2032,7.57888;18.9,7.92888"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[9].MONEY#</string>
        </attribute>
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
              <point val="18.9,7.85252"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="18.9,8.3528"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.2032,8.07916;18.9,8.42916"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[10].MONEY#</string>
        </attribute>
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
              <point val="18.9,8.3528"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="18.9,8.85308"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.2032,8.57944;18.9,8.92944"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[11].MONEY#</string>
        </attribute>
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
              <point val="18.9,8.85308"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="18.9,9.35336"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.2032,9.07972;18.9,9.42972"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[12].MONEY#</string>
        </attribute>
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
              <point val="18.9,9.35336"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O337">
        <attribute name="obj_pos">
          <point val="18.9,9.85364"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.2032,9.58;18.9,9.93"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[13].MONEY#</string>
        </attribute>
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
              <point val="18.9,9.85364"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="18.9,10.3539"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.2032,10.0803;18.9,10.4303"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[14].MONEY#</string>
        </attribute>
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
              <point val="18.9,10.3539"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="18.9,10.8542"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.2032,10.5806;18.9,10.9306"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[15].MONEY#</string>
        </attribute>
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
              <point val="18.9,10.8542"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="18.9,11.3544"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.2032,11.0808;18.9,11.4308"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[16].MONEY#</string>
        </attribute>
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
              <point val="18.9,11.3544"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="18.9,11.8547"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.2032,11.5811;18.9,11.9311"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[17].MONEY#</string>
        </attribute>
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
              <point val="18.9,11.8547"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="18.9,12.355"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.2032,12.0814;18.9,12.4314"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[18].MONEY#</string>
        </attribute>
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
              <point val="18.9,12.355"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="18.9,12.8553"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.2032,12.5817;18.9,12.9317"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[19].MONEY#</string>
        </attribute>
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
              <point val="18.9,12.8553"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="18.9,13.3556"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.2032,13.082;18.9,13.432"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[20].MONEY#</string>
        </attribute>
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
              <point val="18.9,13.3556"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="18.9,13.8558"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.2032,13.5822;18.9,13.9322"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[21].MONEY#</string>
        </attribute>
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
              <point val="18.9,13.8558"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="18.9,14.3561"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.2032,14.0825;18.9,14.4325"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[22].MONEY#</string>
        </attribute>
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
              <point val="18.9,14.3561"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="18.9,14.8564"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.2032,14.5828;18.9,14.9328"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[23].MONEY#</string>
        </attribute>
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
              <point val="18.9,14.8564"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="18.9,15.3567"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.2032,15.0831;18.9,15.4331"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[24].MONEY#</string>
        </attribute>
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
              <point val="18.9,15.3567"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="18.9,15.857"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.2032,15.5834;18.9,15.9334"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[25].MONEY#</string>
        </attribute>
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
              <point val="18.9,15.857"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="18.9,16.3572"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.2032,16.0836;18.9,16.4336"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[26].MONEY#</string>
        </attribute>
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
              <point val="18.9,16.3572"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="18.9,16.8575"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.2032,16.5839;18.9,16.9339"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[27].MONEY#</string>
        </attribute>
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
              <point val="18.9,16.8575"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="18.9,17.3578"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.2032,17.0842;18.9,17.4342"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[28].MONEY#</string>
        </attribute>
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
              <point val="18.9,17.3578"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="18.9,17.8581"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="17.2032,17.5845;18.9,17.9345"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[3].MONEY-OCC[29].MONEY#</string>
        </attribute>
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
              <point val="18.9,17.8581"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
      <object type="Embed - Text" version="0" id="O354">
        <attribute name="obj_pos">
          <point val="20.7,3.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.0032,3.07636;20.7,3.42636"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[0].MONEY#</string>
        </attribute>
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
              <point val="20.7,3.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="20.7,3.85028"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.0032,3.57664;20.7,3.92664"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[1].MONEY#</string>
        </attribute>
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
              <point val="20.7,3.85028"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="20.7,4.35056"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.0032,4.07692;20.7,4.42692"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[2].MONEY#</string>
        </attribute>
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
              <point val="20.7,4.35056"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="20.7,4.85084"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.0032,4.5772;20.7,4.9272"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[3].MONEY#</string>
        </attribute>
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
              <point val="20.7,4.85084"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="20.7,5.35112"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.0032,5.07748;20.7,5.42748"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[4].MONEY#</string>
        </attribute>
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
              <point val="20.7,5.35112"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="20.7,5.8514"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.0032,5.57776;20.7,5.92776"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[5].MONEY#</string>
        </attribute>
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
              <point val="20.7,5.8514"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="20.7,6.35168"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.0032,6.07804;20.7,6.42804"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[6].MONEY#</string>
        </attribute>
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
              <point val="20.7,6.35168"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="20.7,6.85196"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.0032,6.57832;20.7,6.92832"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[7].MONEY#</string>
        </attribute>
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
              <point val="20.7,6.85196"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="20.7,7.35224"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.0032,7.0786;20.7,7.4286"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[8].MONEY#</string>
        </attribute>
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
              <point val="20.7,7.35224"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="20.7,7.85252"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.0032,7.57888;20.7,7.92888"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[9].MONEY#</string>
        </attribute>
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
              <point val="20.7,7.85252"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="20.7,8.3528"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.0032,8.07916;20.7,8.42916"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[10].MONEY#</string>
        </attribute>
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
              <point val="20.7,8.3528"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="20.7,8.85308"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.0032,8.57944;20.7,8.92944"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[11].MONEY#</string>
        </attribute>
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
              <point val="20.7,8.85308"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="20.7,9.35336"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.0032,9.07972;20.7,9.42972"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[12].MONEY#</string>
        </attribute>
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
              <point val="20.7,9.35336"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O367">
        <attribute name="obj_pos">
          <point val="20.7,9.85364"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.0032,9.58;20.7,9.93"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[13].MONEY#</string>
        </attribute>
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
              <point val="20.7,9.85364"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="20.7,10.3539"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.0032,10.0803;20.7,10.4303"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[14].MONEY#</string>
        </attribute>
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
              <point val="20.7,10.3539"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="20.7,10.8542"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.0032,10.5806;20.7,10.9306"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[15].MONEY#</string>
        </attribute>
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
              <point val="20.7,10.8542"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="20.7,11.3544"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.0032,11.0808;20.7,11.4308"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[16].MONEY#</string>
        </attribute>
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
              <point val="20.7,11.3544"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="20.7,11.8547"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.0032,11.5811;20.7,11.9311"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[17].MONEY#</string>
        </attribute>
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
              <point val="20.7,11.8547"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="20.7,12.355"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.0032,12.0814;20.7,12.4314"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[18].MONEY#</string>
        </attribute>
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
              <point val="20.7,12.355"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="20.7,12.8553"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.0032,12.5817;20.7,12.9317"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[19].MONEY#</string>
        </attribute>
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
              <point val="20.7,12.8553"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="20.7,13.3556"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.0032,13.082;20.7,13.432"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[20].MONEY#</string>
        </attribute>
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
              <point val="20.7,13.3556"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="20.7,13.8558"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.0032,13.5822;20.7,13.9322"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[21].MONEY#</string>
        </attribute>
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
              <point val="20.7,13.8558"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="20.7,14.3561"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.0032,14.0825;20.7,14.4325"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[22].MONEY#</string>
        </attribute>
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
              <point val="20.7,14.3561"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="20.7,14.8564"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.0032,14.5828;20.7,14.9328"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[23].MONEY#</string>
        </attribute>
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
              <point val="20.7,14.8564"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="20.7,15.3567"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.0032,15.0831;20.7,15.4331"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[24].MONEY#</string>
        </attribute>
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
              <point val="20.7,15.3567"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="20.7,15.857"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.0032,15.5834;20.7,15.9334"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[25].MONEY#</string>
        </attribute>
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
              <point val="20.7,15.857"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="20.7,16.3572"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.0032,16.0836;20.7,16.4336"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[26].MONEY#</string>
        </attribute>
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
              <point val="20.7,16.3572"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="20.7,16.8575"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.0032,16.5839;20.7,16.9339"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[27].MONEY#</string>
        </attribute>
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
              <point val="20.7,16.8575"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="20.7,17.3578"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.0032,17.0842;20.7,17.4342"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[28].MONEY#</string>
        </attribute>
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
              <point val="20.7,17.3578"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="20.7,17.8581"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="19.0032,17.5845;20.7,17.9345"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[4].MONEY-OCC[29].MONEY#</string>
        </attribute>
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
              <point val="20.7,17.8581"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
      <object type="Embed - Text" version="0" id="O384">
        <attribute name="obj_pos">
          <point val="22.5,3.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="20.8032,3.07636;22.5,3.42636"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[0].MONEY#</string>
        </attribute>
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
              <point val="22.5,3.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="22.5,3.85028"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="20.8032,3.57664;22.5,3.92664"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[1].MONEY#</string>
        </attribute>
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
              <point val="22.5,3.85028"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="22.5,4.35056"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="20.8032,4.07692;22.5,4.42692"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[2].MONEY#</string>
        </attribute>
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
              <point val="22.5,4.35056"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="22.5,4.85084"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="20.8032,4.5772;22.5,4.9272"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[3].MONEY#</string>
        </attribute>
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
              <point val="22.5,4.85084"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="22.5,5.35112"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="20.8032,5.07748;22.5,5.42748"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[4].MONEY#</string>
        </attribute>
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
              <point val="22.5,5.35112"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="22.5,5.8514"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="20.8032,5.57776;22.5,5.92776"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[5].MONEY#</string>
        </attribute>
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
              <point val="22.5,5.8514"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="22.5,6.35168"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="20.8032,6.07804;22.5,6.42804"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[6].MONEY#</string>
        </attribute>
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
              <point val="22.5,6.35168"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="22.5,6.85196"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="20.8032,6.57832;22.5,6.92832"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[7].MONEY#</string>
        </attribute>
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
              <point val="22.5,6.85196"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="22.5,7.35224"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="20.8032,7.0786;22.5,7.4286"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[8].MONEY#</string>
        </attribute>
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
              <point val="22.5,7.35224"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="22.5,7.85252"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="20.8032,7.57888;22.5,7.92888"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[9].MONEY#</string>
        </attribute>
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
              <point val="22.5,7.85252"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="22.5,8.3528"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="20.8032,8.07916;22.5,8.42916"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[10].MONEY#</string>
        </attribute>
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
              <point val="22.5,8.3528"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="22.5,8.85308"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="20.8032,8.57944;22.5,8.92944"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[11].MONEY#</string>
        </attribute>
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
              <point val="22.5,8.85308"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="22.5,9.35336"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="20.8032,9.07972;22.5,9.42972"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[12].MONEY#</string>
        </attribute>
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
              <point val="22.5,9.35336"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O397">
        <attribute name="obj_pos">
          <point val="22.5,9.85364"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="20.8032,9.58;22.5,9.93"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[13].MONEY#</string>
        </attribute>
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
              <point val="22.5,9.85364"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="22.5,10.3539"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="20.8032,10.0803;22.5,10.4303"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[14].MONEY#</string>
        </attribute>
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
              <point val="22.5,10.3539"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="22.5,10.8542"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="20.8032,10.5806;22.5,10.9306"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[15].MONEY#</string>
        </attribute>
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
              <point val="22.5,10.8542"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="22.5,11.3544"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="20.8032,11.0808;22.5,11.4308"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[16].MONEY#</string>
        </attribute>
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
              <point val="22.5,11.3544"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="22.5,11.8547"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="20.8032,11.5811;22.5,11.9311"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[17].MONEY#</string>
        </attribute>
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
              <point val="22.5,11.8547"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="22.5,12.355"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="20.8032,12.0814;22.5,12.4314"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[18].MONEY#</string>
        </attribute>
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
              <point val="22.5,12.355"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="22.5,12.8553"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="20.8032,12.5817;22.5,12.9317"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[19].MONEY#</string>
        </attribute>
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
              <point val="22.5,12.8553"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="22.5,13.3556"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="20.8032,13.082;22.5,13.432"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[20].MONEY#</string>
        </attribute>
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
              <point val="22.5,13.3556"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="22.5,13.8558"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="20.8032,13.5822;22.5,13.9322"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[21].MONEY#</string>
        </attribute>
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
              <point val="22.5,13.8558"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="22.5,14.3561"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="20.8032,14.0825;22.5,14.4325"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[22].MONEY#</string>
        </attribute>
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
              <point val="22.5,14.3561"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="22.5,14.8564"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="20.8032,14.5828;22.5,14.9328"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[23].MONEY#</string>
        </attribute>
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
              <point val="22.5,14.8564"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="22.5,15.3567"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="20.8032,15.0831;22.5,15.4331"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[24].MONEY#</string>
        </attribute>
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
              <point val="22.5,15.3567"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="22.5,15.857"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="20.8032,15.5834;22.5,15.9334"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[25].MONEY#</string>
        </attribute>
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
              <point val="22.5,15.857"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="22.5,16.3572"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="20.8032,16.0836;22.5,16.4336"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[26].MONEY#</string>
        </attribute>
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
              <point val="22.5,16.3572"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="22.5,16.8575"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="20.8032,16.5839;22.5,16.9339"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[27].MONEY#</string>
        </attribute>
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
              <point val="22.5,16.8575"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="22.5,17.3578"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="20.8032,17.0842;22.5,17.4342"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[28].MONEY#</string>
        </attribute>
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
              <point val="22.5,17.3578"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="22.5,17.8581"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="20.8032,17.5845;22.5,17.9345"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[5].MONEY-OCC[29].MONEY#</string>
        </attribute>
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
              <point val="22.5,17.8581"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
      <object type="Embed - Text" version="0" id="O414">
        <attribute name="obj_pos">
          <point val="24.3,3.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.6032,3.07636;24.3,3.42636"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[0].MONEY#</string>
        </attribute>
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
              <point val="24.3,3.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="24.3,3.85028"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.6032,3.57664;24.3,3.92664"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[1].MONEY#</string>
        </attribute>
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
              <point val="24.3,3.85028"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="24.3,4.35056"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.6032,4.07692;24.3,4.42692"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[2].MONEY#</string>
        </attribute>
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
              <point val="24.3,4.35056"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="24.3,4.85084"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.6032,4.5772;24.3,4.9272"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[3].MONEY#</string>
        </attribute>
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
              <point val="24.3,4.85084"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="24.3,5.35112"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.6032,5.07748;24.3,5.42748"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[4].MONEY#</string>
        </attribute>
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
              <point val="24.3,5.35112"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="24.3,5.8514"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.6032,5.57776;24.3,5.92776"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[5].MONEY#</string>
        </attribute>
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
              <point val="24.3,5.8514"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="24.3,6.35168"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.6032,6.07804;24.3,6.42804"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[6].MONEY#</string>
        </attribute>
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
              <point val="24.3,6.35168"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="24.3,6.85196"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.6032,6.57832;24.3,6.92832"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[7].MONEY#</string>
        </attribute>
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
              <point val="24.3,6.85196"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="24.3,7.35224"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.6032,7.0786;24.3,7.4286"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[8].MONEY#</string>
        </attribute>
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
              <point val="24.3,7.35224"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="24.3,7.85252"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.6032,7.57888;24.3,7.92888"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[9].MONEY#</string>
        </attribute>
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
              <point val="24.3,7.85252"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="24.3,8.3528"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.6032,8.07916;24.3,8.42916"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[10].MONEY#</string>
        </attribute>
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
              <point val="24.3,8.3528"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="24.3,8.85308"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.6032,8.57944;24.3,8.92944"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[11].MONEY#</string>
        </attribute>
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
              <point val="24.3,8.85308"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="24.3,9.35336"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.6032,9.07972;24.3,9.42972"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[12].MONEY#</string>
        </attribute>
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
              <point val="24.3,9.35336"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O427">
        <attribute name="obj_pos">
          <point val="24.3,9.85364"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.6032,9.58;24.3,9.93"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[13].MONEY#</string>
        </attribute>
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
              <point val="24.3,9.85364"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="24.3,10.3539"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.6032,10.0803;24.3,10.4303"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[14].MONEY#</string>
        </attribute>
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
              <point val="24.3,10.3539"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="24.3,10.8542"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.6032,10.5806;24.3,10.9306"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[15].MONEY#</string>
        </attribute>
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
              <point val="24.3,10.8542"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="24.3,11.3544"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.6032,11.0808;24.3,11.4308"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[16].MONEY#</string>
        </attribute>
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
              <point val="24.3,11.3544"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="24.3,11.8547"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.6032,11.5811;24.3,11.9311"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[17].MONEY#</string>
        </attribute>
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
              <point val="24.3,11.8547"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="24.3,12.355"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.6032,12.0814;24.3,12.4314"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[18].MONEY#</string>
        </attribute>
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
              <point val="24.3,12.355"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="24.3,12.8553"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.6032,12.5817;24.3,12.9317"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[19].MONEY#</string>
        </attribute>
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
              <point val="24.3,12.8553"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="24.3,13.3556"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.6032,13.082;24.3,13.432"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[20].MONEY#</string>
        </attribute>
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
              <point val="24.3,13.3556"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="24.3,13.8558"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.6032,13.5822;24.3,13.9322"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[21].MONEY#</string>
        </attribute>
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
              <point val="24.3,13.8558"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="24.3,14.3561"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.6032,14.0825;24.3,14.4325"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[22].MONEY#</string>
        </attribute>
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
              <point val="24.3,14.3561"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="24.3,14.8564"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.6032,14.5828;24.3,14.9328"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[23].MONEY#</string>
        </attribute>
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
              <point val="24.3,14.8564"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="24.3,15.3567"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.6032,15.0831;24.3,15.4331"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[24].MONEY#</string>
        </attribute>
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
              <point val="24.3,15.3567"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="24.3,15.857"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.6032,15.5834;24.3,15.9334"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[25].MONEY#</string>
        </attribute>
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
              <point val="24.3,15.857"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="24.3,16.3572"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.6032,16.0836;24.3,16.4336"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[26].MONEY#</string>
        </attribute>
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
              <point val="24.3,16.3572"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="24.3,16.8575"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.6032,16.5839;24.3,16.9339"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[27].MONEY#</string>
        </attribute>
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
              <point val="24.3,16.8575"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="24.3,17.3578"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.6032,17.0842;24.3,17.4342"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[28].MONEY#</string>
        </attribute>
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
              <point val="24.3,17.3578"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="24.3,17.8581"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="22.6032,17.5845;24.3,17.9345"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[6].MONEY-OCC[29].MONEY#</string>
        </attribute>
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
              <point val="24.3,17.8581"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
      <object type="Embed - Text" version="0" id="O444">
        <attribute name="obj_pos">
          <point val="26.1,3.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.4032,3.07636;26.1,3.42636"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[0].MONEY#</string>
        </attribute>
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
              <point val="26.1,3.35"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="26.1,3.85028"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.4032,3.57664;26.1,3.92664"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[1].MONEY#</string>
        </attribute>
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
              <point val="26.1,3.85028"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="26.1,4.35056"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.4032,4.07692;26.1,4.42692"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[2].MONEY#</string>
        </attribute>
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
              <point val="26.1,4.35056"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="26.1,4.85084"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.4032,4.5772;26.1,4.9272"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[3].MONEY#</string>
        </attribute>
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
              <point val="26.1,4.85084"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="26.1,5.35112"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.4032,5.07748;26.1,5.42748"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[4].MONEY#</string>
        </attribute>
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
              <point val="26.1,5.35112"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="26.1,5.8514"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.4032,5.57776;26.1,5.92776"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[5].MONEY#</string>
        </attribute>
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
              <point val="26.1,5.8514"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="26.1,6.35168"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.4032,6.07804;26.1,6.42804"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[6].MONEY#</string>
        </attribute>
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
              <point val="26.1,6.35168"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="26.1,6.85196"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.4032,6.57832;26.1,6.92832"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[7].MONEY#</string>
        </attribute>
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
              <point val="26.1,6.85196"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="26.1,7.35224"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.4032,7.0786;26.1,7.4286"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[8].MONEY#</string>
        </attribute>
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
              <point val="26.1,7.35224"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="26.1,7.85252"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.4032,7.57888;26.1,7.92888"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[9].MONEY#</string>
        </attribute>
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
              <point val="26.1,7.85252"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="26.1,8.3528"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.4032,8.07916;26.1,8.42916"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[10].MONEY#</string>
        </attribute>
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
              <point val="26.1,8.3528"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="26.1,8.85308"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.4032,8.57944;26.1,8.92944"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[11].MONEY#</string>
        </attribute>
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
              <point val="26.1,8.85308"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="26.1,9.35336"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.4032,9.07972;26.1,9.42972"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[12].MONEY#</string>
        </attribute>
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
              <point val="26.1,9.35336"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O457">
        <attribute name="obj_pos">
          <point val="26.1,9.85364"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.4032,9.58;26.1,9.93"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[13].MONEY#</string>
        </attribute>
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
              <point val="26.1,9.85364"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="26.1,10.3539"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.4032,10.0803;26.1,10.4303"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[14].MONEY#</string>
        </attribute>
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
              <point val="26.1,10.3539"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="26.1,10.8542"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.4032,10.5806;26.1,10.9306"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[15].MONEY#</string>
        </attribute>
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
              <point val="26.1,10.8542"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="26.1,11.3544"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.4032,11.0808;26.1,11.4308"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[16].MONEY#</string>
        </attribute>
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
              <point val="26.1,11.3544"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="26.1,11.8547"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.4032,11.5811;26.1,11.9311"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[17].MONEY#</string>
        </attribute>
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
              <point val="26.1,11.8547"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="26.1,12.355"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.4032,12.0814;26.1,12.4314"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[18].MONEY#</string>
        </attribute>
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
              <point val="26.1,12.355"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="26.1,12.8553"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.4032,12.5817;26.1,12.9317"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[19].MONEY#</string>
        </attribute>
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
              <point val="26.1,12.8553"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="26.1,13.3556"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.4032,13.082;26.1,13.432"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[20].MONEY#</string>
        </attribute>
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
              <point val="26.1,13.3556"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="26.1,13.8558"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.4032,13.5822;26.1,13.9322"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[21].MONEY#</string>
        </attribute>
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
              <point val="26.1,13.8558"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="26.1,14.3561"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.4032,14.0825;26.1,14.4325"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[22].MONEY#</string>
        </attribute>
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
              <point val="26.1,14.3561"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="26.1,14.8564"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.4032,14.5828;26.1,14.9328"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[23].MONEY#</string>
        </attribute>
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
              <point val="26.1,14.8564"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="26.1,15.3567"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.4032,15.0831;26.1,15.4331"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[24].MONEY#</string>
        </attribute>
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
              <point val="26.1,15.3567"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="26.1,15.857"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.4032,15.5834;26.1,15.9334"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[25].MONEY#</string>
        </attribute>
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
              <point val="26.1,15.857"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="26.1,16.3572"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.4032,16.0836;26.1,16.4336"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[26].MONEY#</string>
        </attribute>
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
              <point val="26.1,16.3572"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="26.1,16.8575"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.4032,16.5839;26.1,16.9339"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[27].MONEY#</string>
        </attribute>
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
              <point val="26.1,16.8575"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="26.1,17.3578"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.4032,17.0842;26.1,17.4342"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[28].MONEY#</string>
        </attribute>
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
              <point val="26.1,17.3578"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="26.1,17.8581"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="24.4032,17.5845;26.1,17.9345"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[7].MONEY-OCC[29].MONEY#</string>
        </attribute>
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
              <point val="26.1,17.8581"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
      <object type="Embed - Text" version="0" id="O474">
        <attribute name="obj_pos">
          <point val="27.9,3.35"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,3.07636;27.9,3.42636"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[0].MONEY#</string>
        </attribute>
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
      <object type="Embed - Text" version="0" id="O475">
        <attribute name="obj_pos">
          <point val="27.9,3.85028"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,3.57664;27.9,3.92664"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[1].MONEY#</string>
        </attribute>
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
              <point val="27.9,3.85028"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="27.9,4.35056"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,4.07692;27.9,4.42692"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[2].MONEY#</string>
        </attribute>
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
              <point val="27.9,4.35056"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="27.9,4.85084"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,4.5772;27.9,4.9272"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[3].MONEY#</string>
        </attribute>
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
              <point val="27.9,4.85084"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="27.9,5.35112"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,5.07748;27.9,5.42748"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[4].MONEY#</string>
        </attribute>
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
              <point val="27.9,5.35112"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="27.9,5.8514"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,5.57776;27.9,5.92776"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[5].MONEY#</string>
        </attribute>
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
              <point val="27.9,5.8514"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="27.9,6.35168"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,6.07804;27.9,6.42804"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[6].MONEY#</string>
        </attribute>
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
              <point val="27.9,6.35168"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="27.9,6.85196"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,6.57832;27.9,6.92832"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[7].MONEY#</string>
        </attribute>
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
              <point val="27.9,6.85196"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="27.9,7.35224"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,7.0786;27.9,7.4286"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[8].MONEY#</string>
        </attribute>
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
              <point val="27.9,7.35224"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="27.9,7.85252"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,7.57888;27.9,7.92888"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[9].MONEY#</string>
        </attribute>
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
              <point val="27.9,7.85252"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="27.9,8.3528"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,8.07916;27.9,8.42916"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[10].MONEY#</string>
        </attribute>
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
              <point val="27.9,8.3528"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="27.9,8.85308"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,8.57944;27.9,8.92944"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[11].MONEY#</string>
        </attribute>
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
              <point val="27.9,8.85308"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="27.9,9.35336"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,9.07972;27.9,9.42972"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[12].MONEY#</string>
        </attribute>
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
              <point val="27.9,9.35336"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
            <attribute name="single">
              <real val="0.2121"/>
            </attribute>
            <attribute name="multi">
              <real val="0.17675"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Embed - Text" version="0" id="O487">
        <attribute name="obj_pos">
          <point val="27.9,9.85364"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,9.58;27.9,9.93"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[13].MONEY#</string>
        </attribute>
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
              <point val="27.9,9.85364"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="27.9,10.3539"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,10.0803;27.9,10.4303"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[14].MONEY#</string>
        </attribute>
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
              <point val="27.9,10.3539"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="27.9,10.8542"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,10.5806;27.9,10.9306"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[15].MONEY#</string>
        </attribute>
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
              <point val="27.9,10.8542"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="27.9,11.3544"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,11.0808;27.9,11.4308"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[16].MONEY#</string>
        </attribute>
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
              <point val="27.9,11.3544"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="27.9,11.8547"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,11.5811;27.9,11.9311"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[17].MONEY#</string>
        </attribute>
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
              <point val="27.9,11.8547"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="27.9,12.355"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,12.0814;27.9,12.4314"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[18].MONEY#</string>
        </attribute>
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
              <point val="27.9,12.355"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="27.9,12.8553"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,12.5817;27.9,12.9317"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[19].MONEY#</string>
        </attribute>
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
              <point val="27.9,12.8553"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="27.9,13.3556"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,13.082;27.9,13.432"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[20].MONEY#</string>
        </attribute>
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
              <point val="27.9,13.3556"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="27.9,13.8558"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,13.5822;27.9,13.9322"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[21].MONEY#</string>
        </attribute>
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
              <point val="27.9,13.8558"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="27.9,14.3561"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,14.0825;27.9,14.4325"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[22].MONEY#</string>
        </attribute>
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
              <point val="27.9,14.3561"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="27.9,14.8564"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,14.5828;27.9,14.9328"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[23].MONEY#</string>
        </attribute>
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
              <point val="27.9,14.8564"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="27.9,15.3567"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,15.0831;27.9,15.4331"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[24].MONEY#</string>
        </attribute>
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
              <point val="27.9,15.3567"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="27.9,15.857"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,15.5834;27.9,15.9334"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[25].MONEY#</string>
        </attribute>
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
              <point val="27.9,15.857"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="27.9,16.3572"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,16.0836;27.9,16.4336"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[26].MONEY#</string>
        </attribute>
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
              <point val="27.9,16.3572"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="27.9,16.8575"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,16.5839;27.9,16.9339"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[27].MONEY#</string>
        </attribute>
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
              <point val="27.9,16.8575"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="27.9,17.3578"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,17.0842;27.9,17.4342"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[28].MONEY#</string>
        </attribute>
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
              <point val="27.9,17.3578"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
          <point val="27.9,17.8581"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="26.2032,17.5845;27.9,17.9345"/>
        </attribute>
        <attribute name="dnode_path">
          <string>#MONEY-G[8].MONEY-OCC[29].MONEY#</string>
        </attribute>
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
              <point val="27.9,17.8581"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="2"/>
            </attribute>
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
    <object type="Embed - Text" version="0" id="O504">
      <attribute name="obj_pos">
        <point val="17.5,1.45"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.5,1.13727;19.116,1.53727"/>
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
  </layer>
</diagram>
