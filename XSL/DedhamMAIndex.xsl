<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"   >
  <!-- An XSLT template for displaying metadata in ArcGIS that is stored in the ArcGIS metadata format.

     Copyright (c) 2009-2013, Environmental Systems Research Institute, Inc. All rights reserved.
	
     Revision History: Created 3/19/2009 avienneau
-->

  <xsl:import href = "meta_Style.xslt" />
  <xsl:import href = "DedhamMAIndexPage.xslt" />

  <xsl:output method="html" omit-xml-declaration="yes" />
  <xsl:param name="flowdirection"/>

  <xsl:template match="/">
    <html xmlns="http://www.w3.org/1999/xhtml">
      <xsl:if test="/*/@xml:lang[. != '']">
        <xsl:attribute name="xml:lang">
          <xsl:value-of select="/*/@xml:lang"/>
        </xsl:attribute>
        <xsl:attribute name="lang">
          <xsl:value-of select="/*/@xml:lang"/>
        </xsl:attribute>
      </xsl:if>

      <head>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
     
        <!--<xsl:call-template name="styles" />-->
        <xsl:call-template name="MetaStyles" />
      </head>

      <body oncontextmenu="return true">
        <xsl:if test="$flowdirection = 'RTL'">
          <xsl:attribute name="style">direction:rtl;</xsl:attribute>
        </xsl:if>

     
        <xsl:call-template name="iteminfo"/>
      </body>
    </html>

  </xsl:template>

</xsl:stylesheet>

