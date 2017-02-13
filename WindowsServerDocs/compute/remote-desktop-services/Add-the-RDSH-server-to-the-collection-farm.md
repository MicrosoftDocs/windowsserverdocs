---
title: Add the RDSH server to the collection farm
description: Learn how to add an RD Session Host to an RDS collection farm.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services 
ms.author: elizapo
ms.date: 11/08/2016
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1905e1fc-bd2c-45d9-95f2-d4ff55ea2481
author: lizap
manager: dongill
---
# Add the RDSH server to the collection farm

>Applies To: Windows Server 2016

Now that your environment is ready, use the following steps to add the Remote Desktop Session Host server to the collection farm.  

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
3. Add the new RDSH server to Server Manager:   
    1. Launch Server Manager, click **Manage > Add Servers**.   
    2. In the Add Servers dialog, click **Find Now**.   
    3. Select the newly created RD Session Host server (for example, Contoso-Sh2) and click **OK**.
4. Add the RDSH server to the deployment   
    1. Launch Server Manager .  
    2. Click **Remote Desktop Services > Overview > Deployment Servers > Tasks > Add RD Session Host Servers**.   
    3. Select the newly created server (for example, Contoso-Sh2), and then click **Next**.  
    4. On the Confirmation page, select **Restart remote computers as needed**, and then click **Add**.   
5. Add RDSH server to the collection farm:   
    1. Launch Server Manager.   
    2. Click **Remote Desktop Services** and then click the collection to which you want to add the newly created RDSH server (for example, ContosoDesktop).   
    3. Under **Host Servers**, click **Tasks > Add RD Session Host Servers**.   
    4. Select the newly created server (for example, Contoso-Sh2), and then click **Next**.   
    5. On the Confirmation page, click **Add**.   


