# -*- coding: utf-8 -*-
# ---------------------------------------------------------------------------
# UpdatreAgolItems.py
# Created on: 3/3/2015
#   
# Description: 
# ---------------------------------------------------------------------------

# For Http calls
import httplib, urllib, json

# For system tools
import sys

# Import arcpy module
import arcpy
from arcpy import env

import os
import logging
import json

from HTMLParser import HTMLParser


# Defines the entry point into the script
def main(argv=None):   
    # Set up logging
    LOG_FILENAME = 'C:\development\Metadata\Output\Metadata_UpdateAGOL.log'
    logging.basicConfig(level=logging.DEBUG,
                    format='%(asctime)s %(levelname)-8s %(message)s',
                    datefmt='%a, %d %b %Y %H:%M:%S',
                    filename=LOG_FILENAME,
                    filemode='a')

    logging.info("")
    logging.info("**************************")
    # Get input parameters
    ExtractTable =  arcpy.GetParameterAsText(0)
    inputrepository =  arcpy.GetParameterAsText(1)
    portalURL = arcpy.GetParameterAsText(2)
    AGOLusername = arcpy.GetParameterAsText(3)
    AGOLpassword = arcpy.GetParameterAsText(4)
    datadictionary = arcpy.GetParameterAsText(5)
    

    #ExtractTable = "C:\development\Metadata\Python\metadatascript.gdb\MetadataExtract"
    #inputrepository = "C:\development\Metadata\Output"
    #datadictionary = "http://gis.dedham-ma.gov/datadictionary/"
    #portalURL = ""
    #AGOLusername = ""
    #AGOLpassword = ""
    #TokenExpiration = 15


     # Get a token
    token = getAGOLToken(AGOLusername, AGOLpassword, TokenExpiration)
    if token == "":
        logging.info("Failed to get token")
        return

    # Search each metadata page
    fields = ['FILENAME', 'AGOL_USERID','AGOL_FOLDERID', 'AGOL_ITEMID']

    try:
        with arcpy.da.SearchCursor(ExtractTable, fields) as cursor:
            for row in cursor:
                if not (row[0] is None) and not (row[1] is None) and not (row[2] is None) and not (row[3] is None):
                    strSummary = ''
                    strDesc = ''
                    strConstraints = ''
                    strTags = ''
                    strCredits = ''
                    parser = MyParser()
                    parser.feed(open(inputrepository + '\\' + row[0]).read())
                    strDesc = parser.Desc

                    strDesc = strDesc + "<div><br /><div> <a href=" + datadictionary + row[0] +">View Full Metadata</a></div></div>"

                    strSummary = parser.Summary
                    strConstraints = parser.UseConst

                    if strConstraints == '':
                        strConstraints = parser.AccessConst
                    elif parser.AccessConst != '':
                        strConstraints = strConstraints + "<div><br /><div>" + parser.AccessConst + "</div></div>"
                    strTags = parser.Tags
                    strCredits = parser.Credits
   
                    parser.close()
   
                    #Updata AGOL item
                    updateItemDescription(row[1], row[2], row[3],portalURL, token, strSummary, strDesc, strConstraints, strTags, strCredits )
                    logging.info("Updated from " + row[0])
    except:
        success = False
        logging.info(arcpy.GetMessages(2))

    #Shutdown logging    
    logging.shutdown()    
    
def updateItemDescription(userID, folderID, itemID, portalURL, token=None,  snippet='', desc='',  constraints='', tags='', credits=''):
    '''Update the item descriptive information.'''
    params = {
        'snippet': snippet,         # Summary
        'description': desc, # Includes HTML attrib table
        'licenseinfo': constraints,
        'tags' : tags,
        'accessinformation': credits,
        'token' : token,
        'f': 'json'
    }
    requestURL = portalURL + '/sharing/rest/content/users/' + userID + '/' + \
                 folderID + '/items/' + itemID + '/update'
    print requestURL
    f = urllib.urlopen(requestURL, urllib.urlencode(params));
    results = f.read();
    print results
    return results


class MyParser(HTMLParser):
    def __init__(self):
        self.reset()
        self.Title = ''
        self.FoundTitle = 0
        self.Summary = ''
        self.FoundSummary = 0
        self.Desc = ''
        self.FoundDesc = 0
        self.UseConst = ''
        self.FoundUseConst = 0
        self.AccessConst = ''
        self.FoundAccessConst = 0
        self.Tags = ''
        self.FoundTags = 0
        self.Credits = ''
        self.FoundCredits = 0
        self.Thumbnail =''
      
    def handle_starttag(self, tag, attrs):
        if tag == 'h1':
            for name, value in attrs:
                if name == 'class' and value == 'idHeading':
                    self.FoundTitle = 1
        if tag == 'p':
            for name, value in attrs:
                if name == 'id' and value == 'AGOL_Summary':
                    self.FoundSummary = 1
                elif name == 'id' and value == 'AGOL_Desc':
                    self.FoundDesc = 1
                elif name == 'id' and value == 'AGOL_UseConst':
                    self.FoundUseConst = 1
                elif name == 'id' and value == 'AGOL_AccessConst':
                    self.FoundAccessConst = 1
                elif name == 'id' and value == 'AGOL_Tags':
                    self.FoundTags = 1
                elif name == 'id' and value == 'AGOL_Credits':
                    self.FoundCredits = 1
        if tag == 'img':
            for name, value in attrs:
                if name == 'src':
                    self.Thumbnail = value

    def handle_data(self, data):
        if self.FoundTitle:
            self.Title = data
            self.FoundTitle = 0
        elif self.FoundSummary:
            self.Summary = data
            self.FoundSummary = 0
        elif self.FoundDesc:
            self.Desc = data
            self.FoundDesc = 0
        elif self.FoundUseConst:
            self.UseConst = data
            self.FoundUseConst = 0
        elif self.FoundAccessConst:
            self.AccessConst = data
            self.FoundAccessConst = 0
        elif self.FoundTags:
            self.Tags = data
            self.FoundTags = 0
        elif self.FoundCredits:
            self.Credits = data
            self.FoundCredits = 0

    def clean(self):
        self.Title = ''
        self.FoundTitle = 0
        self.Summary = ''
        self.FoundSummary = 0
        self.Desc = ''
        self.FoundDesc = 0
        self.UseConst = ''
        self.FoundUseConst = 0
        self.AccessConst = ''
        self.FoundAccessConst = 0
        self.Tags = ''
        self.FoundTags = 0
        self.Credits = ''
        self.FoundCredits = 0
        self.Thumbnail = ''
 
    
    
# A function to generate a token given username, password for ArcGIS.com
def getAGOLToken(username, password, expires):
    # Token URL is typically http://server[:port]/arcgis/admin/generateToken
    tokenURL = "/sharing/generateToken"
    
    # URL-encode the token parameters
    params = urllib.urlencode({'username': username, 'password': password, 'referer': 'requestip', 'expiration': expires, 'f': 'json'})
    
    headers = {"Content-type": "application/x-www-form-urlencoded", "Accept": "text/plain"}
    
    # Connect to URL and post parameters
    httpsConn = httplib.HTTPSConnection("www.arcgis.com", "443")
    httpsConn.request("POST", tokenURL, params, headers)
    
    # Read response
    response = httpsConn.getresponse()
    if (response.status != 200):
        httpsConn.close()
        print "Error while fetching tokens from admin URL. Please check the URL and try again."
        return
    else:
        data = response.read()
        httpsConn.close()
        
        # Check that data returned is not an error object
        if not assertJsonSuccess(data):            
            return ""
        
        # Extract the token from it
        token = json.loads(data)        
        return token["token"]
    
#A function that checks that the input JSON object
#  is not an error object.    
def assertJsonSuccess(data):
    obj = json.loads(data)
    if 'error' in obj:
        err = obj['error']
        logging.info("JSON Error: " + err['message'])
        return False
    else:
        return True    
    
# Script start
if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))