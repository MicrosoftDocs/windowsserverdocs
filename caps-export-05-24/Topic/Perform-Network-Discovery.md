---
title: Perform Network Discovery
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 901e5747-5bfb-401d-9021-8f76d5b85132
---
# Perform Network Discovery
After you have completed all of the steps in [Prerequisites for Performing Network Discovery](../Topic/Prerequisites-for-Performing-Network-Discovery.md), you can perform Network Discovery.  
  
You can use the following procedure to perform Network Discovery.  
  
### To perform Network Discovery  
  
1.  Open Windows PowerShell and run the following command.  
  
    ```  
    $discovery=New-Object Microsoft.Windows.NetworkController.NetworkDiscoveryActionProperties  
    $discovery.Action=”start”  
  
    Invoke-NetworkControllerTopologyDiscovery –ConnectionUri https://networkcontroller –Properties $disovery  
    ```  
  
For information about discovery results, see [View and Validate Discovered Topology](../Topic/View-and-Validate-Discovered-Topology.md).  
  
## See Also  
[Network Discovery and Topology](../Topic/Network-Discovery-and-Topology.md)  
  
