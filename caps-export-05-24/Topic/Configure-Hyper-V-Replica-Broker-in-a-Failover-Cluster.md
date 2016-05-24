---
title: Configure Hyper-V Replica Broker in a Failover Cluster
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1228b04e-6894-44c9-b5c1-573a881709ca
---
# Configure Hyper-V Replica Broker in a Failover Cluster
Hyper\-V Replica is a feature of Hyper\-V that replicates all changes on a virtual machine to a counterpart virtual machine hosted by a different server. It is simple to configure and does not require either shared storage or any particular storage hardware. Any server workload that can be virtualized in Hyper\-V can be replicated. Replication works over any ordinary IP\-based network, and the replicated data can be encrypted during transmission. Hyper\-V Replica works with stand\-alone servers, failover clusters, or a mixture of both. The servers can be physically co\-located or widely separated geographically. The physical servers do not need to be in the same domain, or even joined to any domain at all.  
  
For an overview of Hyper\-V Replica, see [Hyper\-V Replica Overview](http://technet.microsoft.com/library/jj134172.aspx).  
  
For deployment information, see [Deploy Hyper\-V Replica](http://technet.microsoft.com/library/jj134207.aspx).  
  
