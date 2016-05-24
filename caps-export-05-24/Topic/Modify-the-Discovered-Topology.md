---
title: Modify the Discovered Topology
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3fb2d5d6-273d-4321-ba54-03564bad801d
---
# Modify the Discovered Topology
There are times when Network Discovery might not discover some network elements. If you develop scripts or tools to compare the discovered topology against the actual topology, in some cases, you might not want the comparison logic of the tool or script to always report network elements that are not discoverable by Network Controller.   
  
Instead, your script or tool can ignore these elements when it displays the differences between the discovered and the actual topology. If you do not want the same “undiscovered element” to keep showing up in all discovery runs, you can just manually add the element to the discovered topology. Manually added elements in the discovered topology are visible in subsequent discovery runs.  
  
Conversely, there may be circumstances where Network Discovery discovers an element that is not present in the actual topology. You can choose to hide these elements by setting the **IsHidden** flag.   
  
After you apply this flag to an element, the element is not displayed in the discovery topology. Because of this, any script or tool that compares the discovered and the actual topology does not show these differences. Hidden elements remain hidden in subsequent discovery runs.  
  
>[!NOTE]  
>Hidden elements are not visible when you run **Get-NetworkControllerDiscoveredTopology**. To view hidden elements, you can run **Get-NetworkControllerDiscoveredTopologyNode** and **Get-NetworkControllerDiscoveredTopologyLink**.  
  
To add or edit topology nodes, termination points, and topology links, you can use the following Windows PowerShell commands.  
  
```  
New-NetworkControllerDiscoveredTopologyLink  
New-NetworkControllerDiscoveredTopologyNode  
New-NetworkControllerDiscoveredTerminationpoint  
  
```  
  
To remove manually added topology nodes, termination points, and topology links, you can use the following Windows PowerShell commands.  
  
```  
Remove-NetworkControllerDiscoveredTopologyLink  
Remove-NetworkControllerDiscoveredTopologyNode  
Remove-NetworkControllerDiscoveredTerminationpoint  
  
```  
  
>[!NOTE]  
>You cannot delete network elements that are automatically discovered by Network Controller.