---
title: Managing Remote Storage Resources
description: This article describes how to manage storage resources on a remote computer
ms.date: 7/7/2017
ms.prod: windows-server
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---

# Managing Remote Storage Resources

> Applies to: Windows Server 2019, Windows Server 2016, Windows Server (Semi-Annual Channel), Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2

To manage storage resources on a remote computer, you have two options:

-   Connect to the remote computer from the File Server Resource Manager Microsoft<sup>®</sup> Management Console (MMC) snap-in (which you can then use to manage the remote resources).
-   Use the command-line tools that are installed with File Server Resource Manager.

Either option allows you to work with quotas, screen files, manage classifications, schedule file management tasks, and generate reports with those remote resources.

> [!Note]
> File Server Resource Manager can manage resources on either the local computer or a remote computer, but not both at the same time.

For example, you can:

-   Connect to another computer in the domain using the File Server Resource Manager MMC snap-in and review storage utilization on a volume or folder located on the remote computer.
-   Create quota and file screen templates on a local server and then use the command-line tools to import those templates into a file server located in a branch office.

This section includes the following topics:

-   [Connect to a Remote Computer](connect-to-remote-computer.md)
-   [Command-Line Tools](command-line-tools.md)
