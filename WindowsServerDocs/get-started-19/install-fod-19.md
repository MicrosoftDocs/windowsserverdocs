---
title: Server Core App Compatibility feature on demand
description: "How to install Windows Server Features on Demand"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 99f7daa4-30ce-4d13-be65-0a4d55cca754
author: coreyp-at-msft
ms.author: coreyp
manager: jasgroce
ms.localizationpriority: medium
---

# Server Core App Compatibility feature on demand

> Applies to Windows Server 2019

For more information on Features on Demand (FOD), see [Features On
Demand](https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/features-on-demand-v2--capabilities).

## App Compatibility Feature on Demand

App Compatibility, a Feature on Demand for Server Core, significantly improves the app compatibility of the Windows Server Core installation option by including a subset of binaries and packages from Windows Server with Desktop, without adding the Windows Server Desktop Experience graphical environment. This optional package is available on a separate ISO and can be added to Windows Server Core installations and images only.

The two primary values the App Compatibility FOD provides are:

1.  Increases the compatibility of Server Core for server applications that are already in market or have already been developed by organizations and deployed.

2.  Assists with providing OS components and increased app compatibility of software tools used in acute troubleshooting and debugging scenarios.

Operating system components that are available as part of the Server Core App Compatibility FOD include:

-   Microsoft Management Console (mmc.exe)

-   Event Viewer (Eventvwr.msc)

-   Performance Monitor (PerfMon.exe)

-   Resource Monitor (Resmon.exe)

-   Device Manager (Devmgmt.msc)

-   File Explorer (Explorer.exe)

-   Windows PowerShell (Powershell_ISE.exe)

-   Failover Cluster Manager (CluAdmin.msc)

    -   Requires addition of the Failover Clustering Windows Server feature first.

        -   Use Powershell Cmdlet to add, `Install-WindowsFeature -NameFailover-Clustering -IncludeManagementTools`

        -   To run Failover Cluster Manager, enter **cluadmin** at the command prompt.

### To add the Server Core App Compatibility feature on demand (FOD) to a running instance of Server Core

 >[!NOTE]  
   > Do not attempt to add the Server Core App Compatibility FOD to a Windows Server installation of Windows Server with Desktop Experience.

 >[!NOTE] 
   > This procedure uses Deployment Image Servicing and Management (DISM.exe), a command-line tool. For more information about DISM commands, see [DISM Capabilities Package Servicing Command-Line Options](https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/dism-capabilities-package-servicing-command-line-options).

1. Download the Server FOD optional packages ISO, and copy the ISO to a shared folder on your local network.

 - Where to get the Server FOD ISO

2. Sign in as Administrator on the Server Core computer that is connected to your local network and that you want to add the FOD to.

3. Use **net use**, or some other method, to connect to the location of the FOD ISO.

4. Copy the FOD ISO to a local folder of your choosing.

5. Start PowerShell by entering **powershell.exe** at a command prompt.

6. Mount the FoD ISO by using the following command:

        Mount-DiskImage -ImagePath drive_letter:\folder_where_ISO_is_saved\ISO_filename.iso

7. Type **exit** to exit PowerShell.

8.  Run the following command:

        DISM /Online /Add-Capability /CapabilityName:”ServerCore.AppCompatibility~~~~0.0.1.0” /Source:drive_letter_of_mounted_ISO: /LimitAccess

9.  After the progress bar completes, restart the operating system.

### To optionally add Internet Explorer 11 to Server Core** (after adding the Server Core App Compatibility FOD)

 >[!NOTE]  
   > The Server Core App Compatibility FOD is required for the addition of Internet Explorer 11, but Internet Explorer 11 is not required to add the Server Core App Compatibility FOD.

1.  Sign in as Administrator on the Server Core computer that has the App Compatibility FOD already added and the Server FOD optional package ISO copied locally.

2.  Start PowerShell by entering **powershell.exe** at a command prompt.

3.  Mount the FoD ISO by using the following command:

         Mount-DiskImage -ImagePath drive_letter:\folder_where_ISO_is_saved\ISO_filename.iso

4.  Type **exit** to exit PowerShell.


5.  Run the following command:

        Dism /online /add-package:drive_letter_of_mounted_iso:"Microsoft-Windows-InternetExplorer-Optional-Package~31bf3856ad364e35~amd64~~.cab"

6.  After the progress bar completes, restart the operating system.
