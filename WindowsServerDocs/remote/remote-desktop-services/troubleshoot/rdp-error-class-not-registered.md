---
title: \"Class not registered\" error
description: Troubleshooting \"Class not registered\" error with remote desktop connection.
audience: ITPro ​
ms.custom: na
ms.reviewer: rklemen; josh.bender
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: troubleshooting
ms.assetid: 
author: kaushika-msft
manager: 
ms.author: kaushika; rklemen; josh.bender; v-tea; delhan
ms.date: 06/23/2019
ms.localizationpriority: medium
---

# Clients cannot connect with \"Class not registered\" error

When you try to connect to a remote computer by using a client that is running Windows 10, version 1709 or a later version of Windows, the client may not connect while the Remote Desktop Session Host server reports a message that contains the "Class not registered (0x80040154)" error code.

This issue occurs if the user who is trying to connect has a mandatory user profile. To resolve this issue, install the [July 24, 2018—KB4338817 (OS Build 16299.579)](https://support.microsoft.com/en-us/help/4338817/windows-10-update-kb4338817) Windows 10 update.
