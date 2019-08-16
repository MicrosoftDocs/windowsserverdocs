---
title: User can't authenticate or must authenticate twice
description: Troubleshooting an issue in which user can't authenticate or must authenticate twice when starting a remote desktop connection.
audience: itpro ​
ms.custom: na
ms.reviewer: rklemen
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: troubleshooting
ms.assetid: 
author: kaushika-msft
manager: 
ms.author: delhan
ms.date: 07/24/2019
ms.localizationpriority: medium
---

# User can't authenticate or must authenticate twice

This article addresses several issues that can cause problems that affect user authentication.

## Access denied, restricted type of logon

In this situation, a Windows 10 user attempting to connect to Windows 10 or Windows Server 2016 computers is denied access with the following message:

> Remote Desktop Connection:  
> The system administrator has restricted the type of logon (network or interactive) that you may use. For assistance, contact your system administrator or technical support.

This issue occurs when Network Level Authentication (NLA) is required for RDP connections, and the user is not a member of the **Remote Desktop Users** group. It can also occur if the **Remote Desktop Users** group has not been assigned to the **Access this computer from the network** user right.

To solve this issue, do one of the following things:

  - [Modify the user’s group membership or user rights assignment](#modify-the-users-group-membership-or-user-rights-assignment).
  - Turn off NLA (not recommended).
  - Use remote desktop clients other than Windows 10. For example, Windows 7 clients do not have this issue.

### Modify the user’s group membership or user rights assignment

If this issue affects a single user, the most straightforward solution to this issue is to add the user to the **Remote Desktop Users** group.

If the user is already a member of this group (or if multiple group members have the same problem), check the user rights configuration on the remote Windows 10 or Windows Server 2016 computer.

1. Open Group Policy Object Editor (GPE) and connect to the local policy of the remote computer.
2. Navigate to **Computer Configuration\\Windows Settings\\Security Settings\\Local Policies\\User Rights Assignment**, right-click **Access this computer from the network**, and then select **Properties**.
3. Check the list of users and groups for **Remote Desktop Users** (or a parent group).
4. If the list doesn't include either **Remote Desktop Users** or a parent group like **Everyone**, you must add it to the list. If you have more than one computer in your deployment, use a group policy object.  
    For example, the default membership for **Access this computer from the network** includes **Everyone**. If your deployment uses a group policy object to remove **Everyone**, you may need to restore access by updating the group policy object to add **Remote Desktop Users**.

## Access denied, A remote call to the SAM database has been denied

This behavior is most likely to occur if your domain controllers are running Windows Server 2016 or later, and users attempt to connect by using a customized connection app. In particular, applications that access the user’s profile information in Active Directory will be denied access.

This behavior results from a change to Windows. In Windows Server 2012 R2 and earlier versions, when a user signs in to a remote desktop, the Remote Connection Manager (RCM) contacts the domain controller (DC) to query the configurations that are specific to Remote Desktop on the user object in Active Directory Domain Services (AD DS). This information is displayed in the Remote Desktop Services Profile tab of a user’s object properties in the Active Directory Users and Computers MMC snap-in.

Starting in Windows Server 2016, RCM no longer queries the user's object in AD DS. If you need RCM to query AD DS because you're using Remote Desktop Services attributes, you must manually enable the query.

> [!IMPORTANT]  
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To enable the legacy RCM behavior on a RD Session Host server, configure the following registry entries, and then restart the **Remote Desktop Services** service:  
  - **HKEY\_LOCAL\_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows NT\\Terminal Services**
  - **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Terminal Server\\WinStations\\\<Winstation name\>\\**  
      - Name: **fQueryUserConfigFromDC**
      - Type: **Reg\_DWORD**
      - Value: **1** (Decimal)

To enable the legacy RCM behavior on a server other than a RD Session Host server, configure these registry entries and the following additional registry entry (and then restart the service):
  - **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Terminal Server**

For more information about this behavior, see KB 3200967 [Changes to Remote Connection Manager in Windows Server](https://support.microsoft.com/help/3200967/changes-to-remote-connection-manager-in-windows-server).

## User can't sign in using a smart card

This section addresses three common scenarios where a user can't sign in to a remote desktop using a smart card.

### Can't sign in with a smart card in a branch office with a read-only domain controller (RODC)

This issue occurs in deployments that include an RDSH server at a branch site that uses a RODC. The RDSH server is hosted in the root domain. Users at the branch site belong to a child domain, and use smart cards for authentication. The RODC is configured to cache user passwords (the RODC belongs to the **Allowed RODC Password Replication Group**). When users try to sign in to sessions on the RDSH server, they receive messages such as "The attempted logon is invalid. This is either due to a bad username or authentication information."

This issue is caused by how the root DC and the RDOC manage user credential encryption. The root DC uses an encryption key to encrypt the credentials and the RODC gives the client the decryption key. When a user receives the "invalid" error, that means the two keys don't match.

To work around this issue, try one of the following things:

- Change your DC topology by turning off password caching on the RODC or deploy a writeable DC to teh branch site.
- Move the RDSH server to the same child domain as the users.
- Allow users to sign in without smart cards.

Be advised that all of these solutions require compromises in either performance or security level.

### User can't sign in to a Windows Server 2008 SP2 computer using a smart card

This issue occurs when users sign in to a Windows Server 2008 SP2 computer that has been updated with KB4093227 (2018.4B). When users attempt to sign in using a smart card, they are denied access with messages such as “No valid certificates found. Check that the card is inserted correctly and fits tightly.” At the same time, the Windows Server computer records the Application event "An error occurred while retrieving a digital certificate from the inserted smart card. Invalid Signature."

To resolve this issue, update the Windows Server computer with the 2018.06 B re-release of KB 4093227, [Description of the security update for the Windows Remote Desktop Protocol (RDP) denial of service vulnerability in Windows Server 2008: April 10, 2018](https://support.microsoft.com/help/4093227/security-update-for-vulnerabilities-in-windows-server-2008).

### Can't stay signed in with a smart card and Remote Desktop Services service hangs

This issue occurs when users sign in to a Windows or Windows Server computer that has been updated with KB 4056446. At first, the user may be able to sign in to the system by using a smart card, but then receives a “SCARD\_E\_NO\_SERVICE” error message. The remote computer may become unresponsive.

To work around this issue, restart the remote computer.

To resolve this issue, update the remote computer with the appropriate fix:

  - Windows Server 2008 SP2: KB 4090928, [Windows leaks handles in the lsm.exe process and smart card applications may display "SCARD\_E\_NO\_SERVICE" errors](https://support.microsoft.com/help/4090928/scard-e-no-service-errors-when-windows-leaks-handles-in-the-lsm-exe)
  - Windows Server 2012 R2: KB 4103724, [May 17, 2018—KB4103724 (Preview of Monthly Rollup)](https://support.microsoft.com/help/4103724/windows-81-update-kb4103724)
  - Windows Server 2016 and Windows 10, version 1607: KB 4103720, [May 17, 2018—KB4103720 (OS Build 14393.2273)](https://support.microsoft.com/help/4103720/windows-10-update-kb4103720)

## If the remote PC is locked, the user needs to enter a password twice

This issue may occur when a user attempts to connect to a remote desktop running Windows 10 version 1709 in a deployment in which RDP connections don't require NLA. Under these conditions, if the remote desktop has been locked, the user needs to enter their credentials twice when connecting.

To resolve this issue, update the Windows 10 version 1709 computer with KB 4343893, [August 30, 2018—KB4343893 (OS Build 16299.637)](https://support.microsoft.com/help/4343893/windows-10-update-kb4343893).

## User can't sign in and receives “authentication error” and “CredSSP encryption oracle remediation” messages

When users try to sign in using any version of Windows from Windows Vista SP2 and later versions or Windows Server 2008 SP2 and later versions, they're denied access and recieve messages like these:

```
An authentication error has occurred. The function requested is not supported.
...
This could be due to CredSSP encryption oracle remediation
...
```

“CredSSP encryption oracle remediation” refers to a set of security updates released in March, April, and May of 2018. CredSSP is an authentication provider that processes authentication requests for other applications. The March 13, 2018, "3B" and subsequent updates addressed an exploit in which an attacker could relay user credentials to execute code on the target system.

The initial updates added support for a new Group Policy Object, Encryption Oracle Remediation, that has the following possible settings:

  - Vulnerable: Client applications that use CredSSP can fall back to insecure versions, but this behavior exposes the remote desktops to attacks. Services that use CredSSP accept clients that have not been updated.
  - Mitigated: Client applications that use CredSSP can't fall back to insecure versions, but services that use CredSSP accept clients that have not been updated.
  - Force Updated Clients: Client applications that use CredSSP can't fall back to insecure versions, and services that use CredSSP will not accept unpatched clients. 
    > [!NOTE]
    > This setting should not be deployed until all remote hosts support the newest version.

The May 8, 2018 update changed the default Encryption Oracle Remediation setting from Vulnerable to Mitigated. With this change in place, Remote Desktop clients that have the updates can't connect to servers that don't have them (or updated servers that have not been restarted). For more information about the CredSSP updates, see [KB 4093492](https://support.microsoft.com/help/4093492/credssp-updates-for-cve-2018-0886-march-13-2018).

To resolve this issue, update and restart all systems. For a full list of updates and more information about the vulnerabilities, see [CVE-2018-0886 | CredSSP Remote Code Execution Vulnerability](https://portal.msrc.microsoft.com/security-guidance/advisory/CVE-2018-0886).

To work around this issue until the updates are complete, check KB 4093492 for allowed types of connections. If there are no feasible alternatives you may consider one of the following methods:

- For the affected client computers, set the Encryption Oracle Remediation policy back to **Vulnerable**.
- Modify the following policies in the **Computer Configuration\\Administrative Templates\\Windows Components\\Remote Desktop Services\\Remote Desktop Session Host\\Security** group policy folder:  
  - **Require use of specific security layer for remote (RDP) connections**: set to **Enabled** and select **RDP**.
  - **Require user authentication for remote connections by using Network Level authentication**: set to **Disabled**.
    > [!IMPORTANT]  
    > Changing these group policies reduces your deployment's security. We recommend you only use them temporarily, if at all.

For more information about working with group policy, see [Modifying a blocking GPO](rdp-error-general-troubleshooting.md#modifying-a-blocking-gpo).

## After you update client computers, some users need to sign in twice

When users sign in to Remote Desktop using a computer running Windows 7 or Windows 10, version 1709, they immediately see a second sign-in prompt. This issue happens if the client computer has the following updates:

  - Windows 7: KB 4103718, [May 8, 2018—KB4103718 (Monthly Rollup)](https://support.microsoft.com/help/4103718/windows-7-update-kb4103718)
  - Windows 10 1709: KB 4103727, [May 8, 2018—KB4103727 (OS Build 16299.431)](https://support.microsoft.com/help/4103727/windows-10-update-kb4103727)

To resolve this issue, ensure that the computers that the users want to connect to (as well as RDSH or RDVI servers) are fully updated through June, 2018. This includes the following updates:

  - Windows Server 2016: KB 4284880, [June 12, 2018—KB4284880 (OS Build 14393.2312)](https://support.microsoft.com/help/4284880/windows-10-update-kb4284880)
  - Windows Server 2012 R2: KB 4284815, [June 12, 2018—KB4284815 (Monthly Rollup)](https://support.microsoft.com/help/4284815/windows-81-update-kb4284815)
  - Windows Server 2012: KB 4284855, [June 12, 2018—KB4284855 (Monthly Rollup)](https://support.microsoft.com/help/4284855/windows-server-2012-update-kb4284855)
  - Windows Server 2008 R2: KB 4284826, [June 12, 2018—KB4284826 (Monthly Rollup)](https://support.microsoft.com/help/4284826/windows-7-update-kb4284826)
  - Windows Server 2008 SP2: KB4056564, [Description of the security update for the CredSSP remote code execution vulnerability in Windows Server 2008, Windows Embedded POSReady 2009, and Windows Embedded Standard 2009: March 13, 2018](https://support.microsoft.com/help/4056564/security-update-for-vulnerabilities-in-windows-server-2008)

## Users are denied access on a deployment that uses Remote Credential Guard with multiple RD Connection Brokers

This issue occurs in high-availability deployments that use two or more Remote Desktop Connection Brokers, if Windows Defender Remote Credential Guard is in use. Users can't sign in to remote desktops.

This issue occurs because Remote Credential Guard uses Kerberos for authentication, and restricts NTLM. However, in a high-availability configuration with load balancing, the RD Connection Brokers can't support Kerberos operations.

If you need to use a high-availability configuration with load-balanced RD Connection Brokers, you can work around this issue by disabling Remote Credential Guard. For more information about how to manage Windows Defender Remote Credential Guard, see [Protect Remote Desktop credentials with Windows Defender Remote Credential Guard](https://docs.microsoft.com/windows/security/identity-protection/remote-credential-guard#enable-windows-defender-remote-credential-guard).
