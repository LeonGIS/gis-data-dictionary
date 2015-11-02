<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:res="http://www.esri.com/metadata/res/" xmlns:esri="http://www.esri.com/metadata/" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

  <!-- An XSLT template for displaying metadata in ArcGIS that is stored in the ArcGIS metadata format.

     Copyright (c) 2009-2013, Environmental Systems Research Institute, Inc. All rights reserved.
	
     Revision History: Created 11/19/2009 avienneau
-->
  <xsl:variable name="Upper" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
  <xsl:variable name="Lower" select="'abcdefghijklmnopqrstuvwxyz'" />

  <xsl:variable name="categorytable" select="document('./output/categorytable.xml')" />
  <xsl:variable name="subcategorytable" select="document('./output/subcategorytable.xml')" />
  <xsl:variable name="extracttable" select="document('./output/extracttable.xml')" />
  <xsl:variable name="BaseURL" select="'http://gis.dedham-ma.gov/DataDictionary/'" />




  <xsl:template name="iteminfo" >
    <!-- Page header-->
    <div id="header">
      <div class="container headerContainer">
        <div class="grid_12">
          <ul id="templateNav">
            <li id="homeItem">
              <a  id="home-link">
                <xsl:attribute name="href">
                  <xsl:value-of select="$BaseURL"/>
                </xsl:attribute>
                Dedham Maps
              </a>
            </li>
          </ul>
        </div>
        <div>
        </div>
      </div>
    </div>

    <!--Main content container-->
    <div id="content">
      <div class="container">
        <!--Navigation-->
        <div class="leftPanel">
          <nav class="nav">
            <div id="navigation">
              <h2 class="idHeading">Data Categories</h2>

              <!-- Get field indices-->
              <xsl:variable name="cattablefields" select="$categorytable//DatasetData//FieldArray" />
              <xsl:variable name="CATindex">
                <xsl:for-each select="$cattablefields/Field">
                  <xsl:variable name="fieldname" select="Name" />
                  <xsl:if test="$fieldname = 'CATEGORY'">
                    <xsl:value-of select="number(position())"/>
                  </xsl:if>
                </xsl:for-each>
              </xsl:variable>

              <xsl:variable name="subtablefields" select="$subcategorytable//DatasetData//FieldArray" />
              <xsl:variable name="SUB_Catindex">
                <xsl:for-each select="$subtablefields/Field">
                  <xsl:variable name="fieldname" select="Name" />
                  <xsl:if test="$fieldname = 'CATEGORY'">
                    <xsl:value-of select="number(position())"/>
                  </xsl:if>
                </xsl:for-each>
              </xsl:variable>

              <xsl:variable name="SUB_SubCatindex">
                <xsl:for-each select="$subtablefields/Field">
                  <xsl:variable name="fieldname" select="Name" />
                  <xsl:if test="$fieldname = 'SUBCATEGORY'">
                    <xsl:value-of select="number(position())"/>
                  </xsl:if>
                </xsl:for-each>
              </xsl:variable>

              <xsl:variable name="extractfields" select="$extracttable//DatasetData//FieldArray" />
              <xsl:variable name="Extract_Catindex">
                <xsl:for-each select="$extractfields/Field">
                  <xsl:variable name="fieldname" select="Name" />
                  <xsl:if test="$fieldname = 'CATEGORY'">
                    <xsl:value-of select="number(position())"/>
                  </xsl:if>
                </xsl:for-each>
              </xsl:variable>

              <xsl:variable name="Extract_SubCatindex">
                <xsl:for-each select="$extractfields/Field">
                  <xsl:variable name="fieldname" select="Name" />
                  <xsl:if test="$fieldname = 'SUBCATEGORY'">
                    <xsl:value-of select="number(position())"/>
                  </xsl:if>
                </xsl:for-each>
              </xsl:variable>

              <xsl:variable name="Extract_Fileindex">
                <xsl:for-each select="$extractfields/Field">
                  <xsl:variable name="fieldname" select="Name" />
                  <xsl:if test="$fieldname = 'FILENAME'">
                    <xsl:value-of select="number(position())"/>
                  </xsl:if>
                </xsl:for-each>
              </xsl:variable>

              <xsl:variable name="Extract_Itemindex">
                <xsl:for-each select="$extractfields/Field">
                  <xsl:variable name="fieldname" select="Name" />
                  <xsl:if test="$fieldname = 'ITEMNAME'">
                    <xsl:value-of select="number(position())"/>
                  </xsl:if>
                </xsl:for-each>
              </xsl:variable>

              <ul class="top-level">
                <xsl:for-each select="$categorytable//DatasetData//Records/Record">
                  <xsl:sort select="Values/Value[number($CATindex)]" />

                  <xsl:variable name="Category">
                    <xsl:value-of select="Values/Value[number($CATindex)]"/>
                  </xsl:variable>

                  <li>
                    <!-- Add top level menu already added -->
                    <a href="#">
                      <xsl:value-of select="$Category"/>
                    </a>

                    <!-- Sub category test-->
                    <xsl:variable name="subs">
                      <xsl:value-of select="$subcategorytable//DatasetData//Records/Record[Values/Value=$Category]/Values/Value[number($SUB_SubCatindex)]"/>
                    </xsl:variable>
                    <xsl:choose>
                      <!-- Add subcategory menus-->
                      <xsl:when test="string($subs) != ''">

                        <ul class="sub-level">
                          <xsl:for-each select="$subcategorytable//DatasetData//Records/Record[Values/Value=$Category]">
                            <xsl:sort select="Values/Value[number($SUB_SubCatindex)]" />
                            <!-- Add subcategory menu test-->
                            <xsl:if test="not(Values/Value[number($SUB_SubCatindex)]/@xsi:nil)">

                              <li>
                                <a href="#">
                                  <xsl:value-of select="Values/Value[number($SUB_SubCatindex)]"/>
                                </a>
                                <xsl:variable name="SubCategory">
                                  <xsl:value-of select="string(Values/Value[number($SUB_SubCatindex)])"/>
                                </xsl:variable>

                                <!-- Add Sub Category menu items-->
                                <ul class="sub-level">
                                  <xsl:for-each select="$extracttable//DatasetData//Records/Record[Values/Value=$Category and Values/Value=$SubCategory]">
                                    <xsl:sort select="Values/Value[number($Extract_Itemindex)]" />
                                    <li>
                                      <a>
                                        <xsl:attribute name="href">
                                          <xsl:value-of select="concat($BaseURL,string(Values/Value[number($Extract_Fileindex)]))"/>
                                        </xsl:attribute>
                                        <xsl:value-of select="string(Values/Value[number($Extract_Itemindex)])"/>
                                      </a>
                                    </li>
                                  </xsl:for-each>
                                </ul>
                              </li>
                            </xsl:if>
                          </xsl:for-each>
                        </ul>
                      </xsl:when>

                      <!-- Add Category menu items-->
                      <xsl:otherwise>
                        <ul class="sub-level">
                          <xsl:for-each select="$extracttable//DatasetData//Records/Record[Values/Value=$Category]">
                            <xsl:sort select="Values/Value[number($Extract_Itemindex)]" />
                            <li>
                              <a>
                                <xsl:attribute name="href">
                                  <xsl:value-of select="concat($BaseURL,string(Values/Value[number($Extract_Fileindex)]))"/>
                                </xsl:attribute>
                                <xsl:value-of select="string(Values/Value[number($Extract_Itemindex)])"/>
                              </a>
                            </li>
                          </xsl:for-each>
                        </ul>
                      </xsl:otherwise>
                    </xsl:choose>
                  </li>
                </xsl:for-each>
              </ul>

            </div>
          </nav>
        </div>

        <!-- Main section-->
        <div class="mainPanel">
          <!-- Application Title-->
          <div class="itemDescription" id="overview">
            <!-- Title -->
            <div class="itemTitle">
              <h1 class="idAppTitle">
                <span>Data Dictionary</span>
              </h1>
            </div>
          </div>

          <!-- Title and Image -->
          <div class="itemDescription" id="overview">
            <!-- Title -->
            <div class="itemTitle">
              <div class="meta_title_left">
                <h1 class="idHeading">
                  <xsl:choose>
                    <xsl:when test="/metadata/dataIdInfo[1]/idCitation/resTitle/text()">
                      <xsl:value-of select="/metadata/dataIdInfo[1]/idCitation/resTitle[1]" />
                    </xsl:when>
                    <xsl:when test="/metadata/Esri/DataProperties/itemProps/itemName/text()">
                      <xsl:value-of select="/metadata/Esri/DataProperties/itemProps/itemName" />
                    </xsl:when>
                    <xsl:otherwise>
                      <span class="noContent">No Title</span>
                    </xsl:otherwise>
                  </xsl:choose>
                </h1>
              </div>

              <div class="meta_title_right">
                <!-- Image -->
                <xsl:choose>
                  <xsl:when test="count(/metadata/Binary/Thumbnail/Data) > 0">
                    <img name="thumbnail" id="thumbnail" alt="Thumbnail" title="Thumbnail" class="summary">
                      <xsl:attribute name="src">
                        data:image/jpeg;base64,<xsl:value-of select="metadata/Binary/Thumbnail/Data" />
                      </xsl:attribute>
                      <xsl:attribute name="class">center</xsl:attribute>
                      <xsl:attribute name="width">200px</xsl:attribute>
                    </img>
                  </xsl:when>
                  <xsl:when test="/metadata/idinfo/browse/img/@src">
                    <img name="thumbnail" id="thumbnail" alt="Thumbnail" title="Thumbnail" class="summary">
                      <xsl:attribute name="src">
                        <xsl:value-of select="/metadata/idinfo/browse/img/@src"/>
                      </xsl:attribute>
                      <xsl:attribute name="class">center</xsl:attribute>
                    </img>
                  </xsl:when>
                  <xsl:otherwise>
                    <div class="noThumbnail">
                      <span class="noThumbText">Thumbnail Not Available</span>
                    </div>
                  </xsl:otherwise>
                </xsl:choose>
              </div>
            </div>

            <!--  Download Links-->
            <div class="itemInfo">
              <h2 class="idHeading">Download Layer</h2>
              <xsl:variable name="downloadlinks" select="/metadata/distInfo/distributor/distorTran/onLineSrc[translate(linkage,$Lower,$Upper)!='' and translate(orDesc,$Lower,$Upper)!= '']" />

              <xsl:choose>
                <!--check for download instructions, trim and uppercase them -->
                <xsl:when test="count($downloadlinks) > 0">
                  <ul class="dictionary-downloads">
                    <xsl:apply-templates select="$downloadlinks" />
                  </ul>
                </xsl:when>
                <xsl:otherwise>
                  <p>
                    <span class="noContent">No download available for this item.</span>
                  </p>
                </xsl:otherwise>
              </xsl:choose>
            </div>

            <!--AGOL Summary/Metadata Purpose-->
            <div class="itemInfo">
              <h2 class="idHeading">Summary</h2>
              <xsl:choose>
                <xsl:when test="(/metadata/dataIdInfo[1]/idPurp != '')">
                  <p id="AGOL_Summary">
                    <xsl:value-of select="/metadata/dataIdInfo[1]/idPurp" />
                  </p>
                </xsl:when>
                <xsl:otherwise>
                  <p>
                    <span class="noContent">There is no summary for this item.</span>
                  </p>
                </xsl:otherwise>
              </xsl:choose>
            </div>

            <!--AGOL Description/Metadata Abstract/Tool Summary-->
            <div class="itemInfo">
              <h2 class="idHeading">Description</h2>
              <xsl:choose>
                <xsl:when test="(/metadata/dataIdInfo[1]/idAbs != '')">
                  <div id="AGOL_Desc">
                    <xsl:call-template name="p-element">
                      <xsl:with-param name="html" select="/metadata/dataIdInfo[1]/idAbs" />
                    </xsl:call-template>
                  </div>
                </xsl:when>
                <xsl:otherwise>
                  <p>
                    <span class="noContent">There is no description for this item.</span>
                  </p>
                </xsl:otherwise>
              </xsl:choose>
            </div>

            <!-- Last Update Date-->
            <div class="itemInfo">
              <h2 class="idHeading">Last Update</h2>
              <xsl:choose>
                <xsl:when test="count(/metadata/dataIdInfo/idCitation/date/reviseDate) >0">
                  <xsl:variable name="LastMod" select="/metadata/dataIdInfo/idCitation/date/reviseDate/text()" />
                  <p>
                    <xsl:value-of select="concat(substring($LastMod,6,2),'-',substring($LastMod,9,2),'-',substring($LastMod,1,4))" />
                  </p>
                </xsl:when>
                <xsl:otherwise>
                  <p>
                    <span class="noContent">
                      There is no date for this item.
                    </span>
                  </p>
                </xsl:otherwise>
              </xsl:choose>
            </div>

            <!-- Attribute Table-->
            <div class="itemInfo">
              <h2 class="idHeading">Attributes</h2>
              <xsl:variable name="attributes" select="/metadata/eainfo/detailed/attr[translate(attrlabl,$Lower,$Upper)!='OBJECTID' and translate(attrlabl,$Lower,$Upper)!= 'OBJECTID_1' and translate(attrlabl,$Lower,$Upper)!= 'GLOBALID' and translate(attrlabl, $Lower, $Upper)!= 'SHAPE' and translate(attrlabl,$Lower,$Upper)!= 'SHAPE.AREA' and translate(attrlabl,$Lower,$Upper)!= 'SHAPE.LEN' and translate(attrlabl,$Lower,$Upper)!= 'SHAPE.STAREA()' and translate(attrlabl,$Lower,$Upper)!= 'SHAPE.STLENGTH()'   and translate(attrlabl,$Lower,$Upper)!= 'SHAPE_AREA' and translate(attrlabl,$Lower,$Upper)!= 'SHAPE_LENGTH' and translate(attrlabl,$Lower,$Upper)!= 'RULEID'  and translate(attrlabl,$Lower,$Upper)!= 'RULEID_1'  and translate(attrlabl,$Lower,$Upper)!= 'OVERRIDE' and translate(attrlabl,$Lower,$Upper)!= 'OVERRIDE_1' and translate(attrlabl,$Lower,$Upper)!= ''  and translate(attrlabl,$Lower,$Upper)!= 'CREATED_USER' and translate(attrlabl,$Lower,$Upper)!= 'CREATED_DATE'  and translate(attrlabl,$Lower,$Upper)!= 'LAST_EDITED_USER' and translate(attrlabl,$Lower,$Upper)!= 'LAST_EDITED_DATE' and translate(attrlabl,$Lower,$Upper)!= 'DOCLINK']" />
              <!--return any nodes that pass the select statement, not the actual translations-->
              <xsl:choose>
                <xsl:when test="count($attributes) > 0">
                  <p>
                    <table>
                      <thead>
                        <tr>
                          <th class="name">Name</th>
                          <th class="type">Type Details</th>
                          <th class="description">Description</th>
                        </tr>
                      </thead>
                      <xsl:apply-templates select="$attributes" />
                    </table>
                  </p>

                </xsl:when>
                <xsl:otherwise>
                  <p>
                    <span class="noContent">
                      There is no attributes for this item.
                    </span>
                  </p>
                </xsl:otherwise>
              </xsl:choose>
            </div>

            <!-- Projection Information-->
            <div class="itemInfo">
              <h2 class="idHeading">Coordinate System</h2>
              <xsl:choose>
                <xsl:when test="(/metadata/Esri/DataProperties/coordRef/projcsn != '')">
                  <p>
                    <xsl:value-of select="translate(/metadata/Esri/DataProperties/coordRef/projcsn, '_', ' ')" />
                  </p>
                </xsl:when>
                <xsl:otherwise>
                  <p>
                    <span class="noContent">
                      No projection information for this item.
                    </span>
                  </p>
                </xsl:otherwise>
              </xsl:choose>
            </div>

            <!-- Credits -->
            <div class="itemInfo">
              <h2 class="idHeading">Credits</h2>
              <xsl:choose>
                <xsl:when test="(/metadata/dataIdInfo[1]/idCredit != '')">
                  <p id="AGOL_Credits">
                    <xsl:value-of select="/metadata/dataIdInfo[1]/idCredit" />
                  </p>
                </xsl:when>
                <xsl:otherwise>
                  <p>
                    <span class="noContent">There are no credits for this item.</span>
                  </p>
                </xsl:otherwise>
              </xsl:choose>
            </div>

            <!-- Use constraints -->
            <div class="itemInfo">
              <h2 class="idHeading">Use Limitations</h2>
              <xsl:variable name="UseLimit">
                <xsl:call-template name="removeHtmlTags">
                  <xsl:with-param name="html" select="/metadata/dataIdInfo[1]/resConst/Consts/useLimit[1]" />
                </xsl:call-template>
              </xsl:variable>
              <xsl:choose>
                <xsl:when test="(/metadata/dataIdInfo[1]/resConst/Consts/useLimit[1] != '')">
                  <p id="AGOL_UseConst">
                    <xsl:value-of disable-output-escaping="yes"  select="substring($UseLimit, 0, 1000)"/>
                  </p>
                </xsl:when>
                <xsl:otherwise>
                  <p>
                    <span class="noContent">There are no use limitations for this item.</span>
                  </p>
                </xsl:otherwise>
              </xsl:choose>
            </div>

            <!-- Legal constraints -->
            <div class="itemInfo">
              <h2 class="idHeading">Legal Constraints</h2>
              <xsl:choose>
                <xsl:when test="(/metadata/dataIdInfo[1]/resConst/LegConsts/othConsts != '')">
                  <div id="AGOL_AccessConst">
                    <xsl:call-template name="p-element">
                      <xsl:with-param name="html" select="/metadata/dataIdInfo[1]/resConst/LegConsts/othConsts" />
                    </xsl:call-template>
                  </div>
                </xsl:when>
                <xsl:otherwise>
                  <p>
                    <span class="noContent">There are no legal constraints for this item.</span>
                  </p>
                </xsl:otherwise>
              </xsl:choose>
            </div>

            <!-- Tags -->
            <div class="itemInfoHidden">
              <h2 class="idHeading">Tags</h2>
              <xsl:choose>
                <xsl:when test="(/metadata/dataIdInfo[1]/searchKeys/keyword[1] != '')">
                  <p id="AGOL_Tags">
                    <xsl:call-template name="comma-join">
                      <xsl:with-param name="list" select="/metadata/dataIdInfo[1]/searchKeys/*">
                      </xsl:with-param>
                    </xsl:call-template>
                  </p>
                </xsl:when>
                <xsl:otherwise>
                  <p>
                    <span class="noContent">There are no tags for this item.</span>
                  </p>
                </xsl:otherwise>
              </xsl:choose>
            </div>
          </div>
        </div>
      </div>
    </div>


    <!--footer -->
    <div id="footer">
      <div class="footerrow">
        <div class="footcontainer">
          <div class="foot_leftdiv">
            <div id="footerLogoDiv" class="logoDiv footBorder">
              <div>
                <a id="yourLogo" href="http://www.dedham-ma.gov" title="Dedham Maps">
                  <img  alt="Dedham Maps" >
                    <xsl:attribute name="src">./images/TownSeal.png</xsl:attribute>
                  </img>
                </a>
              </div>
            </div>
          </div>
          <div class="foot_rightdiv">
            <div class="Pad">
              <h2 id="footerHeading">Dedham, Massachusetts</h2>
              <div id="footerDescription">Geographic Information Systems Division</div>
            </div>
          </div>
          <div class="clear"></div>
        </div>
      </div>
    </div>
  </xsl:template>

  <!--Comma delimited string-->
  <xsl:template name="comma-join">
    <xsl:param name="list" />
    <xsl:for-each select="$list">
      <xsl:value-of select= "concat(., substring(',', 2 - (position() != last())))"/>
    </xsl:for-each>
  </xsl:template>

  <!-- Template Name: p-element -->
  <!-- Description: Used to preserve line-breaks in original metadata.
                  Recurse through HTML text looking for <P> elements -->
  <xsl:template name="p-element">
    <xsl:param name="html"/>

    <xsl:choose>
      <xsl:when test="contains($html, '&lt;P')">
        <xsl:variable name="strRemain">
          <!-- Strip HTML tags -->
          <xsl:call-template name="removeHtmlTags">
            <xsl:with-param name="html" select="substring-before($html, 'P&gt;')" />
          </xsl:call-template>
        </xsl:variable>

        <!-- Add P Element-->
        <xsl:if test="$strRemain != ''">
          <!--<p>
            <xsl:value-of select="$strRemain"/>
          </p>-->
          <xsl:call-template name="find-newlinechar">
            <xsl:with-param name="strMetaText" select="$strRemain"/>
          </xsl:call-template>

        </xsl:if>

        <!-- Recurse on remainder -->
        <xsl:call-template name="p-element">
          <xsl:with-param name="html" select="substring-after($html, 'P&gt;')"/>
        </xsl:call-template>
      </xsl:when>

      <!-- No P element in string -->
      <xsl:otherwise>
        <!-- Strip HTML tags -->
        <xsl:variable name="strRemain">
          <xsl:call-template name="removeHtmlTags">
            <xsl:with-param name="html" select="$html" />
          </xsl:call-template>
        </xsl:variable>
        <!-- Add P Element-->
        <xsl:if test="$strRemain != ''">
          <!--<p>
            <xsl:value-of select="$strRemain"/>
          </p>-->
          <xsl:call-template name="find-newlinechar">
            <xsl:with-param name="strMetaText" select="$strRemain"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>



  <xsl:template name="find-newlinechar">
    <xsl:param name="strMetaText"/>
    <xsl:choose>
      <xsl:when test="contains($strMetaText, '&#10;')">
        <xsl:if test="substring-before($strMetaText, '&#10;') != ''">
          <p>
            <xsl:value-of select="substring-before($strMetaText, '&#10;')" />
          </p>
        </xsl:if>
        <xsl:call-template name="find-newlinechar">
          <xsl:with-param name="strMetaText" select="substring-after($strMetaText, '&#10;')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="$strMetaText != ''">
          <p>
            <xsl:value-of select="$strMetaText" />
          </p>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Remove HTML tags from string -->
  <xsl:template name="removeHtmlTags">
    <xsl:param name="html"/>
    <xsl:choose>
      <xsl:when test="contains($html, '&lt;')">
        <xsl:value-of select="substring-before($html, '&lt;')"/>
        <!-- Recurse through HTML -->
        <xsl:call-template name="removeHtmlTags">
          <xsl:with-param name="html" select="substring-after($html, '&gt;')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$html"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- DOWNLOAD LINKS-->
  <xsl:template match="distInfo/distributor/distorTran/onLineSrc">
    <li>
      <xsl:element name="a">
        <xsl:attribute name="href">
          <xsl:value-of select="linkage" />
        </xsl:attribute>
        <xsl:attribute name="class">document zip</xsl:attribute>
        <xsl:value-of select="orDesc" />
      </xsl:element>
    </li>
  </xsl:template>


  <!-- ATTRIBUTES -->
  <xsl:template match="eainfo/detailed/attr">
    <tr>
      <td>
        <xsl:value-of select="translate(attrlabl,$Lower,$Upper)" />
      </td>
      <td>
        type: <xsl:value-of select="attrtype" /><br />
        width: <xsl:value-of select="attwidth" /><br />
        precision: <xsl:value-of select="atprecis" />
      </td>
      <td>
        <xsl:value-of select="attrdef" />
        <!-- create the field values table; use class and id as hooks for jQuery later -->
        <xsl:if test="count(attrdomv/edom) > 0">
          <h4 class="values-title-box">
            <xsl:element name="span">
              <xsl:attribute name="id">
                values-title-<xsl:value-of select="attrlabl" />
              </xsl:attribute>
              <xsl:attribute name="class">values-title</xsl:attribute>

              <xsl:text>Domain Values</xsl:text>
            </xsl:element>
          </h4>
          <xsl:element name="table">
            <xsl:attribute name="id">
              values-table-<xsl:value-of select="attrlabl" />
            </xsl:attribute>
            <xsl:attribute name="class">values-table</xsl:attribute>
            <thead>
              <tr>
                <th>Value</th>
                <th>Description</th>
              </tr>
            </thead>
            <xsl:apply-templates select="attrdomv/edom" />
          </xsl:element>
        </xsl:if>
      </td>
    </tr>
  </xsl:template>

  <!-- FIELD VALUES -->
  <xsl:template match="attrdomv/edom">
    <tr>
      <td>
        <xsl:value-of select="edomv" />
      </td>
      <td>
        <xsl:value-of select="edomvd" />
      </td>
    </tr>
  </xsl:template>
</xsl:stylesheet>

