#######################################################
#Author: Mohamed El-Qassas
#About Author: https://devoworx.com
#Script Name: SharePoint Farm Statistics Scan Report
#Script Description: list all details for Content Databases
#Check the details at: https://spgeeks.devoworx.com/get-all-content-databases-per-farm/
#Check the Full Script details at: https://spgeeks.devoworx.com/sharepoint-farm-scan-report/
#Have a Question: Ask it at https://debug.to
#######################################################
#Add Add-PSSnapin Microsoft.SharePoint.PowerShell
Set-ExecutionPolicy "Unrestricted"
Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction Stop
#######################################################
function SPCDBScanReport()
  { 

		Try
		{
			Write-Host "SharePoint Content Database Scan Report" -ForegroundColor cyan
            Write-Host "--------------------------------------------------------------------"
            $ex = "Exceed the Supported Limit"
            $wa = "Within the Limit"
            #SharePoint Web Application
            $SPWebApp = Get-SPWebApplication 
            # Content Databases
            $ContentDB = Get-SPContentDatabase | select name,WebApplication,@{Name="Contenet Database Size (GB)"; Expression={[math]::Round($_.disksizerequired/1024MB,2)}},@{Name="Within the Limit"; Expression={if([math]::Round($_.disksizerequired/1024MB,2) -ge 200){ "No"} else {"Yes"}}}
            $ContentDBcount = $ContentDB.count
            
            
            ##################################################################################
            #How Many SharePoint Content Database Per farm 
            Write-Host "SharePoint Content Database Per farm" -ForegroundColor cyan
            Write-Host "The supported limit for SharePoint Content Databases per farm is 500 content databases."
            switch($ContentDBcount)
            {
            {$_ -ge 500} {Write-Host "Total Number of SharePoint Content Database:" $_ "|"$ex -ForegroundColor red }
            {$_ -lt 500} {Write-Host "Total Number of SharePoint Content Database:" $_ "|"$wa -ForegroundColor yellow}
            }
            $ContentDB  | Format-List
            Write-Host "For more details, please check https://spgeeks.devoworx.com/sql-server-best-practices-sharepoint/" -ForegroundColor cyan
            Write-Host "--------------------------------------------------------------------"


            ##################################################################################
            #How Many SharePoint Content Database Per Web Application
            Write-Host "SharePoint Content Database Per Web Application" -ForegroundColor cyan
            foreach($WebApp in $SPWebApp){
            Write-Host "The Total Number of Content Database per Web Application" $WebApp.Url "is" (Get-SPContentDatabase -WebApplication $WebApp).count -ForegroundColor green
            Get-SPContentDatabase -WebApplication $WebApp | select name,@{Name="Contenet Database Size (GB)"; Expression={[math]::Round($_.disksizerequired/1024MB,2)}},@{Name="Within the Limit"; Expression={if([math]::Round($_.disksizerequired/1024MB,2) -ge 200){ "No"} else {"Yes"}}} | format-list
            Write-Host "---------------------------------"
            }         
           

            ##################################################################################
            #Content Database Scan Report Summary 
            Write-Host "Content Database Scan Report Summary" -ForegroundColor Green
            Write-Host "Total Number of SharePoint Content Database Per Farm:" $ContentDBcount
            Write-Host "Check the details at: https://spgeeks.devoworx.com/get-all-content-databases-per-farm/" -ForegroundColor cyan
            Write-Host "Check also the SharePoint Farm Scan Report at https://spgeeks.devoworx.com/sharepoint-farm-scan-report/" -ForegroundColor cyan
            Write-Host "--------------------------------------------------------------------"
		}
		Catch
		{
			Write-Host $_.Exception.Message -ForegroundColor Red
		}
  }

#Run SharePoint Content Database Scan Report
SPCDBScanReport