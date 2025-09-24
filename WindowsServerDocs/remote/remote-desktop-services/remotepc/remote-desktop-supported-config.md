---
title: Remote Desktop client - supported configuration
description: Learn which PCs you can and can't access by using supported configurations for Remote Desktop clients.
ms.topic: feature-availability
author: dknappettmsft
ms.author: daknappe
ms.date: 7/3/2024
---

# Remote Desktop client - supported configuration

Learn which PCs you can access by using supported configurations for Remote Desktop clients.

## Supported operating systems for Remote Desktop client connections

You can connect to PCs that run the following Windows operating systems:

- Windows 11 Pro
- Windows 11 Enterprise
- Windows 10 Pro
- Windows 10 Enterprise
- Windows Server 2022
- Windows Server 2019
- Windows Server 2016

>[!NOTE]
>Windows SKUs that aren't listed in this section, such as Windows 10 Home, aren't compatible with connecting remotely.

## Supported operating systems for Remote Desktop Gateway, Web Access and RemoteApp

The following operating systems can serve as Remote Desktop Gateway, Web Access, and RemoteApp:

- Windows Server 2022
- Windows Server 2019
- Windows Server 2016

## RD Gateway messaging isn't supported

Remote Desktop Client doesn't support RD Gateway messaging. Verify that the Remote Desktop Resource Access Policy (RD RAP) for your RD Gateway server doesn't specify **Only allow computers with support for RD Gateway Messaging**, or you aren't able to connect.

