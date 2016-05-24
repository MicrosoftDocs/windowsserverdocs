---
title: Migrate Hyper-V to Windows Server 2012 R2 from Windows Server 2012
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5c8c1264-bd28-4818-9281-d8425e59ed50
author: cwatsonmsft
---
# Migrate Hyper-V to Windows Server 2012 R2 from Windows Server 2012
With Hyper\-V, you can create a virtualized server computing environment by using a technology that is part of Windows. This guide provides information and instructions about migrating the Hyper\-V role that include virtual machines, data, and operating system settings from the source server running Hyper\-V in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to the destination server that is running the [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] operating system.  
  
|||  
|-|-|  
|![](b93f8edc-baa1-46ad-aed5-99c8690273c0)|Did you know that Microsoft Azure provides similar functionality in the cloud? Learn more about [Microsoft Azure virtualization solutions](http://aka.ms/f9bh7g).<br /><br />Create a hybrid virtualization solution in Microsoft Azure:<br />\- [Learn about running virtual machines in Microsoft Azure](http://aka.ms/fvq05g)<br />\- [Move VM’s between Hyper\-V and Microsoft Azure](http://aka.ms/vf75zq)<br />\- [Move VMware, AWS, Hyper\-V and Physical Servers to Microsoft Azure](http://aka.ms/vf75zq)<br />\- [Manage Azure VMs with Virtual Machine Manager in System Center 2012 R2 with Rollup 6](http://aka.ms/e6zkgq)<br />\- [Create and upload a Windows Server VHD to Azure](http://aka.ms/eqpd65)|  
  
## About this guide  
This guide describes how to migrate the Hyper\-V role by providing preparation, migration, and verification steps.  
  
Migration documentation and tools facilitate the migration of server role settings and data from an existing source server to a destination server that is running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. By using the tools that are described in this guide, you can simplify the migration process, reduce migration time, increase the accuracy of the migration process, and help eliminate possible conflicts that might otherwise occur during the migration process.  
  
In addition to the migration options that are described in this topic, Virtual Machine Manager in Microsoft System Center 2012 R2 can facilitate and automate a considerable part of the migration process. For more information about Virtual Machine Manager, see [Virtual Machine Manager](http://technet.microsoft.com/library/gg610610.aspx).  
  
### Target audience  
This document is intended for information technology \(IT\) professionals who are responsible for operating and deploying Hyper\-V in a managed environment.  
  
## What this guide does not provide  
  
-   Migration of Hyper\-V from one server that runs [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] to another server that runs [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
-   Instructions for migrating more than one server role at one time.  
  
-   Migration of Hyper\-V from one server that runs [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] to another server that runs [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. Instead, this process is supported by Hyper\-V management tools and features. The general process is as follows:  
  
    1.  Determine whether to use export and import or live migration to move the virtual machines:  
  
        -   Export and import can be used in either a workgroup or a domain environment. In Hyper\-V running on [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], you can now export a running virtual machine.  
  
        -   Live migration requires a domain environment and some additional configuration, but the virtual machine is running throughout the move process.  
  
    2.  Add the Hyper\-V role to the destination server. You can configure the default storage locations and live migration when you add the role.  
  
    3.  Configure virtual switches, and optionally, other networking features on the destination server. Management tools include the [!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlets [New\-VMSwitch](http://technet.microsoft.com/library/hh848455) and [Set\-VMSwitch](http://technet.microsoft.com/library/hh848515), and the Hyper\-V Virtual Switch Manager in the Hyper\-V Manager console.  
  
    4.  Move the virtual machines by using export and import or live migration. Management tools include the [!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlets [Export\-VM](http://technet.microsoft.com/library/hh848491), [Import\-VM](http://technet.microsoft.com/library/hh848495), and [Move\-VM](http://technet.microsoft.com/library/hh848547.aspx) and the **Export**, **Import**, and **Move** menu commands in the Hyper\-V Manager console.  
  
## Supported migration scenarios  
This guide provides you with instructions to migrate a server that is running Hyper\-V in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to a server that is running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. This guide does not contain instructions for migration when the source server is running multiple roles. If your server is running multiple roles, we recommend that you design a custom migration procedure that is specific to your server environment and is based on the information in other role migration guides. Migration guides for additional roles are available on the [Windows Server Migration Portal](http://technet.microsoft.com/windowsserver/jj554790.aspx).  
  
### Migration dependencies  
The Hyper\-V role does not depend on any other roles. As a best practice, we recommend that no other roles are installed on a server running Hyper\-V.  
  
## Migration scenarios that are not supported  
The following migration scenarios are not supported:  
  
-   Virtual machine configuration under one of the following conditions:  
  
    -   When the number of virtual processors that are configured for the virtual machine is greater than the number of logical processors on the destination server.  
  
    -   When the memory that is configured for a virtual machine is greater than the available memory on the destination server.  
  
## Overview of migration process for this role  
Hyper\-V role migration involves moving the virtual machines, virtual networks, and all the associated settings from one physical computer to another physical computer in the enterprise. The process supports moving from a server running Hyper\-V in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to a server running Hyper\-V in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. The Hyper\-V role does not depend on any other roles.  
  
The migration tools include [!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlets that you can use to perform some of the tasks that are required to migrate the Hyper\-V role and script or to automate the migration process.  
  
In previous versions of Hyper\-V, you were required to shut down a virtual machine before you moved it to a new server. If the move was performed correctly, downtime was limited, but still, there was downtime. A new feature in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], cross\-version live migration, supports moving a running virtual machine from [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. The [!INCLUDE[wps_2](../Token/wps_2_md.md)][Export\-VM](http://technet.microsoft.com/library/hh848491) cmdlet captures the majority of the Hyper\-V settings that are required to perform a successful migration, which includes the virtual machine configurations, virtual networks, and virtual hard disks. Now you can decide how to move virtual machines to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], where in the past, your options where limited.  
  
The following options are available to move a virtual machine:  
  
-   In\-place upgrade  
  
-   Cross\-version live migration  
  
-   Export and Import  
  
-   Copy Cluster Role Wizard  
  
For additional information about each option, see [Hyper-V: Migration Options](../Topic/Hyper-V--Migration-Options.md).  
  
This guide explains the migration process for the following three main scenarios:  
  
-   [Hyper-V: Stand-alone Migration](../Topic/Hyper-V--Stand-alone-Migration.md)  
  
-   [Hyper-V Cluster Using Separate Scale-Out File Server Migration](../Topic/Hyper-V-Cluster-Using-Separate-Scale-Out-File-Server-Migration.md)  
  
-   [Hyper-V Cluster Using Cluster Shared Volumes &#40;CSV&#41; Migration](../Topic/Hyper-V-Cluster-Using-Cluster-Shared-Volumes--CSV--Migration.md)  
  
## Estimated duration  
The length of time it takes to migrate the Hyper\-V role depends on the size of the data to be transferred and on the tools that are used. Of the various types of files to be transferred, the virtual hard disk \(VHD\), .vhd and .vhdx files, have the largest file sizes from a few gigabytes to many gigabytes in size. The length of time that is required for migration is largely affected by the size of the VHD files and by the network bandwidth.  
  
## Additional references  
[Windows Server Migration forum](http://go.microsoft.com/fwlink/p/?LinkId=247606)  
  
