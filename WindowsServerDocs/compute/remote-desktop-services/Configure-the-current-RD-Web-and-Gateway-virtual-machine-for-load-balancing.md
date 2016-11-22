---
title: Configure the current RD Web and Gateway virtual machine for load balancing
description: Learn how to set up load balancing in RDS.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: elizapo
ms.date: 08/01/2016
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 03feb939-bba9-483c-aedd-cfc8986aaa26
author: lizap
manager: dongill
---
# Configure the current RD Web and Gateway virtual machine for load balancing

>Applies To: Windows Server 2016

Use the following steps to configure load balancing for the RD Web and Gateway virtual machine:  
  
1.  Remove the public IP address from the first RD Web and Gateway server:  
    1.  In the Azure portal, click **Browse > Virtual Machines**. Click the first WebGw server virtual machine (for example, Contoso-WebGw1), and then selec the value for **Public IP address/DNS name**.  
    2.  Click **Dissociate**.  
2.  Create an Azure Load Balancer:  
a.  In the Azure portal click **Browse > Load balancers > Add**.  
b.  Enter a name, for example **WebGwLB**.  
c.  Select **Public** for the **Scheme**, **Public IP address**, and the **Public IP address** that you just dissociated in the previous step that has the DNS name label for your deployment.  
d.  Select the appropriate **Subscription**, **Resource Group**, and **Location**.  
e.  Click **Create**.  
3. Create a [probe](https://azure.microsoft.com/documentation/articles/load-balancer-custom-probe-overview/) to monitor which servers are alive:  
    1.  In the Azure portal click **Browse > Load Balancers**., the load balancer you just created, e.g. WebGwLB, and Settings  
    2.  Click **Probes > Add**.  
    3.  Enter a name, for example, **HTTPS**, for the probe. Select **TCP** as the **Protocol**, and enter **443** for the **Port**, then click **OK**.  
4. Create the backend pool of the Connection Brokers:   
  
      1. In **Settings**, click **Backend address pools > Add**.   
  
      2. Enter a name (for example, **WebGwBackendPool**), then click **Add a virtual machine**.  
        
      3. Choose an availability set (for example, WebGwAvSet), and then click **OK**.   
  
      4. Click **Choose the virtual machines**, select each virtual machine, and then click **Select > OK > OK**.   
5.  Create the HTTPS and UDP load balancing rules:  
    1.  In **Settings**, click **Load balancing rules**.  
    2.  Select **Add** for the **HTTPS rule**.  
    3.  Enter a name for the rule, for example, HTTPS, and select **TCP** for the **Protocol**. Enter **443** for both **Port** and **Backend port**, and click **OK**.  
    4.  In **Load balancing rules**, click **Add** for the **UDP rule**.  
    5.  Enter a name for the rule, for example, **UDP**, and select **UDP** for the **Protocol**. Enter **3391** for both **Port** and **Backend port**, and click **OK**.  


