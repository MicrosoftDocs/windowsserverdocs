---
title: Create virtual machines for Remote Desktop
description: Create VMs to host Remote Desktop components in the cloud.
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: elizapo
ms.date: 08/01/2016
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b0f62d6f-0915-44ca-afef-be44a922e20e
author: lizap
manager: dongill
---
# Create virtual machines for Remote Desktop

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016

Use the following steps to create the virtual machines in the tenant's environment that will be used to run the Windows Server 2016 roles, services, and features required for a desktop hosting deployment.   
  
For this example of a basic deployment, the minimum of 3 virtual machines will be created. One virtual machine will host the Remote Desktop (RD) Connection Broker and License Server role services and a file share for the deployment. A second virtual machine will host the RD Gateway and Web Access role services.  A third virtual machine host the RD Session Host role service. For very small deployments, you can reduce VM costs by using AAD App Proxy to eliminate all public endpoints from the deployment and combining all the role services onto a single VM. For larger deployments, you can install the various role services on individual virtual machines to allow better scaling.  
  
This section outlines the steps necessary to deploy virtual machines for each role based on Windows Server images in the [Microsoft Azure Marketplace](https://azure.microsoft.com/marketplace/). If you need to create virtual machines from a custom image, which requires PowerShell, check out [Create a Windows VM with Resource Manager and PowerShell](https://azure.microsoft.com/documentation/articles/virtual-machines-windows-ps-create/). Then return here to attach Azure data disks for the file share and enter an external URL for your deployment.  
  
1. [Create Windows virtual machines](https://azure.microsoft.com/documentation/articles/virtual-machines-windows-hero-tutorial/) to host the RD Connection Broker, RD License Server, and File server.  
  
   For our purpose, we used the following naming conventions:  
   - RD Connection Broker, License Server, and File Server:   
       - VM: Contoso-Cb1  
       - Availability set: CbAvSet    
   - RD Web Access and RD Gateway Server:   
       - VM: Contoso-WebGw1  
       - Availability set: WebGwAvSet  
          
   - RD Session Host:   
       - VM: Contoso-Sh1  
       - Availability set: ShAvSet  
          
   Each VM uses the same resource group.  
2. Create and attach an Azure data disk for the user profile disk (UPD) share:  
   1.  In the Azure portal click **Browse > Resource groups**, click the resource group for the deployment, and then click the VM created for the RD Connection Broker (for example, Contoso-Cb1).  
   2.  Click **Settings > Disks > Attach new**.  
   3.  Accept the defaults for name and type.  
   4.  Enter a size (in GB) that is large enough to hold network shares for the tenant's environment, including user profile disks and certificates. You can approximate 5 GB per user you plan to have  
   5.  Accept the defaults for location and host caching, and then click **OK**.  
3. Create an external load balancer to access the deployment externally:
   1. In the Azure portal click **Browse > Load balancers**, and then click **Add**.
   2. Enter a **Name**, select **Public** as the **Type** of load balancer, and select the appropriate **Subscription**, **Resource Group**, and **Location**.
   3. Select **Choose a public IP address**, **Create new**, enter a name, and select **Ok**.
   4. Select **Create** to create the load balancer.
4. Configure the external load balancer for your deployment
   1. In the Azure portal click **Browse > Resource groups**, click the resource group for the deployment, and then click the load balancer you created for the deployment.
   2. Add a backend pool for the load balancer to send traffic to:
       1. Select **Backend pool** and **Add**.
       2. Enter a **Name** and select **\+ Add a virtual machine**.
       3. Select **Availability set** and **WebGwAvSet**.
       4. Select **Virtual machines**, **Contoso-WebGw1**, **Select**, **OK**, and **OK**.
   3. Add a probe so the load balancer knows what machines are active:
       1. Select **Probes** and **Add**.
       2. Enter a **Name** (like HTTPS), select **TCP**, enter **Port** 443, and select **OK**.
   4. Enter load balancing rules to balance the incoming traffic:
      1. Select **Load balancing rules** and **Add**
      2. Enter a **Name** (like HTTPS), select **TCP**, and 443 for both the **Port** and the **Backend port**.
          - For a Windows 10 and Windows Server 2016 Deployment, leave **Session persistence** as **None**, otherwise select **Client IP**.
      3. Select **OK** to accept the HTTPS rule.
      4. Create a new rule by selecting **Add**.
      5. Enter a **Name** (like UDP), select **UDP**, and 3391 for both the <strong>port and the **Backend port</strong>.
          - For a Windows 10 and Windows Server 2016 deployment, leave **Session persistence** as **None**, otherwise select **Client IP**.
      6. Select **OK** to accept the UDP rule.
   5. Enter an inbound NAT rule to directly connect to Contoso-WebGw1
       1. Select **Inbound NAT rules** and **Add**.
       2. Enter a **Name** (like RDP-Contoso-WebGw1), select **Customm** for the service, **TCP** for the protocol, and enter 14000 for the **Port**.
       3. Select **Choose a virtual machine** and Contoso-WebGw1.
       4. Select **Custom** for the port mapping, enter 3389 for the **Target port**, and select **OK**.
5. Enter an external URL/DNS name for your deployment to access it externally:  
   1.  In the Azure portal, click **Browse > Resource groups**, click the resource group for the deployment, and then click the public IP address you created for RD Web Access and RD Gateway.  
   2.  Click **Configuration**, enter a DNS name label (like contoso), and then click **Save**. This DNS name label (contoso.westus.cloudapp.azure.com) is the DNS name that you'll use to connect to your RD Web Access and RD Gateway server.  

