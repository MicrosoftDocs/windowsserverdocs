---
title: Add high availability to the RD Web and Gateway web front
description: Provides steps for installing the RD Web and Gateway servers in an RDS deployment.
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
author: lizap
ms.author: elizapo
ms.date: 11/08/2016
manager: dongill
---
# Add high availability to the RD Web and Gateway web front

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016


You can deploy a Remote Desktop Web Access (RD Web Access) and Remote Desktop Gateway (RD Gateway) farm to improve the availability and scale of a Windows Server Remote Desktop Services (RDS) deployment 

Use the following steps to add an RD Web and Gateway server to an existing Remote Desktop Services basic deployment.  

## Pre-requisites

Set up a server to act as an additional RD Web and RD Gateway - this can be either a physical server or VM. This includes joining the server to the domain and enabling remote management.

## Step 1: Configure the new server to be part of the RDS environment

1. Connect to the RDMS server in the Azure portal, using Remote Desktop Connection client.
2. Add the new RD Web and Gateway server to Server Manager:
    1. Launch Server Manager, click **Manage > Add Servers**.   
    2. In the Add Servers dialog, click **Find Now**.   
    3. Select the newly created RD Web and Gateway server (for example, Contoso-WebGw2) and click **OK**.
3. Add RD Web and Gateway servers to the deployment  
    1. Launch Server Manager .  
    2. Click **Remote Desktop Services > Overview > Deployment Servers > Tasks > Add RD Web Access Servers**.   
    3. Select the newly created server (for example, Contoso-WebGw2), and then click **Next**.  
    4. On the Confirmation page, select **Restart remote computers as needed**, and then click **Add**.  
    5. Repeat these steps to add the RD Gateway server, but choose **RD Gateway Servers** in step b.
4. Re-install certificates for the RD Gateway servers:
   1. In Server Manager on the RDMS server, click **Remote Desktop Services > Overview > Tasks > Edit Deployment Properties**.  
   2. Expand **Certificates**.  
   3. Scroll down to the table. Click RD **Gateway Role Service > Select existing certificate.**  
   4. Click **Choose a different certificate** and then browse to the certificate location. For example, \Contoso-CB1\Certificates). Select the certificate file for the RD Web and Gateway server created during the prerequisites (e.g. ContosoRdGwCert), and then click **Open**.  
   5. Enter the password for the certificate, select **Allow the certificate to be added to the Trusted Root Certificate Authorities certificate store on the destination computers**, and then click **OK**.  
   6. Click **Apply**.
      > [!NOTE] 
      > You may need to manually restart the TSGateway service running on each RD Gateway server, either through Server Manager or Task Manager.
   7. Repeat steps a through f for the RD Web Access Role Service.

## Step 2: Configure RD Web and RD Gateway properties on the new server
1. Configure the server to be part of an RD Gateway farm:
    1.  In Server Manager on the RDMS server, click **All Servers**. Right-click one of the RD Gateway servers, and then click **Remote Desktop Connection**.
    2.  Sign into to the RD Gateway server using a domain admin account.  
    3.  In Server Manager on the RD Gateway server, click **Tools > Remote Desktop Services > RD Gateway Manager**.  
    4.  In the navigation pane, click the local computer (e.g. Contoso-WebGw1).  
    5.  Click **Add RD Gateway Server Farm members**.  
    6.  On the **Server Farm** tab, enter the name of each RD Gateway server, then click **Add** and **Apply**.  
    7.  Repeat steps a through f on each RD Gateway server so that they recognize each other as RD Gateway servers in a farm. Do not be alarmed if there are warnings, as it might take time for DNS settings to propagate.
2. Configure the server to be part of an RD Web Access farm. The steps below configure the Validation and Decryption Machine Keys to be the same on both RDWeb sites.
    1.  In Server Manager on the RDMS server, click **All Servers**. Right-click the first RD Web Access server (e.g. Contoso-WebGw1) and then click **Remote Desktop Connection**.  
    2.  Sign into the RD Web Access server using a domain admin account.  
    3.  In Server Manager on the RD Web Access server, click **Tools > Internet Information Services (IIS) Manager**.  
    4.  In the left pane of IIS Manager, expand the **Server (e.g. Contoso-WebGw1) > Sites > Default Web Site**, and then click **RDWeb**.  
    5.  Right-click **Machine Key**, and then click **Open Feature**.
    6.  On the Machine Key page, in the **Actions** pane, select **Generate Keys**, and then click **Apply**.
    7.  Copy the validation key (you can right-click the key and then click **Copy**.)
    8.  In IIS Manager, under **Default Web Site**, select **Feed**, **FeedLogon** and **Pages** in turn.
    9. For each:
        1.  Right-click **Machine Key**, and then click **Open Feature**.
        2.  For the Validation Key, clear **Automatically generate at runtime**, and then paste the key you copied in step g.
    10.  Minimize the RD Connection window to this RD Web server.  
    11.  Repeat steps b through e for the second RD Web Access server, ending on the feature view of **Machine Key**.
    12. For the Validation Key, clear **Automatically generate at runtime**, and then paste the key you copied in step g.
    13. Click **Apply**.
    14. Complete this process for the **RDWeb**, **Feed**, **FeedLogon** and **Pages** pages.
    15. Minimize the RD Connection window to the second RD Web Access server, and then maximize the RD Connection window to the first RD Web Access server.  
    16. Repeat steps g through n to copy over the Decryption Key.
    17. When validation keys and decryption keys are identical on both RD Web Access servers for the **RDWeb**, **Feed**, **FeedLogon** and **Pages** pages, sign out of all RD Connection windows.

## Step 3: Configure load balancing for the RD Web and RD Gateway servers

If you are using Azure infrastructure, you can create an external Azure load balancer; if not, you can set up a separate hardware or software load balancer. Load balancing is key so that traffic will be evenly distributed the long-lived connections from Remote Desktop clients, through the RD Gateway, to the servers that users will be running their workloads.

> [!NOTE] 
> If your previous server running RD Web and RD Gateway was already set up behind an external load balancer, skip ahead to step 4, select the existing backend pool, and add the new server to the pool.

1.  Create an Azure Load Balancer:  
    1.  In the Azure portal click **Browse > Load balancers > Add**.  
    2.  Enter a name, for example **WebGwLB**.  
    3.  Select **Public** for the **Scheme**.
    4.  Under **Public IP address**, select **Choose a public IP address**, and then pick an existing public IP address or create a new one.
    5.  Select the appropriate **Subscription**, **Resource Group**, and **Location**.
    6.  Click **Create**.  
2. Create a [probe](https://azure.microsoft.com/documentation/articles/load-balancer-custom-probe-overview/) to monitor which servers are alive:  
    1.  In the Azure portal, select **Browse** > **Load Balancers**, and then choose the load balancer that you created in the previous step.
    2.  Select **All settings** > **Probes** > **Add**.  
    3.  Enter a name, for example, **HTTPS**, for the probe. Select **TCP** as the **Protocol**, and enter **443** for the **Port**, then click **OK**.   
3.  Create the HTTPS and UDP load balancing rules:  
    1.  In **Settings**, click **Load balancing rules**.  
    2.  Select **Add** for the **HTTPS rule**.  
    3.  Enter a name for the rule, for example, HTTPS, and select **TCP** for the **Protocol**. Enter **443** for both **Port** and **Backend port**, and click **OK**.  
    4.  In **Load balancing rules**, click **Add** for the **UDP rule**.  
    5.  Enter a name for the rule, for example, **UDP**, and select **UDP** for the **Protocol**. Enter **3391** for both **Port** and **Backend port**, and click **OK**.  
4. Create the backend pool for the RD Web and RD Gateway servers:
      1. In **Settings**, click **Backend address pools > Add**.   
      2. Enter a name (for example, **WebGwBackendPool**), then click **Add a virtual machine**.  
      3. Choose an availability set (for example, WebGwAvSet), and then click **OK**.   
      4. Click **Choose the virtual machines**, select each virtual machine, and then click **Select > OK > OK**.
