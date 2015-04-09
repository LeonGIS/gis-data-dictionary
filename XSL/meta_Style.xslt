<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>


  <xsl:template name="MetaStyles">
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

      <!--General Elements-->
      a:link {
      color: #098EA6;
      font-weight: normal;
      text-decoration: none;
      }

      a:visited {
      color: #098EA6;
      text-decoration: none;
      }

      h1 {
      font-size: 22px;
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

      h1.idAppTitle {
      font-size: 44px;
      text-shadow: 1px 1px 1px #E9E9E9;
      font-family: Arial, Helvetica, sans-serif;
      font-weight: bold;
      color: #000;
      padding: 30px 0px 30px 0px;
      }

      h2 {
      font-size: 16px;
      margin-left: 10px;
      }

      .container {
      margin-left: auto;
      margin-right:auto;
      width: 980px;
      }

      <!--Layout-->
      .leftPanel{
      width:200px;
      position: relative;
      float:left;
      height: auto !important;
      }
      .mainPanel {
      width: 750px;
      position: relative;
      float: left;
      padding: 0 0 0 30px;
      }

      #content{
      background: #e5e5e5;
      padding: 0px 10px 0px 10px;
      }


      <!--Header -->
      #header {
      height: 75px;
      overflow: hidden;
      color: #000;
      position: relative;
      background: #710000;
      }


      .headerContainer {
      height: 75px;
      background: url(./images/banner.png);
      padding: 0px 10px 0px 10px;
      }

      #templateNav {
      list-style: none;
      margin: 0;
      padding: 0;
      }

      #header ul #homeItem a {
      display: inline-block;
      background: none;
      max-height: 75px;
      font-size: 35px;
      line-height: 75px;
      height: 75px;
      padding: 0;
      margin: 0;
      overflow: hidden;
      text-shadow: 1px 1px 1px #000;
      font-family: Arial, Helvetica, sans-serif;
      font-weight: bold;
      color: #fff;
      }

      #header ul li {
      display: block;
      float: left;
      margin: 0;
      padding: 0;
      background: none;
      }


      <!--Footer -->
      #footer{
      position: relative;
      width:100%;
      float:right;
      height: 145px;
      background: #4d4d4d;
      }

      .footerrow{
      padding: 20px 0px 0px 0px;
      }

      .footcontainer{
      margin-left: auto;
      margin-right: auto;
      width: 960px;
      }

      .foot_rightdiv{
      float: right;
      margin-left: 10px;
      margin-right: 10px;
      }

      #footer h2 {
      font-size: 24px;
      text-shadow: 1px 1px 1px #333;
      font-family: Arial, Helvetica, sans-serif;
      font-weight: bold;
      line-height: 30px;
      color: #dddddd;
      margin: 0 0 5px 0;
      }

      #footerDescription{
      color: fff;
      font-family: Arial, Helvetica, sans-serif;
      font-size: 14px;
      line-height: 18px;
      text-align: left;
      }

      #footer .Pad {
      padding: 20px 0;
      }

      .foot_leftdiv{
      width: 200px;
      float: left;
      }

      #footer .logoDiv{
      padding: 20px;
      text-align: center;
      }

      #footer .footBorder {
      zoom: 1;
      background: url(./images/logoBorder.jpg) repeat-y top right;
      }
      
      #yourLogo {
      display: inline-block;
      zoom: 1;
      border: 0;
      margin-bottom: 5px;
      outline: 0;
      width: 60px;
      height: 60px;
      border-radius: 5px;
      opacity: 1;
      }

      #yourLogo img {
      border: 0;
      margin: 0;
      outline: 0;
      display: inline-block;
      zoom: 1;
      width: 60px;
      height: 60px;
      -webkit-border-radius: 5px;
      border-radius: 5px;
      }

      <!-- Navigation Menus -->
      #navigation {
      font-size:1em;
      width:200px;
      border-style: solid;
      background: #E9E9E9;
      margin-top: 120px;
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
      z-index:99999;
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


      <!-- Main Content-->
      .main {
      left: 220px;
      position: relative;
      width: 75%;
      margin-left: 30px;
      max-width: 900px;
      margin-bottom: 150px;
      }



      <!-- Index Page content-->

      <!-- Index Page table-->
      .Category li {
      list-style: none;
      padding: 0px 0px 5px 0px;
      }

      .Category a{
      font-size: 1.2em;
      }

      .Category h2 {
      font-size: 1.4em;
      margin-left: 10px;
      }

      .Category h3 {
      font-size: 1.2em;
      font-style: italic;
      }


      <!-- Metadata page content -->
      div.itemDescription {
      margin-right: 2em;
      margin-bottom: 2em;
      }

      <!--Title/Image section-->
      div.itemTitle {
      align-items: center;
      display: flex;
      }

      div.meta_title_left{
      width: 350px;
      float: left;
      }
      div.meta_title_rightt{
      margin-left: 10px;
      margin-bottom:10px;
      }

      <!--Thumbnail-->
      .center {
      text-align: center;

      }
      img.center {
      display: block;
      border-color: #666666;
      }

      <!-- Item Info  General-->
      .itemInfo p {
      margin-left: 20px;
      }

      <!--Attribute Table-->
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

      <!-- Tags -->
      .itemInfoHidden {
      display:none;
      }

    </style>
  </xsl:template>


</xsl:stylesheet>


