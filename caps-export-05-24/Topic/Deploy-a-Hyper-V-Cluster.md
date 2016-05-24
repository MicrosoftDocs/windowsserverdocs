---
title: Deploy a Hyper-V Cluster
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 636c67f7-de15-4e23-ad6a-119a8d43d819
author: kumudd
---
# Deploy a Hyper-V Cluster
This topic provides steps to configure and deploy a simple two\-node failover cluster and a clustered Hyper\-V virtual machine. By using the Hyper\-V role, you can use a virtualized computing environment to improve the efficiency of your computing resources and improve server availability without using as many physical computers as you would need in a failover cluster configuration that uses only physical computers. The general considerations and steps in this guide can be used to deploy clusters containing a larger number of nodes and a larger number of virtual machines. However, this topic does not provide guidance for deploying or managing specific workloads on clustered virtual machines.  
  
For overviews of the Hyper\-V role and the Failover Clustering feature, see [Hyper\-V Overview](http://technet.microsoft.com/library/hh831531) and [Failover Clustering Overview](http://technet.microsoft.com/library/hh831579).  
  
For an example of a deployment and application monitoring scenario that uses clustered virtual machines, see [High Availability Printing Overview](http://technet.microsoft.com/library/jj556311.aspx).  
  
**In this topic**  
  
-   [Prerequisites](#BKMK_Prereqs)  
  
-   [Limitations](#BKMK_LIMITS)  
  
-   [Step 1: Connect both physical computers to the networks and storage](#BKMK_Step1)  
  
-   [Step 2: Install Hyper\-V and Failover Clustering on both physical computers](#BKMK_Step2)  
  
-   [Step 3: Create a virtual switch](#BKMK_step3)  
  
-   [Step 4: Validate the cluster configuration](#BKMK_step4)  
  
-   [Step 5: Create the cluster](#BKMK_step5)  
  
-   [Step 6: Add a disk as CSV to store virtual machine data](#BKMK_step6)  
  
-   [Step 7: Create a highly available virtual machine](#BKMK_step7)  
  
-   [Step 8: Install the guest operating system on the virtual machine](#BKMK_step8)  
  
-   [Step 9: Test a planned failover](#BKMK_step9)  
  
-   [Step 10: Test an unplanned failover](#BKMK_Step10)  
  
-   [Step 11: Modify the settings of a virtual machine](#BKMK_step11)  
  
-   [Step 12: Remove a virtual machine from a cluster](#BKMK_step12)  
  
> [!NOTE]  
> This topic includes sample [!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlets that you can use to automate some of the procedures described. For more information, see [Starting Windows PowerShell](http://technet.microsoft.com/library/hh857343.aspx).  
  
## Prerequisites  
  
## <a name="BKMK_Prereqs"></a>Prerequisites  
To use the Hyper\-V role on a failover cluster with two nodes, you need the hardware, software, accounts, and network infrastructure that are outlined in the sections that follow.  
  
### Hardware requirements  
For general requirements for the servers, networks, network adapters, storage, and device controllers for storage for Hyper\-V and for failover clusters, see "Hardware requirements" in [Hyper\-V Overview](http://technet.microsoft.com/library/hh831531) and [Failover Clustering Hardware Requirements and Storage Options](http://technet.microsoft.com/library/jj612869).  
  
> [!NOTE]  
> You can use shared storage that is attached, and you can also use SMB 3.0 file shares as shared storage for servers that are running Hyper\-V that are configured in a failover cluster. For more information, see [Deploy Hyper\-V over SMB](http://technet.microsoft.com/library/jj134187.aspx). The steps in this topic assume that you will be using shared storage that is attached to the cluster nodes.  
  
> [!IMPORTANT]  
> Microsoft supports a failover cluster solution only if all the hardware features are marked as "Certified for [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]" or "Certified for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]." In addition, the complete configuration \(servers, network, and storage\) must pass all cluster validation tests. For more information, see [Step 4: Validate the cluster configuration](#BKMK_step4) in this topic and [Validate Hardware for a Failover Cluster](http://technet.microsoft.com/library/jj134244.aspx).  
  
### Software requirements  
For the software requirements for using the Hyper\-V role and the Failover Clustering feature, see [Hyper\-V Overview](http://technet.microsoft.com/library/hh831531) and [Failover Clustering Overview](http://technet.microsoft.com/library/hh831579).  
  
To install the guest operating system that will run on the clustered virtual machine, you will need appropriate installation media for a supported operating system. You can install from a physical media or an image \(.iso\) file. You also can configure the virtual machine by using a virtual hard disk on which an operating system has already been installed. The steps in this topic assume that you will install [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] on the virtual machine.  
  
### Network infrastructure and domain account requirements  
You will need the following network infrastructure for a two\-node failover cluster:  
  
-   **Networks** It is recommended to have a minimum of two networks for your failover cluster: a public network that allows clients to connect to the cluster and a separate network that is used only for communication between the clustered servers. As needed, you can configure additional networks for specific storage options or for redundancy.  
  
-   **Network settings and IP addresses** When you use identical network adapters for a network, also use identical communication settings on those adapters \(for example, Speed, Duplex Mode, Flow Control, and Media Type\). Also, compare the settings between the network adapter and the switch it connects to and make sure that no settings are in conflict.  
  
    If you have private networks that are not routed to the rest of your network infrastructure, ensure that each of these private networks uses a unique subnet. This is necessary even if you give each network adapter a unique IP address. For example, if you have a cluster node in a central office that uses one physical network, and another node in a branch office that uses a separate physical network, do not specify 10.0.0.0\/24 for both networks, even if you give each adapter a unique IP address.  
  
-   **DNS** The servers in the cluster must be using Domain Name System \(DNS\) for name resolution. The DNS dynamic update protocol can be used.  
  
-   **Domain role** All servers in the cluster must be in the same Active Directory domain. As a best practice, all clustered servers should have the same domain role \(either member server or domain controller\). The recommended role is member server. If the clustered servers are member servers, you need an additional server that acts as the domain controller in the domain that contains your cluster.  
  
-   **Clients** As needed, you can connect one or more linked clients to the failover cluster that you create, and then observe the effect on a client when you move or fail over the highly available virtual machine from one cluster node to the other.  
  
To create a cluster or add nodes, you must be logged on to the domain with an account that has administrator rights and permissions on all servers in that cluster. The account does not need to be a Domain Admins account, but can be a Domain Users account that is in the Administrators group on each clustered server. In addition, if the account is not a Domain Admins account, the account \(or the group that the account is a member of\) must be given the Create Computer Objects and Read All Properties permissions in the domain.  
  
## <a name="BKMK_LIMITS"></a>Limitations  
Hyper\-V and failover clusters include the following general limitations:  
  
-   The failover cluster can have a maximum of 64 nodes.  
  
-   You can have a maximum of 8,000 virtual machines per cluster for server computer virtualization, with a maximum of 1,024 virtual machines on a single node, provided that the server hardware has the resources to support them. For example, when Hyper\-V is used together with Virtual Desktop Infrastructure \(VDI\) for client computer virtualization, you can have a maximum of 8,000 VDI \([!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] or [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)]\) virtual machines per cluster, with a maximum of 1,024 on a single node.  
  
For more information about scalability limits for Hyper\-V, see [Hyper-V scalability in Windows Server 2012 and Windows Server 2012 R2](../Topic/Hyper-V-scalability-in-Windows-Server-2012-and-Windows-Server-2012-R2.md).  
  
## <a name="BKMK_Step1"></a>Step 1: Connect both physical computers to the networks and storage  
Use the following instructions to connect your selected servers to networks and storage.  
  
#### To connect the servers to the networks and storage  
  
1.  For details about the kinds of network adapters and device controllers that you can use with a failover cluster, review [Prerequisites](#BKMK_Prereqs), earlier in this topic.  
  
2.  Connect and configure the networks that the servers in the cluster will use.  
  
    > [!NOTE]  
    > If you want to include clients or a non\-clustered domain controller as part of your test configuration, make sure that these computers can connect to the failover cluster servers through at least one network.  
  
3.  Follow the manufacturer's instructions for physically connecting the servers to the storage.  
  
4.  Ensure that the disks \(LUNs\) that you want to use in the cluster are exposed to the servers that you will cluster \(and only those servers\). You can use either of the following interfaces to expose disks or LUNs:  
  
    -   The interface provided by the manufacturer of the storage.  
  
    -   An appropriate iSCSI interface.  
  
5.  If you have purchased software that controls the format or function of the disk, follow the instructions from the vendor about how to use that software with [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
6.  On one of the servers that you want to cluster, in Server Manager or in Disk Management, confirm that the cluster disks are visible.  
  
7.  If you want to have a storage volume larger than 2 terabytes, and you are using the Windows interface to control the format of the disk, convert that disk to the partition style called GUID partition table \(GPT\). To do this, back up any data on the disk, and delete all volumes on the disk. Then, in Disk Management, right\-click the disk \(not a partition\), and click **Convert to GPT Disk**.  
  
    For volumes smaller than 2 terabytes, instead of using GPT, you can use the partition style called master boot record \(MBR\).  
  
    > [!IMPORTANT]  
    > You can use either the MBR or the GPT partition style for a disk that is used by a failover cluster, but you cannot use a disk that you have converted to dynamic by using Disk Management.  
  
8.  Check the format of any exposed volume or LUN. We recommend NTFS for the format \(for the quorum witness disk, you can use NTFS or ReFS\).  
  
## <a name="BKMK_Step2"></a>Step 2: Install Hyper\-V and Failover Clustering on both physical computers  
To install the Hyper\-V role and the Failover Clustering feature on each physical computer, see the following procedures:  
  
-   [Add the Hyper\-V role](http://technet.microsoft.com/library/hh846766#BKMK_Step1) in "Install the Hyper\-V Role and Configure a Virtual Machine."  
  
-   [Installing the Failover Cluster Feature and Tools in Windows Server 2012](http://blogs.msdn.com/b/clustering/archive/2012/04/06/10291601.aspx)  
  
## <a name="BKMK_step3"></a>Step 3: Create a virtual switch  
Perform this step on both physical computers if you did not create the virtual switch when you installed the Hyper\-V role. This virtual switch provides the highly available virtual machine with access to the physical network.  
  
#### To create a virtual switch  
  
1.  Open Hyper\-V Manager.  
  
2.  From the **Actions** menu, click **Virtual Switch Manager**.  
  
3.  Under **Create virtual switch**, select **External**.  
  
4.  Click **Create Virtual Switch**. The **New Virtual Switch** page appears.  
  
5.  Type a name for the new switch. Make sure you use exactly the same name on both servers running Hyper\-V.  
  
6.  Under **Connection Type**, click **External network**, and then select the physical network adapter.  
  
7.  Click **OK** to save the virtual network and close Virtual Switch Manager.  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]  
  
The following example creates the external switch *VMExternalSwitch*, which binds to the network adapter *Wired Ethernet Connection 3* and allows the management operating system to share the network adapter.  
  
```  
New-VMSwitch "VMExternalSwitch" –NetAdapterName "Wired Ethernet Connection 3" –AllowManagementOS  
```  
  
## <a name="BKMK_step4"></a>Step 4: Validate the cluster configuration  
Before you create the cluster, we strongly recommend that you run a full validation test of your cluster configuration by running the Validate a Configure Wizard in Failover Cluster Manager, or the [!INCLUDE[wps_2](../Token/wps_2_md.md)][Test\-Cluster](http://technet.microsoft.com/library/hh847274.aspx) cmdlet. Specific validation tests are included for the configuration of the Hyper\-V role in the failover cluster.  
  
For detailed considerations and steps to validate the cluster, see [Validate Hardware for a Failover Cluster](http://technet.microsoft.com/library/jj134244).  
  
## <a name="BKMK_step5"></a>Step 5: Create the cluster  
To create a failover cluster by using Failover Cluster Manager or the [!INCLUDE[wps_2](../Token/wps_2_md.md)][New\-Cluster](http://technet.microsoft.com/library/hh847246.aspx) cmdlet, see [Creating a Windows Server 2012 Failover Cluster](http://blogs.msdn.com/b/clustering/archive/2012/05/01/10299698.aspx).  
  
## <a name="BKMK_step6"></a>Step 6: Add a disk as CSV to store virtual machine data  
To implement certain scenarios for clustered virtual machines, the virtual machine storage and virtual hard disk file should be configured as Cluster Shared Volumes \(CSV\). To configure a disk in clustered storage as a CSV volume, you can use Failover Cluster Manager or the [!INCLUDE[wps_2](../Token/wps_2_md.md)][Add\-ClusterSharedVolume](http://technet.microsoft.com/library/hh847320.aspx) cmdlet. For detailed planning considerations and steps to create CSV, see [Use Cluster Shared Volumes in a Windows Server 2012 Failover Cluster](http://technet.microsoft.com/library/jj612868).  
  
CSV can enhance the availability and manageability of virtual machines by enabling multiple nodes to concurrently access a single shared storage volume. For example, on a failover cluster that uses CSV, multiple clustered virtual machines that are distributed across multiple cluster nodes can all access their virtual hard disk files at the same time, even if the files are on a single disk \(LUN\) in the storage. This means that the clustered virtual machines can fail over independently of one another, even if they use only a single LUN. CSV also support live migration of a Hyper\-V virtual machine between nodes in a failover cluster.  
  
## <a name="BKMK_step7"></a>Step 7: Create a highly available virtual machine  
In this step, you create a virtual machine and configure it for high availability.  
  
> [!NOTE]  
> You can run the Hyper\-V New Virtual Machine Wizard directly from Failover Cluster Manager. After the virtual machine is created in this way, it is automatically configured for high availability.  
  
### Considerations for creating a virtual machine that will be highly available  
  
-   Starting in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], we do not support the configuration where there is more than one virtual machine in a virtual machine clustered role. An example of this is a scenario where multiple virtual machines have files on a common physical disk that is not part of CSV. A single virtual machine per clustered role improves the management experience and the functionality of virtual machines in a clustered environment, such as virtual machine mobility.  
  
-   Choose the shared storage as the location to store the virtual machine and the virtual hard disk. Otherwise, you will not be able to make the virtual machine highly available. To make the shared storage available to the virtual machine, you must create the virtual machine on the physical computer that is the node which owns the storage.  
  
-   If you created a CSV volume in [Step 6: Add a disk as CSV to store virtual machine data](#BKMK_step6), in the settings for the virtual hard disk, specify the CSV volume as the location of both the virtual machine and the virtual hard disk.  
  
-   Ensure that you select a virtual hard disk option that is appropriate for the method you are using to install the guest operating system on the virtual machine \(for example, from physical media or from an .iso file\).  
  
##### To create a highly available virtual machine  
  
1.  In Failover Cluster Manager, select or specify the cluster that you want. Ensure that the console tree under the cluster is expanded.  
  
2.  Click **Roles**.  
  
3.  In the **Actions** pane, click **Virtual Machines**, and then click **New Virtual Machine**. The New Virtual Machine Wizard appears. Click **Next**.  
  
4.  On the **Specify Name and Location** page, specify a name for the virtual machine, such as *FailoverTest*. Click **Store the virtual machine in a different location**, and then type the full path or click **Browse** and navigate to the shared storage.  
  
5.  On the **Assign Memory** page, specify the amount of memory required for the operating system that will run on this virtual machine. For example, specify 1024 MB to run [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
6.  On the **Configure Networking** page, connect the network adapter to the virtual switch that is associated with the physical network adapter. You should specify the virtual switch that you configured in [Step 3: Create a virtual switch](#BKMK_step3).  
  
7.  On the **Connect Virtual Hard Disk** page, click **Create a virtual hard disk**. If you want to change the name, type a new a name for the virtual hard disk. Click **Next**.  
  
8.  On the **Installation Options** page, click **Install an operating system from a boot CD\/DVD\-ROM**. Under **Media**, specify the location of the media, and then click **Finish**.  
  
    The virtual machine is created. The High Availability Wizard in Failover Cluster Manager then automatically configures the virtual machine for high availability.  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]  
  
The following example creates the virtual machine *FailoverTest*, specifying that it will be installed from a .iso file, and configures it for high availability.  
  
```  
New-VHD -Path <PathToVHDXFile> -Dynamic -SizeBytes 127GB  
New-VM -Name FailoverTest -Path <PathToVMFolder> -Memory 1GB –SwitchName "VMExternalSwitch" –BootDevice CD -VHDPath <PathToVHDXFile>  
Add-VMDvdDrive -VMName FailoverTest –Path <PathtoISOFile>  
Set-VM –Name FailoverTest –AutomaticStartAction Nothing  
Add-ClusterVirtualMachineRole -VirtualMachine FailoverTest  
  
```  
  
## <a name="BKMK_step8"></a>Step 8: Install the guest operating system on the virtual machine  
You then start the clustered virtual machine that you configured in [Step 7: Create a highly available virtual machine](#BKMK_step7). This installs the guest operating system \(which, in this topic, is assumed to be [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]\). To do this, see [Step 3: Install the guest operating system](http://technet.microsoft.com/library/hh846766#BKMK_step3) in “Install the Hyper\-V Role and Configure a Virtual Machine.”  
  
> [!NOTE]  
> If you are installing an operating system other than [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] on a [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] Hyper\-V host, or an operating system other than [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] on a [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Hyper\-V host, you might also need to install Hyper\-V integration services for the operating system.  
  
## <a name="BKMK_step9"></a>Step 9: Test a planned failover  
To test a planned failover, you can move the clustered virtual machine that you created in [Step 7: Create a highly available virtual machine](#BKMK_step7) to another node.  
  
You have the following options to move a clustered virtual machine:  
  
-   **Live migration** Move ownership of the clustered virtual machine to another node without pausing the role.  
  
-   **Quick migration** Pause the virtual machine, save state, move the role to another node, and start the virtual machine on the other node.  
  
-   **Storage migration** Move only the virtual machine data to other clustered storage.  
  
For example, to test a planned failover by performing a live migration, you can use Failover Cluster Manager or the [!INCLUDE[wps_2](../Token/wps_2_md.md)][Move\-ClusterVirtualMachineRole](http://technet.microsoft.com/library/hh847292.aspx) cmdlet.  
  
#### To test a planned failover  
  
1.  In Failover Cluster Manager, select or specify the cluster that you want. Ensure that the console tree under the cluster is expanded.  
  
2.  To select the destination node for live migration of the clustered virtual machine, right\-click *FailoverTest* \(the clustered virtual machine that you configured in [Step 7: Create a highly available virtual machine](#BKMK_step7)\), point to **Move**, point to **Live Migration**, and then click **Select Node**.  
  
    As the *FailoverTest* virtual machine is moved, the status is displayed in the results pane \(center pane\). Optionally, you can repeat this step to move the virtual machine to an additional node or back to the original node.  
  
3.  Verify that the move succeeded by inspecting the details of each node.  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]  
  
The following example live migrates the virtual machine *FailoverTest* to the node *ContosoFCNode2*.  
  
```  
Move-ClusterVirtualMachineRole -Name "FailoverTest" –Node ContosoFCNode2  
  
```  
  
## <a name="BKMK_Step10"></a>Step 10: Test an unplanned failover  
To test an unplanned failover of the clustered virtual machine, you can stop the Cluster service on the node that owns the clustered virtual machine.  
  
#### To test an unplanned failover  
  
1.  In Failover Cluster Manager, select or specify the cluster that you want. Ensure that the console tree under the cluster is expanded.  
  
2.  To minimize disruption to clients, before stopping the Cluster service on a node, move the clustered roles that are currently owned by that node \(other than *FailoverTest*\) to another node by doing the following:  
  
    1.  Expand the console tree under the cluster that you want to manage, and then expand **Nodes**.  
  
    2.  Select the node that owns the clustered virtual machine *FailoverTest* \(the clustered virtual machine that you configured in [Step 7: Create a highly available virtual machine](#BKMK_step7)\).  
  
    3.  Select all of the clustered roles on the node, except *FailoverTest*.  
  
    4.  To select the destination node for the selected clustered roles, right\-click the roles, point to **Move**, and then click **Select Node**  
  
    It might take several minutes to move the clustered roles to the destination node.  
  
3.  Expand the console tree under **Nodes**.  
  
4.  Right\-click the node that owns *FailoverTest*, point to **More Actions**, and then click **Stop Cluster Service**.  
  
    The virtual machine moves to the other node. There might be a short delay while this happens.  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]  
  
The following example stops the Cluster service on *ContosoFCNode2*, the node that owns the clustered virtual machine *FailoverTest*.  
  
```  
Stop-ClusterNode –Name ContosoFCNode2  
  
```  
  
## <a name="BKMK_step11"></a>Step 11: Modify the settings of a virtual machine  
To modify the configuration of a virtual machine, you can use the Failover Clustering tools or the Hyper\-V tools to access the settings. We recommend that you use the Failover Clustering tools to access the virtual machine settings. When you do this, the cluster is updated automatically after you apply the new settings, and you are able to modify all of the virtual machine settings. However, if you make changes to the virtual machine settings by using the Hyper\-V tools directly, you must update the cluster manually after you make the changes, and you will be prevented from modifying certain virtual machine settings or performing actions that could conflict with settings for the failover cluster. In addition, if the configuration is not refreshed after changes are made, a subsequent failover may not succeed, or it may succeed but the virtual machine will then be configured incorrectly.  
  
> [!NOTE]  
> To modify certain virtual machine settings, you may be prompted to first shut down the virtual machine.  
  
#### To modify the settings of a virtual machine  
  
1.  In Failover Cluster Manager, select or specify the cluster that you want. Ensure that the console tree under the cluster is expanded.  
  
2.  If you need to shut down the virtual machine before modifying the settings, expand **Roles**, right\-click *FailoverTest*\(the clustered virtual machine that you configured in [Step 7: Create a highly available virtual machine](#BKMK_step7)\), and then click **Shut Down**.  
  
3.  Right\-click *FailoverTest*, and then click **Settings**. The Settings page for the virtual machine appears.  
  
4.  Configure the settings for the virtual machine, and then click **OK**.  
  
    The virtual machine configuration is updated in the failover cluster.  
  
5.  If you previously shut down the clustered virtual machine, right\-click *FailoverTest*, point to **More Actions**, and then click **Start Role**.  
  
Use the following procedure to manually refresh the virtual machine configuration in the failover cluster  
  
#### To manually refresh the virtual machine configuration in the failover cluster  
  
1.  In Failover Cluster Manager, select or specify the cluster that you want. Ensure that the console tree under the cluster is expanded.  
  
2.  Right\-click *FailoverTest* \(the clustered virtual machine that you configured in [Step 7: Create a highly available virtual machine](#BKMK_step7)\), point to **More Actions**, and then click **Refresh Virtual Machine Configuration**.  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]  
  
The following example refreshes the configuration of the clustered virtual machine *FailoverTest*.  
  
```  
Update-ClusterVirtualMachineConfiguration –Name "FailoverTest"  
  
```  
  
## <a name="BKMK_step12"></a>Step 12: Remove a virtual machine from a cluster  
When you want to remove a virtual machine from a cluster, the procedure you need to use varies depending on whether you want to keep the virtual machine and its files. This step illustrates both scenarios.  
  
#### Scenario A: To remove a virtual machine from a cluster and retain the virtual machine  
  
1.  Use Failover Cluster Manager to take the virtual machine offline. Under **Roles**, right\-click *FailoverTest* \(the clustered virtual machine that you configured in [Step 7: Create a highly available virtual machine](#BKMK_step7)\), point to **More Actions**, and then click **Stop Role**.  
  
2.  Optionally, export the virtual machine. Exporting a virtual machine allows you to move the virtual machine to another server running Hyper\-V, such as a non\-clustered server. To do this:  
  
    1.  Switch to Hyper\-V Manager and verify that the *FailoverTest* virtual machine is selected.  
  
    2.  Under **Actions**, click **Export**.  
  
    3.  Type or browse to specify a location in which to export the virtual machine, and then click **Export**.  
  
    > [!IMPORTANT]  
    > If you plan to import the virtual machine to another cluster, use either Hyper\-V Manager or Microsoft System Center Virtual Machine Manager. If you import a virtual machine using Hyper\-V Manager, afterwards, configure the virtual machine by using the High Availability Wizard in Failover Cluster Manager, or the [!INCLUDE[wps_2](../Token/wps_2_md.md)][Add\-ClusterVirtualMachineRole](http://technet.microsoft.com/library/hh847259.aspx) cmdlet.  
  
3.  In Hyper\-V Manager, verify that the *FailoverTest* virtual machine is selected. Under **Actions**, click **Delete**.  
  
4.  In Failover Cluster Manager. expand **Roles**, right\-click *FailoverTest*, and then click **Remove**.  
  
    The virtual machine is removed from the cluster.  
  
#### Scenario B: To remove a virtual machine from a cluster and delete the virtual machine  
  
1.  Use Failover Cluster Manager to take the virtual machine offline. Under **Roles**, right\-click *FailoverTest* \(the clustered virtual machine that you configured in [Step 7: Create a highly available virtual machine](#BKMK_step7)\), point to **More Actions**, and then click **Stop Role**.  
  
2.  Switch to Hyper\-V Manager and select the *FailoverTest* virtual machine. Under **Actions**, click **Delete**.  
  
3.  In Failover Cluster Manager, expand **Roles**, right\-click *FailoverTest*, and then click **Remove**.  
  
    The virtual machine is removed from the cluster.  
  
4.  Manually delete the virtual machine and the virtual hard disk from the shared storage.  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Hyper\-V Overview](http://technet.microsoft.com/library/hh831531)  
  
-   [Failover Clustering Overview](http://technet.microsoft.com/library/hh831579)  
  
-   [System Center 2012 – Virtual Machine Manager](http://technet.microsoft.com/library/gg610610.aspx)  
  
