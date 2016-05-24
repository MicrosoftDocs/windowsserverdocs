---
title: Cluster Migrations Involving New Storage: Mount Points
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1f3646e5-bc20-4253-9451-40db0455e1b9
author: kumudd
---
# Cluster Migrations Involving New Storage: Mount Points
This topic describes considerations for configuring mount points during a migration to a failover cluster running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] when the destination cluster will use new storage after the migration.  
  
> [!CAUTION]  
> If you want to use new storage, you must copy or move the data or folders \(including shared folder settings\) during a migration. The wizard for migrating clustered resources does not copy data from one shared storage location to another.  
  
The Migrate a Cluster Wizard does not migrate mount point information \(that is, information about hard disk drives that do not use drive letters, but are mounted instead in a folder on another hard disk drive\). However, the wizard can migrate Physical Disk Resource settings to and from disks that use mount points. The wizard also does not configure the necessary dependency between the resources for mounted disks and the resource for a host disk \(the disk on which the other disks are mounted\). You must configure those dependencies after the wizard completes.  
  
When you work with new storage for your cluster migration, you have some flexibility in the order in which you complete the tasks. You must create the mount points, run the Migrate a Cluster Wizard, copy the data to the new storage, and confirm the disk letters and mount points for the new storage. After completing those tasks, configure the disk resource dependencies in Failover Cluster Manager.  
  
A useful way to keep track of disks in the new storage is to give them labels that indicate your intended mount point configuration. For example, in the new storage, when you are mounting a new disk in a folder called \\**Mount1\-1** on another disk, you can also label the mounted disk as **Mount1\-1**. \(This assumes that the label **Mount1\-1** is not already in use in the old storage.\) When you run the Migrate a Cluster Wizard, and you need to specify that disk for a particular migrated resource, you can select the disk labeled **Mount1\-1** from the list. After the wizard completes, you can return to Failover Cluster Manager to configure the disk resource for **Mount1\-1** so that it is dependent on the appropriate resource \- for example, the resource for disk **F**. Similarly, you would configure the disk resources for all other disks mounted on disk F so that they depended on the disk resource for disk F.  
  
After you run the wizard and fully configure the mounted disk, your last task is to configure the disk dependencies in Failover Cluster Manager. For each disk resource for a mounted hard disk drive, open the Properties sheet and, on the **Dependencies** tab, specify a dependency on the disk resource for the host drive \(where the mounted drives reside\). This ensures that the Cluster service brings the host drive online first, followed by the drives that are dependent on it.  
  
After you configure the dependencies, you can view a dependency report. To view a dependency report, click the service or application in Failover Cluster Manager, and then, under **Actions**, click **Show Dependency Report**. The following illustration shows four mount points that are configured with the correct dependencies on the disk on which they are mounted:  
  
**Four mount points with dependencies configured**  
  
![](../Image/Fail_dep_c.gif)  
  
## Additional references  
[Migrate Cluster Roles to Windows Server 2012 R2](http://technet.microsoft.com/library/dn530779.aspx)  
  
[Migrating Clustered Services and Applications to Windows Server 2012](http://technet.microsoft.com/library/dn486790.aspx)  
  
