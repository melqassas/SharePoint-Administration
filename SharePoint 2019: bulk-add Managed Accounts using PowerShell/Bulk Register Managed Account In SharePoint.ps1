#######################################################
#Add Add-PSSnapin Microsoft.SharePoint.PowerShell
Set-ExecutionPolicy "Unrestricted"
Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction Stop
#######################################################
#Add service account to managed account
function Add-ManagedAccount()
  {
  Try
   {
    #Get Accounts from CSV
    Import-Csv F:\ManagedAccounts.csv | ForEach-Object {
    $ServiceAccount= $_."Service Account"
    $AccountPassword= $_.Password
    Write-Host "Adding the service Account" $ServiceAccount "to Managed Account" -ForegroundColor Green
    $srvacount = Get-SPManagedAccount | ?  {$_.UserName -eq $ServiceAccount}
    if ($srvacount -eq $null)
        {
        $pass = convertto-securestring $AccountPassword -asplaintext -force
        $cred = new-object management.automation.pscredential $ServiceAccount ,$pass
        $res = New-SPManagedAccount -Credential $cred
         if ($res -ne $null)
            {
                Write-Host "The" $ServiceAccount "has been added successfully to Managed Account" -ForegroundColor Cyan
            }
        }
    else
        {
         Write-Host "The" $ServiceAccount "is already added to Managed Account" -ForegroundColor Yellow
        }
      }
    }
  Catch
    {
    Write-Host $_.Exception.Message -ForegroundColor Red
    break
    }
  }
 
#Add bulk accounts to managed accounts using PowerShell
Add-ManagedAccount