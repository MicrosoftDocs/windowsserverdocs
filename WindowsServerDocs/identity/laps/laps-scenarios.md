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

## Scenarios

Windows LAPS supports several primary scenarios:

* Backing up local admin account passwords to [Azure AD](https://docs.microsoft.com/azure/active-directory/devices/concept-azure-ad-join) (for Azure AD joined devices)

* Backing up local admin account passwords to Active Directory (for on-premises AD joined clients and servers)

* Backing up Directory Services Repair Mode (DSRM) account passwords to Active Directory (for AD domain controllers)

* Backing up local admin account passwords to Active Directory using legacy LAPS

Within each scenario, there's various different policy settings that can be applied.  

## Understand device join state restrictions

Which directory a device is joined to impacts how Windows LAPS can be used and should be kept in mind as you're planning which scenario(s) to use.

Devices that are joined to [Azure AD](https://docs.microsoft.com/azure/active-directory/devices/concept-azure-ad-join) can only back up passwords to Azure AD.

Devices that are joined to on-premises AD can only back up passwords to AD.

Devices that are [hybrid-joined](https://docs.microsoft.com/azure/active-directory/devices/concept-azure-ad-join-hybrid) (joined to on-premises AD and registered with Azure AD), can backup their passwords to either AD or Azure AD. Backing up passwords to both directories isn't supported.

## Next steps

Once you have decided which scenario is most relevant for you, proceed to one of the following articles:

[Getting started with Windows LAPS and Azure AD](../laps/laps-scenarios-aad.md).

[Getting started with Windows LAPS and Active Directory](../laps/laps-scenarios-ad.md).

[Getting started with Windows LAPS in Legacy LAPS emulation mode](../laps/laps-scenarios-legacy.md)
