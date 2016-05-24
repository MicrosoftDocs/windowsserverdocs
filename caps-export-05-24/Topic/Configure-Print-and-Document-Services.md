---
title: Configure Print and Document Services
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1a5bc597-a8d6-42e5-8956-1c9f420ab3d3
author: vhorne
---
# Configure Print and Document Services
This article describes how to configure and manage Print and Document Services using both the Print Management Console and the associated Windows PowerShell cmdlets. Management of a [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Print Server is done using the Print Management Console \(PMC\) MMC snap\-in, which has been updated to support the new [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] features. You can remotely manage your print server, but you need to first configure it from the Print Server’s local console.  
  
Internet Printing is also managed using the PMC, and LPD Printing uses Windows PowerShell tools for configuration and remains unchanged functionally from [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
> [!IMPORTANT]  
> The LPD and LPR Services are deprecated starting with [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. Eventually, they will be completely removed from the product, but they are still available in this release. You should begin planning now to employ alternate methods for any applications, code, or usage that depend on these features. For more information about features or functionalities that have either been removed from the product in the current release or are planned for potential removal in subsequent releases, see [Features Removed or Deprecated in Windows Server 2012](../Topic/Features-Removed-or-Deprecated-in-Windows-Server-2012.md).  
  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] introduces a new set of Windows PowerShell cmdlets that can be used to manage print servers and print queues from the command line. Wherever possible, examples on how to use these cmdlets will be shown for common print management scenarios. For more information, see [Print Management Windows PowerShell cmdlets](http://technet.microsoft.com/library/hh918357.aspx).  
  
**In this document**  
  
-   [Step 1: Install v4 drivers](#BKMK_Step1)  
  
-   [Step 2: Install v3 drivers \(if necessary\)](#BKMK_Step2)  
  
-   [Step 3: Create a shared print queue](#BKMK_Step3)  
  
-   [Step 4: Connect to the print queue](#BKMK_Step4)  
  
-   [Step 5: Print from Windows](#BKMK_Step5)  
  
-   [Step 6: Print from a Windows app](#BKMK_Step6)  
  
> [!NOTE]  
> [!INCLUDE[wps_howtorun](../Token/wps_howtorun_md.md)]  
  
## <a name="BKMK_Step1"></a>Step 1:  Install v4 drivers  
Using v4 drivers with [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Print Servers is recommended wherever possible. If [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] client computers are being used, users and IT administrators will receive the new printing experience and receive all of the benefits of the v4 driver model. For some devices, using a v3 driver will be necessary and differences between [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and previous versions of Windows will also be discussed.  
  
[Do this step using Windows PowerShell](#BKMK_PSstep1)  
  
#### To install v4 drivers using the Print Management Console  
  
1.  Open the Print Management Console by opening Server Manager, click **Tools**, and then click **Print Management**.  
  
2.  Expand **Print Servers**, and then expand the Print Server name. Right click **Drivers** and select **Add Drivers**.  
  
3.  To add a v4 driver for a device, select the driver that has v4 or Class Driver in the name.  
  
4.  After the driver is installed, it should display in the list of installed drivers.  
  
    ![](../Image/PFS-Config-Fig1.gif)  
  
    Once installed, V4 drivers are identified by the Version field displayed in the Driver Properties:  
  
    ![](../Image/PFS-Config-Fig2.gif)  
  
The driver name will state **Class Driver**, the **Config File** should show **PrintConfig.dll**, and the driver path should be `%systemroot%\system32\DriverStore`.  
  
**Class Drivers**  
  
V4 drivers that ship with [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] are known as Class Drivers. Drivers of this type should always display **Class Driver** in the name.  
  
**Model Specific Drivers**  
  
V4 drivers that are downloaded directly from a printer manufacturer website or downloaded from Windows Update are known as model specific drivers.  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]  
  
```  
Add-PrinterDriver -Name "HP Color LaserJet 5550 PS Class Driver”  
```  
  
## <a name="BKMK_Step2"></a>Step 2: Install v3 drivers \(if necessary\)  
In many cases it will be necessary to use v3 drivers on a [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Print Server. In these cases, these drivers will install and share exactly as they did before in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. To make installation and maintenance of these drivers easier than they were in previous operating systems, the 32\-bit core driver files and the ntprint.inf driver definition file from 32\-bit Windows are included with [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. If a 32\-bit driver has a dependency on a core driver, an administrator can install a 32\-bit v3 driver without needing to use an installed 32\-bit operating system as a source for the ntprint.inf file.  
  
## <a name="BKMK_Step3"></a>Step 3: Create a shared print queue  
Creating shared print queues in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] follows the same process as [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. A local printer must be installed on the server and connected to a port and a driver, and the print queue must be shared in order for client computers to discover and connect to it. When using a v4 driver, an administrator does not need to install a driver for any additional processor architectures.  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
```  
Add-printer -Name "HP Color LaserJet 4700" -DriverName "HP Color LaserJet 5550 PS Class Driver" -shared -ShareName "HP Color LaserJet 4700" -PortName "192.168.100.100"  
```  
  
> [!IMPORTANT]  
> The Port and Driver must already exist or the Add\-Printer command will fail. Use the `Add-PrinterDriver` and `Add-PrinterPort` cmdlets to install the driver and the port before running the `Add-Printer` command.  
  
## <a name="BKMK_Step4"></a>Step 4: Connect to the print queue  
When connecting to a print queue using a v4 driver from a client computer, the client computer will install the print queue using the enhanced Point and Print process described previously. If the client computer is [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], the driver will be downloaded from either from the local driver store, Windows Update, or Windows Software Update Services \(WSUS\).  
  
**[!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] and v4 drivers**  
  
The user will not be prompted to provide credentials to install the v4 print driver. The v4 driver installs from the local driver store and the user will see a printer installation indicator with a status bar. After the installation completes, the printer is ready to use with no further action needed.  
  
**Microsoft Enhanced Point and Print Compatibility Driver**  
  
A client running a previous version of Windows can install and print to a [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] print queue that is using a v4 driver by using the Microsoft enhanced Point and Print Compatibility Driver. Windows 7 clients do not support the v4 driver model so they need to download and install the Microsoft enhanced Point and Print Compatibility Driver from the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Print Server. [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] comes with both a 64\-bit and 32\-bit compatibility driver pre\-installed.  
  
After the printer is installed, its properties will show the driver as the Microsoft enhanced Point and Print compatibility driver instead of the v4 Class Driver or Model Specific driver that is installed on the server.  
  
![](../Image/PFS-Config-Fig3.gif)  
  
The Microsoft enhanced Point and Print Compatibility Driver works cross\-platform as well, as a 32\-bit Windows 7 client downloads and installs the 32\-bit version of the driver from the server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and uses this driver to print to all v4 print queues.  
  
## <a name="BKMK_Step5"></a>Step 5: Print from Windows  
The [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] Shell includes a new user interface that is designed to help users easily discover and install devices. Print, Fax, and Scan devices are installed from the Settings or Devices charms:  
  
![](../Image/PFS-Config-Fig4.gif)  
  
#### To install a Printer using the [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] Shell  
  
1.  Activate the Charms bar by swiping in from the right edge of a touch screen or moving the mouse to the upper or lower right corner of the display.  
  
2.  Click or touch **Settings**, and then **More PC Settings**.  
  
3.  Click or touch **Devices**, and then click or touch **Add a device**.  
  
4.  Windows scans the network for devices and displays a list of printers that were found. If the administrator published printers to the Active Directory then they should show up at the top of the list.  
  
    ![](../Image/PFS-Config-Fig5.gif)  
  
5.  Click or touch the device that you want to install and it will be added to the list of devices. If the printer is using a v4 driver then no other user interaction is necessary to install the device.  
  
> [!NOTE]  
> In some cases you may need to add a printer through the Control Panel, Devices and Printers, Add Printer user interface. This works the same way as in previous Windows versions.  
  
> [!IMPORTANT]  
> When printing to a [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] print queue, only users with administrator permissions on the print queue \(full system administrator or delegated print administrator, see [Assigning Delegated Print Administrator and Printer Permission Settings in Windows Server 2012](assetId:///24774010-baf2-4877-b9bf-4ac6d79aa105)\) will see readable document names when viewing the print queue.  Users can still view the queue from their client computer and will see their own document name in full, but for other user’s print jobs they will see **Print Document** for the document name.  
>   
> Additionally, in most cases in the event log on the server, the document name will also appear as **Print Document**.  However, in some job failure cases, the document name will be listed in the failure event.  
  
## <a name="BKMK_Step6"></a>Step 6: Print from a Windows app  
[!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] has a new user interface for discovering and printing to print devices on a network. A Windows app that runs in the [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] modern shell may have a custom printing interface that is accessible via the application bar or it may provide a printing link similar to the Internet Explorer app. Additionally, the `CTRL + P` hotkey will activate the new print dialog from any Windows app.  
  
> [!NOTE]  
> Printing from desktop applications remains unchanged and works the same as previous Windows versions.  
  
#### To print a document from a Windows app  
  
1.  Click or tap the Devices charm or use the `CTRL + P` hotkey to activate the Printing interface.  
  
2.  Choose a device to print to by clicking or touching the Print device icon:  
  
    ![](../Image/PFS-Config-Fig6.gif)  
  
3.  A print preview and basic print settings are displayed. The document can be printed using the **Print** button:  
  
    ![](../Image/PFS-Config-Fig7.gif)  
  
4.  Click **More Settings** to activate the advanced print settings dialog where page layout, paper and quality, and output options can be specified:  
  
    ![](../Image/PFS-Config-Fig8.gif)  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Create custom separator pages on Windows Server 2012](assetId:///299f6e98-69de-43f3-b826-f94f16cbede1)  
  
-   [Assigning Delegated Print Administrator and Printer Permission Settings in Windows Server 2012](assetId:///24774010-baf2-4877-b9bf-4ac6d79aa105)  
  
-   [Print and Document Services Overview](assetId:///4371946b-3f98-455f-8423-0a5895f6972f)  
  
-   [Print and Document Services Architecture](assetId:///322779fb-7230-4e71-89c9-eeab1f6c9c30)  
  
-   [Installing Print and Document Services](assetId:///12f5645d-be82-41b1-b058-51e1a6c5dbff)  
  
-   [Print Management Windows PowerShell cmdlets](http://technet.microsoft.com/library/hh918357.aspx)  
  
