#######################################################
#Author: Mohamed El-Qassas
#About Author: https://devoworx.com
#Script Name: SharePoint Farm Statistics Scan Report
#Script Description: list all details for Site Collection, and SubSites
#Check the details at: https://spgeeks.devoworx.com/all-site-collections-and-subsites-per-farm
#Check the Full Script details at: https://spgeeks.devoworx.com/sharepoint-farm-scan-report/
#Have a Question: Ask it at https://debug.to
#######################################################
#Add Add-PSSnapin Microsoft.SharePoint.PowerShell
Set-ExecutionPolicy "Unrestricted"
Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction Stop
#######################################################
function SPSiteScanReport()
  { 

		Try
		{
			Write-Host "SharePoint Site Collection Scan Report" -ForegroundColor cyan
            Write-Host "--------------------------------------------------------------------"
            $ex = "Exceed the Supported Limit"
            $wa = "Within the Limit"
            #SharePoint Web Application
            $SPWebApp = Get-SPWebApplication 
            $SPWebAppcount = $SPWebApp.count
            # Site Collections
            $SiteCollections = Get-SPSite | select url,contentdatabase,webapplication,@{Name="Site Collection Size (MB)";Expression={[math]::Round($_.usage.storage/(1MB),2)}},@{Name="Within the Limit"; Expression={if([math]::Round($_.usage.storage/1MB,2) -ge 100*1024){ "No"} else {"Yes"}}} | Format-List
            $SiteCollectionscount = (Get-SPSite).count
            # SubSites
            $Subsites = Get-SPSite | Get-SPWeb -Limit All
            $Subsitescount= $Subsites.count
            
            
            ##################################################################################
            #How Many SharePoint Site Collections Per farm 
            Write-Host "SharePoint Site Collections Per farm" -ForegroundColor cyan
            Write-Host "The supported limit for SharePoint Site Collections per farm is 750,000 site collections."
            switch($SiteCollectionscount)
            {
            {$_ -ge 750000} {Write-Host "Total Number of SharePoint Site Collections:" $_ "|"$ex -ForegroundColor red }
            {$_ -lt 750000} {Write-Host "Total Number of SharePoint Site Collections:" $_ "|"$wa -ForegroundColor yellow}
            }
            $SiteCollections
            Write-Host "For more details, please check https://spgeeks.devoworx.com/sharepoint-2019-limitations" -ForegroundColor cyan
            Write-Host "--------------------------------------------------------------------"


            ##################################################################################
            #How Many SharePoint Site Collection Per Web Application
            Write-Host "SharePoint Site Collection Per Web Application" -ForegroundColor cyan
            foreach($WebApp in $SPWebApp){
            Write-Host "The Total Number of site collection per Web Application" $WebApp.Url "is" (Get-SPSite -WebApplication $WebApp).count -ForegroundColor green
            Get-SPSite -WebApplication $WebApp | select url,contentdatabase,@{Name="Site Collection Size (MB)";Expression={[math]::Round($_.usage.storage/(1MB),2)}},@{Name="Within the Limit"; Expression={if([math]::Round($_.usage.storage/1MB,2) -ge 100*1024){ "No"} else {"Yes"}}} | format-list
            Write-Host "---------------------------------"
            }

            ##################################################################################
            #How Many SharePoint Site Collection Per Content Database
            Write-Host "SharePoint Site Collection Per Content Database" -ForegroundColor cyan
            foreach($cDB in Get-SPContentDatabase){
            Write-Host "The Total Number of site collection per content database" $cDB.name "is" (Get-SPSite -ContentDatabase $cDB).count -ForegroundColor green
            Get-SPSite -ContentDatabase $cDB | select url,@{Name="Site Collection Size (MB)";Expression={[math]::Round($_.usage.storage/(1MB),2)}},@{Name="Within the Limit"; Expression={if([math]::Round($_.usage.storage/1MB,2) -ge 100*1024){ "No"} else {"Yes"}}} | format-list | format-list
            Write-Host "---------------------------------"
            }


            ##################################################################################
            #How Many SharePoint SubSites Per farm 
            Write-Host "SharePoint SubSites Per farm" -ForegroundColor cyan
            Write-Host "The supported limit for subsites per farm is 250,000 subsites"
            switch($Subsitescount)
            {
            {$_ -ge 250000} {Write-Host "Total Number of SharePoint SubSites:" $_ "|"$ex -ForegroundColor red }
            {$_ -lt 250000} {Write-Host "Total Number of SharePoint SubSites:" $_ "|"$wa -ForegroundColor yellow}
            }
            $Subsites
            Write-Host "For more details, please check https://spgeeks.devoworx.com/sharepoint-2019-limitations" -ForegroundColor cyan
            Write-Host "--------------------------------------------------------------------"

            ##################################################################################
            #How Many SharePoint SubSites per Site Collection
            Write-Host "SharePoint SubSites per Site Collection" -ForegroundColor cyan
            foreach($SC in Get-SPSite){
            Write-Host "The Total Number of SubSites per Site Collection" $SC.Url "is" (Get-SPWeb -Site $SC -Limit All).count -ForegroundColor green
            Get-SPWeb -Site $SC -Limit All | select url | format-list
            Write-Host "---------------------------------"
            }

            ##################################################################################
            #Site Collection Scan Report Summary 
            Write-Host "Site Collection Scan Report Summary" -ForegroundColor Green
            Write-Host "Total Number of SharePoint Web Application Per Farm:" $SPWebAppcount
            Write-Host "Total Number of SharePoint Site Collection Per Farm:" $SiteCollectionscount
            Write-Host "Total Number of SharePoint SubSites Per Farm:" $Subsitescount
            Write-Host "Check the details at: https://spgeeks.devoworx.com/all-site-collections-and-subsites-per-farm" -ForegroundColor cyan
            Write-Host "For more details, please check https://spgeeks.devoworx.com/sharepoint-farm-scan-report/" -ForegroundColor cyan
            Write-Host "--------------------------------------------------------------------"
		}
		Catch
		{
			Write-Host $_.Exception.Message -ForegroundColor Red
		}
  }

#Run SharePoint Site Collection Scan Report
SPSiteScanReport