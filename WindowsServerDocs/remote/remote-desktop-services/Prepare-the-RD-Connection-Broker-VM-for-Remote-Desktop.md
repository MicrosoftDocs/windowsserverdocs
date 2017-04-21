---
title: Prepare the RD Connection Broker VM for Remote Desktop
description: Get your VM ready to host the RD Connection Broker
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: elizapo
ms.date: 08/01/2016
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 432de387-9bad-46df-ad26-3254de377ff7
author: lizap
manager: dongill
---
# Prepare the RD Connection Broker VM for Remote Desktop

>Applies To: Windows Server 2016

Use the following steps to prepare the virtual machine for the Remote Desktop Connection Broker role:  
  
1.  Connect to the virtual machine:  
    1.  In the Azure portal click **Browse > Resource groups** and click the resource group for the deployment.  
    2.  Select the new RD CB virtual machine (for example, Contoso-Cb2).  
    3.  Click **Connect > Open**.  
    4.  Click **Connect**, and then click **Use another user account**. Enter the user name and password for the local administrator account.  
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
    2.  Click **Change > Domain**, and then enter the domain name (for example, contoso.com).  
    3.  Enter the domain administrator credentials.  
 


