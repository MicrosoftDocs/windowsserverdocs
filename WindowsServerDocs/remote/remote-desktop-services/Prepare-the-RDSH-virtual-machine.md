---
title: Prepare the RDSH virtual machine
description: Get the VM ready for the RD Session Host
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: elizapo
ms.date: 08/01/2016  
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d720a65e-b33c-4577-84ad-d84f47dee15b
author: lizap
manager: dongill
---
# Prepare the RDSH virtual machine

>Applies To: Windows Server 2016

Use the following steps to prepare the virtual machine for the Remote Desktop Session Host server:  
  
1.  Connect to the virtual machine:  
    1.  In the Azure portal click **Browse > Resource groups** and click the resource group for the deployment.  
    2.  Select the new RDSH virtual machine (for example, Contoso-Sh2).  
    3.  Click **Connect > Open**.  
    4.  In the client, click **Connect**, and then click **Use another user account**. Enter the user name and password for the local administrator account.  
    5.  Click **Yes** when warned about the certificate.  
2.  Enable remote management:  
    1.  In Server Manager, click **Local Server > Remote management current setting (disabled)**.  
    2.  Select **Enable remote management for this server**.  
    3.  Click **OK**.  
3.  Optional: You can temporarily set Windows Update to not automatically download and install updates. This helps prevent changes and system restarts while you deploy the RDSH server.  
    1.  In Server Manager, click **Local Server > Windows Update current setting**.  
    2.  Select **Advanced options > Defer upgrades**.  
4.  Add the server to the domain:  
    1.  In Server Manager, click **Local Server > Workgroup current setting**.  
    2.  Click **Change > Domain**, and then enter the domain name (for example, Contoso.com).  
    3.  Enter the domain administrator credentials.  
    4.  Restart the virtual machine.


