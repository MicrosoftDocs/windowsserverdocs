---
title: Service Accounts in Windows Server

description: Learn about sMSA, gMSA, dMSA, and virtual accounts in Windows Server Active Directory.
ms.topic: concept-article
author: robinharwood
ms.author: roharwoo
ms.date: 07/08/2025

---

# Service accounts

A service account is a user account that's created explicitly to provide a security context for services that are running on Windows Server operating systems. The security context determines the service's ability to access local and network resources. Windows operating systems rely on services to run various features. These services can be configured through the applications, the Services snap-in, or Task Manager, or by using Windows PowerShell.

This article contains information about the following types of service accounts:

- [Standalone Managed Service Accounts (sMSA)](#standalone-managed-service-accounts)
- [Group Managed Service Accounts (gMSA)](#group-managed-service-accounts)
- [Delegated Managed Service Accounts (dMSA)](#delegated-managed-service-accounts)
- [Virtual accounts](#virtual-accounts)

## Standalone Managed Service Accounts

Managed Service Accounts are designed to isolate domain accounts in crucial applications, such as Internet Information Services (IIS). They eliminate the need for an administrator to manually administer the service principal name (SPN) and credentials for the accounts.


One Managed Service Account can be used for services on a single computer. Managed Service Accounts can't be shared among multiple computers. They also can't be used in server clusters where a service is replicated on multiple cluster nodes. For this scenario, you must use a group Managed Service Account. For more information, see [Group Managed Service Accounts Overview](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831782(v=ws.11)).


In addition to the enhanced security that's provided by having individual accounts for critical services, there are four important administrative benefits associated with Managed Service Accounts:

- You can create a class of domain accounts that can be used to manage and maintain services on local computers.

- Unlike domain accounts in which administrators must manually reset passwords, the network passwords for these accounts are automatically reset.

- You don't have to complete complex SPN management tasks to use Managed Service Accounts.

- You can delegate administrative tasks for Managed Service Accounts to nonadmin accounts.

> [!NOTE]

> Managed service accounts apply only to the Windows operating systems that are listed in the **Applies to** section at the beginning of this article.


## Group Managed Service Accounts

Group Managed Service Accounts are an extension of standalone Managed Service Accounts. These accounts are managed domain accounts that provide automatic password management and simplified SPN management, including delegation of management to other administrators.

A group Managed Service Account provides the same functionality as a standalone Managed Service Account within the domain, but it extends that functionality over multiple servers. When you're connecting to a service that's hosted on a server farm, such as Network Load Balancing, the authentication protocols that support mutual authentication require all instances of the services to use the same principal. When group Managed Service Accounts are used as service principals, the Windows Server operating system manages the password for the account instead of relying on the administrator to manage the password.

 
The Microsoft Key Distribution Service (kdssvc.dll) provides the mechanism to securely obtain the latest key or a specific key with a key identifier for an Active Directory account. This service was introduced in Windows Server 2012, and it doesn't run on earlier versions of the Windows Server operating system. Kdssvc.dll shares a secret, which is used to create keys for the account. These keys are periodically changed. For a group managed service account, the domain controller (DC) computes the password on the key that's provided by kdssvc.dll, in addition to other attributes of the group managed service account.
 

## Delegated Managed Service Accounts

 
A new type of account called delegated Managed Service Account (dMSA) is introduced in Windows Server 2025. This account type enables you to transition from traditional service accounts to machine accounts that have managed and fully randomized keys, while also disabling the original service account passwords. Authentication for dMSA is linked to the device identity, which means that only specified machine identities mapped in AD can access the account. By using dMSA, you can prevent the common issue of credential harvesting via a compromised account that's associated with traditional service accounts.

You can create a dMSA as a standalone account or replace an existing standard service account with it. If an existing account is replaced by a dMSA, authentication via the old account's password is blocked. Instead, the request is redirected to the Local Security Authority (LSA) for authentication via the dMSA, which has access to the same resources as the previous account in AD. To learn more, see [Delegated Managed Service Accounts overview](/windows-server/security/delegated-managed-service-accounts/delegated-managed-service-accounts-overview).
 

## Virtual accounts

Virtual accounts are managed local accounts that simplify service administration by providing the following benefits:

- The virtual account is automatically managed.
- The virtual account can access the network in a domain environment.
- No password management is required. For example, if the default value is used for the service accounts during SQL Server setup on Windows Server, a virtual account that uses the instance name as the service name is established in the format `NT SERVICE\<SERVICENAME>`.

Services that run as virtual accounts access network resources by using the credentials of the computer account, in the format `<domain_name>\<computer_name>$`.

To learn how to configure and use virtual service accounts, see [Managed service account and virtual account concepts](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd548356(v=ws.10)#managed-service-account-and-virtual-account-concepts).

> [!NOTE]
> Virtual accounts apply only to the Windows operating systems that are listed in the **Applies to** list at the beginning of this article.

## Choosing your service account

 
Service accounts are used to control the service's access to local and network resources, and they help ensure that the service can operate safely and securely without exposing sensitive information or resources to unauthorized users. The following table describes the differences between service account types:
 

| Criterion | sMSA | gMSA | dMSA | Virtual accounts |
|-|:-:|:-:|:-:|:-:|
| App runs on a single server | Yes | Yes | Yes | Yes |
| App runs on multiple servers | No | Yes | Yes | No |
| App runs behind a load balancer | No | Yes | Yes | No |
| App runs on Windows Server | Yes | No | No | Yes |
| Requirement to restrict service account to single server | Yes | No | Yes | No |
| Supports machine account linked to device identity | No | No | Yes | No |
| Use for high-security scenarios (prevent credential harvesting) | No | No | Yes | No |

When choosing a service account, it's important to consider factors such as the level of access required by the service and the security policies in place on the server. You should also evaluate the specific needs of the application or service being run.

- **sMSA**: Designed for use on a single computer, sMSAs provide a secure and simplified method for managing SPNs and credentials. They automatically manage passwords and are ideal for isolating domain accounts in critical applications. However, they can't be used across multiple servers or in server clusters.

- **gMSA**: Extend the functionality of sMSAs by supporting multiple servers, making them suitable for server farms and load-balanced applications. They offer automatic password and SPN management, easing administrative burdens. gMSAs provide a single identity solution, allowing services to authenticate across multiple instances seamlessly.

- **dMSA**: Links authentication to specific machine identities, preventing unauthorized access through credential harvesting, allowing for the transition from traditional service accounts with fully randomized and managed keys. dMSAs can replace existing traditional service accounts, ensuring that only authorized devices can access sensitive resources.

- **Virtual accounts**: A managed local account that provides a simplified approach to service administration without the need for manual password management. They can access network resources by using the computer account's credentials, making them suitable for services that require domain access. Virtual accounts are automatically managed and require minimal configuration.

## Related content

| Content type  | References  |
|---------------|-------------|
| Product evaluation | [What's New for Managed Service Accounts](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831451(v=ws.11)) <br> [Get Started with Group Managed Service Accounts](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj128431(v=ws.11)) |
| Deployment | [Windows Server 2012: Group Managed Service Accounts - Tech Community](https://techcommunity.microsoft.com/t5/core-infrastructure-and-security/windows-server-2012-group-managed-service-accounts/ba-p/255910) |
| Related technologies | [Security principals](understand-security-principals.md) <br> [What's new in Windows Server 2016](/windows-server/identity/whats-new-active-directory-domain-services) |

