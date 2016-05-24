---
title: QoS Minimum Bandwidth Best Practices
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a667e387-53af-4f83-b8e5-7ba4c95a82a2
---
# QoS Minimum Bandwidth Best Practices
This topic provides information about configuring QoS Minimum Bandwidth, and includes the following sections.  
  
-   [Guidelines for using Minimum Bandwidth](#bkmk_guidelines)  
  
-   [Minimum Bandwidth Modes](#bkmk_modes)  
  
-   [Minimum Bandwidth and Data Center Bridging \(DCB\)](#bkmk_dcb)  
  
-   [Configuring QoS and NIC Teaming](#bkmk_nicteaming)  
  
-   [Related topics](#bkmk_related)  
  
## <a name="bkmk_guidelines"></a>Guidelines for using Minimum Bandwidth  
Following are guidelines for configuring Minimum Bandwidth.  
  
1.  **Keep the sum of the weights near or under 100**. The larger the value for weight, the higher rounding error or quantization error there is when QoS Packet Scheduler partitions the bandwidth among workloads. The best example to illustrate this guidance is if there are 20 VMs that you want to share the network bandwidth, rather than assigning a weight of 10 to each of them \(in which case the sum would be 200\), assign each VM a weight of 1.  
  
2.  **Assign a relatively large weight to critical workloads even if they don’t require that percentage of bandwidth**. The best example to illustrate this guidance is to think of Management and Cluster heartbeat traffic on a computer that is running the Hyper\-V server role. They rarely require more than 1 or 2 percent of bandwidth over a 10GbE NIC. But they’re critical. So instead of assigning to each of them a weight of 1 or 2, you should assign each a weight of 5 or more.  
  
3.  **Gap the weight assignment to differentiate the level of service to be provided**. In other words, when assigning weight values to VMs, do not use consecutive numbers, such as 1, 2, and 3. For example, if you have VMs named Gold, Silver, and Bronze on the same Hyper\-V Virtual Switch, assign them a respective weight of 5 for Gold, 3 for Silver, and 1 for Bronze \- rather than a weight of 3, 2 and 1, respectively.  
  
4.  **Ensure that traffic that is not specifically filtered out is also accounted for with a weight assignment**. For example, review the configuration [2 NICs without NIC Teaming](../Topic/QoS-Common-Configurations.md#bkmk_1), where Storage, Live Migration, and Cluster are filtered out with a workload\-specific filter. In addition, the rest of the network traffic is grouped with a wild card filter as one single flow that has a weight assignment.  
  
## <a name="bkmk_modes"></a>Minimum Bandwidth Modes  
When you create a Hyper\-V Virtual Switch by using Windows PowerShell, you can choose between one of the following Minimum Bandwidth configuration modes, which determine how you can quantify Minimum Bandwidth for a workload.  
  
-   By weight, which is an integer in the range between 1 and 100  
  
-   By bits per second \(BPS\)  
  
It is recommended that you configure Minimum Bandwidth by using weight rather than BPS. Minimum Bandwidth specified by weight is more flexible and it is compatible with other features, such as Live Migration and NIC Teaming.  
  
For example, consider a VM that is configured to have a Minimum Bandwidth of 500 MBPS. In the Live Migration case, if a destination computer running Hyper\-V doesn’t have 500 MBPS spare bandwidth to satisfy this VM, Live Migration fails because the service is disrupted. If Minimum Bandwidth is specified by weight, this problem does not occur because weight specifies a percentage of bandwidth rather than a specific number of BPS that are required for the traffic. Live\-migrating a VM with a Minimum Bandwidth weight of 3, for example, only increases the sum of the weights by 3 on the destination computer that is running Hyper\-V. In this configuration, the Live Migration service does not fail.  
  
If you must specify minimum bandwidth in an absolute number in BPS, use the following guidelines.  
  
-   The minimum unit is 1% of the link capacity. For example, if a Hyper\-V Virtual Switch is connected to a 10 GB NIC, the minimum amount of bandwidth that you can allocate to a virtual network adapter connected to the switch is 100 MBPS.  
  
-   The number that you specify for BPS is rounded to nearest percent point. For example, 234Mbps is rounded down to 200Mbps, which is 2% of a 10GbE NIC throughput.  
  
When you create a Hyper\-V Virtual Switch by using Windows PowerShell, you can use the –MinimumBandwidthMode parameter of the New\-VMSwitch cmdlet to specify whether Minimum Bandwidth is configured by weight or by BPS. The possible values for the –MinimumBandwidthMode parameter are “Weight,” to specify weight, and “Absolute,” to specify BPS.  
  
The following example Windows PowerShell command illustrates how to create a Hyper\-V Virtual Switch that allows Minimum Bandwidth to be specified by weight.  
  
```  
New-VMSwitch “QoS Switch by Weight” –NetAdapter “External NIC” –MinimumBandwidthMode Weight  
```  
  
The following example Windows PowerShell command illustrates how to create a Hyper\-V Virtual Switch that allows Minimum Bandwidth to be specified by bits per second.  
  
```  
New-VMSwitch “QoS Switch by BPS” –NetAdapter “External NIC” –MinimumBandwidthMode Absolute  
```  
  
For more information, see the Windows PowerShell Hyper\-V reference topic [New\-VMSwitch](http://technet.microsoft.com/library/hh848455.aspx).  
  
## <a name="bkmk_dcb"></a>Minimum Bandwidth and Data Center Bridging \(DCB\)  
Minimum Bandwidth, which is enforced by QoS Packet Scheduler in Windows, and DCB, which is enforced by a capable NIC, have the same functionality – to ensure that a workload receives its fair share of bandwidth when network congestion occurs. QoS Minimum Bandwidth and DCB are not designed to work together, however.  
  
> [!IMPORTANT]  
> Do not enable both Minimum Bandwidth and DCB for workloads that share the same networking stack or NIC.  
  
The figure below illustrates that you can enable either Minimum Bandwidth or DCB on a computer running Hyper\-V, but you cannot enable both technologies at the same time.  
  
![](../Image/qos_mb_01.jpg)  
  
You can enable both Minimum Bandwidth and DCB on one server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] for two separate networking stacks or NICs.  
  
## <a name="bkmk_nicteaming"></a>Configuring QoS and NIC Teaming  
NIC Teaming is a new feature in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. When you configure multiple NICs into a NIC team, the following benefits are provided.  
  
-   Bandwidth aggregation \(i.e. bandwidth distribution across team members\)  
  
-   Traffic failover to maintain connectivity in the event of a network component failure  
  
NIC teaming supports two distribution algorithms.  
  
-   Hyper\-V Virtual Switch port, where the switch port to which a VM’s or the management operating system’s virtual network adapter is connected is used for hashing traffic that is received on the switch port.  
  
-   Address hashing, where the MAC address, the IP address, and the Transport port in the network packet header are used for hashing the traffic.  
  
QoS functionality and NIC Teaming work together in the following ways.  
  
-   **Classification and Tagging**. This QoS feature works seamlessly with NIC Teaming. Network traffic is classified and priority\-tagged by Windows network components before it is hashed to members of a NIC team.  
  
-   **Priority based Flow Control**. This QoS feature works seamlessly with NIC Teaming because PFC occurs at the NIC hardware. It is highly recommended though that it is enabled or disabled consistently across all member NICs of a team.  
  
-   **Bandwidth Management**. The interaction between Bandwidth Management and NIC Teaming is as follows.  
  
    -   **Maximum Bandwidth**. Maximum Bandwidth works seamlessly with NIC Teaming. QoS Packet Scheduler throttles a traffic flow, which can be an application, a service or a workload, before the traffic, which already conforms to the throttling rate, is handed over to NIC Teaming, which hashes it to a team member for transmission.  
  
    -   **Minimum Bandwidth**. As in the case of throttling, QoS Packet Scheduler partitions bandwidth among traffic flows according to the weight assigned to each flow before the traffic is hashed to a team member for transmission. There is a problem, however, when the traffic distribution algorithm of the NIC team that is bound to a Hyper\-V Virtual Switch is Hyper\-V switch port. In such a case, a traffic flow contains all traffic from a VM \(assuming that this VM has only one virtual network adapter\).  
  
        It is possible for NIC Teaming to hash VMs with large weights to one team member and VMs with small weights to another. When that occurs, the amount of bandwidth each VM receives when network congestion occurs does not always reflect the bandwidth weight it is assigned. For example, consider a server that hosts four VMs, two with a minimum bandwidth weight of 3 each and two with a weight of 1 each. If the first two VMs are hashed to one team member of a two\-NIC team and the last two VMs to another team member, essentially each VM gets equal share \(25%\) of the total bandwidth of this NIC team when both team members are congested.  
  
        The problem described above is a less concern when there are many VMs on a Hyper\-V Virtual Switch and\/or the traffic distribution algorithm of a NIC team is Address hashing. In those cases, there are many flows for NIC Teaming to distribute \(e.g. each TCP connection is a flow in Address hashing mode\), and statistically speaking, VM traffic is more likely evenly distributed across team members of the NIC team. When half of the VMs with weight of 3 and half of the VMs with weight of 1 are hashed to one team member, the rest to the other team member, Minimum Bandwidth is enforced more effectively when congestion occurs.  
  
        To overcome the problem caused by hashing when the traffic distribution algorithm is Hyper\-V Virtual Switch port, you can carefully script a specific order to bring up VMs on a computer running Hyper\-V. Because NIC Teaming hashes VM’s virtual network adapters to team members in a round robin fashion, as long as groups of VMs with the same weight are brought up at the same time, the weight distribution across a NIC team is equal.  
  
    -   **Hardware Enforced Minimum Bandwidth**. The same problem described above can occur when traffic distribution is skewed across multiple DCB capable NICs, even though bandwidth is managed by the NIC hardware.  
  
The table below summarizes how QoS works with NIC Teaming.  
  
|QoS Feature|Functionality with NIC Teaming|  
|---------------|----------------------------------|  
|Maximum Bandwidth|Works seamlessly|  
|Minimum Bandwidth|Does not work seamlessly; uneven traffic distribution can affect weight enforcement|  
|Hardware Enforced Minimum Bandwidth \(DCB\)|Does not work seamlessly; uneven traffic distribution can affect weight enforcement|  
|Classification and Tagging|Works seamlessly|  
|Priority\-based Flow Control|Works seamlessly|  
  
When you configure Minimum Bandwidth in absolute numbers, there is another level of complexity when the deployment involves NIC Teaming. For example, if a Hyper\-V switch is bound to a two 1Gb NIC team, and the NIC team appears to provide 2 Gbps available bandwidth. However you cannot allocate more than 1 Gbps bandwidth to VMs. If VMs were configured with more bandwidth, they wouldn’t be able to satisfy the requirements of those VMs in the event of a NIC failure.  
  
![](../Image/qos_mb_02.jpg)  
  
In contrast, if Minimum Bandwidth were specified by weight in the above configuration, there would be no issue because all traffic would be hashed to the remaining NIC, and bandwidth for each VM would be partitioned proportionally according to its weight. This is another reason that for most deployments you should use the weight mode when configuring Minimum Bandwidth.  
  
## <a name="bkmk_related"></a>Related topics  
Following are links to content that will assist you in configuring QoS and related technologies.  
  
-   [Network Quality of Service \(QoS\) Cmdlets in Windows PowerShell](http://technet.microsoft.com/library/hh967469)  
  
-   [Data Center Bridging \(DCB\) Quality of Service \(QoS\) Cmdlets in Windows PowerShell](http://technet.microsoft.com/library/hh967440)  
  
-   [Network Adapter Cmdlets in Windows PowerShell](http://technet.microsoft.com/library/jj134956)  
  
-   [New\-VMSwitch](http://technet.microsoft.com/library/hh848455)  
  
-   [Set\-VMNetworkAdapter](http://technet.microsoft.com/library/hh848457)  
  
-   [Hyper\-V Cmdlets in Windows PowerShell](http://technet.microsoft.com/library/hh848559)  
  
