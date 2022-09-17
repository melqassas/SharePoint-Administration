#Replace a specific word in file name using PowerShell in SharePoint Server 2019,2016
#Author: Mohamed El-Qassas

Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue
 
$siteURL = "http://epm:19812/sites/pp/"
$DocLibName = "Documentss"
$oldword = "qassas"
$newword = "debug"


$TotalfileCounts =0
$filesupdatedCount= 0
try
{

    $SPWeb = Get-SPWeb $siteURL -ErrorAction SilentlyContinue
    #Check if site is correct
    if ($SPWeb -ne $null)
        {
            $DocLib = $SPWeb.Lists[$DocLibName] 
            #Check if cocument library is exist
            if($DocLib -ne $null)
             {
                $TotalfileCounts = $DocLib.Items.Count
                Write-host "The total number of files in ($DocLibName) is ($TotalfileCounts)" -ForegroundColor Cyan
                foreach($ListItem in $DocLib.Items)
                  {
                    $fileName = $ListItem["Name"]
                    if($fileName.ToLower().Contains($oldword))
                        {
                        
                        $filesupdatedCount = $filesupdatedCount +1
                        if($ListItem.File.CheckedOutByUser -eq $null) #if the file is not checked out
                            {
                                $ListItem.File.CheckOut() #check the file out
                                }
                               
                                   
                                    $ListItem["Name"] = $ListItem["Name"].replace($oldword,$newword) #replace
                                    $ListItem["Comment"] ="File has been Updated by PowerShell"
                                    $ListItem.Update() 
                                    $ListItem.File.CheckIn("File has been Updated by PowerShell",[Microsoft.SharePoint.SPCheckinType]::MajorCheckIn) 
                                    $NewfileName = $ListItem["Name"]
                                    Write-Host "- The file '$fileName' name been updated to '$NewfileName'" -ForegroundColor Yellow
                        }
                    }
                    Write-host "The total number of updated files in ($DocLibName) is ($filesupdatedCount)" -ForegroundColor Cyan
               } else {Write-Host "The specified document library ($DocLibName) is not found, Please specifiy an exisiting and correct Document Library Name" -ForegroundColor Red}

        
        $SPWeb.Dispose()
        } else {Write-Host "The specified site ($siteURL) is not found, Please specifiy an exisiting site URL" -ForegroundColor Red}
}
catch
    {
        Write-Host "An error occurred:"
        Write-Host $_ -ForegroundColor Red
    }