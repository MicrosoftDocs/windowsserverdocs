---
title: Network Elements Discovered by Network Controller
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: dfddc7d3-a6c6-4842-9cb8-dd64ad3a3211
---
# Network Elements Discovered by Network Controller
This topic provides information about the Network Controller feature Network Discovery, including the type of information that you can collect for your network topology when you perform Network Discovery.  
  
When you use Network Controller to perform Network Discovery, the search results include information about topology nodes. Topology nodes can be server computers or Ethernet switches.  
  
> [!NOTE]  
> Network Discovery does not detect client computers or links between client computers and switches.  
  
For each topology node on your network, the following information is discovered by Network Controller.  
  
-   Node name. Specifies the computer name or Fully Qualified Domain Name \(FQDN\) of the node.  
  
-   Node type. The valid values for node type are switch and server.  
  
-   Node operating system. Specifies the operating system of the node.  
  
-   Node model number. Specifies the model number of the node.  
  
-   Node vendor. Specifies the vendor of the node.  
  
-   Node serial number. Specifies the serial number of the node.  
  
-   Termination point on the node: A termination point represents actual physical interfaces on the node. Details on the information discovered for termination points is provided below.  
  
-   Links between termination points – There are multiple links, each link existing between two termination points. Details on the information discovered for links between termination points is provided below.  
  
**Details on the information discovered for termination points**  
  
For each termination point on a node, the following information is discovered.  
  
-   Name of the termination point.  
  
-   Media access control \(MAC\) address of the termination point.  
  
-   IP configuration. This includes IP address, network prefix, default gateway, virtual Local Area Network \(VLAN\) identifiers, and whether the IP address is statically assigned or is dynamically assigned by a DHCP server.  
  
-   VLAN. This is the array of VLAN IDs that are configured on the termination point.  
  
-   Administrative status. Supported values are 1,2,3 \(1: up, 2: down, and 3: testing\).  
  
-   Operational status. Supported values are 1,2,3,4,5,6,7 \(1: up, 2: down, 3: testing, 4: unknown, 5: dormant, 6: not present, 7: lower layer down\).  
  
-   Speed. Specifies the bit rate, in megabits per second, at which the interface is operating.  
  
-   Port channel ID. If the termination point represents a port channel on the network switch, this field contains the port channel ID.  
  
-   Interface index of the termination point.  
  
-   Interface type. Supported values are 6, 24, 117, 56, 62, 69, 160, 230, 33, 75, 76, 219 \(6: ethernetCsmacd, 24: softwareLoopback, 33: rs232, 56: fibreChannel, 62:fastEther, 69: fastEtherFX, 75: isdns, 76: isdnu, 117: gigabitEthernet, 160: usb, 219: opticalChannelGroup, 230: adsl2\)  
  
**Details on the information discovered for links between termination points**  
  
For each link between termination points, the following information is discovered.  
  
-   Termination point 1. This represents one end of the link.  
  
-   Termination point 2. This represents the other end of the link.  
  
-   Type of link. This can have the following values:  
  
    -   Regular. This represents a normal physical link that has not been aggregated.  
  
    -   Aggregate. This represents a logical link comprising of several physical links that have been combined using LACP or static link aggregation.  
  
    -   Trunk. This represents a trunk port on the network switch.  
  
-   AggregateID. This is a system\-generated identifier used to group the links that are part of a single logical link. For example, multiple physical links that form an aggregated link for uplink would carry the same aggregateID. AggregateID is provided only for programming convenience, and has no relevance on the physical network.  
  
To prepare for performing Network Discovery, see [Prerequisites for Performing Network Discovery](../Topic/Prerequisites-for-Performing-Network-Discovery.md).  
  
## See Also  
[Network Discovery and Topology](../Topic/Network-Discovery-and-Topology.md)  
  
