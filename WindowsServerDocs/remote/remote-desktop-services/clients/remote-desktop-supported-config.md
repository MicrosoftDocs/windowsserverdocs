---
title: Remote Desktop client - supported configuration
description: Learn which PCs you can access using Remote Desktop clients
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bb932dad-6f74-484f-8f7b-dd957b615d44 
author: lizap
manager: dongill
ms.author: elizapo
ms.date: 06/05/2018
ms.localizationpriority: medium
---

# Remote Desktop client - supported configuration

## Supported PCs
You can connect to PCs that are running the following Windows operating systems:
- Windows 10 Pro
- Windows 10 Enterprise
- Windows 8 Enterprise
- Windows 8 Professional
- Windows 7 Professional
- Windows 7 Enterprise
- Windows 7 Ultimate
- Windows 7 Ultimate
- Windows Server 2008
- Windows Server 2008 R2
- Windows Server 2012
- Windows Server 2012 R2
- Windows Server 2016
- Windows Multipoint Server 2011
- Windows Multipoint Server 2012
- Windows Small Business Server 2008
- Windows Small Business Server 2011

The following computers can run the Remote Desktop gateway:

- Windows Server 2008
- Windows Server 2008 R2
- Windows Server 2012
- Windows Server 2012 R2
- Windows Server 2016
- Windows Small Business Server 2011

The following operating systems can serve as RD Web Access or RemoteApp servers:
- Windows Server 2008 R2
- Windows Server 2012
- Windows Server 2012 R2
- Windows Server 2016

## Unsupported Windows Versions and Editions

The Remote Desktop client will not connect to these Windows Versions and Editions:

- Windows 7 Starter
- Windows 7 Home
- Windows 8 Home
- Windows 8.1 Home
- Windows 10 Home

If you want to access computers that have one of these Windows versions installed, we recommend you upgrade to a Windows version that supports RDP.

## RD Gateway messaging is not supported
Remote Desktop Client does not support RD Gateway messaging. Verify that the Remote Desktop Resource Access Policy (RD RAP) for your RD Gateway server does not specify **Only allow computers with support for RD Gateway Messaging** or you will not be able to connect.