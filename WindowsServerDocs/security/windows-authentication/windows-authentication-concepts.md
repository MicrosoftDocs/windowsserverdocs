---
title: Windows Authentication Concepts
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: security-windows-auth
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 29d1db15-cae0-4e3d-9d8e-241ac206bb8b
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Windows Authentication Concepts

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

This reference overview topic describes the concepts on which Windows authentication is based.

Authentication is a process for verifying the identity of an object or person. When you authenticate an object, the goal is to verify that the object is genuine. When you authenticate a person, the goal is to verify that the person is not an imposter.

In a networking context, authentication is the act of proving identity to a network application or resource. Typically, identity is proven by a cryptographic operation that uses either a key only the user knows (as with public key cryptography) or a shared key. The server side of the authentication exchange compares the signed data with a known cryptographic key to validate the authentication attempt.

Storing the cryptographic keys in a secure central location makes the authentication process scalable and maintainable. Active Directory is the recommended and default technology for storing identity information, which include the cryptographic keys that are the user's credentials. Active Directory is required for default NTLM and Kerberos implementations.

Authentication techniques range from a simple logon to an operating system or a sign-in to a service or application, which identifies users based on something that only the user knows, such as a password, to more powerful security mechanisms that use something that the user has'such as tokens, public key certificates, pictures, or biological attributes. In a business environment, users might access multiple applications on many types of servers within a single location or across multiple locations. For these reasons, authentication must support environments for other platforms and for other Windows operating systems.

## Authentication and authorization: A travel analogy
A travel analogy can help explain how authentication works. A few preparatory tasks are usually necessary to begin the journey. The traveler must prove their true identity to their host authorities. This proof can be in the form of proof of citizenship, birth place, a personal voucher, photographs, or whatever is required by the law of the host country. The traveler's identity is validated by the issuance of a passport, which is analogous to a system account issued and administered by an organization--the security principal. The passport and the intended destination are based on a set of rules and regulations issued by the governmental authority.

**The journey**

When the traveler arrives at the international border, a border guard asks for credentials, and the traveler presents his or her passport. The process is two-fold:

-   The guard authenticates the passport by verifying that it was issued by a security authority that the local government trusts (trusts, at least, to issue passports) and by verifying that the passport has not been modified.

-   The guard authenticates the traveler by verifying that the face matches the face of the person pictured on the passport and that other required credentials are in good order.

If the passport proves to be valid and the traveler proves to be its owner, authentication is successful, and the traveler can be allowed access across the border.

Transitive trust between security authorities is the foundation of authentication; the type of authentication that takes place at an international border is based on trust. The local government does not know the traveler, but it trusts that the host government does. When the host government issued the passport, it did not know the traveler either. It trusted the agency that issued the birth certificate or other documentation. The agency that issued the birth certificate, in turn, trusted the physician who signed the certificate. The physician witnessed the traveler's birth and stamped the certificate with direct proof of the identity, in this case with the newborn's footprint. Trust that is transferred in this way, through trusted intermediaries, is transitive.

Transitive trust is the foundation for network security in Windows client/server architecture. A trust relationship flows throughout a set of domains, such as a domain tree, and forms a relationship between a domain and all domains that trust that domain. For example, if domain A has a transitive trust with domain B, and if domain B trusts domain C, then domain A trusts domain C.

There is a difference between authentication and authorization. With authentication, the system proves that you are who you say you are. With authorization, the system verifies that you have rights to do what you want to do. To take the border analogy to the next step, merely authenticating that the traveler is the proper owner of a valid passport does not necessarily authorize the traveler to enter a country. Residents of a particular country are allowed to enter another country by simply presenting a passport only in situations where the country being entered grants unlimited permission for all citizens of that particular country to enter.

Similarly, you can grant all users from a certain domain permissions to access a resource. Any user who belongs to that domain has access to the resource, just as Canada lets U.S. citizens enter Canada. However, U.S. citizens attempting to enter Brazil or India find that they cannot enter those countries merely by presenting a passport because both of those countries require visiting U.S. citizens to have a valid visa. Thus, authentication does not guarantee access to resources or authorization to use resources.

## Credentials
A passport and possibly associated visas are the accepted credentials for a traveler. However, those credentials might not let a traveler enter or access all resources within a country. For instance, additional credentials are required to attend a conference. In Windows, credentials can be managed to make it possible for account holders to access resources over the network without repeatedly having to supply their credentials. This type of access lets users be authenticated one time by the system to access all applications and data sources that they are authorized to use without entering another account identifier or password. The Windows platform capitalizes on the ability to use a single user identity (maintained by Active Directory) across the network by locally caching user credentials in the operating system's Local Security Authority (LSA). When a user logs on to the domain, Windows authentication packages transparently use the credentials to provide single sign-on when authenticating the credentials to network resources. For more information about credentials, see [Credentials Processes in Windows Authentication](credentials-processes-in-windows-authentication.md).

A form of multi-factor authentication for the traveler might be the requirement to carry and present multiple documents to authenticate his identity such as a passport and conference registration information. Windows implements this form or authentication through smart cards, virtual smart cards, and biometric technologies. 

## Security principals and accounts
In Windows, any user, service, group, or computer that can initiate action is a security principal. Security principals have accounts, which can be local to a computer or be domain-based. For example, Windows client domain-joined computers can participate in a network domain by communicating with a domain controller even when no human user is logged on. To initiate communications, the computer must have an active account in the domain. Before accepting communications from the computer, the local security authority on the domain controller authenticates the computer's identity, and then defines the computer's security context just as it would for a human security principal. This security context defines the identity and capabilities of a user or service on a particular computer or a user, service, group, or computer on a network. For example, it defines the resources, such as a file share or printer, that can be accessed and the actions, such as Read, Write, or Modify, that can be performed by a user, service, or computer on that resource. For more information, see [Security Principals](https://technet.microsoft.com/itpro/windows/keep-secure/security-principals).

An account is a means to identify a claimant--the human user or service--requesting access or resources. The traveler who holds the authentic passport possesses an account with the host country. Users, groups of users, objects, and services can all have individual accounts or share accounts. Accounts can be member of groups and can be assigned specific rights and permissions. Accounts can be restricted to the local computer, workgroup, network, or be assigned membership to a domain.

Built-in accounts and the security groups, of which they are members, are defined on each version of Windows. By using security groups, you can assign the same security permissions to many users who are successfully authenticated, which simplifies access administration. Rules for issuing passports might require that the traveler be assigned to certain groups, such as business, or tourist, or government. This process ensures consistent security permissions across all members of a group. By using security groups to assign permissions means that access control of resources remains constant and easy to manage and audit. By adding and removing users who require access from the appropriate security groups as needed, you can minimize the frequency of changes to access control lists (ACLs).

Standalone managed service accounts and virtual accounts were introduced in  Windows Server 2008 R2  and  Windows 7  to provide necessary applications, such as Microsoft Exchange Server and Internet Information Services (IIS), with the isolation of their own domain accounts, while eliminating the need for an administrator to manually administer the service principal name (SPN) and credentials for these accounts. Group managed service accounts were introduced in Windows Server 2012 and provides the same functionality within the domain but also extends that functionality over multiple servers. When connecting to a service hosted on a server farm, such as Network Load Balance, the authentication protocols supporting mutual authentication require that all instances of the services use the same principal.

For more information about accounts, see:

-   [Active Directory Accounts](https://technet.microsoft.com/itpro/windows/keep-secure/active-directory-accounts)

-   [Active Directory Security Groups](https://technet.microsoft.com/itpro/windows/keep-secure/active-directory-security-groups)

-   [Local Accounts](https://technet.microsoft.com/itpro/windows/keep-bastion.local-accounts)

-   [Microsoft Accounts](https://technet.microsoft.com/itpro/windows/keep-secure/microsoft-accounts)

-   [Service Accounts](https://technet.microsoft.com/itpro/windows/keep-secure/service-accounts)

-   [Special Identities](https://technet.microsoft.com/itpro/windows/keep-secure/special-identities)

## Delegated authentication
To use the travel analogy, countries might issue the same access to all members of an official governmental delegation, just as long as the delegates are well-known. This delegation lets one member act on the authority of another member. In Windows, delegated authentication occurs when a network service accepts an authentication request from a user and assumes the identity of that user in order to initiate a new connection to a second network service. To support delegated authentication, you must establish front-end or first-tier servers, such as web servers, that are responsible for handling client authentication requests and back-end or n-tier servers, such as large databases, that are responsible for storing information. You can delegate the right to set up delegated authentication to users in your organization to reduce the administrative load on your administrators.

By establishing a service or computer as trusted for delegation, you let that service or computer complete delegated authentication, receive a ticket for the user who is making the request, and then access information for that user. This model restricts data access on back-end servers just to those users or services that present credentials with the correct access control tokens. In addition, it allows for access auditing of those back-end resources. By requiring that all data be accessed by means of credentials that are delegated to the server for use on behalf of the client, you ensure that the server cannot be compromised and that you can gain access to sensitive information that is stored on other servers. Delegated authentication is useful for multitier applications that are designed to use single sign-on capabilities across multiple computers.

### Authentication in trust relationships between domains
Most organizations that have more than one domain have a legitimate need for users to access shared resources that are located in a different domain, just as the traveler is permitted travel to different regions in the country. Controlling this access requires that users in one domain can also be authenticated and authorized to use resources in another domain. To provide authentication and authorization capabilities between clients and servers in different domains, there must be a trust between the two domains. Trusts are the underlying technology by which secured Active Directory communications occur and are an integral security component of the Windows Server network architecture.

When a trust exists between two domains, the authentication mechanisms for each domain trust the authentications coming from the other domain. Trusts help provide for controlled access to shared resources in a resource domain--the trusting domain--by verifying that incoming authentication requests come from a trusted authority--the trusted domain. In this way, trusts act as bridges that let only validated authentication requests travel between domains.

How a specific trust passes authentication requests depends on how it is configured. Trust relationships can be one-way, by providing access from the trusted domain to resources in the trusting domain, or two-way, by providing access from each domain to resources in the other domain. Trusts are also either nontransitive, in which case trust exists only between the two trust partner domains, or transitive, in which case trust automatically extends to any other domains that either of the partners trusts.

For information about how a trust works, see [How Domain and Forest Trusts Work](https://technet.microsoft.com/library/cc773178(v=ws.10).aspx).

### Protocol transition
Protocol transition assists application designers by letting applications support different authentication mechanisms at the user authentication tier and by switching to the Kerberos protocol for security features, such as mutual authentication and constrained delegation, in the subsequent application tiers.

For more information about protocol transition, see [Kerberos Protocol Transition and Constrained Delegation](https://technet.microsoft.com/library/cc758097(v=ws.10).aspx).

### Constrained delegation
Constrained delegation gives administrators the ability to specify and enforce application trust boundaries by limiting the scope where application services can act on behalf of a user. You can specify particular services from which a computer that is trusted for delegation can request resources. The flexibility to constrain authorization rights for services helps improve application security design by reducing the opportunities for compromise by untrusted services.

For more information about constrained delegation, see [Kerberos Constrained Delegation Overview](../kerberos/kerberos-constrained-delegation-overview.md).

## See also
[Windows Logon and Authentication Technical Overview](https://technet.microsoft.com/library/dn269029.aspx)


