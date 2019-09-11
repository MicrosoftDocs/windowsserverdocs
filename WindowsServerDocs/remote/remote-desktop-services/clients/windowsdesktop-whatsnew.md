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
author: heidilohr
manager: daveba
ms.author: helohr
ms.date: 09/10/2019
ms.localizationpriority: medium
---
# What's new in the Windows Desktop client

We regularly update the [Windows Desktop client](windowsdesktop.md), adding new features and fixing issues. Here's where you'll find the latest updates.

## Client versions

The client can be configured to use different versions for Release or Insider customers. The Release version is the default configuration.

|Customer |Version  |
|---------|---------|
|Release  |1.2.246  |
|Insider  |1.2.246  |

## Updates for version 1.2.246

*Date published: 08/28/2019*

- Improved the fallback languages for localized version. (ex: FR-CA will properly display in French instead of English.)
- When removing a subscription, the client now properly removes the saved credentials from Credential Manager.
- The client update process is now unattended once started and the client will relaunch once completed.
- The client can now be used on Windows 10 in S mode.
- Fixed an issue that caused the update process to fail for users with a space in their username.
