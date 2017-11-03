---
title: Release Notes - Important Issues in Windows Server, version 1709
description: "Summarizes critical issues requiring workaround to avoid crash, hang, installation failure, data loss."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.date: 10/19/2017
ms.technology: server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 134aab85-664f-4d44-87ef-9e5fd389071f
author: jaimeo
ms.author: jaimeo
manager: elizapo
ms.localizationpriority: medium
---
# Release Notes: Important Issues in Windows Server, version 1709

>Applies To: Windows Server Semi-Annual Channel

These release notes summarize the most critical issues in the Windows Server&reg; operating system, including ways to avoid or work around the issues, if known. For information about by-design changes, new features, and fixes in this release, see [What's New in Windows Server version 1709](whats-new-in-windows-server-1709.md) and announcements from the specific feature teams. Unless otherwise specified, each reported issue applies to all editions and installation options of Windows Server 2016.  

This document is continuously updated. As critical issues requiring a workaround are discovered, they are added, as are new workarounds and fixes as they become available.  
  
## Storage Spaces Direct
[comment]: # (ID: unknown; Submitter: stevenek; state: signed off)  
Storage Spaces Direct is not included in Windows Server, version 1709. If you call *Enable-ClusterStorageSpacesDirect* or its alias *Enable-ClusterS2D*,  on a server running Windows Server, version 1709, you will receive an error with the message "The requested operation is not supported".

It is also not supported to introduce servers running Windows Server, version 1709 into a Windows Server 2016 Storage Spaces Direct deployment.

The Windows Server release model is offering a new option in order to align with similar release and servicing models for [Windows 10](https://docs.microsoft.com/windows/deployment/update/waas-overview) and [Office 365 ProPlus](https://support.office.com/article/Overview-of-the-upcoming-changes-to-Office-365-ProPlus-update-management-78b33779-9356-4cdf-9d2c-08350ef05cca?ui=en-US&rs=en-US&ad=US). The Semi-Annual Channel releases deliver new functionality for customers who want to move at a rapid cadence and will have new releases available twice a year, in spring and fall.

Windows Server, version 1709 introduces the first Semi-Annual Channel release for Windows Server.  This new rapid cadence also enables greater flexibility in how and when we release new production-ready features.

Storage Spaces Direct was introduced in Windows Server 2016 and is the foundation for our hyper-converged platform. We have been thrilled by the positive adoption of the Microsoft hyper-converged platform and we are committed to our customers.

We have been listening to customer feedback and working to deliver the [next set of innovations](https://blogs.technet.microsoft.com/windowsserver/2017/09/07/sneak-peek-2-windows-server-version-1709-hyper-converged-infrastructure/) for our hyper-converged platform. These features are available today in [Windows Insiders](https://insider.windows.com/en-us/for-business/) builds, and we would love for you to try them and share your feedback! However, these new features have not yet achieved the level of validation for production deployment, so we decided to keep them in preview for a little longer and skip Windows Server, version 1709.  But don’t worry, the next release is not far away! For customers looking for a validated hyper-converged solution, we recommend the [Windows Server Software Defined](http://microsoft.com/wssd) program.
