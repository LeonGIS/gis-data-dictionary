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
    <header class="header">
      <div class="container">
        <a  id="home-link">
          <xsl:attribute name="href">
            <xsl:value-of select="$BaseURL"/>
          </xsl:attribute>
          <img class="logoimage" alt="logo" >
            <xsl:attribute name="src">./images/TownSeal.png</xsl:attribute>
          </img>
          <span class="site-logo">Dedham GIS Data Dictionary</span>

          <!-- Leave SkipNav in place for 508 compliance -->
        </a>
        <div>
        </div>
      </div>
    </header>
    
    
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

    <!-- Main section-->
    <main class="main">
     
  
    <!-- Title and Image -->
    <div class="itemDescription" id="overview">
      <h1 class="idHeading">
        GIS Data Listing
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
    </main>

    <footer class="footer">
      <div class="footerrow">
          <p>
            <a href="http://www.dedham-ma.gov/index.cfm?pid=12650">GIS Division</a> | <a href="http://www.dedham-ma.gov">Town of Dedham</a>
          </p>
      </div>
    </footer>
  </xsl:template>






  <xsl:template name="styles">
    <style type="text/css" id="internalStyle">


      html {
      min-height: 100%;
      position: relative;
      }

      body {
      font-family: Verdana, Gill, Helvetica, Sans-serif ;
      font-size: 0.8em;
      font-weight: 500;
      color: #000020;
      background-color: #FFFFFF;
      margin: 0px 0px 190px 0px;
      }


      .main {
      left: 220px;
      position: relative;
      width: 75%;
      margin-left: 30px;
      max-width: 900px;
      margin-bottom: 150px;
      }



      div.itemDescription {
      margin-right: 2em;
      margin-bottom: 2em;
      margin-top: 50px;
      }

      <!-- Index table-->
      .Category li {
      list-style: none;
      padding: 0px 0px 5px 0px;
      }

      .Category a{
      font-size: 1.2em;

      }

      h2 {
      font-size: 1.4em;
      margin-left: 10px;
      }

      h3 {
      font-size: 1.2em;
      font-style: italic;
      }




      <!--- End Index table-->
      
      h1 {
      font-size: 24px;
      margin-top: 0;
      margin-bottom: 5px;
      }
      h1.idHeading {
      color: #000000;
      max-width: 300px;
      padding-left: 10px;
      padding-right: 100px;
      overflow: hidden;
      overflow-wrap: normal;
      }


      h1.gpHeading {
      color: black;
      }
      span.idHeading {
      color: #007799;
      font-weight: bold;
      }
      .center {
      text-align: center;
      margin-top: 40px;
      margin-bottom: 10px;
      }

      <!--img.center {
      text-align: center;
      display: block;
      border-color: #666666;
      }
      img.enclosed {
      width: 60%;
      }
      img.gp {
      width: auto;
      border-style: none;
      margin-top: -1.2em;
      }
      .noThumbnail {
      color: #888888;
      font-size: 1.2em;
      border-width: 1px;
      border-style: solid;
      border-color: black;
      padding: 3em 3em;
      position: relative;
      text-align: center;
      width: 200px;
      height: 100px;
      margin-top: 40px;
      margin-bottom: 10px;
      line-height: 100px
      }
      .noThumbText {
      vertical-align: middle;
      }
      .noContent {
      color: #888888;
      }-->

      .itemInfo p {
      margin-left: 20px;
      }

      .itemInfo img {
      width: auto;
      border: none;
      }

      .gpItemInfo p {
      margin-top: -1.2em;
      }
      div.box {
      margin-left: 1em;
      }
      div.hide {
      display: none;
      }
      div.show {
      display: block;
      }
      span.hide {
      display: none;
      }
      span.show {
      display: inline-block;
      }
      .backToTop a {
      color: #DDDDDD;
      font-style: italic;
      font-size: 0.85em;
      }
    
      <!--h2.gp {
      color: #00709C;
      }-->
      .gpsubtitle {
      color: black;
      font-size: 1.2em;
      font-weight: normal;
      }
      .gptags {
      color: black;
      font-size: 0.8em;
      font-weight: normal;
      }
      .head {
      font-size: 1.3em;
      }
      a:link {
      color: #098EA6;
      font-weight: normal;
      text-decoration: none;
      }
      a:visited {
      color: #098EA6;
      text-decoration: none;
      }

    
    
    
      .backToTop {
      color: #AAAAAA;
      margin-left: 1em;
      }
      p.gp {
      margin-top: .6em;
      margin-bottom: .6em;
      }
      ul ul {
      list-style-type: square;
      }
     
      dl {
      margin: 0;
      padding: 0;
      }
      dl.iso {
      background-color: #F2F9FF;
      }
      dl.esri {
      background-color: #F2FFF9;
      }
      dl.subtype {
      width: 40em;
      margin-top: 0.5em;
      margin-bottom: 0.5em;
      padding: 0;
      }
      dt {
      margin-left: 0.6em;
      padding-left: 0.6em;
      clear: left;
      }
      .subtype dt {
      width: 60%;
      float: left;
      margin: 0;
      padding: 0.5em 0.5em 0 0.75em;
      border-top: 1px solid #006400;
      clear: none;
      }
      .subtype dt.header {
      padding: 0.5em 0.5em 0.5em 0;
      border-top: none;
      }
      dd {
      margin-left: 0.6em;
      padding-left: 0.6em;
      clear: left;
      }
      .subtype dd {
      float: left;
      width: 25%;
      margin: 0;
      padding: 0.5em 0.5em 0 0.75em;
      border-top: 1px solid #006400;
      clear: none;
      }
      .subtype dd.header {
      padding: 0.5em 0.5em 0.5em 0;
      border-top: none;
      }
     
   
      .element {
      font-variant: small-caps;
      font-size: 0.9em;
      font-weight: normal;
      color: #666666;
      }
      unknownElement {
      font-variant: small-caps;
      font-size: 0.9em;
      font-weight: normal;
      color: #333333;
      }
      .sync {
      color: #006400;
      font-weight: bold;
      font-size: 0.9em;
      }
      .syncOld {
      color: #888888;
      font-weight: bold;
      font-size: 0.9em;
      }
     
      .code {
      font-family: monospace;
      }
      pre.wrap {
      width: 96%;
      font-family: Verdana, Gill, Helvetica, Sans-serif ;
      font-size: 1em;
      margin: 0 0 0 0;
      white-space: pre-wrap;       /* css-3 */
      white-space: -moz-pre-wrap;  /* Mozilla, since 1999 */
      white-space: -pre-wrap;      /* Opera 4-6 */
      white-space: -o-pre-wrap;    /* Opera 7 */
      word-wrap: break-word;       /* Internet Explorer 5.5+ */
      }
      pre.wrap p {
      padding-bottom: 1em;
      }
      pre.wrap li {
      padding-bottom: 1em;
      }
      pre.wrap br {
      display: block;
      }
      pre.gp {
      font-family: Courier New, Courier, monospace;
      line-height: 1.2em;
      }
      .gpcode {
      margin-left:15px;
      border: 1px dashed #ACC6D8;
      padding: 10px;
      background-color:#EEEEEE;
      height: auto;
      overflow: scroll;
      width: 96%;
      }

      table {
      border: 1px solid #B7B7B7;
      border-collapse: collapse;
      border-spacing: 0;

      margin:0px;padding:0px;
      }


      tr {
      vertical-align: top;

      }

      tr:nth-child(even) {
      background-color: #E9E9E9
      }

      tr:nth-child(odd) {
      background-color: #ffffff;
      }

      th {
      text-align: left;
      background: #B7B7B7;
      vertical-align: bottom;
      font-size: 12px;
      padding: 10px 10px 5px 10px;

      }
      
      th.description{
        min-width: 300px;
        
      }
      td {

      color: black;
      vertical-align: top;
      font-size: 12px;
      padding: 5px 10px 10px 5px;
      vertical-align:middle;


      border:1px solid #B7B7B7;
      border-width:0px 1px 1px 0px;
      }
      td.description {
      background: white;
      }

      .header {
      background: #710000;
      color: #ffffff;
      height: 70px;

      }

      .container {
      margin-left: 30px;
      height: 70px;

      }

      .logoimage {
      width: 50px;
      height: 50px;
      margin-bottom: 10px;
      margin-top: 10px;
      float: left;
      padding: 0 20px 0 0;
      }

      .site-logo {
      color: #FFFFFF !important;
      font-size: 30px;

      font-family: "Avenir LT W01 65 Medium",Arial,sans-serif;
      line-height: 70px;

      }

      .dictionary-downloads {
      line-style-type: disc;
      line-height: 1.5;
      font-size: 1.0em;
      }

      .nav {
      position:absolute;
      
      left: 0px;
    z-index:99999;

      }



      <!-- Navigation Menus -->
      #navigation {
      font-size:1em;
      width:200px;
      border-style: solid;
      background: #E9E9E9;
      margin-top: 60px;
      margin-left: 20px;
      margin-right: 20px;
      border-color: #710000;
      border-width: 2px;
      }

      #navigation ul {
      margin: 0px;
      padding:0px 0px 10px 0px;
      }

      #navigation li {
      list-style: none;
      }

      ul.top-level li{
      margin-top:5px;
      }

      ul.top-level li span{
      float:right;
      color: #fff;
      margin-right:10px;
      margin-top:-20px;
      }

      #navigation a {
      transition: all .5s ease-out 0s;
      color: #000000;
      cursor: pointer;
      display:block;
      height:25px;
      line-height: 25px;
      text-indent: 10px;
      text-decoration:none;
      width:100%;
      }

      #navigation a:hover{
      text-decoration:none;
      }

      #navigation li:hover {
      background:#ff9898;
      transition: all .5s ease-out 0s;
      position: relative;
      }

      ul.sub-level {
      display: none;
      }

      li:hover .sub-level{
      transition: all .5s ease-out 0s;
      background: #999;
      border: #fff solid;
      border-width: 1px;
      display: block;
      position: absolute;
      left: 75px;
      top: 5px;
      border-radius:5px;
      }

      ul.sub-level li {
      border: none;
      float:left;
      width:100%;
      min-width: 100px;
      }

      #navigation .sub-level {
      background: #E9E9E9;
      transition: all .5s ease-out 0s;
      border-style: solid;
      border-color: #710000;
      padding: 0px 0px 5px 0px;
      width: 100%;
      top: 0px;
      left: 125px;
      }

      #navigation .sub-level .sub-level {
      background: #E9E9E9;
      transition: all .5s ease-out 0s;
      border-style: solid;
      border-color: #710000;
      padding: 0px 0px 5px 0px;
      width: 100%;
      }

      li:hover .sub-level .sub-level {
      display:none;
      }
      .sub-level li:hover .sub-level {
      display:block;
      transition: all .5s ease-out 0s;
      }


      .footer {
      height: 150px;
      background: #e9e9e9;
      position: absolute;
      bottom: 0px;
      width:100%


      }

      .footerrow{

      padding: 15px 0px 0px 0px;
      text-align: right;
      max-width: 1120px;
      }

    </style>
  </xsl:template>


</xsl:stylesheet>

