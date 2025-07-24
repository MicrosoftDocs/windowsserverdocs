---
title: SMBv1 Not Installed by Default in Windows Server and Windows
description: Discover SMBv1 protocol changes in Windows Server and Windows, explore alternatives for legacy compatibility, and learn best practices.
ms.topic: troubleshooting
ai-usage: ai-assisted
ms.author: daknappe
author: dknappettmsft
ms.date: 06/18/2025
---

# SMBv1 not installed by default in Windows Server and Windows

The Server Message Block version 1 (SMBv1) protocol is deprecated and no longer installed by default in modern versions of Windows and Windows Server. This article provides an overview of SMBv1's removal, its behavior in various Windows editions, and alternatives for legacy compatibility. Learn how to address issues related to SMBv1, explore best practices, and understand the implications of its absence in network environments.

## Default behavior for SMBv1

Since Windows 10, version 1709 and Windows Server, version 1709, the Server Message Block version 1 (SMBv1) network protocol is no longer installed by default. SMBv2 and later protocols superseded SMBv1 starting in 2007. Microsoft publicly deprecated the SMBv1 protocol in 2014.

SMBv1 has the following behavior in Windows 10 and Windows Server 2019 and later versions:

- SMBv1 now has both client and server sub-features that can be uninstalled separately.

- Windows 10 Enterprise, Windows 10 Education, and Windows 10 Pro for Workstations no longer contain the SMBv1 client or server by default after a clean installation.

- Windows Server 2019 and later no longer contains the SMBv1 client or server by default after a clean installation.

- Windows 10 Home and Windows 10 Pro no longer contain the SMBv1 server by default after a clean installation.

- Windows 11 doesn't contain the SMBv1 server or client by default after a clean installation.

- Windows 10 Home and Windows 10 Pro, version 1709 still contain the SMBv1 client by default after a clean installation. If the SMBv1 client isn't used for 15 days in total (excluding the computer being turned off), it automatically uninstalls itself. Starting in Windows 10, version 1809, Windows 10 Pro no longer contains the SMBv1 client by default after a clean installation.

- In-place upgrades and Insider flights of Windows 10 Home and Windows 10 Pro don't automatically remove SMBv1 initially. Windows evaluates the usage of SMBv1 client and server, and if either of them isn't used for 15 days in total (excluding the time during which the computer is off), Windows automatically uninstalls it.

- In-place upgrades and Insider flights of the Windows 10 Enterprise, Windows 10 Education, and Windows 10 Pro for Workstations editions don't automatically remove SMBv1. An administrator must decide to uninstall SMBv1 in these managed environments.

- Automatic removal of SMBv1 after 15 days is a one-time operation. If an administrator reinstalls SMBv1, no further attempts are made to uninstall it.

- SMB version 2.02, 2.1, 3.0, 3.02, and 3.1.1 features are still fully supported and included by default as part of the SMBv2 binaries.

- Because the Computer Browser service relies on SMBv1, the service is uninstalled if the SMBv1 client or server is uninstalled. Without SMBv1, Explorer Network can no longer display Windows computers through the legacy NetBIOS datagram browsing method.

- SMBv1 can still be reinstalled in all editions of Windows 10 and Windows Server 2016.

- Windows Server virtual machines created by Microsoft for Azure Marketplace don't contain the SMB1 binaries and you can't enable SMB1. Third-party Azure Marketplace VMs might contain SMB1; contact their vendor for information.

> [!NOTE]
> Windows 10, version 1803 Pro handles SMBv1 in the same manner as Windows 10, version 1703 and Windows 10, version 1607. This issue was fixed in Windows 10, version 1809. You can still uninstall SMBv1 manually. However, Windows won't automatically uninstall SMBv1 after 15 days in the following scenarios:
>
> - You do a clean install of Windows 10, version 1803.
> - You upgrade Windows 10, version 1607 or Windows 10, version 1703 to Windows 10, version 1803 directly without first upgrading to Windows 10, version 1709.

## Error messages when connecting to SMBv1 devices

If you try to connect to devices that support only SMBv1, or if these devices try to connect to you, you might receive one of the following error messages:

- `You can't connect to the file share because it's not secure. This share requires the obsolete SMB1 protocol, which is unsafe and could expose your system to attack. Your system requires SMB2 or higher. For more info on resolving this issue, see: https://go.microsoft.com/fwlink/?linkid=852747.`

- `The specified network name is no longer available.`

- `Unspecified error 0x80004005`

- `System Error 64`

- `The specified server cannot perform the requested operation.`

- `Error 58`

When a remote server requires an SMBv1 connection from this client, and the SMBv1 client is installed, the following event is logged. This mechanism audits the use of SMBv1 and is also used by the automatic uninstaller to set the 15-day timer of removing SMBv1 because of lack of use.

```output
Log Name:      Microsoft-Windows-SmbClient/Security
Source:        Microsoft-Windows-SMBClient
Date:          Date/Time
Event ID:      32002
Task Category: None
Level:         Info
Keywords:      (128)
User:          NETWORK SERVICE
Computer:      computer1.contoso.com
Description:
The local computer received an SMB1 negotiate response.

Dialect:
SecurityMode
Server name:

Guidance:
SMB1 is deprecated and should not be installed nor enabled. For more information, see https://go.microsoft.com/fwlink/?linkid=852747.
```

When a remote server required an SMBv1 connection from this client, and the SMBv1 client isn't installed, the following event is logged. This event shows why the connection fails.

```output
Log Name:      Microsoft-Windows-SmbClient/Security
Source:        Microsoft-Windows-SMBClient
Date:          Date/Time
Event ID:      32000
Task Category: None
Level:         Info
Keywords:      (128)
User:          NETWORK SERVICE
Computer:      computer1.contoso.com
Description:
SMB1 negotiate response received from remote device when SMB1 cannot be negotiated by the local computer.
Dialect:
Server name:

Guidance:
The client has SMB1 disabled or uninstalled. For more information: https://go.microsoft.com/fwlink/?linkid=852747.
```

These devices aren't likely running Windows. They're more likely running older versions of Linux, Samba, or other types of third-party software to provide SMB services. Often, these versions of Linux and Samba are, themselves, no longer supported.

## Workarounds for SMBv1

You should contact the manufacturer of the product that supports only SMBv1, and request a software or firmware update that support SMBv2.02 or a later version. For a current list of known vendors and their SMBv1 requirements, see the following Windows and Windows Server Storage Engineering Team Blog article:

[SMBv1 Product Clearinghouse](https://techcommunity.microsoft.com/t5/Storage-at-Microsoft/SMB1-Product-Clearinghouse/ba-p/426008)

If an update isn't available, you can use the following workarounds to allow legacy applications to work with SMBv2 or a later version. However, these workarounds should be used only as a last resort, and only if the vendor states that they're required.

If you can't use any of these workarounds, or if the application manufacturer can't provide supported versions of SMB, you can re-enable SMBv1 manually by following the steps in [How to detect, enable and disable SMBv1, SMBv2, and SMBv3 in Windows](detect-enable-and-disable-smbv1-v2-v3.md).

> [!WARNING]
> We strongly recommend that you don't reinstall SMBv1. This older protocol has known security issues regarding ransomware and other malware.

### Leasing mode

If SMBv1 is required to provide application compatibility for legacy software behavior, such as a requirement to disable oplocks, Windows provides an SMB share flag known as *leasing mode*. This flag specifies whether a share disables modern SMB semantics such as leases and oplocks.

You can specify a share without using oplocks or leasing to allow a legacy application to work with SMBv2 or a later version. To set leasing mode, use the `New-SmbShare` or `Set-SmbShare` PowerShell cmdlets together with the `-LeasingMode None` parameter. For more information, see the [New-SmbShare](/powershell/module/smbshare/new-smbshare) and [Set-SmbShare](/powershell/module/smbshare/set-smbshare) cmdlet documentation.

> [!CAUTION]
> You should use this option only on shares required by a third-party application for legacy support if the vendor states that they require it. Don't specify leasing mode on user data shares or CA shares that are used by Scale-Out File Servers. The removal of oplocks and leases causes instability and data corruption in most applications. Leasing mode works only in Share mode.

### Explorer Network Browsing

The Computer Browser service relies on the SMBv1 protocol to populate the Windows Explorer Network node (also known as *Network Neighborhood*). This legacy protocol is long deprecated, doesn't route, and has limited security. Because the service can't function without SMBv1, it's removed at the same time.

However, if you still have to use the Explorer Network in home and small business workgroup environments to locate Windows-based computers that no longer use SMBv1, start the **Function Discovery Provider Host** and **Function Discovery Resource Publication** services, and then set them to **Automatic (Delayed Start)**. When you open Explorer Network, enable network discovery when you're prompted.

All Windows devices within that subnet that have these settings appear in Network for browsing. This method uses the *WS-DISCOVERY* protocol. Contact your other vendors and manufacturers if their devices still don't appear in this browse list after the Windows devices appear. It's possible they have this protocol disabled or that they support only SMBv1.

We recommend that you map drives and printers instead of enabling this feature, which still requires searching and browsing for their devices. Mapped resources are easier to locate, require less training, and are safer to use. This is especially true if these resources are provided automatically through Group Policy. An administrator can configure printers for location by methods other than the legacy Computer Browser service by using IP addresses, Active Directory Domain Services (AD DS), Bonjour, mDNS, uPnP, and so on.

## Windows Server best practices analyzer messaging

Windows Server 2012 and later contain a best practices analyzer (BPA) for file servers. If you followed the correct online guidance to uninstall SMB1, running this BPA returns a contradictory warning message:

```output
Title: The SMB 1.0 file sharing protocol should be enabled
Severity: Warning
Date: 3/25/2020 12:38:47 PM
Category: Configuration
Problem: The Server Message Block 1.0 (SMB 1.0) file sharing protocol is disabled on this file server.
Impact: SMB not in a default configuration, which could lead to less than optimal behavior.
Resolution: Use Registry Editor to enable the SMB 1.0 protocol.
```

You should ignore this specific BPA rule's guidance because it's deprecated. The false error was first corrected in Windows Server 2022 and Windows Server 2019 in the 2022 April Cumulative Update. Don't enable SMB 1.0.

## Related content

- [Stop using SMB1](https://aka.ms/stopusingsmb1)
