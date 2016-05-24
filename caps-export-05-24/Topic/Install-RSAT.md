---
title: Install RSAT
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f2642799-9da2-4118-abcc-d96e2c61c8b7
---
# Install RSAT
[Checklist: Deploy IPAM Client](../Topic/Checklist--Deploy-IPAM-Client.md) > **Install RSAT**  
  
Remote Server Administration Tools \(RSAT\) includes tools for remotely managing multiple Windows Server roles and features. The following specifications apply to RSAT:  
  
-   RSAT for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] must be installed on a computer running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)]. You cannot install RSAT for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] on a computer running [!INCLUDE[firstref_client_7](../Token/firstref_client_7_md.md)] or an earlier operating system.  
  
-   RSAT for [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] must be installed on a computer running [!INCLUDE[winblue_client_1](../Token/winblue_client_1_md.md)]. You cannot install RSAT for [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] on a computer running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] or an earlier operating system.  
  
-   RSAT for [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] can be used to manage computers running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
-   On a computer running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], RSAT is automatically available. You do not need to perform a separate download.  
  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
## Installing RSAT  
To install RSAT on a computer running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] or [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], download the Microsoft Update Standalone Package \(.msu\) from the Microsoft Download Center, and then run the installation package.  
  
## <a name="cli"></a>  
#### To install RSAT on a computer running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)]  
  
1.  Depending on the architecture of your computer, select Windows6.2\-KB2693643\-x64.msu \(for x64 systems\) or Windows6.2\-KB2693643\-x86.msu \(for x86 systems\) from the Microsoft Download Center at [Remote Server Administration Tools for Windows 8](http://go.microsoft.com/fwlink/p/?LinkID=238560) \(http:\/\/go.microsoft.com\/fwlink\/p\/?LinkID\=238560\) by clicking the download button next to the appropriate file.  
  
2.  Double\-click the file and then click **Open** if a security warning is displayed.  
  
3.  In the **Windows Update Standalone Installer** dialog box, click **Yes**.  
  
4.  Read the license terms and then click **I Accept** to continue the installation.  
  
5.  Wait for the installation to complete, and then click **Close**.  
  
6.  Verify that **Server Manager** is displayed on **Start**.  
  
    ![](../Image/IPAM_sm.gif)  
  
> [!IMPORTANT]  
> If the signed\-in user account on the computer changes, Server Manager might not be displayed on **Start**. You can find Server Manager in the list of available **Apps**.  
  
#### To install RSAT on a computer running [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)]  
  
1.  Depending on the architecture of your computer, select Windows8.1\-KB2693643\-x64.msu \(for x64 systems\) or Windows8.1\-KB2693643\-x86.msu \(for x86 systems\) from the Microsoft Download Center at [Remote Server Administration Tools for Windows 8.1](http://go.microsoft.com/fwlink/?LinkId=304145) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=304145\) by clicking the download button next to the appropriate file.  
  
2.  Double\-click the file and then click **Open** if a security warning is displayed.  
  
3.  In the **Windows Update Standalone Installer** dialog box, click **Yes**.  
  
4.  Read the license terms and then click **I Accept** to continue the installation.  
  
5.  Wait for the installation to complete, and then click **Close**.  
  
6.  Verify that **Server Manager** is displayed on **Start**.  
  
> [!IMPORTANT]  
> If the signed\-in user account on the computer changes, Server Manager might not be displayed on **Start**. You can find Server Manager in the list of available **Apps**.  
  
## See Also  
[Install IPAM Server](../Topic/Install-IPAM-Server.md)  
  
