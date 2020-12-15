# Author: Mohamed El-Qassas
# Blog  : blog.devoworx.net
# Date  : 08/19/2017
# Description:
#PowerShell Script to Detect the Installed SharePoint 2016 Edition

#Add Add-PSSnapin Microsoft.SharePoint.PowerShell
Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction Stop

#Get SharePoint 2016 Edition 
function Get-SP2016Edition()
    {
       $SharePointEditionGuid = (Get-SPFarm).Products 
       $SharePointEdition = switch ($SharePointEditionGuid) 
           { 
             5DB351B8-C548-4C3C-BFD1-82308C9A519B {"The Installed SharePoint Edition is SharePoint 2016 Trail Edition."; Break}
             4F593424-7178-467A-B612-D02D85C56940 {"The Installed SharePoint Edition is SharePoint 2016 Standard Edition."; Break} 
             716578D2-2029-4FF2-8053-637391A7E683 {"The Installed SharePoint Edition is SharePoint 2016 Enterprise Edition."; Break} 
           }
          
        if($SharePointEdition -eq $null)
           {
               Write-Host "The SharePoint Edition can't be determined." -ForegroundColor Red
           }
        else
           {
               Write-Host $SharePointEdition -ForegroundColor Yellow
               Write-Host "The Biuld Version:" (Get-SPFarm).buildversion -ForegroundColor Yellow
           }      
   }

#Get SharePoint 2016 Edition 
Get-SP2016Edition