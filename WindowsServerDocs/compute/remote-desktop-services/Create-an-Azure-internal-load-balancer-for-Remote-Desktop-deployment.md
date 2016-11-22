---
title: Create an Azure internal load balancer for Remote Desktop deployment
description: Learn how to create an Azure internal load balancer for RDS.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: elizapo
ms.date: 08/01/2016
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 35f1cd3b-4eb0-40e3-8e48-20e779fd42dc
author: lizap
manager: dongill
---
# Create an Azure internal load balancer for Remote Desktop deployment

>Applies To: Windows Server 2016

This section provides steps to deploy an Azure Internal Load Balancer to effectively load balance incoming connections to the RD Connection Brokers setup in High Availability. Another method of load balancing is DNS round-robin, which is detailed below in the Appendix.   
  
## Create a load balancer  
1. Create an Azure Load Balancer   
      1. In the Azure portal click **Browse > Load balancers > Add**.   
      2. Enter a name for the new load balancer (for example, hacb).   
      3. Select **Internal** for the **Scheme**, **Virtual Network** for your deployment (for example, Contoso-VNet), and the **Subnet** with all of your resources (for example, default).   
      4. Select **Static** for the **IP address assignment** and enter a **Private IP address** that is not currently in use (for example, 10.0.0.32).   
      5. Select the appropriate **Subscription**, the **Resource group** with all of your resources, and the appropriate **Location**.   
      6. Select **Create**.   
2. Create a [probe](https://azure.microsoft.com/documentation/articles/load-balancer-custom-probe-overview/) to monitor which servers are active:   
      1. In Azure portal, click **Browse > Load Balancers**, and then click the load balancer you just created, (for example, CBLB). Click **Settings**.   
      2. Click **Probes > Add**.   
      3. Enter a name for the probe (for example, **RDP**), select **TCP** as the **Protocol**, enter **3389** for the **Port**, and then click **OK**.   
3. Create the backend pool of the Connection Brokers:   
      1. In **Settings**, Click **Backend address pools > Add**.   
      2. Enter a name (for example, CBBackendPool), then click **Add a virtual machine**.  
      3. Choose an availability set (for example, CbAvSet), and then click **OK**.   
      3. Click **Choose the virtual machines**, select each virtual machine, and then click **Select > OK > OK**.   
4. Create the RDP load balancing rule:   
      1. In **Settings**, click **Load balancing rules**, and then click **Add**.   
      2. Enter a name (for example, RDP), select **TCP** for the **Protocol**, enter **3389** for both **Port** and **Backend port**, and click **OK**.   
5. Add a DNS record for the Load Balancer:   
      1. Connect to the RDMS server virtual machine (for example, Contoso-CB1). Check out the [Prepare the RD Connection Broker VM](Prepare-the-RD-Connection-Broker-VM-for-Remote-Desktop.md) article for steps on how you connect to the VM.   
      2. In Server Manager, click **Tools > DNS**.   
      3. In the left-hand pane, expand **DNS**, click the DNS machine, click **Forward Lookup Zones**, and then click your domain name (for example, Contoso.com). (It might take a few seconds to process the query to the DNS server for the information.)  
      4. Click **Action > New Host (A or AAAA)**.   
      9. Enter the name (for example, hacb) and the IP address specified earlier (for example, 10.0.0.32).   
  
## Configure DNS round-robin  
  
The following steps are an alternative to creating an Azure Internal Load Balancer.   
  
1. Connect to the RDMS server in the Azure portal. using Remote Desktop Connection client   
2. Create DNS records:   
      1. In Server Manager, click **Tools > DNS**.   
      2. In the left-hand pane, expand **DNS**, click the DNS machine, click **Forward Lookup Zones**, and then click your domain name (for example, Contoso.com). (It might take a few seconds to process the query to the DNS server for the information.)  
      3. Click **Action** and **New Host (A or AAAA)**.   
      4. Enter the **DNS Name** for the RD Connection Broker cluster (for example, hacb), and then enter the **IP address** of the first RD Connection Broker.   
      5. Repeat steps 3-4 for each additional RD Connection Broker, providing each unique IP address for each additional record.


For example, if the IP addresses for the two RD Connection Broker virtual machines are 10.0.0.8 and 10.0.0.9, you would create two DNS host records:
 - Host name: hacb.contoso.com , IP address: 10.0.0.8
 - Host name: hacb.contoso.com , IP address: 10.0.0.9