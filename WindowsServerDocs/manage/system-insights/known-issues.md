---
title: System Insights known issues
description: "System Insights known issues"
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: system-insights
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 
author: gawatu
ms.author: gawatu
manager: mallikarjun.chadalapaka
ms.date: 6/27/2018
---
# System Insights known issues

>Applies To: Windows Server Insider Preview build 17692 and later

This topic describes the known issues in System Insights that impact the latest Insider Preview build.

>[!IMPORTANT]
>Before reporting any bugs, please ensure you're running the latest build. Visit [this page](https://www.microsoft.com/en-us/software-download/windowsinsiderpreviewserver) to get the latest Windows Server 2019 Preview build, and download the latest System Insights extension for Windows Admin Center [using the extension manager](https://docs.microsoft.com/en-us/windows-server/manage/windows-admin-center/configure/using-extensions).

## Known issues

#### In Windows Server Insider Preview build 17744, System Insights sometimes doesn't correctly identify volumes or network adapters.
This issue could cause the following behavior:
- All volumes or network adapters report the same identification information.
- Each volume or network adapter only reports a guid, rather than a friendly name or drive letter.
This will be resolved in an upcoming release.

#### If you upgrade from Windows Server Insider Preview build 17692 to a newer Insider Preview build, System Insights encounters errors when parsing or visualizing the prediction results. 
If you'd like to use In-Place Upgrade and retain your historical usage data, you can run the script below to resolve this issue. You can also clean install the newer build to fix this issue.

```PowerShell
<#
This script stops the Insights service and removes previous System Insights configuration information. 
Once the System Insights service is restarted, it will recreate the database that stores the configuration information, which addresses any issues with In-Place Upgrade from Windows Server Insider Preview build 17692. 
#>
$InsightsDBPath = "$env:ProgramData\Microsoft\Windows\SystemInsights\DB"
Stop-Service -Name Insights

# Update security properties of DB to give Administrator access.
$Acl   = Get-Acl -Path $InsightsDBPath
$Sddl  = $acl.Sddl
$Sddl += '(A;;FA;;;BA)'
$Acl.SetSecurityDescriptorSddlForm($Sddl)
Set-Acl -Path $insightsDBPath -AclObject $Acl

# Remove previous DB files.
Remove-Item -Path $InsightsDBPath\* -Confirm:$false
Start-Service -Name Insights
```

## See also
To learn more about System Insights, use the following resources:

- [System Insights overview](overview.md)
- [Understanding capabilities](understanding-capabilities.md)
- [Managing capabilities](managing-capabilities.md)
- [Adding and developing capabilities](adding-and-developing-capabilities.md)
- [System Insights FAQ](faq.md)
