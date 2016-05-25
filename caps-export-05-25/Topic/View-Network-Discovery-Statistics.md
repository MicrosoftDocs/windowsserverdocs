---
title: View Network Discovery Statistics
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fd44024e-92e0-44cc-9cb5-9c2bf3e6202d
author: vhorne
---
# View Network Discovery Statistics
You can view a variety of Network Discovery statistics by using the **Get\-NetworkControllerTopologyDiscoveryStatistics** command. You can find out the status of a Network Discovery run, the last time Network Discovery was run, and the length of time required to complete a discovery operation.  
  
Following is example output for this command.  
  
```  
Get-NetworkControllertopologyDiscoveryStatistics –ConnectionUri https://networkcontroller   
  
ResourceRef      : /networkDiscovery/statistics/discoveryStatistics  
InstanceId       : 0765e34-00fe-70f7-b357-484e9eb74064  
Etag             : W/”206ce23e-bc59-4aa2-49a2-7e4b7cbf2013”  
ResourceMetadata :  
ResourceId       : discoveryStatistics  
Properties       : Microsoft.Windows.NetworkController.NetworkDiscoveryStatisticsProperties  
  
$stats= Get-NetworkControllertopologyDiscoveryStatistics –ConnectionUri https://networkcontroller  
$stats.Properties  
  
Status     LastRuntimeStamp           LastRuntimeInSeconds           ProvisioningState  
------     -----------------          ----------------------         ------------------------  
Stopped    10/21/2015 11:08:57 AM     121.2345                       Succeeded  
```  
  
For information about vicinity view, see [Use Vicinity View for a Topology Node](../Topic/Use-Vicinity-View-for-a-Topology-Node.md).  
  
## See Also  
[Network Discovery and Topology](../Topic/Network-Discovery-and-Topology.md)  
  
