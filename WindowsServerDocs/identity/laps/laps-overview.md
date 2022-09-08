---
ms.assetid: 4695eaa7-74bd-41e7-bb27-d8873963806f
title: Local Administrator Password Solution Overview
description: Local Administrator Password Solution Overview
author: jsimmons
ms.author: jsimmons
manager: jsimmons
ms.date: 07/04/2022
ms.topic: article
---

# Windows LAPS Overview

## Overview

Windows Local Administrator Password Solution (LAPS) is a Windows feature that automatically manages and backs up the password of a local administrator account on your AzureAD-joined and Active Directory-joined devices. The feature may also be used to automatically manage and back up the Directory Services Repair Mode account password on your Active Directory domain controllers. The password may then be retrieved by an authorized administrator and used as needed.

## Benefits

Using Windows LAPS to regularly rotate and manage local administrator account passwords provides many benefits:

* Protection against pass-the-hash and lateral-traversal attacks.
* Improved security for remote help-desk scenarios.
* Log into and recover devices that are otherwise inaccessible.
* Supports fine-grained security model (ACLs plus optional password encryption) for securing passwords stored in Active Directory.
* Supports Azure role-based access control model for securing passwords stored in Azure AD.

## Supported SKUs

Windows LAPS is supported on desktop Windows, Windows Server, and Windows Server Core. Windows LAPS is a native Windows feature on all supported SKUs. No extra steps are required to install the feature.

> [!IMPORTANT]
> Windows LAPS is currently only available in Windows Insider builds as of 25145 and later. Support for the Windows LAPS Azure AD scenario is currently limited to a small group of Windows Insiders.

## Passwords stored in either Azure AD or Active Directory

Windows LAPS supports backing up the managed account password to either Azure AD or on-premises Active Directory. A hybrid-joined device (joined to both Azure AD and on-premises AD) can be configured to back up passwords to either directory. However, backing up passwords to both directories from a single device isn't supported.

> [!IMPORTANT]
> Windows LAPS doesn't support Azure workplace-joined clients.

## Policy management

Windows LAPS supports multiple policy management mechanisms:

[Windows LAPS CSP](/windows/client-management/mdm/laps-csp.md)

[Windows LAPS Group Policy](../laps/laps-management-policysettings.md#laps-group-policy)

[Legacy LAPS](https://www.microsoft.com/download/details.aspx?id=46899)

## Management and monitoring

Windows LAPS provides various ways to manage and monitor the solution.

Options include an Active Directory Users and Computers property page, a dedicated event log channel, and a Windows PowerShell module.

In addition to these in-Windows options, there are Azure-based monitoring and reporting solutions available when you're backing passwords up to Azure AD.

For more information, see [Windows LAPS Management](../laps/laps-management.md).

## Relationship to original version of LAPS

Microsoft previously shipped an earlier version of this feature with the same name that is still available for download [here](https://www.microsoft.com/download/details.aspx?id=46899).

> [!TIP]
> For brevity, the original version of LAPS will be referred to as "legacy LAPS".

Windows LAPS inherits many design concepts from legacy LAPS. So if you're familiar with legacy LAPS, many Windows LAPS features will look familiar to you. The first key difference is that Windows LAPS is an entirely separate, native-to-Windows implementation. Windows LAPS also adds many new features that weren't present in legacy LAPS. Examples include the ability to back up passwords to Azure AD, the ability to encrypt passwords in Active Directory, and password history support.

> [!IMPORTANT]
> Windows LAPS doesn't require installation of legacy LAPS. You can fully deploy and use all Windows LAPS features with no need to ever install or even refer to legacy LAPS. However Windows LAPS does support a legacy LAPS "emulation mode" which will be discussed later.

# Next steps

Learn more about basic concepts by checking out [Windows LAPS Concepts](../laps/laps-concepts.md).

# Related articles

[Windows LAPS Concepts](../laps/laps-concepts.md)

[Windows LAPS Scenario guides](../laps/laps-scenarios.md)

[Windows LAPS Management](../laps/laps-management.md)

[Windows LAPS Technical Reference](../laps/laps-technicalreference.md)

[Legacy LAPS](https://www.microsoft.com/download/details.aspx?id=46899)