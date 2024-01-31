---
title: What's new in Windows Server Insiders Preview
description: This article describes some of the new features in Windows Server Insiders Preview.
ms.topic: article
author: xelu86
ms.author: wscontent
ms.contributor: stacycl
ms.date: 01/23/2024
---

# What's new in Windows Server Insiders Preview

> [!IMPORTANT]
> Windows Server Insider builds are in PREVIEW. This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

This article describes some of the new features in Windows Server Insiders Preview. Windows Server Insiders Preview is built on the strong foundation of Windows Server 2022 and brings many innovations.

## What's new

The following new features are specific to Windows Server with Desktop Experience only. Having both the physical devices running the operating system and the correct drivers readily available are required.

### Azure Arc

The Azure Arc service loads by default and can be found in the taskbar system tray. Azure Arc extends the capabilities of the Azure platform, allowing for the creation of applications and services that can operate in diverse environments. These include data centers, the edge, multicloud environments, and provide increased flexibility. To learn more, see [Azure Arc](/azure/azure-arc/overview).

### Bluetooth

You can now connect mice, keyboards, headsets, audio devices, and more via bluetooth in Windows Server Preview.

### Desktop shell

When you sign in for the first time, the desktop shell experience conforms to the style and appearance of Windows 11.

### Delegated Managed Service Account (dMSA)

This new type of account enables migration from a service account to a dMSA. This account type comes with managed and fully randomized keys ensuring minimal application changes while disabling the original service account passwords.

### Email & accounts

In **Settings > Accounts > Email & accounts**, this feature was updated to align with the functionality of Windows 11. It's important to keep in mind that domain join is still required for most situations. To take advantage of addition, add a Microsoft account, work account, or school account.

### Feedback Hub

Submitting feedback or reporting problems encountered while using Windows Server Preview can now be done using the Windows Feedback Hub. You can include screenshots or recordings of the process that caused the issue to help us understand your situation and share suggestions to enhance your Windows experience.

### Flighting

Flighting is only available for the Canary Channel release beginning in early 2024 starting with Preview build 26010, which allows users to receive Windows Server flights similar to Windows client. To enable flighting on your device, go to **Start > Settings > Windows Update > Windows Insider Program**. From there, you can choose to opt into your desired Insiders release.

### Pinned apps

Pinning your most used apps is now available through the **Start** menu and is customizable to suit your needs. As of build 26010, the default pinned apps in Preview are currently **Edge**, **File Explorer**, and **Settings**.

### Server Message Block (SMB)

- The [SMB over QUIC](/windows-server/storage/file-server/smb-over-quic) server feature, which was only available in Windows Server Azure Edition, is now available in both Windows Server Standard and Windows Server Datacenter versions.

  Starting with build 25997, the latest update to the SMB client allows for connecting to an SMB server via TCP, QUIC, or RDMA using nondefault network ports. Previously, SMB only supported TCP/445, QUIC/443, and RDMA iWARP/5445 with hardcoded defaults. The SMB over QUIC server in Windows Server supports SMB over QUIC endpoints configured with ports other than the default of 443. Windows Server doesn't have a built-in option to configure alternative SMB server TCP ports that third-party solutions, like Samba, can offer. You can specify an alternative SMB client port using the [net use](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/gg651155(v=ws.11)) command or [New-SmbMapping](/powershell/module/smbshare/new-smbmapping?view=windowsserver2022-ps&preserve-view=true) PowerShell cmdlet.

  SMB over QUIC now supports using certificates with subject alternative names and not just a single subject. This feature allows using a Microsoft AD Certificate Authority and multiple endpoint names where self-signed test certificates aren't required.

- Previously, when creating SMB shares on Windows, the default behavior of Windows Defender Firewall was to enable the rules in the "File and Printer Sharing" group for the relevant firewall profiles. Windows now configures a new group called "File and Printer Sharing (Restrictive)" that doesn't include inbound NetBIOS ports 137-139. An update to this rule removes inbound ICMP, LLMNR, and Spooler Service ports that restrict access to only the ports necessary for SMB sharing.

  This change raises the default standard for network security and aligns the [SMB firewall rules](https://techcommunity.microsoft.com/t5/storage-at-microsoft/smb-firewall-rule-changes-in-windows-insider/ba-p/3974496) more closely with the behavior of the "File Server" role in Windows Server. Administrators can still configure the "File and Printer Sharing" group as needed. To learn more about SMB security, see [Secure SMB Traffic in Windows Server](/windows-server/storage/file-server/smb-secure-traffic).

- The SMB NTLM blocking feature now supports specifying exception lists for NTLM usage. This feature allows administrators to implement a general block on NTLM usage, but still permit clients to use NTLM for specific servers that don't support Kerberos. This scenario can occur for servers that aren't part of an Active Directory domain or third-party servers that don't have Kerberos support.

### Storage Replica Enhanced Log

Enhanced Logs help the Storage Replica log implementation to eliminate the performance costs associated with file system abstractions, leading to improved block replication performance. To learn more, see [Storage Replica Enhanced Log](/windows-server/storage/storage-replica/storage-replica-enhanced-log).

### Wi-Fi

It's now easier to enable wireless capabilities as the Wireless LAN Service feature is now installed by default. The wireless startup service is set to manual and can be enabled by running `net start wlansvc` in the Command Prompt, Windows Terminal or PowerShell.

### Winget

Winget is installed by default, which is a command line Windows Package Manager tool that provides comprehensive package manager solutions for installing applications on Windows devices. To learn more, see [Use the winget tool to install and manage applications](/windows/package-manager/winget).

### Windows Insider Program

The Windows Insider Program provides early access to the latest Windows OS releases for a community of enthusiasts. As a member, you can be among the first to try out new ideas and concepts that Microsoft is developing. After registering as a member, you can opt to participate in different release channels by going to go to **Start > Settings > Windows Update > Windows Insider Program**.

### Windows Terminal

The Windows Terminal, a powerful and efficient multishell application for command-line users, is available in this build. Search for "Terminal" in the search bar.

## See also

- [Windows Server Insiders Community discussions](https://techcommunity.microsoft.com/t5/windows-server-insiders/bd-p/WindowsServerInsiders)
