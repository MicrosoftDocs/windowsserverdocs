---
title: "Release Documentation for Windows Server Essentials"
description: Learn about what is in the Windows Server 2016 Essentials release.
ms.date: 03/10/2021
ms.topic: article
ms.assetid: db402a2b-7a46-448a-841c-750557cd12cc
author: nnamuhcs
ms.author: wscontent
manager: mtillman
---

# Release Documentation for Windows Server Essentials

>Applies To: Windows Server 2016 Essentials

Welcome to the Release Documentation for the Windows Server 2016 Essentials server software. This topic contains information about issues that you may encounter when you install and run the Windows 2016 Server Essentials server software. You should review this topic before you install and run Windows Server 2016 Essentials in your network.

## Client computers

### Install all available Critical and Security updates from Windows Update

Before you connect a client computer to the server, make sure that you open Windows Update on the client computer and install all available critical and security updates.

### Client computer restore may not succeed after migration to Windows 10
 After updating a client computer from Windows 8.1 to Windows 10, client computer restore may not function correctly. You'll need to reconnect the client to the Windows Server 2016 Essentials.

## Enabling TLS 1.2 for Windows Server Essentials
In order to comply with the latest compliance standards for the Federal Risk and Authorization Management Program (FedRAMP), Microsoft plans to disable Transport Layer Security (TLS) versions 1.1 and 1.0 and enable TLS 1.2 in Windows Server Essentials. This would be done for both Client and Server computers.

To enable TLS 1.2, see [How to enable TLS 1.2 on clients](/mem/configmgr/core/plan-design/security/enable-tls-1-2-client).
