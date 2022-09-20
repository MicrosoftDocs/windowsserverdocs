---
ms.assetid: 1d4c57e1-9203-4f15-80fb-0197dd3839ac
title: Local Administrator Password Solution Scenarios
description: Local Administrator Password Solution Scenarios
author: jsimmons
ms.author: jsimmons
manager: jsimmons
ms.date: 07/04/2022
ms.topic: article
---

# Windows LAPS Scenarios

This article describes the basic scenarios supported by Windows LAPS.

## Scenarios

Windows LAPS supports several primary scenarios:

* Backing up local admin account passwords to [Azure Active Directory](/azure/active-directory/devices/concept-azure-ad-join) (for Azure Active Directory joined devices)

* Backing up local admin account passwords to Windows Server Active Directory (for Windows Server Active Directory-joined clients and servers)

* Backing up Directory Services Repair Mode (DSRM) account passwords to Windows Server Active Directory (for Windows Server Active Directory domain controllers)

* Backing up local admin account passwords to Windows Server Active Directory using legacy LAPS

Within each scenario, there's various different policy settings that can be applied.

## Understand device join state restrictions

Which directory a device is joined to impacts how Windows LAPS can be used and should be kept in mind as you're planning which scenario(s) to use.

Devices that are only joined to [Azure Active Directory](/azure/active-directory/devices/concept-azure-ad-join) can only back up passwords to Azure Active Directory.

Devices that are only joined to Windows Server Active Directory can only back up passwords to Windows Server Active Directory.

Devices that are [hybrid-joined](/azure/active-directory/devices/concept-azure-ad-join-hybrid) (joined to both Azure Active Directory and Windows Server Active Directory), can back up their passwords to either Azure Active Directory or Windows Server Active Directory. Backing up passwords to both directories isn't supported.

## Next steps

Once you've decided which scenario is most relevant for you, proceed to one of the following articles:

[Getting started with Windows LAPS and Azure Active Directory](../laps/laps-scenarios-azure-active-directory.md).

[Getting started with Windows LAPS and Windows Server Active Directory](../laps/laps-scenarios-windows-server-active-directory.md).

[Getting started with Windows LAPS in Legacy LAPS emulation mode](../laps/laps-scenarios-legacy.md)
