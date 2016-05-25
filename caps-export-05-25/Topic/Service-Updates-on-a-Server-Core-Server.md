---
title: Service Updates on a Server Core Server
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2493e2ed-dfd7-4032-91ad-37bb89792a1b
author: britw
---
# Service Updates on a Server Core Server
This topic discusses the various ways you can keep a Server Core server up to date with updates. You can service updates in the following ways:  
  
-   **Using Windows Update automatically or with WSUS.** By using Windows Update, either automatically or with command\-line tools, or Windows Server Update Services \(WSUS\), you can service servers running a Server Core installation.  
  
-   **Manually.** Even in organizations that do not use Windows update or WSUS, you can apply updates manually.  
  
|Task|Description|  
|--------|---------------|  
|[1.1. Manage updates automatically with Windows Update](../Topic/Service-Updates-on-a-Server-Core-Server.md#BKMK_1.1)|Managing updates automatically with Windows Update|  
|[1.2. Manage updates with WSUS](../Topic/Service-Updates-on-a-Server-Core-Server.md#BKMK_1.2)|Managing updates with Windows Server Update Services|  
|[1.3. Manage updates manually](../Topic/Service-Updates-on-a-Server-Core-Server.md#BKMK_1.3)|Managing updates manually|  
  
> [!NOTE]  
> [!INCLUDE[wps_howtorun](../Token/wps_howtorun_md.md)]  
  
## <a name="BKMK_1.1"></a>1.1. Manage updates automatically with Windows Update  
To verify the current Windows Update setting, at a command prompt, run the following command:  
  
**Cscript scregedit.wsf \/AU \/v**  
  
To enable automatic updates, run the following commands:  
  
**Net stop wsuaserv**  
  
**cscript scregedit.wst \/AU 4**  
  
**net start wsuaserv**  
  
To disable automatic updates, run the following commands:  
  
**Net stop wsuaserv**  
  
**cscript scregedit.wsf \/AU 1**  
  
**net start wsuaserv**  
  
If the server is a member of a domain, you can also configure Windows Update using Group Policy. For more information, see [http:\/\/go.microsoft.com\/fwlink\/?LinkId\=192470](http://go.microsoft.com/fwlink/?LinkId=192470). However, when you use this method, only option 4 \(“Auto download and schedule the install”\) is relevant to Server Core installations because of the lack of a graphical interface. For more control over which updates are installed and when, you can use a script which provides a command\-line equivalent of most of the Windows Update graphical interface. For information about the script, see [http:\/\/go.microsoft.com\/fwlink\/?LinkId\=192471](http://go.microsoft.com/fwlink/?LinkId=192471).  
  
To force Windows Update to immediately detect and install any available updates, run the following command:  
  
**wuauclt \/detectnow**  
  
Depending on the updates that are installed, you might need to restart the computer, although the system will not notify you of this. To determine if the installation process has completed, use Task Manager to verify that the **Wuauclt** or **Trusted Installer** processes are not actively running. You can also use the methods in the “Viewing installed updates” section to check the list of installed updates.  
  
## <a name="BKMK_1.2"></a>1.2. Manage updates with WSUS  
If the Server Core server is a member of a domain, you can configure it to use a WSUS server with Group Policy. For more information, see [http:\/\/go.microsoft.com\/fwlink\/?LinkId\=192472](http://go.microsoft.com/fwlink/?LinkId=192472).  
  
If the server is not a member of a domain, edit the Registry to configure it to use a WSUS server. For more information, see [http:\/\/go.microsoft.com\/fwlink\/?LinkId\=192473](http://go.microsoft.com/fwlink/?LinkId=192473).  
  
Whenever you configure WSUS settings, be sure to select options that are valid for Server Core installations. For example, since there is no graphical interface, there is no way to receive WSUS notifications. For more control over which updates are installed and when, you can use a script which provides a command\-line equivalent of most of the Windows Update graphical interface. For information about the script, see [http:\/\/go.microsoft.com\/fwlink\/?LinkId\=192471](http://go.microsoft.com/fwlink/?LinkId=192471).  
  
## <a name="BKMK_1.3"></a>1.3. Manage updates manually  
To install an update manually, download the update and make it available to the Server Core computer, and then run the following command:  
  
**Wusa <update>.msu \/quiet**  
  
> [!NOTE]  
> Depending on the updates that are installed, you may need to restart the computer, although the system will not notify you of this.  
  
To uninstall an update manually, download the update and make it available to the Server Core computer, and then run the following command:  
  
**Wusa \/uninstall <update>.msu \/quiet**  
  
> [!NOTE]  
> Depending on the updates that are installed, you may need to restart the computer, although the system will not notify you of this.  
  
To view installed updates, run either of these commands:  
  
**systeminfo**  
  
**wmic qfe list**  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Quick Reference for Server Core Tasks](../Topic/Quick-Reference-for-Server-Core-Tasks.md)  
  
-   [Manage a Server Core Server](../Topic/Manage-a-Server-Core-Server.md)  
  
-   [Configure and Manage Server Core Installations](../Topic/Configure-and-Manage-Server-Core-Installations.md)  
  
-   [Windows Server Installation Options](../Topic/Windows-Server-Installation-Options.md)  
  
-   [Evaluation Versions and Upgrade Options for Windows Server 2012](http://go.microsoft.com/fwlink/?LinkId=260917)  
  
