---
title: SMB authentication rate limiter for Windows Server Insider builds
description: Learn about SMB authentication rate limiter for Windows Server Insider builds 
ms.topic: conceptual
author: gswashington
ms.author: nedpyle
ms.date: 02/14/2024

---

# SMB authentication rate limiter for Windows Server Insider builds

>Applies to: Windows Server Insider Builds

SMB authentication rate limited is a preview feature in Windows Server Insider builds designed to address attacks attemption authentication via SMB that leverage a known user name combined with scripts that bombard the SMB server with multiple password-guess attempts per second. 

It is a common practice for IT managers to enable access to the SMB server service even on machines that aren't dedicated file servers. Enabling access to the SMB server is done for legitimate reasons such as opening remote files or copying logs. But SMB access can also be leveraged by bad actors as a way to attempt authentication. Knowing a username, an attacker can send local or Active Directory Windows New Technology LAN Manager (NTLM) logons to a machine using common opensource tools. Password guess frequency can range from dozens to hundreds of logon attempts per second.

If your organization has no intrusion detection software or doesn't set a password lockout policy, an attacker can guess a user's password in days or even hours. Although the SMB server runs by default across all versions of Windows it's not accessible by default unless the firewall is disabled. An end user who turns off firewall and joins a device to an unsafe network faces a similar problem.

## How SMB authentication rate limiter works

The SMB authentication rate limiter is The SMB server service uses the authentication rate limiter to implement a 2-second delay between each failed NTLM or PKU2U-based authentication. This means if an attacker previously sent 300 brute force attempts per second from a client for 5 minutes (90,000 passwords), the same number of attempts would now take 50 hours or more. As with similar defense-in-depth technique, the purpose of SMB authentication rate limiter is to make a server as unattractive a target as possible.

The SMB authentication rate limiter setting features a time configuration variable and can be enabled or disabled manually in Powershell:

`Set-SmbServerConfiguration -InvalidAuthenticationDelayTimeInMs n` 

The variable is measured in milliseconds; it must be a multiple of 100 with an allowed range 0-10000.

>[!NOTE]
> Setting the variable to 0 disables SMB authentication rate limiter.

To see the current value, run:

`Get-SmbServerConfiguration`

SMB authentication rate limiter does not affect Kerberos. Kerberos authenticates before an application protocol like SMB connects. SMB authentication rate limiter is designed to be an additional layer of defense in depth, especially for devices not joined to domains.

## Related content

- [SMB Authentication Rate Limiter in Insider builds](https://techcommunity.microsoft.com/t5/storage-at-microsoft/smb-authentication-rate-limiter-in-insider-builds/ba-p/2829090)