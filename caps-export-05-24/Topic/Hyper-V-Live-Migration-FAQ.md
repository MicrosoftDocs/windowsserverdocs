---
title: Hyper-V Live Migration FAQ
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9507a03a-0996-40a3-ac5a-fd1da8c9177e
author: cwatsonmsft
---
# Hyper-V Live Migration FAQ
This article provides answers to common questions about the live migration feature of Hyper\-V in [!INCLUDE[firstref_server_7](../Token/firstref_server_7_md.md)].  
  
## Frequently Asked Questions for using the Live Migration feature of Hyper\-V  
[What is live migration?](assetId:///e0ccbd39-c56b-4994-8e50-846861c66285#BKMK_whatis)  
  
[What are the requirements for using live migration?](assetId:///e0ccbd39-c56b-4994-8e50-846861c66285#BKMK_reqs)  
  
[How do you initiate a live migration?](assetId:///e0ccbd39-c56b-4994-8e50-846861c66285#BKMK_initiate)  
  
[How many network adapters are required to use live migration?](assetId:///e0ccbd39-c56b-4994-8e50-846861c66285#BKMK_nics)  
  
[Are Cluster Shared Volumes required to use live migration?](assetId:///e0ccbd39-c56b-4994-8e50-846861c66285#BKMK_CSV)  
  
[How long does it take to move a virtual machine using live migration?](assetId:///e0ccbd39-c56b-4994-8e50-846861c66285#BKMK_howlong)  
  
[Does live migration support moving a virtual machine to a physical computer with a different processor?](assetId:///e0ccbd39-c56b-4994-8e50-846861c66285#BKMK_diffprocessor)  
  
[Does live migration support TCP Offload \(Chimney\)?](assetId:///e0ccbd39-c56b-4994-8e50-846861c66285#BKMK_TCPOffload)  
  
[Can you initiate more than one live migration at a time?](assetId:///e0ccbd39-c56b-4994-8e50-846861c66285#BKMK_morethanone)  
  
[Can you back up a migrating virtual machine?](assetId:///e0ccbd39-c56b-4994-8e50-846861c66285#BKMK_backupVM)  
  
[When should you refresh configuration changes you made to a virtual machine?](assetId:///e0ccbd39-c56b-4994-8e50-846861c66285#BKMK_refreshVM)  
  
[Are all virtual switch names required to be the same to support live migration?](assetId:///e0ccbd39-c56b-4994-8e50-846861c66285#BKMK_switchname)  
  
[When using CSV with Hyper\-V, do you have to boot from the same drive letter?](assetId:///e0ccbd39-c56b-4994-8e50-846861c66285#BKMK_driveletter)  
  
### <a name="BKMK_whatis"></a>What is live migration?  
Live migration is a Hyper\-V feature in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], which requires the failover clustering feature to be added and configured on the servers running Hyper\-V. Live migration allows you to transparently move running virtual machines from one node of the failover cluster to another node in the same cluster without a dropped network connection or perceived downtime. In addition, failover clustering requires shared storage for the cluster nodes. This can include an iSCSI or Fiber\-Channel Storage Area Network \(SAN\). All virtual machines are stored in the shared storage area, and the running virtual machine state is managed by one of the nodes. For a detailed overview of live migration and the benefits of using it, see [Windows Server 2008 R2 & Microsoft Hyper\-V Server 2008 R2 \- Hyper\-V Live Migration Overview & Architecture](http://www.microsoft.com/downloads/details.aspx?FamilyID=FDD083C6-3FC7-470B-8569-7E6A19FB0FDF&amp).  
  
### <a name="BKMK_reqs"></a>What are the requirements for using live migration?  
  
-   All the servers in a failover cluster must either run the x64\-based version or the Itanium architecture\-based version of Windows Server 2008 R2 \(nodes within a single failover cluster cannot run different versions\).  
  
-   All the servers should have the same software updates \(patches\) and service packs.  
  
-   [!INCLUDE[firstref_server_7ent](../Token/firstref_server_7ent_md.md)] or [!INCLUDE[firstref_server_7dat](../Token/firstref_server_7dat_md.md)] must be used for the physical computers. These servers must run the same version of Windows Server 2008 R2, including the same type of installation. That is, both servers must be either a full installation or a Server Core installation.  
  
-   Configure all physical hosts that will use live migration with failover clustering, which supports up to 16 nodes per cluster.  
  
-   Configure the cluster with a dedicated network for live migration traffic.  
  
-   Configure physical hosts on the same TCP\/IP subnet.  
  
-   Provide shared storage access to all physical hosts.  
  
### <a name="BKMK_initiate"></a>How do you initiate a live migration?  
You can initiate a live migration using any of the following methods:  
  
-   **Using Failover Cluster Manager.** For more information, see “To initiate live migration using Failover Cluster Manager” in [Hyper\-V: Using Live Migration with Cluster Shared Volumes in Windows Server 2008 R2](http://go.microsoft.com/fwlink/?LinkId=164729).  
  
-   **PowerShell.** For more information, see “To initiate live migration using PowerShell” in [Hyper\-V: Using Live Migration with Cluster Shared Volumes in Windows Server 2008 R2](http://go.microsoft.com/fwlink/?LinkId=164729).  
  
-   **System Center Virtual Machine Manager 2008 R2.** For more information, see the [System Center Virtual Machine Manager web site](http://technet.microsoft.com/en-us/systemcenter/vmm/default.aspx).  
  
### <a name="BKMK_nics"></a>How many network adapters are required to use live migration?  
For each node of the failover cluster, use more than one network adapter and configure at least one network adapter for the private network. We recommend that you configure separate dedicated networks with gigabit or faster speed for live migration traffic and cluster communication, and these networks should be separate from the network used by the management operating system, and from the network used by the virtual machines. For information on network settings required for live migration, see [Hyper\-V: Live Migration Network Configuration Guide](http://technet.microsoft.com/en-us/library/ff428137(WS.10).aspx).  
  
### <a name="BKMK_CSV"></a>Are Cluster Shared Volumes required to use live migration?  
Cluster Shared Volumes are not required to perform a live migration. You should be aware that using Cluster Shared Volumes simplifies the configuration and management of clustered virtual machines. With Cluster Shared Volumes, multiple clustered virtual machines can use the same LUN \(disk\) while still being able to fail over \(or move from node to node\) independently of one another.  
  
### <a name="BKMK_howlong"></a>How long does it take to move a virtual machine using live migration?  
The amount of time is dependent on the following items:  
  
-   The network connection speed and bandwidth that is available between the source cluster node and the destination cluster node.  
  
-   The load on the source cluster node and the destination cluster node.  
  
-   The amount of RAM configured for the virtual machine.  
  
### <a name="BKMK_diffprocessor"></a>Does live migration support moving a virtual machine to a physical computer with a different processor?  
If you are using different processor versions on the nodes in the cluster, live migration may fail. To perform a live migration of a virtual machine to another physical computer with a different processor, you must first select the **Migrate to a physical computer with a different processor version** setting in Hyper\-V Manager. This setting ensures that the virtual machine uses only the features of the processor that are available on all versions of a virtualization\-capable processor by the same processor manufacturer. It does not provide compatibility between different processor manufacturers. This allows you to move a running virtual machine to a physical computer with different processor features without restarting the virtual machine.  
  
### <a name="BKMK_TCPOffload"></a>Does live migration support TCP Offload \(Chimney\)?  
Yes, when performing a live migration, the TCP stack on the device is moved back into the software stack within the virtual machine. If the cluster node to which the virtual machine in migrating also supports TCP Offload, then this capability will be utilized once the migration is complete.  
  
### <a name="BKMK_morethanone"></a>Can you initiate more than one live migration at a time?  
Yes, depending on the number of nodes in the failover cluster, you may be able to use live migration to move more than one virtual machine at a time. Keep in mind that a cluster node can participate as the source or destination node in only one live migration at a time. For example, if there are 4 nodes in the failover cluster, then two live migrations can occur at the same time.  
  
You can also use Virtual Machine Manager’s maintenance mode to use live migration to evacuate all virtual machines to other hosts on the same cluster. For more information, see [About Maintenance Mode](http://technet.microsoft.com/en-us/library/ee236481.aspx).  
  
### <a name="BKMK_backup"></a>Can you back up a migrating virtual machine?  
Yes. Because live migration is a transition state, the Hyper\-V VSS writer waits for the migration to complete before continuing with backup. However, once migration is complete, the virtual machine is no longer on the cluster node on which backup occurs. At this stage, backup continues and correctly backs up the files \(it can still access the files on the CSV volume\), but it is only a file copy. The VSS writer does not perform the steps that it usually would for an online backup. You should be aware that the VSS writer does not return a failure error code to VSS, and therefore, does not log any errors. However, it does log two warning messages that the virtual machine is not found.  
  
> [!IMPORTANT]  
> When the Hyper\-V VSS writer performs a backup in a failover cluster that uses CSV, and the backup fails or is canceled, CSV continues in a redirected I\/O mode. This causes the I\/O performance of all of the cluster nodes to suffer.  
  
### <a name="BKMK_refreshVM"></a>When should you refresh configuration changes you made to a virtual machine?  
If you change the configuration of a virtual machine, we recommend that you use the Failover Cluster Manager snap\-in to access the virtual machine settings. When you do this, the cluster is updated automatically with the configuration changes. However, if you make changes to the virtual machine settings from the Hyper\-V Manager snap\-in, you must update the cluster manually after you make the changes. If the configuration is not refreshed after networking or storage changes are made, a subsequent failover may not succeed or may succeed but result in the virtual machine being configured incorrectly.  
  
### <a name="BKMK_switchname"></a>Are all virtual switch names required to be the same to support live migration?  
Yes, you should make sure that all virtual switch names are the same across the entire cluster.  
  
### <a name="BKMK_driveletter"></a>When using CSV with Hyper\-V, do you have to boot from the same drive letter?  
When using Hyper\-V with Cluster Shared Volumes, in order for virtual machines to migrate or fail over properly, the operating system \(%SystemDrive%\) of each server in your cluster must be set so that it boots from the same drive letter as all other servers in the cluster. In other words, if one server boots from drive letter C, all servers in the cluster should boot from drive letter C.  
  
## Additional resources  
Below are additional resources about the live migration feature of Hyper\-V.  
  
-   [Hyper\-V Step\-by\-Step Guide: Hyper\-V and Failover Clustering](http://go.microsoft.com/fwlink/?LinkID=129063)  
  
-   [Hyper\-V: Using Live Migration with Cluster Shared Volumes in Windows Server 2008 R2](http://go.microsoft.com/fwlink/?LinkId=164729)  
  
-   [Hyper\-V: Live Migration Network Configuration Guide](http://technet.microsoft.com/en-us/library/ff428137(WS.10).aspx)  
  
