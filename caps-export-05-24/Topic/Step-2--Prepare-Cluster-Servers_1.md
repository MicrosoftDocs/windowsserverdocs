---
title: Step 2: Prepare Cluster Servers_1
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 586b8014-32ef-4c24-a51d-27c0b0e5dcfa
---
# Step 2: Prepare Cluster Servers_1
Before you can configure a cluster deployment, you prepare additional servers to add to the cluster.  
  
|Task|Description|  
|--------|---------------|  
|[2.1 Configure the Remote Access infrastructure](../Topic/Step-2--Prepare-Cluster-Servers_1.md#BKMK_config)|On each server you want to add to the cluster, configure the server topology, IP addressing, routing, and forwarding. If you configure a load balanced cluster of virtual machines, you must configure the virtual machines to use MAC address spoofing.<br /><br />In addition, join each server to the same domain, and connect all the servers to the same subnet.|  
|[2.2 Install the Remote Access role](../Topic/Step-2--Prepare-Cluster-Servers_1.md#BKMK_Install)|On each additional server you want to add to the cluster, install the Remote Access role|  
|[2.3 Install NLB](../Topic/Step-2--Prepare-Cluster-Servers_1.md#BKMK_NLB)|On the deployed Remote Access server and on each additional server you want to add to the cluster, install the NLB feature. Note that this step is not required when using an External Load Balancer.|  
  
## <a name="BKMK_config"></a>2.1 Configure the Remote Access infrastructure  
To configure a Remote Access cluster, you must configure the server topology, IP addressing, routing, and forwarding on every server that will form part of the cluster.  
  
### To configure the Remote Access infrastructure  
  
1.  Configure each of the servers that will be in the cluster with the same topology as the first Remote Access server.  
  
2.  Configure each of the servers that will be in the cluster with appropriate IP addressing, routing, and forwarding based on the configuration of the first Remote Access server. Note that all the servers in the cluster must be connected to the same subnet.  
  
3.  Join each of the servers that will be in the cluster to the same domain as the first Remote Access server.  
  
## <a name="BKMK_Install"></a>2.2 Install the Remote Access role  
To configure a Remote Access cluster, you must install the Remote Access role on every server that will form a part of the cluster.  
  
### To install the Remote Access role on DirectAccess servers  
  
1.  On the DirectAccess server, in the [!INCLUDE[sm](../Token/sm_md.md)] console, in the **Dashboard**, click **Add roles and features**.  
  
2.  Click **Next** three times to get to the server role selection screen.  
  
3.  On the **Select Server Roles** dialog, select **Remote Access**, click **Add Features**, and then click **Next**.  
  
4.  Click **Next** five times.  
  
5.  On the **Confirm installation selections** dialog, click **Install**.  
  
6.  On the **Installation progress** dialog, verify that the installation was successful, and then click **Close**.  
  
7.  Repeat this procedure on all servers that you want to be cluster members.  
  
## <a name="BKMK_NLB"></a>2.3 Install NLB  
To configure a Remote Access cluster, you must install the Network Load Balancing feature on every server that will form a part of the cluster.  
  
> [!NOTE]  
> This step is not required if an external load balancer is used.  
  
#### To install the NLB role  
  
1.  On the DirectAccess server, in the [!INCLUDE[sm](../Token/sm_md.md)] console, in the **Dashboard**, click **Add roles and features**.  
  
2.  Click **Next** four times to get to the server feature selection screen.  
  
3.  On the **Select features** dialog, select **Network Load Balancing**, click **Add Features**, click **Next**, and then click **Install**.  
  
4.  On the **Installation progress** dialog, verify that the installation was successful, and then click **Close**.  
  
5.  Repeat this procedure on all servers that you want to be cluster members.  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Step 3: Configure a Load-Balanced Cluster_1](../Topic/Step-3--Configure-a-Load-Balanced-Cluster_1.md)  
  
