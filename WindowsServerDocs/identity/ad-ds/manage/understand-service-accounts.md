---
title: Service Accounts
description: Windows Server standalone and group-managed service accounts in Active Directory
author: dansimp
ms.author: dansimp
ms.topic: article
ms.date: 07/21/2022
---

# Service accounts

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

A service account is a user account that's created explicitly to provide a security context for services that are running on Windows Server operating systems. The security context determines the service's ability to access local and network resources. Windows operating systems rely on services to run various features. These services can be configured through the applications, the Services snap-in, or Task Manager, or by using Windows PowerShell.

This article contains information about the following types of service accounts:

- [Standalone managed service accounts](#standalone-managed-service-accounts)
- [Group-managed service accounts](#group-managed-service-accounts)
- [Virtual accounts](#virtual-accounts)

## Standalone managed service accounts

Managed service accounts are designed to isolate domain accounts in crucial applications, such as Internet Information Services (IIS). They eliminate the need for an administrator to manually administer the service principal name (SPN) and credentials for the accounts.

To use managed service accounts, the server on which the application or service is installed must be running Windows Server 2008 R2 or later. One managed service account can be used for services on a single computer. Managed service accounts can't be shared between multiple computers, and they can't be used in server clusters where a service is replicated on multiple cluster nodes. For this scenario, you must use a group-managed service account. For more information, see [Group-managed service accounts overview](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831782(v=ws.11)).

In addition to the enhanced security that's provided by having individual accounts for critical services, there are four important administrative benefits associated with managed service accounts:

- You can create a class of domain accounts that can be used to manage and maintain services on local computers.

- Unlike domain accounts in which administrators must manually reset passwords, the network passwords for these accounts are automatically reset.

- You don't have to complete complex SPN management tasks to use managed service accounts.

- You can delegate administrative tasks for managed service accounts to non-administrators.

> [!NOTE]
> Managed service accounts apply only to the Windows operating systems that are listed in "Applies to" at the beginning of this article.

## Group-managed service accounts

Group-managed service accounts are an extension of standalone managed service accounts, which were introduced in Windows Server 2008 R2. These accounts are managed domain accounts that provide automatic password management and simplified SPN management, including delegation of management to other administrators.

A group-managed service account provides the same functionality as a standalone managed service account within the domain, but it extends that functionality over multiple servers. When you're connecting to a service that's hosted on a server farm, such as Network Load Balancing, the authentication protocols that support mutual authentication require all instances of the services to use the same principal. When group-managed service accounts are used as service principals, the Windows Server operating system manages the password for the account instead of relying on the administrator to manage the password.

The Microsoft Key Distribution Service (kdssvc.dll) provides the mechanism to securely obtain the latest key or a specific key with a key identifier for an Active Directory account. This service was introduced in Windows Server 2012, and it doesn't run on earlier versions of the Windows Server operating system. The Key Distribution Service shares a secret, which is used to create keys for the account. These keys are periodically changed. For a group-managed service account, the domain controller computes the password on the key that's provided by the Key Distribution Service, in addition to other attributes of the group-managed service account.

### Group-managed practical applications

Group-managed service accounts provide a single identity solution for services that are running on a server farm, or on systems that use Network Load Balancing. By providing a group-managed service account solution, services can be configured for the group-managed service account principal, and the password management is handled by the operating system.

By using a group-managed service account, service administrators don't need to manage password synchronization between service instances. The group-managed service account supports hosts that are kept offline for an extended time period and the management of member hosts for all instances of a service. This provision means that you can deploy a server farm that supports a single identity to which existing client computers can authenticate without knowing the instance of the service to which they're connecting.

Failover clusters don't support group-managed service accounts. However, services that run on top of the Cluster service can use a group-managed service account or a standalone managed service account if they're a Windows service, an App pool, or a scheduled task, or if they natively support group-managed service accounts or standalone managed service accounts.

### Group-managed software requirements

Group-managed service accounts can be configured and administered only on computers that are running Windows Server 2012 or later. But the accounts can be deployed as a single service identity solution in domains that still have domain controllers that are running operating systems earlier than Windows Server 2012. There are no domain or forest functional level requirements.

A 64-bit architecture is required to run the Windows PowerShell commands that are used to administer group-managed service accounts.

A managed service account is dependent on encryption types that are supported by Kerberos. When a client computer authenticates to a server by using the Kerberos protocol, the domain controller creates a Kerberos service ticket that's protected with encryption that the domain controller and the server support. The domain controller uses the account’s *msDS-SupportedEncryptionTypes* attribute to determine what encryption the server supports. If there is no attribute, it assumes that the client computer doesn't support stronger encryption types. The Advanced Encryption Standard (AES) must always be configured for managed service accounts. If computers that host the managed service account are configured to *not* support RC4, authentication will always fail.

> [!NOTE]
> Introduced in Windows Server 2008 R2, the Data Encryption Standard (DES) is disabled by default. Group-managed service accounts aren't applicable in Windows operating systems earlier than Windows Server 2012.

For more information about supported encryption types, see [Changes in Kerberos Authentication](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd560670(v=ws.10)).

## Virtual accounts

Virtual accounts were introduced in Windows Server 2008 R2 and Windows 7. They are managed local accounts that simplify service administration by providing the following benefits:

- The virtual account is automatically managed.
- The virtual account can access the network in a domain environment.
- No password management is required. For example, if the default value is used for the service accounts during SQL Server setup on Windows Server 2008 R2, a virtual account that uses the instance name as the service name is established in the format NT SERVICE\\\<SERVICENAME>.

Services that run as virtual accounts access network resources by using the credentials of the computer account in the format \<domain\_name>\\\<computer\_name>$.

To learn how to configure and use virtual service accounts, see [Service accounts step-by-step guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd548356(v=ws.10)).

> [!NOTE]
> Virtual accounts apply only to the Windows operating systems that are listed in "Applies to" at the beginning of this article.

## See also

For other resources that are related to standalone managed service accounts, group-managed service accounts, and virtual accounts, see:

| Content type  | References  |
|---------------|-------------|
| Product evaluation| [What's new for managed service accounts](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831451(v=ws.11))<br>[Get started with group-managed service accounts](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj128431(v=ws.11)) |
| Deployment | [Windows Server 2012: Group-managed service accounts - Ask Premier Field Engineering (PFE) Platforms - Site Home - TechNet Blogs](https://blogs.technet.com/b/askpfeplat/archive/2012/12/17/windows-server-2012-group-managed-service-accounts.aspx) |
| Related technologies | [Security principals](understand-security-principals.md)<br>[What's new in Active Directory Domain Services](/windows-server/identity/whats-new-active-directory-domain-services) |
