---
title: Add RD Web and Gateway server to the RDS deployment
description: Provides steps for installing the RD Web and Gateway servers in an RDS deployment.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ac7e1cf8-b63f-4a3b-92ef-56dc8512f7db
author: lizap
ms.author: elizapo
ms.date: 11/08/2016
manager: dongill
---
# Add RD Web and Gateway server to the RDS deployment

>Applies To: Windows Server 2016

Use the following steps to add the RD Web and Gateway server you created to your existing Remote Desktop Services basic deployment.  

>[!NOTE] 
> Step 1, creating a public IP address for the RDMS virtual machine, is only necessary if it does not already have one assigned.

 
1. Create a public IP address for the virtual machine running Remote Desktop Management Services (RDMS). The RDMS virtual machine will typically be the virtual machine running the first instance of the RD Connection Broker role.  
    1. In the Azure portal, click **Browse > Resource groups**, click the resource group for the deployment and then click the RDMS virtual machine (for example, Contoso-Cb1).  
    2. Click **Settings > Network interfaces**, and then click the corresponding network interface.   
    3. Click **Settings > IP address**.
    4. For **Public IP address**, select **Enabled**, and then click **IP address**.   
    5. If you have an existing public IP address you want to use, select it from the list. Otherwise, click **Create new**, enter a name, and then click **OK** and then **Save**.   
2. Connect to the RDMS virtual machine:   
    1.  In the Azure portal click **Browse > Resource groups** and click the resource group for the deployment.  
    2.  Select the new RDMS virtual machine (for example, Contoso-Cb1).  
    3.  Click **Connect > Open** to open the Remote Desktop client.  
    4.  In the client, click **Connect**, and then click **Use another user account**. Enter the user name and password for a domain administrator account.  
    5.  Click **Yes** when warned about the certificate.  
3.  Add the new RD Web and Gateway server to Server Manager:  
    1. Launch Server Manager, click **Manage > Add Servers**.   
    2. In the Add Servers dialog, click **Find Now**.   
    3. Select the newly created RD Session Host server (for example, Contoso-WebGw2) and click **OK**.
 4. Add RD Web and Gateway servers to the deployment  
    1. Launch Server Manager .  
    2. Click **Remote Desktop Services > Overview > Deployment Servers > Tasks > Add RD Web Access Servers**.   
    3. Select the newly created server (for example, Contoso-WebGw2), and then click **Next**.  
    4. On the Confirmation page, select **Restart remote computers as needed**, and then click **Add**.  
    5. Repeat these steps to add the RD Gateway server, but choose **RD Gateway Servers** in step b.  
5.  Add the RD Gateway servers to a farm:  
    1.  In Server Manager on the RDMS server, click **All Servers**. Right-click one of the RD Gateway servers, and then click **Remote Desktop Connection**.  
    2.  Sign into to the RD Gateway server using a domain admin account.  
    3.  In Server Manager on the RD Gateway server, click **Tools > Terminal Services > RD Gateway Manager**.  
    4.  In the navigation pane, click the local computer (e.g. Contoso-WebGw1).  
    5.  Click **Add RD Gateway Server Farm members**.  
    6.  On the **Server Farm** tab, enter the name of each RD Gateway server, then click **Add** and **Apply**.  
    7.  Repeat steps 1-6 for each RD Gateway server
7.  Add the RD Web Access servers to a farm. The steps below configure the Validation and Decryption Machine Keys to be the same on both RDWeb sites.  
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
8.  Re-install certificates for the RD Gateway servers:  
    1.  In Server Manager on the RDMS server, click **Remote Desktop Services > Overview > Tasks > Edit Deployment Properties**.  
    2.  Expand **Certificates**.  
    3.  Scroll down to the table. Click RD **Gateway Role Service > Select existing certificate.**  
    4.  Click **Choose a different certificate** and then browse to the certificate location. For example, \Contoso-CB1\Certificates). Select the certificate file for the RD Web and Gateway server created during the prerequisites (e.g. ContosoRdGwCert), and then click **Open**.  
    5.  Enter the password for the certificate, select **Allow the certificate to be added to the Trusted Root Certificate Authorities certificate store on the destination computers**, and then click **OK**.  
    6.  Click **Apply**.   
    7.  Repeat steps 1-6 for the RD Web Access Role Service.
