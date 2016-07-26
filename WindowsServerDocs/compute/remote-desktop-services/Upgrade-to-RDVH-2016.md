---
title: Upgrading your Remote Desktop Virtualization Host to Windows Server 2016 
description: This article describes how to upgrade your existing Remote Desktop Services deployments to Windows Server 2016.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: [GET ONE FROM guidgenerator.com]
author: spatnaik
manager: scottman
notes: http://social.technet.microsoft.com/wiki/contents/articles/22069.remote-desktop-services-upgrade-guidelines-for-windows-server-2012-r2.aspx

---
# Upgrading your Remote Desktop Virtualization Host to Windows Server 2016

>Applies To: Windows Server Technical Preview

## Standalone RDVH servers in the deployment

These servers should be upgraded all at once. Follow the following steps to upgrade:

1. Log off all users 
1. Turn off/Save all virtual machines (VMs) on each host 
1. Start upgrading the servers to Windows Server 2012 R2 
1. Once up – all collections should be available and functional and the users can start connecting.          


## Multi-server RDVH environment to be upgraded where Cluster Shared Volumes (CSV) is used for VM storage

1. Determine an upgrade strategy where some of the RDVH servers will be upgraded and some will continue to host VMs on Windows Server 2012.  
1. Isolate one or more of the RDVH server(s), targeted for the initial round of upgrading, by migrating all VMs to other ‘not to be upgraded yet’ RDVH server(s) which will remain part of the original 2012 cluster.
    1. Open Failover Cluster Manager. 
    1. Select ‘Roles’ 
    1. Select one or more VMs. Right click to open the context menu. 
    1. Select ‘Move’ and choose either ‘Live or Quick Migration’ to move the VM(s) to one or more of the RD Virtualization Host Servers that are not part of the initial upgrade. Use ‘Live’ or ‘Quick’ Migration depending on factors such as hardware compatibility or online requirements etc. 

1. Evict the RD Virtualization Host Server(s), prepared for upgrading, from the original cluster. 
1. Upgrade the isolated RD Virtualization Host server(s). 
1. After the targeted RD Virtualization Host Server(s) have been successfully upgraded, create a new cluster and CSV which needs to be on an entirely different SAN volume.
1. Join all upgraded RD Virtualization Host Server(s) to the new cluster. 
1. Create a folder structure in the new CSV which mimics the existing folder structure in the existing CSV. This will include the collection folder(s) and each VM’s top level sub-folders. 
1. From the various VM Collection folders on the original CSV, copy over the ‘IMGS’ folder and contents on to the new collection folder(s) in the same location(s) on the new CSV. 
1. On the source RDVH machine, use Cluster Manager to ‘Remove’ the VM’s configuration for ‘high availability’:
    1. Launch Cluster Manager. 
    1. Select the ‘Roles’ node. 
    1. Right click on the VM objects and select ‘Remove’. 

1. On one of the non-upgraded RD Virtualization Host servers, use Hyper-V Manager to ‘Move’ all VMs to one of the upgraded RDVH Servers and new Cluster CSV:            ◦Open Hyper-V Manager. 
    1. Select one of the non-upgraded RD Virtualization Host servers. 
    1. Select one of the VMs to be moved, right click on it to open the context menu. 
    1. Select ‘Move’, the Move Wizard open. 
    1. Choose ‘Move the virtual machine’ and click ‘Next’. 
    1. Provide the targeted upgraded RDVH server’s name on the ‘Specify Destination Computer’ page and click ‘Next’. 
    1. Choose ‘Move the virtual machine’s data to a single location’ and click ‘Next’. 
    1. Browse to the Destination location. 

    > [!IMPORTANT]
    > Ensure this path is to an empty folder for the specific VM. 

    > [!NOTE]
    > As mentioned, you will need to pre-create a new destination sub folder prior to this step. The Select Folder dialog will not allow for creation of the appropriate sub folder in this step. Click ‘Next’. Click ‘Finished’. 

1. Once the VM(s) are relocated, add them as cluster ‘High Availability’ objects. ◦Open ‘Failover Cluster Manager’ on an upgraded RD Virtualization Host Server. 
    1. Select the ‘Roles’ node and right click to open the context menu. Select ‘Configure Role …’. The ‘High Availability Wizard’ dialog will open. Select ‘Next’ on the Start page of the wizard. 
    1. On the ‘Select Role’ page, choose ‘Virtual Machine’ from the list of available choices. Click ‘Next’. A list of VMs that are not configured will be shown. 
    1. Select all the VMs. Click ‘Next’. Click ‘Next’ again on the confirmation page to start the configuration task. The VMs will now be configured for ‘High Availability’. 

1. Once all VMs have been relocated, upgrade the remaining RDVH Servers. Use the above steps for balancing VM locations as appropriate. 

## Multi-server RDVH environment to be upgraded without using Cluster Shared Volumes (CSV) for VM storage
1. Determine an upgrade strategy where some of the RD Virtualization Host servers will be upgraded and some will continue to host VMs on Windows Server 2012. 
             
1. Isolate one or more of the RDVH server(s), targeted for the initial round of upgrading, by migrating all VMs to other ‘not to be upgraded yet’ RD Virtualization Host server(s) which will remain part of the original Windows Server 2012 cluster.
    1. Open Failover Cluster Manager. 
    1. Select ‘Roles’ 
    1. Select one or more VMs. Right click to open the context menu. 
    1. Select ‘Move’ and choose either ‘Live or Quick Migration’ to move the VM(s) to one or more of the RDVH Servers that are not part of the initial upgrade. Use ‘Live’ or ‘Quick’ Migration depending on factors such as hardware compatibility or online requirements etc. 

1. Evict the RD Virtualization Host Server(s), prepared for upgrading, from the original cluster. 
1. Upgrade the isolated RD Virtualization Host server(s). 
1. After the targeted RD Virtualization Host Server(s) have been successfully upgraded, create a new Windows Server 2012 R2 cluster node            
1. Join all upgraded RD Virtualization Host Server(s) to the new cluster node 
1. Disconnect the SAN from Windows Server 2012 cluster and add it to the new Windows Server 2012 R2 cluster 
1. Import all VMs from the SAN on the newly upgraded RDVHs 
1. Once the VM(s) are relocated, add them as cluster ‘High Availability’ objects. ◦Open ‘Failover Cluster Manager’ on an upgraded RD Virtualization Host Server. 
    1. Select the ‘Roles’ node and right click to open the context menu. Select ‘Configure Role …’. The ‘High Availability Wizard’ dialog will open. Select ‘Next’ on the Start page of the wizard. 
    1. On the ‘Select Role’ page, choose ‘Virtual Machine’ from the list of available choices. Click ‘Next’. A list of VMs that are not configured will be shown. 
    1. Select all the VMs. Click ‘Next’. Click ‘Next’ again on the confirmation page to start the configuration task. The VMs will now be configured for ‘High Availability’. 

1. Once all VMs have been relocated, destroy the Windows Server 2012 cluster and upgrade the remaining RD Virtualization Host Servers. 

 > [!NOTE]
 > Heterogeneous Hyper-V servers in a cluster are not supported. 
