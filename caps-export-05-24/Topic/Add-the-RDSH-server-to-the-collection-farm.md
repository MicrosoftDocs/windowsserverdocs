---
title: Add the RDSH server to the collection farm
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1905e1fc-bd2c-45d9-95f2-d4ff55ea2481
author: lizap
---
# Add the RDSH server to the collection farm
Now that your environment is ready, use the following steps to add the Remote Desktop Session Host server to the collection farm.  
  
1. Create a public IP address for the virtual machine running Remote Desktop Management Services (RDMS). The RDMS virtual machine will typically be the virtual machine running the first instance of the RD Connection Broker role.   
  
    Note that this procedure is not necessary if a public IP address already exists for the RDMS virtual machine to permit RDP connections.   
  
    1. In the Azure portal, click **Browse > Virtual Machines**, and then click the RDMS virtual machine (for example, Contoso-CB1).  
    2. Click **Settings > Network interfaces**, and then click the corresponding network interface.   
    3. Click **Settings > IP address**.   
  
    4. For **Public IP address**, select **Enabled**, and then click **IP address**.   
    5. If you have an existing public IP address you want to use, select it from the list. Otherwise, click **Create new**, enter a name, and then click **OK** and then **Save**.   
2. Connect to the RDMS virtual machine:   
    1.	In the Azure portal click **Browse > Virtual Machines**.  
    2.	Select the new RDMS virtual machine (for example, Contoso-CB1).  
    3.	Click **Connect > Open** to open the Remote Desktop client.  
    4.	In the client, click **Connect**, and then click **Use another user account**. Enter the user name and password for a user in the Azure AD DC Administrators group.  
    5.	Click **Yes** when warned about the certificate.  
3. Add the new RDSH server to Server Manager:   
    1. Launch Server Manager, click **Manage > Add Servers**.   
    2. In the Add Servers dialog, click **DNS**.   
    3. Browse to and select the newly created RD Session Host server, e.g. Contoso-SH2.   
    4. Click **OK**.   
4. Add the RDSH server to the deployment   
    1. Launch Server Manager .  
    2. Click **Remote Desktop Services > Overview > Deployment Servers > Tasks > Add RD Session Host Servers**.   
    3. Select the newly created server (for example, Contoso-SH2), and then click **Next**.  
    4. On the Confirmation page, select **Restart remote computers as needed**, and then click **Add**.   
5. Add RDSH server to the collection farm:   
    1. Launch Server Manager.   
    2. Click **Remote Desktop Services** and then click the collection to which you want to add the newly created RDSH server (for example, ContosoDesktop).   
    3. Under **Host Servers**, click **Tasks > Add RD Session Host Servers**.   
    4. Select the newly created server (for example, Contoso-SH2), and then click **Next**.   
    5. On the Confirmation page, click **Add**.   
