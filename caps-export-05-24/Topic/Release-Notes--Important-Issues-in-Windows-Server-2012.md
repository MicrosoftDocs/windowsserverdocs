---
title: Release Notes: Important Issues in Windows Server 2012
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f93f265e-1fa6-4cac-9bff-b76df305ab30
author: jaimeo
---
# Release Notes: Important Issues in Windows Server 2012
These release notes address the most critical issues and information about the [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] operating system. For information about by\-design changes, new features, and fixes in this release, see documentation and announcements from the specific feature teams. For information about important steps to take before installing this release, including issues that you may need to work around, see [Installing Windows Server 2012](../Topic/Installing-Windows-Server-2012.md), a document available at the same location as this document. Unless otherwise specified, these notes apply to all editions and installation options of the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
This document is continuously updated; as critical issues requiring a workaround are discovered, they are added.  
  
## Setup with UEFI and 4K native drives  
If you boot a computer in UEFI mode from the Windows Server 2012 installation DVD and then attempt to install Windows Server 2012 onto a drive that uses the 4K logical sector size \(“4K native”\), you will receive the following error: “We couldn't create a new partition.”  
  
To avoid this, create the needed partition using Diskpart.exe instead of allowing Setup.exe to do it. When the installation wizard gets to the **Where do you want to install Windows?** page, press SHIFT\+F10 to open a command prompt. Use DiskPart to create the partition, and then return to the installation wizard to continue installation. For information about using Diskpart.exe for this, see [Sample: Configure UEFI\/GPT\-Based Hard Drive Partitions by Using Windows PE and DiskPart](http://technet.microsoft.com/library/hh825686.aspx)  
  
If this has already occurred, follow these steps:  
  
1.  On the **Where do you want to install Windows?** page of the wizard, select a partition created by Setup and then click **Delete**. Repeat for any other partitions also created by Setup.  
  
2.  Click **New** to create a new installation partition, and then continue with installation.  
  
For additional information about 4K sector drives, including steps to determine if your drive is of this type, see [Microsoft support policy for 4K sector hard drives in Windows](http://support.microsoft.com/kb/2510009)  
  
## Upgrade  
If you upgrade from a Full installation of [!INCLUDE[firstref_longhorn](../Token/firstref_longhorn_md.md)] or [!INCLUDE[firstref_server_7](../Token/firstref_server_7_md.md)] to [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] in Server with a GUI mode, and then switch [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to Server Core mode, conversion back to Server with a GUI mode will fail.  
  
To avoid this, delete these registry keys with the following commands:  
  
**reg delete HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\WINEVT\\Publishers\\{bc2eeeec\-b77a\-4a52\-b6a4\-dffb1b1370cb}**  
  
**reg delete HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\WINEVT\\Publishers\\{57e0b31d\-de8c\-4181\-bcd1\-f70e880b49fc}**  
  
**reg delete HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\WINEVT\\Publishers\\{8c9dd1ad\-e6e5\-4b07\-b455\-684a9d879900}**  
  
After running these commands, restart the upgrade.  
  
## Copyright  
This document is provided “as\-is”. Information and views expressed in this document, including URL and other Internet Web site references, may change without notice.  
  
This document does not provide you with any legal rights to any intellectual property in any Microsoft product. You may copy and use this document for your internal, reference purposes.  
  
©2012 Microsoft Corporation. All rights reserved.  
  
Microsoft, Active Directory, Hyper\-V, MS\-DOS, Windows, Windows NT, Windows Server, and Windows Vista are either registered trademarks or trademarks of Microsoft Corporation in the United States and\/or other countries.  
  
This product contains graphics filter software; this software is based in part on the work of the Independent JPEG Group.  
  
All other trademarks are property of their respective owners.  
  
2.1  
  
