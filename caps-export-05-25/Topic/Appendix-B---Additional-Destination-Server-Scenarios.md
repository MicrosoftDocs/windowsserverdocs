---
title: Appendix B - Additional Destination Server Scenarios
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5337b6e7-e2a1-4c2e-b6f4-27f2d224c299
author: vhorne
---
# Appendix B - Additional Destination Server Scenarios
  
## <a name="BKMK_AppendixB"></a>  
In some instances, your destination server may require additional preparation before you migrate to it.  
  
### If your server hosts Line Printer Remote \(LPR\) printers  
To enable the hosting of LPR printers, install the LPR Port Monitor feature on the server:  
  
1.  Open Server Manager.  
  
2.  In the **Server Manager** dashboard, click **Add roles and features**. The **Add Roles and Features Wizard** opens.  
  
3.  Click **Next** on the **Before you begin** page.  
  
4.  Ensure **Role\-based or feature\-based installation** is select on the **Select installation type** page, and click **Next**.  
  
5.  Ensure your destination server is selected on the **Select destination server** page and click **Next**.  
  
6.  On the **Select server roles** page, click **Next**.  
  
7.  On the **Select Features** page, click **LPR Port Monitor**, click **Next**, and then follow the instructions to complete the installation.  
  
> [!IMPORTANT]  
> The LPD and LPR Services are deprecated starting with [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. Eventually, they will be completely removed from the product, but they are still available in this release. You should begin planning now to employ alternate methods for any applications, code, or usage that depend on these features. For more information about features or functionalities that have either been removed from the product in the current release or are planned for potential removal in subsequent releases, see [Features Removed or Deprecated in Windows Server 2012](../Topic/Features-Removed-or-Deprecated-in-Windows-Server-2012.md).  
  
### If your server offers Internet Printing Protocol \(IPP\) printer connections  
To enable the Internet Printing Protocol \(IPP\):  
  
-   When installing the Print and Document Services role, select **Internet Printing**.  
  
This automatically configures IIS and any other necessary features to support IPP printer hosting.  
  
### If your server hosts Web Services on Devices \(WSD\) printers  
To enable WSD printing support:  
  
1.  Start the **Network and Sharing Center** from Control Panel and, click **Change advanced sharing settings** and click **Turn on network discovery**.  
  
2.  In Computer Management, Services, start the **Function Discovery Provider Host** service.  
  
3.  In Computer Management, Services, ensure the **Device Association Service** is started.  
  
The server will be then able to identify and communicate with WSD\-enabled printers.  
  
### If your print server is a highly available virtual machine  
  
-   To create a highly available print environment using Hyper\-V and Failover Clustering, see [High availability printing overview](assetId:///a5321958-4647-4511-acb2-1e03aa21fd20). For more information about [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Failover Clustering, see [What's New in Failover Clustering in Windows Server 2012 \[redirected\]](assetId:///187d6191-4f92-4f98-9cae-c5e6d5b74e76) and [Clustering and High\-Availability](http://blogs.msdn.com/b/clustering/archive/2012/04/18/10295158.aspx).  
  
-   Continue with the restoration process on the Printer Server virtual machine on the primary node.  
  
### If your server hosts local bus printers \(LPT and USB\)  
The migration of local bus printers \(LPT and USB\) is not supported, although these printers are shown during backup. After the migration is complete:  
  
1.  Share the local bus printers again on the destination server.  
  
2.  Verify that each printer’s name has not changed.  
  
3.  Test the printers to ensure that the shared connections still work.  
  
### If your server hosts plug and play printers  
The migration of plug\-and\-play printers is not supported. To migrate plug and play printers:  
  
1.  Plug the printer into the destination server. The plug\-and\-play printer drivers will be installed automatically.  
  
2.  Enable printer sharing for the print queues.  
  
## See Also  
[Migrate Print and Document Services to Windows Server 2012](../Topic/Migrate-Print-and-Document-Services-to-Windows-Server-2012.md)  
[Preparing to Migrate](../Topic/Preparing-to-Migrate.md)  
[Migrating the Print and Document Services Role](../Topic/Migrating-the-Print-and-Document-Services-Role.md)  
[Verifying the Migration](../Topic/Verifying-the-Migration.md)  
[Post-Migration Tasks_1](../Topic/Post-Migration-Tasks_1.md)  
[Appendix A - Printbrm.exe Command-Line Tool Details](../Topic/Appendix-A---Printbrm.exe-Command-Line-Tool-Details.md)  
[Appendix C - Printbrm Event IDs](../Topic/Appendix-C---Printbrm-Event-IDs.md)  
  
