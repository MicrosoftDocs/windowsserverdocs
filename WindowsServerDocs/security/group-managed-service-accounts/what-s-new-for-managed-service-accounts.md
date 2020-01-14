---
title: What's New for Managed Service Accounts
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2f2a8b6b-c152-4c40-b712-bfabff0e408b
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# What&#39;s New for Managed Service Accounts

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic for the IT professional describes the changes in functionality for Managed Service Accounts with the introduction of the group Managed Service Account (gMSA) in Windows Server 2012 and Windows 8.

The managed service account is designed to provide services and tasks such as Windows services and IIS application pools to share their own domain accounts, while eliminating the need for an administrator to manually administer passwords for these accounts. It is a managed domain account that provides automatic password management.

## <a name="versions"></a>What's new for Managed Service Accounts in Windows Server 2012 and Windows 8
The following describes what changes in functionality were made to MSA in Windows Server 2012 and Windows 8.

### Group Managed Service Accounts
When a domain account is configured for a server in a domain, the client computer can authenticate and connect to that service. Previously, only two account types have provided identity without requiring password management. But these account types have limitations:

-   Computer account is limited to one domain server and the passwords are managed by the computer

-   Managed Service Account is limited to one domain server and the passwords are managed by the computer.

These accounts cannot be shared across multiple systems. Therefore, you must regularly maintain the account for each service on each system to prevent unwanted password expiration.

**What value does this change add?**

The group Managed Service Account solves this problem because the account password is managed by Windows Server 2012 domain controllers and can be retrieved by multiple Windows Server 2012 systems. This minimizes the administrative overhead of a service account by allowing Windows to handle password management for these accounts.

**What works differently?**

On computers running Windows Server 2012 or Windows 8, a group MSA can be created and managed through the Service Control Manager so that numerous instances of the service, such as deployed over a server farm, can be managed from one server. Tools and utilities that you used to administer Managed Service Accounts, such as IIS Application Pool Manager, can be used with group Managed Service Accounts. Domain administrators can delegate service management to service administrators, who can manage the entire lifecycle of a Managed Service Account or the group Managed Service Account. Existing client computers will be able to authenticate to any such service without knowing which service instance they are authenticating to.

### <a name="interoperability"></a>Removed or deprecated functionality
For  Windows Server 2012 , the Windows PowerShell cmdlets default to managing the group Managed Service Accounts instead of the server Managed Service Accounts.

## See also

-   [Group Managed Service Accounts Overview](group-managed-service-accounts-overview.md)

-   [Active Directory Domain Services Overview](active-directory-domain-services-overview.md)

-   [Managed Service Accounts: Understanding, Implementing, Best Practices, and Troubleshooting](https://blogs.technet.com/b/askds/archive/20../managed-service-accounts-understanding-implementing-best-practices-and-troubleshooting.aspx)


