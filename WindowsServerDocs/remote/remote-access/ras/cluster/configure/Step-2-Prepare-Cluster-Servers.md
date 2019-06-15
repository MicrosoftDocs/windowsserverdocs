---
title: Step 2 Prepare Cluster Servers
description: This topic is part of the guide Deploy Remote Access in a Cluster in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-ras
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 35d68abb-6914-42e0-91e8-803933cf785e
ms.author: pashort
author: shortpatti
---
# Step 2 Prepare Cluster Servers

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

Before you can configure a cluster deployment, you prepare additional servers to add to the cluster.  
  
|Task|Description|  
|----|--------|  
|[2.1 Configure the Remote Access infrastructure](#BKMK_config)|On each server you want to add to the cluster, configure the server topology, IP addressing, routing, and forwarding. If you configure a load balanced cluster of virtual machines, you must configure the virtual machines to use MAC address spoofing.<br /><br />In addition, join each server to the same domain, and connect all the servers to the same subnet.|  
|[2.2 Install the Remote Access role](#BKMK_Install)|On each additional server you want to add to the cluster, install the Remote Access role|  
|[2.3 Install NLB](#BKMK_NLB)|On the deployed Remote Access server and on each additional server you want to add to the cluster, install the NLB feature. Note that this step is not required when using an External Load Balancer.|  
  
## <a name="BKMK_config"></a>2.1 Configure the Remote Access infrastructure  
To configure a Remote Access cluster, you must configure the server topology, IP addressing, routing, and forwarding on every server that will form part of the cluster.  
  
### To configure the Remote Access infrastructure  
  
1.  Configure each of the servers that will be in the cluster with the same topology as the first Remote Access server.  
  
2.  Configure each of the servers that will be in the cluster with appropriate IP addressing, routing, and forwarding based on the configuration of the first Remote Access server. Note that all the servers in the cluster must be connected to the same subnet.  
  
3.  Join each of the servers that will be in the cluster to the same domain as the first Remote Access server.  
  
## <a name="BKMK_Install"></a>2.2 Install the Remote Access role  
To configure a Remote Access cluster, you must install the Remote Access role on every server that will form a part of the cluster.  
  
### To install the Remote Access role on Always On VPN servers  
  
1.  On the DirectAccess server, in the Server Manager console, in the **Dashboard**, click **Add roles and features**.  
  
2.  Click **Next** three times to get to the server role selection screen.  
  
3.  On the **Select Server Roles** dialog, select **Remote Access**, and then click **Next**.  
  
4.  Click **Next** three times.  
  
5.  On the **Select role services** dialog, select **DirectAccess and VPN (RAS)** and then click **Add Features**.  
  
6.  Select **Routing**, select **Web Application Proxy**, click **Add Features**, and then click **Next**.  
  
7. Click **Next**, and then click **Install**.  
  
8.  On the **Installation progress** dialog, verify that the installation was successful, and then click **Close**.  
  
9.  Repeat this procedure on all servers that you want to be cluster members.  
  
## <a name="BKMK_NLB"></a>2.3 Install NLB  
To configure a Remote Access cluster, you must install the Network Load Balancing feature on every server that will form a part of the cluster.  
  
> [!NOTE]  
> This step is not required if an external load balancer is used.  
  
#### To install the NLB role  
  
1.  On the DirectAccess server, in the Server Manager console, in the **Dashboard**, click **Add roles and features**.  
  
2.  Click **Next** four times to get to the server feature selection screen.  
  
3.  On the **Select features** dialog, select **Network Load Balancing**, click **Add Features**, click **Next**, and then click **Install**.  
  
4.  On the **Installation progress** dialog, verify that the installation was successful, and then click **Close**.  
  
5.  Repeat this procedure on all servers that you want to be cluster members.  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Step 3: Configure a load-balanced cluster](Step-3-Configure-a-Load-Balanced-Cluster.md)  
  


