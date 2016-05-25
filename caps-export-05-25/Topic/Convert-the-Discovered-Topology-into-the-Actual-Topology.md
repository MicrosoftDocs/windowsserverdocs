---
title: Convert the Discovered Topology into the Actual Topology
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b3e785e4-0ebb-4a50-9618-a890670dccd2
author: vhorne
---
# Convert the Discovered Topology into the Actual Topology
You can use this topic to learn how to convert the discovered topology into the actual topology.  
  
The usual process for comparing the actual topology with the discovered topology is:  
  
1. Add the actual topology to Network Controller  
2. Perform Network Discovery  
3. Compare the discovered topology to the actual topology  
4. Note all physical wiring issues  
5. Correct the physical wiring issues  
  
In some circumstances, it is difficult to provide the actual topology, because you must manually add the topology nodes, termination points, and links between the termination points. Even though some of this process is automated, there are still network elements that you must manually add.   
  
For example, when you add a server to Network Controller, Network Controller automatically creates the corresponding topology node - yet you still must manually enter the links for the node. Manual entry of topology elements raises the possibility of introducing more topology errors, and might result in an incorrect actual topology. This in turn could cause the wiring topology to be incorrect.  
  
To alleviate these issues, you can import the discovered topology into the actual topology by using the **Import-NetworkControllerDesiredStateTopology** Windows PowerShell command:  
  
`Import-NetworkControllerDesiredStateTopology –ConnectionUri https://networkcontroller –ImportDiscoveredTopology`  
  
When you run this command, the topology links from the discovered topology are imported into the actual topology. The topology nodes and termination points are already assumed to be present in the actual topology, because these elements are created when you add the respective fabric elements to Network Controller for management.  
  
For more information, see [Network Discovery and Topology Terminology](Network-Discovery-and-Topology-Terminology.md) and [Network Elements Discovered by Network Controller](Network-Elements-Discovered-by-Network-Controller.md).