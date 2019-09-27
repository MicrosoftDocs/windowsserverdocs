---
title: What's new in the Windows Desktop client
description: Learn about recent changes to the Remote Desktop client for Windows Desktop
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
author: heidilohr
manager: daveba
ms.author: helohr
ms.date: 09/24/2019
ms.localizationpriority: medium
---
# What's new in the Windows Desktop client

You can find more detailed information about the Windows Desktop client at [Get started with the Windows Desktop client](windowsdesktop.md). You'll find the latest updates to client below.

## Latest client versions

The client can be configured for different [user groups](windowsdesktop-admin.md#configure-user-groups). The following table lists the current versions available for each user group:

|User group |Version  |
|-----------|---------|
|Public     |1.2.247  |
|Insider    |1.2.247  |

## Updates for version 1.2.247

*Date published: 09/17/2019*

- Fixed a crash that happened when authenticating during a connection.
- Fixed a crash that happened when closing the client.

## Updates for version 1.2.246

*Date published: 08/28/2019*

- Improved the fallback languages for localized version. (For example, FR-CA will properly display in French instead of English.)
- When removing a subscription, the client now properly removes the saved credentials from Credential Manager.
- The client update process is now unattended once started and the client will relaunch once completed.
- The client can now be used on Windows 10 in S mode.
- Fixed an issue that caused the update process to fail for users with a space in their username.
