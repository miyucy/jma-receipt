<?xml version="1.0"?>
<diagram xmlns:dia="http://www.lysator.liu.se/~alla/dia/">
  <dictionarydata>
    <element name="PAGE" occurs="1">
      <appinfo>
        <embed object="string" length="6"/>
      </appinfo>
    </element>
    <element name="MSTYMD" occurs="1">
      <appinfo>
        <embed object="string" length="22"/>
      </appinfo>
    </element>
    <element name="HOSPNAME" occurs="1">
      <appinfo>
        <embed object="string" length="60"/>
      </appinfo>
    </element>
    <element name="NAIYO-TBL" occurs="15">
      <element name="SRYCD" occurs="1">
        <appinfo>
          <embed object="string" length="9"/>
        </appinfo>
      </element>
      <element name="NAME" occurs="1">
        <appinfo>
          <embed object="string" length="100"/>
        </appinfo>
      </element>
      <element name="TEN" occurs="1">
        <appinfo>
          <embed object="string" length="14"/>
        </appinfo>
      </element>
      <element name="HKNTEK" occurs="1">
        <appinfo>
          <embed object="string" length="1"/>
        </appinfo>
      </element>
      <element name="BUI" occurs="1">
        <appinfo>
          <embed object="string" length="10"/>
        </appinfo>
      </element>
      <element name="GAITEN" occurs="1">
        <appinfo>
          <embed object="string" length="3"/>
        </appinfo>
      </element>
      <element name="NYUTEN" occurs="1">
        <appinfo>
          <embed object="string" length="3"/>
        </appinfo>
      </element>
      <element name="KRM1" occurs="1">
        <appinfo>
          <embed object="string" length="3"/>
        </appinfo>
      </element>
      <element name="KET1" occurs="1">
        <appinfo>
          <embed object="string" length="3"/>
        </appinfo>
      </element>
      <element name="KRM2" occurs="1">
        <appinfo>
          <embed object="string" length="3"/>
        </appinfo>
      </element>
      <element name="KET2" occurs="1">
        <appinfo>
          <embed object="string" length="3"/>
        </appinfo>
      </element>
      <element name="KRM3" occurs="1">
        <appinfo>
          <embed object="string" length="3"/>
        </appinfo>
      </element>
      <element name="KET3" occurs="1">
        <appinfo>
          <embed object="string" length="3"/>
        </appinfo>
      </element>
      <element name="KRM4" occurs="1">
        <appinfo>
          <embed object="string" length="3"/>
        </appinfo>
      </element>
      <element name="KET4" occurs="1">
        <appinfo>
          <embed object="string" length="3"/>
        </appinfo>
      </element>
      <element name="FUKUYOU1" occurs="1">
        <appinfo>
          <embed object="string" length="2"/>
        </appinfo>
      </element>
      <element name="FUKUYOU2" occurs="1">
        <appinfo>
          <embed object="string" length="2"/>
        </appinfo>
      </element>
      <element name="FUKUYOU3" occurs="1">
        <appinfo>
          <embed object="string" length="2"/>
        </appinfo>
      </element>
      <element name="FUKUYOU4" occurs="1">
        <appinfo>
          <embed object="string" length="2"/>
        </appinfo>
      </element>
      <element name="YUKOSTYMD" occurs="1">
        <appinfo>
          <embed object="string" length="8"/>
        </appinfo>
      </element>
      <element name="NYORO" occurs="1">
        <appinfo>
          <embed object="string" length="1"/>
        </appinfo>
      </element>
      <element name="YUKOEDYMD" occurs="1">
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
          <string>#Orca#</string>
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
    <object type="Standard - Box" version="0" id="O0">
      <attribute name="obj_pos">
        <point val="1,2.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,2.5;28.5,3.5"/>
      </attribute>
      <attribute name="elem_corner">
        <point val="1,2.5"/>
      </attribute>
      <attribute name="elem_width">
        <real val="27.5"/>
      </attribute>
      <attribute name="elem_height">
        <real val="1"/>
      </attribute>
      <attribute name="border_width">
        <real val="0"/>
      </attribute>
      <attribute name="show_background">
        <boolean val="false"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O1">
      <attribute name="obj_pos">
        <point val="3.6,3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.6,3;28.5,3"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.6,3"/>
        <point val="28.5,3"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O2" connection="0"/>
        <connection handle="1" to="O0" connection="4"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O2">
      <attribute name="obj_pos">
        <point val="3.6,2.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.6,2.5;3.6,3.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.6,2.5"/>
        <point val="3.6,3.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Box" version="0" id="O3">
      <attribute name="obj_pos">
        <point val="1,3.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,3.6;28.5,4.6"/>
      </attribute>
      <attribute name="elem_corner">
        <point val="1,3.6"/>
      </attribute>
      <attribute name="elem_width">
        <real val="27.5"/>
      </attribute>
      <attribute name="elem_height">
        <real val="1"/>
      </attribute>
      <attribute name="border_width">
        <real val="0"/>
      </attribute>
      <attribute name="show_background">
        <boolean val="false"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O4">
      <attribute name="obj_pos">
        <point val="3.6,4.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.6,4.1;28.5,4.1"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.6,4.1"/>
        <point val="28.5,4.1"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O5" connection="0"/>
        <connection handle="1" to="O3" connection="4"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O5">
      <attribute name="obj_pos">
        <point val="3.6,3.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.6,3.6;3.6,4.6"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.6,3.6"/>
        <point val="3.6,4.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O6">
      <attribute name="obj_pos">
        <point val="6.3,4.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.3,4.1;6.3,4.6"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="6.3,4.1"/>
        <point val="6.3,4.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O7">
      <attribute name="obj_pos">
        <point val="6.3,3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.3,3;6.3,3.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="6.3,3"/>
        <point val="6.3,3.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O8">
      <attribute name="obj_pos">
        <point val="7.2,4.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.2,4.1;7.2,4.6"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="7.2,4.1"/>
        <point val="7.2,4.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O9">
      <attribute name="obj_pos">
        <point val="7.2,3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.2,3;7.2,3.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="7.2,3"/>
        <point val="7.2,3.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O10">
      <attribute name="obj_pos">
        <point val="9.2,4.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2,4.1;9.2,4.6"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="9.2,4.1"/>
        <point val="9.2,4.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O11">
      <attribute name="obj_pos">
        <point val="9.2,3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2,3;9.2,3.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="9.2,3"/>
        <point val="9.2,3.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O12">
      <attribute name="obj_pos">
        <point val="13.4,4.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.4,4.1;13.4,4.6"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="13.4,4.1"/>
        <point val="13.4,4.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O13">
      <attribute name="obj_pos">
        <point val="10.7,3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.7,3;10.7,3.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="10.7,3"/>
        <point val="10.7,3.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O14">
      <attribute name="obj_pos">
        <point val="14.6,4.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.6,4.1;14.6,4.6"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="14.6,4.1"/>
        <point val="14.6,4.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O15">
      <attribute name="obj_pos">
        <point val="15.8,4.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.8,4.1;15.8,4.6"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="15.8,4.1"/>
        <point val="15.8,4.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O16">
      <attribute name="obj_pos">
        <point val="17,4.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17,4.1;17,4.6"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="17,4.1"/>
        <point val="17,4.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O17">
      <attribute name="obj_pos">
        <point val="12.2,3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.2,3;12.2,3.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="12.2,3"/>
        <point val="12.2,3.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O18">
      <attribute name="obj_pos">
        <point val="18.2,4.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.2,4.1;18.2,4.6"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="18.2,4.1"/>
        <point val="18.2,4.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O19">
      <attribute name="obj_pos">
        <point val="10.7,4.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.7,4.1;10.7,4.6"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="10.7,4.1"/>
        <point val="10.7,4.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O20">
      <attribute name="obj_pos">
        <point val="24.4,4.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.4,4.1;24.4,4.6"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="24.4,4.1"/>
        <point val="24.4,4.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O21">
      <attribute name="obj_pos">
        <point val="24.4,3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.4,3;24.4,3.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="24.4,3"/>
        <point val="24.4,3.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Box" version="0" id="O22">
      <attribute name="obj_pos">
        <point val="1,4.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,4.7;28.5,5.7"/>
      </attribute>
      <attribute name="elem_corner">
        <point val="1,4.7"/>
      </attribute>
      <attribute name="elem_width">
        <real val="27.5"/>
      </attribute>
      <attribute name="elem_height">
        <real val="1"/>
      </attribute>
      <attribute name="border_width">
        <real val="0"/>
      </attribute>
      <attribute name="show_background">
        <boolean val="false"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O23">
      <attribute name="obj_pos">
        <point val="3.6,5.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.6,5.2;28.5,5.2"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.6,5.2"/>
        <point val="28.5,5.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O24" connection="0"/>
        <connection handle="1" to="O22" connection="4"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O24">
      <attribute name="obj_pos">
        <point val="3.6,4.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.6,4.7;3.6,5.7"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.6,4.7"/>
        <point val="3.6,5.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O25">
      <attribute name="obj_pos">
        <point val="6.3,5.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.3,5.2;6.3,5.7"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="6.3,5.2"/>
        <point val="6.3,5.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O26">
      <attribute name="obj_pos">
        <point val="24.4,5.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.4,5.2;24.4,5.7"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="24.4,5.2"/>
        <point val="24.4,5.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Box" version="0" id="O27">
      <attribute name="obj_pos">
        <point val="1,5.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,5.8;28.5,6.8"/>
      </attribute>
      <attribute name="elem_corner">
        <point val="1,5.8"/>
      </attribute>
      <attribute name="elem_width">
        <real val="27.5"/>
      </attribute>
      <attribute name="elem_height">
        <real val="1"/>
      </attribute>
      <attribute name="border_width">
        <real val="0"/>
      </attribute>
      <attribute name="show_background">
        <boolean val="false"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O28">
      <attribute name="obj_pos">
        <point val="3.6,6.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.6,6.3;28.5,6.3"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.6,6.3"/>
        <point val="28.5,6.3"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O29" connection="0"/>
        <connection handle="1" to="O27" connection="4"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O29">
      <attribute name="obj_pos">
        <point val="3.6,5.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.6,5.8;3.6,6.8"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.6,5.8"/>
        <point val="3.6,6.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O30">
      <attribute name="obj_pos">
        <point val="6.3,6.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.3,6.3;6.3,6.8"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="6.3,6.3"/>
        <point val="6.3,6.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O31">
      <attribute name="obj_pos">
        <point val="24.4,6.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.4,6.3;24.4,6.8"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="24.4,6.3"/>
        <point val="24.4,6.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Box" version="0" id="O32">
      <attribute name="obj_pos">
        <point val="1,6.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,6.9;28.5,7.9"/>
      </attribute>
      <attribute name="elem_corner">
        <point val="1,6.9"/>
      </attribute>
      <attribute name="elem_width">
        <real val="27.5"/>
      </attribute>
      <attribute name="elem_height">
        <real val="1"/>
      </attribute>
      <attribute name="border_width">
        <real val="0"/>
      </attribute>
      <attribute name="show_background">
        <boolean val="false"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O33">
      <attribute name="obj_pos">
        <point val="3.6,7.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.6,7.4;28.5,7.4"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.6,7.4"/>
        <point val="28.5,7.4"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O34" connection="0"/>
        <connection handle="1" to="O32" connection="4"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O34">
      <attribute name="obj_pos">
        <point val="3.6,6.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.6,6.9;3.6,7.9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.6,6.9"/>
        <point val="3.6,7.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O35">
      <attribute name="obj_pos">
        <point val="6.3,7.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.3,7.4;6.3,7.9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="6.3,7.4"/>
        <point val="6.3,7.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O36">
      <attribute name="obj_pos">
        <point val="24.4,7.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.4,7.4;24.4,7.9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="24.4,7.4"/>
        <point val="24.4,7.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Box" version="0" id="O37">
      <attribute name="obj_pos">
        <point val="1,8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,8;28.5,9"/>
      </attribute>
      <attribute name="elem_corner">
        <point val="1,8"/>
      </attribute>
      <attribute name="elem_width">
        <real val="27.5"/>
      </attribute>
      <attribute name="elem_height">
        <real val="1"/>
      </attribute>
      <attribute name="border_width">
        <real val="0"/>
      </attribute>
      <attribute name="show_background">
        <boolean val="false"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O38">
      <attribute name="obj_pos">
        <point val="3.6,8.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.6,8.5;28.5,8.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.6,8.5"/>
        <point val="28.5,8.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O39" connection="0"/>
        <connection handle="1" to="O37" connection="4"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O39">
      <attribute name="obj_pos">
        <point val="3.6,8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.6,8;3.6,9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.6,8"/>
        <point val="3.6,9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O40">
      <attribute name="obj_pos">
        <point val="6.3,8.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.3,8.5;6.3,9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="6.3,8.5"/>
        <point val="6.3,9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O41">
      <attribute name="obj_pos">
        <point val="24.4,8.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.4,8.5;24.4,9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="24.4,8.5"/>
        <point val="24.4,9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Box" version="0" id="O42">
      <attribute name="obj_pos">
        <point val="1,9.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,9.1;28.5,10.1"/>
      </attribute>
      <attribute name="elem_corner">
        <point val="1,9.1"/>
      </attribute>
      <attribute name="elem_width">
        <real val="27.5"/>
      </attribute>
      <attribute name="elem_height">
        <real val="1"/>
      </attribute>
      <attribute name="border_width">
        <real val="0"/>
      </attribute>
      <attribute name="show_background">
        <boolean val="false"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O43">
      <attribute name="obj_pos">
        <point val="3.6,9.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.6,9.6;28.5,9.6"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.6,9.6"/>
        <point val="28.5,9.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O44" connection="0"/>
        <connection handle="1" to="O42" connection="4"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O44">
      <attribute name="obj_pos">
        <point val="3.6,9.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.6,9.1;3.6,10.1"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.6,9.1"/>
        <point val="3.6,10.1"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O45">
      <attribute name="obj_pos">
        <point val="6.3,9.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.3,9.6;6.3,10.1"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="6.3,9.6"/>
        <point val="6.3,10.1"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O46">
      <attribute name="obj_pos">
        <point val="24.4,9.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.4,9.6;24.4,10.1"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="24.4,9.6"/>
        <point val="24.4,10.1"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Box" version="0" id="O47">
      <attribute name="obj_pos">
        <point val="1,10.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,10.2;28.5,11.2"/>
      </attribute>
      <attribute name="elem_corner">
        <point val="1,10.2"/>
      </attribute>
      <attribute name="elem_width">
        <real val="27.5"/>
      </attribute>
      <attribute name="elem_height">
        <real val="1"/>
      </attribute>
      <attribute name="border_width">
        <real val="0"/>
      </attribute>
      <attribute name="show_background">
        <boolean val="false"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O48">
      <attribute name="obj_pos">
        <point val="3.6,10.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.6,10.7;28.5,10.7"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.6,10.7"/>
        <point val="28.5,10.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O49" connection="0"/>
        <connection handle="1" to="O47" connection="4"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O49">
      <attribute name="obj_pos">
        <point val="3.6,10.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.6,10.2;3.6,11.2"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.6,10.2"/>
        <point val="3.6,11.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O50">
      <attribute name="obj_pos">
        <point val="6.3,10.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.3,10.7;6.3,11.2"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="6.3,10.7"/>
        <point val="6.3,11.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O51">
      <attribute name="obj_pos">
        <point val="24.4,10.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.4,10.7;24.4,11.2"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="24.4,10.7"/>
        <point val="24.4,11.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Box" version="0" id="O52">
      <attribute name="obj_pos">
        <point val="1,11.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,11.3;28.5,12.3"/>
      </attribute>
      <attribute name="elem_corner">
        <point val="1,11.3"/>
      </attribute>
      <attribute name="elem_width">
        <real val="27.5"/>
      </attribute>
      <attribute name="elem_height">
        <real val="1"/>
      </attribute>
      <attribute name="border_width">
        <real val="0"/>
      </attribute>
      <attribute name="show_background">
        <boolean val="false"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O53">
      <attribute name="obj_pos">
        <point val="3.6,11.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.6,11.8;28.5,11.8"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.6,11.8"/>
        <point val="28.5,11.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O54" connection="0"/>
        <connection handle="1" to="O52" connection="4"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O54">
      <attribute name="obj_pos">
        <point val="3.6,11.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.6,11.3;3.6,12.3"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.6,11.3"/>
        <point val="3.6,12.3"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O55">
      <attribute name="obj_pos">
        <point val="6.3,11.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.3,11.8;6.3,12.3"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="6.3,11.8"/>
        <point val="6.3,12.3"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O56">
      <attribute name="obj_pos">
        <point val="24.4,11.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.4,11.8;24.4,12.3"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="24.4,11.8"/>
        <point val="24.4,12.3"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Box" version="0" id="O57">
      <attribute name="obj_pos">
        <point val="1,12.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,12.4;28.5,13.4"/>
      </attribute>
      <attribute name="elem_corner">
        <point val="1,12.4"/>
      </attribute>
      <attribute name="elem_width">
        <real val="27.5"/>
      </attribute>
      <attribute name="elem_height">
        <real val="1"/>
      </attribute>
      <attribute name="border_width">
        <real val="0"/>
      </attribute>
      <attribute name="show_background">
        <boolean val="false"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O58">
      <attribute name="obj_pos">
        <point val="3.6,12.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.6,12.9;28.5,12.9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.6,12.9"/>
        <point val="28.5,12.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O59" connection="0"/>
        <connection handle="1" to="O57" connection="4"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O59">
      <attribute name="obj_pos">
        <point val="3.6,12.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.6,12.4;3.6,13.4"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.6,12.4"/>
        <point val="3.6,13.4"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O60">
      <attribute name="obj_pos">
        <point val="6.3,12.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.3,12.9;6.3,13.4"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="6.3,12.9"/>
        <point val="6.3,13.4"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O61">
      <attribute name="obj_pos">
        <point val="24.4,12.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.4,12.9;24.4,13.4"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="24.4,12.9"/>
        <point val="24.4,13.4"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Box" version="0" id="O62">
      <attribute name="obj_pos">
        <point val="1,13.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,13.5;28.5,14.5"/>
      </attribute>
      <attribute name="elem_corner">
        <point val="1,13.5"/>
      </attribute>
      <attribute name="elem_width">
        <real val="27.5"/>
      </attribute>
      <attribute name="elem_height">
        <real val="1"/>
      </attribute>
      <attribute name="border_width">
        <real val="0"/>
      </attribute>
      <attribute name="show_background">
        <boolean val="false"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O63">
      <attribute name="obj_pos">
        <point val="3.6,14"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.6,14;28.5,14"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.6,14"/>
        <point val="28.5,14"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O64" connection="0"/>
        <connection handle="1" to="O62" connection="4"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O64">
      <attribute name="obj_pos">
        <point val="3.6,13.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.6,13.5;3.6,14.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.6,13.5"/>
        <point val="3.6,14.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O65">
      <attribute name="obj_pos">
        <point val="6.3,14"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.3,14;6.3,14.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="6.3,14"/>
        <point val="6.3,14.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O66">
      <attribute name="obj_pos">
        <point val="24.4,14"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.4,14;24.4,14.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="24.4,14"/>
        <point val="24.4,14.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Box" version="0" id="O67">
      <attribute name="obj_pos">
        <point val="1,14.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,14.6;28.5,15.6"/>
      </attribute>
      <attribute name="elem_corner">
        <point val="1,14.6"/>
      </attribute>
      <attribute name="elem_width">
        <real val="27.5"/>
      </attribute>
      <attribute name="elem_height">
        <real val="1"/>
      </attribute>
      <attribute name="border_width">
        <real val="0"/>
      </attribute>
      <attribute name="show_background">
        <boolean val="false"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O68">
      <attribute name="obj_pos">
        <point val="3.6,15.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.6,15.1;28.5,15.1"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.6,15.1"/>
        <point val="28.5,15.1"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O69" connection="0"/>
        <connection handle="1" to="O67" connection="4"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O69">
      <attribute name="obj_pos">
        <point val="3.6,14.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.6,14.6;3.6,15.6"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.6,14.6"/>
        <point val="3.6,15.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O70">
      <attribute name="obj_pos">
        <point val="6.3,15.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.3,15.1;6.3,15.6"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="6.3,15.1"/>
        <point val="6.3,15.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O71">
      <attribute name="obj_pos">
        <point val="24.4,15.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.4,15.1;24.4,15.6"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="24.4,15.1"/>
        <point val="24.4,15.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Box" version="0" id="O72">
      <attribute name="obj_pos">
        <point val="1,15.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,15.7;28.5,16.7"/>
      </attribute>
      <attribute name="elem_corner">
        <point val="1,15.7"/>
      </attribute>
      <attribute name="elem_width">
        <real val="27.5"/>
      </attribute>
      <attribute name="elem_height">
        <real val="1"/>
      </attribute>
      <attribute name="border_width">
        <real val="0"/>
      </attribute>
      <attribute name="show_background">
        <boolean val="false"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O73">
      <attribute name="obj_pos">
        <point val="3.6,16.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.6,16.2;28.5,16.2"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.6,16.2"/>
        <point val="28.5,16.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O74" connection="0"/>
        <connection handle="1" to="O72" connection="4"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O74">
      <attribute name="obj_pos">
        <point val="3.6,15.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.6,15.7;3.6,16.7"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.6,15.7"/>
        <point val="3.6,16.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O75">
      <attribute name="obj_pos">
        <point val="6.3,16.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.3,16.2;6.3,16.7"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="6.3,16.2"/>
        <point val="6.3,16.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O76">
      <attribute name="obj_pos">
        <point val="24.4,16.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.4,16.2;24.4,16.7"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="24.4,16.2"/>
        <point val="24.4,16.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Box" version="0" id="O77">
      <attribute name="obj_pos">
        <point val="1,16.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,16.8;28.5,17.8"/>
      </attribute>
      <attribute name="elem_corner">
        <point val="1,16.8"/>
      </attribute>
      <attribute name="elem_width">
        <real val="27.5"/>
      </attribute>
      <attribute name="elem_height">
        <real val="1"/>
      </attribute>
      <attribute name="border_width">
        <real val="0"/>
      </attribute>
      <attribute name="show_background">
        <boolean val="false"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O78">
      <attribute name="obj_pos">
        <point val="3.6,17.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.6,17.3;28.5,17.3"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.6,17.3"/>
        <point val="28.5,17.3"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O79" connection="0"/>
        <connection handle="1" to="O77" connection="4"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O79">
      <attribute name="obj_pos">
        <point val="3.6,16.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.6,16.8;3.6,17.8"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.6,16.8"/>
        <point val="3.6,17.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O80">
      <attribute name="obj_pos">
        <point val="6.3,17.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.3,17.3;6.3,17.8"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="6.3,17.3"/>
        <point val="6.3,17.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O81">
      <attribute name="obj_pos">
        <point val="24.4,17.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.4,17.3;24.4,17.8"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="24.4,17.3"/>
        <point val="24.4,17.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Box" version="0" id="O82">
      <attribute name="obj_pos">
        <point val="1,17.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,17.9;28.5,18.9"/>
      </attribute>
      <attribute name="elem_corner">
        <point val="1,17.9"/>
      </attribute>
      <attribute name="elem_width">
        <real val="27.5"/>
      </attribute>
      <attribute name="elem_height">
        <real val="1"/>
      </attribute>
      <attribute name="border_width">
        <real val="0"/>
      </attribute>
      <attribute name="show_background">
        <boolean val="false"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O83">
      <attribute name="obj_pos">
        <point val="3.6,18.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.6,18.4;28.5,18.4"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.6,18.4"/>
        <point val="28.5,18.4"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O84" connection="0"/>
        <connection handle="1" to="O82" connection="4"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O84">
      <attribute name="obj_pos">
        <point val="3.6,17.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.6,17.9;3.6,18.9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.6,17.9"/>
        <point val="3.6,18.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O85">
      <attribute name="obj_pos">
        <point val="6.3,18.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.3,18.4;6.3,18.9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="6.3,18.4"/>
        <point val="6.3,18.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O86">
      <attribute name="obj_pos">
        <point val="24.4,18.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.4,18.4;24.4,18.9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="24.4,18.4"/>
        <point val="24.4,18.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Box" version="0" id="O87">
      <attribute name="obj_pos">
        <point val="1,19"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,19;28.5,20"/>
      </attribute>
      <attribute name="elem_corner">
        <point val="1,19"/>
      </attribute>
      <attribute name="elem_width">
        <real val="27.5"/>
      </attribute>
      <attribute name="elem_height">
        <real val="1"/>
      </attribute>
      <attribute name="border_width">
        <real val="0"/>
      </attribute>
      <attribute name="show_background">
        <boolean val="false"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O88">
      <attribute name="obj_pos">
        <point val="3.6,19.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.6,19.5;28.5,19.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.6,19.5"/>
        <point val="28.5,19.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
      <connections>
        <connection handle="0" to="O89" connection="0"/>
        <connection handle="1" to="O87" connection="4"/>
      </connections>
    </object>
    <object type="Standard - Line" version="0" id="O89">
      <attribute name="obj_pos">
        <point val="3.6,19"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.6,19;3.6,20"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="3.6,19"/>
        <point val="3.6,20"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O90">
      <attribute name="obj_pos">
        <point val="6.3,19.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.3,19.5;6.3,20"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="6.3,19.5"/>
        <point val="6.3,20"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O91">
      <attribute name="obj_pos">
        <point val="24.4,19.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.4,19.5;24.4,20"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="24.4,19.5"/>
        <point val="24.4,20"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O92">
      <attribute name="obj_pos">
        <point val="12.2,4.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.2,4.1;12.2,4.6"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="12.2,4.1"/>
        <point val="12.2,4.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O93">
      <attribute name="obj_pos">
        <point val="13.4,3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.4,3;13.4,3.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="13.4,3"/>
        <point val="13.4,3.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O94">
      <attribute name="obj_pos">
        <point val="14.6,3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.6,3;14.6,3.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="14.6,3"/>
        <point val="14.6,3.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O95">
      <attribute name="obj_pos">
        <point val="15.8,3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.8,3;15.8,3.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="15.8,3"/>
        <point val="15.8,3.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O96">
      <attribute name="obj_pos">
        <point val="17,3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17,3;17,3.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="17,3"/>
        <point val="17,3.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O97">
      <attribute name="obj_pos">
        <point val="18.2,3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.2,3;18.2,3.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="18.2,3"/>
        <point val="18.2,3.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O98">
      <attribute name="obj_pos">
        <point val="19.4,3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.4,3;19.4,3.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="19.4,3"/>
        <point val="19.4,3.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O99">
      <attribute name="obj_pos">
        <point val="20.6,3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="20.6,3;20.6,3.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="20.6,3"/>
        <point val="20.6,3.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O100">
      <attribute name="obj_pos">
        <point val="19.4,4.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.4,4.1;19.4,4.6"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="19.4,4.1"/>
        <point val="19.4,4.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O101">
      <attribute name="obj_pos">
        <point val="20.6,4.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="20.6,4.1;20.6,4.6"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="20.6,4.1"/>
        <point val="20.6,4.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O102">
      <attribute name="obj_pos">
        <point val="21.8,3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.8,3;21.8,3.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="21.8,3"/>
        <point val="21.8,3.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O103">
      <attribute name="obj_pos">
        <point val="21.8,4.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.8,4.1;21.8,4.6"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="21.8,4.1"/>
        <point val="21.8,4.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O104">
      <attribute name="obj_pos">
        <point val="23,3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23,3;23,3.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="23,3"/>
        <point val="23,3.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O105">
      <attribute name="obj_pos">
        <point val="23,4.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23,4.1;23,4.6"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="23,4.1"/>
        <point val="23,4.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O106">
      <attribute name="obj_pos">
        <point val="22.4,3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.4,3;22.4,3.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="22.4,3"/>
        <point val="22.4,3.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O107">
      <attribute name="obj_pos">
        <point val="22.4,4.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.4,4.1;22.4,4.6"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="22.4,4.1"/>
        <point val="22.4,4.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O108">
      <attribute name="obj_pos">
        <point val="23.6,3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.6,3;23.6,3.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="23.6,3"/>
        <point val="23.6,3.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O109">
      <attribute name="obj_pos">
        <point val="23.6,4.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.6,4.1;23.6,4.6"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="23.6,4.1"/>
        <point val="23.6,4.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O110">
      <attribute name="obj_pos">
        <point val="7.2,6.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.2,6.3;7.2,6.8"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="7.2,6.3"/>
        <point val="7.2,6.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O111">
      <attribute name="obj_pos">
        <point val="7.2,5.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.2,5.2;7.2,5.7"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="7.2,5.2"/>
        <point val="7.2,5.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O112">
      <attribute name="obj_pos">
        <point val="9.2,6.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2,6.3;9.2,6.8"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="9.2,6.3"/>
        <point val="9.2,6.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O113">
      <attribute name="obj_pos">
        <point val="9.2,5.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2,5.2;9.2,5.7"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="9.2,5.2"/>
        <point val="9.2,5.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O114">
      <attribute name="obj_pos">
        <point val="13.4,6.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.4,6.3;13.4,6.8"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="13.4,6.3"/>
        <point val="13.4,6.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O115">
      <attribute name="obj_pos">
        <point val="10.7,5.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.7,5.2;10.7,5.7"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="10.7,5.2"/>
        <point val="10.7,5.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O116">
      <attribute name="obj_pos">
        <point val="14.6,6.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.6,6.3;14.6,6.8"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="14.6,6.3"/>
        <point val="14.6,6.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O117">
      <attribute name="obj_pos">
        <point val="15.8,6.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.8,6.3;15.8,6.8"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="15.8,6.3"/>
        <point val="15.8,6.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O118">
      <attribute name="obj_pos">
        <point val="17,6.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17,6.3;17,6.8"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="17,6.3"/>
        <point val="17,6.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O119">
      <attribute name="obj_pos">
        <point val="12.2,5.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.2,5.2;12.2,5.7"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="12.2,5.2"/>
        <point val="12.2,5.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O120">
      <attribute name="obj_pos">
        <point val="18.2,6.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.2,6.3;18.2,6.8"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="18.2,6.3"/>
        <point val="18.2,6.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O121">
      <attribute name="obj_pos">
        <point val="10.7,6.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.7,6.3;10.7,6.8"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="10.7,6.3"/>
        <point val="10.7,6.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O122">
      <attribute name="obj_pos">
        <point val="12.2,6.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.2,6.3;12.2,6.8"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="12.2,6.3"/>
        <point val="12.2,6.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O123">
      <attribute name="obj_pos">
        <point val="13.4,5.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.4,5.2;13.4,5.7"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="13.4,5.2"/>
        <point val="13.4,5.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O124">
      <attribute name="obj_pos">
        <point val="14.6,5.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.6,5.2;14.6,5.7"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="14.6,5.2"/>
        <point val="14.6,5.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O125">
      <attribute name="obj_pos">
        <point val="15.8,5.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.8,5.2;15.8,5.7"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="15.8,5.2"/>
        <point val="15.8,5.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O126">
      <attribute name="obj_pos">
        <point val="17,5.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17,5.2;17,5.7"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="17,5.2"/>
        <point val="17,5.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O127">
      <attribute name="obj_pos">
        <point val="18.2,5.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.2,5.2;18.2,5.7"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="18.2,5.2"/>
        <point val="18.2,5.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O128">
      <attribute name="obj_pos">
        <point val="19.4,5.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.4,5.2;19.4,5.7"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="19.4,5.2"/>
        <point val="19.4,5.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O129">
      <attribute name="obj_pos">
        <point val="20.6,5.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="20.6,5.2;20.6,5.7"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="20.6,5.2"/>
        <point val="20.6,5.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O130">
      <attribute name="obj_pos">
        <point val="19.4,6.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.4,6.3;19.4,6.8"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="19.4,6.3"/>
        <point val="19.4,6.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O131">
      <attribute name="obj_pos">
        <point val="20.6,6.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="20.6,6.3;20.6,6.8"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="20.6,6.3"/>
        <point val="20.6,6.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O132">
      <attribute name="obj_pos">
        <point val="21.8,5.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.8,5.2;21.8,5.7"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="21.8,5.2"/>
        <point val="21.8,5.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O133">
      <attribute name="obj_pos">
        <point val="21.8,6.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.8,6.3;21.8,6.8"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="21.8,6.3"/>
        <point val="21.8,6.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O134">
      <attribute name="obj_pos">
        <point val="23,5.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23,5.2;23,5.7"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="23,5.2"/>
        <point val="23,5.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O135">
      <attribute name="obj_pos">
        <point val="23,6.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23,6.3;23,6.8"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="23,6.3"/>
        <point val="23,6.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O136">
      <attribute name="obj_pos">
        <point val="22.4,5.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.4,5.2;22.4,5.7"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="22.4,5.2"/>
        <point val="22.4,5.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O137">
      <attribute name="obj_pos">
        <point val="22.4,6.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.4,6.3;22.4,6.8"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="22.4,6.3"/>
        <point val="22.4,6.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O138">
      <attribute name="obj_pos">
        <point val="23.6,5.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.6,5.2;23.6,5.7"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="23.6,5.2"/>
        <point val="23.6,5.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O139">
      <attribute name="obj_pos">
        <point val="23.6,6.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.6,6.3;23.6,6.8"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="23.6,6.3"/>
        <point val="23.6,6.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O140">
      <attribute name="obj_pos">
        <point val="7.2,8.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.2,8.5;7.2,9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="7.2,8.5"/>
        <point val="7.2,9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O141">
      <attribute name="obj_pos">
        <point val="7.2,7.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.2,7.4;7.2,7.9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="7.2,7.4"/>
        <point val="7.2,7.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O142">
      <attribute name="obj_pos">
        <point val="9.2,8.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2,8.5;9.2,9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="9.2,8.5"/>
        <point val="9.2,9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O143">
      <attribute name="obj_pos">
        <point val="9.2,7.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2,7.4;9.2,7.9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="9.2,7.4"/>
        <point val="9.2,7.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O144">
      <attribute name="obj_pos">
        <point val="13.4,8.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.4,8.5;13.4,9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="13.4,8.5"/>
        <point val="13.4,9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O145">
      <attribute name="obj_pos">
        <point val="10.7,7.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.7,7.4;10.7,7.9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="10.7,7.4"/>
        <point val="10.7,7.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O146">
      <attribute name="obj_pos">
        <point val="14.6,8.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.6,8.5;14.6,9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="14.6,8.5"/>
        <point val="14.6,9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O147">
      <attribute name="obj_pos">
        <point val="15.8,8.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.8,8.5;15.8,9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="15.8,8.5"/>
        <point val="15.8,9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O148">
      <attribute name="obj_pos">
        <point val="17,8.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17,8.5;17,9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="17,8.5"/>
        <point val="17,9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O149">
      <attribute name="obj_pos">
        <point val="12.2,7.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.2,7.4;12.2,7.9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="12.2,7.4"/>
        <point val="12.2,7.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O150">
      <attribute name="obj_pos">
        <point val="18.2,8.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.2,8.5;18.2,9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="18.2,8.5"/>
        <point val="18.2,9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O151">
      <attribute name="obj_pos">
        <point val="10.7,8.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.7,8.5;10.7,9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="10.7,8.5"/>
        <point val="10.7,9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O152">
      <attribute name="obj_pos">
        <point val="12.2,8.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.2,8.5;12.2,9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="12.2,8.5"/>
        <point val="12.2,9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O153">
      <attribute name="obj_pos">
        <point val="13.4,7.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.4,7.4;13.4,7.9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="13.4,7.4"/>
        <point val="13.4,7.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O154">
      <attribute name="obj_pos">
        <point val="14.6,7.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.6,7.4;14.6,7.9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="14.6,7.4"/>
        <point val="14.6,7.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O155">
      <attribute name="obj_pos">
        <point val="15.8,7.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.8,7.4;15.8,7.9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="15.8,7.4"/>
        <point val="15.8,7.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O156">
      <attribute name="obj_pos">
        <point val="17,7.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17,7.4;17,7.9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="17,7.4"/>
        <point val="17,7.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O157">
      <attribute name="obj_pos">
        <point val="18.2,7.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.2,7.4;18.2,7.9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="18.2,7.4"/>
        <point val="18.2,7.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O158">
      <attribute name="obj_pos">
        <point val="19.4,7.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.4,7.4;19.4,7.9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="19.4,7.4"/>
        <point val="19.4,7.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O159">
      <attribute name="obj_pos">
        <point val="20.6,7.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="20.6,7.4;20.6,7.9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="20.6,7.4"/>
        <point val="20.6,7.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O160">
      <attribute name="obj_pos">
        <point val="19.4,8.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.4,8.5;19.4,9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="19.4,8.5"/>
        <point val="19.4,9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O161">
      <attribute name="obj_pos">
        <point val="20.6,8.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="20.6,8.5;20.6,9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="20.6,8.5"/>
        <point val="20.6,9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O162">
      <attribute name="obj_pos">
        <point val="21.8,7.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.8,7.4;21.8,7.9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="21.8,7.4"/>
        <point val="21.8,7.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O163">
      <attribute name="obj_pos">
        <point val="21.8,8.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.8,8.5;21.8,9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="21.8,8.5"/>
        <point val="21.8,9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O164">
      <attribute name="obj_pos">
        <point val="23,7.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23,7.4;23,7.9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="23,7.4"/>
        <point val="23,7.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O165">
      <attribute name="obj_pos">
        <point val="23,8.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23,8.5;23,9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="23,8.5"/>
        <point val="23,9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O166">
      <attribute name="obj_pos">
        <point val="22.4,7.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.4,7.4;22.4,7.9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="22.4,7.4"/>
        <point val="22.4,7.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O167">
      <attribute name="obj_pos">
        <point val="22.4,8.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.4,8.5;22.4,9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="22.4,8.5"/>
        <point val="22.4,9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O168">
      <attribute name="obj_pos">
        <point val="23.6,7.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.6,7.4;23.6,7.9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="23.6,7.4"/>
        <point val="23.6,7.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O169">
      <attribute name="obj_pos">
        <point val="23.6,8.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.6,8.5;23.6,9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="23.6,8.5"/>
        <point val="23.6,9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O170">
      <attribute name="obj_pos">
        <point val="7.2,10.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.2,10.7;7.2,11.2"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="7.2,10.7"/>
        <point val="7.2,11.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O171">
      <attribute name="obj_pos">
        <point val="7.2,9.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.2,9.6;7.2,10.1"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="7.2,9.6"/>
        <point val="7.2,10.1"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O172">
      <attribute name="obj_pos">
        <point val="9.2,10.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2,10.7;9.2,11.2"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="9.2,10.7"/>
        <point val="9.2,11.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O173">
      <attribute name="obj_pos">
        <point val="9.2,9.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2,9.6;9.2,10.1"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="9.2,9.6"/>
        <point val="9.2,10.1"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O174">
      <attribute name="obj_pos">
        <point val="13.4,10.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.4,10.7;13.4,11.2"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="13.4,10.7"/>
        <point val="13.4,11.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O175">
      <attribute name="obj_pos">
        <point val="10.7,9.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.7,9.6;10.7,10.1"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="10.7,9.6"/>
        <point val="10.7,10.1"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O176">
      <attribute name="obj_pos">
        <point val="14.6,10.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.6,10.7;14.6,11.2"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="14.6,10.7"/>
        <point val="14.6,11.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O177">
      <attribute name="obj_pos">
        <point val="15.8,10.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.8,10.7;15.8,11.2"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="15.8,10.7"/>
        <point val="15.8,11.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O178">
      <attribute name="obj_pos">
        <point val="17,10.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17,10.7;17,11.2"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="17,10.7"/>
        <point val="17,11.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O179">
      <attribute name="obj_pos">
        <point val="12.2,9.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.2,9.6;12.2,10.1"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="12.2,9.6"/>
        <point val="12.2,10.1"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O180">
      <attribute name="obj_pos">
        <point val="18.2,10.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.2,10.7;18.2,11.2"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="18.2,10.7"/>
        <point val="18.2,11.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O181">
      <attribute name="obj_pos">
        <point val="10.7,10.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.7,10.7;10.7,11.2"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="10.7,10.7"/>
        <point val="10.7,11.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O182">
      <attribute name="obj_pos">
        <point val="12.2,10.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.2,10.7;12.2,11.2"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="12.2,10.7"/>
        <point val="12.2,11.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O183">
      <attribute name="obj_pos">
        <point val="13.4,9.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.4,9.6;13.4,10.1"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="13.4,9.6"/>
        <point val="13.4,10.1"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O184">
      <attribute name="obj_pos">
        <point val="14.6,9.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.6,9.6;14.6,10.1"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="14.6,9.6"/>
        <point val="14.6,10.1"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O185">
      <attribute name="obj_pos">
        <point val="15.8,9.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.8,9.6;15.8,10.1"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="15.8,9.6"/>
        <point val="15.8,10.1"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O186">
      <attribute name="obj_pos">
        <point val="17,9.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17,9.6;17,10.1"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="17,9.6"/>
        <point val="17,10.1"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O187">
      <attribute name="obj_pos">
        <point val="18.2,9.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.2,9.6;18.2,10.1"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="18.2,9.6"/>
        <point val="18.2,10.1"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O188">
      <attribute name="obj_pos">
        <point val="19.4,9.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.4,9.6;19.4,10.1"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="19.4,9.6"/>
        <point val="19.4,10.1"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O189">
      <attribute name="obj_pos">
        <point val="20.6,9.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="20.6,9.6;20.6,10.1"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="20.6,9.6"/>
        <point val="20.6,10.1"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O190">
      <attribute name="obj_pos">
        <point val="19.4,10.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.4,10.7;19.4,11.2"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="19.4,10.7"/>
        <point val="19.4,11.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O191">
      <attribute name="obj_pos">
        <point val="20.6,10.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="20.6,10.7;20.6,11.2"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="20.6,10.7"/>
        <point val="20.6,11.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O192">
      <attribute name="obj_pos">
        <point val="21.8,9.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.8,9.6;21.8,10.1"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="21.8,9.6"/>
        <point val="21.8,10.1"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O193">
      <attribute name="obj_pos">
        <point val="21.8,10.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.8,10.7;21.8,11.2"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="21.8,10.7"/>
        <point val="21.8,11.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O194">
      <attribute name="obj_pos">
        <point val="23,9.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23,9.6;23,10.1"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="23,9.6"/>
        <point val="23,10.1"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O195">
      <attribute name="obj_pos">
        <point val="23,10.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23,10.7;23,11.2"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="23,10.7"/>
        <point val="23,11.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O196">
      <attribute name="obj_pos">
        <point val="22.4,9.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.4,9.6;22.4,10.1"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="22.4,9.6"/>
        <point val="22.4,10.1"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O197">
      <attribute name="obj_pos">
        <point val="22.4,10.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.4,10.7;22.4,11.2"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="22.4,10.7"/>
        <point val="22.4,11.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O198">
      <attribute name="obj_pos">
        <point val="23.6,9.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.6,9.6;23.6,10.1"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="23.6,9.6"/>
        <point val="23.6,10.1"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O199">
      <attribute name="obj_pos">
        <point val="23.6,10.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.6,10.7;23.6,11.2"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="23.6,10.7"/>
        <point val="23.6,11.2"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O200">
      <attribute name="obj_pos">
        <point val="7.2,12.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.2,12.9;7.2,13.4"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="7.2,12.9"/>
        <point val="7.2,13.4"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O201">
      <attribute name="obj_pos">
        <point val="7.2,11.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.2,11.8;7.2,12.3"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="7.2,11.8"/>
        <point val="7.2,12.3"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O202">
      <attribute name="obj_pos">
        <point val="9.2,12.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2,12.9;9.2,13.4"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="9.2,12.9"/>
        <point val="9.2,13.4"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O203">
      <attribute name="obj_pos">
        <point val="9.2,11.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2,11.8;9.2,12.3"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="9.2,11.8"/>
        <point val="9.2,12.3"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O204">
      <attribute name="obj_pos">
        <point val="13.4,12.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.4,12.9;13.4,13.4"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="13.4,12.9"/>
        <point val="13.4,13.4"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O205">
      <attribute name="obj_pos">
        <point val="10.7,11.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.7,11.8;10.7,12.3"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="10.7,11.8"/>
        <point val="10.7,12.3"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O206">
      <attribute name="obj_pos">
        <point val="14.6,12.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.6,12.9;14.6,13.4"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="14.6,12.9"/>
        <point val="14.6,13.4"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O207">
      <attribute name="obj_pos">
        <point val="15.8,12.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.8,12.9;15.8,13.4"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="15.8,12.9"/>
        <point val="15.8,13.4"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O208">
      <attribute name="obj_pos">
        <point val="17,12.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17,12.9;17,13.4"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="17,12.9"/>
        <point val="17,13.4"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O209">
      <attribute name="obj_pos">
        <point val="12.2,11.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.2,11.8;12.2,12.3"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="12.2,11.8"/>
        <point val="12.2,12.3"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O210">
      <attribute name="obj_pos">
        <point val="18.2,12.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.2,12.9;18.2,13.4"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="18.2,12.9"/>
        <point val="18.2,13.4"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O211">
      <attribute name="obj_pos">
        <point val="10.7,12.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.7,12.9;10.7,13.4"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="10.7,12.9"/>
        <point val="10.7,13.4"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O212">
      <attribute name="obj_pos">
        <point val="12.2,12.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.2,12.9;12.2,13.4"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="12.2,12.9"/>
        <point val="12.2,13.4"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O213">
      <attribute name="obj_pos">
        <point val="13.4,11.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.4,11.8;13.4,12.3"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="13.4,11.8"/>
        <point val="13.4,12.3"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O214">
      <attribute name="obj_pos">
        <point val="14.6,11.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.6,11.8;14.6,12.3"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="14.6,11.8"/>
        <point val="14.6,12.3"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O215">
      <attribute name="obj_pos">
        <point val="15.8,11.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.8,11.8;15.8,12.3"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="15.8,11.8"/>
        <point val="15.8,12.3"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O216">
      <attribute name="obj_pos">
        <point val="17,11.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17,11.8;17,12.3"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="17,11.8"/>
        <point val="17,12.3"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O217">
      <attribute name="obj_pos">
        <point val="18.2,11.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.2,11.8;18.2,12.3"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="18.2,11.8"/>
        <point val="18.2,12.3"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O218">
      <attribute name="obj_pos">
        <point val="19.4,11.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.4,11.8;19.4,12.3"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="19.4,11.8"/>
        <point val="19.4,12.3"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O219">
      <attribute name="obj_pos">
        <point val="20.6,11.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="20.6,11.8;20.6,12.3"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="20.6,11.8"/>
        <point val="20.6,12.3"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O220">
      <attribute name="obj_pos">
        <point val="19.4,12.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.4,12.9;19.4,13.4"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="19.4,12.9"/>
        <point val="19.4,13.4"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O221">
      <attribute name="obj_pos">
        <point val="20.6,12.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="20.6,12.9;20.6,13.4"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="20.6,12.9"/>
        <point val="20.6,13.4"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O222">
      <attribute name="obj_pos">
        <point val="21.8,11.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.8,11.8;21.8,12.3"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="21.8,11.8"/>
        <point val="21.8,12.3"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O223">
      <attribute name="obj_pos">
        <point val="21.8,12.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.8,12.9;21.8,13.4"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="21.8,12.9"/>
        <point val="21.8,13.4"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O224">
      <attribute name="obj_pos">
        <point val="23,11.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23,11.8;23,12.3"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="23,11.8"/>
        <point val="23,12.3"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O225">
      <attribute name="obj_pos">
        <point val="23,12.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23,12.9;23,13.4"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="23,12.9"/>
        <point val="23,13.4"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O226">
      <attribute name="obj_pos">
        <point val="22.4,11.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.4,11.8;22.4,12.3"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="22.4,11.8"/>
        <point val="22.4,12.3"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O227">
      <attribute name="obj_pos">
        <point val="22.4,12.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.4,12.9;22.4,13.4"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="22.4,12.9"/>
        <point val="22.4,13.4"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O228">
      <attribute name="obj_pos">
        <point val="23.6,11.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.6,11.8;23.6,12.3"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="23.6,11.8"/>
        <point val="23.6,12.3"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O229">
      <attribute name="obj_pos">
        <point val="23.6,12.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.6,12.9;23.6,13.4"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="23.6,12.9"/>
        <point val="23.6,13.4"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O230">
      <attribute name="obj_pos">
        <point val="7.2,15.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.2,15.1;7.2,15.6"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="7.2,15.1"/>
        <point val="7.2,15.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O231">
      <attribute name="obj_pos">
        <point val="7.2,14"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.2,14;7.2,14.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="7.2,14"/>
        <point val="7.2,14.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O232">
      <attribute name="obj_pos">
        <point val="9.2,15.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2,15.1;9.2,15.6"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="9.2,15.1"/>
        <point val="9.2,15.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O233">
      <attribute name="obj_pos">
        <point val="9.2,14"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2,14;9.2,14.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="9.2,14"/>
        <point val="9.2,14.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O234">
      <attribute name="obj_pos">
        <point val="13.4,15.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.4,15.1;13.4,15.6"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="13.4,15.1"/>
        <point val="13.4,15.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O235">
      <attribute name="obj_pos">
        <point val="10.7,14"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.7,14;10.7,14.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="10.7,14"/>
        <point val="10.7,14.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O236">
      <attribute name="obj_pos">
        <point val="14.6,15.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.6,15.1;14.6,15.6"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="14.6,15.1"/>
        <point val="14.6,15.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O237">
      <attribute name="obj_pos">
        <point val="15.8,15.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.8,15.1;15.8,15.6"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="15.8,15.1"/>
        <point val="15.8,15.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O238">
      <attribute name="obj_pos">
        <point val="17,15.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17,15.1;17,15.6"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="17,15.1"/>
        <point val="17,15.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O239">
      <attribute name="obj_pos">
        <point val="12.2,14"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.2,14;12.2,14.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="12.2,14"/>
        <point val="12.2,14.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O240">
      <attribute name="obj_pos">
        <point val="18.2,15.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.2,15.1;18.2,15.6"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="18.2,15.1"/>
        <point val="18.2,15.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O241">
      <attribute name="obj_pos">
        <point val="10.7,15.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.7,15.1;10.7,15.6"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="10.7,15.1"/>
        <point val="10.7,15.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O242">
      <attribute name="obj_pos">
        <point val="12.2,15.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.2,15.1;12.2,15.6"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="12.2,15.1"/>
        <point val="12.2,15.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O243">
      <attribute name="obj_pos">
        <point val="13.4,14"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.4,14;13.4,14.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="13.4,14"/>
        <point val="13.4,14.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O244">
      <attribute name="obj_pos">
        <point val="14.6,14"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.6,14;14.6,14.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="14.6,14"/>
        <point val="14.6,14.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O245">
      <attribute name="obj_pos">
        <point val="15.8,14"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.8,14;15.8,14.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="15.8,14"/>
        <point val="15.8,14.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O246">
      <attribute name="obj_pos">
        <point val="17,14"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17,14;17,14.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="17,14"/>
        <point val="17,14.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O247">
      <attribute name="obj_pos">
        <point val="18.2,14"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.2,14;18.2,14.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="18.2,14"/>
        <point val="18.2,14.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O248">
      <attribute name="obj_pos">
        <point val="19.4,14"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.4,14;19.4,14.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="19.4,14"/>
        <point val="19.4,14.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O249">
      <attribute name="obj_pos">
        <point val="20.6,14"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="20.6,14;20.6,14.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="20.6,14"/>
        <point val="20.6,14.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O250">
      <attribute name="obj_pos">
        <point val="19.4,15.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.4,15.1;19.4,15.6"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="19.4,15.1"/>
        <point val="19.4,15.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O251">
      <attribute name="obj_pos">
        <point val="20.6,15.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="20.6,15.1;20.6,15.6"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="20.6,15.1"/>
        <point val="20.6,15.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O252">
      <attribute name="obj_pos">
        <point val="21.8,14"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.8,14;21.8,14.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="21.8,14"/>
        <point val="21.8,14.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O253">
      <attribute name="obj_pos">
        <point val="21.8,15.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.8,15.1;21.8,15.6"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="21.8,15.1"/>
        <point val="21.8,15.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O254">
      <attribute name="obj_pos">
        <point val="23,14"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23,14;23,14.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="23,14"/>
        <point val="23,14.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O255">
      <attribute name="obj_pos">
        <point val="23,15.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23,15.1;23,15.6"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="23,15.1"/>
        <point val="23,15.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O256">
      <attribute name="obj_pos">
        <point val="22.4,14"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.4,14;22.4,14.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="22.4,14"/>
        <point val="22.4,14.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O257">
      <attribute name="obj_pos">
        <point val="22.4,15.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.4,15.1;22.4,15.6"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="22.4,15.1"/>
        <point val="22.4,15.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O258">
      <attribute name="obj_pos">
        <point val="23.6,14"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.6,14;23.6,14.5"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="23.6,14"/>
        <point val="23.6,14.5"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O259">
      <attribute name="obj_pos">
        <point val="23.6,15.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.6,15.1;23.6,15.6"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="23.6,15.1"/>
        <point val="23.6,15.6"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O260">
      <attribute name="obj_pos">
        <point val="7.2,17.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.2,17.3;7.2,17.8"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="7.2,17.3"/>
        <point val="7.2,17.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O261">
      <attribute name="obj_pos">
        <point val="7.2,16.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.2,16.2;7.2,16.7"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="7.2,16.2"/>
        <point val="7.2,16.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O262">
      <attribute name="obj_pos">
        <point val="9.2,17.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2,17.3;9.2,17.8"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="9.2,17.3"/>
        <point val="9.2,17.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O263">
      <attribute name="obj_pos">
        <point val="9.2,16.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2,16.2;9.2,16.7"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="9.2,16.2"/>
        <point val="9.2,16.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O264">
      <attribute name="obj_pos">
        <point val="13.4,17.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.4,17.3;13.4,17.8"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="13.4,17.3"/>
        <point val="13.4,17.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O265">
      <attribute name="obj_pos">
        <point val="10.7,16.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.7,16.2;10.7,16.7"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="10.7,16.2"/>
        <point val="10.7,16.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O266">
      <attribute name="obj_pos">
        <point val="14.6,17.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.6,17.3;14.6,17.8"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="14.6,17.3"/>
        <point val="14.6,17.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O267">
      <attribute name="obj_pos">
        <point val="15.8,17.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.8,17.3;15.8,17.8"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="15.8,17.3"/>
        <point val="15.8,17.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O268">
      <attribute name="obj_pos">
        <point val="17,17.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17,17.3;17,17.8"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="17,17.3"/>
        <point val="17,17.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O269">
      <attribute name="obj_pos">
        <point val="12.2,16.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.2,16.2;12.2,16.7"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="12.2,16.2"/>
        <point val="12.2,16.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O270">
      <attribute name="obj_pos">
        <point val="18.2,17.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.2,17.3;18.2,17.8"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="18.2,17.3"/>
        <point val="18.2,17.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O271">
      <attribute name="obj_pos">
        <point val="10.7,17.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.7,17.3;10.7,17.8"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="10.7,17.3"/>
        <point val="10.7,17.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O272">
      <attribute name="obj_pos">
        <point val="12.2,17.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.2,17.3;12.2,17.8"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="12.2,17.3"/>
        <point val="12.2,17.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O273">
      <attribute name="obj_pos">
        <point val="13.4,16.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.4,16.2;13.4,16.7"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="13.4,16.2"/>
        <point val="13.4,16.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O274">
      <attribute name="obj_pos">
        <point val="14.6,16.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.6,16.2;14.6,16.7"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="14.6,16.2"/>
        <point val="14.6,16.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O275">
      <attribute name="obj_pos">
        <point val="15.8,16.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.8,16.2;15.8,16.7"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="15.8,16.2"/>
        <point val="15.8,16.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O276">
      <attribute name="obj_pos">
        <point val="17,16.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17,16.2;17,16.7"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="17,16.2"/>
        <point val="17,16.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O277">
      <attribute name="obj_pos">
        <point val="18.2,16.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.2,16.2;18.2,16.7"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="18.2,16.2"/>
        <point val="18.2,16.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O278">
      <attribute name="obj_pos">
        <point val="19.4,16.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.4,16.2;19.4,16.7"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="19.4,16.2"/>
        <point val="19.4,16.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O279">
      <attribute name="obj_pos">
        <point val="20.6,16.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="20.6,16.2;20.6,16.7"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="20.6,16.2"/>
        <point val="20.6,16.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O280">
      <attribute name="obj_pos">
        <point val="19.4,17.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.4,17.3;19.4,17.8"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="19.4,17.3"/>
        <point val="19.4,17.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O281">
      <attribute name="obj_pos">
        <point val="20.6,17.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="20.6,17.3;20.6,17.8"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="20.6,17.3"/>
        <point val="20.6,17.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O282">
      <attribute name="obj_pos">
        <point val="21.8,16.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.8,16.2;21.8,16.7"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="21.8,16.2"/>
        <point val="21.8,16.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O283">
      <attribute name="obj_pos">
        <point val="21.8,17.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.8,17.3;21.8,17.8"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="21.8,17.3"/>
        <point val="21.8,17.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O284">
      <attribute name="obj_pos">
        <point val="23,16.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23,16.2;23,16.7"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="23,16.2"/>
        <point val="23,16.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O285">
      <attribute name="obj_pos">
        <point val="23,17.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23,17.3;23,17.8"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="23,17.3"/>
        <point val="23,17.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O286">
      <attribute name="obj_pos">
        <point val="22.4,16.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.4,16.2;22.4,16.7"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="22.4,16.2"/>
        <point val="22.4,16.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O287">
      <attribute name="obj_pos">
        <point val="22.4,17.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.4,17.3;22.4,17.8"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="22.4,17.3"/>
        <point val="22.4,17.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O288">
      <attribute name="obj_pos">
        <point val="23.6,16.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.6,16.2;23.6,16.7"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="23.6,16.2"/>
        <point val="23.6,16.7"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O289">
      <attribute name="obj_pos">
        <point val="23.6,17.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.6,17.3;23.6,17.8"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="23.6,17.3"/>
        <point val="23.6,17.8"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O290">
      <attribute name="obj_pos">
        <point val="7.2,19.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.2,19.5;7.2,20"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="7.2,19.5"/>
        <point val="7.2,20"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O291">
      <attribute name="obj_pos">
        <point val="7.2,18.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.2,18.4;7.2,18.9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="7.2,18.4"/>
        <point val="7.2,18.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O292">
      <attribute name="obj_pos">
        <point val="9.2,19.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2,19.5;9.2,20"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="9.2,19.5"/>
        <point val="9.2,20"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O293">
      <attribute name="obj_pos">
        <point val="9.2,18.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.2,18.4;9.2,18.9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="9.2,18.4"/>
        <point val="9.2,18.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O294">
      <attribute name="obj_pos">
        <point val="13.4,19.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.4,19.5;13.4,20"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="13.4,19.5"/>
        <point val="13.4,20"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O295">
      <attribute name="obj_pos">
        <point val="10.7,18.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.7,18.4;10.7,18.9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="10.7,18.4"/>
        <point val="10.7,18.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O296">
      <attribute name="obj_pos">
        <point val="14.6,19.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.6,19.5;14.6,20"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="14.6,19.5"/>
        <point val="14.6,20"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O297">
      <attribute name="obj_pos">
        <point val="15.8,19.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.8,19.5;15.8,20"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="15.8,19.5"/>
        <point val="15.8,20"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O298">
      <attribute name="obj_pos">
        <point val="17,19.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17,19.5;17,20"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="17,19.5"/>
        <point val="17,20"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O299">
      <attribute name="obj_pos">
        <point val="12.2,18.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.2,18.4;12.2,18.9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="12.2,18.4"/>
        <point val="12.2,18.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O300">
      <attribute name="obj_pos">
        <point val="18.2,19.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.2,19.5;18.2,20"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="18.2,19.5"/>
        <point val="18.2,20"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O301">
      <attribute name="obj_pos">
        <point val="10.7,19.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.7,19.5;10.7,20"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="10.7,19.5"/>
        <point val="10.7,20"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O302">
      <attribute name="obj_pos">
        <point val="12.2,19.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.2,19.5;12.2,20"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="12.2,19.5"/>
        <point val="12.2,20"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O303">
      <attribute name="obj_pos">
        <point val="13.4,18.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.4,18.4;13.4,18.9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="13.4,18.4"/>
        <point val="13.4,18.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O304">
      <attribute name="obj_pos">
        <point val="14.6,18.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.6,18.4;14.6,18.9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="14.6,18.4"/>
        <point val="14.6,18.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O305">
      <attribute name="obj_pos">
        <point val="15.8,18.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.8,18.4;15.8,18.9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="15.8,18.4"/>
        <point val="15.8,18.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O306">
      <attribute name="obj_pos">
        <point val="17,18.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17,18.4;17,18.9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="17,18.4"/>
        <point val="17,18.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O307">
      <attribute name="obj_pos">
        <point val="18.2,18.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.2,18.4;18.2,18.9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="18.2,18.4"/>
        <point val="18.2,18.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O308">
      <attribute name="obj_pos">
        <point val="19.4,18.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.4,18.4;19.4,18.9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="19.4,18.4"/>
        <point val="19.4,18.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O309">
      <attribute name="obj_pos">
        <point val="20.6,18.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="20.6,18.4;20.6,18.9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="20.6,18.4"/>
        <point val="20.6,18.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O310">
      <attribute name="obj_pos">
        <point val="19.4,19.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.4,19.5;19.4,20"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="19.4,19.5"/>
        <point val="19.4,20"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O311">
      <attribute name="obj_pos">
        <point val="20.6,19.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="20.6,19.5;20.6,20"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="20.6,19.5"/>
        <point val="20.6,20"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O312">
      <attribute name="obj_pos">
        <point val="21.8,18.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.8,18.4;21.8,18.9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="21.8,18.4"/>
        <point val="21.8,18.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O313">
      <attribute name="obj_pos">
        <point val="21.8,19.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.8,19.5;21.8,20"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="21.8,19.5"/>
        <point val="21.8,20"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O314">
      <attribute name="obj_pos">
        <point val="23,18.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23,18.4;23,18.9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="23,18.4"/>
        <point val="23,18.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O315">
      <attribute name="obj_pos">
        <point val="23,19.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23,19.5;23,20"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="23,19.5"/>
        <point val="23,20"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O316">
      <attribute name="obj_pos">
        <point val="22.4,18.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.4,18.4;22.4,18.9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="22.4,18.4"/>
        <point val="22.4,18.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O317">
      <attribute name="obj_pos">
        <point val="22.4,19.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.4,19.5;22.4,20"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="22.4,19.5"/>
        <point val="22.4,20"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O318">
      <attribute name="obj_pos">
        <point val="23.6,18.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.6,18.4;23.6,18.9"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="23.6,18.4"/>
        <point val="23.6,18.9"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
    <object type="Standard - Line" version="0" id="O319">
      <attribute name="obj_pos">
        <point val="23.6,19.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.6,19.5;23.6,20"/>
      </attribute>
      <attribute name="conn_endpoints">
        <point val="23.6,19.5"/>
        <point val="23.6,20"/>
      </attribute>
      <attribute name="numcp">
        <int val="1"/>
      </attribute>
      <attribute name="line_width">
        <real val="0"/>
      </attribute>
    </object>
  </layer>
  <layer name="&#202;&#184;&#187;&#250;" visible="true">
    <object type="Standard - Text" version="0" id="O320">
      <attribute name="obj_pos">
        <point val="1.1,2.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.1,2.62636;3.5745,2.97636"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#191;&#199;&#206;&#197;&#185;&#212;&#176;&#217;&#165;&#179;&#161;&#188;&#165;&#201;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="1.1,2.9"/>
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
    <object type="Standard - Text" version="0" id="O321">
      <attribute name="obj_pos">
        <point val="10.8,2.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.8,2.62636;21.405,2.97636"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#201;&#202;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#161;&#204;&#190;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10.8,2.9"/>
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
    <object type="Standard - Text" version="0" id="O322">
      <attribute name="obj_pos">
        <point val="25.2,3.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="25.2,3.12636;27.6745,3.47636"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#205;&#173;&#161;&#161;&#184;&#250;&#161;&#161;&#180;&#252;&#161;&#161;&#184;&#194;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="25.2,3.4"/>
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
    <object type="Standard - Text" version="0" id="O323">
      <attribute name="obj_pos">
        <point val="6.7,3.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.3465,3.12636;7.0535,3.47636"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#202;&#221;&#197;&#172;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="6.7,3.4"/>
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
    <object type="Standard - Text" version="0" id="O324">
      <attribute name="obj_pos">
        <point val="4.1,3.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="4.1,3.12636;5.8675,3.47636"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#182;&#226;&#161;&#161;&#161;&#161;&#161;&#161;&#179;&#219;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="4.1,3.4"/>
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
    <object type="Standard - Text" version="0" id="O325">
      <attribute name="obj_pos">
        <point val="8.2,3.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.493,3.12636;8.907,3.47636"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#201;&#244;&#176;&#204;&#182;&#232;&#202;&#172;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.2,3.4"/>
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
    <object type="Standard - Text" version="0" id="O326">
      <attribute name="obj_pos">
        <point val="11.5,3.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="10.7576,3.12636;12.2424,3.47636"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#189;&#184;&#183;&#215;(&#198;&#254;)#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.5,3.4"/>
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
    <object type="Standard - Text" version="0" id="O327">
      <attribute name="obj_pos">
        <point val="1,2.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1,2.00909;7.666,2.50909"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#197;&#192;&#191;&#244;&#165;&#222;&#165;&#185;&#165;&#191;&#161;&#188;&#165;&#234;&#165;&#185;&#165;&#200;(&#164;&#189;&#164;&#206;&#194;&#190;)#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.5"/>
          </attribute>
          <attribute name="pos">
            <point val="1,2.4"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
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
    <object type="Standard - Text" version="0" id="O328">
      <attribute name="obj_pos">
        <point val="8.7,2.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="8.7,2.12636;11.1745,2.47636"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#176;&#229;&#206;&#197;&#181;&#161;&#180;&#216;&#204;&#190;&#190;&#206;&#161;&#167;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="8.7,2.4"/>
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
    <object type="Standard - Text" version="0" id="O329">
      <attribute name="obj_pos">
        <point val="28.1,2.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="28.1,2.12636;28.4535,2.47636"/>
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
            <point val="28.1,2.4"/>
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
    <object type="Standard - Text" version="0" id="O330">
      <attribute name="obj_pos">
        <point val="10,3.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.25765,3.12636;10.7424,3.47636"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#189;&#184;&#183;&#215;(&#179;&#176;)#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="10,3.4"/>
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
    <object type="Standard - Text" version="0" id="O331">
      <attribute name="obj_pos">
        <point val="12.8,3.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.2698,3.12636;13.3302,3.47636"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#176;&#204;&#195;&#214;&#163;&#177;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="12.8,3.4"/>
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
    <object type="Standard - Text" version="0" id="O332">
      <attribute name="obj_pos">
        <point val="14,3.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.4697,3.12636;14.5302,3.47636"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#183;&#229;&#191;&#244;&#163;&#177;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="14,3.4"/>
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
    <object type="Standard - Text" version="0" id="O333">
      <attribute name="obj_pos">
        <point val="15.2,3.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="14.6697,3.12636;15.7302,3.47636"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#176;&#204;&#195;&#214;&#163;&#178;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="15.2,3.4"/>
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
    <object type="Standard - Text" version="0" id="O334">
      <attribute name="obj_pos">
        <point val="16.4,3.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.8697,3.12636;16.9302,3.47636"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#183;&#229;&#191;&#244;&#163;&#178;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="16.4,3.4"/>
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
    <object type="Standard - Text" version="0" id="O335">
      <attribute name="obj_pos">
        <point val="17.6,3.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.0698,3.12636;18.1303,3.47636"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#176;&#204;&#195;&#214;&#163;&#179;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="17.6,3.4"/>
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
    <object type="Standard - Text" version="0" id="O336">
      <attribute name="obj_pos">
        <point val="18.8,3.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.2698,3.12636;19.3303,3.47636"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#183;&#229;&#191;&#244;&#163;&#179;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="18.8,3.4"/>
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
    <object type="Standard - Text" version="0" id="O337">
      <attribute name="obj_pos">
        <point val="20,3.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.4698,3.12636;20.5303,3.47636"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#176;&#204;&#195;&#214;&#163;&#180;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="20,3.4"/>
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
    <object type="Standard - Text" version="0" id="O338">
      <attribute name="obj_pos">
        <point val="21.2,3.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="20.6698,3.12636;21.7303,3.47636"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#183;&#229;&#191;&#244;&#163;&#180;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="21.2,3.4"/>
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
    <object type="Standard - Text" version="0" id="O339">
      <attribute name="obj_pos">
        <point val="22.1,3.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.9233,3.12636;22.2768,3.47636"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#196;&#171;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="22.1,3.4"/>
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
    <object type="Standard - Text" version="0" id="O340">
      <attribute name="obj_pos">
        <point val="22.7,3.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.5233,3.12636;22.8768,3.47636"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#195;&#235;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="22.7,3.4"/>
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
    <object type="Standard - Text" version="0" id="O341">
      <attribute name="obj_pos">
        <point val="23.3,3.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.1233,3.12636;23.4768,3.47636"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#205;&#188;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="23.3,3.4"/>
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
    <object type="Standard - Text" version="0" id="O342">
      <attribute name="obj_pos">
        <point val="24,3.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.6465,3.12636;24.3535,3.47636"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#191;&#178;&#193;&#176;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="24,3.4"/>
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
    <object type="Embed - Text" version="0" id="O343">
      <attribute name="obj_pos">
        <point val="27.9,2.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.6274,2.12636;27.9,2.47636"/>
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
            <string>#99,999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="27.9,2.4"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="22.4,2.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.4,2.12636;26.642,2.47636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#MSTYMD#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="22.4,2.4"/>
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
    <object type="Embed - Text" version="0" id="O345">
      <attribute name="obj_pos">
        <point val="11.1,2.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="11.1,2.12636;21.705,2.47636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#HOSPNAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="11.1,2.4"/>
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
    <object type="Embed - Text" version="0" id="O346">
      <attribute name="obj_pos">
        <point val="1.1,4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.1,3.64818;3.5543,4.09818"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[0].SRYCD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#999999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.45"/>
          </attribute>
          <attribute name="pos">
            <point val="1.1,4"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2727"/>
          </attribute>
          <attribute name="multi">
            <real val="0.22725"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O347">
      <attribute name="obj_pos">
        <point val="3.7,4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.7,3.72636;21.375,4.07636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[0].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.7,4"/>
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
    <object type="Embed - Text" version="0" id="O348">
      <attribute name="obj_pos">
        <point val="6.2,4.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.2306,4.22636;6.2,4.57636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[0].TEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999999.99#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="6.2,4.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="7.1,4.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.8879,4.22636;7.1,4.57636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[0].HKNTEK#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#9#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,4.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="7.3,4.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.3,4.22636;9.0675,4.57636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[0].BUI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.3,4.5"/>
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
    <object type="Embed - Text" version="0" id="O351">
      <attribute name="obj_pos">
        <point val="10.6,4.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.9637,4.22636;10.6,4.57636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[0].GAITEN#</string>
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
            <point val="10.6,4.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="12.1,4.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="11.4637,4.22636;12.1,4.57636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[0].NYUTEN#</string>
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
            <point val="12.1,4.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="13.3,4.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.6637,4.22636;13.3,4.57636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[0].KRM1#</string>
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
            <point val="13.3,4.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="14.5,4.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.8637,4.22636;14.5,4.57636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[0].KET1#</string>
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
            <point val="14.5,4.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="24.5,4.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.5,4.22636;26.1968,4.57636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[0].YUKOSTYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#00000000#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="24.5,4.5"/>
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
    <object type="Embed - Text" version="0" id="O356">
      <attribute name="obj_pos">
        <point val="26.3,4.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.3,4.22636;26.5121,4.57636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[0].NYORO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#-#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.3,4.5"/>
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
    <object type="Embed - Text" version="0" id="O357">
      <attribute name="obj_pos">
        <point val="26.6,4.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.6,4.22636;28.2968,4.57636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[0].YUKOEDYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,4.5"/>
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
    <object type="Embed - Text" version="0" id="O358">
      <attribute name="obj_pos">
        <point val="22.1,4.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.9233,4.22636;22.2768,4.57636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[0].FUKUYOU1#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="22.1,4.5"/>
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
    <object type="Embed - Text" version="0" id="O359">
      <attribute name="obj_pos">
        <point val="15.7,4.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.0637,4.22636;15.7,4.57636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[0].KRM2#</string>
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
            <point val="15.7,4.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="16.9,4.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.2637,4.22636;16.9,4.57636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[0].KET2#</string>
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
            <point val="16.9,4.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="18.1,4.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.4637,4.22636;18.1,4.57636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[0].KRM3#</string>
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
            <point val="18.1,4.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="19.3,4.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.6637,4.22636;19.3,4.57636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[0].KET3#</string>
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
            <point val="19.3,4.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="20.5,4.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.8637,4.22636;20.5,4.57636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[0].KRM4#</string>
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
            <point val="20.5,4.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="21.7,4.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.0637,4.22636;21.7,4.57636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[0].KET4#</string>
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
            <point val="21.7,4.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="22.7,4.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.5233,4.22636;22.8768,4.57636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[0].FUKUYOU2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="22.7,4.5"/>
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
    <object type="Embed - Text" version="0" id="O366">
      <attribute name="obj_pos">
        <point val="23.3,4.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.1233,4.22636;23.4768,4.57636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[0].FUKUYOU3#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="23.3,4.5"/>
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
    <object type="Embed - Text" version="0" id="O367">
      <attribute name="obj_pos">
        <point val="24,4.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.8233,4.22636;24.1768,4.57636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[0].FUKUYOU4#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="24,4.5"/>
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
    <object type="Embed - Text" version="0" id="O368">
      <attribute name="obj_pos">
        <point val="1.1,5.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.1,4.74818;3.5543,5.19818"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[1].SRYCD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#999999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.45"/>
          </attribute>
          <attribute name="pos">
            <point val="1.1,5.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2727"/>
          </attribute>
          <attribute name="multi">
            <real val="0.22725"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O369">
      <attribute name="obj_pos">
        <point val="3.7,5.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.7,4.82636;21.375,5.17636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[1].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.7,5.1"/>
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
    <object type="Embed - Text" version="0" id="O370">
      <attribute name="obj_pos">
        <point val="6.2,5.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.2306,5.32636;6.2,5.67636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[1].TEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999999.99#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="6.2,5.6"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="7.1,5.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.8879,5.32636;7.1,5.67636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[1].HKNTEK#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#9#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,5.6"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="7.3,5.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.3,5.32636;9.0675,5.67636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[1].BUI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.3,5.6"/>
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
    <object type="Embed - Text" version="0" id="O373">
      <attribute name="obj_pos">
        <point val="10.6,5.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.9637,5.32636;10.6,5.67636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[1].GAITEN#</string>
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
            <point val="10.6,5.6"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="12.1,5.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="11.4637,5.32636;12.1,5.67636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[1].NYUTEN#</string>
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
            <point val="12.1,5.6"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="13.3,5.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.6637,5.32636;13.3,5.67636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[1].KRM1#</string>
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
            <point val="13.3,5.6"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="14.5,5.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.8637,5.32636;14.5,5.67636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[1].KET1#</string>
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
            <point val="14.5,5.6"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="24.5,5.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.5,5.32636;26.1968,5.67636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[1].YUKOSTYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#00000000#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="24.5,5.6"/>
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
    <object type="Embed - Text" version="0" id="O378">
      <attribute name="obj_pos">
        <point val="26.3,5.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.3,5.32636;26.5121,5.67636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[1].NYORO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#-#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.3,5.6"/>
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
    <object type="Embed - Text" version="0" id="O379">
      <attribute name="obj_pos">
        <point val="26.6,5.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.6,5.32636;28.2968,5.67636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[1].YUKOEDYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,5.6"/>
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
    <object type="Embed - Text" version="0" id="O380">
      <attribute name="obj_pos">
        <point val="22.1,5.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.9233,5.32636;22.2768,5.67636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[1].FUKUYOU1#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="22.1,5.6"/>
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
    <object type="Embed - Text" version="0" id="O381">
      <attribute name="obj_pos">
        <point val="15.7,5.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.0637,5.32636;15.7,5.67636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[1].KRM2#</string>
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
            <point val="15.7,5.6"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="16.9,5.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.2637,5.32636;16.9,5.67636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[1].KET2#</string>
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
            <point val="16.9,5.6"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="18.1,5.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.4637,5.32636;18.1,5.67636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[1].KRM3#</string>
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
            <point val="18.1,5.6"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="19.3,5.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.6637,5.32636;19.3,5.67636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[1].KET3#</string>
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
            <point val="19.3,5.6"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="20.5,5.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.8637,5.32636;20.5,5.67636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[1].KRM4#</string>
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
            <point val="20.5,5.6"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="21.7,5.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.0637,5.32636;21.7,5.67636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[1].KET4#</string>
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
            <point val="21.7,5.6"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="22.7,5.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.5233,5.32636;22.8768,5.67636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[1].FUKUYOU2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="22.7,5.6"/>
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
    <object type="Embed - Text" version="0" id="O388">
      <attribute name="obj_pos">
        <point val="23.3,5.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.1233,5.32636;23.4768,5.67636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[1].FUKUYOU3#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="23.3,5.6"/>
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
    <object type="Embed - Text" version="0" id="O389">
      <attribute name="obj_pos">
        <point val="24,5.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.8233,5.32636;24.1768,5.67636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[1].FUKUYOU4#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="24,5.6"/>
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
    <object type="Embed - Text" version="0" id="O390">
      <attribute name="obj_pos">
        <point val="1.1,6.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.1,5.84818;3.5543,6.29818"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[2].SRYCD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#999999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.45"/>
          </attribute>
          <attribute name="pos">
            <point val="1.1,6.2"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2727"/>
          </attribute>
          <attribute name="multi">
            <real val="0.22725"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O391">
      <attribute name="obj_pos">
        <point val="3.7,6.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.7,5.92636;21.375,6.27636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[2].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.7,6.2"/>
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
    <object type="Embed - Text" version="0" id="O392">
      <attribute name="obj_pos">
        <point val="6.2,6.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.2306,6.42636;6.2,6.77636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[2].TEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999999.99#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="6.2,6.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="7.1,6.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.8879,6.42636;7.1,6.77636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[2].HKNTEK#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#9#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,6.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="7.3,6.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.3,6.42636;9.0675,6.77636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[2].BUI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.3,6.7"/>
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
    <object type="Embed - Text" version="0" id="O395">
      <attribute name="obj_pos">
        <point val="10.6,6.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.9637,6.42636;10.6,6.77636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[2].GAITEN#</string>
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
            <point val="10.6,6.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="12.1,6.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="11.4637,6.42636;12.1,6.77636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[2].NYUTEN#</string>
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
            <point val="12.1,6.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="13.3,6.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.6637,6.42636;13.3,6.77636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[2].KRM1#</string>
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
            <point val="13.3,6.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="14.5,6.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.8637,6.42636;14.5,6.77636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[2].KET1#</string>
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
            <point val="14.5,6.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="24.5,6.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.5,6.42636;26.1968,6.77636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[2].YUKOSTYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#00000000#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="24.5,6.7"/>
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
    <object type="Embed - Text" version="0" id="O400">
      <attribute name="obj_pos">
        <point val="26.3,6.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.3,6.42636;26.5121,6.77636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[2].NYORO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#-#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.3,6.7"/>
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
    <object type="Embed - Text" version="0" id="O401">
      <attribute name="obj_pos">
        <point val="26.6,6.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.6,6.42636;28.2968,6.77636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[2].YUKOEDYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,6.7"/>
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
    <object type="Embed - Text" version="0" id="O402">
      <attribute name="obj_pos">
        <point val="22.1,6.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.9233,6.42636;22.2768,6.77636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[2].FUKUYOU1#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="22.1,6.7"/>
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
    <object type="Embed - Text" version="0" id="O403">
      <attribute name="obj_pos">
        <point val="15.7,6.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.0637,6.42636;15.7,6.77636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[2].KRM2#</string>
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
            <point val="15.7,6.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="16.9,6.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.2637,6.42636;16.9,6.77636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[2].KET2#</string>
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
            <point val="16.9,6.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="18.1,6.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.4637,6.42636;18.1,6.77636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[2].KRM3#</string>
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
            <point val="18.1,6.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="19.3,6.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.6637,6.42636;19.3,6.77636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[2].KET3#</string>
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
            <point val="19.3,6.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="20.5,6.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.8637,6.42636;20.5,6.77636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[2].KRM4#</string>
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
            <point val="20.5,6.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="21.7,6.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.0637,6.42636;21.7,6.77636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[2].KET4#</string>
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
            <point val="21.7,6.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="22.7,6.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.5233,6.42636;22.8768,6.77636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[2].FUKUYOU2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="22.7,6.7"/>
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
    <object type="Embed - Text" version="0" id="O410">
      <attribute name="obj_pos">
        <point val="23.3,6.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.1233,6.42636;23.4768,6.77636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[2].FUKUYOU3#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="23.3,6.7"/>
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
    <object type="Embed - Text" version="0" id="O411">
      <attribute name="obj_pos">
        <point val="24,6.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.8233,6.42636;24.1768,6.77636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[2].FUKUYOU4#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="24,6.7"/>
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
    <object type="Embed - Text" version="0" id="O412">
      <attribute name="obj_pos">
        <point val="1.1,7.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.1,6.94818;3.5543,7.39818"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[3].SRYCD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#999999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.45"/>
          </attribute>
          <attribute name="pos">
            <point val="1.1,7.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2727"/>
          </attribute>
          <attribute name="multi">
            <real val="0.22725"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O413">
      <attribute name="obj_pos">
        <point val="3.7,7.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.7,7.02636;21.375,7.37636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[3].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.7,7.3"/>
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
    <object type="Embed - Text" version="0" id="O414">
      <attribute name="obj_pos">
        <point val="6.2,7.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.2306,7.52636;6.2,7.87636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[3].TEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999999.99#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="6.2,7.8"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="7.1,7.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.8879,7.52636;7.1,7.87636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[3].HKNTEK#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#9#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,7.8"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="7.3,7.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.3,7.52636;9.0675,7.87636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[3].BUI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.3,7.8"/>
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
    <object type="Embed - Text" version="0" id="O417">
      <attribute name="obj_pos">
        <point val="10.6,7.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.9637,7.52636;10.6,7.87636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[3].GAITEN#</string>
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
            <point val="10.6,7.8"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="12.1,7.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="11.4637,7.52636;12.1,7.87636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[3].NYUTEN#</string>
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
            <point val="12.1,7.8"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="13.3,7.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.6637,7.52636;13.3,7.87636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[3].KRM1#</string>
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
            <point val="13.3,7.8"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="14.5,7.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.8637,7.52636;14.5,7.87636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[3].KET1#</string>
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
            <point val="14.5,7.8"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="24.5,7.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.5,7.52636;26.1968,7.87636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[3].YUKOSTYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#00000000#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="24.5,7.8"/>
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
    <object type="Embed - Text" version="0" id="O422">
      <attribute name="obj_pos">
        <point val="26.3,7.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.3,7.52636;26.5121,7.87636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[3].NYORO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#-#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.3,7.8"/>
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
    <object type="Embed - Text" version="0" id="O423">
      <attribute name="obj_pos">
        <point val="26.6,7.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.6,7.52636;28.2968,7.87636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[3].YUKOEDYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,7.8"/>
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
    <object type="Embed - Text" version="0" id="O424">
      <attribute name="obj_pos">
        <point val="22.1,7.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.9233,7.52636;22.2768,7.87636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[3].FUKUYOU1#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="22.1,7.8"/>
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
    <object type="Embed - Text" version="0" id="O425">
      <attribute name="obj_pos">
        <point val="15.7,7.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.0637,7.52636;15.7,7.87636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[3].KRM2#</string>
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
            <point val="15.7,7.8"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="16.9,7.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.2637,7.52636;16.9,7.87636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[3].KET2#</string>
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
            <point val="16.9,7.8"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="18.1,7.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.4637,7.52636;18.1,7.87636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[3].KRM3#</string>
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
            <point val="18.1,7.8"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="19.3,7.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.6637,7.52636;19.3,7.87636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[3].KET3#</string>
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
            <point val="19.3,7.8"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="20.5,7.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.8637,7.52636;20.5,7.87636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[3].KRM4#</string>
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
            <point val="20.5,7.8"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="21.7,7.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.0637,7.52636;21.7,7.87636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[3].KET4#</string>
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
            <point val="21.7,7.8"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="22.7,7.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.5233,7.52636;22.8768,7.87636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[3].FUKUYOU2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="22.7,7.8"/>
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
    <object type="Embed - Text" version="0" id="O432">
      <attribute name="obj_pos">
        <point val="23.3,7.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.1233,7.52636;23.4768,7.87636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[3].FUKUYOU3#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="23.3,7.8"/>
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
    <object type="Embed - Text" version="0" id="O433">
      <attribute name="obj_pos">
        <point val="24,7.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.8233,7.52636;24.1768,7.87636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[3].FUKUYOU4#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="24,7.8"/>
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
    <object type="Embed - Text" version="0" id="O434">
      <attribute name="obj_pos">
        <point val="1.1,8.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.1,8.04818;3.5543,8.49818"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[4].SRYCD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#999999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.45"/>
          </attribute>
          <attribute name="pos">
            <point val="1.1,8.4"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2727"/>
          </attribute>
          <attribute name="multi">
            <real val="0.22725"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O435">
      <attribute name="obj_pos">
        <point val="3.7,8.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.7,8.12636;21.375,8.47636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[4].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.7,8.4"/>
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
    <object type="Embed - Text" version="0" id="O436">
      <attribute name="obj_pos">
        <point val="6.2,8.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.2306,8.62636;6.2,8.97636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[4].TEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999999.99#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="6.2,8.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="7.1,8.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.8879,8.62636;7.1,8.97636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[4].HKNTEK#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#9#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,8.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="7.3,8.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.3,8.62636;9.0675,8.97636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[4].BUI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.3,8.9"/>
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
    <object type="Embed - Text" version="0" id="O439">
      <attribute name="obj_pos">
        <point val="10.6,8.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.9637,8.62636;10.6,8.97636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[4].GAITEN#</string>
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
            <point val="10.6,8.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="12.1,8.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="11.4637,8.62636;12.1,8.97636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[4].NYUTEN#</string>
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
            <point val="12.1,8.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="13.3,8.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.6637,8.62636;13.3,8.97636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[4].KRM1#</string>
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
            <point val="13.3,8.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="14.5,8.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.8637,8.62636;14.5,8.97636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[4].KET1#</string>
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
            <point val="14.5,8.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="24.5,8.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.5,8.62636;26.1968,8.97636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[4].YUKOSTYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#00000000#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="24.5,8.9"/>
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
    <object type="Embed - Text" version="0" id="O444">
      <attribute name="obj_pos">
        <point val="26.3,8.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.3,8.62636;26.5121,8.97636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[4].NYORO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#-#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.3,8.9"/>
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
    <object type="Embed - Text" version="0" id="O445">
      <attribute name="obj_pos">
        <point val="26.6,8.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.6,8.62636;28.2968,8.97636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[4].YUKOEDYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,8.9"/>
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
    <object type="Embed - Text" version="0" id="O446">
      <attribute name="obj_pos">
        <point val="22.1,8.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.9233,8.62636;22.2768,8.97636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[4].FUKUYOU1#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="22.1,8.9"/>
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
    <object type="Embed - Text" version="0" id="O447">
      <attribute name="obj_pos">
        <point val="15.7,8.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.0637,8.62636;15.7,8.97636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[4].KRM2#</string>
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
            <point val="15.7,8.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="16.9,8.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.2637,8.62636;16.9,8.97636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[4].KET2#</string>
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
            <point val="16.9,8.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="18.1,8.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.4637,8.62636;18.1,8.97636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[4].KRM3#</string>
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
            <point val="18.1,8.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="19.3,8.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.6637,8.62636;19.3,8.97636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[4].KET3#</string>
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
            <point val="19.3,8.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="20.5,8.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.8637,8.62636;20.5,8.97636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[4].KRM4#</string>
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
            <point val="20.5,8.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="21.7,8.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.0637,8.62636;21.7,8.97636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[4].KET4#</string>
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
            <point val="21.7,8.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="22.7,8.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.5233,8.62636;22.8768,8.97636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[4].FUKUYOU2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="22.7,8.9"/>
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
    <object type="Embed - Text" version="0" id="O454">
      <attribute name="obj_pos">
        <point val="23.3,8.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.1233,8.62636;23.4768,8.97636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[4].FUKUYOU3#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="23.3,8.9"/>
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
    <object type="Embed - Text" version="0" id="O455">
      <attribute name="obj_pos">
        <point val="24,8.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.8233,8.62636;24.1768,8.97636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[4].FUKUYOU4#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="24,8.9"/>
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
    <object type="Embed - Text" version="0" id="O456">
      <attribute name="obj_pos">
        <point val="1.1,9.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.1,9.14818;3.5543,9.59818"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[5].SRYCD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#999999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.45"/>
          </attribute>
          <attribute name="pos">
            <point val="1.1,9.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2727"/>
          </attribute>
          <attribute name="multi">
            <real val="0.22725"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O457">
      <attribute name="obj_pos">
        <point val="3.7,9.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.7,9.22636;21.375,9.57636"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[5].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.7,9.5"/>
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
    <object type="Embed - Text" version="0" id="O458">
      <attribute name="obj_pos">
        <point val="6.2,10"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.2306,9.72636;6.2,10.0764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[5].TEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999999.99#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="6.2,10"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="7.1,10"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.8879,9.72636;7.1,10.0764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[5].HKNTEK#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#9#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,10"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="7.3,10"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.3,9.72636;9.0675,10.0764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[5].BUI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.3,10"/>
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
    <object type="Embed - Text" version="0" id="O461">
      <attribute name="obj_pos">
        <point val="10.6,10"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.9637,9.72636;10.6,10.0764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[5].GAITEN#</string>
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
            <point val="10.6,10"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="12.1,10"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="11.4637,9.72636;12.1,10.0764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[5].NYUTEN#</string>
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
            <point val="12.1,10"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="13.3,10"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.6637,9.72636;13.3,10.0764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[5].KRM1#</string>
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
            <point val="13.3,10"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="14.5,10"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.8637,9.72636;14.5,10.0764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[5].KET1#</string>
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
            <point val="14.5,10"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="24.5,10"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.5,9.72636;26.1968,10.0764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[5].YUKOSTYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#00000000#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="24.5,10"/>
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
    <object type="Embed - Text" version="0" id="O466">
      <attribute name="obj_pos">
        <point val="26.3,10"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.3,9.72636;26.5121,10.0764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[5].NYORO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#-#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.3,10"/>
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
    <object type="Embed - Text" version="0" id="O467">
      <attribute name="obj_pos">
        <point val="26.6,10"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.6,9.72636;28.2968,10.0764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[5].YUKOEDYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,10"/>
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
    <object type="Embed - Text" version="0" id="O468">
      <attribute name="obj_pos">
        <point val="22.1,10"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.9233,9.72636;22.2768,10.0764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[5].FUKUYOU1#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="22.1,10"/>
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
    <object type="Embed - Text" version="0" id="O469">
      <attribute name="obj_pos">
        <point val="15.7,10"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.0637,9.72636;15.7,10.0764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[5].KRM2#</string>
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
            <point val="15.7,10"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="16.9,10"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.2637,9.72636;16.9,10.0764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[5].KET2#</string>
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
            <point val="16.9,10"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="18.1,10"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.4637,9.72636;18.1,10.0764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[5].KRM3#</string>
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
            <point val="18.1,10"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="19.3,10"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.6637,9.72636;19.3,10.0764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[5].KET3#</string>
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
            <point val="19.3,10"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="20.5,10"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.8637,9.72636;20.5,10.0764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[5].KRM4#</string>
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
            <point val="20.5,10"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="21.7,10"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.0637,9.72636;21.7,10.0764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[5].KET4#</string>
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
            <point val="21.7,10"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="22.7,10"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.5233,9.72636;22.8768,10.0764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[5].FUKUYOU2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="22.7,10"/>
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
    <object type="Embed - Text" version="0" id="O476">
      <attribute name="obj_pos">
        <point val="23.3,10"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.1233,9.72636;23.4768,10.0764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[5].FUKUYOU3#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="23.3,10"/>
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
    <object type="Embed - Text" version="0" id="O477">
      <attribute name="obj_pos">
        <point val="24,10"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.8233,9.72636;24.1768,10.0764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[5].FUKUYOU4#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="24,10"/>
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
    <object type="Embed - Text" version="0" id="O478">
      <attribute name="obj_pos">
        <point val="1.1,10.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.1,10.2482;3.5543,10.6982"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[6].SRYCD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#999999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.45"/>
          </attribute>
          <attribute name="pos">
            <point val="1.1,10.6"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2727"/>
          </attribute>
          <attribute name="multi">
            <real val="0.22725"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O479">
      <attribute name="obj_pos">
        <point val="3.7,10.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.7,10.3264;21.375,10.6764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[6].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.7,10.6"/>
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
    <object type="Embed - Text" version="0" id="O480">
      <attribute name="obj_pos">
        <point val="6.2,11.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.2306,10.8264;6.2,11.1764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[6].TEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999999.99#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="6.2,11.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="7.1,11.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.8879,10.8264;7.1,11.1764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[6].HKNTEK#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#9#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
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
        <point val="7.3,11.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.3,10.8264;9.0675,11.1764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[6].BUI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.3,11.1"/>
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
    <object type="Embed - Text" version="0" id="O483">
      <attribute name="obj_pos">
        <point val="10.6,11.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.9637,10.8264;10.6,11.1764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[6].GAITEN#</string>
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
            <point val="10.6,11.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="12.1,11.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="11.4637,10.8264;12.1,11.1764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[6].NYUTEN#</string>
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
            <point val="12.1,11.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="13.3,11.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.6637,10.8264;13.3,11.1764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[6].KRM1#</string>
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
            <point val="13.3,11.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="14.5,11.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.8637,10.8264;14.5,11.1764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[6].KET1#</string>
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
            <point val="14.5,11.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="24.5,11.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.5,10.8264;26.1968,11.1764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[6].YUKOSTYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#00000000#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="24.5,11.1"/>
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
    <object type="Embed - Text" version="0" id="O488">
      <attribute name="obj_pos">
        <point val="26.3,11.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.3,10.8264;26.5121,11.1764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[6].NYORO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#-#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.3,11.1"/>
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
    <object type="Embed - Text" version="0" id="O489">
      <attribute name="obj_pos">
        <point val="26.6,11.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.6,10.8264;28.2968,11.1764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[6].YUKOEDYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,11.1"/>
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
    <object type="Embed - Text" version="0" id="O490">
      <attribute name="obj_pos">
        <point val="22.1,11.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.9233,10.8264;22.2768,11.1764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[6].FUKUYOU1#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="22.1,11.1"/>
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
    <object type="Embed - Text" version="0" id="O491">
      <attribute name="obj_pos">
        <point val="15.7,11.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.0637,10.8264;15.7,11.1764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[6].KRM2#</string>
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
            <point val="15.7,11.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="16.9,11.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.2637,10.8264;16.9,11.1764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[6].KET2#</string>
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
            <point val="16.9,11.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="18.1,11.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.4637,10.8264;18.1,11.1764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[6].KRM3#</string>
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
            <point val="18.1,11.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="19.3,11.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.6637,10.8264;19.3,11.1764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[6].KET3#</string>
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
            <point val="19.3,11.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="20.5,11.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.8637,10.8264;20.5,11.1764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[6].KRM4#</string>
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
            <point val="20.5,11.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="21.7,11.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.0637,10.8264;21.7,11.1764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[6].KET4#</string>
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
            <point val="21.7,11.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="22.7,11.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.5233,10.8264;22.8768,11.1764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[6].FUKUYOU2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="22.7,11.1"/>
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
    <object type="Embed - Text" version="0" id="O498">
      <attribute name="obj_pos">
        <point val="23.3,11.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.1233,10.8264;23.4768,11.1764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[6].FUKUYOU3#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="23.3,11.1"/>
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
    <object type="Embed - Text" version="0" id="O499">
      <attribute name="obj_pos">
        <point val="24,11.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.8233,10.8264;24.1768,11.1764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[6].FUKUYOU4#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="24,11.1"/>
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
    <object type="Embed - Text" version="0" id="O500">
      <attribute name="obj_pos">
        <point val="1.1,11.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.1,11.3482;3.5543,11.7982"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[7].SRYCD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#999999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.45"/>
          </attribute>
          <attribute name="pos">
            <point val="1.1,11.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2727"/>
          </attribute>
          <attribute name="multi">
            <real val="0.22725"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O501">
      <attribute name="obj_pos">
        <point val="3.7,11.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.7,11.4264;21.375,11.7764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[7].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.7,11.7"/>
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
    <object type="Embed - Text" version="0" id="O502">
      <attribute name="obj_pos">
        <point val="6.2,12.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.2306,11.9264;6.2,12.2764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[7].TEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999999.99#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="6.2,12.2"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="7.1,12.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.8879,11.9264;7.1,12.2764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[7].HKNTEK#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#9#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,12.2"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="7.3,12.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.3,11.9264;9.0675,12.2764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[7].BUI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.3,12.2"/>
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
    <object type="Embed - Text" version="0" id="O505">
      <attribute name="obj_pos">
        <point val="10.6,12.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.9637,11.9264;10.6,12.2764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[7].GAITEN#</string>
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
            <point val="10.6,12.2"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="12.1,12.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="11.4637,11.9264;12.1,12.2764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[7].NYUTEN#</string>
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
            <point val="12.1,12.2"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="13.3,12.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.6637,11.9264;13.3,12.2764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[7].KRM1#</string>
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
            <point val="13.3,12.2"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="14.5,12.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.8637,11.9264;14.5,12.2764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[7].KET1#</string>
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
            <point val="14.5,12.2"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="24.5,12.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.5,11.9264;26.1968,12.2764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[7].YUKOSTYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#00000000#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="24.5,12.2"/>
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
    <object type="Embed - Text" version="0" id="O510">
      <attribute name="obj_pos">
        <point val="26.3,12.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.3,11.9264;26.5121,12.2764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[7].NYORO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#-#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.3,12.2"/>
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
    <object type="Embed - Text" version="0" id="O511">
      <attribute name="obj_pos">
        <point val="26.6,12.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.6,11.9264;28.2968,12.2764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[7].YUKOEDYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,12.2"/>
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
    <object type="Embed - Text" version="0" id="O512">
      <attribute name="obj_pos">
        <point val="22.1,12.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.9233,11.9264;22.2768,12.2764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[7].FUKUYOU1#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="22.1,12.2"/>
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
    <object type="Embed - Text" version="0" id="O513">
      <attribute name="obj_pos">
        <point val="15.7,12.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.0637,11.9264;15.7,12.2764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[7].KRM2#</string>
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
            <point val="15.7,12.2"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="16.9,12.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.2637,11.9264;16.9,12.2764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[7].KET2#</string>
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
            <point val="16.9,12.2"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="18.1,12.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.4637,11.9264;18.1,12.2764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[7].KRM3#</string>
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
            <point val="18.1,12.2"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="19.3,12.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.6637,11.9264;19.3,12.2764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[7].KET3#</string>
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
            <point val="19.3,12.2"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O517">
      <attribute name="obj_pos">
        <point val="20.5,12.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.8637,11.9264;20.5,12.2764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[7].KRM4#</string>
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
            <point val="20.5,12.2"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="21.7,12.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.0637,11.9264;21.7,12.2764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[7].KET4#</string>
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
            <point val="21.7,12.2"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="22.7,12.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.5233,11.9264;22.8768,12.2764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[7].FUKUYOU2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="22.7,12.2"/>
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
    <object type="Embed - Text" version="0" id="O520">
      <attribute name="obj_pos">
        <point val="23.3,12.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.1233,11.9264;23.4768,12.2764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[7].FUKUYOU3#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="23.3,12.2"/>
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
    <object type="Embed - Text" version="0" id="O521">
      <attribute name="obj_pos">
        <point val="24,12.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.8233,11.9264;24.1768,12.2764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[7].FUKUYOU4#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="24,12.2"/>
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
    <object type="Embed - Text" version="0" id="O522">
      <attribute name="obj_pos">
        <point val="1.1,12.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.1,12.4482;3.5543,12.8982"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[8].SRYCD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#999999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.45"/>
          </attribute>
          <attribute name="pos">
            <point val="1.1,12.8"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2727"/>
          </attribute>
          <attribute name="multi">
            <real val="0.22725"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O523">
      <attribute name="obj_pos">
        <point val="3.7,12.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.7,12.5264;21.375,12.8764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[8].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.7,12.8"/>
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
    <object type="Embed - Text" version="0" id="O524">
      <attribute name="obj_pos">
        <point val="6.2,13.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.2306,13.0264;6.2,13.3764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[8].TEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999999.99#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="6.2,13.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="7.1,13.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.8879,13.0264;7.1,13.3764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[8].HKNTEK#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#9#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,13.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="7.3,13.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.3,13.0264;9.0675,13.3764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[8].BUI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.3,13.3"/>
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
    <object type="Embed - Text" version="0" id="O527">
      <attribute name="obj_pos">
        <point val="10.6,13.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.9637,13.0264;10.6,13.3764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[8].GAITEN#</string>
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
            <point val="10.6,13.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="12.1,13.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="11.4637,13.0264;12.1,13.3764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[8].NYUTEN#</string>
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
            <point val="12.1,13.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="13.3,13.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.6637,13.0264;13.3,13.3764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[8].KRM1#</string>
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
            <point val="13.3,13.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="14.5,13.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.8637,13.0264;14.5,13.3764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[8].KET1#</string>
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
            <point val="14.5,13.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="24.5,13.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.5,13.0264;26.1968,13.3764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[8].YUKOSTYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#00000000#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="24.5,13.3"/>
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
    <object type="Embed - Text" version="0" id="O532">
      <attribute name="obj_pos">
        <point val="26.3,13.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.3,13.0264;26.5121,13.3764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[8].NYORO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#-#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.3,13.3"/>
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
    <object type="Embed - Text" version="0" id="O533">
      <attribute name="obj_pos">
        <point val="26.6,13.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.6,13.0264;28.2968,13.3764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[8].YUKOEDYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,13.3"/>
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
    <object type="Embed - Text" version="0" id="O534">
      <attribute name="obj_pos">
        <point val="22.1,13.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.9233,13.0264;22.2768,13.3764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[8].FUKUYOU1#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="22.1,13.3"/>
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
    <object type="Embed - Text" version="0" id="O535">
      <attribute name="obj_pos">
        <point val="15.7,13.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.0637,13.0264;15.7,13.3764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[8].KRM2#</string>
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
            <point val="15.7,13.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="16.9,13.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.2637,13.0264;16.9,13.3764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[8].KET2#</string>
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
            <point val="16.9,13.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="18.1,13.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.4637,13.0264;18.1,13.3764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[8].KRM3#</string>
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
            <point val="18.1,13.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="19.3,13.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.6637,13.0264;19.3,13.3764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[8].KET3#</string>
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
            <point val="19.3,13.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="20.5,13.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.8637,13.0264;20.5,13.3764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[8].KRM4#</string>
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
            <point val="20.5,13.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="21.7,13.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.0637,13.0264;21.7,13.3764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[8].KET4#</string>
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
            <point val="21.7,13.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="22.7,13.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.5233,13.0264;22.8768,13.3764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[8].FUKUYOU2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="22.7,13.3"/>
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
    <object type="Embed - Text" version="0" id="O542">
      <attribute name="obj_pos">
        <point val="23.3,13.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.1233,13.0264;23.4768,13.3764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[8].FUKUYOU3#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="23.3,13.3"/>
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
    <object type="Embed - Text" version="0" id="O543">
      <attribute name="obj_pos">
        <point val="24,13.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.8233,13.0264;24.1768,13.3764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[8].FUKUYOU4#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="24,13.3"/>
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
    <object type="Embed - Text" version="0" id="O544">
      <attribute name="obj_pos">
        <point val="1.1,13.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.1,13.5482;3.5543,13.9982"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[9].SRYCD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#999999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.45"/>
          </attribute>
          <attribute name="pos">
            <point val="1.1,13.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2727"/>
          </attribute>
          <attribute name="multi">
            <real val="0.22725"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O545">
      <attribute name="obj_pos">
        <point val="3.7,13.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.7,13.6264;21.375,13.9764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[9].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.7,13.9"/>
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
    <object type="Embed - Text" version="0" id="O546">
      <attribute name="obj_pos">
        <point val="6.2,14.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.2306,14.1264;6.2,14.4764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[9].TEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999999.99#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="6.2,14.4"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O547">
      <attribute name="obj_pos">
        <point val="7.1,14.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.8879,14.1264;7.1,14.4764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[9].HKNTEK#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#9#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,14.4"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="7.3,14.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.3,14.1264;9.0675,14.4764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[9].BUI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.3,14.4"/>
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
    <object type="Embed - Text" version="0" id="O549">
      <attribute name="obj_pos">
        <point val="10.6,14.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.9637,14.1264;10.6,14.4764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[9].GAITEN#</string>
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
            <point val="10.6,14.4"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="12.1,14.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="11.4637,14.1264;12.1,14.4764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[9].NYUTEN#</string>
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
            <point val="12.1,14.4"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="13.3,14.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.6637,14.1264;13.3,14.4764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[9].KRM1#</string>
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
            <point val="13.3,14.4"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="14.5,14.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.8637,14.1264;14.5,14.4764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[9].KET1#</string>
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
            <point val="14.5,14.4"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="24.5,14.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.5,14.1264;26.1968,14.4764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[9].YUKOSTYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#00000000#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="24.5,14.4"/>
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
    <object type="Embed - Text" version="0" id="O554">
      <attribute name="obj_pos">
        <point val="26.3,14.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.3,14.1264;26.5121,14.4764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[9].NYORO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#-#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.3,14.4"/>
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
    <object type="Embed - Text" version="0" id="O555">
      <attribute name="obj_pos">
        <point val="26.6,14.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.6,14.1264;28.2968,14.4764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[9].YUKOEDYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,14.4"/>
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
    <object type="Embed - Text" version="0" id="O556">
      <attribute name="obj_pos">
        <point val="22.1,14.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.9233,14.1264;22.2768,14.4764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[9].FUKUYOU1#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="22.1,14.4"/>
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
        <point val="15.7,14.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.0637,14.1264;15.7,14.4764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[9].KRM2#</string>
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
            <point val="15.7,14.4"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="16.9,14.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.2637,14.1264;16.9,14.4764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[9].KET2#</string>
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
            <point val="16.9,14.4"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
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
        <point val="18.1,14.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.4637,14.1264;18.1,14.4764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[9].KRM3#</string>
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
            <point val="18.1,14.4"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O560">
      <attribute name="obj_pos">
        <point val="19.3,14.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.6637,14.1264;19.3,14.4764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[9].KET3#</string>
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
            <point val="19.3,14.4"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O561">
      <attribute name="obj_pos">
        <point val="20.5,14.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.8637,14.1264;20.5,14.4764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[9].KRM4#</string>
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
            <point val="20.5,14.4"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O562">
      <attribute name="obj_pos">
        <point val="21.7,14.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.0637,14.1264;21.7,14.4764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[9].KET4#</string>
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
            <point val="21.7,14.4"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O563">
      <attribute name="obj_pos">
        <point val="22.7,14.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.5233,14.1264;22.8768,14.4764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[9].FUKUYOU2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="22.7,14.4"/>
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
    <object type="Embed - Text" version="0" id="O564">
      <attribute name="obj_pos">
        <point val="23.3,14.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.1233,14.1264;23.4768,14.4764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[9].FUKUYOU3#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="23.3,14.4"/>
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
    <object type="Embed - Text" version="0" id="O565">
      <attribute name="obj_pos">
        <point val="24,14.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.8233,14.1264;24.1768,14.4764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[9].FUKUYOU4#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="24,14.4"/>
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
    <object type="Embed - Text" version="0" id="O566">
      <attribute name="obj_pos">
        <point val="1.1,15"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.1,14.6482;3.5543,15.0982"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[10].SRYCD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#999999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.45"/>
          </attribute>
          <attribute name="pos">
            <point val="1.1,15"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2727"/>
          </attribute>
          <attribute name="multi">
            <real val="0.22725"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O567">
      <attribute name="obj_pos">
        <point val="3.7,15"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.7,14.7264;21.375,15.0764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[10].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.7,15"/>
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
    <object type="Embed - Text" version="0" id="O568">
      <attribute name="obj_pos">
        <point val="6.2,15.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.2306,15.2264;6.2,15.5764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[10].TEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999999.99#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="6.2,15.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O569">
      <attribute name="obj_pos">
        <point val="7.1,15.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.8879,15.2264;7.1,15.5764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[10].HKNTEK#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#9#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,15.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O570">
      <attribute name="obj_pos">
        <point val="7.3,15.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.3,15.2264;9.0675,15.5764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[10].BUI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.3,15.5"/>
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
    <object type="Embed - Text" version="0" id="O571">
      <attribute name="obj_pos">
        <point val="10.6,15.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.9637,15.2264;10.6,15.5764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[10].GAITEN#</string>
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
            <point val="10.6,15.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O572">
      <attribute name="obj_pos">
        <point val="12.1,15.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="11.4637,15.2264;12.1,15.5764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[10].NYUTEN#</string>
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
            <point val="12.1,15.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O573">
      <attribute name="obj_pos">
        <point val="13.3,15.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.6637,15.2264;13.3,15.5764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[10].KRM1#</string>
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
            <point val="13.3,15.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O574">
      <attribute name="obj_pos">
        <point val="14.5,15.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.8637,15.2264;14.5,15.5764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[10].KET1#</string>
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
            <point val="14.5,15.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O575">
      <attribute name="obj_pos">
        <point val="24.5,15.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.5,15.2264;26.1968,15.5764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[10].YUKOSTYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#00000000#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="24.5,15.5"/>
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
    <object type="Embed - Text" version="0" id="O576">
      <attribute name="obj_pos">
        <point val="26.3,15.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.3,15.2264;26.5121,15.5764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[10].NYORO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#-#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.3,15.5"/>
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
    <object type="Embed - Text" version="0" id="O577">
      <attribute name="obj_pos">
        <point val="26.6,15.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.6,15.2264;28.2968,15.5764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[10].YUKOEDYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,15.5"/>
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
    <object type="Embed - Text" version="0" id="O578">
      <attribute name="obj_pos">
        <point val="22.1,15.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.9233,15.2264;22.2768,15.5764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[10].FUKUYOU1#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="22.1,15.5"/>
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
    <object type="Embed - Text" version="0" id="O579">
      <attribute name="obj_pos">
        <point val="15.7,15.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.0637,15.2264;15.7,15.5764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[10].KRM2#</string>
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
            <point val="15.7,15.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O580">
      <attribute name="obj_pos">
        <point val="16.9,15.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.2637,15.2264;16.9,15.5764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[10].KET2#</string>
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
            <point val="16.9,15.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O581">
      <attribute name="obj_pos">
        <point val="18.1,15.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.4637,15.2264;18.1,15.5764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[10].KRM3#</string>
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
            <point val="18.1,15.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O582">
      <attribute name="obj_pos">
        <point val="19.3,15.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.6637,15.2264;19.3,15.5764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[10].KET3#</string>
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
            <point val="19.3,15.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O583">
      <attribute name="obj_pos">
        <point val="20.5,15.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.8637,15.2264;20.5,15.5764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[10].KRM4#</string>
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
            <point val="20.5,15.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O584">
      <attribute name="obj_pos">
        <point val="21.7,15.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.0637,15.2264;21.7,15.5764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[10].KET4#</string>
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
            <point val="21.7,15.5"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O585">
      <attribute name="obj_pos">
        <point val="22.7,15.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.5233,15.2264;22.8768,15.5764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[10].FUKUYOU2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="22.7,15.5"/>
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
    <object type="Embed - Text" version="0" id="O586">
      <attribute name="obj_pos">
        <point val="23.3,15.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.1233,15.2264;23.4768,15.5764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[10].FUKUYOU3#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="23.3,15.5"/>
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
    <object type="Embed - Text" version="0" id="O587">
      <attribute name="obj_pos">
        <point val="24,15.5"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.8233,15.2264;24.1768,15.5764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[10].FUKUYOU4#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="24,15.5"/>
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
    <object type="Embed - Text" version="0" id="O588">
      <attribute name="obj_pos">
        <point val="1.1,16.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.1,15.7482;3.5543,16.1982"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[11].SRYCD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#999999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.45"/>
          </attribute>
          <attribute name="pos">
            <point val="1.1,16.1"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2727"/>
          </attribute>
          <attribute name="multi">
            <real val="0.22725"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O589">
      <attribute name="obj_pos">
        <point val="3.7,16.1"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.7,15.8264;21.375,16.1764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[11].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.7,16.1"/>
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
    <object type="Embed - Text" version="0" id="O590">
      <attribute name="obj_pos">
        <point val="6.2,16.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.2306,16.3264;6.2,16.6764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[11].TEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999999.99#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="6.2,16.6"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O591">
      <attribute name="obj_pos">
        <point val="7.1,16.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.8879,16.3264;7.1,16.6764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[11].HKNTEK#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#9#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,16.6"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O592">
      <attribute name="obj_pos">
        <point val="7.3,16.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.3,16.3264;9.0675,16.6764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[11].BUI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.3,16.6"/>
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
    <object type="Embed - Text" version="0" id="O593">
      <attribute name="obj_pos">
        <point val="10.6,16.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.9637,16.3264;10.6,16.6764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[11].GAITEN#</string>
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
            <point val="10.6,16.6"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O594">
      <attribute name="obj_pos">
        <point val="12.1,16.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="11.4637,16.3264;12.1,16.6764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[11].NYUTEN#</string>
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
            <point val="12.1,16.6"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O595">
      <attribute name="obj_pos">
        <point val="13.3,16.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.6637,16.3264;13.3,16.6764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[11].KRM1#</string>
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
            <point val="13.3,16.6"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O596">
      <attribute name="obj_pos">
        <point val="14.5,16.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.8637,16.3264;14.5,16.6764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[11].KET1#</string>
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
            <point val="14.5,16.6"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O597">
      <attribute name="obj_pos">
        <point val="24.5,16.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.5,16.3264;26.1968,16.6764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[11].YUKOSTYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#00000000#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="24.5,16.6"/>
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
    <object type="Embed - Text" version="0" id="O598">
      <attribute name="obj_pos">
        <point val="26.3,16.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.3,16.3264;26.5121,16.6764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[11].NYORO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#-#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.3,16.6"/>
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
    <object type="Embed - Text" version="0" id="O599">
      <attribute name="obj_pos">
        <point val="26.6,16.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.6,16.3264;28.2968,16.6764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[11].YUKOEDYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,16.6"/>
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
    <object type="Embed - Text" version="0" id="O600">
      <attribute name="obj_pos">
        <point val="22.1,16.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.9233,16.3264;22.2768,16.6764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[11].FUKUYOU1#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="22.1,16.6"/>
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
    <object type="Embed - Text" version="0" id="O601">
      <attribute name="obj_pos">
        <point val="15.7,16.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.0637,16.3264;15.7,16.6764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[11].KRM2#</string>
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
            <point val="15.7,16.6"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O602">
      <attribute name="obj_pos">
        <point val="16.9,16.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.2637,16.3264;16.9,16.6764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[11].KET2#</string>
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
            <point val="16.9,16.6"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O603">
      <attribute name="obj_pos">
        <point val="18.1,16.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.4637,16.3264;18.1,16.6764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[11].KRM3#</string>
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
            <point val="18.1,16.6"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O604">
      <attribute name="obj_pos">
        <point val="19.3,16.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.6637,16.3264;19.3,16.6764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[11].KET3#</string>
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
            <point val="19.3,16.6"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O605">
      <attribute name="obj_pos">
        <point val="20.5,16.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.8637,16.3264;20.5,16.6764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[11].KRM4#</string>
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
            <point val="20.5,16.6"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O606">
      <attribute name="obj_pos">
        <point val="21.7,16.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.0637,16.3264;21.7,16.6764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[11].KET4#</string>
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
            <point val="21.7,16.6"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O607">
      <attribute name="obj_pos">
        <point val="22.7,16.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.5233,16.3264;22.8768,16.6764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[11].FUKUYOU2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="22.7,16.6"/>
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
    <object type="Embed - Text" version="0" id="O608">
      <attribute name="obj_pos">
        <point val="23.3,16.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.1233,16.3264;23.4768,16.6764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[11].FUKUYOU3#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="23.3,16.6"/>
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
    <object type="Embed - Text" version="0" id="O609">
      <attribute name="obj_pos">
        <point val="24,16.6"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.8233,16.3264;24.1768,16.6764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[11].FUKUYOU4#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="24,16.6"/>
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
    <object type="Embed - Text" version="0" id="O610">
      <attribute name="obj_pos">
        <point val="1.1,17.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.1,16.8482;3.5543,17.2982"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[12].SRYCD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#999999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.45"/>
          </attribute>
          <attribute name="pos">
            <point val="1.1,17.2"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2727"/>
          </attribute>
          <attribute name="multi">
            <real val="0.22725"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O611">
      <attribute name="obj_pos">
        <point val="3.7,17.2"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.7,16.9264;21.375,17.2764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[12].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.7,17.2"/>
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
    <object type="Embed - Text" version="0" id="O612">
      <attribute name="obj_pos">
        <point val="6.2,17.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.2306,17.4264;6.2,17.7764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[12].TEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999999.99#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="6.2,17.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O613">
      <attribute name="obj_pos">
        <point val="7.1,17.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.8879,17.4264;7.1,17.7764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[12].HKNTEK#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#9#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
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
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O614">
      <attribute name="obj_pos">
        <point val="7.3,17.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.3,17.4264;9.0675,17.7764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[12].BUI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.3,17.7"/>
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
    <object type="Embed - Text" version="0" id="O615">
      <attribute name="obj_pos">
        <point val="10.6,17.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.9637,17.4264;10.6,17.7764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[12].GAITEN#</string>
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
            <point val="10.6,17.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O616">
      <attribute name="obj_pos">
        <point val="12.1,17.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="11.4637,17.4264;12.1,17.7764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[12].NYUTEN#</string>
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
            <point val="12.1,17.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O617">
      <attribute name="obj_pos">
        <point val="13.3,17.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.6637,17.4264;13.3,17.7764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[12].KRM1#</string>
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
            <point val="13.3,17.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O618">
      <attribute name="obj_pos">
        <point val="14.5,17.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.8637,17.4264;14.5,17.7764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[12].KET1#</string>
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
            <point val="14.5,17.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O619">
      <attribute name="obj_pos">
        <point val="24.5,17.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.5,17.4264;26.1968,17.7764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[12].YUKOSTYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#00000000#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="24.5,17.7"/>
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
    <object type="Embed - Text" version="0" id="O620">
      <attribute name="obj_pos">
        <point val="26.3,17.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.3,17.4264;26.5121,17.7764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[12].NYORO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#-#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.3,17.7"/>
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
    <object type="Embed - Text" version="0" id="O621">
      <attribute name="obj_pos">
        <point val="26.6,17.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.6,17.4264;28.2968,17.7764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[12].YUKOEDYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,17.7"/>
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
    <object type="Embed - Text" version="0" id="O622">
      <attribute name="obj_pos">
        <point val="22.1,17.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.9233,17.4264;22.2768,17.7764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[12].FUKUYOU1#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="22.1,17.7"/>
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
    <object type="Embed - Text" version="0" id="O623">
      <attribute name="obj_pos">
        <point val="15.7,17.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.0637,17.4264;15.7,17.7764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[12].KRM2#</string>
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
            <point val="15.7,17.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O624">
      <attribute name="obj_pos">
        <point val="16.9,17.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.2637,17.4264;16.9,17.7764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[12].KET2#</string>
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
            <point val="16.9,17.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O625">
      <attribute name="obj_pos">
        <point val="18.1,17.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.4637,17.4264;18.1,17.7764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[12].KRM3#</string>
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
            <point val="18.1,17.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O626">
      <attribute name="obj_pos">
        <point val="19.3,17.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.6637,17.4264;19.3,17.7764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[12].KET3#</string>
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
            <point val="19.3,17.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O627">
      <attribute name="obj_pos">
        <point val="20.5,17.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.8637,17.4264;20.5,17.7764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[12].KRM4#</string>
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
            <point val="20.5,17.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O628">
      <attribute name="obj_pos">
        <point val="21.7,17.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.0637,17.4264;21.7,17.7764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[12].KET4#</string>
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
            <point val="21.7,17.7"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O629">
      <attribute name="obj_pos">
        <point val="22.7,17.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.5233,17.4264;22.8768,17.7764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[12].FUKUYOU2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="22.7,17.7"/>
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
    <object type="Embed - Text" version="0" id="O630">
      <attribute name="obj_pos">
        <point val="23.3,17.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.1233,17.4264;23.4768,17.7764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[12].FUKUYOU3#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="23.3,17.7"/>
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
    <object type="Embed - Text" version="0" id="O631">
      <attribute name="obj_pos">
        <point val="24,17.7"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.8233,17.4264;24.1768,17.7764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[12].FUKUYOU4#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="24,17.7"/>
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
    <object type="Embed - Text" version="0" id="O632">
      <attribute name="obj_pos">
        <point val="1.1,18.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.1,17.9482;3.5543,18.3982"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[13].SRYCD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#999999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.45"/>
          </attribute>
          <attribute name="pos">
            <point val="1.1,18.3"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2727"/>
          </attribute>
          <attribute name="multi">
            <real val="0.22725"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O633">
      <attribute name="obj_pos">
        <point val="3.7,18.3"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.7,18.0264;21.375,18.3764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[13].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.7,18.3"/>
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
    <object type="Embed - Text" version="0" id="O634">
      <attribute name="obj_pos">
        <point val="6.2,18.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.2306,18.5264;6.2,18.8764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[13].TEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999999.99#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="6.2,18.8"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O635">
      <attribute name="obj_pos">
        <point val="7.1,18.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.8879,18.5264;7.1,18.8764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[13].HKNTEK#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#9#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,18.8"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O636">
      <attribute name="obj_pos">
        <point val="7.3,18.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.3,18.5264;9.0675,18.8764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[13].BUI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.3,18.8"/>
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
    <object type="Embed - Text" version="0" id="O637">
      <attribute name="obj_pos">
        <point val="10.6,18.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.9637,18.5264;10.6,18.8764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[13].GAITEN#</string>
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
            <point val="10.6,18.8"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O638">
      <attribute name="obj_pos">
        <point val="12.1,18.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="11.4637,18.5264;12.1,18.8764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[13].NYUTEN#</string>
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
            <point val="12.1,18.8"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O639">
      <attribute name="obj_pos">
        <point val="13.3,18.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.6637,18.5264;13.3,18.8764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[13].KRM1#</string>
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
            <point val="13.3,18.8"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O640">
      <attribute name="obj_pos">
        <point val="14.5,18.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.8637,18.5264;14.5,18.8764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[13].KET1#</string>
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
            <point val="14.5,18.8"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O641">
      <attribute name="obj_pos">
        <point val="24.5,18.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.5,18.5264;26.1968,18.8764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[13].YUKOSTYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#00000000#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="24.5,18.8"/>
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
    <object type="Embed - Text" version="0" id="O642">
      <attribute name="obj_pos">
        <point val="26.3,18.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.3,18.5264;26.5121,18.8764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[13].NYORO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#-#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.3,18.8"/>
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
    <object type="Embed - Text" version="0" id="O643">
      <attribute name="obj_pos">
        <point val="26.6,18.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.6,18.5264;28.2968,18.8764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[13].YUKOEDYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,18.8"/>
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
    <object type="Embed - Text" version="0" id="O644">
      <attribute name="obj_pos">
        <point val="22.1,18.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.9233,18.5264;22.2768,18.8764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[13].FUKUYOU1#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="22.1,18.8"/>
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
    <object type="Embed - Text" version="0" id="O645">
      <attribute name="obj_pos">
        <point val="15.7,18.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.0637,18.5264;15.7,18.8764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[13].KRM2#</string>
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
            <point val="15.7,18.8"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O646">
      <attribute name="obj_pos">
        <point val="16.9,18.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.2637,18.5264;16.9,18.8764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[13].KET2#</string>
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
            <point val="16.9,18.8"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O647">
      <attribute name="obj_pos">
        <point val="18.1,18.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.4637,18.5264;18.1,18.8764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[13].KRM3#</string>
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
            <point val="18.1,18.8"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O648">
      <attribute name="obj_pos">
        <point val="19.3,18.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.6637,18.5264;19.3,18.8764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[13].KET3#</string>
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
            <point val="19.3,18.8"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O649">
      <attribute name="obj_pos">
        <point val="20.5,18.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.8637,18.5264;20.5,18.8764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[13].KRM4#</string>
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
            <point val="20.5,18.8"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O650">
      <attribute name="obj_pos">
        <point val="21.7,18.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.0637,18.5264;21.7,18.8764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[13].KET4#</string>
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
            <point val="21.7,18.8"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O651">
      <attribute name="obj_pos">
        <point val="22.7,18.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.5233,18.5264;22.8768,18.8764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[13].FUKUYOU2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="22.7,18.8"/>
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
    <object type="Embed - Text" version="0" id="O652">
      <attribute name="obj_pos">
        <point val="23.3,18.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.1233,18.5264;23.4768,18.8764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[13].FUKUYOU3#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="23.3,18.8"/>
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
    <object type="Embed - Text" version="0" id="O653">
      <attribute name="obj_pos">
        <point val="24,18.8"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.8233,18.5264;24.1768,18.8764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[13].FUKUYOU4#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="24,18.8"/>
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
    <object type="Embed - Text" version="0" id="O654">
      <attribute name="obj_pos">
        <point val="1.1,19.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="1.1,19.0482;3.5543,19.4982"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[14].SRYCD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#999999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.45"/>
          </attribute>
          <attribute name="pos">
            <point val="1.1,19.4"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="0"/>
          </attribute>
          <attribute name="single">
            <real val="0.2727"/>
          </attribute>
          <attribute name="multi">
            <real val="0.22725"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O655">
      <attribute name="obj_pos">
        <point val="3.7,19.4"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.7,19.1264;21.375,19.4764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[14].NAME#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;&#164;&#162;&#164;&#164;&#164;&#166;&#164;&#168;&#164;&#170;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="3.7,19.4"/>
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
    <object type="Embed - Text" version="0" id="O656">
      <attribute name="obj_pos">
        <point val="6.2,19.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="3.2306,19.6264;6.2,19.9764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[14].TEN#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999999.99#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="6.2,19.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O657">
      <attribute name="obj_pos">
        <point val="7.1,19.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="6.8879,19.6264;7.1,19.9764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[14].HKNTEK#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#9#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.1,19.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O658">
      <attribute name="obj_pos">
        <point val="7.3,19.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="7.3,19.6264;9.0675,19.9764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[14].BUI#</string>
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
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="7.3,19.9"/>
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
    <object type="Embed - Text" version="0" id="O659">
      <attribute name="obj_pos">
        <point val="10.6,19.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="9.9637,19.6264;10.6,19.9764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[14].GAITEN#</string>
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
            <point val="10.6,19.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O660">
      <attribute name="obj_pos">
        <point val="12.1,19.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="11.4637,19.6264;12.1,19.9764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[14].NYUTEN#</string>
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
            <point val="12.1,19.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O661">
      <attribute name="obj_pos">
        <point val="13.3,19.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="12.6637,19.6264;13.3,19.9764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[14].KRM1#</string>
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
            <point val="13.3,19.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O662">
      <attribute name="obj_pos">
        <point val="14.5,19.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="13.8637,19.6264;14.5,19.9764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[14].KET1#</string>
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
            <point val="14.5,19.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O663">
      <attribute name="obj_pos">
        <point val="24.5,19.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="24.5,19.6264;26.1968,19.9764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[14].YUKOSTYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#00000000#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="24.5,19.9"/>
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
    <object type="Embed - Text" version="0" id="O664">
      <attribute name="obj_pos">
        <point val="26.3,19.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.3,19.6264;26.5121,19.9764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[14].NYORO#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#-#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.3,19.9"/>
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
    <object type="Embed - Text" version="0" id="O665">
      <attribute name="obj_pos">
        <point val="26.6,19.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="26.6,19.6264;28.2968,19.9764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[14].YUKOEDYMD#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="1"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#99999999#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="26.6,19.9"/>
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
    <object type="Embed - Text" version="0" id="O666">
      <attribute name="obj_pos">
        <point val="22.1,19.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.9233,19.6264;22.2768,19.9764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[14].FUKUYOU1#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="22.1,19.9"/>
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
    <object type="Embed - Text" version="0" id="O667">
      <attribute name="obj_pos">
        <point val="15.7,19.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="15.0637,19.6264;15.7,19.9764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[14].KRM2#</string>
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
            <point val="15.7,19.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O668">
      <attribute name="obj_pos">
        <point val="16.9,19.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="16.2637,19.6264;16.9,19.9764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[14].KET2#</string>
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
            <point val="16.9,19.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O669">
      <attribute name="obj_pos">
        <point val="18.1,19.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="17.4637,19.6264;18.1,19.9764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[14].KRM3#</string>
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
            <point val="18.1,19.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O670">
      <attribute name="obj_pos">
        <point val="19.3,19.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="18.6637,19.6264;19.3,19.9764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[14].KET3#</string>
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
            <point val="19.3,19.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O671">
      <attribute name="obj_pos">
        <point val="20.5,19.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="19.8637,19.6264;20.5,19.9764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[14].KRM4#</string>
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
            <point val="20.5,19.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O672">
      <attribute name="obj_pos">
        <point val="21.7,19.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="21.0637,19.6264;21.7,19.9764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[14].KET4#</string>
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
            <point val="21.7,19.9"/>
          </attribute>
          <attribute name="color">
            <color val="#000000"/>
          </attribute>
          <attribute name="alignment">
            <enum val="2"/>
          </attribute>
          <attribute name="single">
            <real val="0.2121"/>
          </attribute>
          <attribute name="multi">
            <real val="0.17675"/>
          </attribute>
        </composite>
      </attribute>
    </object>
    <object type="Embed - Text" version="0" id="O673">
      <attribute name="obj_pos">
        <point val="22.7,19.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="22.5233,19.6264;22.8768,19.9764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[14].FUKUYOU2#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="22.7,19.9"/>
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
    <object type="Embed - Text" version="0" id="O674">
      <attribute name="obj_pos">
        <point val="23.3,19.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.1233,19.6264;23.4768,19.9764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[14].FUKUYOU3#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="23.3,19.9"/>
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
    <object type="Embed - Text" version="0" id="O675">
      <attribute name="obj_pos">
        <point val="24,19.9"/>
      </attribute>
      <attribute name="obj_bb">
        <rectangle val="23.8233,19.6264;24.1768,19.9764"/>
      </attribute>
      <attribute name="dnode_path">
        <string>#NAIYO-TBL[14].FUKUYOU4#</string>
      </attribute>
      <attribute name="embed_text_string">
        <enum val="0"/>
      </attribute>
      <attribute name="text">
        <composite type="text">
          <attribute name="string">
            <string>#&#161;&#251;#</string>
          </attribute>
          <attribute name="font">
            <font name="Courier"/>
          </attribute>
          <attribute name="height">
            <real val="0.35"/>
          </attribute>
          <attribute name="pos">
            <point val="24,19.9"/>
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
