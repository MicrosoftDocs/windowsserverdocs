---
title: Release Notes - Important Issues in Windows Server 2016
description: "Summarizes critical issues requiring workaround to avoid crash, hang, installation failure, data loss."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.date: 11/13/2018
ms.technology: server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 134aab85-664f-4d44-87ef-9e5fd389071f
author: jaimeo
ms.author: jaimeo
---
# Release Notes: Important Issues in Windows Server 2016

>Applies to: Windows Server 2016

These release notes summarize the most critical issues in the Windows Server 2016 operating system, including ways to avoid or work around the issues, if known. For information about by-design changes, new features, and fixes in this release, see [What's New in Windows Server 2016](whats-new-in-windows-server-2016.md) and announcements from the specific feature teams. Unless otherwise specified, each reported issue applies to all editions and installation options of Windows Server 2016.

This document is continuously updated. As critical issues requiring a workaround are discovered, they are added, as are new workarounds and fixes as they become available.

## Express updates available starting in November 2018 (NEW)

Starting with the November 2018 "Update Tuesday" update, Windows will again publish [Express updates](express-updates.md) for Windows Server 2016. If you're using WSUS and Configuration Manager you will once again see two packages for the Windows Server 2016 update: a Full update and an Express update. If you want to use Express for your server environments, you need to confirm that the server has taken a full update since November 2017 (KB# 4048953) to ensure the Express update installs correctly. If you attempt an Express update on a server that hasn't been updated since the 2017 11B update (KB# 4048953), you'll see repeated failures that consume bandwidth and CPU resources in an infinite loop. If you get into this scenario, stop pushing the Express update, and instead push a recent Full update to stop the failure loop.

## Server Core installation option

[comment]: # (ID: 370; Submitter: amason; state: signed off)

When you install Windows Server 2016 by using the Server Core installation option, the print spooler is installed and starts by default even when the Print Server role is not installed.

To avoid this, after the first boot, set the print spooler to disabled.

## Containers

[comment]: # (ID: 371; Submitter: taylorb; state: signed off)
- Before you use containers, install [Servicing stack update for Windows 10 Version 1607: August 23, 2016](https://support.microsoft.com/kb/3176936) or any later updates that are available. Otherwise, a number of problems can occur, including failures in building, starting, or running containers, and errors similar to "CreateProcess failed in Win32: The RPC server is unavailable."

[comment]: # (ID: 373; Submitter: plang; state: signed off)
- The NanoServerPackage OneGet provider does not work in Windows Containers. To work around this, use Find-NanoServerPackage and Save-NanoServerPackage on a different computer (not a container) to download the needed package. Then copy the packages into the container and install them.

## Device Guard

[comment]: # (ID: 369; Submitter: nirb; state: signed off)
If you use virtualization-based protection of code integrity or Shielded virtual machines (that use virtualization-based protection of code integrity), you should be aware that these technologies could be incompatible with some devices and applications. You should test such configurations in your lab before enabling the features on production systems. Failure to do so could result in unexpected data loss or stop errors.

## Microsoft Exchange

[comment]: # (ID: 375; Submitter: wgries; state: signed off)
If you attempt to run Microsoft Exchange 2016 CU3 on Windows Server 2016, you will experience errors in the IIS host process W3WP.exe. There is no workaround at this time. You should postpone deployment of Exchange 2016 CU3 on Windows Server 2016 until a supported fix is available.

## Remote Server Administration Tools (RSAT)

[comment]: # (ID: 374; Submitter: ryanpu; state: signed off)
If you're running a version of Windows 10 older than the Anniversary Update, and are using Hyper-V and virtual machines with an enabled virtual Trusted Platform Module (including shielded virtual machines), and then install the version of RSAT provided for Windows Server 2016, attempts to start those virtual machines will fail.

To avoid this, upgrade the client computer to Windows 10 Anniversary Update (or later) prior to installing RSAT. If this has already occurred, uninstall RSAT, upgrade the client to Window 10 Anniversary Update, and then reinstall RSAT.

## Shielded virtual machines

[comment]: # (ID: 369; Submitter: nirb; state: signed off)  
- Ensure that you have installed all available updates before you deploy Shielded virtual machines in production.

- If you use virtualization-based protection of code integrity or Shielded virtual machines (that use virtualization-based protection of code integrity), you should be aware that these technologies could be incompatible with some devices and applications. You should test such configurations in your lab before enabling the features on production systems. Failure to do so could result in unexpected data loss or stop errors.

## Start menu

[comment]: # (ID: 372; Submitter: samli; state: signed off)
This issue affects Windows Server 2016 installed with the Server with Desktop Experience option.

If you install any applications which add shortcut items inside a folder on the **Start** menu, the shortcuts won't work until you log out and log back in again.

Go back to the main [Windows Server 2016](Windows-Server-2016.md) hub.

## Storport Performance

Some systems may exhibit reduced storage performance when running a new install of Windows Server 2016 versus Windows Server 2012 R2.  A number of changes were made during the development of Windows Server 2016 to improve security and reliability of the platform. Some of those changes, like enabling Windows Defender by default, result in longer I/O paths that can reduce I/O performance in certain workloads and patterns. Microsoft does not recommend disabling Windows Defender as it is an important layer of protection for your systems.  

## Copyright

This document is provided "as-is". Information and views expressed in this document, including URL and other Internet Web site references, may change without notice.  

This document does not provide you with any legal rights to any intellectual property in any Microsoft product. You may copy and use this document for your internal, reference purposes.  

&copy; 2016 Microsoft Corporation. All rights reserved.  

Microsoft, Active Directory, Hyper-V, Windows, and Windows Server are either registered trademarks or trademarks of Microsoft Corporation in the United States and/or other countries.  

This product contains graphics filter software; this software is based in part on the work of the Independent JPEG Group.  

1.0
