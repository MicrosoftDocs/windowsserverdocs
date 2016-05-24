---
title: Migrate Hyper-V to Windows Server 2012 R2 from Windows Server 2008 R2
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 01b1bd74-4147-4b4f-b10d-bc8b4f910f0f
author: cwatsonmsft
---
# Migrate Hyper-V to Windows Server 2012 R2 from Windows Server 2008 R2
With Hyper\-V, you can create a virtualized server computing environment by using a technology that is part of Windows. This guide provides information and instructions about migrating the Hyper\-V role that include virtual machines, data, and operating system settings from the source server running Hyper\-V in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] to the destination server that is running the [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] operating system.  
  
|||  
|-|-|  
|![](b93f8edc-baa1-46ad-aed5-99c8690273c0)|Did you know that Microsoft Azure provides similar functionality in the cloud? Learn more about [Microsoft Azure virtualization solutions](http://aka.ms/f9bh7g).<br /><br />Create a hybrid virtualization solution in Microsoft Azure:<br />\- [Learn about running virtual machines in Microsoft Azure](http://aka.ms/fvq05g)<br />\- [Move VM’s between Hyper\-V and Microsoft Azure](http://aka.ms/vf75zq)<br />\- [Move VMware, AWS, Hyper\-V and Physical Servers to Microsoft Azure](http://aka.ms/vf75zq)<br />\- [Manage Azure VMs with Virtual Machine Manager in System Center 2012 R2 with Rollup 6](http://aka.ms/e6zkgq)<br />\- [Create and upload a Windows Server VHD to Azure](http://aka.ms/eqpd65)<br />\- [Create and preconfigure Windows virtual machine with the classic deployment model and PowerShell](http://aka.ms/lr0ve7)|  
  
**In this document:**  
  
-   [About this guide](../Topic/Migrate-Hyper-V-to-Windows-Server-2012-R2-from-Windows-Server-2008-R2.md#BKMK_About)  
  
-   [What this guide does not provide](../Topic/Migrate-Hyper-V-to-Windows-Server-2012-R2-from-Windows-Server-2008-R2.md#BKMK_NotProvide)  
  
-   [Supported migration scenarios](../Topic/Migrate-Hyper-V-to-Windows-Server-2012-R2-from-Windows-Server-2008-R2.md#BKMK_Supported)  
  
-   [Migration scenarios that are not supported](../Topic/Migrate-Hyper-V-to-Windows-Server-2012-R2-from-Windows-Server-2008-R2.md#BKMK_NotSupported)  
  
-   [Overview of migration process for this role](../Topic/Migrate-Hyper-V-to-Windows-Server-2012-R2-from-Windows-Server-2008-R2.md#BKMK_MigrationProcess)  
  
-   [In\-place upgrade](../Topic/Migrate-Hyper-V-to-Windows-Server-2012-R2-from-Windows-Server-2008-R2.md#bkmk_inplace)  
  
-   [Manually copy virtual hard disks and virtual machine configuration files](../Topic/Migrate-Hyper-V-to-Windows-Server-2012-R2-from-Windows-Server-2008-R2.md#bkmk_manually)  
  
## <a name="BKMK_About"></a>About this guide  
This guide describes how to migrate the Hyper\-V role by providing preparation, migration, and verification steps.  
  
Migration documentation facilitates the migration of server role settings and data from an existing source server to a destination server that is running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
In addition to the migration options that are described in this topic, [!INCLUDE[vmmblue_1](../Token/vmmblue_1_md.md)] can facilitate and automate a considerable part of the migration process. For more information about Virtual Machine Manager, see [Virtual Machine Manager](http://technet.microsoft.com/library/gg610610.aspx).  
  
### Target audience  
This document is intended for information technology \(IT\) professionals who are responsible for operating and deploying Hyper\-V in a managed environment.  
  
## <a name="BKMK_NotProvide"></a>What this guide does not provide  
  
-   Clustering scenarios are not supported by this migration process. For information about how to perform a migration in a clustered environment, see [Migration of Highly Available Virtual Machines Using the Migrate a Cluster Wizard](assetId:///0b7fd763-b21e-44e5-8f6e-cdf863a06a4a).  
  
-   Migration of Hyper\-V from one server that runs [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to another server that runs [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. For more information about migration from [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], see [Migrate Hyper-V to Windows Server 2012 R2 from Windows Server 2012](../Topic/Migrate-Hyper-V-to-Windows-Server-2012-R2-from-Windows-Server-2012.md).  
  
-   Instructions for migrating more than one server role at one time.  
  
-   Migration of Hyper\-V from one server that runs [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] to another server that runs [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. Instead, you can leverage one of the following Hyper\-V features:  
  
    -   Live migration  
  
    -   Shared nothing live migration  
  
    -   Export and import  
  
    -   Copy cluster wizard  
  
## <a name="BKMK_Supported"></a>Supported migration scenarios  
This guide provides you with instructions to migrate a server that is running Hyper\-V in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] to a server that is running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. This guide does not contain instructions for migration when the source server is running multiple roles. If your server is running multiple roles, we recommend that you design a custom migration procedure that is specific to your server environment and is based on the information in other role migration guides. Migration guides for additional roles are available on the [Windows Server Migration Portal](http://technet.microsoft.com/windowsserver/jj554790.aspx).  
  
### Migration dependencies  
The Hyper\-V role does not depend on any other roles. As a best practice, we recommend that no other roles are installed on a server running Hyper\-V.  
  
## <a name="BKMK_NotSupported"></a>Migration scenarios that are not supported  
The following migration scenarios are not supported:  
  
-   Virtual machine configuration under one of the following conditions:  
  
    -   When the number of virtual processors that are configured for the virtual machine is greater than the number of logical processors on the destination server.  
  
    -   When the memory that is configured for a virtual machine is greater than the available memory on the destination server.  
  
## <a name="BKMK_MigrationProcess"></a>Overview of migration process for this role  
Hyper\-V role migration involves moving the virtual machines, virtual networks, and all the associated settings from one physical computer to another physical computer in the enterprise. The process supports moving from a server running Hyper\-V in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] to a server running Hyper\-V in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. The Hyper\-V role does not depend on any other roles.  
  
The following options are available to move a virtual machine:  
  
-   [In\-place upgrade](../Topic/Migrate-Hyper-V-to-Windows-Server-2012-R2-from-Windows-Server-2008-R2.md#bkmk_inplace)  
  
-   [Manually copy virtual hard disks and virtual machine configuration files](../Topic/Migrate-Hyper-V-to-Windows-Server-2012-R2-from-Windows-Server-2008-R2.md#bkmk_manually)  
  
    > [!IMPORTANT]  
    > Exporting a virtual machine from [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and importing it on a server running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] is not supported.  
  
-   Migrate to Hyper\-V running on [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] first and then migrate to Hyper\-V running on [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. For additional information see:  
  
    1.  [Migrate Hyper-V to Windows Server 2012 from Windows 2008 R2](../Topic/Migrate-Hyper-V-to-Windows-Server-2012-from-Windows-2008-R2.md)  
  
    2.  [Migrate Hyper-V to Windows Server 2012 R2 from Windows Server 2012](../Topic/Migrate-Hyper-V-to-Windows-Server-2012-R2-from-Windows-Server-2012.md)  
  
## Estimated duration  
The length of time it takes to migrate the Hyper\-V role depends on the size of the data to be transferred and on the tools that are used. Of the various types of files to be transferred, the virtual hard disk \(VHD\), have the largest file sizes from a few gigabytes to many gigabytes in size. The length of time that is required for migration is largely affected by the size of the VHD files and by the network bandwidth.  
  
## <a name="bkmk_inplace"></a>In\-place upgrade  
This scenario describes how to use the existing hardware that runs the [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] operating system and to perform an in\-place upgrade of the operating system to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. This scenario does not require any additional hardware.  
  
> [!NOTE]  
> Before you run an in\-place upgrade, we recommend that you back up the management operating system and the virtual machines.  
  
### Perform an in\-place upgrade  
Use the following steps to perform an in\-place upgrade.  
  
1.  Log on to the server by using a user account with local Administrator rights.  
  
2.  Shutdown all running virtual machines and ensure none of the virtual machines are in a saved state.  
  
3.  Delete all online snapshots. Online snapshots contain saved state information and saved states cannot be migrated to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. For additional information about online snapshots, see [Checkpoints and Snapshots Overview](assetId:///b2f6bba9-f7b9-4fde-b046-7401cbdee93a).  
  
4.  Insert media for [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and run **Setup.exe** if the installation program did not start automatically.  
  
5.  Review the upgrade report and fix any blocking warning messages.  
  
6.  After the server running Hyper\-V has restarted, confirm that the server was successfully upgraded.  
  
7.  Install the latest updates.  
  
8.  Start each of the virtual machines that were running before the upgrade.  
  
9. Confirm that each virtual machine operates as expected.  
  
10. Upgrade the integration services for each virtual machine. A restart might be required to complete the integration services update.  
  
## <a name="bkmk_manually"></a>Manually copy virtual hard disks and virtual machine configuration files  
This scenario describes how to copy the virtual machine and associated files on a Hyper\-V running on [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] to a server running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. This scenario requires a server that is running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] with the Hyper\-V role installed and configured.  
  
There are two servers that are referenced in this scenario:  
  
-   Source server – this is the server running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
-   Destination server – this is the server running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
Perform the following steps on the source server.  
  
1.  Shutdown or turn off virtual machines you want to move. Saved state is not supported.  
  
2.  Delete all online snapshots for each virtual machine to be moved. For more information about online snapshots, see [Checkpoints and Snapshots Overview](assetId:///b2f6bba9-f7b9-4fde-b046-7401cbdee93a)  
  
3.  Stop the **Hyper\-V Virtual Machine Management** service \(vmms.exe\).  
  
    > [!NOTE]  
    > This step is need to ensure that all files are properly unlocked.  
  
4.  Copy the virtual hard disk and configuration files to the destination server.  
  
5.  You can start the **Hyper\-V Virtual Machine Management** service if you still have virtual machines running on the source server.  
  
Perform the following steps on the destination server.  
  
1.  Install [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] on the new server hardware.  
  
2.  Install the Hyper\-V role on the server.  
  
3.  Configure the following Hyper\-V settings, for example:  
  
    -   The default location for virtual hard disks and virtual machine configuration files.  
  
    -   Live migration settings.  
  
    -   Virtual switches.  
  
4.  Open the Hyper\-V Manager console.  
  
5.  From the **Actions** pane click **Import Virtual Machine** to run the **Import Virtual Machine** wizard. You will need to specify the path to the files copied from the source server. The wizard walks you through the steps of addressing incompatibilities when you import the virtual machine to the new host—such as memory, virtual switches, and virtual processors. For more information about the Import wizard, see [Overview of exporting and importing a virtual machine](../Topic/Overview-of-exporting-and-importing-a-virtual-machine.md).  
  
    > [!NOTE]  
    > You can also use the [!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlet [Import\-VM](http://technet.microsoft.com/library/hh848495).  
  
6.  Start the virtual machine that was just imported.  
  
7.  Confirm that each virtual machine operates as expected.  
  
8.  Upgrade the integration services for each virtual machine. A restart might be required to complete the integration services update.  
  
9. To import additional virtual machines, repeat steps 5\-8.  
  
> [!NOTE]  
> Hyper\-V in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] introduces a new version of the virtual hard disk format called VHDX, which is designed to handle current and future workloads. You can convert your existing VHD files to VHDX to take advantage of the VHDX features. When converting from VHD to VHDX the virtual machine must be turned off. In the Hyper\-V Manager console use the **Edit Virtual Hard Disk Wizard** or you can use the **Convert\-VHD**[!INCLUDE[wps](../Token/wps_md.md)] cmdlet.  
>   
> For additional information about VHDX, see [Hyper\-V Virtual Hard Disk Format Overview](assetId:///248806ae-6797-46d1-b1be-24cbf1bafba4).  
>   
> For additional information about Convert\-VHD [!INCLUDE[wps](../Token/wps_md.md)] cmdlet, see [Convert\-VHD](http://technet.microsoft.com/library/hh848454.aspx).  
  
## Additional references  
[Windows Server Migration forum](http://go.microsoft.com/fwlink/p/?LinkId=247606)  
  
[Overview of exporting and importing a virtual machine](../Topic/Overview-of-exporting-and-importing-a-virtual-machine.md)  
  
[Checkpoints and Snapshots Overview](assetId:///b2f6bba9-f7b9-4fde-b046-7401cbdee93a)  
  
