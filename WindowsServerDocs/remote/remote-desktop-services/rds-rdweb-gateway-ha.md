---
title: Add high availability to the RD Web and Gateway web front
description: Provides steps for installing the RD Web and Gateway servers in an RDS deployment.
ms.custom: na
ms.prod: windows-server-threshold
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

>Applies To: Windows Server 2016


You can deploy a Remote Desktop Web Access (RD Web Access) and Remote Desktop Gateway (RD Gateway) farm to improve the availability and scale of a Windows Server Remote Desktop Services (RDS) deployment 

Use the following steps to add an RD Web and Gateway server to an existing Remote Desktop Services basic deployment.  

1. Set up a server or virtual machine to host the RD Web and Gateway roles.
2. Connect to the RDMS.  
3. Add the new RD Web and Gateway server to Server Manager:
    1. Launch Server Manager, click **Manage > Add Servers**.   
    2. In the Add Servers dialog, click **Find Now**.   
    3. Select the newly created RD Session Host server (for example, Contoso-WebGw2) and click **OK**.
 4. Add RD Web and Gateway servers to the deployment  
    1. Launch Server Manager .  
    2. Click **Remote Desktop Services > Overview > Deployment Servers > Tasks > Add RD Web Access Servers**.   
    3. Select the newly created server (for example, Contoso-WebGw2), and then click **Next**.  
    4. On the Confirmation page, select **Restart remote computers as needed**, and then click **Add**.  
    5. Repeat these steps to add the RD Gateway server, but choose **RD Gateway Servers** in step b.  
4. Add the RD Gateway servers to a farm:
    1.  In Server Manager on the RDMS server, click **All Servers**. Right-click one of the RD Gateway servers, and then click **Remote Desktop Connection**.  
    2.  Sign into to the RD Gateway server using a domain admin account.  
    3.  In Server Manager on the RD Gateway server, click **Tools > Terminal Services > RD Gateway Manager**.  
    4.  In the navigation pane, click the local computer (e.g. Contoso-WebGw1).  
    5.  Click **Add RD Gateway Server Farm members**.  
    6.  On the **Server Farm** tab, enter the name of each RD Gateway server, then click **Add** and **Apply**.  
    7.  Repeat steps 1-6 for each RD Gateway server
5. Add the RD Web Access servers to a farm. The steps below configure the Validation and Decryption Machine Keys to be the same on both RDWeb sites.
    1.  In Server Manager on the RDMS server, click **All Servers**. Right-click the first RD Web Access server, e.g. Contoso-WebGw1, and then click **Remote Desktop Connection**.  
    2.  Sign into the RD Web Access server using a Domain Admin account.  
    3.  Now, on the RD Web Access server, launch Server Manager. Click **Tools > Terminal Services > Internet Information Services (IIS) Manager**.  
    4.  In the IIS Manager's left pane, expand the local computer (e.g. Contoso-WebGw1) > Sites > Default Web Site, and then click **RDWeb**.  
    5.  Right-click **Machine Key**, and then click **Open Feature**.  
    6.  On the Machine Key page, in the **Actions** pane, select **Generate Keys**, and then click **Apply**.  
    7.  Copy the validation key (you can right-click the key and then click **Copy**.)  
    8.  Minimize the RD Connection window to this RD Web server.  
    9.  Repeat steps 2 through 5 for the second RD Web Access server  
    10. For the Validation Key, clear **Automatically generate at runtime**, and then paste the key you copied in step g.   
    11. Click **Apply**.  
    12. Minimize the RD Connection window to the second RD Web Access server, and then maximize the RD Connection window to the first RD Web Access server.  
    14. Repeat steps 7-11 for the Decryption Key.  
    15. When validation keys and decryption keys are identical on both RD Web Access servers, sign out of all RD Connection windows.  
6. Re-install certificates for the RD Gateway servers:
    1.  In Server Manager on the RDMS server, click **Remote Desktop Services > Overview > Tasks > Edit Deployment Properties**.  
    2.  Expand **Certificates**.  
    3.  Scroll down to the table. Click RD **Gateway Role Service > Select existing certificate.**  
    4.  Click **Choose a different certificate** and then browse to the certificate location. For example, \Contoso-CB1\Certificates). Select the certificate file for the RD Web and Gateway server created during the prerequisites (e.g. ContosoRdGwCert), and then click **Open**.  
    5.  Enter the password for the certificate, select **Allow the certificate to be added to the Trusted Root Certificate Authorities certificate store on the destination computers**, and then click **OK**.  
    6.  Click **Apply**.   
    7.  Repeat steps 1-6 for the RD Web Access Role Service.


### Set up load balancing

Next configure load balancing for the RD Web and Gateway. These steps assume you are using Azure Load Balancer for load balancing. Use the following steps:  
  
1.  Create an Azure Load Balancer:  
   1.  In the Azure portal click **Browse > Load balancers > Add**.  
   2.  Enter a name, for example **WebGwLB**.  
   3.  Select **Public** for the **Scheme**, **Public IP address**, and the **Public IP address** that you just dissociated in the previous step that has the DNS name label for your deployment.  
   4.  Select the appropriate **Subscription**, **Resource Group**, and **Location**.  
   5.  Click **Create**.  
3. Create a [probe](https://azure.microsoft.com/documentation/articles/load-balancer-custom-probe-overview/) to monitor which servers are alive:  
    1.  In the Azure portal click **Browse > Load Balancers**., the load balancer you just created, e.g. WebGwLB, and Settings  
    2.  Click **Probes > Add**.  
    3.  Enter a name, for example, **HTTPS**, for the probe. Select **TCP** as the **Protocol**, and enter **443** for the **Port**, then click **OK**.  
4. Create the backend pool for the Connection Brokers:   
  
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


