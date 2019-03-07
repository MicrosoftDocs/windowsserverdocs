---
title: Server Core App Compatibility Feature on Demand (FOD)
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

# Server Core App Compatibility Feature on Demand (FOD)

> Applies to Windows Server 2019 and Windows Server, version 1809

The **Server Core App Compatibility Feature on Demand** is an optional feature package that can be added to Windows Server 2019 Server Core installations, or Windows Server, version 1809, at any time.

For more information on Features on Demand (FOD), see [Features On
Demand](https://docs.microsoft.com/windows-hardware/manufacture/desktop/features-on-demand-v2--capabilities).


## Why install the App Compatibility FOD? 

App Compatibility, a Feature on Demand for Server Core, significantly improves the app compatibility of the Windows Server Core installation option by including a subset of binaries and packages from Windows Server with Desktop Experience, without adding the Windows Server Desktop Experience graphical environment. This optional package is available on a separate ISO, or from Windows Update, but can only be added to Windows Server Core installations and images.

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

-   Disk Management (Diskmgmt.msc)

-   Failover Cluster Manager (CluAdmin.msc)

    -   Requires addition of the Failover Clustering Windows Server feature first.

        -   Use Powershell Cmdlet to add, `Install-WindowsFeature -NameFailover-Clustering -IncludeManagementTools`

        -   To run Failover Cluster Manager, enter **cluadmin** at the command prompt.

## Installing the App Compatibility FOD

 >[!IMPORTANT] 
   >The App Compatibility FOD can only be installed on Server Core. Do not attempt to add the Server Core App Compatibility FOD to a Windows Server installation of Windows Server with Desktop Experience.

### To add the Server Core App Compatibility feature on demand (FOD) to a running instance of Server Core

 >[!NOTE] 
   > This procedure uses Deployment Image Servicing and Management (DISM.exe), a command-line tool. For more information about DISM commands, see [DISM Capabilities Package Servicing Command-Line Options](https://docs.microsoft.com/windows-hardware/manufacture/desktop/dism-capabilities-package-servicing-command-line-options).

>[!NOTE] 
   > The same FOD optional packages ISO can be used for either Windows Server 2019 Server Core installations, or Windows Server, version 1809, installations.

>[!NOTE] 
   > If your computer or virtual machine that is running Server Core is able to connect to Windows Update, steps 1 - 7 below can be skipped. But be sure to leave off /Source and /LimitAccess from the DISM command in step 8.

1. Download the Server FOD optional packages ISO, and copy the ISO to a shared folder on your local network:

 - If you have a volume license you can download the Server FOD ISO image file from the same portal where the OS ISO image file is obtained: [Volume Licensing Service Center](https://www.microsoft.com/Licensing/servicecenter/default.aspx).
 - The Server FOD ISO image file is also available on the [Microsoft Evaluation Center](https://www.microsoft.com/evalcenter/evaluate-windows-server-2019) or on the [Visual Studio portal](https://visualstudio.microsoft.com) for subscribers.


2. Sign in as Administrator on the Server Core computer that is connected to your local network and that you want to add the FOD to.

3. Use **net use**, or some other method, to connect to the location of the FOD ISO.

4. Copy the FOD ISO to a local folder of your choosing.

5. Start PowerShell by entering **powershell.exe** at a command prompt.

6. Mount the FoD ISO by using the following command:

        Mount-DiskImage -ImagePath drive_letter:\folder_where_ISO_is_saved\ISO_filename.iso

7. Type **exit** to exit PowerShell.

8.  Run the following command:

        DISM /Online /Add-Capability /CapabilityName:"ServerCore.AppCompatibility~~~~0.0.1.0" /Source:drive_letter_of_mounted_ISO: /LimitAccess

9.  After the progress bar completes, restart the operating system.

### To optionally add Internet Explorer 11 to Server Core (after adding the Server Core App Compatibility FOD)

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

 
#### Release notes and suggestions for the Server Core App Compatibility FOD and Internet Explorer 11 optional package

- **Important:** please read the Windows Server 2019 release notes for any issues, considerations, or guidance before proceeding with installation and use of the Server Core App Compatibility FOD and Internet Explorer 11 optional package.
 
 >[!NOTE] 
   > It's possible to encounter flickering with the Server Core console experience when adding the App Compatibility FOD after using Windows Update to install cumulative updates.  This issue is resolved with December, 2018 updates.  For more info and resolution steps, see [Knowledge Base article 4481610: Screen flickers after you install Server Core App Compatibility FOD in Windows Server 2019 Server Core](https://support.microsoft.com/help/4481610/screen-flickers-after-fod-installation-windows2019-server-core).

- After installation of the App Compatibility FOD and reboot of the server, the command console window frame color will change to a different shade of blue.

- If you choose to also install the Internet Explorer 11 optional package, note that double clicking to open locally saved .htm files is not supported. However, you can **right-click** and choose **Open with IE**, or you can open it directly from Internet Explorer **File** -> **Open**. 

- To further enhance the app compatibility of Server Core with the App Compatibility FOD, the IIS Management Console has been added to Server Core as an optional component.  However, it is absolutely necessary to first add the App Compatibility FOD to use the IIS Management Console. IIS Management Console relies on the Microsoft Management Console (mmc.exe), which is only available on Server Core with the addition of the App Compatibility FOD.  Use Powershell [**Install-WindowsFeature**](https://docs.microsoft.com/powershell/module/microsoft.windows.servermanager.migration/install-windowsfeature?view=win10-ps) to add IIS Management Console.

- As a general point of guidance, when installing apps on Server Core (with or without these optional packages) it is sometimes necessary to use silent install options and instructions. 
    
 - As an example, SQL Server Management Studio for SQL Server 2016 and SQL Server 2017 can be installed on Server Core and is fully functional when the App Compatibility FOD is present.  See, [Install SQL Server from the Command Prompt](https://docs.microsoft.com/sql/database-engine/install-windows/install-sql-server-from-the-command-prompt?view=sql-server-2017).
 - If SQL Server Management Studio is not desired, then it is unnecessary to install the Server Core App Compatibility FOD.  See, [Install SQL Server on Server Core](https://docs.microsoft.com/sql/database-engine/install-windows/install-sql-server-on-server-core?view=sql-server-2017).

