---
title: Application Considerations
ms.custom: na
ms.date: 07/22/2016
ms.prod: windows-server-2016
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 445e6184-4e1e-4f10-ad3c-042f2a6c2f5f
author: evas
manager: scottman
---
# Application Considerations
  
## Application compatibility

Any application that you want to run on a MultiPoint server system must fullfill the following requirements  
  
1.  It should install and run on Windows Server 2016 
  
2.  It needs to be session aware so each user can run an instance of the app in a MultiPoint System.
  
If the application does specify this requirement we recommend to try installing the application and use it in a remote desktop session. 

## Addressing application compatibility problems  
MultiPoint Services offers the option to associate stations with full instances of Windows 10 Enterprise editions running virtually on the same host computer. For critical applications that will not run multiple instances for multiple users, or will not install on a 64\-bit operating system, this can be a solution. Deploying desktops this way requires using the Virtual Desktops tab in MultiPoint Manager to:  
  
-   Enable virtual desktops  
  
-   Create a desktop template  
  
-   Customize the template with the problem application  
  
-   Associate stations with the customized template  
  
Each station starts from the same template, so any changes are erased each time the computer starts.  


  
  
>[!NOTE] 
>It is important to verify the licensing requirements for the applications you want to run on a MultiPoint. Although you are installing one copy applications might require per\-user licensing.  
  
