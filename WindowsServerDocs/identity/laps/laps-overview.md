---
title: Windows LAPS overview
description: Get an overview of Windows Local Administrator Password Solution (Windows LAPS), including key scenarios and setup and management options.
author: jay98014
ms.author: jsimmons
ms.date: 11/08/2022
ms.topic: overview
---

# What is Windows LAPS?

Windows Local Administrator Password Solution (Windows LAPS) is a Windows feature that automatically manages and backs up the password of a local administrator account on your Azure Active Directory-joined or Windows Server Active Directory-joined devices. You also can use Windows LAPS to automatically manage and back up the Directory Services Repair Mode (DSRM) account password on your Windows Server Active Directory domain controllers. An authorized administrator can retrieve the DSRM password and use it.

> [!IMPORTANT]
> Windows LAPS currently is available only in [Windows 11 Insider Preview Build 25145 and later](/windows-insider/flight-hub/#active-development-builds-of-windows-11). Support for the Windows LAPS Azure Active Directory scenario is currently in private preview, and limited to a small number of customers who have a direct engagement with engineering. Once public preview is declared in 2023, all customers will be able to evaluate this AAD scenario.

## Benefits of using Windows LAPS

Use Windows LAPS to regularly rotate and manage local administrator account passwords and get these benefits:

- Protection against pass-the-hash and lateral-traversal attacks
- Improved security for remote help desk scenarios
- Ability to sign in to and recover devices that are otherwise inaccessible
- A fine-grained security model (access control lists and optional password encryption) for securing passwords that are stored in Windows Server Active Directory
- Support for the Azure role-based access control model for securing passwords that are stored in Azure Active Directory

Watch this video to learn about Windows LAPS.

>[!Video https://www.youtube.com/embed/jdEDIXm4JgU]

## Supported platforms

Windows LAPS is supported on desktop Windows, Windows Server, and Windows Server Core. Windows LAPS is a native Windows feature on all supported SKUs. No extra steps are required to install the feature.

As noted earlier, Windows LAPS currently is available only in Windows 11 Insider Preview Build 25145 and later. Support for the Windows LAPS Azure Active Directory scenario currently is limited to a small number of Windows Insider users.

## Key Windows LAPS scenarios

You can use Windows LAPS for several primary scenarios:

- Back up local administrator account passwords to [Azure Active Directory](/azure/active-directory/devices/concept-azure-ad-join) (for Azure Active Directory-joined devices)

- Back up local administrator account passwords to Windows Server Active Directory (for Windows Server Active Directory-joined clients and servers)

- Back up DSRM account passwords to Windows Server Active Directory (for Windows Server Active Directory domain controllers)

- Back up local administrator account passwords to Windows Server Active Directory by using legacy Microsoft LAPS

In each scenario, you can apply different policy settings.

Windows LAPS doesn't support Azure Active Directory workplace-joined clients.

## Understand device join state restrictions

Whether a device is joined to Azure Active Directory or Windows Server Active Directory determines how you can use Windows LAPS.

Devices that are joined only to [Azure Active Directory](/azure/active-directory/devices/concept-azure-ad-join) can back up passwords only to Azure Active Directory.

Devices that are joined only to Windows Server Active Directory can back up passwords only to Windows Server Active Directory.

Devices that are [hybrid-joined](/azure/active-directory/devices/concept-azure-ad-join-hybrid) (joined to both Azure Active Directory and Windows Server Active Directory) can back up their passwords either to Azure Active Directory or to Windows Server Active Directory. You can't back up passwords to both Azure Active Directory and Windows Server Active Directory.

## Set Windows LAPS policy

To set up and manage policy for your Windows LAPS deployment, you have multiple options:

- [Windows LAPS configuration service provider (CSP)](/windows/client-management/mdm/laps-csp)
- [Windows LAPS Group Policy](laps-management-policy-settings.md#windows-laps-group-policy)
- [Legacy Microsoft LAPS](https://www.microsoft.com/download/details.aspx?id=46899)

## Manage and monitor Windows LAPS

You also have various options to manage and monitor Windows LAPS.

Options for Windows include:

- The Windows Server Active Directory Users and Computers properties dialog
- A dedicated event log channel
- A Windows PowerShell module that's specific to Windows LAPS

Azure-based monitoring and reporting solutions are available when you back up passwords to Azure Active Directory.

## Windows LAPS vs. legacy Microsoft LAPS

You can still download an earlier version of Local Administrator Password Solution, [legacy Microsoft LAPS](https://www.microsoft.com/download/details.aspx?id=46899).

Windows LAPS inherits many design concepts from legacy Microsoft LAPS. If you're familiar with legacy Microsoft LAPS, many Windows LAPS features will be familiar. A key difference is that Windows LAPS is an entirely separate implementation that's native to Windows. Windows LAPS also adds many features that aren't available in legacy Microsoft LAPS. You can use Windows LAPS to back up passwords to Azure Active Directory, encrypt passwords in Windows Server Active Directory, and store your password history.

> [!IMPORTANT]
> Windows LAPS doesn't require you to install legacy Microsoft LAPS. You can fully deploy and use all Windows LAPS features without installing or referring to legacy Microsoft LAPS. But to help migrate an existing legacy Microsoft LAPS deployment, Windows LAPS offers [legacy Microsoft LAPS emulation mode](laps-scenarios-legacy.md).

## See also

[Legacy Microsoft LAPS](https://www.microsoft.com/download/details.aspx?id=46899)

## Next steps

- [Key concepts in Windows LAPS](laps-concepts.md)
- [Get started with Windows LAPS for Windows Server Active Directory](laps-scenarios-windows-server-active-directory.md)
- [Get started with Windows LAPS for Azure Active Directory](laps-scenarios-azure-active-directory.md)
- [Get started with Windows LAPS in legacy Microsoft LAPS emulation mode](laps-scenarios-legacy.md)
