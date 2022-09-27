---
title: Windows Local Administrator Password Solution (Windows LAPS) scenarios
description: Learn about Windows Local Administrator Password Solution (Windows LAPS) scenarios.
author: jay98014
ms.author: jsimmons
ms.date: 07/04/2022
ms.topic: article
---

# Windows LAPS scenarios

> Applies to: Windows 11

This article describes the basic scenarios for using Windows LAPS.

Windows LAPS currently is available only in Windows 11 Insider Preview Build 25145 and later. Support for the Windows LAPS Azure Active Directory scenario currently is limited to a small group of Windows Insider users.

## Scenarios

You can use Windows LAPS for several primary scenarios:

- Back up local admin account passwords to [Azure Active Directory](/azure/active-directory/devices/concept-azure-ad-join) (for Azure Active Directory-joined devices)

- Back up local admin account passwords to Windows Server Active Directory (for Windows Server Active Directory-joined clients and servers)

- Back up Directory Services Repair Mode (DSRM) account passwords to Windows Server Active Directory (for Windows Server Active Directory domain controllers)

- Back up local admin account passwords to Windows Server Active Directory by using Microsoft LAPS (earlier version)

In each scenario, you can apply different policy settings.

## Understand device join state restrictions

Which directory a device is joined to affects how you can use Windows LAPS. Keep this in mind as you plan your usage scenario.

Devices that are joined only to [Azure Active Directory](/azure/active-directory/devices/concept-azure-ad-join) can back up passwords only to Azure Active Directory.

Devices that are joined only to Windows Server Active Directory can back up passwords only to Windows Server Active Directory.

Devices that are [hybrid-joined](/azure/active-directory/devices/concept-azure-ad-join-hybrid) (joined to both Azure Active Directory and Windows Server Active Directory) can back up their passwords to either Azure Active Directory or Windows Server Active Directory. You can't back up passwords to both directories.

## Next steps

When you've decided which scenario is most relevant for you, go to one of the following articles:

[Get started with Windows LAPS and Azure Active Directory](../laps/laps-scenarios-azure-active-directory.md).

[Get started with Windows LAPS and Windows Server Active Directory](../laps/laps-scenarios-windows-server-active-directory.md).

[Get started with Windows LAPS in Microsoft LAPS emulation mode](../laps/laps-scenarios-legacy.md)
