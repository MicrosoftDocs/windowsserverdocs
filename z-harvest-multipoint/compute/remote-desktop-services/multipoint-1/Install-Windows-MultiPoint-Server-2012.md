---
title: Install MultiPoint Services
ms.custom: na
ms.date: 07/22/2016
ms.prod: windows-server-2016
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f6f8970b-de3f-4255-b2a1-5472a16ed02f
author: evas
manager: scottman
---
# Install Windows Server 2016
If you are installing a server from scratch follow these instructions to install Windows Server 2016.  
  

#### Enable MultiPoint Services role service
After you have installed Windows Server 2016 successfully login as Administrator. Use the Server Manager where you can enable MultiPoint Services. The Server Manager opens automatically at start-up. On the Dashboard select *Add roles and features* to enable MultiPoint Services and follow the instructions in the wizard.

In the section for the installation type you might go either with the 
- Role-based or feature-based installation or
- Remote Desktop Services installation

For standard MultiPoint Services deployments we recommend to select the Remote Destkop Services installation which allows you conveniently select the MultiPoint Services role under Deployment type. For the rolebased installation you will need to select MultiPoint Services in the list of roles. The server will reboot after successfull installation.  
  
 ### Configure your primary station  
  
    1.  On the **Create a MultiPoint Server Station** page, type the specified letter from the keyboard for that monitor. The correct key entry associates the keyboard and mouse for that station.  
  
    2.  Log on as Administrator.  
  
