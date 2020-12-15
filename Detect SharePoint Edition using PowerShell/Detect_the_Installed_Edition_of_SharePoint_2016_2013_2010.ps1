# Author: Mohamed El-Qassas
# Blog  : blog.devoworx.net
# Date  : 08/19/2017
# Description: PowerShell Script to Detect the Installed Edition of SharePoint 2016 - 2013 -2010

#Add Add-PSSnapin Microsoft.SharePoint.PowerShell
Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction Stop

#Get SharePoint Edition 
function Get-SharePointEdition()
 {
   Write-Host "-----------------------------------------------------------------------" -ForegroundColor yellow
   Write-Host "The Installed SharePoint" -ForegroundColor yellow
   Write-Host "-----------------------------------------------------------------------" -ForegroundColor yellow
   $SharePointEditionGuid = (Get-SPFarm).Products 
   switch ($SharePointEditionGuid) 
      { 
             #SharePoint 2016 Editions
             5DB351B8-C548-4C3C-BFD1-82308C9A519B {"SharePoint 2016 Trail."}
             4F593424-7178-467A-B612-D02D85C56940 {"SharePoint 2016 Standard."} 
             716578D2-2029-4FF2-8053-637391A7E683 {"SharePoint 2016 Enterprise."} 
             #SharePoint 2013 Editions
             9FF54EBC-8C12-47D7-854F-3865D4BE8118 {"SharePoint Foundation 2013."} 
             35466B1A-B17B-4DFB-A703-F74E2A1F5F5E {"SharePoint Server 2013 Enterprise plus Project Server 2013.";break}
			 BC7BAF08-4D97-462C-8411-341052402E71 {"SharePoint Server 2013 Enterprise plus Project Server 2013 Trail.";break}
             B7D84C2B-0754-49E4-B7BE-7EE321DCE0A9 {"SharePoint Server 2013 Enterprise."} 
			 298A586A-E3C1-42F0-AFE0-4BCFDC2E7CD0 {"SharePoint Server 2013 Enterprise Trail."} 
             C5D855EE-F32B-4A1C-97A8-F0A28CE02F9C {"SharePoint Server 2013."}
			 CBF97833-C73A-4BAF-9ED3-D47B3CFF51BE {"SharePoint Server 2013 Trail."}
             #SharePoint 2010 Editions
             BEED1F75-C398-4447-AEF1-E66E1F0DF91E {"SharePoint Foundation 2010."} 
             B2C0B444-3914-4ACB-A0B8-7CF50A8F7AA0 {"SharePoint Server 2010 Standard Trial."}
             3FDFBCC8-B3E4-4482-91FA-122C6432805C {"SharePoint Server 2010 Standard."} 
             88BED06D-8C6B-4E62-AB01-546D6005FE97 {"SharePoint Server 2010 Enterprise Trial."} 
             D5595F62-449B-4061-B0B2-0CBAD410BB51 {"SharePoint Server 2010 Enterprise."} 
             84902853-59F6-4B20-BC7C-DE4F419FEFAD {"Project Server 2010 Trial."} 
             ED21638F-97FF-4A65-AD9B-6889B93065E2 {"Project Server 2010."} 
             default {"The SharePoint edition can't be determined"}
      }
       
        Write-Host "-----------------------------------------------------------------------" -ForegroundColor yellow
        Write-Host "The Biuld Version" -ForegroundColor yellow
        Write-Host "-----------------------------------------------------------------------" -ForegroundColor yellow
        Write-Host  (Get-SPFarm).buildversion
      
 }

#Get SharePoint Edition 
Get-SharePointEdition