---
title: Application Considerations
ms.custom: na
ms.prod: multipoint-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 445e6184-4e1e-4f10-ad3c-042f2a6c2f5f
---
# Application Considerations
  
## Addressing application compatibility problems  
New for [!INCLUDE[win8_server_multipoint_2](../Token/win8_server_multipoint_2_md.md)] is the option to associate stations with full instances of Windows 7 Enterprise or Windows 8 Enterprise running virtually on the same host computer. For critical applications that will not run multiple instances for multiple users, or will not install on a 64\-bit operating system, this can be a solution. Deploying desktops this way requires using the Virtual Desktops tab in [!INCLUDE[win8_server_multipoint_manager](../Token/win8_server_multipoint_manager_md.md)] to:  
  
-   Enable virtual desktops  
  
-   Create a desktop template  
  
-   Customize the template with the problem application  
  
-   Associate stations with the customized template  
  
Each station starts from the same template, so any changes are erased each time the computer starts.  
  
## Application compatibility  
To work properly on a [!INCLUDE[win8_server_multipoint_3](../Token/win8_server_multipoint_3_md.md)] system, an application must:  
  
1.  Install and run on Remote Desktop Services in Windows Server 2012  
  
2.  Install on a 64\-bit operating system  
  
For more information about known application compatibility issues, see [Community Verified Application Compatibility Center for Remote Desktop Services and Windows MultiPoint Server](http://rdcompatibility.com/compatibility/Default.aspx?&srv=4)  
  
### Licensing  
It is important to verify the licensing requirements for the applications you want to run on [!INCLUDE[win8_server_multipoint_3](../Token/win8_server_multipoint_3_md.md)]. Although you are installing a single copy of [!INCLUDE[win8_server_multipoint_3](../Token/win8_server_multipoint_3_md.md)], there are traditionally multiple users, and some applications require per\-user licensing. For example, in cases such as using Microsoft Office, a volume license version is required because it is licensed per user rather than per computer.  
  
