# Author: Mohamed El-Qassas
# Blog  : https://devoworx.com
# Date  : 04/01/2021
# Read instrcutions at https://spgeeks.devoworx.com
# Description: PowerShell Script to Get the Version Comments for each Document and other Version Details in SharePoint Document Library
# Have a quiestion, Please ask it at https://debug.to

#Add Add-PSSnapin Microsoft.SharePoint.PowerShell
Set-ExecutionPolicy "Unrestricted"
Add-PSSnapin "Microsoft.SharePoint.PowerShell"
#Variables
function ExportDocLibVersions ()
{
    param([string]$siteURL,$DocLibName)
try
{

####################################################################

#Get the Web and document library
$WebSite = Get-SPWeb $siteURL
$DocLib = $WebSite.Lists.TryGetList($DocLibName)
####################################################################

#Check if the version settings is enabled to proceed

If ($DocLib.EnableVersioning -eq $TRUE) 
  {  
  Write-host "The version settings is enabled for" $DocLibName -ForegroundColor Cyan
  Write-host "Start Exporting process ......." -ForegroundColor green

#Prepare the file Path
$ReportFolderPath = "C:\SPVersions\$DocLibName\LibVersions-$((Get-Date).ToString('yyyy-MM-dd-hh-mm-ss-tt'))"
New-Item -ItemType Directory -Path $ReportFolderPath
$ReportFilePath = "$ReportFolderPath\versions.csv"
New-Item -ItemType file -Path $ReportFilePath


#check the Report path
if(Test-path $ReportFilePath)
{
####################################################################

#Check if the doc lib is found

if($DocLib -ne $null)
 {
    #Get all documents
    $DocsCollection = $DocLib.Items
    if($DocsCollection -ne $null)
    {
       #iterate for each doc in document library
       foreach ($Doc in $DocsCollection)
        {
          $Vcount = ($Doc.Versions).Count #Get the Version Count
          $totalVersions=$Vcount  #Total Versions
          $count= $Vcount #Set the decremental count to the Version Count
          #Iterate for each version in each document
          Add-Content -Path $ReportFilePath -Value "Doc ID,Document Name,Created By, Created Date, Modified By, Modified Date ,Size (KB)"
          Add-Content -Path $ReportFilePath -Value "$($Doc.id),$($Doc.Name),$($Doc['Author']),$($Doc['Created']),$($Doc['Editor']),$($Doc['Modified']),$($Doc.File.Length)"
          Add-Content -Path $ReportFilePath -Value "Version ID,Version Title, Modified By, Modified at ,Size (KB), CheckInComments"
           foreach($version in $Doc.Versions)
             {
               if([int]$count -eq $Vcount)
                  {
                    $VersionDetails = "$($version.VersionLabel),$($version['Title']), $($version.CreatedBy.User.DisplayName), $($version.Created),$($Doc.File.Versions.GetVersionFromLabel($version.VersionLabel).Size),$($version['Check In Comment'])"
                  }
                  else
                  {
                    $VersionDetails = "$($version.VersionLabel),$($version['Title']), $($version.CreatedBy.User.DisplayName), $($version.Created),$($Doc.File.Versions.GetVersionFromLabel($version.VersionLabel).Size),$($Doc.File.Versions.GetVersionFromLabel($version.VersionLabel).CheckInComment)"
                  }
                  # add the version details to the exported file
                  Add-Content -Path $ReportFilePath -Value $VersionDetails
                  $count = $count -1 #decrease version count
             }
             #Add Item Sperator
             Add-Content -Path $ReportFilePath -Value "---------------------------------------------------"
             $totalVersion = $totalVersion + $Vcount
        }

        Write-host "The versions of " $DocLibName " have been exported successfuly at " $ReportFilePath  -ForegroundColor Green
        start $ReportFilePath
        Write-host "------------------------------------------------------" -ForegroundColor Cyan
        Write-host "Export Operation Summary" 
        Write-host "------------------------------------------------------" -ForegroundColor Cyan
        Write-host "Site URL:" $siteURL -ForegroundColor Cyan
        Write-host "Site Title:" $WebSite -ForegroundColor Cyan
        Write-host "Document Library Name:" $DocLib -ForegroundColor Cyan
        Write-host "Number of Documents:" $DocsCollection.Count -ForegroundColor Cyan
        Write-host "Number of Versions:" $totalVersion -ForegroundColor Cyan
    }
     else
       {
         Write-host "No Documents in " $DocLibName -ForegroundColor Red
       }
 }
 else
 {
     Write-host "The " $DocLibName " is not found" -ForegroundColor Red
 }
 }
 else
 {
 Write-host $ReportFilePath "is not found" -ForegroundColor Red
 }

 }
 else
 {
 Write-host "The version settings is not enabled, please enabel it first" -ForegroundColor Red
 [system.Diagnostics.Process]::Start("iexplore","https://debug.to")
 }

 }
 catch
 {
    Write-host $_.Exception.Message -ForegroundColor Red
 }

}


# Provide the SharePoint Site URL, and the Document Library Name
ExportDocLibVersions -siteURL "http://epm:19812/pmo/" -DocLibName "Doc Lib Get Versions Details" 




