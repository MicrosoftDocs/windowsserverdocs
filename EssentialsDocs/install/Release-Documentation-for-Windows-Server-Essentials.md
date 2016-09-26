---
title: "Release Documentation for Windows Server Essentials"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: db402a2b-7a46-448a-841c-750557cd12cc
author: nnamuhcs
ms.author: coreyp
---

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, and Windows Server 2012


# Release Documentation for Windows Server Essentials
Welcome to the Release Documentation for the  Windows Server Essentials server software. This topic contains information about issues that you may encounter when you install and run the  Windows Server Essentials server software. You should review this topic before you install and run  Windows Server Essentials in your network.  

  
## Server installation and deployment  
  
### Time needs to be synchronized in Hyper-V environments  
 If you host  Windows Server Essentials in a Hyper-V environment, you should disable time synchronization with the virtual machine host, or configure  Windows Server Essentials to use the same time zone as the virtual machine host.  
  
 For more information, see Deployment Considerations for Virtualized Domain Controllers in [Running Domain Controllers in Hyper-V](http://technet.microsoft.com//library/virtual_active_directory_domain_controller_virtualization_hyperv\(WS.10\).aspx).  
  
### Some add-ins cannot be installed after upgrading from  Windows Server Essentials to  Windows Server 2012 Standard  
 Some add-ins that are specifically designed to run on the  Windows Server Essentials server software cannot be installed after the upgrade to  Windows Server 2012 Standard. Add-ins of this type that were installed before the upgrade are not affected.  
  
 To work around this issue, install all necessary add-ins before you upgrade  Windows Server Essentials to  Windows Server 2012 Standard.  
  
 The product development team is investigating this issue.  
  
## Client computers  
  
### Install all available Critical and Security updates from Windows Update  
 Before you connect a client computer to the server, make sure that you open Windows Update on the client computer and install all available Critical and Security updates.  
  
### Client computer restore may not succeed after migration to Windows 8  
 After updating a client computer from Windows 7 to Windows 8, client computer restore may not function correctly.  
  
 To resolve this issue, see [Install the Connector software](../use/Get-Connected-in-Windows-Server-Essentials.md#BKMK_11).  
  
## Media  
  
### Media will not automatically stream to devices that do not support Silverlight  
 You can use HTTP progressive download to stream media to devices that do not support Silverlight. To do so, configure port forwarding for TCP port 80 on your router.  
  
### A playlist in Remote Web Access is empty  
 A playlist that was created in Remote Web Access does not contain any songs, even though songs were added to the list.  
  
 The product development team is investigating this issue.  
  
## Online Backup  
  
### Online Backup might cause the Dashboard to stop functioning  
 If you integrate  Microsoft Azure Backup with a non-English Release Candidate version of  Windows Server Essentials, the Dashboard might stop functioning when you close a wizard that you accessed from the Online Backup section.  
  
 If you encounter this issue, you might be able to resolve the problem by restarting the  Windows Server Essentials Dashboard.  
  
 The product development team is investigating this issue.
