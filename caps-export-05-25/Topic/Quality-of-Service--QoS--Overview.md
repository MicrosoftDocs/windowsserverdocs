---
title: Quality of Service (QoS) Overview
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: aec1ca7c-9f81-4789-ad02-20d9084ead10
author: vhorne
---
# Quality of Service (QoS) Overview
QoS is a set of technologies that provide you with the ability to cost\-effectively manage network traffic and to enhance user experiences in enterprise environments, small offices, and even home networking environments.  
  
This document provides introductory information about Quality of Service \(QoS\) in [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)].  
  
> [!NOTE]  
> In addition to this topic, the following [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] QoS documentation is available.  
>   
> -   [QoS Common Configurations](../Topic/QoS-Common-Configurations.md)  
> -   [QoS Minimum Bandwidth Best Practices](../Topic/QoS-Minimum-Bandwidth-Best-Practices.md)  
> -   [Policy-based Quality of Service &#40;QoS&#41;](../Topic/Policy-based-Quality-of-Service--QoS-.md)  
> -   [Configuring Policy-based Quality of Service &#40;QoS&#41;](../Topic/Configuring-Policy-based-Quality-of-Service--QoS-.md)  
> -   [Quality Windows Audio Video Experience &#40;qWave&#41;](../Topic/Quality-Windows-Audio-Video-Experience--qWave-.md)  
> -   [QoS Frequently Asked Questions](../Topic/QoS-Frequently-Asked-Questions.md)  
  
## <a name="BKMK_OVER"></a>QoS features  
QoS technologies allow you to meet the service requirements of a workload or an application by measuring network bandwidth, detecting changing network conditions \(such as congestion or availability of bandwidth\), and prioritizing \- or throttling \- network traffic. For example, you can use QoS to prioritize traffic for latency\-sensitive applications \(such as voice or video streaming\), and to control the impact of latency\-insensitive traffic \(such as bulk data transfers\).  
  
QoS provides the following features.  
  
-   [Bandwidth management](#bkmk_bandwidth)  
  
-   [Classification and tagging](#bkmk_class)  
  
-   [Priority based flow control](#bkmk_priority)  
  
-   [Policy\-based QoS and Hyper\-V QoS](#bkmk_policy)  
  
Information on these features is provided in the following sections.  
  
> [!NOTE]  
> QoS is included in all versions of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[win8_client_1](../Token/win8_client_1_md.md)], and supports all QoS APIs and features that are provided by QoS in [!INCLUDE[firstref_server_7](../Token/firstref_server_7_md.md)] and [!INCLUDE[firstref_client_7](../Token/firstref_client_7_md.md)]. QoS is not available in [!INCLUDE[winrt_1](../Token/winrt_1_md.md)].  
  
### <a name="bkmk_bandwidth"></a>Bandwidth management  
In previous versions of QoS, as with QoS in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], Maximum Bandwidth is a feature that sets an absolute ceiling \- a throttling rate \- for a workload. [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] introduces Minimum Bandwidth.  
  
Minimum Bandwidth provides a specified level of service to a workload when network congestion occurs while still permitting higher bandwidth utilization by this workload in circumstances where there is no network congestion. Network congestion occurs on a computer system when multiple workloads compete for access to an external network through one network adapter.  
  
Because the capacity of any network adapter is limited, when the sum of the workloads exceeds that capacity, the network throughput of each workload becomes nondeterministic. With Minimum Bandwidth, you can define how bandwidth is shared by competing applications.  
  
For example, you might have Storage, Live Migration, and Cluster sharing a 10 GB NIC on a computer that is running the Hyper\-V server role. If you assign a weight of 50, 30 and 20 to Storage, Live Migration, and Cluster, respectively, they receive corresponding shares of bandwidth when the NIC is congested.  
  
Both Minimum Bandwidth and Maximum Bandwidth enable you to enforce predictable network throughput for each workload. The main difference between them, from an administrator’s point of view, is how they utilize network resources.  
  
**Network resource utilization**  
  
When Maximum Bandwidth is set for a workload, the workload can never exceed the ceiling even if no other workloads in the system are using the network bandwidth. When Minimum Bandwidth is set for a workload, the workload can use as much bandwidth as it can \- until network congestion occurs. Using the previous example, when Live Migration is not occurring, both the Storage and Cluster workloads can exceed their predefined shares of network bandwidth.  
  
You can choose to enable Maximum Bandwidth, Minimum Bandwidth, or both based on the requirements of a specific scenario. For example, to prevent a hosted VM from unexpectedly using all available Internet bandwidth, a public hoster can impose a QoS Maximum Bandwidth setting on the VM. Conversely, to maximize the bandwidth utilization on any computer running the Hyper\-V server role within the datacenter, you can impose a minimum bandwidth setting on the server.  
  
**Server Message Block Direct \(SMB Direct\) and Data Center Bridging \(DCB\).**  
  
Minimum Bandwidth and Maximum Bandwidth are enforced by QoS Packet Scheduler. They work well with traffic that flows through the Windows Server networking stack.  
  
But there is network traffic that bypasses the networking stack. The most notable example is Server Message Block Direct \(SMB Direct\), a [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] feature that builds on Remote Direct Memory Access \(RDMA\). SMB Direct offloads the SMB traffic directly to an RDMA\-capable NIC to reduce latency and the number of CPU cycles that are spent on networking. Because SMB Direct still competes for bandwidth with other network traffic at the NIC hardware, one can impact or even starve the other if they are left unchecked.  
  
To resolve this issue, you can use Data Center Bridging \(DCB\). DCB is implemented by some NIC vendors in network adapters. DCB works in a similar way as Minimum Bandwidth: each class of traffic, regardless of whether it’s offloaded or not, has bandwidth allocation; in the event of network congestion, each class gets its share \- otherwise, each class gets as much bandwidth as is available.  
  
### <a name="bkmk_class"></a>Classification and tagging  
Before the bandwidth for a workload is managed, the workload must be classified or filtered out so that QoS Packet Scheduler or a DCB capable NIC can act upon it. Windows has sophisticated traffic classification capability. Classification can be based on 5\-tuples, user type, or URI. [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] simplifies the management task so that you can invoke built\-in filters in Windows PowerShell to classify some of the most common workloads. The table below lists these built\-in filters.  
  
|Workload|Built\-in Filter \(Parameter\) in Windows PowerShell|Filter Implementation|  
|------------|--------------------------------------------------------|-------------------------|  
|iSCSI|\-iSCSI|Match TCP or UDP port 3260|  
|NFS|\-NFS|Match TCP or UDP port 2049|  
|SMB|\-SMB|Match TCP or UDP port 445|  
|Live Migration|\-LiveMigration|Match TCP port 6600|  
|SMB Direct|\-NetDirect<port>|Match the specified port|  
|Wild Card|\-Default|Any traffic that is not otherwise classified|  
  
> [!NOTE]  
> -   SMB Direct offloads SMB traffic to a NIC. When “\-NetDirect <port>” is specified in a QoS policy, Windows sends the instruction to any NIC that supports SMB Direct; the compatible NICs then filter out the network traffic flow based on the specified port.  
> -   Wild Card allows you to capture any traffic that is not filtered out or classified. For example, you can use this wild card filter to create a class of traffic for Management on a computer that is running the Hyper\-V server role.  
  
Bandwidth Management is not the only action that you can specify in a QoS policy. For example, you can prioritize and tag traffic so that QoS is enforced from end to end across a data center.  
  
Previous versions of Windows support priority tagging in the IP header of a network packet. The priority bits are known as Differentiation Service Code Point \(DSCP\). [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] adds the support of 802.1p tagging. 802.1p is a 3\-bit priority value in the layer 2 Ethernet frame. Therefore it applies to non\-IP packets such as RDMA over Ethernet.  
  
### <a name="bkmk_priority"></a>Priority based flow control  
Workloads, such as RDMA, require lossless transport.  If RDMA is built on top of Ethernet directly, which is known as RDMA over Converged Ethernet \(ROCE\), the Ethernet transport must be lossless. Traditionally, link level flow control, which relies on the 802.3 Pause frame, is a solution. But link level flow control causes problems such as head of line blocking.  
  
This issue is resolved by Priority based Flow Control \(PFC\), which is one standard defined by the Institute of Electrical and Electronics Engineers \(IEEE\) DCB workgroup. [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] allows you to enable PFC as long as it is supported by a NIC. When PFC is enabled for ROCE on both ends of an Ethernet link, only the virtual link designated for ROCE, which is denoted by a priority value, becomes lossless, and other workloads on the same physical link do not suffer from head of line blocking.  
  
### <a name="bkmk_policy"></a>Policy\-based QoS and Hyper\-V QoS  
For network administrators, QoS in [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] is designed to help manage network traffic on the physical network and on the virtual network. Policy\-based QoS is designed to manage traffic on the physical network. And a new functionality in QoS, called Hyper\-V QoS, allows you to manage traffic on the virtual network.  
  
#### Policy\-based QoS  
You can use Policy\-based QoS to manage network traffic on the physical network. Policy\-based QoS enables you to specify network bandwidth control based on application type, users, and computers. You can use Policy\-based QoS to manage traffic to help control bandwidth costs, negotiate service levels with bandwidth providers or business departments, and to offer better end\-user experiences. Because Policy\-based QoS is built into Group Policy, it is part of your existing management infrastructure, and is therefore a cost\-effective solution to implement.  
  
Policy\-based QoS provides the ability to:  
  
-   Enforce minimum bandwidth for a traffic flow, which is identified by a 5\-tuple traffic filter.  
  
    > [!NOTE]  
    > 5\-tuple is a term used in computer networking that describes a set of five different values that constitute a Transmission Control Protocol\/Internet Protocol \(TCP\/IP\) connection.  
  
-   Configure and query or view QoS policies, which enforce minimum and maximum bandwidth and 802.1p or Differentiated Services Code Point \(DSCP\) marking on filtered packets, through WMI and PowerShell.  
  
    > [!NOTE]  
    > -   DSCP is a field in an IPv4 or IPv6 header in computer networking.  
    > -   802.1p is an Institute of Electrical and Electronics Engineers \(IEEE\) specification that enables Layer\-2 switches to perform traffic prioritization and dynamic multicast filtering.  
  
-   Use Group Policy editors to configure an Extended Quality of Service \(eQoS\) policy to tag packets with an 802.1p value.  
  
-   Configure local QoS policies on computers that are not joined to a domain.  
  
For more information, see [Policy-based Quality of Service &#40;QoS&#41;](../Topic/Policy-based-Quality-of-Service--QoS-.md).  
  
#### Hyper\-V QoS  
You can use Hyper\-V QoS to manage network traffic on the virtual network. In [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)], QoS includes new bandwidth management features that enable cloud hosting providers and enterprises to provide services that deliver predictable network performance to virtual machines on a server that is running the Hyper\-V server role. Hyper\-V QoS supports the management of upper\-allowed and lower\-allowed bandwidth limits, commonly referred to as maximum bandwidth and minimum bandwidth.  
  
In hosted environments, Hyper\-V QoS enables you to guarantee specific performance levels based on the service level agreements \(SLAs\) to which you have agreed with your customers. Hyper\-V QoS helps ensure that your customers are not impacted or compromised by other customers on their shared infrastructure, which can include computing, storage, and network resources.  
  
In addition, enterprise networks might require similar functionality. By using Hyper\-V QoS in your enterprise, you can run multiple virtual machine\-based application servers on a host server that is running Hyper\-V, and have confidence that each application server delivers predictable performance.  
  
Hyper\-V QoS provides the ability to:  
  
-   Enforce minimum bandwidth and maximum bandwidth for a traffic flow, which is identified by a Hyper\-V Virtual Switch port number.  
  
-   Configure minimum bandwidth and maximum bandwidth per Hyper\-V virtual switch port by using either PowerShell cmdlets or Windows Management Instrumentation \(WMI\).  
  
-   Configure multiple virtual network adapters in Hyper\-V and specify QoS on each virtual network adapter individually.  
  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Hyper\-V QoS can also use hardware that is compatible with data center bridging \(DCB\) to converge multiple types of network traffic on a single network adapter with a guaranteed level of service provided to each type of traffic. With Windows PowerShell, you can configure these new features manually or enable automation in a script to manage a group of servers, regardless of whether they are joined to a domain.  
  
