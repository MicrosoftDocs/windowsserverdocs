---
title: Windows Logon Scenarios
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: security-windows-auth
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 66b7c568-67b7-4ac9-a479-a5a3b8a66142
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Windows Logon Scenarios

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

This reference topic for the IT professional summarizes common Windows logon and sign-in scenarios.

The Windows operating systems require all users to log on to the computer with a valid account to access local and network resources. Windows-based computers secure resources by implementing the logon process, in which users are authenticated. After a user is authenticated, authorization and access control technologies implement the second phase of protecting resources: determining if the authenticated user is authorized to access a resource.

The contents of this topic apply to versions of Windows designated in the **Applies to** list at the beginning of this topic.

In addition, applications and services can require users to sign in to access those resources that are offered by the application or service. The sign-in process is similar to the logon process, in that a valid account and correct credentials are required, but logon information is stored in the Security Account Manager (SAM) database on the local computer and in Active Directory where applicable. Sign-in account and credential information is managed by the application or service, and optionally can be stored locally in Credential Locker.

To understand how authentication works, see [Windows Authentication Concepts](windows-authentication-concepts.md).

This topic describes the following scenarios:

-   [Interactive logon](#BKMK_InteractiveLogon)

-   [Network logon](#BKMK_NetworkLogon)

-   [Smart card logon](#BKMK_SmartCardLogon)

-   [Biometric logon](#BKMK_BioLogon)

## <a name="BKMK_InteractiveLogon"></a>Interactive logon
The logon process begins either when a user enters credentials in the credentials entry dialog box, or when the user inserts a smart card into the smart card reader, or when the user interacts with a biometric device. Users can perform an interactive logon by using a local user account or a domain account to log on to a computer.

The following diagram shows the interactive logon elements and logon process.

![Diagram showing the interactive logon elements and logon process](../media/windows-logon-scenarios/AuthN_LSA_Architecture_Client.gif)

**Windows Client Authentication Architecture**

### <a name="BKMK_LocaDomainLogon"></a>Local and domain logon
Credentials that the user presents for a domain logon contain all the elements necessary for a local logon, such as account name and password or certificate, and Active Directory domain information. The process confirms the user's identification to the security database on the user's local computer or to an Active Directory domain. This mandatory logon process cannot be turned off for users in a domain.

Users can perform an interactive logon to a computer in either of two ways:

-   Locally, when the user has direct physical access to the computer, or when the computer is part of a network of computers.

    A local logon grants a user permission to access Windows resources on the local computer. A local logon requires that the user has a user account in the Security Accounts Manager (SAM) on the local computer. The SAM protects and manages user and group information in the form of security accounts stored in the local computer registry. The computer can have network access, but it is not required. Local user account and group membership information is used to manage access to local resources.

    A network logon grants a user permission to access Windows resources on the local computer in addition to any resources on networked computers as defined by the credential's access token. Both a local logon and a network logon require that the user has a user account in the Security Accounts Manager (SAM) on the local computer. Local user account and group membership information is used to manage access to local resources, and the access token for the user defines what resources can be accessed on networked computers.

    A local logon and a network logon are not sufficient to grant the user and computer permission to access and to use domain resources.

-   Remotely, through Terminal Services or Remote Desktop Services (RDS), in which case the logon is further qualified as remote interactive.

After an interactive logon, Windows runs applications on behalf of the user, and the user can interact with those applications.

A local logon grants a user permission to access resources on the local computer or resources on networked computers. If the computer is joined to a domain, then the Winlogon functionality attempts to log on to that domain.

A domain logon grants a user permission to access local and domain resources. A domain logon requires that the user has a user account in Active Directory. The computer must have an account in the Active Directory domain and be physically connected to the network. Users must also have the user rights to log on to a local computer or a domain. Domain user account information and group membership information are used to manage access to domain and local resources.

### <a name="BKMK_RemoteLogon"></a>Remote logon
In Windows, accessing another computer through remote logon relies on the Remote Desktop Protocol (RDP). Because the user must already have successfully logged on to the client computer before attempting a remote connection, interactive logon processes have successfully finished.

RDP manages the credentials that the user enters by using the Remote Desktop Client. Those credentials are intended for the target computer, and the user must have an account on that target computer. In addition, the target computer must be configured to accept a remote connection. The target computer credentials are sent to attempt to perform the authentication process. If authentication is successful, the user is connected to local and network resources that are accessible by using the supplied credentials.

## <a name="BKMK_NetworkLogon"></a>Network logon
A network logon can only be used after user, service, or computer authentication has taken place. During network logon, the process does not use the credentials entry dialog boxes to collect data. Instead, previously established credentials or another method to collect credentials is used. This process confirms the user's identity to any network service that the user is attempting to access. This process is typically invisible to the user unless alternate credentials have to be provided.

To provide this type of authentication, the security system includes these authentication mechanisms:

-   Kerberos version 5 protocol

-   Public key certificates

-   Secure Sockets Layer/Transport Layer Security (SSL/TLS)

-   Digest

-   NTLM, for compatibility with Microsoft Windows NT 4.0-based systems

For information about the elements and processes, see the interactive logon diagram above.

## <a name="BKMK_SmartCardLogon"></a>Smart card logon
Smart cards can be used to log on only to domain accounts, not local accounts. Smart card authentication requires the use of the Kerberos authentication protocol. Introduced in Windows 2000 Server, in Windows-based operating systems a public key extension to the Kerberos protocol's initial authentication request is implemented. In contrast to shared secret key cryptography, public key cryptography is asymmetric, that is, two different keys are needed: one to encrypt, another to decrypt. Together, the keys that are required to perform both operations make up a private/public key pair.

To initiate a typical logon session, a user must prove his or her identity by providing information known only to the user and the underlying Kerberos protocol infrastructure. The secret information is a cryptographic shared key derived from the user's password. A shared secret key is symmetric, which means that the same key is used for both encryption and decryption.

The following diagram shows the elements and processes required for smart card logon.

![Diagram showing the elements and processes required for smart card logon](../media/windows-logon-scenarios/SmartCardCredArchitecture.gif)

**Smart Card credential provider architecture**

When a smart card is used instead of a password, a private/public key pair stored on the user's smart card is substituted for the shared secret key, which is derived from the user's password. The private key is stored only on the smart card. The public key can be made available to anyone with whom the owner wants to exchange confidential information.

For more information about the smart card logon process in Windows, see [How smart card sign-in works in Windows](https://technet.microsoft.com/library/ff404285.aspx).

## <a name="BKMK_BioLogon"></a>Biometric logon
A device is used to capture and build a digital characteristic of an artifact, such as a fingerprint. This digital representation is then compared to a sample of the same artifact, and when the two are successfully compared, authentication can occur. Computers running any of the operating systems designated in the **Applies to** list at the beginning of this topic can be configured to accept this form of logon. However, if biometric logon is only configured for local logon, the user needs to present domain credentials when accessing an Active Directory domain.

## Additional resources
For information about how Windows manages credentials submitted during the logon process, see [Credentials Management in Windows Authentication](https://technet.microsoft.com/library/dn169014.aspx).

[Windows Logon and Authentication Technical Overview](https://technet.microsoft.com/library/dn169029.aspx)


