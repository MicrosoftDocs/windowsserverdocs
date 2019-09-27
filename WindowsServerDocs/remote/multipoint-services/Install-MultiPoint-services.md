---
title: Install MultiPoint Services
description: Learn how to install and configure MultiPoint Services in Windows Server 2016
ms.custom: na
ms.date: 07/22/2016
ms.prod: windows-server
ms.technology: multipoint-services
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f6f8970b-de3f-4255-b2a1-5472a16ed02f
author: evaseydl
manager: scottman
ms.author: evas
---
# Install MultiPoint Services
If you are installing a server from scratch follow these instructions to install MultiPoint Services.  

After you have installed Windows Server 2016 successfully sign in as Administrator. Use the Server Manager where you can enable MultiPoint Services. The Server Manager opens automatically at start-up. On the Dashboard select **Add roles and features** to enable MultiPoint Services and follow the instructions in the wizard.

In the section for the installation type you might go either with the 
- Role-based or feature-based installation or
- Remote Desktop Services installation

For standard MultiPoint Services deployments we recommend to select the Remote Desktop Services installation which allows you conveniently select the MultiPoint Services role under Deployment type. For the role-based installation you will need to select **MultiPoint Services** in the list of roles. The server will reboot after successful installation.  
  
## Configure your primary station  
  
1.  On the **Create a MultiPoint Server Station** page, type the specified letter from the keyboard for that monitor. The correct key entry associates the keyboard and mouse for that station.  
2.  Sign in as Administrator.  