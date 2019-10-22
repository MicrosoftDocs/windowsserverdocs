---
title: Scale out your RDS deployment by adding an RD Session Host farm
description: Add a second RD Session Host to yur RDS environment.
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: elizapo
ms.date: 04/10/2017
ms.tgt_pltfrm: na
ms.topic: article
author: lizap
manager: dongill
---
# Scale out your Remote Desktop Services deployment by adding an RD Session Host farm

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016

You can improve the availability and scale of your RDS deployment by adding a Remote Desktop Session Host (RDSH) farm.   
  
 
Use the following steps to add another RD Sesssion Host to your deployment:  
  
1. Create a server to host the second RD Session Host. If you are using Azure virtual machines, make sure to include the new VM in the same availability set that holds your first RD Session Host.
2. Enable remote management on the new server or virtual machine:
   1. In Server Manager, click **Local Server > Remote management current setting (disabled)**. 
   2. Select **Enable remote management for this server**, and then click **OK**. 
   3. Optional: You can temporarily set Windows Update to not automatically download and install updates. This helps prevent changes and system restarts while you deploy the RDSH server. In Server Manager, click **Local Server > Windows Update current setting**. Click **Advanced options > Defer upgrades**. 
3. Add the server or vm to the domain:
   1. In Server Manager, click **Local Server > Workgroup current setting**. 
   2. Click **Change > Domain**, and then enter the domain name (for example, Contoso.com). 
   3. Enter the domain administrator credentials. 
   4. Restart the server or vm.
4. Add the new RD Session Host to the farm:
   >[!NOTE] 
   > Step 1, creating a public IP address for the RDMS virtual machine, is only necessary if you are using a vm for the RDMS and if it does not already have an IP address assigned.
   
   1. Create a public IP address for the virtual machine running Remote Desktop Management Services (RDMS). The RDMS virtual machine will typically be the virtual machine running the first instance of the RD Connection Broker role.  
       1. In the Azure portal, click **Browse > Resource groups**, click the resource group for the deployment and then click the RDMS virtual machine (for example, Contoso-Cb1).  
       2. Click **Settings > Network interfaces**, and then click the corresponding network interface.   
       3. Click **Settings > IP address**.
       4. For **Public IP address**, select **Enabled**, and then click **IP address**.   
       5. If you have an existing public IP address you want to use, select it from the list. Otherwise, click **Create new**, enter a name, and then click **OK** and then **Save**.   
   2. Sign into the RDMS.
   3. Add the new RDSH server to Server Manager:   
       1. Launch Server Manager, click **Manage > Add Servers**.   
       2. In the Add Servers dialog, click **Find Now**.   
       3. Select the server you want to use for the RD Session Host or the newly created virtual machine (for example, Contoso-Sh2) and click **OK**.
   4. Add the RDSH server to the deployment
       1. Launch Server Manager .  
       2. Click **Remote Desktop Services > Overview > Deployment Servers > Tasks > Add RD Session Host Servers**.   
       3. Select the new server (for example, Contoso-Sh2), and then click **Next**.  
       4. On the Confirmation page, select **Restart remote computers as needed**, and then click **Add**.   
   5. Add RDSH server to the collection farm:
       1. Launch Server Manager.   
       2. Click **Remote Desktop Services** and then click the collection to which you want to add the newly created RDSH server (for example, ContosoDesktop).   
       3. Under **Host Servers**, click **Tasks > Add RD Session Host Servers**.   
       4. Select the newly created server (for example, Contoso-Sh2), and then click **Next**.   
       5. On the Confirmation page, click **Add**.   

