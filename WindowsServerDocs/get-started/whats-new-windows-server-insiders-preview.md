---
title: What's new in Windows Server Insiders Preview
description: This article describes some of the new features in Windows Server Insiders Preview.
ms.topic: article
author: xelu86
ms.author: wscontent
ms.date: 02/01/2024
ms.prod: windows-server
---

# What's new in Windows Server Insiders Preview

> [!IMPORTANT]
> Windows Server Insider builds are in PREVIEW. This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

This article describes some of the new features in Windows Server Insiders Preview. Windows Server Insiders Preview is built on the strong foundation of Windows Server 2022 and brings many innovations.

## What's new

The following new features are specific to Windows Server with Desktop Experience only. Having both the physical devices running the operating system and the correct drivers readily available are required.

### Active Directory Domain Services

The latest enhancements to Active Directory Domain Services (AD DS) and Active Directory Lightweight Domain Services (AD LDS) introduce a range of new functionalities and capabilities aimed at optimizing your domain management experience. To learn more, see [What's new in Active Directory Domain Services Insider Preview](/windows-server/identity/ad-ds/whats-new-active-directory-domain-services-insider-preview).

### Azure Arc

The Azure Arc service loads by default and can be found in the taskbar system tray. Azure Arc extends the capabilities of the Azure platform, allowing for the creation of applications and services that can operate in diverse environments. These include data centers, the edge, multicloud environments, and provide increased flexibility. To learn more, see [Azure Arc](/azure/azure-arc/overview).

### Bluetooth

You can now connect mice, keyboards, headsets, audio devices, and more via bluetooth in Windows Server Preview.

### Desktop shell

When you sign in for the first time, the desktop shell experience conforms to the style and appearance of Windows 11.

### Delegated Managed Service Account

This new type of account enables migration from a service account to a delegated Managed Service Account (dMSA). This account type comes with managed and fully randomized keys ensuring minimal application changes while disabling the original service account passwords.

### Email & accounts

You can now add the following accounts in **Settings > Accounts > Email & accounts** for Windows Server Preview:

- Microsoft Entra ID
- Microsoft account
- Work or school account

It's important to keep in mind that domain join is still required for most situations.

### Feedback Hub

Submitting feedback or reporting problems encountered while using Windows Server Preview can now be done using the Windows Feedback Hub. You can include screenshots or recordings of the process that caused the issue to help us understand your situation and share suggestions to enhance your Windows experience.

### File Compression

Build 26040 has a new compression feature when compressing an item by performing a right-click called **Compress to**. This feature supports **ZIP**, **7z**, and **TAR** compression formats with specific compression methods for each.

### Flighting

Flighting is only available for the Canary Channel release beginning in early 2024 starting with Preview build 26010, which allows users to receive Windows Server flights similar to Windows client. To enable flighting on your device, go to **Start > Settings > Windows Update > Windows Insider Program**. From there, you can choose to opt into your desired Insiders release.

### Pinned apps

Pinning your most used apps is now available through the **Start** menu and is customizable to suit your needs. As of build 26040, the default pinned apps in Preview are currently **Edge**, **File Explorer**, and **Settings**.

### Server Message Block

Server Message Block (SMB) is one of the most widely used protocols in networking in providing a reliable way to share files and other resources between devices on your network. Windows Server Preview brings the following SMB capabilities:

- The [SMB over Quick UDP Internet Connections](/windows-server/storage/file-server/smb-over-quic) (QUIC) server feature, which was only available in Windows Server Azure Edition, is now available in both Windows Server Standard and Windows Server Datacenter versions. SMB over QUIC adds the benefits of the QUIC which provides low-latency, encrypted connections over the internet. See [SMB over QUIC now available in Windows Server Insider Datacenter and Standard editions](https://techcommunity.microsoft.com/t5/storage-at-microsoft/smb-over-quic-now-available-in-windows-server-insider-datacenter/ba-p/3975242) for more details.

  Previously, SMB server in Windows has mandated inbound connections to use the IANA-registered port TCP/445 while the SMB TCP client has only allowed outbound connections to that same TCP port. Now, SMB over QUIC allows for [SMB alternative ports](https://techcommunity.microsoft.com/t5/storage-at-microsoft/smb-alternative-ports-now-supported-in-windows-insider/ba-p/3974509) where QUIC-mandated UDP/443 ports are available for both server and client devices.

  Another feature that has been introduced to SMB over QUIC is [client access control](https://techcommunity.microsoft.com/t5/storage-at-microsoft/smb-over-quic-client-access-control-now-supported-in-windows/ba-p/3951938), which is alternative to TCP and RDMA that supplies secure connectivity to edge file servers over untrusted networks.

- Previously, when a share was created, the [SMB firewall rules](https://techcommunity.microsoft.com/t5/storage-at-microsoft/smb-firewall-rule-changes-in-windows-insider/ba-p/3974496) would be automatically configured to enable the "File and Printer Sharing" group for the relevant firewall profiles. Now, the creation of an SMB share in Windows results in the automatic configuration of the new "File and Printer Sharing (Restrictive)" group, which no longer permits inbound NetBIOS ports 137-139.

- Starting with build 25997, an update has been made to [enforce SMB encryption](https://techcommunity.microsoft.com/t5/storage-at-microsoft/smb-client-encryption-mandate-now-supported-in-windows-insider/ba-p/3964037) for all outbound SMB client connections. With this update, administrators can set a mandate that all destination servers support SMB 3.x and encryption. If a server lacks these capabilities, the client will be unable to establish a connection.

- Also in build 25997, the [SMB authentication rate limiter](https://techcommunity.microsoft.com/t5/storage-at-microsoft/smb-authentication-rate-limiter-now-on-by-default-in-windows/ba-p/3634244), which limits the number of authentication attempts that can be made within a certain time period, is set to enabled by default.

- Starting with build 25951, the SMB client has been updated to support [NTLM blocking](https://techcommunity.microsoft.com/t5/storage-at-microsoft/smb-ntlm-blocking-now-supported-in-windows-insider/ba-p/3916206) for remote outbound connections. This is a departure from the previous behavior, where the Windows Simple and Protected GSSAPI Negotiation Mechanism ([SPNEGO](/openspecs/windows_protocols/ms-spng/b16309d8-4a93-4fa6-9ee2-7d84b2451c84)) would negotiate Kerberos, NTLM, and other mechanisms with the destination server to determine a supported security package.

- Also introduced in build 25951, is the [SMB dialect management](https://techcommunity.microsoft.com/t5/storage-at-microsoft/smb-dialect-management-now-supported-in-windows-insider/ba-p/3916368) feature where the SMB server now controls which SMB 2 and SMB 3 dialects it negotiates compared to the previous behavior matching only the highest dialect.

- Beginning with build 25931, [SMB signing](https://techcommunity.microsoft.com/t5/storage-at-microsoft/smb-signing-required-by-default-in-windows-insider/ba-p/3831704) is now required by default for all SMB outbound connections where previously this was only required when connecting to shares named **SYSVOL** and **NETLOGON** on AD domain controllers.

- The [Remote Mailslot](https://techcommunity.microsoft.com/t5/storage-at-microsoft/the-beginning-of-the-end-of-remote-mailslots-as-part-of-windows/ba-p/3762048) protocol is disabled by default starting in build 25314.

### Storage Replica Enhanced Log

Enhanced Logs help the Storage Replica log implementation to eliminate the performance costs associated with file system abstractions, leading to improved block replication performance. To learn more, see [Storage Replica Enhanced Log](/windows-server/storage/storage-replica/storage-replica-enhanced-log).

### Task Manager

Build 26040 now sports the modern task manager app with mica material conforming to the style of Windows 11.

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
