---
title: Release Notes - Important Issues in Windows Server 2016
description: "Summarizes critical issues requiring workaround to avoid crash, hang, installation failure, data loss."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.date: 10/05/2016
ms.technology: server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 134aab85-664f-4d44-87ef-9e5fd389071f
author: jaimeo
ms.author: jaimeo
manager: dongill
---
# Release Notes: Important Issues in Windows Server 2016

>Applies To: Windows Server 2016

These release notes summarize the most critical issues in the Windows Server&reg; 2016 operating system, including ways to avoid or work around the issues, if known. For information about by-design changes, new features, and fixes in this release, see [What's New in Windows Server 2016](What-s-New-in-Windows-Server-2016-Technical-Preview) and announcements from the specific feature teams. Unless otherwise specified, each reported issue applies to all editions and installation options of Windows Server 2016.  

This document is continuously updated. As critical issues requiring a workaround are discovered, they are added, as are new workarounds and fixes as they become available.  
  
## Server Core installation option
[comment]: # (ID: 370; Submitter: amason; state: signed off)  
When you install Windows Server 2016 by using the Server Core installation option, the print spooler is installed and starts by default even when the Print Server role is not installed.

To avoid this, after the first boot, set the print spooler to disabled.

## Containers  

[comment]: # (ID: 371; Submitter: taylorb; state: signed off)  
Before you use containers, install [Servicing stack update for Windows 10 Version 1607: August 23, 2016](https://support.microsoft.com/en-us/kb/3176936) or any later updates that are available. Otherwise, a number of problems can occur, including failures in building, starting, or running containers, and errors similar to "CreateProcess failed in Win32: The RPC server is unavailable." 


## Shielded virtual machines
[comment]: # (ID: 369; Submitter: nirb; state: signed off)  
- Shielded virtual machines should be deployed only in non-production environments until an update is available.
- You cannot convert existing non-shielded virtual machines to Shielded virtual machines. There is no workaround at this time. If you need to deploy Shielded virtual machines, create new ones directly from shielded templates.

Go back to the main [Windows Server 2016](Windows-Server-2016.md) hub.

## Copyright  
This document is provided "as-is". Information and views expressed in this document, including URL and other Internet Web site references, may change without notice.  

This document does not provide you with any legal rights to any intellectual property in any Microsoft product. You may copy and use this document for your internal, reference purposes.  

&copy; 2016 Microsoft Corporation. All rights reserved.  

Microsoft, Active Directory, Hyper-V, Windows, and Windows Server are either registered trademarks or trademarks of Microsoft Corporation in the United States and/or other countries.  

This product contains graphics filter software; this software is based in part on the work of the Independent JPEG Group.  


1.0  
