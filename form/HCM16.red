<?xml version="1.0"?>
<diagram xmlns:dia="http://www.lysator.liu.se/~alla/dia/">
  <dictionarydata>
    <element name="SRYYMD" occurs="1">
      <appinfo>
        <embed object="string" length="22"/>
      </appinfo>
    </element>
    <element name="SAKUSEI" occurs="1">
      <appinfo>
        <embed object="string" length="14"/>
      </appinfo>
    </element>
    <element name="PAGE" occurs="1">
      <appinfo>
        <embed object="string" length="3"/>
      </appinfo>
    </element>
    <element name="A-TBL" occurs="35">
      <element name="NUM" occurs="1">
        <appinfo>
          <embed object="string" length="4"/>
        </appinfo>
      </element>
      <element name="PTNUM" occurs="1">
        <appinfo>
          <embed object="string" length="20"/>
        </appinfo>
      </element>
      <element name="NAME" occurs="1">
        <appinfo>
          <embed object="string" length="50"/>
        </appinfo>
      </element>
      <element name="SRYKA" occurs="1">
        <appinfo>
          <embed object="string" length="20"/>
        </appinfo>
      </element>
      <element name="NAIYO" occurs="1">
        <appinfo>
          <embed object="string" length="20"/>
        </appinfo>
      </element>
      <element name="DRNAME" occurs="1">
        <appinfo>
          <embed object="string" length="30"/>
        </appinfo>
      </element>
      <element name="UKETUKE" occurs="1">
        <appinfo>
          <embed object="string" length="5"/>
        </appinfo>
      </element>
      <element name="KAIKEI" occurs="1">
        <appinfo>
          <embed object="string" length="5"/>
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
  <layer name="&#199;&#216;&#183;&#202;" visible="true">
    <object type="Standard - Line" version="0" id="O0">
      <attribute name="obj_pos">
        <point val="1,2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.985,1.985;1.015,20.015"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,2"/>
        <point val="1,20"/>
      </attribute>
      <attribute name="numcp">
        <int val="35"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.03"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O1">
      <attribute name="obj_pos">
        <point val="1,2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.985,1.985;28.715,2.015"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,2"/>
        <point val="28.7,2"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.03"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O2">
      <attribute name="obj_pos">
        <point val="28.7,2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="28.685,1.985;28.715,20.015"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="28.7,2"/>
        <point val="28.7,20"/>
      </attribute>
      <attribute name="numcp">
        <int val="35"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.03"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O3">
      <attribute name="obj_pos">
        <point val="1,2.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.985,2.485;28.715,2.515"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,2.5"/>
        <point val="28.7,2.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.03"/>
      </attribute>
      <connections>
        <connection handle="0" to="O0" connection="0"/>
        <connection handle="1" to="O2" connection="0"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O4">
      <attribute name="obj_pos">
        <point val="1,3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,3;28.7,3"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,3"/>
        <point val="28.7,3"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O0" connection="1"/>
        <connection handle="1" to="O2" connection="1"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O5">
      <attribute name="obj_pos">
        <point val="1,3.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,3.5;28.7,3.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,3.5"/>
        <point val="28.7,3.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O0" connection="2"/>
        <connection handle="1" to="O2" connection="2"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O6">
      <attribute name="obj_pos">
        <point val="1,4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,4;28.7,4"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,4"/>
        <point val="28.7,4"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O0" connection="3"/>
        <connection handle="1" to="O2" connection="3"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O7">
      <attribute name="obj_pos">
        <point val="1,4.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,4.5;28.7,4.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,4.5"/>
        <point val="28.7,4.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O0" connection="4"/>
        <connection handle="1" to="O2" connection="4"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O8">
      <attribute name="obj_pos">
        <point val="1,5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,5;28.7,5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,5"/>
        <point val="28.7,5"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O0" connection="5"/>
        <connection handle="1" to="O2" connection="5"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O9">
      <attribute name="obj_pos">
        <point val="1,5.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,5.5;28.7,5.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,5.5"/>
        <point val="28.7,5.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O0" connection="6"/>
        <connection handle="1" to="O2" connection="6"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O10">
      <attribute name="obj_pos">
        <point val="1,6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,6;28.7,6"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,6"/>
        <point val="28.7,6"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O0" connection="7"/>
        <connection handle="1" to="O2" connection="7"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O11">
      <attribute name="obj_pos">
        <point val="1,6.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,6.5;28.7,6.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,6.5"/>
        <point val="28.7,6.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O0" connection="8"/>
        <connection handle="1" to="O2" connection="8"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O12">
      <attribute name="obj_pos">
        <point val="1,7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,7;28.7,7"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,7"/>
        <point val="28.7,7"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O0" connection="9"/>
        <connection handle="1" to="O2" connection="9"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O13">
      <attribute name="obj_pos">
        <point val="1,7.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,7.5;28.7,7.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,7.5"/>
        <point val="28.7,7.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O0" connection="10"/>
        <connection handle="1" to="O2" connection="10"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O14">
      <attribute name="obj_pos">
        <point val="1,8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,8;28.7,8"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,8"/>
        <point val="28.7,8"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O0" connection="11"/>
        <connection handle="1" to="O2" connection="11"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O15">
      <attribute name="obj_pos">
        <point val="1,8.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,8.5;28.7,8.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,8.5"/>
        <point val="28.7,8.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O0" connection="12"/>
        <connection handle="1" to="O2" connection="12"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O16">
      <attribute name="obj_pos">
        <point val="1,9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,9;28.7,9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,9"/>
        <point val="28.7,9"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O0" connection="13"/>
        <connection handle="1" to="O2" connection="13"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O17">
      <attribute name="obj_pos">
        <point val="1,9.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,9.5;28.7,9.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,9.5"/>
        <point val="28.7,9.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O0" connection="14"/>
        <connection handle="1" to="O2" connection="14"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O18">
      <attribute name="obj_pos">
        <point val="1,10"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,10;28.7,10"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,10"/>
        <point val="28.7,10"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O0" connection="15"/>
        <connection handle="1" to="O2" connection="15"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O19">
      <attribute name="obj_pos">
        <point val="1,10.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,10.5;28.7,10.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,10.5"/>
        <point val="28.7,10.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O0" connection="16"/>
        <connection handle="1" to="O2" connection="16"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O20">
      <attribute name="obj_pos">
        <point val="1,11"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,11;28.7,11"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,11"/>
        <point val="28.7,11"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O0" connection="17"/>
        <connection handle="1" to="O2" connection="17"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O21">
      <attribute name="obj_pos">
        <point val="1,11.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,11.5;28.7,11.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,11.5"/>
        <point val="28.7,11.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O0" connection="18"/>
        <connection handle="1" to="O2" connection="18"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O22">
      <attribute name="obj_pos">
        <point val="1,12"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,12;28.7,12"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,12"/>
        <point val="28.7,12"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O0" connection="19"/>
        <connection handle="1" to="O2" connection="19"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O23">
      <attribute name="obj_pos">
        <point val="1,12.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,12.5;28.7,12.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,12.5"/>
        <point val="28.7,12.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O0" connection="20"/>
        <connection handle="1" to="O2" connection="20"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O24">
      <attribute name="obj_pos">
        <point val="1,13"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,13;28.7,13"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,13"/>
        <point val="28.7,13"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O0" connection="21"/>
        <connection handle="1" to="O2" connection="21"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O25">
      <attribute name="obj_pos">
        <point val="1,13.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,13.5;28.7,13.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,13.5"/>
        <point val="28.7,13.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O0" connection="22"/>
        <connection handle="1" to="O2" connection="22"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O26">
      <attribute name="obj_pos">
        <point val="1,14"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,14;28.7,14"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,14"/>
        <point val="28.7,14"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O0" connection="23"/>
        <connection handle="1" to="O2" connection="23"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O27">
      <attribute name="obj_pos">
        <point val="1,14.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,14.5;28.7,14.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,14.5"/>
        <point val="28.7,14.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O0" connection="24"/>
        <connection handle="1" to="O2" connection="24"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O28">
      <attribute name="obj_pos">
        <point val="1,15"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,15;28.7,15"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,15"/>
        <point val="28.7,15"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O0" connection="25"/>
        <connection handle="1" to="O2" connection="25"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O29">
      <attribute name="obj_pos">
        <point val="1,15.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,15.5;28.7,15.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,15.5"/>
        <point val="28.7,15.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O0" connection="26"/>
        <connection handle="1" to="O2" connection="26"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O30">
      <attribute name="obj_pos">
        <point val="1,16"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,16;28.7,16"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,16"/>
        <point val="28.7,16"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O0" connection="27"/>
        <connection handle="1" to="O2" connection="27"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O31">
      <attribute name="obj_pos">
        <point val="1,16.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,16.5;28.7,16.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,16.5"/>
        <point val="28.7,16.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O0" connection="28"/>
        <connection handle="1" to="O2" connection="28"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O32">
      <attribute name="obj_pos">
        <point val="1,17"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,17;28.7,17"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,17"/>
        <point val="28.7,17"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O0" connection="29"/>
        <connection handle="1" to="O2" connection="29"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O33">
      <attribute name="obj_pos">
        <point val="1,17.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,17.5;28.7,17.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,17.5"/>
        <point val="28.7,17.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O0" connection="30"/>
        <connection handle="1" to="O2" connection="30"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O34">
      <attribute name="obj_pos">
        <point val="1,18"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,18;28.7,18"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,18"/>
        <point val="28.7,18"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O0" connection="31"/>
        <connection handle="1" to="O2" connection="31"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O35">
      <attribute name="obj_pos">
        <point val="1,18.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,18.5;28.7,18.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,18.5"/>
        <point val="28.7,18.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O0" connection="32"/>
        <connection handle="1" to="O2" connection="32"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O36">
      <attribute name="obj_pos">
        <point val="1,19"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,19;28.7,19"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,19"/>
        <point val="28.7,19"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O0" connection="33"/>
        <connection handle="1" to="O2" connection="33"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O37">
      <attribute name="obj_pos">
        <point val="1,19.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,19.5;28.7,19.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,19.5"/>
        <point val="28.7,19.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O0" connection="34"/>
        <connection handle="1" to="O2" connection="34"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O38">
      <attribute name="obj_pos">
        <point val="1,20"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="0.985,19.985;28.715,20.015"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1,20"/>
        <point val="28.7,20"/>
      </attribute>
      <attribute name="numcp">
        <int val="0"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.03"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O39">
      <attribute name="obj_pos">
        <point val="2,2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.995,1.995;2.005,20.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="2,2"/>
        <point val="2,20"/>
      </attribute>
      <attribute name="numcp">
        <int val="35"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O40">
      <attribute name="obj_pos">
        <point val="6.4,2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.395,1.995;6.405,20.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="6.4,2"/>
        <point val="6.4,20"/>
      </attribute>
      <attribute name="numcp">
        <int val="35"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O41">
      <attribute name="obj_pos">
        <point val="27.3,2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.3,2;27.3,20"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="27.3,2"/>
        <point val="27.3,20"/>
      </attribute>
      <attribute name="numcp">
        <int val="35"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O42">
      <attribute name="obj_pos">
        <point val="25.9,2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="25.9,2;25.9,20"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="25.9,2"/>
        <point val="25.9,20"/>
      </attribute>
      <attribute name="numcp">
        <int val="35"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O43">
      <attribute name="obj_pos">
        <point val="21.1,2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.1,2;21.1,20"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="21.1,2"/>
        <point val="21.1,20"/>
      </attribute>
      <attribute name="numcp">
        <int val="35"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O44">
      <attribute name="obj_pos">
        <point val="17.9,2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.9,2;17.9,20"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="17.9,2"/>
        <point val="17.9,20"/>
      </attribute>
      <attribute name="numcp">
        <int val="35"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O45">
      <attribute name="obj_pos">
        <point val="14.7,2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.7,2;14.7,20"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="14.7,2"/>
        <point val="14.7,20"/>
      </attribute>
      <attribute name="numcp">
        <int val="35"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
  </layer>
  <layer name="&#202;&#184;&#187;&#250;" visible="true">
    <object type="Standard - Text" version="0" id="O46">
      <attribute name="obj_pos">
        <point val="1.5,2.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.197,2.11545;1.803,2.41545"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#200;&#214;&#185;&#230;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="1.5,2.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
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
    <object type="Standard - Text" version="0" id="O47">
      <attribute name="obj_pos">
        <point val="4.2,2.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.594,2.11545;4.806,2.41545"/>
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
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="4.2,2.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
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
    <object type="Standard - Text" version="0" id="O48">
      <attribute name="obj_pos">
        <point val="10.5,2.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.894,2.11545;11.106,2.41545"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#180;&#181;&#188;&#212;&#187;&#225;&#204;&#190;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="10.5,2.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
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
    <object type="Standard - Text" version="0" id="O49">
      <attribute name="obj_pos">
        <point val="16.3,2.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.8455,2.11545;16.7545,2.41545"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#191;&#199;&#206;&#197;&#178;&#202;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="16.3,2.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
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
    <object type="Standard - Text" version="0" id="O50">
      <attribute name="obj_pos">
        <point val="19.5,2.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.197,2.11545;19.803,2.41545"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#198;&#226;&#205;&#198;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="19.5,2.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
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
    <object type="Standard - Text" version="0" id="O51">
      <attribute name="obj_pos">
        <point val="23.5,2.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.894,2.11545;24.106,2.41545"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#165;&#201;&#165;&#175;&#165;&#191;&#161;&#188;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="23.5,2.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
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
    <object type="Standard - Text" version="0" id="O52">
      <attribute name="obj_pos">
        <point val="26.6,2.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="25.994,2.11545;27.206,2.41545"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#188;&#245;&#201;&#213;&#187;&#254;&#180;&#214;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,2.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
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
    <object type="Standard - Text" version="0" id="O53">
      <attribute name="obj_pos">
        <point val="28,2.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.394,2.11545;28.606,2.41545"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#178;&#241;&#183;&#215;&#187;&#254;&#180;&#214;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="28,2.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
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
    <object type="Standard - Text" version="0" id="O54">
      <attribute name="obj_pos">
        <point val="14.3,1.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.0375,1.40909;15.5625,1.90909"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#188;&#245;&#201;&#213;&#176;&#236;&#205;&#247;&#201;&#189;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.5"/>
          </attribute>
          <attribute name="pos">
            <point val="14.3,1.8"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
          </attribute>
          <attribute name="single">
            <real val="0.303"/>
          </attribute>
          <attribute name="multi">
            <real val="0.2525"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O55">
      <attribute name="obj_pos">
        <point val="4.55,1.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.55,1.56545;5.459,1.86545"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#205;&#232;&#177;&#161;&#202;&#172;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="4.55,1.8"/>
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
    <object type="Standard - Text" version="0" id="O56">
      <attribute name="obj_pos">
        <point val="23.5,1.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.894,1.61545;24.106,1.91545"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#186;&#238;&#192;&#174;&#198;&#252;&#187;&#254;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="23.5,1.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="1"/>
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
    <object type="Standard - Text" version="0" id="O57">
      <attribute name="obj_pos">
        <point val="28,1.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.394,1.61545;28,1.91545"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#202;&#199;&#161;&#167;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="28,1.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
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
  </layer>
  <layer name="&#186;&#185;&#164;&#183;&#185;&#254;&#164;&#223;" visible="true">
    <object type="Embed - Text" version="0" id="O58">
      <attribute name="obj_pos">
        <point val="1.9,2.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0516,2.57636;1.9,2.92636"/>
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
            <string>#9999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,2.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O59">
      <attribute name="obj_pos">
        <point val="2.1,2.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.1,2.57636;6.342,2.92636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[0].PTNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="2.1,2.85"/>
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
    <object type="Embed - Text" version="0" id="O60">
      <attribute name="obj_pos">
        <point val="6.5,2.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.5,2.61545;14.075,2.91545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[0].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.5,2.85"/>
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
    <object type="Embed - Text" version="0" id="O61">
      <attribute name="obj_pos">
        <point val="28,2.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.4698,2.57636;28.5303,2.92636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[0].KAIKEI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="28,2.85"/>
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
    <object type="Embed - Text" version="0" id="O62">
      <attribute name="obj_pos">
        <point val="26.6,2.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.0698,2.57636;27.1303,2.92636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[0].UKETUKE#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,2.85"/>
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
    <object type="Embed - Text" version="0" id="O63">
      <attribute name="obj_pos">
        <point val="21.2,2.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.2,2.61545;25.745,2.91545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[0].DRNAME#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="21.2,2.85"/>
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
    <object type="Embed - Text" version="0" id="O64">
      <attribute name="obj_pos">
        <point val="18,2.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18,2.61545;21.03,2.91545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[0].NAIYO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="18,2.85"/>
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
    <object type="Embed - Text" version="0" id="O65">
      <attribute name="obj_pos">
        <point val="14.8,2.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.8,2.61545;17.83,2.91545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[0].SRYKA#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="14.8,2.85"/>
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
    <object type="Embed - Text" version="0" id="O66">
      <attribute name="obj_pos">
        <point val="1.9,3.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0516,3.07636;1.9,3.42636"/>
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
            <string>#9999#</string>
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
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O67">
      <attribute name="obj_pos">
        <point val="2.1,3.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.1,3.07636;6.342,3.42636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[1].PTNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="2.1,3.35"/>
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
    <object type="Embed - Text" version="0" id="O68">
      <attribute name="obj_pos">
        <point val="6.5,3.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.5,3.11545;14.075,3.41545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[1].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.5,3.35"/>
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
    <object type="Embed - Text" version="0" id="O69">
      <attribute name="obj_pos">
        <point val="28,3.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.4698,3.07636;28.5303,3.42636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[1].KAIKEI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="28,3.35"/>
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
    <object type="Embed - Text" version="0" id="O70">
      <attribute name="obj_pos">
        <point val="26.6,3.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.0698,3.07636;27.1303,3.42636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[1].UKETUKE#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,3.35"/>
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
    <object type="Embed - Text" version="0" id="O71">
      <attribute name="obj_pos">
        <point val="21.2,3.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.2,3.11545;25.745,3.41545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[1].DRNAME#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="21.2,3.35"/>
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
    <object type="Embed - Text" version="0" id="O72">
      <attribute name="obj_pos">
        <point val="18,3.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18,3.11545;21.03,3.41545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[1].NAIYO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="18,3.35"/>
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
    <object type="Embed - Text" version="0" id="O73">
      <attribute name="obj_pos">
        <point val="14.8,3.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.8,3.11545;17.83,3.41545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[1].SRYKA#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="14.8,3.35"/>
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
    <object type="Embed - Text" version="0" id="O74">
      <attribute name="obj_pos">
        <point val="1.9,3.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0516,3.57636;1.9,3.92636"/>
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
            <string>#9999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,3.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O75">
      <attribute name="obj_pos">
        <point val="2.1,3.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.1,3.57636;6.342,3.92636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[2].PTNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="2.1,3.85"/>
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
    <object type="Embed - Text" version="0" id="O76">
      <attribute name="obj_pos">
        <point val="6.5,3.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.5,3.61545;14.075,3.91545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[2].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.5,3.85"/>
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
    <object type="Embed - Text" version="0" id="O77">
      <attribute name="obj_pos">
        <point val="28,3.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.4698,3.57636;28.5303,3.92636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[2].KAIKEI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="28,3.85"/>
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
    <object type="Embed - Text" version="0" id="O78">
      <attribute name="obj_pos">
        <point val="26.6,3.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.0698,3.57636;27.1303,3.92636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[2].UKETUKE#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,3.85"/>
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
    <object type="Embed - Text" version="0" id="O79">
      <attribute name="obj_pos">
        <point val="21.2,3.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.2,3.61545;25.745,3.91545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[2].DRNAME#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="21.2,3.85"/>
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
    <object type="Embed - Text" version="0" id="O80">
      <attribute name="obj_pos">
        <point val="18,3.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18,3.61545;21.03,3.91545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[2].NAIYO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="18,3.85"/>
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
    <object type="Embed - Text" version="0" id="O81">
      <attribute name="obj_pos">
        <point val="14.8,3.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.8,3.61545;17.83,3.91545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[2].SRYKA#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="14.8,3.85"/>
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
    <object type="Embed - Text" version="0" id="O82">
      <attribute name="obj_pos">
        <point val="1.9,4.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0516,4.07636;1.9,4.42636"/>
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
            <string>#9999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,4.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="2.1,4.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.1,4.07636;6.342,4.42636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[3].PTNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="2.1,4.35"/>
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
        <point val="6.5,4.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.5,4.11545;14.075,4.41545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[3].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.5,4.35"/>
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
    <object type="Embed - Text" version="0" id="O85">
      <attribute name="obj_pos">
        <point val="28,4.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.4698,4.07636;28.5303,4.42636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[3].KAIKEI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="28,4.35"/>
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
    <object type="Embed - Text" version="0" id="O86">
      <attribute name="obj_pos">
        <point val="26.6,4.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.0698,4.07636;27.1303,4.42636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[3].UKETUKE#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,4.35"/>
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
    <object type="Embed - Text" version="0" id="O87">
      <attribute name="obj_pos">
        <point val="21.2,4.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.2,4.11545;25.745,4.41545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[3].DRNAME#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="21.2,4.35"/>
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
    <object type="Embed - Text" version="0" id="O88">
      <attribute name="obj_pos">
        <point val="18,4.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18,4.11545;21.03,4.41545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[3].NAIYO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="18,4.35"/>
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
    <object type="Embed - Text" version="0" id="O89">
      <attribute name="obj_pos">
        <point val="14.8,4.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.8,4.11545;17.83,4.41545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[3].SRYKA#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="14.8,4.35"/>
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
    <object type="Embed - Text" version="0" id="O90">
      <attribute name="obj_pos">
        <point val="1.9,4.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0516,4.57636;1.9,4.92636"/>
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
            <string>#9999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,4.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="2.1,4.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.1,4.57636;6.342,4.92636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[4].PTNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="2.1,4.85"/>
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
    <object type="Embed - Text" version="0" id="O92">
      <attribute name="obj_pos">
        <point val="6.5,4.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.5,4.61545;14.075,4.91545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[4].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.5,4.85"/>
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
    <object type="Embed - Text" version="0" id="O93">
      <attribute name="obj_pos">
        <point val="28,4.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.4698,4.57636;28.5303,4.92636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[4].KAIKEI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="28,4.85"/>
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
    <object type="Embed - Text" version="0" id="O94">
      <attribute name="obj_pos">
        <point val="26.6,4.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.0698,4.57636;27.1303,4.92636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[4].UKETUKE#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,4.85"/>
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
    <object type="Embed - Text" version="0" id="O95">
      <attribute name="obj_pos">
        <point val="21.2,4.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.2,4.61545;25.745,4.91545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[4].DRNAME#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="21.2,4.85"/>
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
    <object type="Embed - Text" version="0" id="O96">
      <attribute name="obj_pos">
        <point val="18,4.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18,4.61545;21.03,4.91545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[4].NAIYO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="18,4.85"/>
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
    <object type="Embed - Text" version="0" id="O97">
      <attribute name="obj_pos">
        <point val="14.8,4.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.8,4.61545;17.83,4.91545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[4].SRYKA#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="14.8,4.85"/>
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
    <object type="Embed - Text" version="0" id="O98">
      <attribute name="obj_pos">
        <point val="1.9,5.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0516,5.07636;1.9,5.42636"/>
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
            <string>#9999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,5.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="2.1,5.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.1,5.07636;6.342,5.42636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[5].PTNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="2.1,5.35"/>
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
    <object type="Embed - Text" version="0" id="O100">
      <attribute name="obj_pos">
        <point val="6.5,5.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.5,5.11545;14.075,5.41545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[5].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.5,5.35"/>
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
    <object type="Embed - Text" version="0" id="O101">
      <attribute name="obj_pos">
        <point val="28,5.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.4698,5.07636;28.5303,5.42636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[5].KAIKEI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="28,5.35"/>
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
    <object type="Embed - Text" version="0" id="O102">
      <attribute name="obj_pos">
        <point val="26.6,5.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.0698,5.07636;27.1303,5.42636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[5].UKETUKE#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,5.35"/>
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
    <object type="Embed - Text" version="0" id="O103">
      <attribute name="obj_pos">
        <point val="21.2,5.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.2,5.11545;25.745,5.41545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[5].DRNAME#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="21.2,5.35"/>
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
    <object type="Embed - Text" version="0" id="O104">
      <attribute name="obj_pos">
        <point val="18,5.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18,5.11545;21.03,5.41545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[5].NAIYO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="18,5.35"/>
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
    <object type="Embed - Text" version="0" id="O105">
      <attribute name="obj_pos">
        <point val="14.8,5.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.8,5.11545;17.83,5.41545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[5].SRYKA#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="14.8,5.35"/>
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
    <object type="Embed - Text" version="0" id="O106">
      <attribute name="obj_pos">
        <point val="1.9,5.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0516,5.57636;1.9,5.92636"/>
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
            <string>#9999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,5.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="2.1,5.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.1,5.57636;6.342,5.92636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[6].PTNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="2.1,5.85"/>
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
    <object type="Embed - Text" version="0" id="O108">
      <attribute name="obj_pos">
        <point val="6.5,5.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.5,5.61545;14.075,5.91545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[6].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.5,5.85"/>
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
    <object type="Embed - Text" version="0" id="O109">
      <attribute name="obj_pos">
        <point val="28,5.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.4698,5.57636;28.5303,5.92636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[6].KAIKEI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="28,5.85"/>
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
    <object type="Embed - Text" version="0" id="O110">
      <attribute name="obj_pos">
        <point val="26.6,5.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.0698,5.57636;27.1303,5.92636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[6].UKETUKE#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,5.85"/>
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
    <object type="Embed - Text" version="0" id="O111">
      <attribute name="obj_pos">
        <point val="21.2,5.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.2,5.61545;25.745,5.91545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[6].DRNAME#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="21.2,5.85"/>
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
    <object type="Embed - Text" version="0" id="O112">
      <attribute name="obj_pos">
        <point val="18,5.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18,5.61545;21.03,5.91545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[6].NAIYO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="18,5.85"/>
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
    <object type="Embed - Text" version="0" id="O113">
      <attribute name="obj_pos">
        <point val="14.8,5.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.8,5.61545;17.83,5.91545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[6].SRYKA#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="14.8,5.85"/>
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
    <object type="Embed - Text" version="0" id="O114">
      <attribute name="obj_pos">
        <point val="1.9,6.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0516,6.07636;1.9,6.42636"/>
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
            <string>#9999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,6.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="2.1,6.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.1,6.07636;6.342,6.42636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[7].PTNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="2.1,6.35"/>
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
    <object type="Embed - Text" version="0" id="O116">
      <attribute name="obj_pos">
        <point val="6.5,6.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.5,6.11545;14.075,6.41545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[7].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.5,6.35"/>
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
    <object type="Embed - Text" version="0" id="O117">
      <attribute name="obj_pos">
        <point val="28,6.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.4698,6.07636;28.5303,6.42636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[7].KAIKEI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="28,6.35"/>
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
    <object type="Embed - Text" version="0" id="O118">
      <attribute name="obj_pos">
        <point val="26.6,6.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.0698,6.07636;27.1303,6.42636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[7].UKETUKE#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,6.35"/>
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
    <object type="Embed - Text" version="0" id="O119">
      <attribute name="obj_pos">
        <point val="21.2,6.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.2,6.11545;25.745,6.41545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[7].DRNAME#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="21.2,6.35"/>
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
    <object type="Embed - Text" version="0" id="O120">
      <attribute name="obj_pos">
        <point val="18,6.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18,6.11545;21.03,6.41545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[7].NAIYO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="18,6.35"/>
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
    <object type="Embed - Text" version="0" id="O121">
      <attribute name="obj_pos">
        <point val="14.8,6.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.8,6.11545;17.83,6.41545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[7].SRYKA#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="14.8,6.35"/>
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
    <object type="Embed - Text" version="0" id="O122">
      <attribute name="obj_pos">
        <point val="1.9,6.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0516,6.57636;1.9,6.92636"/>
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
            <string>#9999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,6.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="2.1,6.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.1,6.57636;6.342,6.92636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[8].PTNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="2.1,6.85"/>
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
    <object type="Embed - Text" version="0" id="O124">
      <attribute name="obj_pos">
        <point val="6.5,6.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.5,6.61545;14.075,6.91545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[8].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.5,6.85"/>
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
    <object type="Embed - Text" version="0" id="O125">
      <attribute name="obj_pos">
        <point val="28,6.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.4698,6.57636;28.5303,6.92636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[8].KAIKEI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="28,6.85"/>
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
    <object type="Embed - Text" version="0" id="O126">
      <attribute name="obj_pos">
        <point val="26.6,6.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.0698,6.57636;27.1303,6.92636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[8].UKETUKE#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,6.85"/>
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
    <object type="Embed - Text" version="0" id="O127">
      <attribute name="obj_pos">
        <point val="21.2,6.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.2,6.61545;25.745,6.91545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[8].DRNAME#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="21.2,6.85"/>
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
    <object type="Embed - Text" version="0" id="O128">
      <attribute name="obj_pos">
        <point val="18,6.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18,6.61545;21.03,6.91545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[8].NAIYO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="18,6.85"/>
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
    <object type="Embed - Text" version="0" id="O129">
      <attribute name="obj_pos">
        <point val="14.8,6.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.8,6.61545;17.83,6.91545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[8].SRYKA#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="14.8,6.85"/>
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
    <object type="Embed - Text" version="0" id="O130">
      <attribute name="obj_pos">
        <point val="1.9,7.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0516,7.07636;1.9,7.42636"/>
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
            <string>#9999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,7.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="2.1,7.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.1,7.07636;6.342,7.42636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[9].PTNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="2.1,7.35"/>
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
    <object type="Embed - Text" version="0" id="O132">
      <attribute name="obj_pos">
        <point val="6.5,7.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.5,7.11545;14.075,7.41545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[9].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.5,7.35"/>
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
    <object type="Embed - Text" version="0" id="O133">
      <attribute name="obj_pos">
        <point val="28,7.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.4698,7.07636;28.5303,7.42636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[9].KAIKEI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="28,7.35"/>
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
    <object type="Embed - Text" version="0" id="O134">
      <attribute name="obj_pos">
        <point val="26.6,7.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.0698,7.07636;27.1303,7.42636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[9].UKETUKE#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,7.35"/>
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
    <object type="Embed - Text" version="0" id="O135">
      <attribute name="obj_pos">
        <point val="21.2,7.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.2,7.11545;25.745,7.41545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[9].DRNAME#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="21.2,7.35"/>
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
    <object type="Embed - Text" version="0" id="O136">
      <attribute name="obj_pos">
        <point val="18,7.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18,7.11545;21.03,7.41545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[9].NAIYO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="18,7.35"/>
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
    <object type="Embed - Text" version="0" id="O137">
      <attribute name="obj_pos">
        <point val="14.8,7.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.8,7.11545;17.83,7.41545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[9].SRYKA#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="14.8,7.35"/>
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
    <object type="Embed - Text" version="0" id="O138">
      <attribute name="obj_pos">
        <point val="1.9,7.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0516,7.57636;1.9,7.92636"/>
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
            <string>#9999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,7.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="2.1,7.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.1,7.57636;6.342,7.92636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[10].PTNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="2.1,7.85"/>
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
    <object type="Embed - Text" version="0" id="O140">
      <attribute name="obj_pos">
        <point val="6.5,7.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.5,7.61545;14.075,7.91545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[10].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.5,7.85"/>
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
    <object type="Embed - Text" version="0" id="O141">
      <attribute name="obj_pos">
        <point val="28,7.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.4698,7.57636;28.5303,7.92636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[10].KAIKEI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="28,7.85"/>
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
    <object type="Embed - Text" version="0" id="O142">
      <attribute name="obj_pos">
        <point val="26.6,7.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.0698,7.57636;27.1303,7.92636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[10].UKETUKE#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,7.85"/>
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
    <object type="Embed - Text" version="0" id="O143">
      <attribute name="obj_pos">
        <point val="21.2,7.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.2,7.61545;25.745,7.91545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[10].DRNAME#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="21.2,7.85"/>
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
    <object type="Embed - Text" version="0" id="O144">
      <attribute name="obj_pos">
        <point val="18,7.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18,7.61545;21.03,7.91545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[10].NAIYO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="18,7.85"/>
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
    <object type="Embed - Text" version="0" id="O145">
      <attribute name="obj_pos">
        <point val="14.8,7.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.8,7.61545;17.83,7.91545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[10].SRYKA#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="14.8,7.85"/>
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
    <object type="Embed - Text" version="0" id="O146">
      <attribute name="obj_pos">
        <point val="1.9,8.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0516,8.07636;1.9,8.42636"/>
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
            <string>#9999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,8.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="2.1,8.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.1,8.07636;6.342,8.42636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[11].PTNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="2.1,8.35"/>
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
        <point val="6.5,8.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.5,8.11545;14.075,8.41545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[11].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.5,8.35"/>
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
    <object type="Embed - Text" version="0" id="O149">
      <attribute name="obj_pos">
        <point val="28,8.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.4698,8.07636;28.5303,8.42636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[11].KAIKEI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="28,8.35"/>
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
    <object type="Embed - Text" version="0" id="O150">
      <attribute name="obj_pos">
        <point val="26.6,8.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.0698,8.07636;27.1303,8.42636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[11].UKETUKE#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,8.35"/>
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
    <object type="Embed - Text" version="0" id="O151">
      <attribute name="obj_pos">
        <point val="21.2,8.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.2,8.11545;25.745,8.41545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[11].DRNAME#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="21.2,8.35"/>
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
    <object type="Embed - Text" version="0" id="O152">
      <attribute name="obj_pos">
        <point val="18,8.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18,8.11545;21.03,8.41545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[11].NAIYO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="18,8.35"/>
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
    <object type="Embed - Text" version="0" id="O153">
      <attribute name="obj_pos">
        <point val="14.8,8.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.8,8.11545;17.83,8.41545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[11].SRYKA#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="14.8,8.35"/>
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
    <object type="Embed - Text" version="0" id="O154">
      <attribute name="obj_pos">
        <point val="1.9,8.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0516,8.57636;1.9,8.92636"/>
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
            <string>#9999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,8.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="2.1,8.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.1,8.57636;6.342,8.92636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[12].PTNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="2.1,8.85"/>
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
        <point val="6.5,8.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.5,8.61545;14.075,8.91545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[12].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.5,8.85"/>
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
    <object type="Embed - Text" version="0" id="O157">
      <attribute name="obj_pos">
        <point val="28,8.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.4698,8.57636;28.5303,8.92636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[12].KAIKEI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="28,8.85"/>
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
    <object type="Embed - Text" version="0" id="O158">
      <attribute name="obj_pos">
        <point val="26.6,8.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.0698,8.57636;27.1303,8.92636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[12].UKETUKE#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,8.85"/>
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
    <object type="Embed - Text" version="0" id="O159">
      <attribute name="obj_pos">
        <point val="21.2,8.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.2,8.61545;25.745,8.91545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[12].DRNAME#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="21.2,8.85"/>
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
    <object type="Embed - Text" version="0" id="O160">
      <attribute name="obj_pos">
        <point val="18,8.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18,8.61545;21.03,8.91545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[12].NAIYO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="18,8.85"/>
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
    <object type="Embed - Text" version="0" id="O161">
      <attribute name="obj_pos">
        <point val="14.8,8.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.8,8.61545;17.83,8.91545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[12].SRYKA#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="14.8,8.85"/>
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
    <object type="Embed - Text" version="0" id="O162">
      <attribute name="obj_pos">
        <point val="1.9,9.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0516,9.07636;1.9,9.42636"/>
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
            <string>#9999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,9.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="2.1,9.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.1,9.07636;6.342,9.42636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[13].PTNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="2.1,9.35"/>
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
        <point val="6.5,9.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.5,9.11545;14.075,9.41545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[13].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.5,9.35"/>
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
    <object type="Embed - Text" version="0" id="O165">
      <attribute name="obj_pos">
        <point val="28,9.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.4698,9.07636;28.5303,9.42636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[13].KAIKEI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="28,9.35"/>
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
    <object type="Embed - Text" version="0" id="O166">
      <attribute name="obj_pos">
        <point val="26.6,9.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.0698,9.07636;27.1303,9.42636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[13].UKETUKE#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,9.35"/>
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
    <object type="Embed - Text" version="0" id="O167">
      <attribute name="obj_pos">
        <point val="21.2,9.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.2,9.11545;25.745,9.41545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[13].DRNAME#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="21.2,9.35"/>
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
    <object type="Embed - Text" version="0" id="O168">
      <attribute name="obj_pos">
        <point val="18,9.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18,9.11545;21.03,9.41545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[13].NAIYO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="18,9.35"/>
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
    <object type="Embed - Text" version="0" id="O169">
      <attribute name="obj_pos">
        <point val="14.8,9.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.8,9.11545;17.83,9.41545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[13].SRYKA#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="14.8,9.35"/>
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
    <object type="Embed - Text" version="0" id="O170">
      <attribute name="obj_pos">
        <point val="1.9,9.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0516,9.57636;1.9,9.92636"/>
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
            <string>#9999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,9.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="2.1,9.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.1,9.57636;6.342,9.92636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[14].PTNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="2.1,9.85"/>
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
        <point val="6.5,9.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.5,9.61545;14.075,9.91545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[14].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.5,9.85"/>
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
    <object type="Embed - Text" version="0" id="O173">
      <attribute name="obj_pos">
        <point val="28,9.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.4698,9.57636;28.5303,9.92636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[14].KAIKEI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="28,9.85"/>
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
    <object type="Embed - Text" version="0" id="O174">
      <attribute name="obj_pos">
        <point val="26.6,9.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.0698,9.57636;27.1303,9.92636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[14].UKETUKE#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,9.85"/>
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
    <object type="Embed - Text" version="0" id="O175">
      <attribute name="obj_pos">
        <point val="21.2,9.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.2,9.61545;25.745,9.91545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[14].DRNAME#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="21.2,9.85"/>
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
        <point val="18,9.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18,9.61545;21.03,9.91545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[14].NAIYO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="18,9.85"/>
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
        <point val="14.8,9.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.8,9.61545;17.83,9.91545"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[14].SRYKA#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="14.8,9.85"/>
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
        <point val="1.9,10.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0516,10.0764;1.9,10.4264"/>
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
            <string>#9999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,10.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="2.1,10.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.1,10.0764;6.342,10.4264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[15].PTNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="2.1,10.35"/>
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
        <point val="6.5,10.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.5,10.1155;14.075,10.4155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[15].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.5,10.35"/>
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
        <point val="28,10.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.4698,10.0764;28.5303,10.4264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[15].KAIKEI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="28,10.35"/>
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
    <object type="Embed - Text" version="0" id="O182">
      <attribute name="obj_pos">
        <point val="26.6,10.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.0698,10.0764;27.1303,10.4264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[15].UKETUKE#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,10.35"/>
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
    <object type="Embed - Text" version="0" id="O183">
      <attribute name="obj_pos">
        <point val="21.2,10.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.2,10.1155;25.745,10.4155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[15].DRNAME#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="21.2,10.35"/>
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
        <point val="18,10.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18,10.1155;21.03,10.4155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[15].NAIYO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="18,10.35"/>
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
        <point val="14.8,10.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.8,10.1155;17.83,10.4155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[15].SRYKA#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="14.8,10.35"/>
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
        <point val="1.9,10.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0516,10.5764;1.9,10.9264"/>
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
            <string>#9999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,10.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O187">
      <attribute name="obj_pos">
        <point val="2.1,10.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.1,10.5764;6.342,10.9264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[16].PTNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="2.1,10.85"/>
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
    <object type="Embed - Text" version="0" id="O188">
      <attribute name="obj_pos">
        <point val="6.5,10.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.5,10.6155;14.075,10.9155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[16].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.5,10.85"/>
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
        <point val="28,10.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.4698,10.5764;28.5303,10.9264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[16].KAIKEI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="28,10.85"/>
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
    <object type="Embed - Text" version="0" id="O190">
      <attribute name="obj_pos">
        <point val="26.6,10.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.0698,10.5764;27.1303,10.9264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[16].UKETUKE#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,10.85"/>
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
    <object type="Embed - Text" version="0" id="O191">
      <attribute name="obj_pos">
        <point val="21.2,10.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.2,10.6155;25.745,10.9155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[16].DRNAME#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="21.2,10.85"/>
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
        <point val="18,10.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18,10.6155;21.03,10.9155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[16].NAIYO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="18,10.85"/>
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
        <point val="14.8,10.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.8,10.6155;17.83,10.9155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[16].SRYKA#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="14.8,10.85"/>
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
        <point val="1.9,11.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0516,11.0764;1.9,11.4264"/>
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
            <string>#9999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,11.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O195">
      <attribute name="obj_pos">
        <point val="2.1,11.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.1,11.0764;6.342,11.4264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[17].PTNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="2.1,11.35"/>
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
    <object type="Embed - Text" version="0" id="O196">
      <attribute name="obj_pos">
        <point val="6.5,11.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.5,11.1155;14.075,11.4155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[17].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.5,11.35"/>
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
        <point val="28,11.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.4698,11.0764;28.5303,11.4264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[17].KAIKEI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="28,11.35"/>
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
    <object type="Embed - Text" version="0" id="O198">
      <attribute name="obj_pos">
        <point val="26.6,11.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.0698,11.0764;27.1303,11.4264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[17].UKETUKE#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,11.35"/>
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
    <object type="Embed - Text" version="0" id="O199">
      <attribute name="obj_pos">
        <point val="21.2,11.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.2,11.1155;25.745,11.4155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[17].DRNAME#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="21.2,11.35"/>
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
        <point val="18,11.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18,11.1155;21.03,11.4155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[17].NAIYO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="18,11.35"/>
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
        <point val="14.8,11.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.8,11.1155;17.83,11.4155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[17].SRYKA#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="14.8,11.35"/>
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
        <point val="1.9,11.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0516,11.5764;1.9,11.9264"/>
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
            <string>#9999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,11.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O203">
      <attribute name="obj_pos">
        <point val="2.1,11.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.1,11.5764;6.342,11.9264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[18].PTNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="2.1,11.85"/>
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
    <object type="Embed - Text" version="0" id="O204">
      <attribute name="obj_pos">
        <point val="6.5,11.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.5,11.6155;14.075,11.9155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[18].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.5,11.85"/>
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
        <point val="28,11.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.4698,11.5764;28.5303,11.9264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[18].KAIKEI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="28,11.85"/>
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
    <object type="Embed - Text" version="0" id="O206">
      <attribute name="obj_pos">
        <point val="26.6,11.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.0698,11.5764;27.1303,11.9264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[18].UKETUKE#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,11.85"/>
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
    <object type="Embed - Text" version="0" id="O207">
      <attribute name="obj_pos">
        <point val="21.2,11.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.2,11.6155;25.745,11.9155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[18].DRNAME#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="21.2,11.85"/>
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
        <point val="18,11.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18,11.6155;21.03,11.9155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[18].NAIYO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="18,11.85"/>
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
        <point val="14.8,11.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.8,11.6155;17.83,11.9155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[18].SRYKA#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="14.8,11.85"/>
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
        <point val="1.9,12.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0516,12.0764;1.9,12.4264"/>
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
            <string>#9999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,12.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="2.1,12.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.1,12.0764;6.342,12.4264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[19].PTNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="2.1,12.35"/>
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
    <object type="Embed - Text" version="0" id="O212">
      <attribute name="obj_pos">
        <point val="6.5,12.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.5,12.1155;14.075,12.4155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[19].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.5,12.35"/>
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
        <point val="28,12.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.4698,12.0764;28.5303,12.4264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[19].KAIKEI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="28,12.35"/>
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
    <object type="Embed - Text" version="0" id="O214">
      <attribute name="obj_pos">
        <point val="26.6,12.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.0698,12.0764;27.1303,12.4264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[19].UKETUKE#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,12.35"/>
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
    <object type="Embed - Text" version="0" id="O215">
      <attribute name="obj_pos">
        <point val="21.2,12.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.2,12.1155;25.745,12.4155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[19].DRNAME#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="21.2,12.35"/>
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
        <point val="18,12.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18,12.1155;21.03,12.4155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[19].NAIYO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="18,12.35"/>
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
    <object type="Embed - Text" version="0" id="O217">
      <attribute name="obj_pos">
        <point val="14.8,12.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.8,12.1155;17.83,12.4155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[19].SRYKA#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="14.8,12.35"/>
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
    <object type="Embed - Text" version="0" id="O218">
      <attribute name="obj_pos">
        <point val="1.9,12.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0516,12.5764;1.9,12.9264"/>
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
            <string>#9999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,12.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="2.1,12.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.1,12.5764;6.342,12.9264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[20].PTNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="2.1,12.85"/>
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
    <object type="Embed - Text" version="0" id="O220">
      <attribute name="obj_pos">
        <point val="6.5,12.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.5,12.6155;14.075,12.9155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[20].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.5,12.85"/>
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
    <object type="Embed - Text" version="0" id="O221">
      <attribute name="obj_pos">
        <point val="28,12.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.4698,12.5764;28.5303,12.9264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[20].KAIKEI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="28,12.85"/>
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
    <object type="Embed - Text" version="0" id="O222">
      <attribute name="obj_pos">
        <point val="26.6,12.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.0698,12.5764;27.1303,12.9264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[20].UKETUKE#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,12.85"/>
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
    <object type="Embed - Text" version="0" id="O223">
      <attribute name="obj_pos">
        <point val="21.2,12.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.2,12.6155;25.745,12.9155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[20].DRNAME#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="21.2,12.85"/>
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
    <object type="Embed - Text" version="0" id="O224">
      <attribute name="obj_pos">
        <point val="18,12.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18,12.6155;21.03,12.9155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[20].NAIYO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="18,12.85"/>
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
    <object type="Embed - Text" version="0" id="O225">
      <attribute name="obj_pos">
        <point val="14.8,12.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.8,12.6155;17.83,12.9155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[20].SRYKA#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="14.8,12.85"/>
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
    <object type="Embed - Text" version="0" id="O226">
      <attribute name="obj_pos">
        <point val="1.9,13.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0516,13.0764;1.9,13.4264"/>
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
            <string>#9999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,13.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="2.1,13.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.1,13.0764;6.342,13.4264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[21].PTNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="2.1,13.35"/>
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
    <object type="Embed - Text" version="0" id="O228">
      <attribute name="obj_pos">
        <point val="6.5,13.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.5,13.1155;14.075,13.4155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[21].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.5,13.35"/>
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
    <object type="Embed - Text" version="0" id="O229">
      <attribute name="obj_pos">
        <point val="28,13.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.4698,13.0764;28.5303,13.4264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[21].KAIKEI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="28,13.35"/>
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
    <object type="Embed - Text" version="0" id="O230">
      <attribute name="obj_pos">
        <point val="26.6,13.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.0698,13.0764;27.1303,13.4264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[21].UKETUKE#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,13.35"/>
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
    <object type="Embed - Text" version="0" id="O231">
      <attribute name="obj_pos">
        <point val="21.2,13.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.2,13.1155;25.745,13.4155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[21].DRNAME#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="21.2,13.35"/>
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
    <object type="Embed - Text" version="0" id="O232">
      <attribute name="obj_pos">
        <point val="18,13.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18,13.1155;21.03,13.4155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[21].NAIYO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="18,13.35"/>
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
    <object type="Embed - Text" version="0" id="O233">
      <attribute name="obj_pos">
        <point val="14.8,13.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.8,13.1155;17.83,13.4155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[21].SRYKA#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="14.8,13.35"/>
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
    <object type="Embed - Text" version="0" id="O234">
      <attribute name="obj_pos">
        <point val="1.9,13.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0516,13.5764;1.9,13.9264"/>
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
            <string>#9999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,13.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="2.1,13.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.1,13.5764;6.342,13.9264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[22].PTNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="2.1,13.85"/>
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
    <object type="Embed - Text" version="0" id="O236">
      <attribute name="obj_pos">
        <point val="6.5,13.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.5,13.6155;14.075,13.9155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[22].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.5,13.85"/>
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
    <object type="Embed - Text" version="0" id="O237">
      <attribute name="obj_pos">
        <point val="28,13.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.4698,13.5764;28.5303,13.9264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[22].KAIKEI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="28,13.85"/>
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
    <object type="Embed - Text" version="0" id="O238">
      <attribute name="obj_pos">
        <point val="26.6,13.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.0698,13.5764;27.1303,13.9264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[22].UKETUKE#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,13.85"/>
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
    <object type="Embed - Text" version="0" id="O239">
      <attribute name="obj_pos">
        <point val="21.2,13.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.2,13.6155;25.745,13.9155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[22].DRNAME#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="21.2,13.85"/>
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
    <object type="Embed - Text" version="0" id="O240">
      <attribute name="obj_pos">
        <point val="18,13.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18,13.6155;21.03,13.9155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[22].NAIYO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="18,13.85"/>
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
    <object type="Embed - Text" version="0" id="O241">
      <attribute name="obj_pos">
        <point val="14.8,13.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.8,13.6155;17.83,13.9155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[22].SRYKA#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="14.8,13.85"/>
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
    <object type="Embed - Text" version="0" id="O242">
      <attribute name="obj_pos">
        <point val="1.9,14.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0516,14.0764;1.9,14.4264"/>
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
            <string>#9999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,14.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="2.1,14.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.1,14.0764;6.342,14.4264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[23].PTNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="2.1,14.35"/>
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
    <object type="Embed - Text" version="0" id="O244">
      <attribute name="obj_pos">
        <point val="6.5,14.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.5,14.1155;14.075,14.4155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[23].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.5,14.35"/>
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
    <object type="Embed - Text" version="0" id="O245">
      <attribute name="obj_pos">
        <point val="28,14.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.4698,14.0764;28.5303,14.4264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[23].KAIKEI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="28,14.35"/>
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
    <object type="Embed - Text" version="0" id="O246">
      <attribute name="obj_pos">
        <point val="26.6,14.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.0698,14.0764;27.1303,14.4264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[23].UKETUKE#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,14.35"/>
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
    <object type="Embed - Text" version="0" id="O247">
      <attribute name="obj_pos">
        <point val="21.2,14.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.2,14.1155;25.745,14.4155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[23].DRNAME#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="21.2,14.35"/>
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
    <object type="Embed - Text" version="0" id="O248">
      <attribute name="obj_pos">
        <point val="18,14.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18,14.1155;21.03,14.4155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[23].NAIYO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="18,14.35"/>
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
    <object type="Embed - Text" version="0" id="O249">
      <attribute name="obj_pos">
        <point val="14.8,14.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.8,14.1155;17.83,14.4155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[23].SRYKA#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="14.8,14.35"/>
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
    <object type="Embed - Text" version="0" id="O250">
      <attribute name="obj_pos">
        <point val="1.9,14.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0516,14.5764;1.9,14.9264"/>
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
            <string>#9999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,14.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="2.1,14.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.1,14.5764;6.342,14.9264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[24].PTNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="2.1,14.85"/>
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
    <object type="Embed - Text" version="0" id="O252">
      <attribute name="obj_pos">
        <point val="6.5,14.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.5,14.6155;14.075,14.9155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[24].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.5,14.85"/>
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
    <object type="Embed - Text" version="0" id="O253">
      <attribute name="obj_pos">
        <point val="28,14.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.4698,14.5764;28.5303,14.9264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[24].KAIKEI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="28,14.85"/>
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
    <object type="Embed - Text" version="0" id="O254">
      <attribute name="obj_pos">
        <point val="26.6,14.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.0698,14.5764;27.1303,14.9264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[24].UKETUKE#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,14.85"/>
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
    <object type="Embed - Text" version="0" id="O255">
      <attribute name="obj_pos">
        <point val="21.2,14.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.2,14.6155;25.745,14.9155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[24].DRNAME#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="21.2,14.85"/>
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
    <object type="Embed - Text" version="0" id="O256">
      <attribute name="obj_pos">
        <point val="18,14.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18,14.6155;21.03,14.9155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[24].NAIYO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="18,14.85"/>
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
    <object type="Embed - Text" version="0" id="O257">
      <attribute name="obj_pos">
        <point val="14.8,14.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.8,14.6155;17.83,14.9155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[24].SRYKA#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="14.8,14.85"/>
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
    <object type="Embed - Text" version="0" id="O258">
      <attribute name="obj_pos">
        <point val="1.9,15.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0516,15.0764;1.9,15.4264"/>
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
            <string>#9999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,15.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="2.1,15.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.1,15.0764;6.342,15.4264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[25].PTNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="2.1,15.35"/>
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
    <object type="Embed - Text" version="0" id="O260">
      <attribute name="obj_pos">
        <point val="6.5,15.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.5,15.1155;14.075,15.4155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[25].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.5,15.35"/>
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
    <object type="Embed - Text" version="0" id="O261">
      <attribute name="obj_pos">
        <point val="28,15.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.4698,15.0764;28.5303,15.4264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[25].KAIKEI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="28,15.35"/>
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
    <object type="Embed - Text" version="0" id="O262">
      <attribute name="obj_pos">
        <point val="26.6,15.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.0698,15.0764;27.1303,15.4264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[25].UKETUKE#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,15.35"/>
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
    <object type="Embed - Text" version="0" id="O263">
      <attribute name="obj_pos">
        <point val="21.2,15.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.2,15.1155;25.745,15.4155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[25].DRNAME#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="21.2,15.35"/>
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
    <object type="Embed - Text" version="0" id="O264">
      <attribute name="obj_pos">
        <point val="18,15.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18,15.1155;21.03,15.4155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[25].NAIYO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="18,15.35"/>
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
    <object type="Embed - Text" version="0" id="O265">
      <attribute name="obj_pos">
        <point val="14.8,15.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.8,15.1155;17.83,15.4155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[25].SRYKA#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="14.8,15.35"/>
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
    <object type="Embed - Text" version="0" id="O266">
      <attribute name="obj_pos">
        <point val="1.9,15.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0516,15.5764;1.9,15.9264"/>
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
            <string>#9999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,15.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="2.1,15.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.1,15.5764;6.342,15.9264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[26].PTNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="2.1,15.85"/>
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
    <object type="Embed - Text" version="0" id="O268">
      <attribute name="obj_pos">
        <point val="6.5,15.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.5,15.6155;14.075,15.9155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[26].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.5,15.85"/>
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
    <object type="Embed - Text" version="0" id="O269">
      <attribute name="obj_pos">
        <point val="28,15.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.4698,15.5764;28.5303,15.9264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[26].KAIKEI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="28,15.85"/>
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
    <object type="Embed - Text" version="0" id="O270">
      <attribute name="obj_pos">
        <point val="26.6,15.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.0698,15.5764;27.1303,15.9264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[26].UKETUKE#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,15.85"/>
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
    <object type="Embed - Text" version="0" id="O271">
      <attribute name="obj_pos">
        <point val="21.2,15.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.2,15.6155;25.745,15.9155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[26].DRNAME#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="21.2,15.85"/>
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
    <object type="Embed - Text" version="0" id="O272">
      <attribute name="obj_pos">
        <point val="18,15.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18,15.6155;21.03,15.9155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[26].NAIYO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="18,15.85"/>
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
    <object type="Embed - Text" version="0" id="O273">
      <attribute name="obj_pos">
        <point val="14.8,15.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.8,15.6155;17.83,15.9155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[26].SRYKA#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="14.8,15.85"/>
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
    <object type="Embed - Text" version="0" id="O274">
      <attribute name="obj_pos">
        <point val="1.9,16.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0516,16.0764;1.9,16.4264"/>
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
            <string>#9999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,16.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="2.1,16.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.1,16.0764;6.342,16.4264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[27].PTNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="2.1,16.35"/>
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
    <object type="Embed - Text" version="0" id="O276">
      <attribute name="obj_pos">
        <point val="6.5,16.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.5,16.1155;14.075,16.4155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[27].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.5,16.35"/>
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
    <object type="Embed - Text" version="0" id="O277">
      <attribute name="obj_pos">
        <point val="28,16.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.4698,16.0764;28.5303,16.4264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[27].KAIKEI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="28,16.35"/>
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
    <object type="Embed - Text" version="0" id="O278">
      <attribute name="obj_pos">
        <point val="26.6,16.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.0698,16.0764;27.1303,16.4264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[27].UKETUKE#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,16.35"/>
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
    <object type="Embed - Text" version="0" id="O279">
      <attribute name="obj_pos">
        <point val="21.2,16.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.2,16.1155;25.745,16.4155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[27].DRNAME#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="21.2,16.35"/>
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
    <object type="Embed - Text" version="0" id="O280">
      <attribute name="obj_pos">
        <point val="18,16.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18,16.1155;21.03,16.4155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[27].NAIYO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="18,16.35"/>
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
    <object type="Embed - Text" version="0" id="O281">
      <attribute name="obj_pos">
        <point val="14.8,16.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.8,16.1155;17.83,16.4155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[27].SRYKA#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="14.8,16.35"/>
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
    <object type="Embed - Text" version="0" id="O282">
      <attribute name="obj_pos">
        <point val="1.9,16.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0516,16.5764;1.9,16.9264"/>
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
            <string>#9999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,16.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="2.1,16.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.1,16.5764;6.342,16.9264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[28].PTNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="2.1,16.85"/>
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
    <object type="Embed - Text" version="0" id="O284">
      <attribute name="obj_pos">
        <point val="6.5,16.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.5,16.6155;14.075,16.9155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[28].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.5,16.85"/>
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
    <object type="Embed - Text" version="0" id="O285">
      <attribute name="obj_pos">
        <point val="28,16.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.4698,16.5764;28.5303,16.9264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[28].KAIKEI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="28,16.85"/>
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
    <object type="Embed - Text" version="0" id="O286">
      <attribute name="obj_pos">
        <point val="26.6,16.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.0698,16.5764;27.1303,16.9264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[28].UKETUKE#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,16.85"/>
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
    <object type="Embed - Text" version="0" id="O287">
      <attribute name="obj_pos">
        <point val="21.2,16.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.2,16.6155;25.745,16.9155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[28].DRNAME#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="21.2,16.85"/>
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
    <object type="Embed - Text" version="0" id="O288">
      <attribute name="obj_pos">
        <point val="18,16.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18,16.6155;21.03,16.9155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[28].NAIYO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="18,16.85"/>
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
    <object type="Embed - Text" version="0" id="O289">
      <attribute name="obj_pos">
        <point val="14.8,16.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.8,16.6155;17.83,16.9155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[28].SRYKA#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="14.8,16.85"/>
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
    <object type="Embed - Text" version="0" id="O290">
      <attribute name="obj_pos">
        <point val="1.9,17.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0516,17.0764;1.9,17.4264"/>
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
            <string>#9999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,17.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="2.1,17.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.1,17.0764;6.342,17.4264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[29].PTNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="2.1,17.35"/>
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
    <object type="Embed - Text" version="0" id="O292">
      <attribute name="obj_pos">
        <point val="6.5,17.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.5,17.1155;14.075,17.4155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[29].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.5,17.35"/>
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
    <object type="Embed - Text" version="0" id="O293">
      <attribute name="obj_pos">
        <point val="28,17.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.4698,17.0764;28.5303,17.4264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[29].KAIKEI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="28,17.35"/>
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
    <object type="Embed - Text" version="0" id="O294">
      <attribute name="obj_pos">
        <point val="26.6,17.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.0698,17.0764;27.1303,17.4264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[29].UKETUKE#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,17.35"/>
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
    <object type="Embed - Text" version="0" id="O295">
      <attribute name="obj_pos">
        <point val="21.2,17.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.2,17.1155;25.745,17.4155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[29].DRNAME#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="21.2,17.35"/>
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
    <object type="Embed - Text" version="0" id="O296">
      <attribute name="obj_pos">
        <point val="18,17.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18,17.1155;21.03,17.4155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[29].NAIYO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="18,17.35"/>
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
    <object type="Embed - Text" version="0" id="O297">
      <attribute name="obj_pos">
        <point val="14.8,17.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.8,17.1155;17.83,17.4155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[29].SRYKA#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="14.8,17.35"/>
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
    <object type="Embed - Text" version="0" id="O298">
      <attribute name="obj_pos">
        <point val="1.9,17.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0516,17.5764;1.9,17.9264"/>
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
            <string>#9999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,17.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="2.1,17.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.1,17.5764;6.342,17.9264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[30].PTNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="2.1,17.85"/>
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
    <object type="Embed - Text" version="0" id="O300">
      <attribute name="obj_pos">
        <point val="6.5,17.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.5,17.6155;14.075,17.9155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[30].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.5,17.85"/>
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
    <object type="Embed - Text" version="0" id="O301">
      <attribute name="obj_pos">
        <point val="28,17.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.4698,17.5764;28.5303,17.9264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[30].KAIKEI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="28,17.85"/>
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
    <object type="Embed - Text" version="0" id="O302">
      <attribute name="obj_pos">
        <point val="26.6,17.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.0698,17.5764;27.1303,17.9264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[30].UKETUKE#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,17.85"/>
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
    <object type="Embed - Text" version="0" id="O303">
      <attribute name="obj_pos">
        <point val="21.2,17.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.2,17.6155;25.745,17.9155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[30].DRNAME#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="21.2,17.85"/>
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
    <object type="Embed - Text" version="0" id="O304">
      <attribute name="obj_pos">
        <point val="18,17.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18,17.6155;21.03,17.9155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[30].NAIYO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="18,17.85"/>
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
    <object type="Embed - Text" version="0" id="O305">
      <attribute name="obj_pos">
        <point val="14.8,17.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.8,17.6155;17.83,17.9155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[30].SRYKA#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="14.8,17.85"/>
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
    <object type="Embed - Text" version="0" id="O306">
      <attribute name="obj_pos">
        <point val="1.9,18.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0516,18.0764;1.9,18.4264"/>
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
            <string>#9999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,18.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="2.1,18.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.1,18.0764;6.342,18.4264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[31].PTNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="2.1,18.35"/>
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
    <object type="Embed - Text" version="0" id="O308">
      <attribute name="obj_pos">
        <point val="6.5,18.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.5,18.1155;14.075,18.4155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[31].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.5,18.35"/>
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
    <object type="Embed - Text" version="0" id="O309">
      <attribute name="obj_pos">
        <point val="28,18.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.4698,18.0764;28.5303,18.4264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[31].KAIKEI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="28,18.35"/>
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
    <object type="Embed - Text" version="0" id="O310">
      <attribute name="obj_pos">
        <point val="26.6,18.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.0698,18.0764;27.1303,18.4264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[31].UKETUKE#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,18.35"/>
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
    <object type="Embed - Text" version="0" id="O311">
      <attribute name="obj_pos">
        <point val="21.2,18.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.2,18.1155;25.745,18.4155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[31].DRNAME#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="21.2,18.35"/>
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
    <object type="Embed - Text" version="0" id="O312">
      <attribute name="obj_pos">
        <point val="18,18.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18,18.1155;21.03,18.4155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[31].NAIYO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="18,18.35"/>
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
    <object type="Embed - Text" version="0" id="O313">
      <attribute name="obj_pos">
        <point val="14.8,18.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.8,18.1155;17.83,18.4155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[31].SRYKA#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="14.8,18.35"/>
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
    <object type="Embed - Text" version="0" id="O314">
      <attribute name="obj_pos">
        <point val="1.9,18.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0516,18.5764;1.9,18.9264"/>
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
            <string>#9999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,18.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="2.1,18.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.1,18.5764;6.342,18.9264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[32].PTNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="2.1,18.85"/>
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
    <object type="Embed - Text" version="0" id="O316">
      <attribute name="obj_pos">
        <point val="6.5,18.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.5,18.6155;14.075,18.9155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[32].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.5,18.85"/>
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
    <object type="Embed - Text" version="0" id="O317">
      <attribute name="obj_pos">
        <point val="28,18.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.4698,18.5764;28.5303,18.9264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[32].KAIKEI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="28,18.85"/>
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
    <object type="Embed - Text" version="0" id="O318">
      <attribute name="obj_pos">
        <point val="26.6,18.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.0698,18.5764;27.1303,18.9264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[32].UKETUKE#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,18.85"/>
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
    <object type="Embed - Text" version="0" id="O319">
      <attribute name="obj_pos">
        <point val="21.2,18.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.2,18.6155;25.745,18.9155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[32].DRNAME#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="21.2,18.85"/>
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
    <object type="Embed - Text" version="0" id="O320">
      <attribute name="obj_pos">
        <point val="18,18.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18,18.6155;21.03,18.9155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[32].NAIYO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="18,18.85"/>
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
    <object type="Embed - Text" version="0" id="O321">
      <attribute name="obj_pos">
        <point val="14.8,18.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.8,18.6155;17.83,18.9155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[32].SRYKA#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="14.8,18.85"/>
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
    <object type="Embed - Text" version="0" id="O322">
      <attribute name="obj_pos">
        <point val="1.9,19.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0516,19.0764;1.9,19.4264"/>
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
            <string>#9999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,19.35"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="2.1,19.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.1,19.0764;6.342,19.4264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[33].PTNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="2.1,19.35"/>
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
    <object type="Embed - Text" version="0" id="O324">
      <attribute name="obj_pos">
        <point val="6.5,19.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.5,19.1155;14.075,19.4155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[33].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.5,19.35"/>
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
    <object type="Embed - Text" version="0" id="O325">
      <attribute name="obj_pos">
        <point val="28,19.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.4698,19.0764;28.5303,19.4264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[33].KAIKEI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="28,19.35"/>
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
    <object type="Embed - Text" version="0" id="O326">
      <attribute name="obj_pos">
        <point val="26.6,19.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.0698,19.0764;27.1303,19.4264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[33].UKETUKE#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,19.35"/>
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
    <object type="Embed - Text" version="0" id="O327">
      <attribute name="obj_pos">
        <point val="21.2,19.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.2,19.1155;25.745,19.4155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[33].DRNAME#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="21.2,19.35"/>
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
    <object type="Embed - Text" version="0" id="O328">
      <attribute name="obj_pos">
        <point val="18,19.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18,19.1155;21.03,19.4155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[33].NAIYO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="18,19.35"/>
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
    <object type="Embed - Text" version="0" id="O329">
      <attribute name="obj_pos">
        <point val="14.8,19.35"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.8,19.1155;17.83,19.4155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[33].SRYKA#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="14.8,19.35"/>
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
    <object type="Embed - Text" version="0" id="O330">
      <attribute name="obj_pos">
        <point val="1.9,19.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.0516,19.5764;1.9,19.9264"/>
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
            <string>#9999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.9,19.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="2.1,19.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.1,19.5764;6.342,19.9264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[34].PTNUM#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="2.1,19.85"/>
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
    <object type="Embed - Text" version="0" id="O332">
      <attribute name="obj_pos">
        <point val="6.5,19.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.5,19.6155;14.075,19.9155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[34].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.5,19.85"/>
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
    <object type="Embed - Text" version="0" id="O333">
      <attribute name="obj_pos">
        <point val="28,19.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="27.4698,19.5764;28.5303,19.9264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[34].KAIKEI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="28,19.85"/>
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
    <object type="Embed - Text" version="0" id="O334">
      <attribute name="obj_pos">
        <point val="26.6,19.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.0698,19.5764;27.1303,19.9264"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[34].UKETUKE#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,19.85"/>
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
    <object type="Embed - Text" version="0" id="O335">
      <attribute name="obj_pos">
        <point val="21.2,19.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.2,19.6155;25.745,19.9155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[34].DRNAME#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="21.2,19.85"/>
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
    <object type="Embed - Text" version="0" id="O336">
      <attribute name="obj_pos">
        <point val="18,19.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18,19.6155;21.03,19.9155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[34].NAIYO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="18,19.85"/>
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
    <object type="Embed - Text" version="0" id="O337">
      <attribute name="obj_pos">
        <point val="14.8,19.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.8,19.6155;17.83,19.9155"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#A-TBL[34].SRYKA#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="14.8,19.85"/>
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
    <object type="Embed - Text" version="0" id="O338">
      <attribute name="obj_pos">
        <point val="1,1.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,1.56545;4.333,1.86545"/>
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
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="1,1.8"/>
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
    <object type="Embed - Text" version="0" id="O339">
      <attribute name="obj_pos">
        <point val="28.7,1.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="28.0637,1.57636;28.7,1.92636"/>
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
            <point val="28.7,1.85"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="24.25,1.85"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.25,1.57636;27.2194,1.92636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#SAKUSEI#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="24.25,1.85"/>
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
  </layer>
</diagram>
