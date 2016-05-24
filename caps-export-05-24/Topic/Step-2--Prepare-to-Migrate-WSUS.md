---
title: Step 2: Prepare to Migrate WSUS
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c4feddde-4b2d-4797-b2ee-75456c4efc05
author: britw
---
# Step 2: Prepare to Migrate WSUS
The second step in the migration of your Windows Server Update Services \(WSUS\) server role involves preparing the destination and source servers. The following checklist describes the steps involved to prepare for your WSUS migration.  
  
|Task|Description|  
|--------|---------------|  
|[2.1. Prepare before you start the migration](../Topic/Step-2--Prepare-to-Migrate-WSUS.md#BKMK_1.1)|Review the recommended guidelines before starting the migration process.|  
|[2.2. Prepare the destination server](../Topic/Step-2--Prepare-to-Migrate-WSUS.md#BKMK_1.2)|Understand the steps that must be completed on the WSUS destination server before the migration.|  
|[2.3. Prepare the source server](../Topic/Step-2--Prepare-to-Migrate-WSUS.md#BKMK_1.3.)|Understand the steps that must be completed on the WSUS source server before the migration.|  
  
## <a name="BKMK_1.1"></a>2.1. Prepare before you start the migration  
This migration procedure assumes a working knowledge of deployment basics for Windows Server Update Services \(WSUS\) 3.0 SP2. For more information about WSUS deployment, see [Deploying WSUS in the Organization](assetId:///5ad27d64-0749-4b84-a8c1-21ffe5bccd3f). We recommend that you make the following decisions and preparations before you start the migration process:  
  
> [!WARNING]  
> Upgrade from any version of Windows Server that supports WSUS 3.2 to [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)] requires that you first uninstall WSUS 3.2.  
>   
> In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], upgrading from any version of Windows Server with WSUS 3.2 installed is blocked during the installation process if WSUS 3.2 is detected, and you are prompted to first uninstall Windows Server Update Services prior to upgrading [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
>   
> However, because of changes in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], when upgrading from any version of Windows Server and WSUS 3.2 to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], the installation is not blocked. Failure to uninstall WSUS 3.2 prior to performing a [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] upgrade will cause the post installation tasks for WSUS in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] to fail. In this case, the only known corrective measure is to format the hard drive and reinstall [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
-   Configure a location to store updates on the source server. Changing the content storage configuration as part of the migration process is not supported. You can store updates on the local WSUS server or on Microsoft Update. If you want the destination server to store updates in a different location than the source server, the new location must be configured on the source server before migration.  
  
-   Confirm that the destination server meets the minimum WSUS hardware requirements and database requirements. For more information about those requirements see [Deploying WSUS in the Organization](assetId:///5ad27d64-0749-4b84-a8c1-21ffe5bccd3f) on Microsoft TechNet.  
  
## <a name="BKMK_1.2"></a>2.2. Prepare the destination server  
Before migrating WSUS, set up a new [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] in your organization as the WSUS destination server and install WSUS server role on the destination server. After you have successfully installed the WSUS server role, the Configuration Wizard starts automatically. Close the Configuration Wizard. Do not try to sync the updates at this point, because you will copy the update binary files later in the migration process. The WSUS installation procedure assumes that updates for the new server come from Windows Update.  
  
After this is complete, follow these guidelines:  
  
-   If you have decided to use the full installation of SQL Server as the WSUS database, install SQL Server 2008 R2 Standard or SQL Server 2008 R2 Enterprise.  
  
-   Download a graphical tool to manage your database on the destination server from [Microsoft SQL Server Management Studio Express](http://go.microsoft.com/fwlink/?LinkId=161326) or [Microsoft SQL Server 2008 R2 Management Studio Express](http://go.microsoft.com/fwlink/?LinkID=164279).  
  
-   Open TCP port 7000 and make sure that it is not being used by other applications. This port is used by Send\-SmigServerData and Receive\-SmigServerData to perform the data transfer.  
  
-   If the destination server is not joined to the source server’s domain, visually verify that the time, date, and time zone on the destination server are synchronized with the source server. Use the Windows Control Panel to update the date and time if it is necessary.  
  
> [!IMPORTANT]  
> For more information about minimum system requirements and hardware capacity requirements for the WSUS server, see the [Deploying WSUS in the Organization](assetId:///5ad27d64-0749-4b84-a8c1-21ffe5bccd3f).  
  
## <a name="BKMK_1.3."></a>2.3. Prepare the source server  
Review and take action based on the following guidelines:  
  
-   Refer to [Appendix A: Migration Data Collection Worksheet](http://technet.microsoft.com/library/ee822828(WS.10).aspx) to collect data about the source server.  
  
-   Open TCP port 7000 and make sure that it is not being used by other applications. This port is used by Send\-SmigServerData and Receive\-SmigServerData to perform the data transfer.  
  
-   If you have changed the default behavior of Windows Firewall \(or another firewall program\) to block outgoing traffic on computers that are running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], you must enable outgoing traffic on UDP port 7000.  
  
-   Download a graphical tool for managing your database on the source server at [Microsoft SQL Server Management Studio Express](http://go.microsoft.com/fwlink/?LinkId=161326).  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Step 3: Migrate WSUS](../Topic/Step-3--Migrate-WSUS.md)  
  
-   [Step 1: Plan for WSUS Migration](../Topic/Step-1--Plan-for-WSUS-Migration.md)  
  
-   [WSUS server role description](assetId:///77f5db8a-4b8f-4bd5-8493-387310adf46e#BKMK_OVER)  
  
