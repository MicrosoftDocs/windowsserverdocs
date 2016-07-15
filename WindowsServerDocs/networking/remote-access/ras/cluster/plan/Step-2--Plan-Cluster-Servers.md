---
title: Step 2 Plan Cluster Servers
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 673c5bfb-b590-4932-8e54-ca0a466d90cc
author: coreyp-at-msft
---
# Step 2 Plan Cluster Servers

>Applies To: Windows Server Technical Preview

After deploying a single Remote Access server, plan to add additional servers to the cluster.  
  
|Task|Description|  
|--------|---------------|  
|[2.1 Installing roles and features](#BKMK_Install).|For each server that will be added to the cluster, plan for installation of the Remote Access role and the Windows NLB feature (if needed), plan the topology, IP addressing, routing and forwarding.|  
|[2.2 Configure server settings](#BKMK_Config)|Configure settings for each server that will be added to the cluster. Note that you can configure a load balanced cluster of servers using virtual machines. In order for routing and connectivity to work correctly, you must configure the virtual machines to use MAC address spoofing.|  
  
## <a name="BKMK_Install"></a>2.1 Installing roles and features  
For each server you want to join to the cluster, plan to install the Remote Access role. In addition plan to install the Network Load Balancing (NLB) feature if you want to load balance traffic to the cluster using Windows NLB. For more information see [Network Load Balancing overview](http://technet.microsoft.com/library/hh831698.aspx).  
  
## <a name="BKMK_Config"></a>2.2 Configure server settings  
For each server that will be added to the cluster, plan IP address and domain settings. Note the following:  
  
1.  Servers in the cluster must all belong to the same domain.  
  
2.  Servers in the cluster must be located on the same subnet.  
  
3.  Each server in the cluster should have the same number of network adapters in use for the DirectAccess deployment.  
  
For more information about configuring server settings, see the single server planning guide -[Step 1: Configure the Remote Access infrastructure](assetId:///0064848b-b82e-4397-8fde-0c660c596076).  
  
When you load balance the cluster using Windows NLB the following Windows NLB settings are applied:  
  
1.  Operation mode-Unicast. This can be changed to multicast using NLB Manager. This setting cannot be modified in the Remote Access Management console.  
  
2.  Load weight factor-Defined as Equal, where all cluster servers have equal load.  
  
3.  Filtering mode-Traffic will be load balanced across multiple hosts.  
  
4.  Affinity-Single affinity is defined.  
  
5.  Protocols-Both  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Step 2: Plan load balancing](assetId:///22e3a2dc-4f9c-417c-9630-c329506a3e8b)  
  


