---
title: Configure Live Migration
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 66b608ef-b056-4aa3-be20-19de30a37d4a
author: cwatsonmsft
---
# Configure Live Migration
This guide describes how to configure your network to use the live migration feature of Hyper\-V. It provides a detailed list of the networking configuration requirements for optimal performance and reliability, as well as recommendations for scenarios that do not meet these requirements.  
  
For information about the complete requirements for using Hyper\-V with Cluster Shared Volumes, see[Hyper\-V: Using Live Migration with Cluster Shared Volumes in Windows Server 2008 R2](http://go.microsoft.com/fwlink/?LinkId=164729) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=164729\).  
  
## Hyper\-V live migration network requirements  
The following recommendations will help you configure your networking environment for using live migration:  
  
-   **Network adapters**. For each node of the failover cluster, use more than one network adapter and configure at least one network adapter for the private network. We recommend that you configure separate dedicated networks with gigabit or faster speed for live migration traffic and cluster communication, and these networks should be separate from the network used by the management operating system, and from the network used by the virtual machines. For information about the network traffic that can occur on a network used for Cluster Shared Volumes, see “Understanding redirected I\/O mode in CSV communication” in [Requirements for Using Cluster Shared Volumes in a Failover Cluster in Windows Server 2008 R2](http://go.microsoft.com/fwlink/?LinkId=182153) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=182153\).  
  
    Each node must also have a network adapter that carries Cluster Shared Volumes communication. **Client for Microsoft Networks** and **File and Printer Sharing for Microsoft Networks** must be enabled in the network adapter properties to support SMB, which is a requirement for Cluster Shared Volumes. For more information on the network used for CSV communication, see [Managing the network used for Cluster Shared Volumes](assetId:///47666237-c938-4fa7-9cb5-b098f7884c3b#BKMK_manageCSVnetworks).  
  
-   **Hardware and system settings**. It is required that the storage configuration and hardware on the failover cluster be identical and that the cluster nodes used for live migration have processors by the same manufacturer. If this is not possible, it is recommended that the hardware and system settings are as similar as possible to minimize potential problems.  
  
-   **Security policies**. If possible, do not apply IPsec policies on a private network for live migration because this can significantly impact the performance of live migration. However, IPsec should be implemented when the live migration traffic needs to be encrypted.  
  
-   **IP subnet configuration**. Ensure that the virtual network on the source and destination nodes \(for the live migration\) in the failover cluster is connected through the same IP subnet. This is so the virtual machine can retain the same IP address after live migration. For each network in a failover cluster where Cluster Shared Volumes is enabled, all nodes must be on the same logical subnet, which means that multisite clusters that use Cluster Shared Volumes must use a VLAN.  
  
-   For storage network recommendations, you should review the guidelines provided by your storage vendor.  
  
### Scenarios for using live migration without the required network configuration  
When your environment does not have the full set of network configuration requirements, the following list identifies some additional scenarios for using live migration:  
  
-   You plan to deploy Hyper\-V in a production environment, and you would prefer to first test how the live migration feature works using your existing hardware. You would like to understand the network requirements for live migration before you acquire the hardware necessary for optimal performance.  
  
-   You have several blade servers in your enterprise environment, which, in general, do not include as many network adapters as other servers. You would like to use the live migration feature of Hyper\-V, so that the virtual machines do not experience any downtime because your servers are updated and load balanced.  
  
## Identifying the network access needs for live migration  
Live migration requires failover clustering and shared storage. It is recommended that you use Cluster Shared Volumes on an iSCSI or a Fibre Channel storage area network \(SAN\) or on Serial Attached SCSI \(SAS\) storage to provide shared access for optimal manageability. The following table provides a list of the network access recommendations for Hyper\-V.  
  
|Network access type|Purpose of the network access type|Network traffic requirements|Recommended network access|  
|-----------------------|--------------------------------------|--------------------------------|------------------------------|  
|Storage|Access storage through iSCSI or Fibre Channel \(Fibre Channel does not need a network adapter\).|High bandwidth and low latency.|Usually, dedicated and private access. Refer to your storage vendor for guidelines.|  
|Virtual machine access|Workloads running on virtual machines usually require external network connectivity to service client requests.|Varies|Public access which could be teamed for link aggregation or to fail over the cluster.|  
|Management|Managing the Hyper\-V management operating system. This network is used by Hyper\-V Manager or System Center Virtual Machine Manager \(VMM\).|Low bandwidth|Public access, which could be teamed to fail over the cluster.|  
|Cluster and Cluster Shared Volumes|Preferred network used by the cluster for communications to maintain cluster health. Also, used by Cluster Shared Volumes to send data between owner and non\-owner nodes. If storage access is interrupted, this network is used to access the Cluster Shared Volumes or to maintain and back up the Cluster Shared Volumes.<br /><br />The cluster should have access to more than one network for communication to ensure the cluster is highly available.|Usually low bandwidth and low latency. Occasionally, high bandwidth.|Private access|  
|Live migration|Transfer virtual machine memory and state.|High bandwidth and low latency during migrations.|Private access|  
  
## Networking considerations for live migration  
When planning a network configuration to use for live migration, you should review the following list of networking recommendations. These will help you design the best possible configuration for environments that do not have the required hardware configuration for live migration.  
  
-   Because specific storage networking requirements are not included in this guide, you should refer to your storage vendor’s recommendations. In addition, you can review the [Windows Server Storage Guidelines](http://go.microsoft.com/fwlink/?LinkID=161361) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=161361\).  
  
-   It is recommended that all network configurations should isolate cluster\/Cluster Shared Volumes and live migration on private networks.  
  
-   We recommend that you do not use the same network adapter for virtual machine access and management. If you are limited by the number of network adapters, you should configure a VLAN to isolate traffic. VLAN recommendations include 802.1q and 802.p. For more information, see [Configuring Virtual Networks](http://go.microsoft.com/fwlink/?LinkID=131362) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=131362\).  
  
-   If you are leveraging network configurations that use converged networking or network sharing technologies, refer to your vendor documentation for instructions on how to configure virtual network adapters that will be exposed to Hyper\-V management operating system.  
  
-   Bandwidth throttling may need to be adjusted for specific network configurations. The bandwidth throttling that is outlined in the following table provides control only for the outgoing traffic of a physical network adapter. To ensure end\-to\-end QoS and optimal network performance, refer to the QoS documentation from your network switch and router provider.  
  
-   If TCP Chimney is enabled in the Hyper\-V management operating system, the QoS configuration outlined in this guide will not work. This is because QoS is applied in the software stack of the network adapter driver, so when the TCP Chimney Offload feature is active, the network adapter driver processes the network packets and bypasses any QoS settings.  
  
-   If you have teamed network adapters that are available to the Hyper\-V management operating system, the QoS configuration that is discussed in this guide should work, as long as the teaming software exposes an aggregated virtual network adapter. Refer to your network teaming vendor for additional information.  
  
-   References to teamed network adapters in the following table refer specifically to link aggregation. Any requirements to use teamed network adapters for failover clustering should be added separately.  
  
-   The bandwidth capping values in the following table are examples. You should choose specific values that are appropriate for your network configuration.  
  
The following table details the recommended, supported, and not recommended network configurations for live migration, and is organized in the order in which each network configuration is commonly used. Before reviewing the table, note the following:  
  
-   When a network adapter is connected to a virtual switch, it is referred to as a virtual network adapter.  
  
-   Network access for virtual machines can be on either a public or private network. To allow virtual machines access to computers on the physical network, they must be on a public network. The requirements for virtual machine access vary depending on network I\/O needs and the number of virtual machines you are running on a single physical server.  
  
-   In addition to the preferred network for the cluster and the Cluster Shared Volumes, a cluster can utilize at least one additional network for communication. This increases the high availability of the cluster. The cluster should also be on a private network.  
  
-   If a network configuration is listed as “not recommended” in the following table, it should not be used because the performance of live migrations declines and cluster nodes might crash. Add another network adapter to separate traffic between live migration and Cluster Shared Volumes.  
  
|Host configuration|Virtual machine access|Management|Cluster and Cluster Shared Volumes|Live migration|Comments|  
|----------------------|--------------------------|--------------|--------------------------------------|------------------|------------|  
|4 network adapters with 1 Gbps|Virtual network adapter 1|Network adapter 2|Network adapter 3|Network adapter 4|Recommended|  
|3 network adapters with 1 Gbps; 2 adapters are teamed for link aggregation \(private\)|Virtual network adapter 1|Virtual network adapter 1 with bandwidth capped at 10%|Network adapter 2 \(teamed\)|Network adapter 2 with bandwidth capped at 40% \(teamed\)|Supported|  
|3 network adapters with 1 Gbps|Virtual network adapter 1|Virtual network adapter 1 with bandwidth capped at 10%|Network adapter 2|Network adapter 3|Supported|  
|2 network adapters with 10 Gbps|Virtual network adapter 1|Virtual network adapter 1 with bandwidth capped at 1%|Network adapter 2|Network adapter 2 with bandwidth capped at 50%|Supported\*|  
|2 network adapters with 10 Gbps; 1 network adapter with 1 Gbps|Virtual network adapter 1 \(10 Gbps\)|Network adapter 2 \(1 Gbps\)|Network adapter 3 \(10 Gbps\)|Network adapter 3 with bandwidth capped at 50%|Supported|  
|2 network adapters with 10 Gbps; 2 network adapters with 1 Gbps|Virtual network adapter 1 \(10 Gbps\)|Network adapter 2 \(1 Gbps\)|Network adapter 3 \(1 Gbps\)|Network adapter 4 \(10 Gbps\)|Supported|  
|3 network adapters with 1 Gbps; 2 adapters are teamed for link aggregation \(public\)|Virtual network adapter 1|Virtual network adapter 1 with bandwidth capped at 5%|Network adapter 2 \(teamed\)|Network adapter 2 with bandwidth capped at 90% \(teamed\)|Not recommended|  
|2 network adapters with 1 Gbps|Virtual network adapter 1|Virtual network adapter 1 with bandwidth capped at 10%|Network adapter 2|Network adapter 2 with bandwidth capped at 90%|Not recommended|  
|1 network adapter with 10 Gbps; 1 network adapter with 1 Gbps|Virtual network adapter 1 \(10 Gbps\)|Virtual network adapter 1 with bandwidth capped at 10%|Network adapter 2 \(1 Gbps\)|Network adapter 2 with bandwidth capped at 90%|Not recommended|  
  
\*This configuration is considered recommended if your configuration has a redundant network path available for Cluster and Cluster Shared Volumes communication.  
  
### <a name="BKMK_QoS"></a>Managing bandwidth in the management operating system  
You can manage the use of the bandwidth that is configured for live migration by configuring a QoS policy to limit TCP traffic on port 6600, which is the port that is used for live migration. This ensures that network traffic on TCP port 6600 does not exceed the limit you set. Use the procedure below to create a QoS policy to do this.  
  
##### To create a QoS policy to limit live migration traffic  
  
1.  Click **Start**, type **gpedit.msc** in the **Search programs and files** box, and then press ENTER.  
  
2.  In the console tree under **Local Computer Policy**, expand Computer Configuration, expand **Windows Settings**, right\-click **Policy\-based QoS**, and then click **Create new Policy**.  
  
3.  In **Policy\-based QoS**, under **Policy name**, type a name for the QoS policy that uniquely identifies the policy.  
  
4.  In **Specify Outbound Throttle Rate**, select the check box to enable throttling for outbound traffic, and then specify a value greater than 1 in kilobytes per second \(KBps\) or megabytes per second \(MBps\). For example, enter 115 MBps to limit the traffic for live migration so that it does not exceed 90% of 1 Gbps. Click **Next**.  
  
5.  In **IP Addresses**, by default, **Any source IP address** and **Any destination IP address** are selected. Click **Next**.  
  
6.  In **Application Name**, by default, **All applications** is selected. This applies the throttle rate that you specified to outbound traffic, regardless of the application you are using. Click **Next**.  
  
7.  In **Protocols and Ports**, under **Select the protocol this QoS policy applies to:**, select **TCP** from the drop\-down menu. This applies the throttle rate that you specified to outbound TCP traffic.  
  
8.  Under **Select the source port number:**, select **From any source port**. This applies the throttle rate to outbound traffic, regardless of the source port number of the traffic.  
  
9. Under **Specify the destination port number:**, select **To this destination port number or range**, and then specify 6600 as the port number. This applies the throttle rate that you specified only to traffic with the destination port number or range you specify.  
  
You can configure a QoS policy to limit the network traffic for the IP address used by the management operating system. This ensures that network traffic outbound from the specified IP address does not exceed the limit you set. Use the procedure below to create a QoS policy to do this.  
  
##### To create a QoS policy to limit network traffic for the IP address on the management operating system  
  
1.  Follow Steps 1 through 5 in the procedure “To create a QoS policy to limit live migration traffic.”  
  
2.  In **IP Addresses**, under **This QoS policy applies to:**, select **Only for the following source IP address or prefix:**, and then type the IP address for the management operating system. This applies the throttle rate that you specified to outbound traffic from a source IP address that you specify.  
  
