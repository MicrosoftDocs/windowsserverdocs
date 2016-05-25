---
title: Use Vicinity View for a Topology Node
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8fa1e77c-6f03-42a2-aa7a-11a54e20ae63
author: vhorne
---
# Use Vicinity View for a Topology Node
The vicinity view for a topology node shows all the neighboring nodes \- nodes that are directly connected to the topology node \- and all the links between the topology node and the neighboring nodes. This view is very useful when you want to programmatically configure switches or routers that are directly connected to a host. For example, if you provision a new IP address on a host that is connected to a switch, you can then configure the switch with a new route.  
  
To obtain the vicinity information for a node, you can use the **Get\-NetworkControllerDiscoveredTopologyNodeVicinity** command. The example output below demonstrates the information you can gather with this command.  
  
```  
$a=get-NetworkControllerDiscoveredTopologyNodeVicinity -ConnectionUri https://networkcontroller -TopologyNodeId 951f133f-612b-4134-a588-ed1f73c2a468  
$a.Properties  
  
ProvisioningState     TopologyNodes                       TopologyLinks  
-----------------     -------------                       -------------  
Succeeded         {951f133f-612b-4134-a588-ed1f73c2a468,  {5e6bcd97-4352-4ac3-8b5e-1e69b2402d30,   
                 fc284b32-38ba-47d2-a67a-6443d3938bb1,..} a462bfcc-5115-4ac1-a6ac-558a755bb803,  
                                                          ...}  
```  
  
To add the actual topology to Network Controller, see [Build the Actual Topology in Network Controller](../Topic/Build-the-Actual-Topology-in-Network-Controller.md).  
  
## See Also  
[Network Discovery and Topology](../Topic/Network-Discovery-and-Topology.md)  
  
