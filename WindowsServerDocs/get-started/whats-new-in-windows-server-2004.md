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

We've reduced the overall size of Server Core container images for improved download speeds. We've included the following improvements:

- Smaller NGEN images compared to previous releases.
- Smaller .NET Framework runtime images.
- The .NET team has ensured there's only one copy of each NGEN image, to save space.

To give you a better idea of the size of these containers, the following table compares the current version of the container with previous versions.

| Container version | Download size | Size on disk |
|---|---|---|
| Windows Server, version 1903 | 2.311 GB | 5.1 GB |
| Windows Server, version 1909 | 2.257 GB | 4.97 GB |
| Windows Server, version 2004 | 1.865 GB | 4.05 GB |

To learn more about Windows container updates, see [Update Windows Server containers](/virtualization/windowscontainers/deploy-containers/update-containers/).
