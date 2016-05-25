---
title: Release Documentation for Windows Server 2012 Essentials
ms.custom: na
ms.prod: windows-server-2012-r2-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: db402a2b-7a46-448a-841c-750557cd12cc
author: cfreemanwa
---
# Release Documentation for Windows Server 2012 Essentials
Welcome to the Release Documentation for the [!INCLUDE[sbs_sbs8web_2](../Token/sbs_sbs8web_2_md.md)] server software. This topic contains information about issues that you may encounter when you install and run the [!INCLUDE[sbs_sbs8web_2](../Token/sbs_sbs8web_2_md.md)] server software. You should review this topic before you install and run [!INCLUDE[sbs_sbs8web_2](../Token/sbs_sbs8web_2_md.md)] in your network.  
  
> [!NOTE]  
> For information about issues that apply to the Windows Server 2012 operating system, see [Release Notes: Important Issues in Windows Server 2012](http://technet.microsoft.com/library/jj134216.aspx).  
  
## Server installation and deployment  
  
### Time needs to be synchronized in Hyper\-V environments  
If you host [!INCLUDE[sbs_sbs8web_2](../Token/sbs_sbs8web_2_md.md)] in a Hyper\-V environment, you should disable time synchronization with the virtual machine host, or configure [!INCLUDE[sbs_sbs8web_2](../Token/sbs_sbs8web_2_md.md)] to use the same time zone as the virtual machine host.  
  
For more information, see “Deployment Considerations for Virtualized Domain Controllers” in [Running Domain Controllers in Hyper\-V](http://technet.microsoft.com//library/virtual_active_directory_domain_controller_virtualization_hyperv(WS.10).aspx).  
  
### Some add\-ins cannot be installed after upgrading from [!INCLUDE[sbs_sbs8web_2](../Token/sbs_sbs8web_2_md.md)] to [!INCLUDE[win8_server_standard_2](../Token/win8_server_standard_2_md.md)]  
Some add\-ins that are specifically designed to run on the [!INCLUDE[sbs_sbs8web_2](../Token/sbs_sbs8web_2_md.md)] server software cannot be installed after the upgrade to [!INCLUDE[win8_server_standard_2](../Token/win8_server_standard_2_md.md)]. Add\-ins of this type that were installed before the upgrade are not affected.  
  
To work around this issue, install all necessary add\-ins before you upgrade [!INCLUDE[sbs_sbs8web_2](../Token/sbs_sbs8web_2_md.md)] to [!INCLUDE[win8_server_standard_2](../Token/win8_server_standard_2_md.md)].  
  
The product development team is investigating this issue.  
  
## Client computers  
  
### Install all available Critical and Security updates from Windows Update  
Before you connect a client computer to the server, make sure that you open Windows Update on the client computer and install all available Critical and Security updates.  
  
### Client computer restore may not succeed after migration to Windows 8  
After updating a client computer from Windows 7 to Windows 8, client computer restore may not function correctly.  
  
To resolve this issue, see [Install the Connector software](../Topic/Get-Connected-in-Windows-Server-Essentials.md#BKMK_11).  
  
## Media  
  
### Media will not automatically stream to devices that do not support Silverlight  
You can use HTTP progressive download to stream media to devices that do not support Silverlight. To do so, configure port forwarding for TCP port 80 on your router.  
  
### A playlist in Remote Web Access is empty  
A playlist that was created in Remote Web Access does not contain any songs, even though songs were added to the list.  
  
The product development team is investigating this issue.  
  
## Online Backup  
  
### Online Backup might cause the Dashboard to stop functioning  
If you integrate [!INCLUDE[sbs8_mob_1](../Token/sbs8_mob_1_md.md)] with a non\-English Release Candidate version of [!INCLUDE[sbs_sbs8web_2](../Token/sbs_sbs8web_2_md.md)], the Dashboard might stop functioning when you close a wizard that you accessed from the Online Backup section.  
  
If you encounter this issue, you might be able to resolve the problem by restarting the [!INCLUDE[sbs_sbs8web_2](../Token/sbs_sbs8web_2_md.md)] Dashboard.  
  
The product development team is investigating this issue.  
  
