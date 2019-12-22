

Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction Stop
#Allow or disallow List Item Menu Context in SharePoint List.
function Manage-ListItemMenu()
	{
	param ([string]$WebAppURL,[string]$List,[string]$Field,[bool]$Allow)
		Try
		{
             $Web = Get-SPWeb $WebAppURL
             $Lst = $web.Lists[$List]
             $Fld = $Lst.Fields[$Field]
             $msg = "The List Item Menu Context has been allowed for"
             if($Allow -eq $True)
             {
               Write-Host "Allow List Item Menu Context in SharePoint List" -ForegroundColor Green
               $Fld.ListItemMenuAllowed = "Required"
               $msg = "The List Item Menu Context has been allowed for"
             }
            else
            {
               Write-Host "DisAllow List Item Menu Context in SharePoint List" -ForegroundColor Green
               $Fld.ListItemMenuAllowed = "Prohibited"
               $msg = "The List Item Menu Context has been disallowed for"
            }
  
                #Reflect the Update
                $Fld.Update()
                $Lst.Update()
                Write-Host $msg $Field "successfully" -ForegroundColor Cyan
			
		}
		Catch
		{
			Write-Host $_.Exception.Message -ForegroundColor Red
		}
	}

Manage-ListItemMenu -WebAppURL "http://epm:19812/PWA/" -List "LinkToItemMenu" -Field "Allow" -Allow $False

