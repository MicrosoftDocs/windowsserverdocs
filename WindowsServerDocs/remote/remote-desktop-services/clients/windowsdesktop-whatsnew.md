---
title: What's new in the Windows Desktop client
description: Learn about recent changes to the Remote Desktop client for Windows Desktop
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
author: lizap
manager: dongill
ms.author: elizapo
ms.date: 09/10/2019
ms.localizationpriority: medium
---
# What's new in the Windows Desktop client

We regularly update the [Windows Desktop client](windowsdesktop.md), adding new features and fixing issues. Check out the latest updates below.

## Client version in the different rings

The client can be configured for different rings which determines which version is available. By default, it uses the Release ring.

|Ring    |Version  |
|--------|---------|
|Release |1.2.246  |
|Insider |1.2.246  |

## Updates for version 1.2.246

*Published date: 08/28/2019*

- Improved the fallback languages for localized version. (ex: FR-CA will properly display in French instead of English.)
- When removing a subscription, the client now properly removes the saved credentials from Credential Manager.
- The client update process is now unattended once started and the client will relaunch once completed.
- The client can now be used on Windows 10S devices.
- Fixed an issue that caused the update process to fail for users with a space in their username.
