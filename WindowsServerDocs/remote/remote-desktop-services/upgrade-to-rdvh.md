---
title: Upgrading your Remote Desktop Virtualization Host to Windows Server 2016 
description: This article describes how to upgrade your existing Remote Desktop Services deployments to Windows Server 2016.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: spatnaik
ms.date: 08/01/2016  
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5aed8ba7-f541-4416-b01c-4d3b1712e2b1
author: spatnaik
manager: scottman
---
# Upgrading your Remote Desktop Virtualization Host to Windows Server 2016

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

## Supported OS upgrades with RDS role installed
Upgrades to Windows Server 2016 are supported only from Windows Server 2012 R2 and Windows Server 2016 TP5.

## RD Virtualization Host servers in the deployment where VMs are stored locally
These servers should be upgraded all at once. Follow the following steps to upgrade:

1. Log off all users.
1. Turn off or save all virtual machines on each host. 
1. Upgrade the servers to Windows Server 2016. 
1. All collections should be available and functional after the upgrades are complete.      

## RD Virtualization Host servers in the deployment where VMs are stored in Cluster Shared Volumes (CSV) 

1. Determine an upgrade strategy where some of the RDVH servers will be upgraded and some will continue to host VMs on Windows Server 2012 R2.  
2. Isolate one or more of the RDVH servers, targeted for the initial round of upgrading, by migrating all VMs to other ‘not to be upgraded yet’ RDVH servers that will remain part of the original 2012 R2 cluster.
    1. Open Failover Cluster Manager. 
    1. Click **Roles**. 
    1. Select one or more VMs. Right-click to open the context menu. 
    1. Click **Move** and choose either **Live** or **Quick Migration** to move the VMs to one or more of the RD Virtualization Host Servers that are not part of the initial upgrade. Use **Live** or **Quick** Migration depending on factors such as hardware compatibility or online requirements. 
3. Evict the RDVH servers, prepared for upgrading, from the original cluster. 
4. Upgrade the isolated RDVH servers. 
5. After the targeted RDVH servers have been successfully upgraded, create a new cluster and CSV, which needs to be on an entirely different SAN volume.
6. Join all upgraded RDVH servers to the new cluster. 
7. Create a folder structure in the new CSV that mimics the existing folder structure in the existing CSV. This will include the collection folders and each VM’s top level sub-folders. 
8. From the various VM Collection folders on the original CSV, copy over the /IMGS folder and contents to the new collection folders in the same locations on the new CSV. 
9. On the source RDVH machine, use Cluster Manager to remove the VM’s configuration for high availability:
    1. Launch Cluster Manager. 
    1. Click **Roles**. 
    1. Right-click the VM objects, and then click **Remove**. 
10. On one of the non-upgraded RDVH servers, use Hyper-V Manager to move all VMs to one of the upgraded RDVH servers and new Cluster CSV:
    1. Open Hyper-V Manager. 
    2. Select one of the non-upgraded RDVH servers. 
    3. Right-click one of the VMs to be moved, and then click **Move**. 
    4. Choose **Move the virtual machine**, and then click **Next**. 
    5. Provide the targeted upgraded RDVH server’s name on the **Specify Destination Computer** page, and then click **Next**. 
    6. Choose **Move the virtual machine’s data to a single location**, and then click **Next**. 
    7. Browse to the destination location. 
       > [!IMPORTANT]
       > Ensure this path is to an empty folder for the specific VM. 

       > [!NOTE]
       > As mentioned, you will need to have already created a new destination sub folder prior to this step. The Select Folder dialog will not allow you to create a sub folder in this step. 
    
       Click **Next**, and then click **Finished**. 
11. Once the VMs are relocated, add them as cluster **High Availability** objects:
     1. Open Failover Cluster Manager on an upgraded RD Virtualization Host Server. 
     1. Right-click the **Roles** node, and then click **Configure Role**. Click **Next** on the **Start** page of the High Availability wizard. 
     1. Choose **Virtual Machine** from the list of available roles, and then click **Next**. A list of VMs that are not configured will be shown. 
     1. Select all the VMs. Click **Next** and then click **Next** again on the confirmation page to start the configuration task.  
12. Once you have relocated all VMs, upgrade the remaining RDVH servers. Use the above steps for balancing VM locations as appropriate.

> [!NOTE]  
> Heterogeneous Hyper-V servers in a cluster are not supported. 
