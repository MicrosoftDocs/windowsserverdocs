---
title: "Windows LAPS Overview: Manage Admin Passwords"
description: Get an overview of Windows Local Administrator Password Solution (Windows LAPS), including key scenarios and setup and management options.
author: robinharwood
ms.author: roharwoo
ms.date: 09/14/2026
ms.topic: concept-article
ai-usage: ai-assisted
# customer intent: As an administrator, I want to become familiar with the Windows Local Administrator Password Solution (Windows LAPS) feature so that I can use it to manage and back up administrator passwords.
---

# What is Windows LAPS?

Windows Local Administrator Password Solution (Windows LAPS) is a Windows feature that automatically manages and backs up the password of a local administrator account on your Microsoft Entra-joined or Windows Server Active Directory-joined devices. You can also use Windows LAPS to manage and back up the Directory Services Restore Mode (DSRM) account password on your Windows Server Active Directory domain controllers.

Local administrator accounts often share the same password across many devices, which bad actors can exploit to move laterally across your environment. Windows LAPS helps you close that gap by regularly rotating each device's local administrator password, storing it securely, and letting authorized administrators retrieve it to sign in to or recover a device.

This article introduces the platforms that Windows LAPS supports, its key scenarios and benefits, and how it differs from the legacy Microsoft LAPS product, so that you can decide how to use Windows LAPS in your environment.

## Windows LAPS supported platforms

Windows LAPS is available on the following OS platforms:

### Windows client

- Windows 11 23H2 and later.
- Other versions of Windows client that received the April 11, 2023 Update or later, including:
  - [Windows 11 22H2 - April 11 2023 Update](https://support.microsoft.com/help/5025239) and later.
  - [Windows 11 21H2 - April 11 2023 Update](https://support.microsoft.com/help/5025224) and later.
  - [Windows 10 - April 11 2023 Update](https://support.microsoft.com/help/5025221) and later.

Windows 10 reached the end of support on October 14, 2025. Windows LAPS remains available only on Windows 10 devices that continue to receive updates, such as through the Extended Security Updates (ESU) program. For supported Windows 10 servicing and lifecycle dates, see the [Windows lifecycle FAQ](/lifecycle/faq/windows). For new deployments, use Windows 11 or a supported version of Windows Server.

The [Automatic Account Management](/windows/client-management/mdm/laps-csp#automaticaccountmanagementenabled) settings in the Windows LAPS configuration service provider (CSP) require Windows 11, version 24H2 or later, or Windows Server 2025 or later.

### Windows Server

- Windows Server 2025 and later.
- [Windows Server Annual Channel for Containers, 23H2 and later](https://support.microsoft.com/topic/windows-server-version-23h2-update-history-68c851ff-825a-4dbc-857b-51c5aa0ab248).
- Other versions of Windows Server that received the April 11, 2023 Update or later, including:
  - [Windows Server 2022 - April 11 2023 Update](https://support.microsoft.com/help/5025230) and later.
  - [Windows Server 2019 - April 11 2023 Update](https://support.microsoft.com/help/5025229) and later.

Windows LAPS is available in all supported editions of these platforms, including long-term servicing channel (LTSC) editions. Introducing the Windows LAPS feature doesn't modify the standard Microsoft product lifecycle policies.

## Windows LAPS and Microsoft Entra ID

Windows LAPS with Microsoft Entra ID and Microsoft Intune support is generally available as of October 23, 2023. For more information, see [Windows Local Administrator Password Solution with Microsoft Entra ID now generally available!](https://techcommunity.microsoft.com/t5/microsoft-entra-azure-ad-blog/windows-local-administrator-password-solution-with-microsoft/ba-p/3911999) and [Windows Local Administrator Password Solution in Microsoft Entra ID](/azure/active-directory/devices/howto-manage-local-admin-passwords).

## Benefits of using Windows LAPS

Use Windows LAPS to regularly rotate and manage local administrator account passwords and get these benefits:

- Protection against pass-the-hash and lateral-traversal attacks
- Improved security for remote help desk scenarios
- Ability to sign in to and recover devices that are otherwise inaccessible
- A fine-grained security model (access control lists and optional password encryption) for securing passwords stored in Windows Server Active Directory
- Support for the Microsoft Entra role-based access control model for securing passwords stored in Microsoft Entra ID

## Windows LAPS informational videos

The following videos give you more information about the Windows LAPS feature. Because these videos don't include text content, use the surrounding articles for the authoritative Windows LAPS guidance.

Windows Technical Takeoff presentation (November 2022):

> [!VIDEO https://www.youtube.com/embed/jdEDIXm4JgU]

Windows Tackling Tech discussion (August 2023):

> [!VIDEO https://www.youtube.com/embed/bcs1gPB4dOQ]

## Key Windows LAPS scenarios

You can use Windows LAPS for several primary scenarios:

- Back up local administrator account passwords to [Microsoft Entra ID](/azure/active-directory/devices/concept-azure-ad-join) (for Microsoft Entra-joined devices)

- Back up local administrator account passwords to Windows Server Active Directory (for Windows Server Active Directory-joined clients and servers)

- Back up DSRM account passwords to Windows Server Active Directory (for Windows Server Active Directory domain controllers)

- Back up local administrator account passwords to Windows Server Active Directory by using [legacy Microsoft LAPS emulation mode](laps-scenarios-legacy.md), in which native Windows LAPS honors your existing legacy Microsoft LAPS Group Policy settings during migration

In each scenario, you can apply different policy settings.

## Understand device join state restrictions

Whether a device is joined to Microsoft Entra ID or Windows Server Active Directory determines how you can use Windows LAPS.

- Devices that are joined only to [Microsoft Entra ID](/azure/active-directory/devices/concept-azure-ad-join) can back up passwords only to Microsoft Entra ID.
- Devices that are joined only to Windows Server Active Directory can back up passwords only to Windows Server Active Directory.
- Devices that are [hybrid-joined](/azure/active-directory/devices/concept-azure-ad-join-hybrid) (joined to both Microsoft Entra ID and Windows Server Active Directory) can back up their passwords either to Microsoft Entra ID or to Windows Server Active Directory.

You can't back up passwords to both Microsoft Entra ID and Windows Server Active Directory.

Windows LAPS doesn't support Microsoft Entra workplace-joined clients.

## Set Windows LAPS policy

To set up and manage policy for your Windows LAPS deployment, you have multiple options:

- [Windows LAPS configuration service provider (CSP)](/windows/client-management/mdm/laps-csp)
- [Windows LAPS Group Policy](laps-management-policy-settings.md#windows-laps-group-policy)
- [Legacy Microsoft LAPS emulation mode](laps-scenarios-legacy.md), in which native Windows LAPS reads your existing legacy Microsoft LAPS Group Policy settings

## Manage and monitor Windows LAPS

You have several options to manage and monitor Windows LAPS.

Options for Windows include:

- The **Active Directory Users and Computers** properties dialog box. For more information, see [Get started with Windows LAPS and Windows Server Active Directory](laps-scenarios-windows-server-active-directory.md).
- A dedicated event log channel. For more information, see [Windows LAPS troubleshooting guidance](/troubleshoot/windows-server/windows-security/windows-laps-troubleshooting-guidance).
- A Windows PowerShell module that's specific to Windows LAPS. For more information, see the [LAPS PowerShell module reference](/powershell/module/laps).

When you back up passwords to Microsoft Entra ID, you get Microsoft Entra ID-based monitoring and reporting solutions.

## Deprecation of the legacy Microsoft LAPS product

> [!IMPORTANT]
> The [legacy Microsoft LAPS product](https://www.microsoft.com/download/details.aspx?id=46899) is deprecated as of Windows 11 23H2 and later. Newer OS versions block installation of the legacy Microsoft LAPS Microsoft Installer (MSI) package. Microsoft no longer considers code changes for the legacy Microsoft LAPS product.
>
> Use Windows LAPS to manage local administrator account passwords. Windows LAPS is available on Windows Server 2019 and later, and on supported Windows 10 and Windows 11 clients.
>
> Microsoft will continue to support the legacy Microsoft LAPS product on the older versions of Windows (earlier than Windows 11 23H2) that previously supported it. That support ends at the normal end of support for those OS versions.

## Windows LAPS vs. legacy Microsoft LAPS

Windows LAPS inherits many design concepts from legacy Microsoft LAPS. If you're familiar with legacy Microsoft LAPS, you recognize many Windows LAPS features. A key difference is that Windows LAPS is an entirely separate implementation that's native to Windows. Windows LAPS also adds many features that aren't available in legacy Microsoft LAPS. You can use Windows LAPS to back up passwords to Microsoft Entra ID, encrypt passwords in Windows Server Active Directory, and store your password history.

Windows LAPS doesn't require you to install legacy Microsoft LAPS. You can fully deploy and use all Windows LAPS features without installing or referring to legacy Microsoft LAPS. To help migrate an existing legacy Microsoft LAPS deployment, Windows LAPS offers [legacy Microsoft LAPS emulation mode](laps-scenarios-legacy.md). Remember that the legacy Microsoft LAPS product is deprecated on newer Microsoft OS versions. For more information, see [Deprecation of the legacy Microsoft LAPS product](#deprecation-of-the-legacy-microsoft-laps-product).

## From legacy Microsoft LAPS to native Windows LAPS

Because the legacy Microsoft LAPS product is deprecated and newer Windows versions block its installer, native Windows LAPS is the supported way to manage local administrator passwords. Native Windows LAPS requires no separate download or installation. It's built into supported versions of Windows and Windows Server, so you don't need to install legacy Microsoft LAPS to adopt it.

To plan and complete the move on devices that currently run legacy Microsoft LAPS, see [Migrate to Windows LAPS from legacy LAPS](laps-scenarios-migration.md). That article is the authoritative source for the migration prerequisites, the available migration options, how to validate that native Windows LAPS manages your accounts successfully, and how to remove the legacy Microsoft LAPS software after the transition.

## Legacy Microsoft LAPS emulation mode

If you can't move directly to native Windows LAPS, you can run Windows LAPS in *legacy Microsoft LAPS emulation mode* as a transitional option. In this mode, Windows LAPS honors your existing legacy Microsoft LAPS Group Policy settings while you complete the migration.

Emulation mode has two critical prerequisites:

- Don't install the legacy Microsoft LAPS Group Policy client-side extension (CSE) on the managed device. If the legacy CSE is present, Windows LAPS defers to it and disables emulation mode to avoid conflicts.
- Native Windows LAPS policy settings take precedence. If you configure a device with both native Windows LAPS policy settings and legacy Microsoft LAPS policy settings, Windows LAPS applies the native settings and ignores the emulated legacy settings.

Emulation mode has security limitations. Like legacy Microsoft LAPS, it stores passwords in Windows Server Active Directory only in clear-text form, so it can't use the password encryption or password history features of native Windows LAPS. Treat emulation mode as a temporary step, and plan to migrate to native Windows LAPS to take advantage of its security features. For more information, see [Get started with Windows LAPS in legacy Microsoft LAPS emulation mode](laps-scenarios-legacy.md).

## Windows LAPS and legacy Microsoft LAPS support statement

Microsoft released the legacy Microsoft LAPS product in 2016 on the [Microsoft Download Center](https://www.microsoft.com/download/details.aspx?id=46899). Windows LAPS shipped as part of Windows Updates released on April 11, 2023, for the platforms listed in [Windows LAPS supported platforms](#windows-laps-supported-platforms).

Microsoft and its support delivery organization offer assisted support for both legacy Microsoft LAPS and Windows LAPS, including interoperability between the two products. Microsoft deprecated the legacy Microsoft LAPS product on newer Microsoft OS versions. For more information, see [Deprecation of the legacy Microsoft LAPS product](#deprecation-of-the-legacy-microsoft-laps-product).

We strongly recommend that you begin planning now to migrate your Windows LAPS-capable systems from legacy Microsoft LAPS to the Windows LAPS feature. Windows LAPS offers many new security features and improved product servicing.

Direct questions about limitations and interoperability concerns between third-party local account password management tools and Windows LAPS to the developer of the third-party application, not Microsoft.

## Windows LAPS licensing requirements

The Windows LAPS feature is available at no cost on all supported Windows platforms.

You can back up passwords to Windows Server Active Directory with no other licensing requirements.

You can back up passwords to Microsoft Entra ID with a Microsoft Entra ID Free or higher license.

Other Microsoft Entra ID or Microsoft Intune features can have other licensing requirements.

## Submit feedback about Windows LAPS

Want to send us feedback? To submit document-specific questions, use the feedback links at the bottom of this page.

You can also submit feedback and other requests on the [Windows LAPS feedback](https://aka.ms/WindowsLAPSFeedback) Tech Community page.

If your feedback is specific to the Microsoft Entra ID-related or Intune-related LAPS functionality, submit feedback through the [Microsoft Entra feedback forum](https://feedback.azure.com/d365community/forum/22920db1-ad25-ec11-b6e6-000d3a4f0789).

If you aren't sure where your feedback should go, submit it by using any of these options.

## Related content

- [Key concepts in Windows LAPS](laps-concepts-overview.md)
- [Get started with Windows LAPS and Windows Server Active Directory](laps-scenarios-windows-server-active-directory.md)
- [Get started with Windows LAPS and Microsoft Entra ID](laps-scenarios-azure-active-directory.md)
- [Get started with Windows LAPS in legacy Microsoft LAPS emulation mode](laps-scenarios-legacy.md)
- [Migrate to Windows LAPS from legacy LAPS](laps-scenarios-migration.md)
- [Windows LAPS CSP](/windows/client-management/mdm/laps-csp)
- [LAPS PowerShell module reference](/powershell/module/laps)
- [Windows LAPS troubleshooting guidance](/troubleshoot/windows-server/windows-security/windows-laps-troubleshooting-guidance)
- [Microsoft Intune support for Windows LAPS](/mem/intune/protect/windows-laps-overview)
- [Windows Local Administrator Password Solution in Microsoft Entra ID](/azure/active-directory/devices/howto-manage-local-admin-passwords)


