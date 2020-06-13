#######################################################
#Author: Mohamed El-Qassas
#About Author: https://devoworx.com
#Script Name: Show and Hide Column in SharePoint List Forms Using PowerShell 
#Check the details at: https://spgeeks.devoworx.com/all-site-collections-and-subsites-per-farm
#Have a Question: Ask it at https://debug.to
#######################################################
#Add Add-PSSnapin Microsoft.SharePoint.PowerShell
Set-ExecutionPolicy "Unrestricted"
Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction Stop
#######################################################
function ShowHide_SPColumn()
  { 
    param([string]$SiteURL,$ListTitle,$FieldName,$FormType,[bool]$Show)

    try{
        $web = Get-SPWeb -Site $SiteURL
        $list = $web.lists | Where-Object { $_.title -Eq $ListTitle } 
        if($list)
            {
              if($Show -eq $true){
                   $Action = "Show"
               }
               else
               {
                   $Action = "Hide"
               }
                
               $reply = Read-Host -Prompt "Are you sure you would like to $Action '$FieldName' column in '$FormType form' in '$list' list?[y/n]"
                if ( $reply -match "[yY]" ) {   
                $Fields= $list.Fields
                $RField= $Fields[$FieldName]
                foreach ($Field in $Fields)
                    {
                        if($Field -eq $RField)
                            {
                                $found = $true
                                switch($FormType)
                                {
                                "New" {$RField.ShowInNewForm=$Show; break}
                                "Edit" {$RField.ShowInEditForm=$Show; break}
                                "Display" {$RField.ShowInDisplayForm=$Show; break}
                                "All" {$RField.ShowInNewForm=$Show;$RField.ShowInEditForm=$Show;$RField.ShowInDisplayForm=$Show; break}
                                 default {$RField.ShowInNewForm=$false; break}
                                }
                                $RField.Update()
                                if($Show -eq $true){
                                    Write-Host "This field '$FieldName' has been shown in '$FormType form' successfully" -ForegroundColor Green
                                }
                                else
                                {
                                    Write-Host "This field '$FieldName' has been hidden in '$FormType form' successfully" -ForegroundColor Green
                                }
                    break;
                            }
                    
                    } 
                    if(!$found)
                       {
                           Write-Host "This field '$FieldName' is not found in '$list'" -ForegroundColor Yellow
                           Write-Host "The available fields in '$list' list" -ForegroundColor Cyan
                           $Fields | select title
                       }
        }
        
      }
      else
        {
            Write-Host "This list '$ListTitle' is not found, please make sure you have typed the list title and site URL correctly" -ForegroundColor Yellow
        }

    }
        Catch
	{
        Write-Host $_.Exception.Message -ForegroundColor Red
        break
	}
}

# -FormType "New" or "Edit" or "Display" or"All"
ShowHide_SPColumn -SiteURL "http://epm:19812" -ListTitle "Show and Hide SharePoint Column" -FieldName "Test" -FormType "All" -Show $false

