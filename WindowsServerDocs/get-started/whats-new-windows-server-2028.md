---
title: "Windows Server 2028 Preview: New features"
description: Windows Server 2028 Preview introduces new identity, management, automation, security, recovery, storage, and virtualization features.
ms.topic: whats-new
author: robinharwood
ms.author: roharwoo
ms.date: 11/16/2026
ai-usage: ai-assisted

#customer intent: As an administrator, Windows Server Insider, or technical decision-maker, I want to discover features in Windows Server 2028 Preview so that I can evaluate them.
---

# What's new in Windows Server 2028 Preview

Windows Server 2028 Preview introduces new capabilities across identity, management, automation, security, recovery, storage, and virtualization. Administrators and technical decision-makers can evaluate these capabilities before release to identify features that merit testing and deployment planning.

This article summarizes the features available for evaluation and identifies the first Windows Server Insider Preview build in which each feature appeared. To begin evaluating the features, see [Get started with Windows Server Insider Preview](get-started-with-windows-server-insiders-preview.md).

> [!IMPORTANT]
> Windows Server 2028 is currently in PREVIEW.
> This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

For build-specific limitations and workarounds, see the known issues in the announcements for [Windows Server Insider Preview build 29706](https://aka.ms/serverinsiders), [Windows Server Insider Preview build 29683](https://techcommunity.microsoft.com/discussions/windowsserverinsiders/announcing-windows-server-vnext-preview-build-29683/4563923), and [Windows Server Insider Preview build 29651](https://techcommunity.microsoft.com/discussions/windowsserverinsiders/announcing-windows-server-vnext-preview-build-29651/4549702).

## PowerShell 7

**Insider Preview build:** [Windows Server Insider Preview build 29706](https://aka.ms/serverinsiders) (November 17, 2026)

Windows Server 2028 Preview includes PowerShell 7, providing an upgrade path from Windows PowerShell 5.1. Windows PowerShell 5.1 remains available side by side, so existing automation can continue to use it without a forced migration. For more information, see [What's new in PowerShell](/powershell/scripting/whats-new/overview).

## SMB Policy Controller

**Insider Preview build:** [Windows Server Insider Preview build 29706](https://aka.ms/serverinsiders) (November 17, 2026)

SMB Policy Controller in Windows Server 2028 Preview helps administrators reduce manual configuration and keep Server Message Block (SMB) file-share settings aligned with workload needs. Instead of configuring each managed setting individually, use PowerShell to define the intended use of an existing share, such as departmental file storage or application data, and select a security- or performance-oriented profile. You can manage share-specific and server-wide settings separately. The controller applies the managed configuration and reconciles drift to maintain the intended settings over time.

## Microsoft Entra ID and Microsoft Intune management for Windows Server

**Insider Preview build:** [Windows Server Insider Preview build 29706](https://aka.ms/serverinsiders) (November 17, 2026)

Windows Server 2028 Preview can join Microsoft Entra ID through **Settings** > **Accounts** > **Access work or school**, using the same Settings flow as Windows 11. Administrators can then sign in to Windows Server with Microsoft Entra accounts.

Microsoft Entra ID and Microsoft Intune can work alongside Azure Arc on the same server within the scope supported by this preview. Microsoft Intune provides endpoint-management workflows, while Azure Arc provides infrastructure management, monitoring, and governance. In Microsoft Intune environments that opt in to server enrollment, servers that meet the [Windows Server management in Intune requirements](https://aka.ms/IntuneServerGuide) automatically enroll in Microsoft Intune so endpoint administrators can manage them alongside Windows clients. Microsoft Intune server enrollment is off by default and intended for nonproduction preview evaluation.

Identity capabilities include:

- Join Microsoft Entra ID through **Settings** without requiring Active Directory Domain Services for the join.
- Sign in to Windows Server with Microsoft Entra accounts.
- Use device compliance as a signal for Microsoft Entra Conditional Access.
- Use Microsoft Entra accounts with administrative privileges to access supported Windows Server capabilities.

Management capabilities include:

- Automatically enroll Microsoft Entra joined servers in Microsoft Intune, or use Group Policy to enroll Microsoft Entra hybrid joined servers.
- View operating system and application inventory.
- Apply security baselines and device configuration policies supported in the Microsoft Intune server management preview through configuration service providers (CSPs).
- Deploy supported Win32 apps.
- Manage updates by using Windows Update for Business and Windows Autopatch settings supported in the Microsoft Intune server management preview.

Existing Microsoft Intune roles, scope tags, groups, and assignment filters control access and policy targeting. If Group Policy, Configuration Manager, Azure Arc, Microsoft Intune, or another tool manages the server, avoid enforcing conflicting settings.

For more information, see [Get started with Windows Server management in Intune](https://aka.ms/IntuneServerGuide).

To share feedback about the preview, submit the [Intune Server Management preview feedback form](https://forms.cloud.microsoft/r/ax1xF5ccUC) or visit the [Windows Server Insiders community](https://techcommunity.microsoft.com/category/windows-server/discussions/windowsserverinsiders). For preview issues, use these feedback channels instead of contacting Microsoft support.

## Secure by default for Server Core

**Insider Preview build:** [Windows Server Insider Preview build 29706](https://aka.ms/serverinsiders) (November 17, 2026)

Windows Server 2028 Preview includes secure-by-default configuration settings for Server Core. New installations start with stronger security protections. This change reduces the need to harden servers after deployment. These defaults help protect servers against common attacks, including credential theft, lateral movement, and protocol downgrade attacks, from the first boot.

The hardened defaults fall into seven layers:

- Network exposure
- Identity and authentication
- Privilege and administrative access
- Remote access and management
- Cryptography
- Operating system platform and code integrity
- Observability

This preview applies hardened defaults to new installations only. For more information, see [Secure by default for Windows Server](https://aka.ms/WSHardened).

## Trusted Launch for Generation 2 virtual machines

**Insider Preview build:** [Windows Server Insider Preview build 29621](https://techcommunity.microsoft.com/discussions/windowsserverinsiders/announcing-windows-server-vnext-preview-build-29621/4536572) (July 13, 2026)

Trusted Launch in Windows Server 2028 Preview helps administrators protect Generation 2 Hyper-V workloads from boot-level and firmware attacks that can compromise a virtual machine (VM) before operating-system defenses start. It uses Secure Boot, a virtual Trusted Platform Module (vTPM), and encrypted guest state. This preview doesn't support:

- Moving a Trusted Launch VM to another server.
- Using Trusted Launch VMs with failover clusters.
- Using Trusted Launch VMs with Hyper-V Replica.
- Verifying boot integrity.

For more information, see [Trusted Launch for virtual machines for Windows Server Insiders](https://techcommunity.microsoft.com/blog/windowsservernewsandbestpractices/announcing-trusted-launch-for-virtual-machines-for-windows-server-insiders/4537082).

## Quick Machine Recovery

**Insider Preview build:** [Windows Server Insider Preview build 29574](https://techcommunity.microsoft.com/discussions/windowsserverinsiders/announcing-windows-server-vnext-preview-build-29574/4515178) (April 27, 2026)

Quick Machine Recovery helps restore servers that can't start after a critical error, reducing the need for manual recovery. Quick Machine Recovery first appeared in Windows Server 2028 Preview in build 29574. It's also available for Windows Server 2025 beginning with the October 2026 security update. After repeated boot failures, the server enters a network-connected Windows Recovery Environment (WinRE), checks Windows Update for a Microsoft-published remediation, applies it, and restarts. Administrators can control whether this best-effort process runs automatically and set retry intervals and a total wait time. Recovery succeeds only if Microsoft has published an applicable remediation. For more information, see [Quick Machine Recovery](/windows/configuration/quick-machine-recovery/) and [configure Quick Machine Recovery by using Group Policy](/troubleshoot/windows-server/group-policy/configure-quick-machine-recovery-via-group-policy).

## NVMe over Fabrics

**Insider Preview build:** [Windows Server Insider Preview build 29550](https://techcommunity.microsoft.com/discussions/windowsserverinsiders/announcing-windows-server-vnext-preview-build-29550/4501665) (March 12, 2026)

The built-in Non-Volatile Memory Express (NVMe) over Fabrics (NVMe-oF) initiator in Windows Server 2028 Preview lets you access remote NVMe storage as Windows disks. Use NVMe over TCP (Transmission Control Protocol) on standard Ethernet for broader infrastructure compatibility, or use NVMe over RDMA (Remote Direct Memory Access) on supported networks for lower latency and higher throughput. You can use this preview only from the command line. It doesn't support multipathing and provides limited recovery in some network failure scenarios. For more information, see [Introducing the Windows NVMe-oF Initiator Preview](https://techcommunity.microsoft.com/blog/windowsservernewsandbestpractices/introducing-the-windows-nvme-of-initiator-preview-in-windows-server-insiders-bui/4501344).

## ReFS Boot

**Insider Preview build:** [Windows Server Insider Preview build 29531](https://techcommunity.microsoft.com/discussions/windowsserverinsiders/announcing-windows-server-vnext-preview-build-29531/4494655) (February 12, 2026)

ReFS Boot is an optional feature that lets Windows Server 2028 Preview start from a Resilient File System (ReFS)-formatted boot volume. ReFS Boot provides ReFS resilience, performance, and scale for operating system storage. For resilience, ReFS uses metadata checksums, optional integrity streams, and online scrubbing to detect corruption and keep the boot volume online without an offline `chkdsk`. For performance, ReFS speeds up storage-intensive operations such as copying large files and managing virtual machine disks. For scale, ReFS supports volumes and files up to 35 petabytes (PB).

ReFS Boot requires Unified Extensible Firmware Interface (UEFI) firmware, doesn't support Generation 1 VMs, and creates a Windows Recovery Environment (WinRE) partition of at least 2 GB. If the WinRE partition lacks space for a WinRE update, Windows might disable WinRE. If you delete the WinRE partition and extend the ReFS boot volume into that space, restoring WinRE requires a clean installation of Windows Server. For more information, see [ReFS Boot for Windows Server Insiders](https://techcommunity.microsoft.com/blog/windowsservernewsandbestpractices/announcing-refs-boot-for-windows-server-insiders/4496592) and [Resilient File System overview](../storage/refs/refs-overview.md).

## Related content

- [Get started with Windows Server Insider Preview](get-started-with-windows-server-insiders-preview.md)
- [Windows Server Insider Community](https://techcommunity.microsoft.com/t5/windows-server-insiders/bd-p/WindowsServerInsiders)
