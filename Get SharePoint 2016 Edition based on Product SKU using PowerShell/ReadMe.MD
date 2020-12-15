
![Get SharePoint 2016 Edition based on Product SKU using PowerShell](https://user-images.githubusercontent.com/49816567/102157256-362c0780-3e90-11eb-80a7-565e4d6353d1.png)

# [Get SharePoint 2016 Edition based on Product SKU using PowerShell](https://spgeeks.devoworx.com/get-sharepoint-edition-powershell/)

This script will help you to detect the Installed SharePoint 2016 Edition.

- SharePoint 2016 Trail.
- SharePoint 2016 Standard.
- SharePoint 2016 Enterprise.

It also detects the current farm build number.

> For more details, please check **[How to Get SharePoint Edition PowerShell?](https://spgeeks.devoworx.com/get-sharepoint-edition-powershell/)**

## How to Use?

- Download the attached script file "Detect_the_Installed_Edition_of_SharePoint_2016.ps1"
- Run ISE as Administrator.
- Open the downloaded script file.
- Click Run.

![PowerShell Script to Detect the Installed SharePoint 2016 Edition](https://user-images.githubusercontent.com/49816567/102153853-2d840300-3e89-11eb-989e-c1b23213590d.gif)

## Output

**(Test1)** You have SharePoint 2016, The script will work properly and get the current SharePoint Edition and the farm build number as shown below:

![PowerShell Script to Detect the Installed SharePoint 2016 Edition - EnterPrise (1)](https://user-images.githubusercontent.com/49816567/102157429-886d2880-3e90-11eb-9de9-6ca2e2c5007e.png)

**(Test2)** You don't have SharePoint 2016, The script will inform you "The SharePoint Edition can't be determined" as shown below:

![PowerShell Script to Detect the Installed SharePoint 2016 Edition - Not (1)](https://user-images.githubusercontent.com/49816567/102157424-86a36500-3e90-11eb-857e-70df23971e09.png)

**Note**

- There is no SharePoint Foundation for SharePoint 2016 so that the script will show specifically which SharePoint 2016 (Standard / Enterprise) Edition has been installed. See also [SharePoint 2016 Foundation, What's the alternative?](https://spgeeks.devoworx.com/sharepoint-foundation-2016-whats-the-alternative/)



## Applies To

- SharePoint 2016.


> **Note:** this script has been migrated from my [TechNet Gallery ](https://gallery.technet.microsoft.com/PowerShell-Script-to-52956bf7)

## See Also

- [Detect SharePoint Edition Using PowerShell](https://github.com/melqassas/PSforSharePoint/blob/master/Detect%20SharePoint%20Edition%20using%20PowerShell/)



--------------

**Have a Question, Please ask [deBUG.to](https://deBUG.to) Community** | **[Mohamed El-Qassas](https://devoworx.com)**
