---
title: Release Notes - Important Issues in Windows Server, version 1709
description: "Summarizes critical issues requiring workaround to avoid crash, hang, installation failure, data loss."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.date: 10/17/2017
ms.technology: server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 134aab85-664f-4d44-87ef-9e5fd389071f
author: jaimeo
ms.author: jaimeo
manager: elizapo
---
# Release Notes: Important Issues in Windows Server, version 1709

>Applies To: Windows Server Semi-Annual Channel

These release notes summarize the most critical issues in the Windows Server&reg; operating system, including ways to avoid or work around the issues, if known. For information about by-design changes, new features, and fixes in this release, see [What's New in Windows Server version 1709](whats-new-in-windows-server-1709.md) and announcements from the specific feature teams. Unless otherwise specified, each reported issue applies to all editions and installation options of Windows Server 2016.  

This document is continuously updated. As critical issues requiring a workaround are discovered, they are added, as are new workarounds and fixes as they become available.  
  
## Storage Spaces Direct
[comment]: # (ID: unknown; Submitter: stevenek; state: in review)  
Storage Spaces Direct is not included in Windows Server, version 1709. If you call *Enable-ClusterStorageSpacesDirect* or its alias *Enable-ClusterS2D*,  on a server running Windows Server, version 1709, you will receive an error with the message "The requested operation is not supported".

It is also not supported to introduce servers running Windows Server, version 1709 into a Windows Server 2016 Storage Spaces Direct deployment.
