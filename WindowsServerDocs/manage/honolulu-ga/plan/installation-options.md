---
title: What type of installation is right for you
description: What type of installation is right for you Windows Admin Center (Project Honolulu)
ms.technology: manage
ms.topic: article
author: nwashburn-ms
ms.author: niwashbu
ms.date: 04/05/2018
ms.localizationpriority: low
ms.prod: windows-server-threshold
---

# What type of installation is right for you?

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

## Supported operating systems

You can *install* Windows Admin Center on the following Windows operating systems:

| **Version** | **Installation Mode** |
|-------------|-----------------------|
|Windows 10   | Desktop mode |
|Windows Server, version 1709 | Gateway mode |
|Windows Server 2016 | Gateway mode |

**Desktop Mode:** Connect to the Windows Admin Center gateway from the same computer on which it's installed (i.e. `http://localhost:[port]`)

**Gateway Mode:** Connect to the Windows Admin Center gateway from a client browser on a different machine (i.e. `https://servername`)

You can use Windows Admin Center to *manage* the following Windows operating systems:

| **Version** | **Managed node** via Server Manager | **Managed cluster** via Failover Cluster Mgr | **Managed HCI cluster** via HC Cluster Mgr (early preview)|
|-------------------------|---------------|-----|------------------------|
| Windows Server, version 1709| Yes | Yes | Yes, on Insider builds |
| Windows Server 2016     | Yes | Yes | Future                 |
| Windows Server 2012 R2  | Yes           | Yes | N/A                    |
| Windows Server 2012     | Yes            | Yes | N/A                    |
> [!NOTE]
> Windows Admin Center requires PowerShell features that are not included in Windows Server 2012 and 2012 R2. If you will manage Windows Server 2012 or 2012 R2 with Windows Admin Center, you will need to install Windows Management Framework (WMF) version 5.0 or higher on those servers.

>Type `$PSVersiontable` in PowerShell to verify that WMF is installed,
and that the version is 5.0 or higher. 

>If it is not installed, you can [download WMF 5.1](https://www.microsoft.com/en-us/download/details.aspx?id=54616).

## Deployment options

![](../../media/honolulu/spacer1.png)![](../../media/honolulu/deployment.png)
