---
title: Using Guest Clustering for High Availability
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 839c30af-d036-42d1-a0f6-dcc82d61717a
author: kumudd
---
# Using Guest Clustering for High Availability
A failover cluster that is made up of two or more virtual machines is typically referred to as a *guest cluster*. Guest clustering supports high availability for workloads within the virtual machine. This topic includes planning and deployment information that is specific to a guest cluster scenario.  
  
Besides the traditional benefits of virtualization, deploying a clustered application \(known as a *clustered role*\) inside a virtual machine provides the following additional value:  
  
-   **Proactive health monitoring of the clustered roles**. For each clustered role, there are several associated resources such as a resource for the application, the storage, and networking. The cluster continuously monitors each resource to verify that it is functioning. If the cluster detects a failure, it initiates automatic recovery steps. For example, the cluster may move the clustered role or fail it over to another node.  
  
-   **Application mobility**. You can easily move clustered roles to other nodes. In a guest cluster, you can move a clustered role to another node to service the virtual machine while the application stays in production. For example, you can apply updates or change the configuration, restart the virtual machine, and verify that it functions correctly without interrupting the availability of the application.  
  
    > [!NOTE]  
    > Starting in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], you can use the Cluster\-Aware Updating feature to automate the updating of guest cluster nodes. For more information, see [Cluster\-Aware Updating Overview](http://technet.microsoft.com/library/hh831694.aspx).  
  
-   **Protection from host failure**. You can place guest cluster nodes on different physical hosts to protect against physical host failure. If a guest cluster node becomes unavailable because of physical host failure, another guest cluster node automatically detects the situation. It then brings any clustered roles that were running on the unavailable node online. This preserves the availability of the clustered roles. Note that this functionality is especially valuable if the virtual machines are not running on hosts that are part of a Hyper\-V failover cluster.  
  
-   **Virtual machine mobility**. If you run your clustered applications on virtual machines, you can choose to deploy them to any host that supports the virtual machine. To move a virtual machine to another host, you can live migrate the virtual machine. This provides flexibility and the ability to optimize resources on the Hyper\-V hosts.  
  
## <a name="BKMK_PhysicalHost"></a>Physical host considerations  
To increase the availability of a guest cluster workload, you must also consider the physical hosts on which the virtual machines will run.  
  
### <a name="BKMK_HostCluster"></a>Deploy a guest cluster on a physical host cluster  
Although not required, to provide extra resiliency we recommend that you deploy virtual machines that are part of a guest cluster on a Hyper\-V host cluster instead of on stand\-alone computers that are running Hyper\-V.  
  
Consider the following scenario:  
  
1.  A two node guest cluster \(Guest1 and Guest2\) runs on a three node physical host cluster \(Host1, Host2, and Host3\). Guest1 runs on Host1. Guest2 runs on Host2.  
  
2.  Host1 suddenly fails. The guest cluster fails over any roles that were running on Guest1 to Guest2. This quickly brings the role back online and makes the workload available to clients.  
  
3.  Because Guest1 is on a physical host cluster, the Guest1 virtual machine automatically moves and starts on another host. If Guest2 has problems, Guest1 is available again for the roles to fail over to it.  
  
In this scenario, if Guest1 was instead running on a stand\-alone host, the virtual machine would be unavailable until Host1 was brought back online and the virtual machine started. If there was an issue such as a hardware failure, the virtual machine could be unavailable for a lengthy period.  
  
### <a name="BKMK_AntiAffinity"></a>Place the virtual machines on different physical hosts  
We recommend that you place virtual machines that are part of the same guest cluster on different physical hosts. This enables the failover of the workload to a running guest cluster node if there is a host failure. The surviving guest cluster node detects the loss of the other node and starts the clustered roles. This shortens the recovery time and increases the availability of the workload.  
  
If all nodes of the guest cluster are on the same host and a host failure occurs, after the host recovers you must restart at least one of the virtual machines to make the workload available. To avoid this situation, you can configure the cluster to place virtual machines on different physical nodes of the cluster. To do this, use either of the following methods:  
  
-   Use Windows PowerShell to set the **AntiAffinityClassNames** property for each virtual machine role that is part of the same guest cluster to the same text string. **AntiAffinityClassNames** is a property of a cluster group. For more information, see [AntiAffinityClassNames](http://msdn.microsoft.com/library/windows/desktop/aa369651(v=vs.85).aspx), and the example in this section.  
  
-   If you use System Center Virtual Machine Manager \(VMM\), you can configure anti\-affinity by using availability sets. For more information, see [How to Configure Availability Sets in VMM for Virtual Machines on a Host Cluster](http://technet.microsoft.com/library/jj628165.aspx).  
  
    > [!NOTE]  
    > This functionality is available starting in System Center 2012 Service Pack 1.  
  
When the cluster must fail over clustered roles or move a virtual machine to another node, it checks all clustered roles on the destination node to determine whether any of the roles have the same string value set for the **AntiAffinityClassNames** property. If a role on the destination node has the same string value, the cluster targets another node and does the same check until it finds a node that can host the virtual machine. If there is no available node except for one with a role that has the same string value, the cluster places the virtual machine on a node with a matching string value.  
  
**Example of how to set anti\-affinity**  
  
The following Windows PowerShell example shows how to view the **AntiAffinityClassNames** property value for a clustered virtual machine that is named "*VM1*", and how to set the property value to the string "*GuestCluster1*." You must set this property to the same string on each virtual machine that is a member of the same guest cluster.  
  
To view the current **AntiAffinityClassNames** property value for a guest cluster node that is named "*VM1*," type the following command:  
  
```  
Get-ClusterGroup VM1 | fl anti*  
```  
  
To set the **AntiAffinityClassNames** property value to the string "*GuestCluster1*," type the following command:  
  
```  
(Get-ClusterGroup VM1).AntiAffinityClassNames = "GuestCluster1"  
```  
  
To confirm the property value for *VM1*, type the following command again:  
  
```  
Get-ClusterGroup VM1 | fl anti*  
```  
  
## <a name="BKMK_GuestCluster"></a>Guest cluster considerations for deployment and management  
The deployment and management of a guest cluster is very similar to a physical host cluster. You would follow the same steps to create a guest cluster. Before you install an application on the guest cluster, check if there is a deployment guide that outlines specific requirements and recommendations for running the application in a virtual machine.  
  
If you use [!INCLUDE[vmmblue_1](../Token/vmmblue_1_md.md)], realize that it includes a new feature to deploy guest clusters. You can use service templates to create the virtual machines and to create a [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] guest cluster that uses shared virtual hard disk \(.vhdx\) files as storage. For more information, see [How to Create a Guest Cluster by Using a Service Template in VMM](http://technet.microsoft.com/library/dn249412.aspx).  
  
### <a name="BKMK_Support"></a>Support requirements  
The requirements for Microsoft Customer Service and Support to officially support a guest cluster are the same as for clusters that run directly on physical hardware. This includes the requirement to pass all cluster validation tests. For more information, see [Validate Hardware for a Windows Server 2012 Failover Cluster](http://technet.microsoft.com/library/jj134244.aspx) and [The Microsoft support policy for Windows Server 2012 failover clusters](http://support.microsoft.com/kb/2775067).  
  
To receive support for the Windows Server operating system or for server features that are running on a virtual machine, you must use a supported hypervisor. \(Note that [Microsoft's Life Cycle Support policy](http://support.microsoft.com/common/international.aspx?RDPATH=%2fdefault.aspx%3fpr%3dlifecycle) still applies to the guest operating system.\) If you do not use Hyper\-V, Microsoft requires that the hypervisor is validated and listed in the Microsoft Windows Server Catalog under the Server Virtualization Validation Program \(SVVP\). For more information, see [Server Virtualization Validation Program](http://www.windowsservercatalog.com/svvp.aspx?svvppage=svvp.htm) and the [Server Virtualization Validation Program FAQ](http://www.windowsservercatalog.com/svvp.aspx?svvppage=svvpfaq.htm).  
  
### <a name="BKMK_NodeLimit"></a>Node limit  
The same 64\-node limit applies to physical host clusters and to guest clusters that are running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. The number of nodes that you deploy depends on the clustered role. For example, if you have a database role on physical servers that is deployed on more than two nodes to spread out the instances, you can emulate this environment by using more than two nodes of a guest cluster to host the instances.  
  
Realize that although deploying virtual machines has significant cost savings over dedicated physical servers, each virtual machine consumes CPU, memory, and other system resources that could be otherwise provisioned to other virtual machines. Therefore, do not add more nodes to a guest cluster than needed.  
  
### <a name="BKMK_AD"></a>Active Directory domain requirements  
Failover clusters require that nodes of the same cluster are members of the same Active Directory domain. However, there is no requirement that a guest cluster belongs to the same Active Directory domain as the physical hosts on which the virtual machines are running.  
  
### <a name="BKMK_Storage"></a>Storage options  
The following tables lists the storage types that you can use to provide shared storage for a guest cluster.  
  
|Storage Type|Description|  
|----------------|---------------|  
|Shared virtual hard disk|New in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], you can configure multiple virtual machines to connect to and use a single virtual hard disk \(.vhdx\) file. Each virtual machine can access the virtual hard disk just like servers would connect to the same LUN in a storage area network \(SAN\). For more information, see [Deploy a Guest Cluster Using a Shared Virtual Hard Disk](http://technet.microsoft.com/library/dn265980.aspx).|  
|Virtual Fibre Channel|Introduced in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], virtual Fibre Channel enables you to connect virtual machines to LUNs on a Fibre Channel SAN. For more information, see [Hyper\-V Virtual Fibre Channel Overview](http://technet.microsoft.com/library/hh831413.aspx).|  
|iSCSI|The iSCSI initiator inside a virtual machine enables you to connect over the network to an iSCSI target. For more information, see [iSCSI Target Block Storage Overview](http://technet.microsoft.com/library/hh848272.aspx) and the blog post [Introduction of iSCSI Target in Windows Server 2012](http://blogs.technet.com/b/filecab/archive/2012/05/21/introduction-of-iscsi-target-in-windows-server-2012.aspx).|  
  
Storage requirements depend on the clustered roles that run on the cluster. Most clustered roles use clustered storage, where the storage is available on any cluster node that runs a clustered role. Examples of clustered storage include Physical Disk resources and Cluster Shared Volumes \(CSV\). Some roles do not require storage that is managed by the cluster. For example, you can configure Microsoft SQL Server to use availability groups that replicate the data between nodes. Other clustered roles may use Server Message Block \(SMB\) shares or Network File System \(NFS\) shares as data stores that any cluster node can access.  
  
### <a name="BKMK_Network"></a>Network considerations  
Failover clusters, whether physical or virtual, have networking requirements for communication between the nodes and to provide client network connectivity.  
  
**Network redundancy**  
  
To achieve the goal of high availability, avoid single points of failure whenever possible. For networking, you can use NIC Teaming to protect against network adapter failures. Also, connect network adapters to different switches to provide tolerance for switch and port failures.  
  
For guest clusters, consider the following scenarios when you plan for network redundancy:  
  
-   **Physical host NIC Teaming**. In this scenario, the host has multiple network adapters in a teamed configuration. You would configure Hyper\-V with a single virtual switch that uses the team.  
  
-   **NIC Teaming inside the virtual machines**. In this scenario, the physical host provides more than one virtual network that has external connectivity. \(Make sure that the virtual network adapters are connected to different external switches.\) You then use NIC Teaming inside the virtual machine to provide failover between the networks if there is a connection failure.  
  
    > [!IMPORTANT]  
    > To use NIC Teaming inside a virtual machine, you must also configure each Hyper\-V switch port that is associated with the virtual machine to allow teaming. To do this, open the virtual machine settings in Hyper\-V Manager. In the **Advanced Features** of each network adapter, under **NIC Teaming**, select the **Enable this network adapter to be part of a team in the guest operating system** check box. Or, you can use the following Windows PowerShell command:  
    >   
    > `Set-VMNetworkAdapter –VMName VMName –AllowTeaming On`  
  
Because most failures occur at the infrastructure level, it is best to provide resiliency for the physical host. You can use NIC Teaming inside the guest virtual machines when you do not have NIC Teaming at the physical host level. For more information about NIC Teaming, see [NIC Teaming Overview](http://technet.microsoft.com/library/hh831648.aspx).  
  
**Number of networks**  
  
When you deploy a guest cluster, you must consider the following general categories of network communication. Each has slightly different requirements.  
  
|Traffic Type|Description|  
|----------------|---------------|  
|Client access|Most cluster deployments have clustered roles that provide services to users or to other systems. For instance, most database applications have client applications that store and retrieve records or other information. This type of communication typically requires routing to other subnets and a default gateway.|  
|Cluster communication|The Cluster service and other cluster components such as Cluster Shared Volumes \(CSV\) use one or more networks to transfer information between nodes. For this communication, the cluster can use private networks that have no gateway or routed networks.|  
|Storage|Clustered roles may require storage that can be accessed from any node of the cluster. If you use SMB file shares or iSCSI targets for the guest cluster, both use Ethernet networks to connect to the storage.|  
  
Realize that there are different ways to provide these requirements. These include the following:  
  
-   **Separate networks for each category**. Some guest cluster deployments may have one or more virtual networks for each type of network traffic. This emulates the common physical network configuration for failover clusters. There is a network for client access \(preferably teamed\) that has a default gateway and is routable, a network that is on a non\-routed subnet for communications between cluster nodes, and if storage uses a network, one or more network adapters that use either NIC Teaming or Multipath I\/O \(MPIO\) for resiliency.  
  
-   **Converged networking**. In this scenario you use one virtual network for all networking I\/O on the guest cluster virtual machines. Because the network is shared for all types of network traffic, you should configure QoS policies on the physical host to make sure that the cluster and CSV traffic has reserved bandwidth to meet I\/O demands. For more information, see the "Hyper\-V QoS" section of [Policy\-based QoS and Hyper\-V QoS](http://technet.microsoft.com/library/hh831679.aspx#bkmk_policy), and the "4 NICs in two NIC teams" example in [QoS Common Configurations](http://technet.microsoft.com/library/jj735302.aspx#bkmk_3).  
  
    > [!NOTE]  
    > When you run cluster validation tests on a cluster with a single network adapter, the networking test reports a warning about lack of redundancy. This warning does not prevent you from deploying the cluster or from receiving support. It is provided to make sure that you understand the importance of redundancy.  
  
**Protect against short\-term network interruptions**  
  
Failover cluster nodes use the network to send heartbeat packets to other nodes of the cluster. If a node does not receive a response from another node for a specified period of time, the cluster removes the node from cluster membership. By default, a guest cluster node is considered down if it does not respond within 5 seconds. Other nodes that are members of the cluster will take over any clustered roles that were running on the removed node.  
  
Typically, during the live migration of a virtual machine there is a fast final transition when the virtual machine is stopped on the source node and is running on the destination node. However, if something causes the final transition to take longer than the configured heartbeat threshold settings, the guest cluster considers the node to be down even though the live migration eventually succeeds. If the live migration final transition is completed within the TCP time\-out interval \(typically around 20 seconds\), clients that are connected through the network to the virtual machine seamlessly reconnect.  
  
To make the cluster heartbeat time\-out more consistent with the TCP time\-out interval, you can change the **SameSubnetThreshold** and **CrossSubnetThreshold** cluster properties from the default of 5 seconds to 20 seconds. By default, the cluster sends a heartbeat every 1 second. The threshold specifies how many heartbeats to miss in succession before the cluster considers the cluster node to be down.  
  
> [!IMPORTANT]  
> Do not increase the heartbeat threshold from its default value for a Scale\-Out File Server. A Scale\-Out File Server already provides seamless recovery. If a node is considered down, the node fails over and recovers the SMB sessions on another node. This recovery action needs to occur within the SMB session time\-out period. If you increase the heartbeat threshold, node detection will take longer. If it exceeds the SMB session time\-out values, the recovery may no longer be seamless.  
  
The following example shows how to use Windows PowerShell to view the **CrossSubnetThreshold** and **SameSubnetThreshold** cluster properties, and how to change the values for each to 20.  
  
To view the current property values, type the following command:  
  
```  
Get-Cluster | fl *subnet*  
```  
  
To set the values of the **CrossSubnetThreshold** and **SameSubnetThreshold** properties to 20, type the following commands:  
  
```  
(Get-Cluster).CrossSubnetThreshold = 20  
(Get-Cluster).SameSubnetThreshold = 20  
```  
  
To confirm the property values, type the following command again:  
  
```  
Get-Cluster | fl *subnet*  
```  
  
## <a name="BKMK_Links"></a>See also  
  
-   [High Availability Solutions \(SQL Server\)](http://technet.microsoft.com/library/ms190202.aspx)  
  
-   [Failover Clustering Overview](assetId:///6eeffe4f-3558-495b-bcea-c640fe4d6c49)  
  
