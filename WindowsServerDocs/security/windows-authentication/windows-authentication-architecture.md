---
title: Windows Authentication Architecture
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: security-windows-auth
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 07c9d6bb-9b03-407d-89b6-97c7551b256b
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Windows Authentication Architecture

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

This overview topic for the IT professional explains the basic architectural scheme for Windows authentication.

Authentication is the process by which the system validates a user's logon or sign-in information. A user's name and password are compared against an authorized list, and if the system detects a match, access is granted to the extent specified in the permission list for that user.

As part of an extensible architecture, the Windows Server operating systems implement a default set of authentication security support providers, which include Negotiate, the Kerberos protocol, NTLM, Schannel (secure channel), and Digest. The protocols used by these providers enable authentication of users, computers, and services, and the authentication process enables authorized users and services to access resources in a secure manner.

In Windows Server, applications authenticate users by using the SSPI to abstract calls for authentication. Thus, developers do not need to understand the complexities of specific authentication protocols or build authentication protocols into their applications.

Windows Server operating systems include a set of security components that make up the Windows security model. These components ensure that applications cannot gain access to resources without authentication and authorization. The following sections describe the elements of the authentication architecture.

### Local Security Authority
The Local Security Authority (LSA) is a protected subsystem that authenticates and signs in users to the local computer. In addition, LSA maintains information about all aspects of local security on a computer (these aspects are collectively known as the local security policy). It also provides various services for translation between names and security identifiers (SIDs).

The security subsystem keeps track of the security policies and the accounts that are on a computer system. In the case of a domain controller, these policies and accounts are those that are in effect for the domain in which the domain controller is located. These policies and accounts are stored in Active Directory. The LSA subsystem provides services for validating access to objects, checking user rights, and generating audit messages.

### Security Support Provider Interface
The Security Support Provider Interface (SSPI) is the API that obtains integrated security services for authentication, message integrity, message privacy, and security quality-of-service for any distributed application protocol.

SSPI is the implementation of the Generic Security Service API (GSSAPI). SSPI provides a mechanism by which a distributed application can call one of several security providers to obtain an authenticated connection without knowledge of the details of the security protocol.

## See also

-   [Security Support Provider Interface Architecture](security-support-provider-interface-architecture.md)

-   [Credentials Processes in Windows Authentication](credentials-processes-in-windows-authentication.md)

-   [Windows Authentication Technical Overview](https://technet.microsoft.com/library/dn169029.aspx)


