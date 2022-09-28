---
title: Windows Local Administrator Password Solution (Windows LAPS) overview
description: Get an overview of Windows Local Administrator Password Solution (Windows LAPS).
author: jay98014
ms.author: jsimmons
ms.date: 07/04/2022
ms.topic: overview
---

# What is Windows LAPS?

Windows Local Administrator Password Solution (Windows LAPS) is a Windows feature that automatically manages and backs up the password of a local administrator account on your Azure Active Directory-joined and Windows Server Active Directory-joined devices. You also can use Windows LAPS to automatically manage and back up the Directory Services Repair Mode (DSRM) account password on your Windows Server Active Directory domain controllers. An authorized administrator can retrieve the DSRM password and use it.

> [!IMPORTANT]
> Windows LAPS currently is available only in Windows 11 Insider Preview Build 25145 and later. Support for the Windows LAPS Azure Active Directory scenario currently is limited to a small group of Windows Insider users.

## Benefits of using Windows LAPS

Using Windows LAPS to regularly rotate and manage local administrator account passwords provides many benefits:

- Protection against pass-the-hash and lateral-traversal attacks.
- Improved security for remote help desk scenarios.
- Ability to log in to and recover devices that are otherwise inaccessible.
- Fine-grained security model (access control lists and optional password encryption) for securing passwords stored in Windows Server Active Directory.
- Supports the Azure role-based access control model for securing passwords stored in Azure Active Directory.

## Supported SKUs

Windows LAPS is supported on desktop Windows, Windows Server, and Windows Server Core. Windows LAPS is a native Windows feature on all supported SKUs. No extra steps are required to install the feature.

As noted earlier, Windows LAPS currently is available only in Windows 11 Insider Preview Build 25145 and later. Support for the Windows LAPS Azure Active Directory scenario currently is limited to a small group of Windows Insider users.

## Back up passwords in Azure Active Directory or Windows Server Active Directory

Windows LAPS supports backing up the managed account password to either Azure Active Directory or Windows Server Active Directory. A hybrid-joined device (joined to both Azure Active Directory and Windows Server Active Directory) can be configured to back up passwords to either directory. However, backing up passwords to both directories from a single device isn't supported.

> [!IMPORTANT]
> Windows LAPS doesn't support Azure Active Directory workplace-joined clients.

## Set Windows LAPS policy

You have multiple options to manage your Windows LAPS policy:

- [Windows LAPS CSP](/windows/client-management/mdm/laps-csp)
- [Windows LAPS Group Policy](../laps/laps-management-policy-settings.md#laps-group-policy)
- [Microsoft LAPS (earlier version)](https://www.microsoft.com/download/details.aspx?id=46899)

## Manage and monitor Windows LAPS

You also have various options to manage and monitor Windows LAPS. Windows options include:

- Windows Server Active Directory Users and Computers property page
- Dedicated event log channel
- Windows PowerShell module

Azure-based monitoring and reporting solutions are available when you back up passwords to Azure Active Directory.

For more information, see [Manage Windows LAPS](../laps/laps-management.md).

## Windows LAPS vs. Microsoft LAPS

You can still download an earlier version of Local Administrator Password Solution, named [Microsoft LAPS](https://www.microsoft.com/download/details.aspx?id=46899).

Windows LAPS inherits many design concepts from Microsoft LAPS. If you're familiar with Microsoft LAPS, many Windows LAPS features will look familiar to you. The first key difference is that Windows LAPS is an entirely separate, native-to-Windows implementation. Windows LAPS also adds many new features that weren't present in Microsoft LAPS. Examples include the ability to back up passwords to Azure Active Directory, the ability to encrypt passwords in Windows Server Active Directory, and password history support.

> [!IMPORTANT]
> Windows LAPS doesn't require installation of Microsoft LAPS. You can fully deploy and use all Windows LAPS features with no need to ever install or even refer to Microsoft LAPS. However Windows LAPS does support a Microsoft LAPS "emulation mode" which will be discussed later.

## See also

[Windows LAPS concepts](../laps/laps-concepts.md)

[Windows LAPS scenario guide](../laps/laps-scenarios.md)

[Windows LAPS management](../laps/laps-management.md)

[Windows LAPS technical reference](../laps/laps-technical-reference.md)

[Microsoft LAPS (earlier version)](https://www.microsoft.com/download/details.aspx?id=46899)
