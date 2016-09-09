---
title: Remote Desktop client - supported configuration
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bb932dad-6f74-484f-8f7b-dd957b615d44 
author: lizap
manager: dongill
---

# Remote Desktop client - supported configuration

## Supported PCs
You can connect to PCs that are running the following Windows operating systems:
- Windows 10
- Windows 8 Enterprise
- Windows 8 Properties
- Windows 7 Professional
- Windows 7 Enterprise
- Windows 7 Ultimate
- Windows 7 Ultimate
- Windows Vista Business
- Windows Vista Ultimate
- Windows Vista Enterprise
- Windows XP Professional
- Windows Server 2000
- Windows Server 2003
- Windows Server 2003 R2
- Windows Server 2008
- Windows Server 2008 R2
- Windows Server 2012
- Windows Server 2012 R2
- Windows Server 2016
- Windows Multipoint Server 2011
- Windows Multipoint Server 2012
- Windows Small Business Server 2003
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

- Windows XP Starter
- Windows XP Home
- Windows XP Tablet PC
- Windows Media Center
- Windows Vista Starter
- Windows Vista Home
- Windows 7 Starter
- Windows 7 Home

If you want to access computers that have one of these Windows versions installed, we recommend you upgrade to a Windows version that supports RDP.

## RD Gateway messaging is not supported
Remote Desktop Client does not support RD Gateway messaging. Verify that the Remote Desktop Resource Access Policy (RD RAP) for your RD Gateway server does not specify **Only allow computers with support for RD Gateway Messaging** or you will not be able to connect.