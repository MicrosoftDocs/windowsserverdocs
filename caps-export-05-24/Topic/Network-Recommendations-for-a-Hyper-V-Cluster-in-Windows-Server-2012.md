---
title: Network Recommendations for a Hyper-V Cluster in Windows Server 2012
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4fb79ef2-829d-4313-a82a-f35d2e9b45e7
author: KBDAzure
---
# Network Recommendations for a Hyper-V Cluster in Windows Server 2012
There are several different types of network traffic that you must consider and plan for when you deploy a highly available Hyper\-V solution. You should design your network configuration with the following goals in mind:  
  
-   To ensure network quality of service  
  
-   To provide network redundancy  
  
-   To isolate traffic to defined networks  
  
-   Where applicable, take advantage of Server Message Block \(SMB\) Multichannel  
  
This topic provides network configuration recommendations that are specific to a Hyper\-V cluster that is running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. It includes an overview of the different network traffic types, recommendations for how to isolate traffic, recommendations for features such as NIC Teaming, Quality of Service \(QoS\) and Virtual Machine Queue \(VMQ\), and a Windows PowerShell script that shows an example of converged networking, where the network traffic on a Hyper\-V cluster is routed through one external virtual switch.  
  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] supports the concept of converged networking, where different types of network traffic share the same Ethernet network infrastructure. In previous versions of Windows Server, the typical recommendation for a failover cluster was to dedicate separate physical network adapters to different traffic types. Improvements in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], such as Hyper\-V QoS and the ability to add virtual network adapters to the management operating system enable you to consolidate the network traffic on fewer physical adapters. Combined with traffic isolation methods such as VLANs, you can isolate and control the network traffic.  
  
> [!IMPORTANT]  
> If you use System Center Virtual Machine Manager \(VMM\) to create or manage Hyper\-V clusters, you must use VMM to configure the network settings that are described in this topic.  
  
**In this topic:**  
  
-   [Overview of different network traffic types traffic](#BKMK_Overview)  
  
-   [How to isolate the network traffic on a Hyper\-V cluster](#BKMK_Isolate)  
  
-   [NIC Teaming recommendations](#BKMK_NICTeam)  
  
-   [Quality of Service \(QoS\) recommendations](#BKMK_QoS)  
  
-   [Virtual Machine Queue \(VMQ\) recommendations](#BKMK_VMQ)  
  
-   [Example of converged networking: routing traffic through one Hyper\-V virtual switch](#BKMK_Example)  
  
-   [Appendix: Encryption](#BKMK_Appendix)  
  
## <a name="BKMK_Overview"></a>Overview of different network traffic types  
When you deploy a Hyper\-V cluster, you must plan for several types of network traffic. The following table summarizes the different traffic types.  
  
|Network Traffic Type|Description|  
|------------------------|---------------|  
|Management|-   Provides connectivity between the server that is running Hyper\-V and basic infrastructure functionality.<br />-   Used to manage the Hyper\-V management operating system and virtual machines.|  
|Cluster|-   Used for inter\-node cluster communication such as the cluster heartbeat and Cluster Shared Volumes \(CSV\) redirection.|  
|Live migration|-   Used for virtual machine live migration.|  
|Storage|-   Used for SMB traffic or for iSCSI traffic.|  
|Replica traffic|-   Used for virtual machine replication through the Hyper\-V Replica feature.|  
|Virtual machine access|-   Used for virtual machine connectivity.<br />-   Typically requires external network connectivity to service client requests.|  
  
The following sections provide more detailed information about each network traffic type.  
  
### Management traffic  
A management network provides connectivity between the operating system of the physical Hyper\-V host \(also known as the *management operating system*\) and basic infrastructure functionality such as Active Directory Domain Services \(AD DS\), Domain Name System \(DNS\), and Windows Server Update Services \(WSUS\). It is also used for management of the server that is running Hyper\-V and the virtual machines.  
  
The management network must have connectivity between all required infrastructure, and to any location from which you want to manage the server.  
  
### Cluster traffic  
A failover cluster monitors and communicates the cluster state between all members of the cluster. This communication is very important to maintain cluster health. If a cluster node does not communicate a regular health check \(known as the *cluster heartbeat*\), the cluster considers the node down and removes the node from cluster membership. The cluster then transfers the workload to another cluster node.  
  
Inter\-node cluster communication also includes traffic that is associated with CSV. For CSV, where all nodes of a cluster can access shared block\-level storage simultaneously, the nodes in the cluster must communicate to orchestrate storage\-related activities.  Also, if a cluster node loses its direct connection to the underlying CSV storage, CSV has resiliency features which redirect the storage I\/O over the network to another cluster node that can access the storage.  
  
### Live migration traffic  
Live migration enables the transparent movement of running virtual machines from one Hyper\-V host to another without a dropped network connection or perceived downtime.  
  
We recommend that you use a dedicated network or VLAN for live migration traffic to ensure quality of service and for traffic isolation and security. Live migration traffic can saturate network links. This can cause other traffic to experience increased latency.  The time it takes to fully migrate one or more virtual machines depends on the throughput of the live migration network. Therefore, you must ensure that you configure the appropriate quality of service for this traffic. To provide the best performance, live migration traffic is not encrypted.  
  
You can designate multiple networks as live migration networks in a prioritized list. For example, you may have one migration network for cluster nodes in the same cluster that is fast \(10 GB\), and a second migration network for cross\-cluster migrations that is slower \(1 GB\).  
  
All Hyper\-V hosts that can initiate or receive a live migration must have connectivity to a network that is configured to allow live migrations. Because live migration can occur between nodes in the same cluster, between nodes in different clusters, and between a cluster and a stand\-alone Hyper\-V host, make sure that all these servers can access a live migration\-enabled network.  
  
### Storage traffic  
For a virtual machine to be highly available, all members of the Hyper\-V cluster must be able to access the virtual machine state. This includes the configuration state and the virtual hard disks. To meet this requirement, you must have shared storage.  
  
In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], there are two ways that you can provide shared storage:  
  
-   **Shared block storage**. Shared block storage options include Fibre Channel, Fibre Channel over Ethernet \(FCoE\), iSCSI, and shared Serial Attached SCSI \(SAS\).  
  
-   **File\-based storage**. Remote file\-based storage is provided through SMB 3.0.  
  
SMB 3.0 includes new functionality known as SMB Multichannel. SMB Multichannel automatically detects and uses multiple network interfaces to deliver high performance and highly reliable storage connectivity.  
  
By default, SMB Multichannel is enabled, and requires no additional configuration. You should use at least two network adapters of the same type and speed so that SMB Multichannel is in effect. Network adapters that support RDMA \(Remote Direct Memory Access\) are recommended but not required.  
  
SMB 3.0 also automatically discovers and takes advantage of available hardware offloads, such as RDMA. A feature known as SMB Direct supports the use of network adapters that have RDMA capability. SMB Direct provides the best performance possible while also reducing file server and client overhead.  
  
> [!NOTE]  
> The NIC Teaming feature is incompatible with RDMA\-capable network adapters. Therefore, if you intend to use the RDMA capabilities of the network adapter, do not team those adapters.  
  
Both iSCSI and SMB use the network to connect the storage to cluster members. Because reliable storage connectivity and performance is very important for Hyper\-V virtual machines, we recommend that you use multiple networks \(physical or logical\) to ensure that these requirements are achieved.  
  
> [!NOTE]  
> For more information about SMB Direct and SMB Multichannel, see [Improve Performance of a File Server with SMB Direct](http://technet.microsoft.com/library/jj134210.aspx) and [The basics of SMB Multichannel, a feature of Windows Server 2012 and SMB 3.0](http://blogs.technet.com/b/josebda/archive/2012/06/28/the-basics-of-smb-multichannel-a-feature-of-windows-server-2012-and-smb-3-0.aspx).  
  
### Replica traffic  
Hyper\-V Replica provides asynchronous replication of Hyper\-V virtual machines between two hosting servers or Hyper\-V clusters. Replica traffic occurs between the primary and Replica sites.  
  
Hyper\-V Replica automatically discovers and uses available network interfaces to transmit replication traffic. To throttle and control the replica traffic bandwidth, you can define QoS policies with minimum bandwidth weight.  
  
If you use certificate\-based authentication, Hyper\-V Replica encrypts the traffic. If you use Kerberos\-based authentication, traffic is not encrypted.  
  
### Virtual machine access traffic  
Most virtual machines require some form of network or Internet connectivity. For example, workloads that are running on virtual machines typically require external network connectivity to service client requests. This can include tenant access in a hosted cloud implementation. Because multiple subclasses of traffic may exist, such as traffic that is internal to the datacenter and traffic that is external \(for example to a computer outside the datacenter or to the Internet\); one or more networks are required for these virtual machines to communicate.  
  
To separate virtual machine traffic from the management operating system, we recommend that you use VLANs which are not exposed to the management operating system.  
  
## <a name="BKMK_Isolate"></a>How to isolate the network traffic on a Hyper\-V cluster  
To provide the most consistent performance and functionality, and to improve network security, we recommend that you isolate the different types of network traffic.  
  
> [!NOTE]  
> Realize that if you want to have a physical or logical network that is dedicated to a specific traffic type, you must assign each physical or virtual network adapter to a unique subnet. For each cluster node, Failover Clustering recognizes only one IP address per subnet.  
  
### Isolate traffic on the management network  
We recommend that you use a firewall or IPsec encryption, or both, to isolate management traffic. In addition, you can use auditing to ensure that only defined and allowed communication is transmitted through the management network.  
  
### Isolate traffic on the cluster network  
To isolate inter\-node cluster traffic, you can configure a network to either allow cluster network communication or not to allow cluster network communication. For a network that allows cluster network communication, you can also configure whether to allow clients to connect through the network. \(This includes client and management operating system access.\)  
  
A failover cluster can use any network that allows cluster network communication for cluster monitoring, state communication, and for CSV\-related communication.  
  
To configure a network to allow or not to allow cluster network communication, you can use Failover Cluster Manager or Windows PowerShell. To use Failover Cluster Manager, click **Networks** in the navigation tree. In the **Networks** pane, right\-click a network, and then click **Properties**.  
  
![](../Image/FC_MgmtNetwork.JPG)  
  
**Figure 1. Failover Cluster Manager network properties**  
  
The following Windows PowerShell example configures a network named *Management Network* to allow cluster and client connectivity.  
  
```  
(Get-ClusterNetwork -Name "Management Network").Role = 3  
  
```  
  
The **Role** property has the following possible values.  
  
|Value|Network Setting|  
|---------|-------------------|  
|0|Do not allow cluster network communication|  
|1|Allow cluster network communication only|  
|3|Allow cluster network communication and client connectivity|  
  
The following table shows the recommended settings for each type of network traffic. Realize that virtual machine access traffic is not listed because these networks should be isolated from the management operating system by using VLANs that are not exposed to the host. Therefore, virtual machine networks should not appear in Failover Cluster Manager as cluster networks.  
  
|Network Type|Recommended Setting|  
|----------------|-----------------------|  
|Management|Both of the following:<br /><br />-   Allow cluster network communication on this network<br />-   Allow clients to connect through this network|  
|Cluster|Allow cluster network communication on this network **Note:** Clear the **Allow clients to connect through this network** check box.|  
|Live migration|Allow cluster network communication on this network **Note:** Clear the **Allow clients to connect through this network** check box.|  
|Storage|Do not allow cluster network communication on this network|  
|Replica traffic|Both of the following:<br /><br />-   Allow cluster network communication on this network<br />-   Allow clients to connect through this network|  
  
### Isolate traffic on the live migration network  
By default, live migration traffic uses the cluster network topology to discover available networks and to establish priority. However, you can manually configure live migration preferences to isolate live migration traffic to only the networks that you define. To do this, you can use Failover Cluster Manager or Windows PowerShell. To use Failover Cluster Manager, in the navigation tree, right\-click **Networks**, and then click **Live Migration Settings**.  
  
![](../Image/FC_LMSettings.JPG)  
  
**Figure 2. Live migration settings in Failover Cluster Manager**  
  
The following Windows PowerShell example enables live migration traffic only on a network that is named *Migration\_Network*.  
  
```  
Get-ClusterResourceType -Name "Virtual Machine" | Set-ClusterParameter -Name MigrationExcludeNetworks -Value ([String]::Join(";",(Get-ClusterNetwork | Where-Object {$_.Name -ne "Migration_Network"}).ID))  
  
```  
  
### Isolate traffic on the storage network  
To isolate SMB storage traffic, you can use Windows PowerShell to set SMB Multichannel constraints. SMB Multichannel constraints restrict SMB communication between a given file server and the Hyper\-V host to one or more defined network interfaces.  
  
For example, the following Windows PowerShell command sets a constraint for SMB traffic from the file server *FileServer1* to the network interfaces *SMB1*, *SMB2*, *SMB3*, and *SMB4* on the Hyper\-V host from which you run this command.  
  
```  
New-SmbMultichannelConstraint -ServerName "FileServer1" -InterfaceAlias "SMB1", "SMB2", "SMB3", "SMB4"  
  
```  
  
> [!NOTE]  
> -   You must run this command on each node of the Hyper\-V cluster.  
> -   To find the interface name, use the **Get\-NetAdapter** cmdlet.  
  
For more information, see [New\-SmbMultichannelConstraint](http://technet.microsoft.com/library/jj635699.aspx).  
  
To isolate iSCSI traffic, configure the iSCSI target with interfaces on a dedicated network \(logical or physical\). Use the corresponding interfaces on the cluster nodes when you configure the iSCSI initiator.  
  
### Isolate traffic for replication  
To isolate Hyper\-V Replica traffic, we recommend that you use a different subnet for the primary and Replica sites.  
  
If you want to isolate the replica traffic to a particular network adapter, you can define a persistent static route which redirects the network traffic to the defined network adapter. To specify a static route, use the following command:  
  
**route add <destination> mask <subnet mask and gateway> if <interface> \-p**  
  
For example, to add a static route to the 10.1.17.0 network \(example network of the Replica site\) that uses a subnet mask of 255.255.255.0, a gateway of 10.0.17.1 \(example IP address of the primary site\), where the interface number for the adapter that you want to dedicate to replica traffic is 8, run the following command:  
  
**route add 10.1.17.1 mask 255.255.255.0 10.0.17.1 if 8 \-p**  
  
## <a name="BKMK_NICTeam"></a>NIC Teaming \(LBFO\) recommendations  
We recommend that you team physical network adapters in the management operating system. This provides bandwidth aggregation and network traffic failover if a network hardware failure or outage occurs.  
  
The NIC Teaming feature, also known as load balancing and failover \(LBFO\), provides two basic sets of algorithms for teaming.  
  
-   **Switch\-dependent modes**. Requires the switch to participate in the teaming process. Typically requires all the network adapters in the team to be connected to the same switch.  
  
-   **Switch\-independent modes**. Does not require the switch to participate in the teaming process. Although not required, team network adapters can be connected to different switches.  
  
Both modes provide for bandwidth aggregation and traffic failover if a network adapter failure or network disconnection occurs. However, in most cases only switch\-independent teaming provides traffic failover for a switch failure.  
  
NIC Teaming also provides a traffic distribution algorithm that is optimized for Hyper\-V workloads. This algorithm is referred to as the *Hyper\-V port* load balancing mode. This mode distributes the traffic based on the MAC address of the virtual network adapters. The algorithm uses round robin as the load\-balancing mechanism. For example, on a server that has two teamed physical network adapters and four virtual network adapters, the first and third virtual network adapter will use the first physical adapter, and the second and fourth virtual network adapter will use the second physical adapter. Hyper\-V port mode also enables the use of hardware offloads such as virtual machine queue \(VMQ\) which reduces CPU overhead for networking operations.  
  
**Recommendations**  
  
For a clustered Hyper\-V deployment, we recommend that you use the following settings when you configure the additional properties of a team.  
  
|Property Name|Recommended Setting|  
|-----------------|-----------------------|  
|Teaming mode|Switch Independent \(the default setting\)|  
|Load balancing mode|Hyper\-V Port|  
  
> [!NOTE]  
> NIC teaming will effectively disable the RDMA capability of the network adapters. If you want to use SMB Direct and the RDMA capability of the network adapters, you should not use NIC Teaming.  
  
For more information about the NIC Teaming modes and how to configure NIC Teaming settings, see [Windows Server 2012 NIC Teaming \(LBFO\) Deployment and Management](http://www.microsoft.com/download/details.aspx?id=30160) and [NIC Teaming Overview](http://technet.microsoft.com/library/hh831648.aspx).  
  
## <a name="BKMK_QoS"></a>Quality of Service \(QoS\) recommendations  
You can use QoS technologies that are available in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to meet the service requirements of a workload or an application. QoS provides the following:  
  
-   Measures network bandwidth, detects changing network conditions \(such as congestion or availability of bandwidth\), and prioritizes \- or throttles \- network traffic.  
  
-   Enables you to converge multiple types of network traffic on a single adapter.  
  
-   Includes a minimum bandwidth feature which guarantees a certain amount of bandwidth to a given type of traffic.  
  
We recommend that you configure appropriate Hyper\-V QoS on the virtual switch to ensure that network requirements are met for all appropriate types of network traffic on the Hyper\-V cluster.  
  
> [!NOTE]  
> You can use QoS to control outbound traffic, but not the inbound traffic. For example, with Hyper\-V Replica, you can use QoS to control outbound traffic \(from the primary server\), but not the inbound traffic \(from the Replica server\).  
  
**Recommendations**  
  
For a Hyper\-V cluster, we recommend that you configure Hyper\-V QoS that applies to the virtual switch. When you configure QoS, do the following:  
  
-   **Configure minimum bandwidth in weight mode instead of in bits per second.** Minimum bandwidth specified by weight is more flexible and it is compatible with other features, such as live migration and NIC Teaming. For more information, see the **MinimumBandwidthMode** parameter in [New\-VMSwitch](http://technet.microsoft.com/library/hh848455.aspx).  
  
-   **Enable and configure QoS for all virtual network adapters.** Assign a weight to all virtual adapters. For more information, see [Set\-VMNetworkAdapter](http://technet.microsoft.com/library/hh848457.aspx). To make sure that all virtual adapters have a weight, configure the **DefaultFlowMinimumBandwidthWeight** parameter on the virtual switch to a reasonable value. For more information, see [Set\-VMSwitch](http://technet.microsoft.com/library/hh848515(v=wps.620).aspx).  
  
The following table recommends some generic weight values. You can assign a value from 1 to 100. For guidelines to consider when you assign weight values, see [Guidelines for using Minimum Bandwidth](http://technet.microsoft.com/library/jj735303.aspx#bkmk_guidelines).  
  
|Network Classification|Weight|  
|--------------------------|----------|  
|Default weight|0|  
|Virtual machine access|1, 3 or 5 \(low, medium and high\-throughput virtual machines\)|  
|Cluster|10|  
|Management|10|  
|Replica traffic|10|  
|Live migration|40|  
|Storage|40|  
  
## <a name="BKMK_VMQ"></a>Virtual machine queue \(VMQ\) recommendations  
Virtual machine queue \(VMQ\) is a feature that is available to computers that have VMQ\-capable network hardware. VMQ uses hardware packet filtering to deliver packet data from an external virtual network directly to virtual network adapters. This reduces the overhead of routing packets.  When VMQ is enabled, a dedicated queue is established on the physical network adapter for each virtual network adapter that has requested a queue.  
  
Not all physical network adapters support VMQ. Those that do support VMQ will have a fixed number of queues available, and the number will vary. To determine whether a network adapter supports VMQ, and how many queues they support, use the [Get\-NetAdapterVmq](http://technet.microsoft.com/library/jj130881.aspx) cmdlet.  
  
You can assign virtual machine queues to any virtual network adapter. This includes virtual network adapters that are exposed to the management operating system. Queues are assigned according to a weight value, in a first\-come first\-serve manner. By default, all virtual adapters have a weight of 100.  
  
**Recommendations**  
  
We recommend that you increase the VMQ weight for interfaces with heavy inbound traffic, such as storage and live migration networks. To do this, use the [Set\-VMNetworkAdapter](http://technet.microsoft.com/library/hh848457.aspx) Windows PowerShell cmdlet.  
  
## <a name="BKMK_Example"></a>Example of converged networking: routing traffic through one Hyper\-V virtual switch  
The following Windows PowerShell script shows an example of how you can route traffic on a Hyper\-V cluster through one Hyper\-V external virtual switch. The example uses two physical 10 GB network adapters that are teamed by using the NIC Teaming feature. The script configures a Hyper\-V cluster node with a management interface, a live migration interface, a cluster interface, and four SMB interfaces. After the script, there is more information about how to add an interface for Hyper\-V Replica traffic. The following diagram shows the example network configuration.  
  
![](../Image/FCClusterNetworks.jpg)  
  
**Figure 3. Example Hyper\-V cluster network configuration**  
  
The example also configures network isolation which restricts cluster traffic from the management interface, restricts SMB traffic to the SMB interfaces, and restricts live migration traffic to the live migration interface.  
  
```  
# Create a network team using switch independent teaming and Hyper-V port mode  
New-NetLbfoTeam "PhysicalTeam" –TeamMembers "10GBPort1", "10GBPort2" –TeamNicName "PhysicalTeam" -TeamingMode SwitchIndependent -LoadBalancingAlgorithm HyperVPort  
  
# Create a Hyper-V virtual switch connected to the network team  
# Enable QoS in Weight mode  
New-VMSwitch "TeamSwitch" –NetAdapterName "PhysicalTeam" –MinimumBandwidthMode Weight –AllowManagementOS $false  
  
# Configure the default bandwidth weight for the switch  
# Ensures all virtual NICs have a weight  
Set-VMSwitch -Name "TeamSwitch" -DefaultFlowMinimumBandwidthWeight 0  
  
# Create virtual network adapters on the management operating system  
# Connect the adapters to the virtual switch  
# Set the VLAN associated with the adapter  
# Configure the VMQ weight and minimum bandwidth weight  
Add-VMNetworkAdapter –ManagementOS –Name "Management" –SwitchName "TeamSwitch"  
Set-VMNetworkAdapterVlan -ManagementOS -VMNetworkAdapterName "Management" -Access -VlanId 10  
Set-VMNetworkAdapter -ManagementOS -Name "Management" -VmqWeight 80 -MinimumBandwidthWeight 10  
  
Add-VMNetworkAdapter –ManagementOS –Name "Cluster" –SwitchName "TeamSwitch"  
Set-VMNetworkAdapterVlan -ManagementOS -VMNetworkAdapterName "Cluster" -Access -VlanId 11  
Set-VMNetworkAdapter -ManagementOS -Name "Cluster" -VmqWeight 80 -MinimumBandwidthWeight 10  
  
Add-VMNetworkAdapter –ManagementOS –Name "Migration" –SwitchName "TeamSwitch"  
Set-VMNetworkAdapterVlan -ManagementOS -VMNetworkAdapterName "Migration" -Access -VlanId 12  
Set-VMNetworkAdapter -ManagementOS -Name "Migration" -VmqWeight 90 -MinimumBandwidthWeight 40  
  
Add-VMNetworkAdapter –ManagementOS –Name "SMB1" –SwitchName "TeamSwitch"  
Set-VMNetworkAdapterVlan -ManagementOS -VMNetworkAdapterName "SMB1" -Access -VlanId 13  
Set-VMNetworkAdapter -ManagementOS -Name "SMB1" -VmqWeight 100 -MinimumBandwidthWeight 40  
  
Add-VMNetworkAdapter –ManagementOS –Name "SMB2" –SwitchName "TeamSwitch"  
Set-VMNetworkAdapterVlan -ManagementOS -VMNetworkAdapterName "SMB2" -Access -VlanId 14  
Set-VMNetworkAdapter -ManagementOS -Name "SMB2" -VmqWeight 100 -MinimumBandwidthWeight 40  
  
Add-VMNetworkAdapter –ManagementOS –Name "SMB3" –SwitchName "TeamSwitch"  
Set-VMNetworkAdapterVlan -ManagementOS -VMNetworkAdapterName "SMB3" -Access -VlanId 15  
Set-VMNetworkAdapter -ManagementOS -Name "SMB3" -VmqWeight 100 -MinimumBandwidthWeight 40  
  
Add-VMNetworkAdapter –ManagementOS –Name "SMB4" –SwitchName "TeamSwitch"  
Set-VMNetworkAdapterVlan -ManagementOS -VMNetworkAdapterName "SMB4" -Access -VlanId 16  
Set-VMNetworkAdapter -ManagementOS -Name "SMB4" -VmqWeight 100 -MinimumBandwidthWeight 40  
  
# Rename the cluster networks if desired  
(Get-ClusterNetwork | Where-Object {$_.Address -eq "10.0.10.0"}).Name = "Management_Network"  
(Get-ClusterNetwork | Where-Object {$_.Address -eq "10.0.11.0"}).Name = "Cluster_Network"  
(Get-ClusterNetwork | Where-Object {$_.Address -eq "10.0.12.0"}).Name = "Migration_Network"  
(Get-ClusterNetwork | Where-Object {$_.Address -eq "10.0.13.0"}).Name = "SMB_Network1"  
(Get-ClusterNetwork | Where-Object {$_.Address -eq "10.0.14.0"}).Name = "SMB_Network2"  
(Get-ClusterNetwork | Where-Object {$_.Address -eq "10.0.15.0"}).Name = "SMB_Network3"  
(Get-ClusterNetwork | Where-Object {$_.Address -eq "10.0.16.0"}).Name = "SMB_Network4"  
  
# Configure the cluster network roles  
(Get-ClusterNetwork -Name "Management_Network").Role = 3  
(Get-ClusterNetwork -Name "Cluster_Network").Role = 1  
(Get-ClusterNetwork -Name "Migration_Network").Role = 1  
(Get-ClusterNetwork -Name "SMB_Network1").Role = 0  
(Get-ClusterNetwork -Name "SMB_Network2").Role = 0  
(Get-ClusterNetwork -Name "SMB_Network3").Role = 0  
(Get-ClusterNetwork -Name "SMB_Network4").Role = 0  
  
# Configure an SMB Multichannel constraint  
# This ensures that SMB traffic from the named server only uses SMB interfaces  
New-SmbMultichannelConstraint -ServerName "FileServer1" -InterfaceAlias "vEthernet (SMB1)", "vEthernet (SMB2)", "vEthernet (SMB3)", "vEthernet (SMB4)"  
  
# Configure the live migration network  
Get-ClusterResourceType -Name "Virtual Machine" | Set-ClusterParameter -Name MigrationExcludeNetworks -Value ([String]::Join(";",(Get-ClusterNetwork | Where-Object {$_.Name -ne "Migration_Network"}).ID))  
  
```  
  
**Hyper\-V Replica considerations**  
  
If you also use Hyper\-V Replica in your environment, you can add another virtual network adapter to the management operating system for replica traffic. For example:  
  
```  
Add-VMNetworkAdapter –ManagementOS –Name "Replica" –SwitchName "TeamSwitch"  
Set-VMNetworkAdapterVlan -ManagementOS -VMNetworkAdapterName "Replica" –Access –VlanId 17  
Set-VMNetworkAdapter -ManagementOS -Name "Replica" -VmqWeight 80 -MinimumBandwidthWeight 10  
  
# If the host is clustered – configure the cluster name and role  
(Get-ClusterNetwork | Where-Object {$_.Address -eq "10.0.17.0"}).Name = "Replica"  
(Get-ClusterNetwork -Name "Replica").Role = 3  
  
```  
  
> [!NOTE]  
> If you are instead using policy\-based QoS, where you can throttle outgoing traffic regardless of the interface on which it is sent, you can use either of the following methods to throttle Hyper\-V Replica traffic:  
>   
> -   Create a QoS policy that is based on the destination subnet. In this example, the Replica site uses the 10.1.17.0\/24 subnet.  
>   
>     ```  
>     New-NetQosPolicy "Replica traffic to 10.1.17.0" –DestinationAddress 10.1.17.0/24 –MinBandwidthWeightAction 40  
>   
>     ```  
> -   Create a QoS policy that is based on the destination port. In the following example, the network listener on the Replica server or cluster has been configured to use port 8080 to receive replication traffic.  
>   
>     ```  
>     New-NetQosPolicy "Replica traffic to 8080" –DestinationPort 8080 –ThrottleRateActionBitsPerSecond 100000  
>   
>     ```  
  
## <a name="BKMK_Appendix"></a>Appendix: Encryption  
  
### Cluster traffic  
By default, cluster communication is not encrypted. You can enable encryption if you want. However, realize that there is performance overhead that is associated with encryption. To enable encryption, you can use the following Windows PowerShell command to set the security level for the cluster.  
  
```  
(Get-Cluster). SecurityLevel = 2  
```  
  
The following table shows the different security level values.  
  
|Security Description|Value|  
|------------------------|---------|  
|Clear text|0|  
|Signed \(default\)|1|  
|Encrypted|2|  
  
### Live migration traffic  
Live migration traffic is not encrypted. You can enable IPsec or other network layer encryption technologies if you want. However, realize that encryption technologies typically affect performance.  
  
### SMB traffic  
By default, SMB traffic is not encrypted. Therefore, we recommend that you use a dedicated network \(physical or logical\) or use encryption. For SMB traffic, you can use SMB encryption, layer\-2 or layer\-3 encryption. SMB encryption is the preferred method.  
  
### Replica traffic  
If you use Kerberos\-based authentication, Hyper\-V Replica traffic is not encrypted. We strongly recommend that you encrypt replication traffic that transits public networks over the WAN or the Internet. We recommend Secure Sockets Layer \(SSL\) encryption as the encryption method. You can also use IPsec. However, realize that using IPsec may significantly affect performance.  
  
## See also  
  
-   [Failover Cluster Networking Essentials \(video\)](http://channel9.msdn.com/Events/TechEd/NorthAmerica/2013/MDC-B337#fbid=esw7e4Omfy5)  
  
