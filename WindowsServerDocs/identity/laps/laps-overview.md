---
title: Windows LAPS overview
description: Get an overview of Windows Local Administrator Password Solution (Windows LAPS), including key scenarios and setup and management options.
author: dknappettmsft
ms.author: daknappe
ms.date: 03/10/2025
ms.topic: overview
# customer intent: As an administrator, I want to become familiar with the Windows Local Administrator Password Solution (Windows LAPS) feature so that I can use it to manage and back up administrator passwords.
---

# What is Windows LAPS?

Windows Local Administrator Password Solution (Windows LAPS) is a Windows feature that automatically manages and backs up the password of a local administrator account on your Microsoft Entra-joined or Windows Server Active Directory-joined devices. You also can use Windows LAPS to automatically manage and back up the Directory Services Restore Mode (DSRM) account password on your Windows Server Active Directory domain controllers. An authorized administrator can retrieve the DSRM password and use it.

## Windows LAPS supported platforms

Windows LAPS is available on the following OS platforms:

### Windows client

- Windows 11 23H2 and later.
- Other versions of Windows client that have received the April 11, 2023 Update or later, including:
  - [Windows 11 22H2 - April 11 2023 Update](https://support.microsoft.com/help/5025239) and later.
  - [Windows 11 21H2 - April 11 2023 Update](https://support.microsoft.com/help/5025224) and later.
  - [Windows 10 - April 11 2023 Update](https://support.microsoft.com/help/5025221) and later.

> [!NOTE]
> The [Automatic Account Management](/windows/client-management/mdm/laps-csp#automaticaccountmanagementenabled) CSP settings require Windows 11 24H2 or later. These settings don't function properly on earlier versions of Windows.

### Windows Server

- Windows Server 2025 and later.
- [Windows Server Annual Channel for Containers, 23H2 and later](https://support.microsoft.com/topic/windows-server-version-23h2-update-history-68c851ff-825a-4dbc-857b-51c5aa0ab248).
- Other versions of Windows Server that have received the April 11, 2023 Update or later, including:
  - [Windows Server 2022 - April 11 2023 Update](https://support.microsoft.com/help/5025230) and later.
  - [Windows Server 2019 - April 11 2023 Update](https://support.microsoft.com/help/5025229) and later.

All supported editions of these platforms have been updated with Windows LAPS, including long-term servicing channel (LTSC) editions. The introduction of the Windows LAPS feature doesn't modify the standard Microsoft product lifecycle policies.

## Windows LAPS and Microsoft Entra ID

Windows LAPS with Microsoft Entra ID and Microsoft Intune support is generally available as of October 23, 2023. For more information, see [Windows Local Administrator Password Solution with Microsoft Entra ID now generally available!](https://techcommunity.microsoft.com/t5/microsoft-entra-azure-ad-blog/windows-local-administrator-password-solution-with-microsoft/ba-p/3911999) and [Windows Local Administrator Password Solution in Microsoft Entra ID](/azure/active-directory/devices/howto-manage-local-admin-passwords).

## Benefits of using Windows LAPS

Use Windows LAPS to regularly rotate and manage local administrator account passwords and get these benefits:

- Protection against pass-the-hash and lateral-traversal attacks
- Improved security for remote help desk scenarios
- Ability to sign in to and recover devices that are otherwise inaccessible
- A fine-grained security model (access control lists and optional password encryption) for securing passwords that are stored in Windows Server Active Directory
- Support for the Microsoft Entra role-based access control model for securing passwords that are stored in Microsoft Entra ID

## Informational videos

The following videos offer an informative way to see more about the Windows LAPS feature.

Windows Technical Takeoff presentation (November 2022):

>[!Video https://www.youtube.com/embed/jdEDIXm4JgU]

Windows Tackling Tech discussion (August 2023):

>[!Video https://www.youtube.com/embed/bcs1gPB4dOQ]

## Key Windows LAPS scenarios

You can use Windows LAPS for several primary scenarios:

- Back up local administrator account passwords to [Microsoft Entra ID](/azure/active-directory/devices/concept-azure-ad-join) (for Microsoft Entra-joined devices)

- Back up local administrator account passwords to Windows Server Active Directory (for Windows Server Active Directory-joined clients and servers)

- Back up DSRM account passwords to Windows Server Active Directory (for Windows Server Active Directory domain controllers)

- Back up local administrator account passwords to Windows Server Active Directory by using legacy Microsoft LAPS

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
- [Legacy Microsoft LAPS](https://www.microsoft.com/download/details.aspx?id=46899)

## Manage and monitor Windows LAPS

You also have various options to manage and monitor Windows LAPS.

Options for Windows include:

- The Windows Server Active Directory Users and Computers properties dialog.
- A dedicated event log channel.
- A Windows PowerShell module that's specific to Windows LAPS.

Entra-based monitoring and reporting solutions are available when you back up passwords to Microsoft Entra ID.

## Deprecation of the legacy Microsoft LAPS product

> [!IMPORTANT]
> The [legacy Microsoft LAPS product](https://www.microsoft.com/download/details.aspx?id=46899) is deprecated as of Windows 11 23H2 and later. Installation of the legacy Microsoft LAPS Microsoft Installer (MSI) package is blocked on newer OS versions, and Microsoft no longer considers code changes for the legacy Microsoft LAPS product.
>
> Use Windows LAPS for managing local administrator account passwords. Windows LAPS is available on Windows Server 2019 and later, and on supported Windows 10 and Windows 11 clients.
>
> Microsoft will continue to support the legacy Microsoft LAPS product on older versions of Windows (earlier than Windows 11 23H2) on which it was previously supported. That support will end upon the normal end of support for those OS versions.

## Windows LAPS vs. legacy Microsoft LAPS

Windows LAPS inherits many design concepts from legacy Microsoft LAPS. If you're familiar with legacy Microsoft LAPS, many Windows LAPS features are familiar. A key difference is that Windows LAPS is an entirely separate implementation that's native to Windows. Windows LAPS also adds many features that aren't available in legacy Microsoft LAPS. You can use Windows LAPS to back up passwords to Microsoft Entra ID, encrypt passwords in Windows Server Active Directory, and store your password history.

> [!IMPORTANT]
> Windows LAPS doesn't require you to install legacy Microsoft LAPS. You can fully deploy and use all Windows LAPS features without installing or referring to legacy Microsoft LAPS. But to help migrate an existing legacy Microsoft LAPS deployment, Windows LAPS offers [legacy Microsoft LAPS emulation mode](laps-scenarios-legacy.md).

> [!IMPORTANT]
> The legacy Microsoft LAPS product is deprecated on newer Microsoft OS versions. For more information, see [Deprecation of the legacy Microsoft LAPS product](laps-overview.md#deprecation-of-the-legacy-microsoft-laps-product).

## Support statement

Microsoft released the legacy Microsoft LAPS product in calendar year 2016 on the [Microsoft Download Center](https://www.microsoft.com/download/details.aspx?id=46899). Windows LAPS shipped as part of Windows Updates released on April 11, 2023, for the platforms listed in [Windows LAPS and Microsoft Entra ID](laps-overview.md#windows-laps-and-microsoft-entra-id).

Microsoft and its support delivery organization offer assisted support for both Microsoft LAPS and Windows LAPS, including interoperability between the two products.

> [!IMPORTANT]
> The legacy Microsoft LAPS product is deprecated on newer Microsoft OS versions. For more information, see [Deprecation of the legacy Microsoft LAPS product](laps-overview.md#deprecation-of-the-legacy-microsoft-laps-product).

We strongly recommend that you begin planning now to migrate your Windows LAPS-capable systems from using legacy Microsoft LAPS over to the Windows LAPS feature. Windows LAPS offers many new security features and improved product servicing.

Questions about limitations and interoperability concerns between third-party local account password management tools and Windows LAPS should be directed to the third-party application developer, not Microsoft.

## Licensing requirements

The Windows LAPS feature itself is available for free in all supported Windows platforms.

You can back up passwords to Windows Server Active Directory with no other licensing requirements.

You can back up passwords to Microsoft Entra ID with a Microsoft Entra ID Free or higher license.

Other Entra-related or Intune-related features can have other licensing requirements.

## Submit feedback

Want to send us feedback? Feel free to submit document-specific questions via the feedback links at the bottom of this page.

You can also submit feedback and other requests via the [Windows LAPS feedback](https://aka.ms/WindowsLAPSFeedback) Tech Community page.

If your feedback is specific to the Microsoft Entra ID-related or Intune-related LAPS functionality, you can submit feedback via the [Microsoft Entra feedback forum](https://feedback.azure.com/d365community/forum/22920db1-ad25-ec11-b6e6-000d3a4f0789).

If you aren't sure where your feedback should go, submit it by using any of these options.

## See also

- [Introducing Windows Local Administrator Password Solution with Microsoft Entra ID](https://techcommunity.microsoft.com/t5/microsoft-entra-azure-ad-blog/introducing-windows-local-administrator-password-solution-with/ba-p/1942487)
- [Windows Local Administrator Password Solution in Microsoft Entra ID](https://aka.ms/cloudlaps)
- [Windows Local Administrator Password Solution with Microsoft Entra ID now generally available!](https://techcommunity.microsoft.com/t5/microsoft-entra-azure-ad-blog/windows-local-administrator-password-solution-with-microsoft/ba-p/3911999)
- [Microsoft Intune support for Windows LAPS](/mem/intune/protect/windows-laps-overview)
- [LAPS CSP](/windows/client-management/mdm/laps-csp)
- [Windows LAPS troubleshooting guidance](/troubleshoot/windows-server/windows-security/windows-laps-troubleshooting-guidance)
- [LAPS PowerShell module reference](/powershell/module/laps)
- [Legacy Microsoft LAPS](https://www.microsoft.com/download/details.aspx?id=46899)

## Next steps

- [Key concepts in Windows LAPS](laps-concepts-overview.md)
- [Get started with Windows LAPS and Windows Server Active Directory](laps-scenarios-windows-server-active-directory.md)
- [Get started with Windows LAPS and Microsoft Entra ID](laps-scenarios-azure-active-directory.md)
- [Get started with Windows LAPS in legacy Microsoft LAPS emulation mode](laps-scenarios-legacy.md)


