---
title: Deploy a Guest Cluster Using a Shared Virtual Hard Disk
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d25a2cb3-0932-47c9-b2e4-0e0c7ae9dd6a
author: kumudd
---
# Deploy a Guest Cluster Using a Shared Virtual Hard Disk
The procedures in this topic show how you can designate a virtual hard disk \(.vhdx file\) as shared storage for multiple virtual machines that are configured as a guest failover cluster. You can use shared .vhdx files for data disks and for the disk witness. Do not use a shared .vhdx file for the operating system disk.  
  
For an overview of shared .vhdx files that includes deployment diagrams, see [Virtual Hard Disk Sharing Overview](../Topic/Virtual-Hard-Disk-Sharing-Overview.md).  
  
## <a name="BKMK_Deployment"></a>Deployment scenarios  
You can deploy a guest failover cluster that uses shared .vhdx files on a Hyper\-V failover cluster in either of the following configurations:  
  
**Scenario 1: Hyper\-V failover cluster using Cluster Shared Volumes \(CSV\) on block\-level storage**  
  
In this scenario, all virtual machine files, including the shared .vhdx files are stored on a CSV that is configured as shared storage for a Hyper\-V failover cluster.  
  
This scenario has the following physical host prerequisites:  
  
-   At least two servers that are running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
-   The servers must be members of the same Active Directory domain.  
  
-   The servers must support Hyper\-V. For more information, see the "Hardware requirements" section of [Hyper\-V Overview](assetId:///5aad349f-ef06-464a-b36f-366fbb040143).  
  
-   The servers must meet the requirements for failover clustering. For more information, see [Failover Clustering Hardware Requirements and Storage Options](../Topic/Failover-Clustering-Hardware-Requirements-and-Storage-Options.md) and [Validate Hardware for a Failover Cluster_1](../Topic/Validate-Hardware-for-a-Failover-Cluster_1.md).  
  
-   The servers must have access to block\-level storage, which you can add as shared storage to the physical cluster. This storage can be iSCSI, Fibre Channel, Serial Attached SCSI \(SAS\), or clustered storage spaces that use a set of shared SAS just\-a\-bunch\-of\-disks \(JBOD\) enclosures.  
  
**Scenario 2: Hyper\-V failover cluster using file\-based storage in a separate Scale\-Out File Server**  
  
This scenario uses Server Message Block \(SMB\) file\-based storage as the location of the shared .vhdx files. You must deploy a Scale\-Out File Server and create an SMB file share as the storage location. You also need a separate Hyper\-V failover cluster.  
  
The following table describes the physical host prerequisites.  
  
|Cluster Type|Requirements|  
|----------------|----------------|  
|Scale\-Out File Server|-   At least two servers that are running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].<br />-   The servers must be members of the same Active Directory domain.<br />-   The servers must meet the requirements for failover clustering.<br />    For more information, see [Failover Clustering Hardware Requirements and Storage Options](../Topic/Failover-Clustering-Hardware-Requirements-and-Storage-Options.md) and [Validate Hardware for a Failover Cluster_1](../Topic/Validate-Hardware-for-a-Failover-Cluster_1.md).<br />-   The servers must have access to block\-level storage, which you can add as shared storage to the physical cluster. This storage can be iSCSI, Fibre Channel, SAS, or clustered storage spaces that use a set of shared SAS JBOD enclosures.|  
|Hyper\-V failover cluster|-   At least two servers that are running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].<br />-   The servers must be members of the same Active Directory domain.<br />-   The servers must support Hyper\-V. For more information, see the “Hardware requirements” section of [Hyper\-V Overview](assetId:///5aad349f-ef06-464a-b36f-366fbb040143).<br />-   The servers must meet the requirements for failover clustering.<br />    For more information, see [Failover Clustering Hardware Requirements and Storage Options](../Topic/Failover-Clustering-Hardware-Requirements-and-Storage-Options.md) and [Validate Hardware for a Failover Cluster_1](../Topic/Validate-Hardware-for-a-Failover-Cluster_1.md).|  
  
## Step 1: Configure the physical servers  
In this step, you create the failover clusters that are required to host the virtual machines, and create the storage locations for the virtual machine files.  
  
Use the appropriate procedure for your deployment scenario. Before you begin, make sure that the servers meet the prerequisites that are outlined in the [Deployment scenarios](#BKMK_Deployment) section of this topic.  
  
**Scenario 1: Hyper\-V failover cluster using CSV**  
  
1.  Create at least a two\-node Hyper\-V failover cluster by following Steps 1 through 5 in the topic [Deploy a Hyper-V Cluster](../Topic/Deploy-a-Hyper-V-Cluster.md).  
  
2.  In Step 6 of the [Deploy a Hyper-V Cluster](../Topic/Deploy-a-Hyper-V-Cluster.md) topic, add the storage where you want to store the virtual machine files to CSV. For more information, see the “Add a disk as a CSV to a failover cluster” section of [Use Cluster Shared Volumes in a Failover Cluster](../Topic/Use-Cluster-Shared-Volumes-in-a-Failover-Cluster.md).  
  
**Scenario 2: Hyper\-V cluster using file\-based storage in a separate Scale\-Out File Server**  
  
1.  Create at least a two\-node Hyper\-V failover cluster by following Steps 1 through 5 in the topic [Deploy a Hyper-V Cluster](../Topic/Deploy-a-Hyper-V-Cluster.md).  
  
    > [!NOTE]  
    > If you plan to store all virtual machine files on the Scale\-Out File Server, you do not need shared block\-level storage on the Hyper\-V cluster.  
  
2.  Deploy a Scale\-Out File Server by following Steps 1 and 2, and Task 1.1 of Step 3 in the guide [Deploy Scale\-Out File Server](assetId:///11415db9-8fb8-4aea-a6c0-38f706a0586e).  
  
## Step 2: Create the virtual machines  
This step shows how to create the virtual machines that you can use to create the guest failover cluster. In this step, you create the virtual machine configuration files and the virtual hard disk that is used for the operating system.  
  
**Guest operating system requirements**  
  
You must use [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] for the guest operating system. If you use [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], you must upgrade the Hyper\-V integration services to the [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] version.  
  
> [!NOTE]  
> As a best practice, we recommend that if you create a virtual machine on a failover cluster node, you create it as a highly available virtual machine.  
  
#### To create the virtual machines  
  
1.  From one of the Hyper\-V failover cluster nodes, create two or more highly available virtual machines. To do this, follow Steps 7 and 8 in the topic [Deploy a Hyper-V Cluster](../Topic/Deploy-a-Hyper-V-Cluster.md). When you create the virtual machines, note the following:  
  
    1.  On the **Specify Name and Location** page, select the **Store the virtual machine in a different location** check box, click **Browse**, and then navigate to the shared storage location.  
  
        -   If the shared storage is a CSV disk, navigate to: *C:\\*ClusterStorage\\Volume*X*, where *C:\\* represents the system drive, and *X* represents the volume number.  
  
        -   If the shared storage is an SMB file share, navigate to: \\\\*ServerName\\ShareName*, where *ServerName* represents the client access point for the Scale\-Out File Server, and *ShareName* represents the name of the SMB file share.  
  
    2.  On the **Specify Generation** page, select **Generation 1** or **Generation 2**. Both types of virtual machines are supported. However, if you want to use an existing virtual hard disk that is in the .vhd file format, you must use a Generation 1 virtual machine.  
  
        > [!NOTE]  
        > The virtual hard disk for the operating system can use the .vhd or the .vhdx file format.  
  
    3.  On the **Connect Virtual Hard Disk** page, create a virtual hard disk or use an existing virtual hard disk that resides on shared storage. \(If you use an existing virtual hard disk, the guest operating system must be [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].\) In the **Location** box, specify a CSV path or the SMB file share path.  
  
2.  If you chose to create a virtual hard disk, install an operating system on each virtual machine. You must use [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
3.  Ensure that both virtual machines are running and that they are joined to the same Active Directory domain.  
  
4.  If you installed [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] as the guest operating system, upgrade the Hyper\-V integration services to the [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] version. For information about how to upgrade integration services, see Step 4 of the topic [Install the Hyper\-V Role and Configure a Virtual Machine](http://technet.microsoft.com/library/hh846766.aspx#BKMK_step4).  
  
## Step 3: Create and enable a shared virtual hard disk  
This step shows how to create and then share a virtual hard disk that is in the .vhdx file format. Repeat this step for each shared .vhdx file that you want to add. For example, you may want to add one or more shared disks that will act as data disks, and a separate shared disk that you can designate as the disk witness for the guest failover cluster.  
  
#### To create a virtual hard disk to share  
  
1.  In Failover Cluster Manager, expand the cluster name, and then click **Roles**.  
  
2.  In the **Roles** pane, right\-click the virtual machine on which you want to add a shared virtual hard disk, and then click **Settings**.  
  
3.  In the virtual machine settings, under **Hardware**, click **SCSI Controller**.  
  
4.  In the details pane, click **Hard Drive**, and then click **Add**.  
  
5.  In the **Hard Drive** details pane, under **Virtual hard disk**, click **New**.  
  
    The New Virtual Hard Disk Wizard opens.  
  
6.  On the **Before You Begin** page, click **Next**.  
  
7.  On the **Choose Disk Format** page, accept the default format of **VHDX**, and then click **Next**.  
  
    > [!NOTE]  
    > To share the virtual hard disk, the format must be .vhdx.  
  
8.  On the **Choose Disk Type** page, select **Fixed size** or **Dynamically expanding**, and then click **Next**.  
  
    > [!NOTE]  
    > A differencing disk is not supported for a shared virtual hard disk.  
  
9. On the **Specify Name and Location** page, do the following:  
  
    1.  In the **Name** box, enter the name of the shared virtual hard disk.  
  
    2.  In the **Location** box, enter the path of the shared storage location.  
  
        For Scenario 1, where the shared storage is a CSV disk, enter the path:  
  
        C:\\ClusterStorage\\Volume*X*, where *C:\\* represents the system drive, and *X* represents the desired CSV volume number.  
  
        For Scenario 2, where the shared storage is an SMB file share, specify the path:  
  
        \\\\*ServerName\\ShareName*, where *ServerName* represents the client access point for the Scale\-Out File Server, and *ShareName* represents the name of the SMB file share.  
  
    3.  Click **Next**.  
  
10. On the **Configure Disk** page, accept the default option of **Create a new blank virtual hard disk**, specify the desired size, and then click **Next**.  
  
11. On the **Completing the New Virtual Hard Disk Wizard** page, review the configuration, and then click **Finish**.  
  
    > [!IMPORTANT]  
    > If the virtual machine is running, do not click **Apply** in the virtual machine settings before you continue to the next procedure.  
    >   
    > If you do click **Apply** on a running virtual machine, you will need to stop the virtual machine or remove and then add the virtual hard disk without clicking **Apply**. For more information, see the Note in Step 3 of the following procedure.  
  
#### To share the virtual hard disk  
  
1.  In the virtual machine settings, under **SCSI Controller**, expand the hard drive that you created in the previous procedure.  
  
2.  Click **Advanced Features**.  
  
3.  In the details pane, select the **Enable virtual hard disk sharing** check box.  
  
    > [!NOTE]  
    > If the check box appears dimmed and is unavailable, you can do either of the following:  
    >   
    > -   Remove and then add the virtual hard disk to the running virtual machine. When you do, ensure that you do not click **Apply** when the New Virtual Hard Disk Wizard completes. Instead, immediately configure sharing in **Advanced Features**.  
    > -   Stop the virtual machine, and then select the **Enable virtual hard disk sharing** check box.  
  
4.  Click **Apply**, and then click **OK**.  
  
5.  Add the virtual hard disk to each virtual machine that will use the shared .vhdx file. When you do, repeat this procedure to enable virtual hard disk sharing for each virtual machine that will use the disk.  
  
> [!TIP]  
> To share a virtual hard disk by using Windows PowerShell, use the **Add\-VMHardDiskDrive** cmdlet with the **–ShareVirtualDisk** parameter. You must run this command as an administrator on the Hyper\-V host for each virtual machine that will use the shared .vhdx file.  
>   
> For example, the following command adds a shared virtual hard disk \(*Data1.vhdx*\) on volume 1 of CSV to a virtual machine that is named *VM1*.  
>   
> `Add-VMHardDiskDrive -VMName VM1 -Path C:\ClusterStorage\Volume1\Data1.vhdx -ShareVirtualDisk`  
>   
> The following command adds a shared virtual hard disk \(*Witness.vhdx*\) that is stored on an SMB file share \(\\\\*Server1\\Share1*\) to a virtual machine that is named *VM2*.  
>   
> `Add-VMHardDiskDrive -VMName VM2 -Path \\Server1\Share1\Witness.vhdx -ShareVirtualDisk`  
  
## Step 4: Create the guest cluster  
This step shows how to verify that the shared .vhdx files show up as shared storage when you create the guest cluster.  
  
#### To create the guest cluster and verify the shared storage  
  
1.  On one of the virtual machines, in Server Manager or in Disk Management, confirm that the shared .vhdx file is visible as a disk. Bring the disk online, initialize the disk, and then create and format the volume.  
  
2.  Create the guest cluster by adding the virtual machines as cluster nodes. When you create the cluster, add all eligible storage. \(The shared .vhdx files will be added as available storage.\)  
  
3.  After the failover cluster is created, verify that the storage was added. To do this, open Failover Cluster Manager, expand the cluster name, expand **Storage**, and then click **Disks**.  
  
    In the **Disks** pane, verify that the disks appear.  
  
4.  Optionally, add the available storage to CSV. For more information, see the "Add a disk as a CSV to a failover cluster" section of [Use Cluster Shared Volumes in a Failover Cluster](../Topic/Use-Cluster-Shared-Volumes-in-a-Failover-Cluster.md).  
  
