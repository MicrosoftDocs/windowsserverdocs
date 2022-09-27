---
title: Local Administrator Password Solution management
description: Local Administrator Password Solution management.
author: jay98014
ms.author: jsimmons
ms.date: 07/04/2022
ms.topic: article
---

# Windows LAPS Management

> Applies to: Windows 11

Windows LAPS offers multiple ways to manage the solution. This article provides a brief overview of some of the management mechanisms.

Windows LAPS currently is available only in Windows 11 Insider Preview Build 25145 and later. Support for the Windows LAPS Azure Active Directory scenario currently is limited to a small group of Windows Insider users.

## Overview

There's a large number of configuration settings that be configured via both a Group Policy setting and an Intune Configuration Service Provider (CSP):

[Windows LAPS policy settings](../laps/laps-management-policy-settings.md)

A dedicated event log channel is used to track all activity performed by the Windows LAPS client:

[Windows LAPS event log](../laps/laps-management-event-log.md)

A new PowerShell module is provided for security configuration tasks, password retrieval, and trouble-shooting scenarios:

[Windows LAPS PowerShell](../laps/laps-management-powershell.md)

## See also

[Windows LAPS policy settings](../laps/laps-management-policy-settings.md)
