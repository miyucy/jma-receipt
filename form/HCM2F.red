<?xml version="1.0" encoding="euc-jp"?>
<diagram xmlns:dia="http://www.lysator.liu.se/~alla/dia/">
  <dictionarydata>
    <element name="HOSPCD" occurs="1">
      <appinfo>
        <embed object="string" type="X" length="20"/>
      </appinfo>
    </element>
    <element name="TITLE" occurs="1">
      <appinfo>
        <embed object="string" type="X" length="36"/>
      </appinfo>
    </element>
    <element name="HKN-TBL" occurs="1">
      <element name="HKN-TBLG" occurs="4">
        <element name="HKN-G" occurs="2">
          <element name="KENSU" occurs="1">
            <appinfo>
              <embed object="string" type="X" length="6"/>
            </appinfo>
          </element>
          <element name="NISSU" occurs="1">
            <appinfo>
              <embed object="string" type="X" length="6"/>
            </appinfo>
          </element>
          <element name="TENSU" occurs="1">
            <appinfo>
              <embed object="string" type="X" length="10"/>
            </appinfo>
          </element>
          <element name="YKZFTN" occurs="1">
            <appinfo>
              <embed object="string" type="X" length="8"/>
            </appinfo>
          </element>
          <element name="ITBFTN" occurs="1">
            <appinfo>
              <embed object="string" type="X" length="9"/>
            </appinfo>
          </element>
        </element>
      </element>
    </element>
    <element name="KOHNUM" occurs="2">
      <appinfo>
        <embed object="string" type="X" length="3"/>
      </appinfo>
    </element>
    <element name="KOHNAME" occurs="2">
      <appinfo>
        <embed object="string" type="X" length="12"/>
      </appinfo>
    </element>
    <element name="SYO-TBL" occurs="1">
      <element name="SYO-TBLG" occurs="4">
        <element name="SYOKENSU" occurs="1">
          <appinfo>
            <embed object="string" type="X" length="6"/>
          </appinfo>
        </element>
        <element name="SYONISSU" occurs="1">
          <appinfo>
            <embed object="string" type="X" length="6"/>
          </appinfo>
        </element>
        <element name="SYOKINGAK" occurs="1">
          <appinfo>
            <embed object="string" type="X" length="9"/>
          </appinfo>
        </element>
        <element name="SYOFTNGAK" occurs="1">
          <appinfo>
            <embed object="string" type="X" length="9"/>
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
    <object type="Standard - Box" version="0" id="O0">
      <attribute name="obj_pos">
        <point val="1.2,1.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.195,1.695;19.805,28.005"/>
      </attribute>
      <attribute name="elem_corner">
        <point val="1.2,1.7"/>
      </attribute>
      <attribute name="elem_width">
        <real val="18.6"/>
      </attribute>
      <attribute name="elem_height">
        <real val="26.3"/>
      </attribute>
      <attribute name="border_width">
        <real val="0.01"/>
      </attribute>
      <attribute name="show_background">
        <boolean val="false"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O1">
      <attribute name="obj_pos">
        <point val="13.5,2.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.495,2.295;19.305,2.305"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="13.5,2.3"/>
        <point val="19.3,2.3"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O2">
      <attribute name="obj_pos">
        <point val="4.4,4.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.395,4.795;19.305,4.805"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="4.4,4.8"/>
        <point val="19.3,4.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="1" to="O47" connection="0"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O3">
      <attribute name="obj_pos">
        <point val="4.4,6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.395,5.995;19.305,6.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="4.4,6"/>
        <point val="19.3,6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="1" to="O32" connection="0"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O4">
      <attribute name="obj_pos">
        <point val="4.4,7.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.395,7.195;19.305,7.205"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="4.4,7.2"/>
        <point val="19.3,7.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="1" to="O48" connection="0"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O5">
      <attribute name="obj_pos">
        <point val="4.4,8.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.395,8.395;19.305,8.405"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="4.4,8.4"/>
        <point val="19.3,8.4"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="1" to="O34" connection="0"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O6">
      <attribute name="obj_pos">
        <point val="1.7,4.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.695,4.195;2.605,4.205"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.7,4.2"/>
        <point val="2.6,4.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O7">
      <attribute name="obj_pos">
        <point val="12.7,5.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.695,4.795;13.905,5.405"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="12.7,5.4"/>
        <point val="13.9,4.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O8">
      <attribute name="obj_pos">
        <point val="17.2,5.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.195,4.795;19.305,5.405"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="17.2,5.4"/>
        <point val="19.3,4.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="1" to="O47" connection="0"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O9">
      <attribute name="obj_pos">
        <point val="15.1,5.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.095,4.795;17.205,5.405"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="15.1,5.4"/>
        <point val="17.2,4.8"/>
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
        <point val="13.9,5.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.895,4.795;15.105,5.405"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="13.9,5.4"/>
        <point val="15.1,4.8"/>
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
        <point val="1.7,9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.695,8.995;2.605,9.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.7,9"/>
        <point val="2.6,9"/>
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
        <point val="1.7,6.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.695,6.595;2.605,6.605"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.7,6.6"/>
        <point val="2.6,6.6"/>
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
        <point val="3.1,7.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.095,7.195;4.405,7.205"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.1,7.2"/>
        <point val="4.4,7.2"/>
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
        <point val="3.1,8.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.095,8.395;4.405,8.405"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.1,8.4"/>
        <point val="4.4,8.4"/>
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
        <point val="3.1,4.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.095,4.795;4.405,4.805"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.1,4.8"/>
        <point val="4.4,4.8"/>
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
        <point val="3.1,6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.095,5.995;4.405,6.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.1,6"/>
        <point val="4.4,6"/>
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
        <point val="4.4,3.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.395,3.395;19.305,3.405"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="4.4,3.4"/>
        <point val="19.3,3.4"/>
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
        <point val="12.7,6.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.695,5.995;13.905,6.605"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="12.7,6.6"/>
        <point val="13.9,6"/>
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
        <point val="17.2,6.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.195,5.995;19.305,6.605"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="17.2,6.6"/>
        <point val="19.3,6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="1" to="O32" connection="0"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O20">
      <attribute name="obj_pos">
        <point val="15.1,6.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.095,5.995;17.205,6.605"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="15.1,6.6"/>
        <point val="17.2,6"/>
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
        <point val="13.9,6.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.895,5.995;15.105,6.605"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="13.9,6.6"/>
        <point val="15.1,6"/>
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
        <point val="12.7,7.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.695,7.195;13.905,7.805"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="12.7,7.8"/>
        <point val="13.9,7.2"/>
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
        <point val="17.2,7.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.195,7.195;19.305,7.805"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="17.2,7.8"/>
        <point val="19.3,7.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="1" to="O48" connection="0"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O24">
      <attribute name="obj_pos">
        <point val="15.1,7.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.095,7.195;17.205,7.805"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="15.1,7.8"/>
        <point val="17.2,7.2"/>
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
        <point val="13.9,7.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.895,7.195;15.105,7.805"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="13.9,7.8"/>
        <point val="15.1,7.2"/>
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
        <point val="12.7,9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.695,8.395;13.905,9.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="12.7,9"/>
        <point val="13.9,8.4"/>
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
        <point val="17.2,9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.195,8.395;19.305,9.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="17.2,9"/>
        <point val="19.3,8.4"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="1" to="O34" connection="0"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O28">
      <attribute name="obj_pos">
        <point val="15.1,9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.095,8.395;17.205,9.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="15.1,9"/>
        <point val="17.2,8.4"/>
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
        <point val="13.9,9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.895,8.395;15.105,9.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="13.9,9"/>
        <point val="15.1,8.4"/>
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
        <point val="2.6,6.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.595,5.395;2.605,6.605"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="2.6,6.6"/>
        <point val="2.6,5.4"/>
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
        <point val="2.6,9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.595,7.795;2.605,9.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="2.6,9"/>
        <point val="2.6,7.8"/>
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
        <point val="19.3,6.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.295,5.395;19.305,6.605"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="19.3,6.6"/>
        <point val="19.3,5.4"/>
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
        <point val="19.3,4.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.295,2.995;19.305,4.205"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="19.3,4.2"/>
        <point val="19.3,3"/>
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
        <point val="19.3,9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.295,7.795;19.305,9.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="19.3,9"/>
        <point val="19.3,7.8"/>
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
        <point val="4.4,4.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.385,4.185;19.315,4.215"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="4.4,4.2"/>
        <point val="19.3,4.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.03"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O36">
      <attribute name="obj_pos">
        <point val="4.4,5.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.385,5.385;19.315,5.415"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="4.4,5.4"/>
        <point val="19.3,5.4"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.03"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O37">
      <attribute name="obj_pos">
        <point val="4.4,6.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.385,6.585;19.315,6.615"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="4.4,6.6"/>
        <point val="19.3,6.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.03"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O38">
      <attribute name="obj_pos">
        <point val="4.4,7.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.385,7.785;19.315,7.815"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="4.4,7.8"/>
        <point val="19.3,7.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.03"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O39">
      <attribute name="obj_pos">
        <point val="4.4,9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.395,8.995;19.305,9.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="4.4,9"/>
        <point val="19.3,9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O40">
      <attribute name="obj_pos">
        <point val="2.6,7.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.585,7.785;4.415,7.815"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="2.6,7.8"/>
        <point val="4.4,7.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.03"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O41">
      <attribute name="obj_pos">
        <point val="2.6,5.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.585,5.385;4.415,5.415"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="2.6,5.4"/>
        <point val="4.4,5.4"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.03"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O42">
      <attribute name="obj_pos">
        <point val="2.6,9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.595,8.995;4.405,9.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="2.6,9"/>
        <point val="4.4,9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O43">
      <attribute name="obj_pos">
        <point val="2.6,6.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.585,6.585;4.415,6.615"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="2.6,6.6"/>
        <point val="4.4,6.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.03"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O44">
      <attribute name="obj_pos">
        <point val="2.6,4.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.585,4.185;4.415,4.215"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="2.6,4.2"/>
        <point val="4.4,4.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.03"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O45">
      <attribute name="obj_pos">
        <point val="2.6,5.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.585,4.185;2.615,5.415"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="2.6,5.4"/>
        <point val="2.6,4.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.03"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O46">
      <attribute name="obj_pos">
        <point val="2.6,7.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.585,6.585;2.615,7.815"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="2.6,7.8"/>
        <point val="2.6,6.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.03"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O47">
      <attribute name="obj_pos">
        <point val="19.3,5.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.285,4.185;19.315,5.415"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="19.3,5.4"/>
        <point val="19.3,4.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.03"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O48">
      <attribute name="obj_pos">
        <point val="19.3,7.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.285,6.585;19.315,7.815"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="19.3,7.8"/>
        <point val="19.3,6.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.03"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O49">
      <attribute name="obj_pos">
        <point val="1.7,9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.695,2.995;1.705,9.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.7,9"/>
        <point val="1.7,3"/>
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
        <point val="3.1,9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.095,4.195;3.105,9.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.1,9"/>
        <point val="3.1,4.2"/>
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
        <point val="4.4,9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.395,2.995;4.405,9.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="4.4,9"/>
        <point val="4.4,3"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O52">
      <attribute name="obj_pos">
        <point val="5.6,9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.595,3.395;5.605,9.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="5.6,9"/>
        <point val="5.6,3.4"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O53">
      <attribute name="obj_pos">
        <point val="6.8,9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.795,3.395;6.805,9.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="6.8,9"/>
        <point val="6.8,3.4"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O54">
      <attribute name="obj_pos">
        <point val="8.7,9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.695,3.395;8.705,9.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="8.7,9"/>
        <point val="8.7,3.4"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O55">
      <attribute name="obj_pos">
        <point val="12.7,9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.695,2.995;12.705,9.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="12.7,9"/>
        <point val="12.7,3"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O56">
      <attribute name="obj_pos">
        <point val="13.9,9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.895,3.395;13.905,9.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="13.9,9"/>
        <point val="13.9,3.4"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O57">
      <attribute name="obj_pos">
        <point val="15.1,9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.095,3.395;15.105,9.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="15.1,9"/>
        <point val="15.1,3.4"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O58">
      <attribute name="obj_pos">
        <point val="17.2,9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.195,3.395;17.205,9.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="17.2,9"/>
        <point val="17.2,3.4"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O59">
      <attribute name="obj_pos">
        <point val="4.4,11.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.395,11.595;19.305,11.605"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="4.4,11.6"/>
        <point val="19.3,11.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="1" to="O108" connection="0"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O60">
      <attribute name="obj_pos">
        <point val="4.4,12.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.395,12.795;19.305,12.805"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="4.4,12.8"/>
        <point val="19.3,12.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O112" connection="0"/>
        <connection handle="1" to="O93" connection="0"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O61">
      <attribute name="obj_pos">
        <point val="4.4,14"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.395,13.995;19.305,14.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="4.4,14"/>
        <point val="19.3,14"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="1" to="O109" connection="0"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O62">
      <attribute name="obj_pos">
        <point val="4.4,15.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.395,15.195;19.305,15.205"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="4.4,15.2"/>
        <point val="19.3,15.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="1" to="O95" connection="0"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O63">
      <attribute name="obj_pos">
        <point val="8.7,12.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.695,12.195;10.605,12.805"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="8.7,12.8"/>
        <point val="10.6,12.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O64">
      <attribute name="obj_pos">
        <point val="8.7,14"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.695,13.395;10.605,14.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="8.7,14"/>
        <point val="10.6,13.4"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O65">
      <attribute name="obj_pos">
        <point val="8.7,15.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.695,14.595;10.605,15.205"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="8.7,15.2"/>
        <point val="10.6,14.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O66">
      <attribute name="obj_pos">
        <point val="1.7,11"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.695,10.995;2.605,11.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.7,11"/>
        <point val="2.6,11"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O67">
      <attribute name="obj_pos">
        <point val="12.7,12.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.695,11.595;13.905,12.205"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="12.7,12.2"/>
        <point val="13.9,11.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O68">
      <attribute name="obj_pos">
        <point val="17.2,12.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.195,11.595;19.305,12.205"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="17.2,12.2"/>
        <point val="19.3,11.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="1" to="O108" connection="0"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O69">
      <attribute name="obj_pos">
        <point val="15.1,12.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.095,11.595;17.205,12.205"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="15.1,12.2"/>
        <point val="17.2,11.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O70">
      <attribute name="obj_pos">
        <point val="13.9,12.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.895,11.595;15.105,12.205"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="13.9,12.2"/>
        <point val="15.1,11.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O71">
      <attribute name="obj_pos">
        <point val="1.7,15.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.695,15.795;2.605,15.805"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.7,15.8"/>
        <point val="2.6,15.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O72">
      <attribute name="obj_pos">
        <point val="1.7,13.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.695,13.395;2.605,13.405"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.7,13.4"/>
        <point val="2.6,13.4"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O73">
      <attribute name="obj_pos">
        <point val="3.1,14"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.095,13.995;4.405,14.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.1,14"/>
        <point val="4.4,14"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O74">
      <attribute name="obj_pos">
        <point val="3.1,15.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.095,15.195;4.405,15.205"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.1,15.2"/>
        <point val="4.4,15.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O75">
      <attribute name="obj_pos">
        <point val="3.1,11.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.095,11.595;4.405,11.605"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.1,11.6"/>
        <point val="4.4,11.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O76">
      <attribute name="obj_pos">
        <point val="3.1,12.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.095,12.795;4.405,12.805"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.1,12.8"/>
        <point val="4.4,12.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="1" to="O112" connection="0"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O77">
      <attribute name="obj_pos">
        <point val="4.4,10.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.395,10.195;19.305,10.205"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="4.4,10.2"/>
        <point val="19.3,10.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O78">
      <attribute name="obj_pos">
        <point val="12.7,13.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.695,12.795;13.905,13.405"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="12.7,13.4"/>
        <point val="13.9,12.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O79">
      <attribute name="obj_pos">
        <point val="17.2,13.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.195,12.795;19.305,13.405"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="17.2,13.4"/>
        <point val="19.3,12.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="1" to="O93" connection="0"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O80">
      <attribute name="obj_pos">
        <point val="15.1,13.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.095,12.795;17.205,13.405"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="15.1,13.4"/>
        <point val="17.2,12.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O81">
      <attribute name="obj_pos">
        <point val="13.9,13.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.895,12.795;15.105,13.405"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="13.9,13.4"/>
        <point val="15.1,12.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O82">
      <attribute name="obj_pos">
        <point val="12.7,14.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.695,13.995;13.905,14.605"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="12.7,14.6"/>
        <point val="13.9,14"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O83">
      <attribute name="obj_pos">
        <point val="17.2,14.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.195,13.995;19.305,14.605"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="17.2,14.6"/>
        <point val="19.3,14"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="1" to="O109" connection="0"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O84">
      <attribute name="obj_pos">
        <point val="15.1,14.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.095,13.995;17.205,14.605"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="15.1,14.6"/>
        <point val="17.2,14"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O85">
      <attribute name="obj_pos">
        <point val="13.9,14.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.895,13.995;15.105,14.605"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="13.9,14.6"/>
        <point val="15.1,14"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O86">
      <attribute name="obj_pos">
        <point val="12.7,15.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.695,15.195;13.905,15.805"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="12.7,15.8"/>
        <point val="13.9,15.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O87">
      <attribute name="obj_pos">
        <point val="17.2,15.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.195,15.195;19.305,15.805"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="17.2,15.8"/>
        <point val="19.3,15.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="1" to="O95" connection="0"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O88">
      <attribute name="obj_pos">
        <point val="15.1,15.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.095,15.195;17.205,15.805"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="15.1,15.8"/>
        <point val="17.2,15.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O89">
      <attribute name="obj_pos">
        <point val="13.9,15.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.895,15.195;15.105,15.805"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="13.9,15.8"/>
        <point val="15.1,15.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O90">
      <attribute name="obj_pos">
        <point val="8.7,11.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.695,10.995;10.605,11.605"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="8.7,11.6"/>
        <point val="10.6,11"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O91">
      <attribute name="obj_pos">
        <point val="2.6,13.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.595,12.195;2.605,13.405"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="2.6,13.4"/>
        <point val="2.6,12.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O92">
      <attribute name="obj_pos">
        <point val="2.6,15.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.595,14.595;2.605,15.805"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="2.6,15.8"/>
        <point val="2.6,14.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O93">
      <attribute name="obj_pos">
        <point val="19.3,13.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.295,12.195;19.305,13.405"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="19.3,13.4"/>
        <point val="19.3,12.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O94">
      <attribute name="obj_pos">
        <point val="19.3,11"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.295,9.795;19.305,11.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="19.3,11"/>
        <point val="19.3,9.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O95">
      <attribute name="obj_pos">
        <point val="19.3,15.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.295,14.595;19.305,15.805"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="19.3,15.8"/>
        <point val="19.3,14.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O96">
      <attribute name="obj_pos">
        <point val="4.4,11"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.385,10.985;19.315,11.015"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="4.4,11"/>
        <point val="19.3,11"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.03"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O97">
      <attribute name="obj_pos">
        <point val="4.4,12.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.385,12.185;19.315,12.215"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="4.4,12.2"/>
        <point val="19.3,12.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.03"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O98">
      <attribute name="obj_pos">
        <point val="4.4,13.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.385,13.385;19.315,13.415"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="4.4,13.4"/>
        <point val="19.3,13.4"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.03"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O99">
      <attribute name="obj_pos">
        <point val="4.4,14.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.385,14.585;19.315,14.615"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="4.4,14.6"/>
        <point val="19.3,14.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.03"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O100">
      <attribute name="obj_pos">
        <point val="4.4,15.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.395,15.795;19.305,15.805"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="4.4,15.8"/>
        <point val="19.3,15.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O101">
      <attribute name="obj_pos">
        <point val="2.6,14.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.585,14.585;4.415,14.615"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="2.6,14.6"/>
        <point val="4.4,14.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.03"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O102">
      <attribute name="obj_pos">
        <point val="2.6,12.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.585,12.185;4.415,12.215"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="2.6,12.2"/>
        <point val="4.4,12.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.03"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O103">
      <attribute name="obj_pos">
        <point val="2.6,15.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.595,15.795;4.405,15.805"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="2.6,15.8"/>
        <point val="4.4,15.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O104">
      <attribute name="obj_pos">
        <point val="2.6,13.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.585,13.385;4.415,13.415"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="2.6,13.4"/>
        <point val="4.4,13.4"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.03"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O105">
      <attribute name="obj_pos">
        <point val="2.6,11"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.585,10.985;4.415,11.015"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="2.6,11"/>
        <point val="4.4,11"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.03"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O106">
      <attribute name="obj_pos">
        <point val="2.6,12.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.585,10.985;2.615,12.215"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="2.6,12.2"/>
        <point val="2.6,11"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.03"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O107">
      <attribute name="obj_pos">
        <point val="2.6,14.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.585,13.385;2.615,14.615"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="2.6,14.6"/>
        <point val="2.6,13.4"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.03"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O108">
      <attribute name="obj_pos">
        <point val="19.3,12.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.285,10.985;19.315,12.215"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="19.3,12.2"/>
        <point val="19.3,11"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.03"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O109">
      <attribute name="obj_pos">
        <point val="19.3,14.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.285,13.385;19.315,14.615"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="19.3,14.6"/>
        <point val="19.3,13.4"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.03"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O110">
      <attribute name="obj_pos">
        <point val="1.7,15.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.695,9.795;1.705,15.805"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.7,15.8"/>
        <point val="1.7,9.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O111">
      <attribute name="obj_pos">
        <point val="3.1,15.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.095,10.995;3.105,15.805"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.1,15.8"/>
        <point val="3.1,11"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O112">
      <attribute name="obj_pos">
        <point val="4.4,15.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.395,9.795;4.405,15.805"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="4.4,15.8"/>
        <point val="4.4,9.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O113">
      <attribute name="obj_pos">
        <point val="5.6,15.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.595,10.195;5.605,15.805"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="5.6,15.8"/>
        <point val="5.6,10.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O114">
      <attribute name="obj_pos">
        <point val="6.8,15.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.795,10.195;6.805,15.805"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="6.8,15.8"/>
        <point val="6.8,10.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O115">
      <attribute name="obj_pos">
        <point val="8.7,15.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.695,10.195;8.705,15.805"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="8.7,15.8"/>
        <point val="8.7,10.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O116">
      <attribute name="obj_pos">
        <point val="10.6,15.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.595,10.195;10.605,15.805"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="10.6,15.8"/>
        <point val="10.6,10.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O117">
      <attribute name="obj_pos">
        <point val="12.7,15.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.695,9.795;12.705,15.805"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="12.7,15.8"/>
        <point val="12.7,9.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O118">
      <attribute name="obj_pos">
        <point val="13.9,15.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.895,10.195;13.905,15.805"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="13.9,15.8"/>
        <point val="13.9,10.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O119">
      <attribute name="obj_pos">
        <point val="15.1,15.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.095,10.195;15.105,15.805"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="15.1,15.8"/>
        <point val="15.1,10.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O120">
      <attribute name="obj_pos">
        <point val="17.2,15.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.195,10.195;17.205,15.805"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="17.2,15.8"/>
        <point val="17.2,10.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O121">
      <attribute name="obj_pos">
        <point val="1.7,9.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.695,9.795;4.405,9.805"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.7,9.8"/>
        <point val="4.4,9.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O122">
      <attribute name="obj_pos">
        <point val="4.4,9.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.395,9.795;19.305,9.805"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="4.4,9.8"/>
        <point val="19.3,9.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O123">
      <attribute name="obj_pos">
        <point val="6.8,27.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.795,27.195;19.305,27.205"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="6.8,27.2"/>
        <point val="19.3,27.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O124">
      <attribute name="obj_pos">
        <point val="1.7,25.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.695,16.595;1.705,25.205"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.7,25.2"/>
        <point val="1.7,16.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O125">
      <attribute name="obj_pos">
        <point val="1.7,16.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.695,16.595;19.305,16.605"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.7,16.6"/>
        <point val="19.3,16.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O126">
      <attribute name="obj_pos">
        <point val="19.3,25.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.295,16.595;19.305,25.205"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="19.3,25.2"/>
        <point val="19.3,16.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O127">
      <attribute name="obj_pos">
        <point val="10.6,26.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.595,26.595;13.905,26.605"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="10.6,26.6"/>
        <point val="13.9,26.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O133" connection="0"/>
        <connection handle="1" to="O135" connection="0"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O128">
      <attribute name="obj_pos">
        <point val="6.8,26"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.795,25.995;19.305,26.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="6.8,26"/>
        <point val="19.3,26"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O129">
      <attribute name="obj_pos">
        <point val="1.7,25.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.695,25.195;19.305,25.205"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.7,25.2"/>
        <point val="19.3,25.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O130">
      <attribute name="obj_pos">
        <point val="19.3,27.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.295,25.995;19.305,27.205"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="19.3,27.2"/>
        <point val="19.3,26"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O131">
      <attribute name="obj_pos">
        <point val="6.8,27.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.795,25.995;6.805,27.205"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="6.8,27.2"/>
        <point val="6.8,26"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O132">
      <attribute name="obj_pos">
        <point val="8.7,27.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.695,25.995;8.705,27.205"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="8.7,27.2"/>
        <point val="8.7,26"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O133">
      <attribute name="obj_pos">
        <point val="10.6,27.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.595,25.995;10.605,27.205"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="10.6,27.2"/>
        <point val="10.6,26"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O134">
      <attribute name="obj_pos">
        <point val="15.1,27.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.095,25.995;15.105,27.205"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="15.1,27.2"/>
        <point val="15.1,26"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O135">
      <attribute name="obj_pos">
        <point val="13.9,27.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.895,25.995;13.905,27.205"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="13.9,27.2"/>
        <point val="13.9,26"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O136">
      <attribute name="obj_pos">
        <point val="15.1,26.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.095,26.595;19.305,26.605"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="15.1,26.6"/>
        <point val="19.3,26.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
      <connections>
        <connection handle="0" to="O134" connection="0"/>
        <connection handle="1" to="O130" connection="0"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O137">
      <attribute name="obj_pos">
        <point val="11.4,27.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="11.395,25.995;11.405,27.205"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="11.4,27.2"/>
        <point val="11.4,26"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O138">
      <attribute name="obj_pos">
        <point val="15.9,27.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.895,25.995;15.905,27.205"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="15.9,27.2"/>
        <point val="15.9,26"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O139">
      <attribute name="obj_pos">
        <point val="1.7,3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.695,2.995;4.405,3.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="1.7,3"/>
        <point val="4.4,3"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O140">
      <attribute name="obj_pos">
        <point val="4.4,3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.395,2.995;19.305,3.005"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="4.4,3"/>
        <point val="19.3,3"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0.01"/>
      </attribute>
    </object>
  </layer>
  <layer name="&#202;&#184;&#187;&#250;" visible="true">
    <object type="Standard - Text" version="0" id="O141">
      <attribute name="obj_pos">
        <point val="2.2,28.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.2,28.0919;9.27,28.3719"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#200;&#247;&#185;&#205;&#161;&#161;&#164;&#179;&#164;&#206;&#205;&#209;&#187;&#230;&#164;&#207;&#161;&#162;&#198;&#252;&#203;&#220;&#185;&#169;&#182;&#200;&#181;&#172;&#179;&#202;&#163;&#193;&#206;&#243;&#163;&#180;&#200;&#214;&#164;&#200;&#164;&#185;&#164;&#235;&#164;&#179;&#164;&#200;&#161;&#163;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="2.2,28.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O142">
      <attribute name="obj_pos">
        <point val="6.35,27.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.35,27.6919;19.9244,27.9719"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#195;&#237;&#176;&#213;&#161;&#161;&#162;&#168;&#176;&#245;&#164;&#206;&#205;&#243;&#164;&#207;&#181;&#173;&#198;&#254;&#164;&#183;&#164;&#202;&#164;&#164;&#164;&#179;&#164;&#200;&#161;&#163;&#161;&#214;&#176;&#236;&#201;&#244;&#201;&#233;&#195;&#180;&#182;&#226;&#161;&#215;&#164;&#206;&#185;&#224;&#164;&#207;&#161;&#162;&#204;&#244;&#186;&#222;&#176;&#236;&#201;&#244;&#201;&#233;&#195;&#180;&#182;&#226;&#164;&#242;&#189;&#252;&#164;&#164;&#164;&#191;&#182;&#226;&#179;&#219;&#164;&#242;&#181;&#173;&#186;&#220;&#164;&#185;&#164;&#235;&#164;&#179;&#164;&#200;&#161;&#163;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="6.35,27.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O143">
      <attribute name="obj_pos">
        <point val="4.725,3.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.725,3.69186;5.2906,3.97186"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#183;&#239;&#191;&#244;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="4.725,3.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O144">
      <attribute name="obj_pos">
        <point val="5.775,3.75"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.775,3.54186;6.6234,4.10186"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#191;&#199;&#161;&#161;&#206;&#197;
&#188;&#194;&#198;&#252;&#191;&#244;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="5.775,3.75"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O145">
      <attribute name="obj_pos">
        <point val="7.375,3.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.375,3.69186;7.9406,3.97186"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#197;&#192;&#191;&#244;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="7.375,3.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O146">
      <attribute name="obj_pos">
        <point val="10.025,3.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.025,3.69186;11.439,3.97186"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#176;&#236;&#201;&#244;&#201;&#233;&#195;&#180;&#182;&#226;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="10.025,3.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O147">
      <attribute name="obj_pos">
        <point val="13.025,3.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.025,3.69186;13.5906,3.97186"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#183;&#239;&#191;&#244;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="13.025,3.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O148">
      <attribute name="obj_pos">
        <point val="14.225,3.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.225,3.69186;14.7906,3.97186"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#198;&#252;&#191;&#244;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="14.225,3.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O149">
      <attribute name="obj_pos">
        <point val="15.875,3.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.875,3.69186;16.4406,3.97186"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#182;&#226;&#179;&#219;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="15.875,3.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O150">
      <attribute name="obj_pos">
        <point val="17.575,3.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.575,3.69186;18.989,3.97186"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#201;&#184;&#189;&#224;&#201;&#233;&#195;&#180;&#179;&#219;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="17.575,3.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O151">
      <attribute name="obj_pos">
        <point val="2.525,3.73125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.525,3.52311;3.6562,3.80311"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#182;&#232;&#161;&#161;&#161;&#161;&#202;&#172;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="2.525,3.73125"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O152">
      <attribute name="obj_pos">
        <point val="1.7,2.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.7,2.69186;2.8312,2.97186"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#207;&#183;&#191;&#205;&#202;&#221;&#183;&#242;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="1.7,2.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O153">
      <attribute name="obj_pos">
        <point val="13.5,2.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.5,1.99186;15.4796,2.27186"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#176;&#229;&#206;&#197;&#181;&#161;&#180;&#216;&#165;&#179;&#161;&#188;&#165;&#201;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="13.5,2.2"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O154">
      <attribute name="obj_pos">
        <point val="2,7.45"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2,7.24186;2.2828,8.36186"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#207;&#183;
&#191;&#205;
&#200;&#172;
&#179;&#228;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="2,7.45"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O155">
      <attribute name="obj_pos">
        <point val="12.35,4.61875"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.35,4.41061;12.6328,4.69061"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#177;&#223;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="12.35,4.61875"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O156">
      <attribute name="obj_pos">
        <point val="16.85,4.61875"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.85,4.41061;17.1328,4.69061"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#177;&#223;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="16.85,4.61875"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O157">
      <attribute name="obj_pos">
        <point val="18.95,4.61875"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.95,4.41061;19.2328,4.69061"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#177;&#223;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="18.95,4.61875"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O158">
      <attribute name="obj_pos">
        <point val="3.18125,8.81875"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.18125,8.61061;4.02965,8.89061"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#198;&#254;&#177;&#161;&#179;&#176;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="3.18125,8.81875"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O159">
      <attribute name="obj_pos">
        <point val="3.18125,8.21875"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.18125,8.01061;3.74685,8.29061"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#198;&#254;&#177;&#161;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="3.18125,8.21875"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O160">
      <attribute name="obj_pos">
        <point val="2.7,8.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.7,7.99186;2.9828,8.83186"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#162;&#168;
&#183;&#232;
&#196;&#234;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="2.7,8.2"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O161">
      <attribute name="obj_pos">
        <point val="2.7,7.15"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.7,6.94186;2.9828,7.50186"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#192;&#193;
&#181;&#225;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="2.7,7.15"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O162">
      <attribute name="obj_pos">
        <point val="3.18125,7.61875"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.18125,7.41061;4.02965,7.69061"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#198;&#254;&#177;&#161;&#179;&#176;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="3.18125,7.61875"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O163">
      <attribute name="obj_pos">
        <point val="3.18125,7.01875"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.18125,6.81061;3.74685,7.09061"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#198;&#254;&#177;&#161;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="3.18125,7.01875"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O164">
      <attribute name="obj_pos">
        <point val="3.18125,6.41875"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.18125,6.21061;4.02965,6.49061"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#198;&#254;&#177;&#161;&#179;&#176;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="3.18125,6.41875"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O165">
      <attribute name="obj_pos">
        <point val="3.18125,5.81875"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.18125,5.61061;3.74685,5.89061"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#198;&#254;&#177;&#161;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="3.18125,5.81875"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O166">
      <attribute name="obj_pos">
        <point val="2.7,5.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.7,5.59186;2.9828,6.43186"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#162;&#168;
&#183;&#232;
&#196;&#234;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="2.7,5.8"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O167">
      <attribute name="obj_pos">
        <point val="2.7,4.75"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.7,4.54186;2.9828,5.10186"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#192;&#193;
&#181;&#225;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="2.7,4.75"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O168">
      <attribute name="obj_pos">
        <point val="3.18125,5.21875"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.18125,5.01061;4.02965,5.29061"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#198;&#254;&#177;&#161;&#179;&#176;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="3.18125,5.21875"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O169">
      <attribute name="obj_pos">
        <point val="3.18125,4.61875"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.18125,4.41061;3.74685,4.69061"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#198;&#254;&#177;&#161;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="3.18125,4.61875"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O170">
      <attribute name="obj_pos">
        <point val="2,5.05"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2,4.84186;2.2828,5.96186"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#207;&#183;
&#191;&#205;
&#182;&#229;
&#179;&#228;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="2,5.05"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O171">
      <attribute name="obj_pos">
        <point val="4.725,10.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.725,10.4919;5.2906,10.7719"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#183;&#239;&#191;&#244;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="4.725,10.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O172">
      <attribute name="obj_pos">
        <point val="5.775,10.55"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.775,10.3419;6.6234,10.9019"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#191;&#199;&#161;&#161;&#206;&#197;
&#188;&#194;&#198;&#252;&#191;&#244;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="5.775,10.55"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O173">
      <attribute name="obj_pos">
        <point val="7.375,10.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.375,10.4919;7.9406,10.7719"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#197;&#192;&#191;&#244;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="7.375,10.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O174">
      <attribute name="obj_pos">
        <point val="10.925,10.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.925,10.4919;12.339,10.7719"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#176;&#236;&#201;&#244;&#201;&#233;&#195;&#180;&#182;&#226;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="10.925,10.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O175">
      <attribute name="obj_pos">
        <point val="13.025,10.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.025,10.4919;13.5906,10.7719"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#183;&#239;&#191;&#244;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="13.025,10.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O176">
      <attribute name="obj_pos">
        <point val="14.225,10.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.225,10.4919;14.7906,10.7719"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#198;&#252;&#191;&#244;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="14.225,10.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O177">
      <attribute name="obj_pos">
        <point val="15.875,10.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.875,10.4919;16.4406,10.7719"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#182;&#226;&#179;&#219;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="15.875,10.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O178">
      <attribute name="obj_pos">
        <point val="17.575,10.55"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.575,10.3419;18.989,10.9019"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#201;&#184;&#189;&#224;&#201;&#233;&#195;&#180;&#179;&#219;
&#161;&#202;&#184;&#248;&#200;&#241;&#202;&#172;&#161;&#203;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="17.575,10.55"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O179">
      <attribute name="obj_pos">
        <point val="1.7,9.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.7,9.49186;3.3968,9.77186"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#184;&#248;&#200;&#241;&#201;&#233;&#195;&#180;&#176;&#229;&#206;&#197;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="1.7,9.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <group>
      <object type="Standard - Text" version="0" id="O180">
        <attribute name="obj_pos">
          <point val="9.825,10.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="9.825,10.6419;10.1078,10.9219"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#&#195;&#180;#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.28"/>
            </attribute>
            <attribute name="pos">
              <point val="9.825,10.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="0"/>
            </attribute>
            <attribute name="single">
              <real val="0.16968"/>
            </attribute>
            <attribute name="multi">
              <real val="0.1414"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Standard - Text" version="0" id="O181">
        <attribute name="obj_pos">
          <point val="10.1,10.55"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.1,10.3419;10.3828,10.6219"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#&#186;&#222;#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.28"/>
            </attribute>
            <attribute name="pos">
              <point val="10.1,10.55"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="0"/>
            </attribute>
            <attribute name="single">
              <real val="0.16968"/>
            </attribute>
            <attribute name="multi">
              <real val="0.1414"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Standard - Text" version="0" id="O182">
        <attribute name="obj_pos">
          <point val="9,10.55"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="9,10.3419;9.2828,10.6219"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#&#204;&#244;#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.28"/>
            </attribute>
            <attribute name="pos">
              <point val="9,10.55"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="0"/>
            </attribute>
            <attribute name="single">
              <real val="0.16968"/>
            </attribute>
            <attribute name="multi">
              <real val="0.1414"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Standard - Text" version="0" id="O183">
        <attribute name="obj_pos">
          <point val="10.1,10.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="10.1,10.6419;10.3828,10.9219"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#&#182;&#226;#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.28"/>
            </attribute>
            <attribute name="pos">
              <point val="10.1,10.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="0"/>
            </attribute>
            <attribute name="single">
              <real val="0.16968"/>
            </attribute>
            <attribute name="multi">
              <real val="0.1414"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Standard - Text" version="0" id="O184">
        <attribute name="obj_pos">
          <point val="9,10.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="9,10.6419;9.2828,10.9219"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#&#176;&#236;#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.28"/>
            </attribute>
            <attribute name="pos">
              <point val="9,10.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="0"/>
            </attribute>
            <attribute name="single">
              <real val="0.16968"/>
            </attribute>
            <attribute name="multi">
              <real val="0.1414"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Standard - Text" version="0" id="O185">
        <attribute name="obj_pos">
          <point val="9.275,10.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="9.275,10.6419;9.5578,10.9219"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#&#201;&#244;#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.28"/>
            </attribute>
            <attribute name="pos">
              <point val="9.275,10.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="0"/>
            </attribute>
            <attribute name="single">
              <real val="0.16968"/>
            </attribute>
            <attribute name="multi">
              <real val="0.1414"/>
            </attribute>
          </composite>
        </attribute>
      </object>
      <object type="Standard - Text" version="0" id="O186">
        <attribute name="obj_pos">
          <point val="9.55,10.85"/>
        </attribute>
        <attribute name="obj_bb">
          <rectangle val="9.55,10.6419;9.8328,10.9219"/>
        </attribute>
        <attribute name="text">
          <composite type="text">
            <attribute name="string">
              <string>#&#201;&#233;#</string>
            </attribute>
            <attribute name="font">
              <font name="Courier"/>
            </attribute>
            <attribute name="height">
              <real val="0.28"/>
            </attribute>
            <attribute name="pos">
              <point val="9.55,10.85"/>
            </attribute>
            <attribute name="color">
              <color val="#000000"/>
            </attribute>
            <attribute name="alignment">
              <enum val="0"/>
            </attribute>
            <attribute name="single">
              <real val="0.16968"/>
            </attribute>
            <attribute name="multi">
              <real val="0.1414"/>
            </attribute>
          </composite>
        </attribute>
      </object>
    </group>
    <object type="Standard - Text" version="0" id="O187">
      <attribute name="obj_pos">
        <point val="12.35,11.4188"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.35,11.2107;12.6328,11.4907"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#177;&#223;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="12.35,11.4188"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O188">
      <attribute name="obj_pos">
        <point val="16.85,11.4188"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.85,11.2107;17.1328,11.4907"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#177;&#223;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="16.85,11.4188"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O189">
      <attribute name="obj_pos">
        <point val="18.95,11.4188"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.95,11.2107;19.2328,11.4907"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#177;&#223;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="18.95,11.4188"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O190">
      <attribute name="obj_pos">
        <point val="3.18125,15.6187"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.18125,15.4106;4.02965,15.6906"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#198;&#254;&#177;&#161;&#179;&#176;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="3.18125,15.6187"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O191">
      <attribute name="obj_pos">
        <point val="3.18125,15.0187"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.18125,14.8106;3.74685,15.0906"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#198;&#254;&#177;&#161;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="3.18125,15.0187"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O192">
      <attribute name="obj_pos">
        <point val="2.7,15"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.7,14.7919;2.9828,15.6319"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#162;&#168;
&#183;&#232;
&#196;&#234;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="2.7,15"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O193">
      <attribute name="obj_pos">
        <point val="2.7,13.95"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.7,13.7419;2.9828,14.3019"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#192;&#193;
&#181;&#225;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="2.7,13.95"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O194">
      <attribute name="obj_pos">
        <point val="3.18125,14.4187"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.18125,14.2106;4.02965,14.4906"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#198;&#254;&#177;&#161;&#179;&#176;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="3.18125,14.4187"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O195">
      <attribute name="obj_pos">
        <point val="3.18125,13.8187"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.18125,13.6106;3.74685,13.8906"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#198;&#254;&#177;&#161;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="3.18125,13.8187"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O196">
      <attribute name="obj_pos">
        <point val="3.18125,13.2187"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.18125,13.0106;4.02965,13.2906"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#198;&#254;&#177;&#161;&#179;&#176;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="3.18125,13.2187"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O197">
      <attribute name="obj_pos">
        <point val="3.18125,12.6187"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.18125,12.4106;3.74685,12.6906"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#198;&#254;&#177;&#161;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="3.18125,12.6187"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O198">
      <attribute name="obj_pos">
        <point val="2.7,12.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.7,12.3919;2.9828,13.2319"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#162;&#168;
&#183;&#232;
&#196;&#234;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="2.7,12.6"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O199">
      <attribute name="obj_pos">
        <point val="2.7,11.55"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.7,11.3419;2.9828,11.9019"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#192;&#193;
&#181;&#225;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="2.7,11.55"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O200">
      <attribute name="obj_pos">
        <point val="3.18125,12.0187"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.18125,11.8106;4.02965,12.0906"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#198;&#254;&#177;&#161;&#179;&#176;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="3.18125,12.0187"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O201">
      <attribute name="obj_pos">
        <point val="3.18125,11.4187"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.18125,11.2106;3.74685,11.4906"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#198;&#254;&#177;&#161;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="3.18125,11.4187"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O202">
      <attribute name="obj_pos">
        <point val="7.225,10.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.225,9.89186;9.7702,10.1719"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#206;&#197;&#161;&#161;&#205;&#220;&#161;&#161;&#164;&#206;&#161;&#161;&#181;&#235;&#161;&#161;&#201;&#213;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="7.225,10.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O203">
      <attribute name="obj_pos">
        <point val="14.825,10.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.825,9.89186;16.8046,10.1719"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#191;&#169;&#161;&#161;&#187;&#246;&#161;&#161;&#206;&#197;&#161;&#161;&#205;&#220;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="14.825,10.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O204">
      <attribute name="obj_pos">
        <point val="2.2,16.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.2,16.6919;3.0484,16.9719"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#200;&#247;&#161;&#161;&#185;&#205;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="2.2,16.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O205">
      <attribute name="obj_pos">
        <point val="6.9,26.6875"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.9,26.4794;8.5968,26.7594"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#162;&#168;&#185;&#226;&#179;&#219;&#206;&#197;&#205;&#220;&#200;&#241;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="6.9,26.6875"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O206">
      <attribute name="obj_pos">
        <point val="8.8,26.6875"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.8,26.4794;10.4968,26.7594"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#176;&#236;&#200;&#204;&#200;&#239;&#202;&#221;&#184;&#177;&#188;&#212;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="8.8,26.6875"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O207">
      <attribute name="obj_pos">
        <point val="10.75,26.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.75,26.1919;11.3156,26.4719"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#183;&#239;&#191;&#244;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="10.75,26.4"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O208">
      <attribute name="obj_pos">
        <point val="10.75,27"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.75,26.7919;11.3156,27.0719"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#182;&#226;&#179;&#219;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="10.75,27"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O209">
      <attribute name="obj_pos">
        <point val="13.55,27.0125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.55,26.8044;13.8328,27.0844"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#177;&#223;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="13.55,27.0125"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O210">
      <attribute name="obj_pos">
        <point val="15.25,26.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.25,26.1919;15.8156,26.4719"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#183;&#239;&#191;&#244;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="15.25,26.4"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O211">
      <attribute name="obj_pos">
        <point val="15.25,27"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.25,26.7919;15.8156,27.0719"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#182;&#226;&#179;&#219;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="15.25,27"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O212">
      <attribute name="obj_pos">
        <point val="18.95,27.0125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.95,26.8044;19.2328,27.0844"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#177;&#223;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="18.95,27.0125"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O213">
      <attribute name="obj_pos">
        <point val="14.1,26.6875"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.1,26.4794;14.9484,26.7594"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#194;&#224;&#191;&#166;&#188;&#212;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="14.1,26.6875"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O214">
      <attribute name="obj_pos">
        <point val="10.25,12.0188"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.25,11.8107;10.5328,12.0907"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#177;&#223;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="10.25,12.0188"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O215">
      <attribute name="obj_pos">
        <point val="7.225,3.3125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.225,3.10436;9.7702,3.38436"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#206;&#197;&#161;&#161;&#205;&#220;&#161;&#161;&#164;&#206;&#161;&#161;&#181;&#235;&#161;&#161;&#201;&#213;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="7.225,3.3125"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O216">
      <attribute name="obj_pos">
        <point val="14.825,3.3125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.825,3.10436;16.8046,3.38436"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#191;&#169;&#161;&#161;&#187;&#246;&#161;&#161;&#206;&#197;&#161;&#161;&#205;&#220;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="14.825,3.3125"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Standard - Text" version="0" id="O217">
      <attribute name="obj_pos">
        <point val="2.525,10.5312"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2.525,10.3231;3.6562,10.6031"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#182;&#232;&#161;&#161;&#161;&#161;&#202;&#172;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="2.525,10.5312"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
  </layer>
  <layer name="&#186;&#185;&#164;&#183;&#185;&#254;&#164;&#223;" visible="true">
    <object type="Embed - Text" version="0" id="O218">
      <attribute name="obj_pos">
        <point val="15.65,2.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.65,1.97699;16.7408,2.27699"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HOSPCD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#123456#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="15.65,2.2"/>
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
    <object type="Embed - Text" version="0" id="O219">
      <attribute name="obj_pos">
        <point val="5.55,4.6125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.641,4.38949;5.55,4.68949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKN-TBL.HKN-TBLG[0].HKN-G[0].KENSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#KENSU#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="5.55,4.6125"/>
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
    <object type="Embed - Text" version="0" id="O220">
      <attribute name="obj_pos">
        <point val="6.75,4.6125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.841,4.38949;6.75,4.68949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKN-TBL.HKN-TBLG[0].HKN-G[0].NISSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#NISSU#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.75,4.6125"/>
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
    <object type="Embed - Text" version="0" id="O221">
      <attribute name="obj_pos">
        <point val="8.65,4.6125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.741,4.38949;8.65,4.68949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKN-TBL.HKN-TBLG[0].HKN-G[0].TENSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#TENSU#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="8.65,4.6125"/>
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
    <object type="Embed - Text" version="0" id="O222">
      <attribute name="obj_pos">
        <point val="10.2,4.6125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.1092,4.38949;10.2,4.68949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKN-TBL.HKN-TBLG[0].HKN-G[0].YKZFTN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#YKZFTN#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="10.2,4.6125"/>
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
    <object type="Embed - Text" version="0" id="O223">
      <attribute name="obj_pos">
        <point val="12.3,4.6125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="11.2092,4.38949;12.3,4.68949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKN-TBL.HKN-TBLG[0].HKN-G[0].ITBFTN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#ITBFTN#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="12.3,4.6125"/>
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
    <object type="Embed - Text" version="0" id="O224">
      <attribute name="obj_pos">
        <point val="13.85,4.6125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.3956,4.38949;13.85,4.68949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#SYO-TBL.SYO-TBLG[3].SYOKENSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#SYOKENSU#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="13.85,4.6125"/>
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
    <object type="Embed - Text" version="0" id="O225">
      <attribute name="obj_pos">
        <point val="15.05,4.6125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.5956,4.38949;15.05,4.68949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#SYO-TBL.SYO-TBLG[0].SYONISSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#SYONISSU#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="15.05,4.6125"/>
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
    <object type="Embed - Text" version="0" id="O226">
      <attribute name="obj_pos">
        <point val="16.8,4.6125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.1638,4.38949;16.8,4.68949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#SYO-TBL.SYO-TBLG[0].SYOKINGAK#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#SYOKINGAK#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="16.8,4.6125"/>
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
    <object type="Embed - Text" version="0" id="O227">
      <attribute name="obj_pos">
        <point val="18.9,4.6125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.2638,4.38949;18.9,4.68949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#SYO-TBL.SYO-TBLG[0].SYOFTNGAK#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#SYOFTNGAK#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="18.9,4.6125"/>
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
    <object type="Embed - Text" version="0" id="O228">
      <attribute name="obj_pos">
        <point val="5.55,5.2125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.641,4.98949;5.55,5.28949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKN-TBL.HKN-TBLG[0].HKN-G[1].KENSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#KENSU#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="5.55,5.2125"/>
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
    <object type="Embed - Text" version="0" id="O229">
      <attribute name="obj_pos">
        <point val="6.75,5.2125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.841,4.98949;6.75,5.28949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKN-TBL.HKN-TBLG[0].HKN-G[1].NISSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#NISSU#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.75,5.2125"/>
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
    <object type="Embed - Text" version="0" id="O230">
      <attribute name="obj_pos">
        <point val="8.65,5.2125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.741,4.98949;8.65,5.28949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKN-TBL.HKN-TBLG[0].HKN-G[1].TENSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#TENSU#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="8.65,5.2125"/>
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
    <object type="Embed - Text" version="0" id="O231">
      <attribute name="obj_pos">
        <point val="10.2,5.2125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.1092,4.98949;10.2,5.28949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKN-TBL.HKN-TBLG[0].HKN-G[1].YKZFTN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#YKZFTN#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="10.2,5.2125"/>
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
    <object type="Embed - Text" version="0" id="O232">
      <attribute name="obj_pos">
        <point val="12.3,5.2125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="11.2092,4.98949;12.3,5.28949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKN-TBL.HKN-TBLG[0].HKN-G[1].ITBFTN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#ITBFTN#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="12.3,5.2125"/>
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
    <object type="Embed - Text" version="0" id="O233">
      <attribute name="obj_pos">
        <point val="13.85,7.0125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.3956,6.78949;13.85,7.08949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#SYO-TBL.SYO-TBLG[0].SYOKENSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#SYOKENSU#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="13.85,7.0125"/>
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
    <object type="Embed - Text" version="0" id="O234">
      <attribute name="obj_pos">
        <point val="15.05,7.0125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.5956,6.78949;15.05,7.08949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#SYO-TBL.SYO-TBLG[1].SYONISSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#SYONISSU#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="15.05,7.0125"/>
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
    <object type="Embed - Text" version="0" id="O235">
      <attribute name="obj_pos">
        <point val="16.8,7.0125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.1638,6.78949;16.8,7.08949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#SYO-TBL.SYO-TBLG[1].SYOKINGAK#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#SYOKINGAK#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="16.8,7.0125"/>
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
    <object type="Embed - Text" version="0" id="O236">
      <attribute name="obj_pos">
        <point val="18.9,7.0125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.2638,6.78949;18.9,7.08949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#SYO-TBL.SYO-TBLG[1].SYOFTNGAK#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#SYOFTNGAK#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="18.9,7.0125"/>
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
    <object type="Embed - Text" version="0" id="O237">
      <attribute name="obj_pos">
        <point val="5.55,7.0125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.641,6.78949;5.55,7.08949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKN-TBL.HKN-TBLG[1].HKN-G[0].KENSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#KENSU#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="5.55,7.0125"/>
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
    <object type="Embed - Text" version="0" id="O238">
      <attribute name="obj_pos">
        <point val="6.75,7.0125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.841,6.78949;6.75,7.08949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKN-TBL.HKN-TBLG[1].HKN-G[0].NISSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#NISSU#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.75,7.0125"/>
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
    <object type="Embed - Text" version="0" id="O239">
      <attribute name="obj_pos">
        <point val="8.65,7.0125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.741,6.78949;8.65,7.08949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKN-TBL.HKN-TBLG[1].HKN-G[0].TENSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#TENSU#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="8.65,7.0125"/>
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
    <object type="Embed - Text" version="0" id="O240">
      <attribute name="obj_pos">
        <point val="10.2,7.0125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.1092,6.78949;10.2,7.08949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKN-TBL.HKN-TBLG[1].HKN-G[0].YKZFTN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#YKZFTN#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="10.2,7.0125"/>
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
    <object type="Embed - Text" version="0" id="O241">
      <attribute name="obj_pos">
        <point val="12.3,7.0125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="11.2092,6.78949;12.3,7.08949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKN-TBL.HKN-TBLG[1].HKN-G[0].ITBFTN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#ITBFTN#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="12.3,7.0125"/>
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
    <object type="Embed - Text" version="0" id="O242">
      <attribute name="obj_pos">
        <point val="13.85,11.4125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.3956,11.1895;13.85,11.4895"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#SYO-TBL.SYO-TBLG[1].SYOKENSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#SYOKENSU#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="13.85,11.4125"/>
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
    <object type="Embed - Text" version="0" id="O243">
      <attribute name="obj_pos">
        <point val="15.05,11.4125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.5956,11.1895;15.05,11.4895"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#SYO-TBL.SYO-TBLG[2].SYONISSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#SYONISSU#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="15.05,11.4125"/>
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
    <object type="Embed - Text" version="0" id="O244">
      <attribute name="obj_pos">
        <point val="16.8,11.4125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.1638,11.1895;16.8,11.4895"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#SYO-TBL.SYO-TBLG[2].SYOKINGAK#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#SYOKINGAK#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="16.8,11.4125"/>
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
    <object type="Embed - Text" version="0" id="O245">
      <attribute name="obj_pos">
        <point val="18.9,11.4125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.2638,11.1895;18.9,11.4895"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#SYO-TBL.SYO-TBLG[2].SYOFTNGAK#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#SYOFTNGAK#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="18.9,11.4125"/>
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
    <object type="Embed - Text" version="0" id="O246">
      <attribute name="obj_pos">
        <point val="5.55,7.6125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.641,7.38949;5.55,7.68949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKN-TBL.HKN-TBLG[1].HKN-G[1].KENSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#KENSU#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="5.55,7.6125"/>
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
    <object type="Embed - Text" version="0" id="O247">
      <attribute name="obj_pos">
        <point val="6.75,7.6125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.841,7.38949;6.75,7.68949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKN-TBL.HKN-TBLG[1].HKN-G[1].NISSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#NISSU#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.75,7.6125"/>
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
    <object type="Embed - Text" version="0" id="O248">
      <attribute name="obj_pos">
        <point val="8.65,7.6125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.741,7.38949;8.65,7.68949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKN-TBL.HKN-TBLG[1].HKN-G[1].TENSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#TENSU#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="8.65,7.6125"/>
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
    <object type="Embed - Text" version="0" id="O249">
      <attribute name="obj_pos">
        <point val="10.2,7.6125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.1092,7.38949;10.2,7.68949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKN-TBL.HKN-TBLG[1].HKN-G[1].YKZFTN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#YKZFTN#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="10.2,7.6125"/>
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
    <object type="Embed - Text" version="0" id="O250">
      <attribute name="obj_pos">
        <point val="12.3,7.6125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="11.2092,7.38949;12.3,7.68949"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKN-TBL.HKN-TBLG[1].HKN-G[1].ITBFTN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#ITBFTN#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="12.3,7.6125"/>
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
    <object type="Embed - Text" version="0" id="O251">
      <attribute name="obj_pos">
        <point val="13.85,13.8125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.3956,13.5895;13.85,13.8895"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#SYO-TBL.SYO-TBLG[2].SYOKENSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#SYOKENSU#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="13.85,13.8125"/>
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
    <object type="Embed - Text" version="0" id="O252">
      <attribute name="obj_pos">
        <point val="15.05,13.8125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.5956,13.5895;15.05,13.8895"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#SYO-TBL.SYO-TBLG[3].SYONISSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#SYONISSU#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="15.05,13.8125"/>
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
    <object type="Embed - Text" version="0" id="O253">
      <attribute name="obj_pos">
        <point val="16.8,13.8125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.1638,13.5895;16.8,13.8895"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#SYO-TBL.SYO-TBLG[3].SYOKINGAK#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#SYOKINGAK#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="16.8,13.8125"/>
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
    <object type="Embed - Text" version="0" id="O254">
      <attribute name="obj_pos">
        <point val="18.9,13.8125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.2638,13.5895;18.9,13.8895"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#SYO-TBL.SYO-TBLG[3].SYOFTNGAK#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#SYOFTNGAK#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="18.9,13.8125"/>
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
    <object type="Embed - Text" version="0" id="O255">
      <attribute name="obj_pos">
        <point val="5.55,11.4125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.641,11.1895;5.55,11.4895"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKN-TBL.HKN-TBLG[2].HKN-G[0].KENSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#KENSU#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="5.55,11.4125"/>
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
    <object type="Embed - Text" version="0" id="O256">
      <attribute name="obj_pos">
        <point val="6.75,11.4125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.841,11.1895;6.75,11.4895"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKN-TBL.HKN-TBLG[2].HKN-G[0].NISSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#NISSU#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.75,11.4125"/>
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
    <object type="Embed - Text" version="0" id="O257">
      <attribute name="obj_pos">
        <point val="8.65,11.4125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.741,11.1895;8.65,11.4895"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKN-TBL.HKN-TBLG[2].HKN-G[0].TENSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#TENSU#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="8.65,11.4125"/>
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
    <object type="Embed - Text" version="0" id="O258">
      <attribute name="obj_pos">
        <point val="10.2,11.4125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.1092,11.1895;10.2,11.4895"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKN-TBL.HKN-TBLG[2].HKN-G[0].YKZFTN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#YKZFTN#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="10.2,11.4125"/>
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
    <object type="Embed - Text" version="0" id="O259">
      <attribute name="obj_pos">
        <point val="12.3,11.4125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="11.2092,11.1895;12.3,11.4895"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKN-TBL.HKN-TBLG[2].HKN-G[0].ITBFTN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#ITBFTN#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="12.3,11.4125"/>
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
    <object type="Embed - Text" version="0" id="O260">
      <attribute name="obj_pos">
        <point val="5.55,12.0125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.641,11.7895;5.55,12.0895"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKN-TBL.HKN-TBLG[2].HKN-G[1].KENSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#KENSU#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="5.55,12.0125"/>
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
    <object type="Embed - Text" version="0" id="O261">
      <attribute name="obj_pos">
        <point val="6.75,12.0125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.841,11.7895;6.75,12.0895"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKN-TBL.HKN-TBLG[2].HKN-G[1].NISSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#NISSU#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.75,12.0125"/>
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
    <object type="Embed - Text" version="0" id="O262">
      <attribute name="obj_pos">
        <point val="8.65,12.0125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.741,11.7895;8.65,12.0895"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKN-TBL.HKN-TBLG[2].HKN-G[1].TENSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#TENSU#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="8.65,12.0125"/>
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
    <object type="Embed - Text" version="0" id="O263">
      <attribute name="obj_pos">
        <point val="10.2,12.0125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.1092,11.7895;10.2,12.0895"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKN-TBL.HKN-TBLG[2].HKN-G[1].YKZFTN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#YKZFTN#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="10.2,12.0125"/>
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
    <object type="Embed - Text" version="0" id="O264">
      <attribute name="obj_pos">
        <point val="12.3,12.0125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="11.2092,11.7895;12.3,12.0895"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKN-TBL.HKN-TBLG[2].HKN-G[1].ITBFTN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#ITBFTN#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="12.3,12.0125"/>
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
    <object type="Embed - Text" version="0" id="O265">
      <attribute name="obj_pos">
        <point val="5.55,13.8125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.641,13.5895;5.55,13.8895"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKN-TBL.HKN-TBLG[3].HKN-G[0].KENSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#KENSU#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="5.55,13.8125"/>
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
    <object type="Embed - Text" version="0" id="O266">
      <attribute name="obj_pos">
        <point val="6.75,13.8125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.841,13.5895;6.75,13.8895"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKN-TBL.HKN-TBLG[3].HKN-G[0].NISSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#NISSU#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.75,13.8125"/>
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
    <object type="Embed - Text" version="0" id="O267">
      <attribute name="obj_pos">
        <point val="8.65,13.8125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.741,13.5895;8.65,13.8895"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKN-TBL.HKN-TBLG[3].HKN-G[0].TENSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#TENSU#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="8.65,13.8125"/>
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
    <object type="Embed - Text" version="0" id="O268">
      <attribute name="obj_pos">
        <point val="10.2,13.8125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.1092,13.5895;10.2,13.8895"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKN-TBL.HKN-TBLG[3].HKN-G[0].YKZFTN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#YKZFTN#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="10.2,13.8125"/>
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
    <object type="Embed - Text" version="0" id="O269">
      <attribute name="obj_pos">
        <point val="12.3,13.8125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="11.2092,13.5895;12.3,13.8895"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKN-TBL.HKN-TBLG[3].HKN-G[0].ITBFTN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#ITBFTN#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="12.3,13.8125"/>
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
    <object type="Embed - Text" version="0" id="O270">
      <attribute name="obj_pos">
        <point val="5.55,14.4125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.641,14.1895;5.55,14.4895"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKN-TBL.HKN-TBLG[3].HKN-G[1].KENSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#KENSU#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="5.55,14.4125"/>
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
    <object type="Embed - Text" version="0" id="O271">
      <attribute name="obj_pos">
        <point val="6.75,14.4125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="5.841,14.1895;6.75,14.4895"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKN-TBL.HKN-TBLG[3].HKN-G[1].NISSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#NISSU#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="6.75,14.4125"/>
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
    <object type="Embed - Text" version="0" id="O272">
      <attribute name="obj_pos">
        <point val="8.65,14.4125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.741,14.1895;8.65,14.4895"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKN-TBL.HKN-TBLG[3].HKN-G[1].TENSU#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#TENSU#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="8.65,14.4125"/>
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
    <object type="Embed - Text" version="0" id="O273">
      <attribute name="obj_pos">
        <point val="10.2,14.4125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.1092,14.1895;10.2,14.4895"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKN-TBL.HKN-TBLG[3].HKN-G[1].YKZFTN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#YKZFTN#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="10.2,14.4125"/>
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
    <object type="Embed - Text" version="0" id="O274">
      <attribute name="obj_pos">
        <point val="12.3,14.4125"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="11.2092,14.1895;12.3,14.4895"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HKN-TBL.HKN-TBLG[3].HKN-G[1].ITBFTN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#ITBFTN#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="12.3,14.4125"/>
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
    <object type="Embed - Text" version="0" id="O275">
      <attribute name="obj_pos">
        <point val="2.4,13.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.8546,13.577;2.4,13.877"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#KOHNUM[1]#</string>
      </attribute>
      <attribute name="embed_text_column">
        <int val="137095272"/>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
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
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="2.4,13.8"/>
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
    <object type="Embed - Text" version="0" id="O276">
      <attribute name="obj_pos">
        <point val="2,14.15"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2,13.9419;2.2828,15.6219"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#KOHNAME[1]#</string>
      </attribute>
      <attribute name="embed_text_column">
        <int val="2"/>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;
&#164;&#164;
&#164;&#166;
&#164;&#168;
&#164;&#170;
&#164;&#171;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="2,14.15"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O277">
      <attribute name="obj_pos">
        <point val="2.4,11.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.8546,11.177;2.4,11.477"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#KOHNUM[0]#</string>
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
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="2.4,11.4"/>
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
    <object type="Embed - Text" version="0" id="O278">
      <attribute name="obj_pos">
        <point val="2,11.75"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="2,11.5419;2.2828,13.2219"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#KOHNAME[0]#</string>
      </attribute>
      <attribute name="embed_text_column">
        <int val="2"/>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;
&#164;&#164;
&#164;&#166;
&#164;&#168;
&#164;&#170;
&#164;&#171;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.28"/>
          </attribute>
          <attribute name="pos">
            <point val="2,11.75"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.16968"/>
          </attribute>
          <attribute name="multi">
            <real val="0.1414"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O279">
      <attribute name="obj_pos">
        <point val="7.5,2.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.5,2.47699;12.954,2.77699"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#TITLE#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;&#164;&#162;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.3"/>
          </attribute>
          <attribute name="pos">
            <point val="7.5,2.7"/>
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
  </layer>
</diagram>
