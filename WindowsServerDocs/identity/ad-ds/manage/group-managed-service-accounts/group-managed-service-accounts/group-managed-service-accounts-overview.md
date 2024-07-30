---
title: Group Managed Service Accounts Overview
description: Learn about the group Managed Service Account; specifically  practical applications, changes in Microsoft's implementation, and hardware and software requirements.
ms.topic: article
ms.assetid: cef0693c-f861-48a7-a1c0-8d1bc06143ce
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 08/04/2023
---
# Group Managed Service Accounts Overview

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

This article for IT professionals introduces the group Managed Service Account (gMSA) by describing practical applications, changes in Microsoft's implementation, and hardware and software requirements.

## Feature description

A standalone Managed Service Account (sMSA) is a managed domain account that provides automatic password management, simplified service principal name (SPN) management and the ability to delegate the management to other administrators. This type of managed service account (MSA) was introduced in Windows Server 2008 R2 and Windows 7.

The group Managed Service Account (gMSA) provides the same functionality within the domain and also extends that functionality over multiple servers. When you connect to a service hosted on a server farm, such as a Network Load Balanced solution, the authentication protocols supporting mutual authentication require all instances of the services to use the same principal. When you use a gMSA as a service principal, the Windows operating system manages the password for the account instead of relying on the administrator to manage the password.

The Microsoft Key Distribution Service (`kdssvc.dll`) lets you securely obtain the latest key or a specific key with a key identifier for an Active Directory account. The Key Distribution Service shares a secret that's used to create keys for the account. These keys periodically change. For a gMSA, the domain controller computes the password on the key that the Key Distribution Services provides, along with other attributes of the gMSA.  Member hosts can obtain the current and preceding password values by contacting a domain controller.

## Practical applications

gMSAs provide a single identity solution for services running on a server farm or on systems behind Network Load Balancer. By providing a gMSA solution, you can configure services for the new gMSA principal while Windows handles the password management.

When services or service administrators use a gMSA, they don't need to manage password synchronization between service instances. The gMSA supports hosts kept offline for an extended time period and manages member hosts for all instances of a service. You can deploy a server farm that supports a single identity that existing client computers can authenticate without having to know which service instance they're connecting to.

Failover clusters don't support gMSAs. However, services that run on top of the Cluster service can use a gMSA or a sMSA if they're a Windows service, an app pool, a scheduled task, or natively support gMSA or sMSA.

## Software requirements

In order to run the Windows PowerShell commands you need to administer gMSAs, you must have a 64-bit architecture.

A managed service account depends upon Kerberos supported encryption types. When a client computer authenticates to a server using Kerberos, the DC creates a Kerberos service ticket protected with encryption that both the DC and server support. The DC uses the account's *msDS-SupportedEncryptionTypes* attribute to determine what encryption the server supports. If there isn't an attribute, the DC treats the client computer like it doesn't support stronger encryption types. If you've configured the host to not support RC4, then authentication always fails. For this reason, you should always configure AES for MSAs.

> [!NOTE]
> As of Windows Server 2008 R2, DES is disabled by default. For more information about supported encryption types, see [Changes in Kerberos Authentication](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd560670(v=ws.10)).

gMSAs aren't applicable to Windows operating systems earlier than Windows Server 2012.

## Server Manager information

You don't need to do any extra configuration to implement MSA and gMSA using Server Manager or the `Install-WindowsFeature` cmdlet.

## Next steps

Here are some other resources you can read to learn more about Managed Service Accounts:

- [What's New for Managed Service Accounts](what-s-new-for-managed-service-accounts.md)
- [Managed Service Accounts Documentation for Windows 7 and Windows Server 2008 R2](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ff641731(v=ws.10))
- [Service Accounts Step-by-Step Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd548356(v=ws.10))
- [Managed Service Accounts in Active Directory](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd378925(v=ws.10))
- [Getting Started with Group Managed Service Accounts](getting-started-with-group-managed-service-accounts.md)
- [Managed Service Accounts in Active Directory Domain Services](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd378925(v=ws.10))
- [Managed Service Accounts: Understanding, Implementing, Best Practices, and Troubleshooting](/archive/blogs/askds/managed-service-accounts-understanding-implementing-best-practices-and-troubleshooting)
- [Active Directory Domain Services Overview](active-directory-domain-services-overview.md)
