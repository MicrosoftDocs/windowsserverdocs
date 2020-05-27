---
title: What's New in Windows Server, version 2004
description: New features in Windows Server, version 2004
ms.prod: windows-server
ms.technology: server-general
ms.topic: article
author: Heidilohr
ms.author: helohr
ms.date: 05/27/2020
ms.localizationpriority: high
---

# What's new in Windows Server, version 2004

>Applies to: Windows Server (Semi-Annual Channel)

To learn about the latest features in Windows, see [What's New in Windows Server](whats-new-in-windows-server.md). This topic describes some of the new features in Windows Server, version 2004.

## Server Core container improvements

We've reduced the overall size of Server Core container images for improved download speeds and performance. We've included the following improvements:

- Removed most NGEN images from Server Core container image to make the image size smaller.
- .NET Framework runtime images built on Server Core container images are now optimized for ASP.NET apps and Windows PowerShell script performance.
- The .NET team has also ensured there's only one copy of each NGEN image, resulting a smaller size for .NET Framework images.

To give you a better idea of the size of these containers, the following table compares the current version of the container as of [the May 2020 monthly security update](https://support.microsoft.com/help/4561769/windows-server-containers-for-may-2020) (also known as the "5B" update) with previous versions.

| Container version | Download size | Size on disk |
|---|---|---|
| Windows Server, version 1903 | 2.311 GB | 5.1 GB |
| Windows Server, version 1909 | 2.257 GB | 4.97 GB |
| Windows Server, version 2004 | 1.830 GB | 3.98 GB |

For more information about the Windows Server, version 2004 update, see [our blog post](https://techcommunity.microsoft.com/t5/containers/windows-server-version-2004-now-available/ba-p/1419194). To learn more about Windows container updates in general, see [Update Windows Server containers](/virtualization/windowscontainers/deploy-containers/update-containers/).
