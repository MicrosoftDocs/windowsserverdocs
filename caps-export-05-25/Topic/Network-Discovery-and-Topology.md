---
title: Network Discovery and Topology
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5e8dcb7a-6d0c-4951-b715-3bbf0541985a
author: vhorne
---
# Network Discovery and Topology
This topic provides an overview of the Network Discovery feature in Network Controller.  
  
> [!NOTE]  
> In addition to this topic, the following Network Discovery and Topology documentation is available.  
>   
> 1.  [Network Discovery and Topology Terminology](../Topic/Network-Discovery-and-Topology-Terminology.md)  
> 2.  [Network Elements Discovered by Network Controller](../Topic/Network-Elements-Discovered-by-Network-Controller.md)  
> 3.  [Prerequisites for Performing Network Discovery](../Topic/Prerequisites-for-Performing-Network-Discovery.md)  
> 4.  [Perform Network Discovery](../Topic/Perform-Network-Discovery.md)  
> 5.  [View and Validate Discovered Topology](../Topic/View-and-Validate-Discovered-Topology.md)  
> 6.  [View Network Discovery Statistics](../Topic/View-Network-Discovery-Statistics.md)  
> 7.  [Use Vicinity View for a Topology Node](../Topic/Use-Vicinity-View-for-a-Topology-Node.md)  
> 8.  [Build the Actual Topology in Network Controller](../Topic/Build-the-Actual-Topology-in-Network-Controller.md)  
  
## <a name="bkmk_over"></a>Network Discovery and Topology Overview  
Network Discovery allows you to validate the network wiring and connections in your datacenter network. You can use Network Discovery to validate whether the network connections between switches \- and between switches and host computers or storage nodes \- are functioning correctly, and are configured according to the expected network architecture.  
  
You can also use the Network Discovery feature of Network Controller as an automated way of discovering devices on your network and attaining an overview of your network structure and design.  
  
This network overview allows you to identify differences between the expected design of your network and the discovered topology of the network. Differences between the expected design and the discovery results can assist you in troubleshooting network connectivity issues, device availability problems, and other network issues.  
  
You can use Network Discovery to validate your network design and functionality at any time, and it is particularly useful in the following circumstances.  
  
-   After initial deployment of a new network  
  
-   After addition or removal of network devices  
  
-   After addition or removal of racks and enclosures  
  
The following three scenarios provide examples of a Network Administrator, Eric, who uses Network Discovery to manage the network of a Cloud Service Provider \(CSP\).  
  
### Deploying a New Network  
Eric is a Network Administrator for a start\-up CSP, and he is setting up the core network for the first time. Eric installs top of rack \(ToR\) switches, and installs cabling to connect the ToRs to aggregate switches, which provides inter\-rack connectivity.  
Now Eric wants to validate the switches and switch connections by using Network Controller's Network Discovery feature. So before configuring all hosts on the network, Eric configures a Network Controller cluster on multiple servers that are running Windows Server 2016.  
  
After Network Controller is configured, Eric performs Network Discovery to validate wiring and network connections between switches. The discovery process enumerates all of the devices and how they are connected on the network.  
Eric uses Windows PowerShell scripts to compare the discovered topology with the actual topology of the network. The discovery results show Eric that he has accidentally made some incorrect connections between switches, so he adjusts switch wiring until it is correct.  
  
Next, Eric uses Network Controller to configure the switches. After the switches are configured, he repeats Network Discovery to ensure that the virtual Local Area Networks \(VLANs\) and link aggregation information is configured correctly on the switches, making configuration adjustments as needed.  
  
In the final stage of network deployment, Eric deploys host computers on the network, installing operating systems, creating an Active Directory domain, and joining computers to the domain. To validate the host connectivity, Eric again runs Network Discovery.  
  
This time, Network Discovery detects the entire network, including Windows hosts, switches, and all connections between them. Eric uses the discovery information to correct any errors he has made and to arrive at the point where he has a fully functioning network.  
  
### Replacement of a Failed Network Switch  
Eric notes that the Network Monitoring feature of Network Controller has detected the failure of an aggregate switch. After investigation, Eric decides that the switch requires replacement and removes it from the rack. Eric installs a new switch and connects it to the network. Using fabric network management Windows PowerShell cmdlets, Eric configures the switch and updates the actual topology with the new switch and its connections.  
  
Then Eric runs Network Discovery, and compares the discovered topology with the actual topology. Eric performs corrections and reruns Network Discovery until no differences remain between actual topology and discovered topology.  
  
### Adding a New Network Rack  
Due to increased network bandwidth demand from tenants, Eric decides to add a new rack to the existing setup. Eric readies the new rack and switches, and connects the switches to the network, updating the actual topology at the same time.  
  
Eric then runs Network Discovery multiple times \- first to validate wiring between switches, then to validate link aggregation, and finally to validate host connectivity. When he discovers anomalies between the actual topology and the discovered topology, Eric makes physical or configuration changes as needed, until all is working correctly.  
  
To learn about Network Discovery terminology, see [Network Discovery and Topology Terminology](../Topic/Network-Discovery-and-Topology-Terminology.md).  
  
For more information about discovery results. see [Network Elements Discovered by Network Controller](../Topic/Network-Elements-Discovered-by-Network-Controller.md).  
  
To take required steps for performing discovery, see [Prerequisites for Performing Network Discovery](../Topic/Prerequisites-for-Performing-Network-Discovery.md).  
  
To use Network Discovery, see [Perform Network Discovery](../Topic/Perform-Network-Discovery.md).  
  
> [!NOTE]  
> Membership in **Administrators**, or equivalent, is the minimum required to perform the procedures in the following sections. You can run these procedures on the local computer or from a remote computer. Ensure that you replace variable values in the Windows PowerShell example commands with values that are correct for your deployment.  
  
For detailed reference information about the Windows PowerShell commands used in this guide, see [Network Controller Cmdlets](https://technet.microsoft.com/en-us/library/mt576401.aspx).  
  
To learn terminology specific to Network Discovery, see [Network Discovery and Topology Terminology](../Topic/Network-Discovery-and-Topology-Terminology.md)  
  
