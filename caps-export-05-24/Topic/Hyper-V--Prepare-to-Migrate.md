---
title: Hyper-V: Prepare to Migrate
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 00959060-30f1-4578-8068-89d4d58f137c
author: cwatsonmsft
---
# Hyper-V: Prepare to Migrate
Follow these steps to prepare for migration.  
  
## Select and prepare your destination server  
To select and prepare the destination server for migration, perform the steps in the order they are given.  
  
### Hardware requirements for the destination server  
The computer you select as the destination server must meet the following hardware requirements:  
  
-   **Storage**. The destination server requires enough storage to hold the virtual hard disks from the source server.  
  
-   **Network**. The destination server requires at least as many physical network adapters as the number of physical network adapters in use as external virtual networks on the source server. To determine this, open Hyper\-V Manager on the source server, and then open Virtual Network Manager. Under **Virtual Networks** \(in the left pane\) note the number of the networks designated as “External”.  
  
-   **Memory**. The destination server requires enough memory to run all the virtual machines you plan to run at the same time, as well as run the Hyper\-V role. For example, if you run all the virtual machines configured on the source server at the same time, the destination server must have at least as much memory as the sum of memory configured for all virtual machines, plus memory to run the Hyper\-V role in [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)].  
  
-   **Processor**. The destination server requires at least as many logical processors as the largest number of processors configured on a virtual machine on the source server. Note that if you want to migrate virtual machines with saved states, the processor on the destination server must be compatible with the processor on the source server. The processors must be from the same manufacturer and have compatible steppings.  
  
### Software requirements for the destination server  
After you select the destination server, prepare the software by doing the following:  
  
> [!IMPORTANT]  
> If you install Windows Server Migration Tools before you install the Hyper\-V role, you must remove the tools and then install the Hyper\-V role before you install the tools. For removal instructions, see [Install, Use, and Remove Windows Server Migration Tools](../Topic/Install,-Use,-and-Remove-Windows-Server-Migration-Tools.md).  
  
1.  Install [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. For more information, see [Installing Windows Server 2012](../Topic/Installing-Windows-Server-2012.md).  
  
2.  Add the Hyper\-V role. For instructions, see [Install the Hyper\-V role and configure a virtual machine](assetId:///243b5705-96c9-4ec7-9ec5-c68a22b0d42d).  
  
## Back up your source server  
Before you start migration, back up the source server. If the migration fails, you can use this backup to restore the source server. For information about the different types of backups, see [Planning for Backup](http://go.microsoft.com/fwlink/?LinkId=178128) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=178128\).  
  
## Install migration tools  
[!INCLUDE[wsmt](../Token/wsmt_md.md)] in [!INCLUDE[firstref_server_7](../Token/firstref_server_7_md.md)] allows an administrator to migrate some server roles, features, operating system settings, shares, and other data from computers that are running certain editions of Windows Server 2003, [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] to computers that are running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
Complete installation, configuration, and removal instructions for [!INCLUDE[wsmt](../Token/wsmt_md.md)] are available on the World Wide Web, in [Install, Use, and Remove Windows Server Migration Tools](../Topic/Install,-Use,-and-Remove-Windows-Server-Migration-Tools.md). [!INCLUDE[wsmt](../Token/wsmt_md.md)] must be installed on both the destination server and the source server, in that order.  
  
Migration documentation and tools ease the process of migrating server role settings and data from an existing server that is running Windows Server 2003 and later releases of the Windows operating system to another computer. By using these tools to migrate roles, you can simplify migration, reduce migration time, increase accuracy of the migration process, and help eliminate conflicts that could otherwise occur during the migration process.  
  
[!INCLUDE[wsmt](../Token/wsmt_md.md)] is a set of [!INCLUDE[wps_1](../Token/wps_1_md.md)] cmdlets. For more information about [!INCLUDE[wps_2](../Token/wps_2_md.md)] and working with cmdlets, see [Windows PowerShell Core](http://go.microsoft.com/fwlink/?LinkID=244829) on Microsoft TechNet.  
  
## <a name="BKMK_collectconfig"></a>Collect configuration details from your source server  
Collect the following configuration details about the source server. You will use this information as part of the verification process after you perform the migration.  
  
-   Gather identifying information about the set of virtual machines on the source server. If there is a relatively small number of virtual machines on the server \(for example, less than 20\), you could take a screenshot of the list of virtual machines displayed in the Hyper\-V Manager snap\-in. Additionally, record the following configuration information for each virtual machine:  
  
    -   Amount of memory  
  
    -   Number of virtual processors  
  
    -   Virtual hard disks \(.vhd files\) connected to the virtual machine  
  
-   For each virtual machine that has snapshots, gather information about the number of snapshots and the structure of the snapshot tree.  
  
-   Record information about the external virtual networks. Include information such as the name of each external virtual network. If you plan to migrate the IP settings of the physical network adapters \(for example, if the network adapters use static IP addresses that you want to retain\), save the IP configuration settings by using the following command:  
  
    ```  
    IPConfig /all > IPSettings.txt  
    ```  
  
-   If you have made any customizations to the Hyper\-V security policy, gather all the information about scopes and roles from Authorization Manager \(see [Using Authorization Manager for Hyper\-V Security](http://go.microsoft.com/fwlink/?LinkId=183469) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=183469\)\).  
  
-   If you have turned off any exceptions in Windows Firewall, record that information.  
  
-   If you have granted remote access to the server for Hyper\-V management to any user account that is not a member of the Administrators group, record that information. The Hyper\-V Remote Management Configuration Utility is a tool is that you can use for this task. However, this tool is not published or supported by Microsoft. For more information, see [Hyper\-V Remote Management Configuration Utility](http://go.microsoft.com/fwlink/?LinkId=178138) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=178138\).  
  
-   If you have granted remote access to the server for Hyper\-V management to any user account that is not a member of the Administrators group or Distributed COM Users group, open the registry and navigate to the HKLM\\Software\\Microsoft\\OLE\\ key. Find the MachineLaunchRestriction value and record all the information about that value.  
  
    > [!CAUTION]  
    > Incorrectly editing the registry may severely damage your system. Before making changes to the registry, you should back up any valued data on the computer.  
  
## Prepare other computers in the enterprise  
  
> [!IMPORTANT]  
> Before you run the **Import\-SmigServerSetting**, **Export\-SmigServerSetting**, or **Get\-SmigServerFeature** cmdlets, verify that during migration, both source and destination servers can contact the domain controller that is associated with domain users or groups who are members of local groups on the source server.  
>   
> Before you run the **Send\-SmigServerData** or **Receive\-SmigServerData** cmdlets, verify that during migration, both source and destination servers can contact the domain controller that is associated with those domain users who have rights to files or shares that are being migrated.  
  
Depending on the workloads that you have deployed in your virtual machines, you need to take the necessary actions to ensure that the users and clients that obtain services from the virtual machines are not negatively impacted during the migration. In other words, you could either have a planned downtime or redirect the clients and users to alternate, redundant virtual machines while the migration is in progress. The specific actions you take depend on the best practices you have in place for the workloads deployed in the virtual machines.  
  
## Additional references  
  
1.  [Migrate Hyper-V to Windows Server 2012 from Windows 2008 R2](../Topic/Migrate-Hyper-V-to-Windows-Server-2012-from-Windows-2008-R2.md)  
  
2.  [Hyper\-V: Migrate the Hyper\-V Role](assetId:///fa4f4b48-ecbb-4c0d-8ef1-34da57c81ce6)  
  
3.  [Hyper-V: Verify the Migration](../Topic/Hyper-V--Verify-the-Migration.md)  
  
4.  [Hyper\-V: Post\-migration Tasks](assetId:///dfea5e27-6361-4fb1-8217-8197ae2284b0)  
  
5.  [Hyper\-V Overview](assetId:///5aad349f-ef06-464a-b36f-366fbb040143)  
  
6.  [Hyper\-V Migration Guide](http://technet.microsoft.com/library/ee849855(v=ws.10)) \(for migration of Hyper\-V running in Windows Server 2008 to Windows Server 2008 R2.\)  
  
7.  [Windows Server Migration Portal](http://go.microsoft.com/fwlink/?LinkId=247608)  
  
