---
title: Build the Actual Topology in Network Controller
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c7ea6da0-3fbd-47ce-beff-8959b371bfb2
---
# Build the Actual Topology in Network Controller
You can build the actual topology of the network in Network Controller, which is useful when comparing the actual with the discovered topology. This is also required by the Network Controller feature Network Monitoring, which uses the actual topology to determine which network elements need to be monitored and what are the expected links between those elements.  
  
When you add individual fabric resources to Network Controller, Network Controller automatically creates topology nodes and termination points for those resources. For example, When you add a server resource to Network Controller along with the server physical interfaces, Network Controller automatically creates a topology node for the Server resource and termination points for the network interfaces on the server.  
  
To build the actual topology of the network, perform the following steps.  
  
-   Add network switches to Network Controller. Adding the switches automatically creates corresponding topology nodes and their termination points in  Network Controller.  
  
-   Add servers and their physical interfaces to Network Controller. Adding servers and their interfaces automatically creates the corresponding topology nodes and their termination points in  Network Controller.  
  
-   Add the links between the termination points. You can do this with the Windows PowerShell command  
    **Add\-NetworkControllerDesiredStateTopologyLink**. Following is an example use of this command.  
  
    ```  
    $links=New-Object Microsoft.Windows.NetworkController.DesiredStateTopologyLinkProperties  
    $links.AggregateId=””  
    $term1=Get-NetworkControllerDesiredStateTerminationPoint –ConnectionUri https://networkcontroller –TopologyNode Node1 –ResourceId Int1  
    $term2=Get-NetworkControllerDesiredStateTerminationPoint –ConnectionUri https://networkcontroller –TopologyNode Node2 –ResourceId Int1  
    $links.Terminationpoint1=$term1  
    $links.Terminationpoint2=$term2  
    $links.type=”Regular”  
  
    New-NetworkControllerDiscoveredTopologyLink –Connectionuri https://networkcontroller –ResourceId link1  
    ```  
  
> [!NOTE]  
> To add topology links, you must provide the two termination points for the link. You can get the individual termination points by enumerating the Server or Switch resource. The Server physical interface provides a reference to the corresponding termination point. In addition, switch port and port channel resources include reference to the corresponding termination points.  
  
To view the desired topology, topology nodes, termination points, and topology links, you can use the following Windows PowerShell commands.  
  
```  
Get-NetworkControllerDesiredStateTopology      
Get-NetworkControllerDesiredStateTopologyNode  
Get-NetworkControllerDesiredStateTerminationpoint  
Get-NetworkControllerDesiredStateTopologyLink  
```  
  
## See Also  
[Network Discovery and Topology](../Topic/Network-Discovery-and-Topology.md)  
  
