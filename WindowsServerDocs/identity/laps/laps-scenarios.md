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

# Scenario guides

## Overview

Windows LAPS supports several primary scenarios:

* Backing up local admin account passwords to Azure AD (for Azure-AD-joined or hybrid-joined devices)

* Backing up local admin account passwords to Active Directory (for AD domain-joined clients\servers)

* Backing up Directory Services Repair Mode (DSRM) account passwords to Active Directory (for AD domain controllers)

* Backing up local admin account passwords to Active Directory using legacy LAPS

Within each scenario, there's various different policy settings that can be applied.  

## Understand device join state restrictions

Which directory a device is joined to impacts how Windows LAPS can be used and should be kept in mind as you're planning which scenario(s) to use.

Devices that are joined only to Azure AD can only back up passwords to Azure AD.

Devices that are joined only to AD can only back up passwords to AD.

If your devices are hybrid-joined (to both Azure AD and AD), then you have to choose a specific directory. Backing up passwords to both directories isn't supported.

## Getting started

Once you have an idea of which scenario you want to use, proceed to one of the following articles:

[Getting started with Windows LAPS and Azure AD](../laps/laps-scenarios-aad.md).

[Getting started with Windows LAPS and Active Directory](../laps/laps-scenarios-ad.md).

[Getting started with Windows LAPS in Legacy LAPS emulation mode](../laps/laps-scenarios-legacy.md)
