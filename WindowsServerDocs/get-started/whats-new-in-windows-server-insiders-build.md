---
title: What's new in Windows Server Insiders Preview
description: This article describes some of the new features in Windows Server Insiders Preview.
ms.topic: article
author: xelu86
ms.author: wscontent
ms.contributor: stacycl
ms.date: 12/08/2023
ms.prod: windows-server
---

# What's new in Windows Server Insiders Preview

> [!IMPORTANT]
> Windows Server Insider builds are in PREVIEW. This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

This article describes some of the new features in Windows Server Insiders Preview. Windows Server Insiders Preview is built on the strong foundation of Windows Server 2022 and brings many innovations.

## What's new

The following new features are specific to Windows Server with Desktop Experience only. Having both the physical devices running the operating system and the correct drivers readily available are required.

## Build 25997



### Delegated Managed Service Account (dMSA)

This new type of account enables migration from a Service Account to a dMSA. This account type comes with managed and fully randomized keys ensuring minimal application changes while disabling the original service account passwords.



### Server Message Block (SMB)

- The [SMB over QUIC](/windows-server/storage/file-server/smb-over-quic) server feature, which was only available in Windows Server Azure Edition, is now available in both Windows Server Standard and Windows Server Datacenter versions.

  The latest update to the SMB client allows for connecting to an SMB server via TCP, QUIC, or RDMA using nondefault network ports. Previously, SMB only supported TCP/445, QUIC/443, and RDMA iWARP/5445 with hardcoded defaults. The SMB over QUIC server in Windows Server will soon be able to support SMB over QUIC endpoints configured with ports other than the default of 443. Windows Server doesn't have a built-in option to configure alternative SMB server TCP ports that third-party solutions, like Samba, can offer. You can specify an alternative SMB client port using the [net use](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/gg651155(v=ws.11)) command or [New-SmbMapping](/powershell/module/smbshare/new-smbmapping?view=windowsserver2022-ps) PowerShell cmdlet.

  SMB over QUIC now supports using certificates with subject alternative names and not just a single subject. This feature allows using a Microsoft AD Certificate Authority and multiple endpoint names where self-signed test certificates aren't required.

- Previously, when creating SMB shares on Windows, the default behavior of the Windows Defender Firewall was to enable the rules in the "File and Printer Sharing" group for the relevant firewall profiles. Windows now configures a new group called "File and Printer Sharing (Restrictive)" that doesn't include inbound NetBIOS ports 137-139. In the future, the plan is to update this rule so that it removes inbound ICMP, LLMNR, and Spooler Service ports, restricting access to only the ports necessary for SMB sharing.

  This change raises the default standard for network security and aligns the [SMB firewall rules](https://techcommunity.microsoft.com/t5/storage-at-microsoft/smb-firewall-rule-changes-in-windows-insider/ba-p/3974496) more closely with the behavior of the "File Server" role in Windows Server. Administrators can still configure the "File and Printer Sharing" group as needed. To learn more about SMB security, see [Secure SMB Traffic in Windows Server](/windows-server/storage/file-server/smb-secure-traffic).

- The SMB NTLM blocking feature now supports specifying exception lists for NTLM usage. This feature allows administrators to implement a general block on NTLM usage, but still permit clients to use NTLM for specific servers that don't support Kerberos. This scenario can occur for servers that aren't part of an Active Directory domain or third-party servers that don't have Kerberos support.

### Wi-Fi

The Wireless LAN Service feature is installed by default and the WLAN AutoConfig service startup is set to automatic.

### Winget

Winget is installed by default, which is a command line Windows Package Manager tool that provides comprehensive package manager solutions for installing applications on Windows devices.

## Build 25977

### Bluetooth

You can now connect mice, keyboards, headsets, audio devices, and more via bluetooth in Windows Server.

### Email & accounts

In **Settings > Accounts > Email & accounts**, this feature was updated to align with the functionality of Windows 11. It's important to keep in mind that domain join is still required for most situations.

### SMB over QUIC Client Access Control



### OOBE

When you install and sign in for the first time, you can observe that this preview conforms to the style and appearance of the Windows 11 GUI.

## Build 25967

...

## Build 25951

### Azure Arc

The Azure Arc service loads by default and can be found in the taskbar system tray. Azure Arc extends the capabilities of the Azure platform, allowing for the creation of applications and services that can operate in diverse environments. These include data centers, the edge, multicloud environments, and provide increased flexibility. To learn more, see [Azure Arc](/azure/azure-arc/overview).

### Storage Replica Enhanced Log

Enhanced Logs help the Storage Replica log implementation to eliminate the performance costs associated with file system abstractions, leading to improved block replication performance. To learn more, see [Storage Replica Enhanced Log](/windows-server/storage/storage-replica/storage-replica-enhanced-log).

### Windows Terminal

The Windows Terminal, a powerful and efficient multishell application for command-line users, is available in this build. Search for "Terminal" in the search bar.

## Insiders Preview feedback

### How to provide feedback for Insiders Build

Your feedback is valuable to us as it provides insight to what is currently working, capturing bugs, and suggestions of where improvements can be made. To learn how to provide feedback, see [Deeper look at feedback](/windows-insider/feedback).

Use your registered Windows 10 or Windows 11 device and open the [Feedback Hub](https://aka.ms/WIPFeedbackHub) app. In the Feedback Hub app, provide us:

1. A title about the issue with the preview build number. Example, _Server Manager Issue in Windows Server Standard 25997_.
1. A detailed explanation of what is occurring.
1. For the **Category**, select **Windows Server**.
1. Attaching a screenshot of the issue is optional.
1. Complete submitting your feedback.

See [Explore the Feedback Hub](/windows-insider/feedback-hub/feedback-hub-app) to learn more.
