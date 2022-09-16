#Update Publishing Page Properties in SharePoint Server 2019,2016
#Author: Mohamed El-Qassas

Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue
 
$siteURL = "http://epm:19812/sites/pp/"
$CurrentPageURL = "http://epm:19812/sites/pp/Documents/devo1.png"
$NewPageURL = "http://epm:19812/sites/pp/Documents/debug.png"
$NewpageName = "debug"
$NewpageTitle = "debug"

try
{

    $SPWeb = Get-SPWeb $siteURL -ErrorAction SilentlyContinue
    #Check if site is correct
    if ($SPWeb -ne $null)
        {
            #Check if new file name is not exist
            $CheckNewFile = $spWeb.GetFile($NewPageURL)
            if ($CheckNewFile."Exists" -ne $false)
                {
                    Write-Host "The specified name ($NewpageName) is already in use, Please specifiy another page name" -ForegroundColor Red
                }
            else
                {

                    $SPpage = $spWeb.GetFile($CurrentPageURL);
                    [Microsoft.SharePoint.SPListItem]$SPListItem = $SPpage.Item
                    
                    #Check if the current file is exist
                    if ($SPListItem -ne $null)
                        {
                            if($SPpage.CheckOutType -eq "None" -And $SPpage.LockType -eq "None")
                               
                                { 
                                    $SPpage.CheckOut()  
                                } 
                                    
                                    $SPListItem["Name"] = $NewpageName
                                    $SPListItem["Title"] = $NewpageTitle
                                    #Cusotm fields, in your case you have to set your custom fields name
                                    $SPListItem["Comment"] = "File has been updated by PowerShell"
                                    $SPListItem.Update();
                                    $SPpage = $SPWeb.GetFile($NewPageURL);
                                    $SPpage.CheckIn("Page Updated",[Microsoft.SharePoint.SPCheckinType]::MajorCheckIn)
                                    Write-Host "the $SPpage name and title has been updated" -ForegroundColor Yellow
                                    Start-Process $NewPageURL
                            
                }
        else
            {
                Write-Host "the $SPpage is not found" -ForegroundColor Red
            }
        }

        $SPWeb.Dispose()
    }
        else {Write-Host "The specified site ($siteURL) is not found, Please specifiy an exisiting site URL" -ForegroundColor Red}
}
catch
    {
        Write-Host "An error occurred:"
        Write-Host $_ -ForegroundColor Red
    }