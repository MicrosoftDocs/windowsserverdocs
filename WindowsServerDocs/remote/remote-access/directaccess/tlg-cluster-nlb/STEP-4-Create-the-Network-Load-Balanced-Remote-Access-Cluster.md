---
title: STEP 4 Create the Network Load Balanced Remote Access Cluster
description: This topic is part of the Test Lab Guide - Demonstrate DirectAccess in a Cluster with Windows NLB for Windows Server 2016
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-da
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 509eaa08-c49d-448d-a71e-c1c45519ccd5
ms.author: pashort
author: shortpatti
---
# STEP 4 Create the Network Load Balanced Remote Access Cluster

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

 Windows Server 2016, Windows Server 2012 R2 and Windows Server 2012 enable you to create clusters of Remote Access servers. A cluster acts as a single logical server and provides centralized configuration and management for the servers in the cluster. When using Network Load Balancing (NLB) there is support for up to 8 Remote Access members in a single cluster. Remote Access clusters provide high availability and load balancing of connections from DirectAccess clients to the internal network.  
  
The following procedures enable you to create and test a Remote Access cluster:  
  
1. Install the Network Load Balancing feature on EDGE1 and EDGE2. Before enabling load balancing, you must install the Network Load Balancing feature on both EDGE1 and EDGE2.
  
2. Enable load balancing on EDGE1. EDGE1 was originally installed in single server mode. To enable load balancing, you configure new external and internal dedicated IP addresses (DIPs) for EDGE1. The previous DIPs on EDGE1 are automatically configured as virtual IP addresses (VIPs) for the cluster. The new external DIP is 131.107.0.10, the new internal IPv4 DIP is 10.0.0.10, the new internal IPv6 DIP is 2001:db8:1::10. The cluster VIPs are 131.107.0.2 and 131.107.0.3 (external), and 10.0.0.2 and 2001:db8:1::2 (internal).
  
3. Add EDGE2 to the load balanced cluster. After enabling load balancing, you can now add EDGE2 to the cluster to provide load balancing and high availability for DirectAccess client connections.

## Prerequisites

If you are creating this test lab on virtual machines, you must enable MAC address spoofing on EDGE1 and EDGE2.  
  
### Enable MAC address spoofing on EDGE1 and EDGE2  
  
1.  Perform a graceful shutdown on EDGE1 and EDGE2.  
  
2.  On the machine hosting your virtual machines, in **Hyper-V Manager**, right-click EDGE1, and then click **Settings**.  
  
3.  On the **Settings** dialog box, in the **Hardware** list, click the network adapter connected to the corpnet network, and then in the details pane, select the **Enable spoofing of MAC addresses** check box.  
  
4.  In the **Hardware** list, click the network adapter connected to the Internet network, and then in the details pane, select the **Enable spoofing of MAC addresses** check box.  
  
5.  On the **Settings** dialog box, click **OK**.  
  
6.  Repeat this procedure from step 2 on EDGE2.  
  
## Install the Network Load Balancing feature on EDGE1 and EDGE2  
To configure EDGE1 and EDGE2 in a cluster, you must install the Network Load Balancing feature on both EDGE1 and EDGE2.  
  
### To install Network Load Balancing  
  
1.  On EDGE1, in the Server Manager console, in the **Dashboard**, click **Add roles and features**.  
  
2.  Click **Next** four times to get to the server feature selection screen.  
  
3.  On the **Select features** dialog, select **Network Load Balancing**, click **Add Features**, click **Next**, and then click **Install**.  
  
4.  On the **Installation progress** dialog, verify that the installation was successful, and then click **Close**.  
  
5.  Repeat this procedure on EDGE2.  
  
## Enable load balancing on EDGE1  
Use this procedure to enable load balancing and configure the new DIPs on EDGE1.  
  
### Enable load balancing  
  
1.  On EDGE1, click **Start**, type **RAMgmtUI.exe**, and then press ENTER. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.  
  
2.  In the Remote Access Management console, in the left pane, click **Configuration**, and then in the **Tasks** pane, click **Enable Load Balancing**.  
  
3.  In the Enable Load Balancing Wizard, click **Next**.  
  
4.  On the **Load Balancing Method** page, click **Use Windows Network Load Balancing (NLB)**, and then click **Next**.  
  
5.  On the **External Dedicated IP Addresses** page, in the **IPv4 address** box, type **131.107.0.10**, in the **Subnet mask** box, verify the subnet prefix is **255.255.255.0**, and then click **Next**.  
  
6.  On the **Internal Dedicated IP Addresses** page, do the following, and then click **Next**:  
  
    1.  In the **IPv4 address** box, type **10.0.0.10** and in the **Subnet mask** box, verify the subnet prefix is **255.255.255.0**.  
  
    2.  In the **IPv6 address** box, type **2001:db8:1::10** and in the Subnet prefix length, verify the value is **64**.  
  
7.  On the **Summary** page, click **Commit**.  
  
8.  On the **Enable Load Balancing** dialog box, click **Close**.  
  
9. In the Enable Load Balancing Wizard, click **Close**.  
  
## Add EDGE2 to the load balanced cluster  
Use this procedure to add EDGE2 to the NLB cluster.  
  
> [!NOTE]  
> You should wait two minutes after completing the previous steps before proceeding. After enabling NLB, the RAConfigTask runs and configures the machine with NLB settings. This might take a few minutes to complete, and if the administrator runs another NLB related configuration before the task ends, that configuration will fail.  
  
### Add EDGE2 to the cluster  
  
1.  On the EDGE1 computer or virtual machine, in the Remote Access Management Console, in the **Tasks** pane, under **Load Balanced Cluster**, click **Add or Remove Servers**.  
  
2.  On the **Add or Remove Servers** dialog box, click **Add Server**.  
  
3.  On the **Add a Server** wizard, on the **Select Server** page, type **EDGE2**, and then click **Next**.  
  
4.  On the **Network Adapters** page, in **External adapter**, make sure that **Internet** is selected, and in **Internal adapter**, make sure that **Corpnet** is selected. Click **Browse**, on the **Windows Security** dialog box, make sure that **IP-HTTPS Certificate** is selected, click **OK**, and then click **Next**.  
  
5.  On the **Summary** page, click **Add**.  
  
6.  On the **Completion** page, click **Close**.  
  
7.  On the **Add or Remove Servers** dialog box, click **Commit**.  
  
8.  On the **Adding and Removing Servers** dialog box, click **Close**.  
  
9. On the **Start** screen, type**nlbmgr.exe**, and the press ENTER. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.  
  
10. In the **Network Load Balancing Manager**, click **Internal DA cluster**. In the details pane, make sure that both **EDGE1(Corpnet)** and **EDGE2(Corpnet)** have the status **Converged**.  
  
11. If a server is not **Converged**, in the console tree, right-click the server, point to **Control Host**, and then click **Start**.  
  
12. In the **Network Load Balancing Manager**, click **Internet DA cluster**. Make sure that in the details pane, both **EDGE1(Internet)** and **EDGE2(Internet)** have the status **Converged**.  
  
13. If a server is not **Converged**, in the console tree, right-click the server, point to **Control Host**, and then click **Start**.
