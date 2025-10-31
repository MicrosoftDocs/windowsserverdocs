---
title: Upgrading your Remote Desktop Virtualization Host
description: Learn how to upgrade your existing Remote Desktop Virtualization Host.
ms.author: daknappe
ms.date: 7/3/2024
ms.topic: upgrade-and-migration-article
author: dknappettmsft
---
# Upgrading your Remote Desktop Virtualization Host

> 

## RD Virtualization Host servers in the deployment where VMs are stored locally

These servers should be upgraded all at once. Complete the following steps to upgrade:

1. Log off all users.

1. Turn off or save all virtual machines on each host.

1. Upgrade the servers to the new Windows Server version.

1. All collections should be available and functional after the upgrades are complete.

## RD Virtualization Host servers in the deployment where VMs are stored in Cluster Shared Volumes (CSV)

1. Determine an upgrade strategy where some of the RDVH servers are upgraded and some continue to host VMs on the earlier version of Windows Server.

1. Isolate one or more of the RDVH servers targeted for the initial round of upgrading. By migrating all VMs to other 'not to be upgraded yet' RDVH servers that remain part of the original cluster.
    1. Open Failover Cluster Manager.
    
    1. Select **Roles**.
    
    1. Select one or more VMs. Right-click to open the context menu.
    
    1. Select **Move** and choose either **Live** or **Quick Migration** to move the VMs to one or more of the RD Virtualization Host Servers that aren't part of the initial upgrade. Use **Live** or **Quick** Migration depending on factors such as hardware compatibility or online requirements.

1. Evict the RDVH servers, prepared for upgrading, from the original cluster.

1. Upgrade the isolated RDVH servers.

1. After the targeted RDVH servers have been successfully upgraded, create a new cluster and CSV, which needs to be on an entirely different SAN volume.

1. Join all upgraded RDVH servers to the new cluster.

1. Create a folder structure in the new CSV that mimics the existing folder structure in the existing CSV. This includes the collection folders and each VM's top level subfolders.

1. From the various VM Collection folders on the original CSV, copy over the /IMGS folder and contents to the new collection folders in the same locations on the new CSV.

1. On the source RDVH machine, use Cluster Manager to remove the VM's configuration for high availability:
    1. Launch Cluster Manager.
    
    1. Select **Roles**.
    
    1. Right-click the VM objects, and then select **Remove**.

1. On one of the nonupgraded RDVH servers, use Hyper-V Manager to move all VMs to one of the upgraded RDVH servers and new Cluster CSV:
    1. Open Hyper-V Manager.
    
    1. Select one of the nonupgraded RDVH servers.
    
    1. Right-click one of the VMs to be moved, and then select **Move**.
    
    1. Choose **Move the virtual machine**, and then select **Next**.
    
    1. Provide the targeted upgraded RDVH server's name on the **Specify Destination Computer** page, and then select **Next**.
    
    1. Choose **Move the virtual machine's data to a single location**, and then select **Next**.
    
    1. Browse to the destination location.
       > [!IMPORTANT]
       > Ensure this path is to an empty folder for the specific VM.

       > [!NOTE]
       > As mentioned, you need to have already created a new destination subfolder prior to this step. The Select Folder dialog won't allow you to create a subfolder in this step.

       Select **Next**, and then select **Finished**.
1. Once the VMs are relocated, add them as cluster **High Availability** objects:
     1. Open Failover Cluster Manager on an upgraded RD Virtualization Host Server.
     
     1. Right-click the **Roles** node, and then select **Configure Role**. Select **Next** on the **Start** page of the High Availability wizard.
     
     1. Choose **Virtual Machine** from the list of available roles, and then select **Next**. A list of VMs that aren't configured is shown.
     
     1. Select all the VMs. Select **Next** and then select **Next** again on the confirmation page to start the configuration task.

1. Once you have relocated all VMs, upgrade the remaining RDVH servers. Use the above steps for balancing VM locations as appropriate.

> [!NOTE]
> Heterogeneous Hyper-V servers in a cluster aren't supported.
