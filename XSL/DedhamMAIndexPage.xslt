<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:res="http://www.esri.com/metadata/res/" xmlns:esri="http://www.esri.com/metadata/" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

  <!-- An XSLT template for displaying metadata in ArcGIS that is stored in the ArcGIS metadata format.

     Copyright (c) 2009-2013, Environmental Systems Research Institute, Inc. All rights reserved.
	
     Revision History: Created 11/19/2009 avienneau
-->
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
                                    <xsl:sort select="Values/Value[number($Extract_Fileindex)]" />
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
                            <xsl:sort select="Values/Value[number($Extract_Fileindex)]" />
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
         
          <!--Application Title-->
          <div class="itemDescription" id="overview">
            <!-- Title -->
            <div class="itemTitle">
              <h1 class="idAppTitle">
                <span>GIS Data Dictionary</span>
              </h1>
            </div>
          </div>
          
          <!-- Data listing -->
          <div class="indexMain" id="overview">
            <h1 class="idHeading">
              Data Listing
            </h1>

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

            <xsl:for-each select="$categorytable//DatasetData//Records/Record">
              <xsl:sort select="Values/Value[number($CATindex)]" />
              <xsl:variable name="Category">
                <xsl:value-of select="Values/Value[number($CATindex)]"/>
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

              <div class="itemInfo">
                <ul class="Category">
                  <li>
                    <h2 class="idHeading">
                      <xsl:value-of select="$Category"/>
                    </h2>
                  </li>
                  <!-- Sub category test-->
                  <xsl:variable name="subs">
                    <xsl:value-of select="$subcategorytable//DatasetData//Records/Record[Values/Value=$Category]/Values/Value[number($SUB_SubCatindex)]"/>
                  </xsl:variable>
                  <xsl:choose>
                    <!-- Add subcategory menus-->
                    <xsl:when test="string($subs) != ''">
                      <ul >
                        <xsl:for-each select="$subcategorytable//DatasetData//Records/Record[Values/Value=$Category]">
                          <xsl:sort select="Values/Value[number($SUB_SubCatindex)]" />
                          <!-- Add subcategory menu test-->
                          <xsl:if test="not(Values/Value[number($SUB_SubCatindex)]/@xsi:nil)">
                            <xsl:variable name="SubCategory">
                              <xsl:value-of select="string(Values/Value[number($SUB_SubCatindex)])"/>
                            </xsl:variable>
                            <li>
                              <h3 class="idHeading">
                                <xsl:value-of select="$SubCategory"/>
                              </h3>
                            </li>
                            <!-- Add Sub Category Data Listing-->
                            <ul >
                              <xsl:for-each select="$extracttable//DatasetData//Records/Record[Values/Value=$Category and Values/Value=$SubCategory]">
                                <xsl:sort select="Values/Value[number($Extract_Fileindex)]" />
                                <li>
                                  <a class="idHeading">
                                    <xsl:attribute name="href">
                                      <xsl:value-of select="concat($BaseURL,string(Values/Value[number($Extract_Fileindex)]))"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="string(Values/Value[number($Extract_Itemindex)])"/>
                                  </a>
                                </li>
                              </xsl:for-each>
                            </ul>
                          </xsl:if>
                        </xsl:for-each>
                      </ul>
                    </xsl:when>

                    <!-- Add Category menu items-->
                    <xsl:otherwise>
                      <ul>
                        <xsl:for-each select="$extracttable//DatasetData//Records/Record[Values/Value=$Category]">
                          <xsl:sort select="Values/Value[number($Extract_Fileindex)]" />
                          <li>
                            <a >
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
                </ul>
              </div>
            </xsl:for-each>
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
</xsl:stylesheet>

