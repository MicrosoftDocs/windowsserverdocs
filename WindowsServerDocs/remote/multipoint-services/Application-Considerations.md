---
title: Application Considerations
description: Compatiblity information for apps on MultiPoint Services
ms.custom: na
ms.prod: windows-server
ms.technology: multipoint-services
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 445e6184-4e1e-4f10-ad3c-042f2a6c2f5f
author: evaseydl
manager: scottman
ms.author: evas
ms.date: 08/04/2016
---
# Application Considerations
  
## Application compatibility

Any application that you want to run on a MultiPoint Services system must fulfill the following requirements:
  
- It should install and run on Windows Server 2016 
- It needs to be session aware so each user can run an instance of the app in a MultiPoint system.
  
If the application does specify this requirement we recommend to try installing the application and use it in a remote desktop session. 

## Addressing application compatibility problems  
MultiPoint Services offers the option to associate stations with full instances of Windows 10 Enterprise editions running virtually on the same host computer. For critical applications that will not run multiple instances for multiple users, or will not install on a 64-bit operating system, this can be a solution. Deploying desktops this way requires using the Virtual Desktops tab in MultiPoint Manager to:  
  
-   Enable virtual desktops  
-   Create a desktop template  
-   Customize the template with the problem application  
-   Associate stations with the customized template  

Each station starts from the same template, so any changes are erased each time the computer starts.  
  
>[!NOTE] 
>It is important to verify the licensing requirements for the applications you want to run on a MultiPoint. Although you are installing one copy applications might require per-user licensing.  
  
