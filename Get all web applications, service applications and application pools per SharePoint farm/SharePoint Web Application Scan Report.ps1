#######################################################
#Author: Mohamed El-Qassas
#About Author: https://devoworx.com
#Script Name: SharePoint Web Application Scan Report
#Script Description: list all details for Web Application, Application Pool, Running Service Application
#Check the details at: https://spgeeks.devoworx.com/get-all-web-applications-per-farm/
#Check the Full Script details at: https://spgeeks.devoworx.com/sharepoint-farm-scan-report/
#Have a Question: Ask it at https://debug.to
#######################################################
#Add Add-PSSnapin Microsoft.SharePoint.PowerShell
Set-ExecutionPolicy "Unrestricted"
Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction Stop
#######################################################
function SPWebAppScanReport()
  { 

		Try
		{
			Write-Host "SharePoint Web Application Scan Report" -ForegroundColor cyan
            Write-Host "--------------------------------------------------------------------"
            $ex = "Exceed the Supported Limit"
            $wa = "Within the Limit"
            #SharePoint Web Application
            $SPWebApp = Get-SPWebApplication 
            $SPWebAppcount = $SPWebApp.count
            #SharePoint Web Application Pool
            $SPWebAppPool = Get-SPWebApplication | select ApplicationPool -Unique
            #SharePoint Service Application Pool
            $SPSrvWebAppPool = Get-SPServiceApplicationPool  | Select -Unique
            $SPAppPoolCount = $SPSrvWebAppPool.count + $SPWebAppPool.count
            #SharePoint Service Applications
            $SPSrvApp = Get-SPServiceApplication | select id,name
            $SPSrvAppcount= $SPSrvApp.count
            
            
            ##################################################################################
            #How Many Web Applications in farm 
            Write-Host "SharePoint Web Applications per Farm" -ForegroundColor cyan
            Write-Host "The supported limit for the SharePoint web application per farm is 20 web applications."
            switch($SPWebAppcount)
            {
            {$_ -ge 20} {Write-Host "Total Number of SharePoint Web Application:" $_ "|"$ex -ForegroundColor red }
            {$_ -lt 20} {Write-Host "Total Number of SharePoint Web Application:" $_ "|"$wa -ForegroundColor yellow}
            }
            $SPWebApp
            Write-Host "For more details, please check https://spgeeks.devoworx.com/sharepoint-2019-limitations" -ForegroundColor cyan
            Write-Host "--------------------------------------------------------------------"


            ##################################################################################
            #How Many SharePoint Web Application Pools for the web server Per farm 
            Write-Host "SharePoint Web Application Pools for the web server Per farm" -ForegroundColor cyan
            Write-Host "SharePoint Application Pool Limits for Web Server per Farm is 10 Application Pools (This limit depends mainly on the Server Hardware specifications)."
            switch($SPAppPoolCount)
            {
            {$_ -ge 10} {Write-Host "Total Number of SharePoint Application Pool:" $_ "|"$ex -ForegroundColor red }
            {$_ -lt 10} {Write-Host "Total Number of SharePoint Application Pool:" $_ "|"$wa -ForegroundColor yellow}
            }
            $SPWebAppPool
            $SPSrvWebAppPool | select name
            Write-Host "For more details, please check https://spgeeks.devoworx.com/sharepoint-2019-service-accounts-best-practice/" -ForegroundColor cyan
            Write-Host "--------------------------------------------------------------------"

            
            ##################################################################################
            #How Many SharePoint Service Applications Running on farm
            Write-Host "Running SharePoint Service Applications" -ForegroundColor cyan 
            Write-Host "Total Number of Running SharePoint Service Applications:" $SPSrvApp.count -ForegroundColor Green
            $SPSrvApp 
            Write-Host "--------------------------------------------------------------------"


            ##################################################################################
            #Web Application Report Summary 
            Write-Host "Web Application Report Summary" -ForegroundColor Green
            Write-Host "Total Number of SharePoint Web Application Per Farm:" $SPWebAppcount
            Write-Host "Total Number of SharePoint Application Pool Per Farm:" $SPAppPoolCount
            Write-Host "Total Number of SharePoint Service Application Per Farm:" $SPSrvAppcount
            Write-Host "Check the details at: https://spgeeks.devoworx.com/get-all-web-applications-per-farm/" -ForegroundColor cyan
            Write-Host "Check also the SharePoint Farm Scan Report at https://spgeeks.devoworx.com/sharepoint-farm-scan-report/" -ForegroundColor cyan
            Write-Host "--------------------------------------------------------------------"
		}
		Catch
		{
			Write-Host $_.Exception.Message -ForegroundColor Red
		}
  }

#Run SharePoint Web APplication Scan Report
SPWebAppScanReport