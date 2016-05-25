---
title: Network Monitoring
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fa799372-90fb-4701-8c88-ed919a40f7fa
author: vhorne
---
# Network Monitoring
You can use this topic to learn about Network Monitoring, which allows you to monitor the physical and virtual networks in your datacenter.  
  
> [!NOTE]  
> -   Network Monitoring is a feature of Network Controller in [!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)]; you must deploy Network Controller to use Network Monitoring.  
>   
>     For more information, see [Deploy Network Controller using Windows PowerShell](https://technet.microsoft.com/library/mt282165.aspx).  
> -   To use Network Monitoring, it is recommended that you install the Network Controller Network Monitoring Management pack in System Center Operations Manager, which provides a graphical Network Monitoring interface. You can also interact with Network Monitor by using the Representational State Transfer \(REST\) APIs or Windows PowerShell.  
  
You can use Network Monitoring to detect changes in network loss, latency, and the availability of devices in your network topology, as well as to alert you to network problems as they occur. These alerts provide you with the ability to rapidly identify, locate, and fix network issues.  
  
The alerts and the information provided with the alerts allow you to:  
  
-   Prioritize troubleshooting actions based on issue impact  
  
-   Achieve faster turnaround on reported issues  
  
-   Solve problems before they seriously impact your tenants  
  
-   More successfully maintain network up time for your datacenter network service level agreements \(SLAs\)  
  
The Network Monitoring service uses the network object model, provided by the topology service, to determine the network devices and links to be monitored. Physical network monitoring is performed using both active network and element data.  
  
Active network data, such as network loss and latency, is detected by sending network traffic and measuring round\-trip time. The Network Monitoring service automatically determines the network points between which traffic must be sent, the quantum of traffic to be sent in order to cover all network paths, and also the loss and latency baseline and deviations over a period of time.  
  
> [!NOTE]  
> Element data is collected using Simple Network Management Protocol \(SNMP\) polling and traps. The monitoring service collects a limited set of critical data available through public management information bases \(MIBs\). For example, the service monitors link state, system restarts, and Border Gateway Protocol \(BGP\) peer status.  
  
**Health monitoring**  
  
The monitoring system reports health of both devices and device groups. Health is reported based on both active and element data. Devices are, for example, physical switches and routers. Device groups are a combination of physical devices which has some relevance within the datacenter.  
  
For example, device groups can be racks or subnets or simply host groups. In addition to providing health information, the monitoring service also reports vital statistics such as network loss, latency, device CPU\/memory usages, link utilization, and packet drops.  
  
**Impact Analysis**  
  
Impact analysis is the process of identifying overlay networks that are affected by the underlying faulty physical networks.  
  
Network Monitoring  can identify virtual networks that are affected by any network failure, including physical network failures, and which are at high risk of losing connectivity.  
  
Network Monitoring uses topology information to determine the virtual network footprint and to report the health of impacted virtual networks.  
  
For example, if a host loses network connectivity, the system marks all virtual networks on this host and that are connected to the faulty network as impacted. Similarly, if a rack loses uplink connectivity to the core network, the system determines the logical network affected and marks all virtual networks in this rack and connected to the affected logical network as impacted.  
  
Network Monitoring integrates with System Center Operations Manager server to report both health and statistics data.  Health is reported in an aggregated manner making it easy to traverse and understand key issues.  
  
**Performance monitoring**  
  
Performance monitoring is accomplished with active probing, which measures network loss and latency within a fault domain\/rack, between fault domains\/racks, and from fault domains\/racks to  external addresses. Active probing identifies all parallel paths between any two end nodes, and includes all of the paths in its tests.  
  
Using active probing, Network Monitoring learns the baseline threshold for loss and latency for every link that it monitors.  
  
**Statistics collection and aggregation**  
  
Network Monitoring collects statistics about your network and aggregates them into an easy to understand format so that you're always aware of your network health status.  
  
Network Monitoring gathers statistics for physical and virtual network devices and interfaces, including the following.  
  
-   Switches, routers, and their interfaces  
  
-   Fault Domains\/Racks  
  
-   Hosts  
  
-   Host interfaces  
  
-   Hyper\-V Virtual Switches  
  
-   Hyper\-V Virtual Switch ports  
  
From physical network devices, Network Monitoring collects Simple Network Management Protocol \(SNMP\) traps to recognise active alerts, such as an Ethernet switch reboot or an interface failure on a switch or router.  
  
From the virtual network, Network Monitoring polls Hyper\-V hosts to gather statistics about virtual switches and ports, and then associates the devices to the correct virtual network.  
  
**Fault localization**  
  
The Network Monitoring service attempts to localize devices that are causing network loss and latency, leveraging advanced algorithms to identify both network paths and devices in the paths that are causing performance degradation.  
  
Network Monitoring uses fault localization to identify the network location of a device or interface that has  failed. Fault localization reduces the number of alerts that are raised in circumstances where a single failure causes lack of connectivity for many other devices, which in turn could cause a cascade of additional alerts.  
  
## Canary Controller and Agents  
The Canary Controller and Canary Agents are features of Network Monitoring that conduct active probe tests within a rack, between racks, and from a rack to one or more external addresses, monitoring network performance and health  
  
The Network Monitor feature of Network Controller acts as the Canary Controller and requires two Canary Agents per logical network per rack.  
  
Canary Agents are servers running [!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)] that have the Canary Network Diagnostics feature installed. Upon installation of the Canary Network Diagnostics feature, the Network Performance and Diagnostic Service \(NPDS\) is installed.  
  
The Canary Controller automatically detects servers that have the NPDS service installed and started. When Network Monitor locates servers with the NPDS service running, it restarts the service to verify that the host is a Canary Agent.  
  
For the Canary Agent to function correctly, you must configure the firewall on the server where you install the Canary Network Diagnostics feature to allow inbound and outbound NPDS traffic on port 8084.  
  
In addition, the Canary Network Diagnostics feature must be installed on a host computer for the canary agent to be auto\-discovered. If you deploy Canary Agents on Virtual Machines \(VMs\), you must manually register the Canary Agents with the Canary Controller.  
  
