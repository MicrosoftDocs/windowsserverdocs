---
title: Install Microsoft Virtual Machine Converter
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b84c2557-743c-4782-aba8-c97a216473a2
author: cwatsonmsft
---
# Install Microsoft Virtual Machine Converter
  
## Prerequisites  
Before you install Microsoft Virtual Machine Converter \(MVMC\), you must install the following software on the computer on which you want to run MVMC:  
  
-   Windows Server 2012 R2, Windows Server 2012, or Windows Server 2008 R2 with SP1 operating systems  
  
-   Microsoft .NET Framework 3.5 and .NET Framework 4 if you install MVMC on Windows Server 2008 R2 with SP1  
  
-   Microsoft .NET Framework 4.5 if you install MVMC on Windows Server 2012 R2, Windows Server 2012, or Windows 8  
  
    > [!NOTE]  
    > Although MVMC installs on all of these versions, using the Windows PowerShell cmdlets that are released as part of MVMC requires Windows PowerShell Runtime 3.0, as the cmdlets function only on Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2 with SP1, or Windows 8.  
  
-   Visual C\+\+ Redistributable for Visual Studio 2012 Update 1  
  
-   [Windows Management Framework 3.0](http://www.microsoft.com/download/details.aspx?id=34595)  
  
In addition, enable the following features:  
  
-   Background Intelligent Transfer Service \(BITS\) feature in Windows Server on the destination host for physical machine conversion  
  
-   Hyper\-V on the destination host  
  
## Installation  
  
#### To install MVMC  
  
1.  Download the Microsoft Virtual Machine Converter Windows Installer package to your local server.  
  
2.  Run the Windows Installer package.  
  
3.  Enter a location where you want to install MVMC or use the default location and continue with the installation.  
  
> [!IMPORTANT]  
> The account that runs the Setup program must be the local administrator.  
  
