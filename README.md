# gis-data-dictionary


##Credits
Tools are an adaptation of presentation materials and code samples developed by City of Cambridge, MA.
Sweeney, Sean and Sheketoff, Rachel (October 2014) *One Metadata To Rule Them All*. Retrieved from https://github.com/seansweeney/NEARC-2014


#Files

##./Python

Metadataexport.py - Python script for generating an HTML based data dictionary from Esri metadata.  (Must be run from ArcCatalog)

UpdateAgolItems.py - Updates item information in AGOL from information parsed from HTML files generated for data dictionary.


##./XSL

XSL and XSLT files used to generate data dictionary pages and data dictionary index page


#Required

A geodatabase table named MetadataExtract

## Table fields
* DATASOURCE - Path to data (ex. - Database Connections\geoDB.sde\GeoDB.DBO.AOD)
* FILENAME - Name of html file to create (ex. - AOD.html)
* CATEGORY - Category to list data item under (ex. - Zoning)
* SUBCATEGORY - Subcategory to list data item under (Optional)
* ITEMNAME - Name in TOC of Data Dictionary (ex. - Arts Overlay District)
* AGOL_USERID - Owner of AGOL item
* AGOL_FOLDERID - AGOL item's  folder id
* AGOL_ITEMID - AGOL item id
