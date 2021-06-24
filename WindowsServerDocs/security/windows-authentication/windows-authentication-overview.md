---
title: Windows Authentication Overview
description: Learn about lists documentation resources for Windows authentication and logon technologies that include product evaluation, getting started guides, procedures, design and deployment guides, technical references, and command references.
ms.topic: article
ms.assetid: 485a0774-0785-457f-a964-0e9403c12bb1
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/12/2016
---
# Windows Authentication Overview

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

This navigation topic for the IT professional lists documentation resources for Windows authentication and logon technologies that include product evaluation, getting started guides, procedures, design and deployment guides, technical references, and command references.

## Feature description
Authentication is a process for verifying the identity of an object, service or person. When you authenticate an object, the goal is to verify that the object is genuine. When you authenticate a service or person, the goal is to verify that the credentials presented are authentic.

In a networking context, authentication is the act of proving identity to a network application or resource. Typically, identity is proven by a cryptographic operation that uses either a key only the user knows - as with public key cryptography - or a shared key. The server side of the authentication exchange compares the signed data with a known cryptographic key to validate the authentication attempt.

Storing the cryptographic keys in a secure central location makes the authentication process scalable and maintainable. Active Directory Domain Services is the recommended and default technology for storing identity information \(including the cryptographic keys that are the user's credentials\). Active Directory is required for default NTLM and Kerberos implementations.

Authentication techniques range from a simple logon, which identifies users based on something that only the user knows - like a password, to more powerful security mechanisms that use something that the user has - like tokens, public key certificates, and biometrics. In a business environment, services or users might access multiple applications or resources on many types of servers within a single location or across multiple locations. For these reasons, authentication must support environments for other platforms and for other Windows operating systems.

The Windows operating system implements a default set of authentication protocols, including Kerberos, NTLM, Transport Layer Security\/Secure Sockets Layer \(TLS\/SSL\), and Digest, as part of an extensible architecture. In addition, some protocols are combined into authentication packages such as Negotiate and the Credential Security Support Provider. These protocols and packages enable authentication of users, computers, and services; the authentication process, in turn, enables authorized users and services to access resources in a secure manner.

For more information about Windows Authentication including

-   [Windows Authentication Concepts](windows-authentication-concepts.md)

-   [Windows Logon Scenarios](windows-logon-scenarios.md)

-   [Windows Authentication Architecture](windows-authentication-architecture.md)

-   [Security Support Provider Interface Architecture](security-support-provider-interface-architecture.md)

-   [Credentials Processes in Windows Authentication](credentials-processes-in-windows-authentication.md)

-   [Group Policy Settings Used in Windows Authentication](group-policy-settings-used-in-windows-authentication.md)

see the [Windows Authentication Technical Overview](windows-authentication-technical-overview.md).

## Practical applications
Windows Authentication is used to verify that the information comes from a trusted source, whether from a person or computer object, such as another computer. Windows provides many different methods to achieve this goal as described below.

|To...|Feature|Description|
|----|------|--------|
|Authenticate within an Active Directory domain|Kerberos|The Microsoft Windows&nbsp;Server operating systems implement the Kerberos version 5 authentication protocol and extensions for public key authentication. The Kerberos authentication client is implemented as a security support provider \(SSP\) and can be accessed through the Security Support Provider Interface \(SSPI\). Initial user authentication is integrated with the Winlogon single sign\-on architecture. The Kerberos Key Distribution Center \(KDC\) is integrated with other Windows Server security services running on the domain controller. The KDC uses the domain's Active Directory directory service database as its security account database. Active Directory is required for default Kerberos implementations.<p>For additional resources, see [Kerberos Authentication Overview](../kerberos/kerberos-authentication-overview.md).|
|Secure authentication on the web|TLS\/SSL as implemented in the Schannel Security Support Provider|The Transport Layer Security \(TLS\) protocol versions 1.0, 1.1, and 1.2, Secure Sockets Layer \(SSL\) protocol, versions 2.0 and 3.0, Datagram Transport Layer Security protocol version 1.0, and the Private Communications Transport \(PCT\) protocol, version 1.0, are based on public key cryptography. The Secure Channel \(Schannel\) provider authentication protocol suite provides these protocols. All Schannel protocols use a client and server model.<p>For additional resources, see [TLS - SSL &#40;Schannel SSP&#41; Overview](../tls/tls-ssl-schannel-ssp-overview.md).|
|Authenticate to a web service or application|Integrated Windows Authentication<p>Digest Authentication|For additional resources, see [Integrated Windows Authentication](/previous-versions/windows/it-pro/windows-server-2003/cc758557(v=ws.10)) and [Digest Authentication](/previous-versions/windows/it-pro/windows-server-2003/cc738318(v=ws.10)), and [Advanced Digest Authentication](/previous-versions/windows/it-pro/windows-server-2003/cc783131(v=ws.10)).|
|Authenticate to legacy applications|NTLM|NTLM is a challenge\-response style authentication protocol.In addition to authentication, the NTLM protocol optionally provides for session security--specifically message integrity and confidentiality through signing and sealing functions in NTLM.<p>For additional resources, see [NTLM Overview](../kerberos/ntlm-overview.md).|
|Leverage multifactor authentication|Smart card support<p>Biometric support|Smart cards are a tamper\-resistant and portable way to provide security solutions for tasks such as client authentication, logging on to domains, code signing, and securing e\-mail.<p>Biometrics relies on measuring an unchanging physical characteristic of a person to uniquely identify that person. Fingerprints are one of the most frequently used biometric characteristics, with millions of fingerprint biometric devices that are embedded in personal computers and peripherals.<p>For additional resources, see [Smart Card Technical Reference](/windows/security/identity-protection/smart-cards/smart-card-windows-smart-card-technical-reference). |
|Provide local management, storage and reuse of credentials|Credentials management<p>Local Security Authority<p>Passwords|Credential  management in Windows ensures that credentials are stored securely. Credentials are collected on the Secure Desktop \(for local or domain access\), through apps or through websites so that the correct credentials are presented every time a resource is accessed.<p>
|Extend modern authentication protection to legacy systems|Extended Protection for Authentication|This feature enhances the protection and handling of credentials when authenticating network connections by using Integrated Windows Authentication \(IWA\).|

## Software requirements
Windows Authentication is designed to be compatible with previous versions of the Windows operating system. However, improvements with each release are not necessarily applicable to previous versions. Refer to documentation about specific features for more information.

## Server Manager information
Many authentication features can be configured using Group Policy, which can be installed using Server Manager. The Windows Biometric Framework feature is installed using Server Manager. Other server roles which are dependent upon authentication methods, such as Web Server \(IIS\) and Active Directory Domain Services, can also be installed using Server Manager.

## Related resources

|Authentication technologies|Resources|
|----------------|-------|
|Windows authentication|[Windows Authentication Technical Overview](../windows-authentication/windows-authentication-technical-overview.md)<br />Includes topics addressing differences between versions, general authentication concepts, logon scenarios, architectures for supported versions, and applicable settings.|
|Kerberos|[Kerberos Authentication Overview](../kerberos/kerberos-authentication-overview.md)<p>[Kerberos Constrained Delegation Overview](../kerberos/kerberos-constrained-delegation-overview.md)<p>[Kerberos Authentication Technical Reference](/previous-versions/windows/it-pro/windows-server-2003/cc739058(v=ws.10))\(2003\)<p>[Kerberos forum](/answers/topics/windows-server-security.html)|
|TLS\/SSL and DTLS \(Schannel security support provider\)|[TLS - SSL &#40;Schannel SSP&#41; Overview](../tls/tls-ssl-schannel-ssp-overview.md)<p>[Schannel Security Support Provider Technical Reference](../tls/schannel-security-support-provider-technical-reference.md)|
|Digest authentication|[Digest Authentication Technical Reference](/previous-versions/windows/it-pro/windows-server-2003/cc782794(v=ws.10))\(2003\)|
|NTLM|[NTLM Overview](../kerberos/ntlm-overview.md)<br />Contains links to current and past resources|
|PKU2U|[Introducing PKU2U in Windows](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd560634(v=ws.10))|
|Smart Card|[Smart Card Technical Reference](/windows/security/identity-protection/smart-cards/smart-card-windows-smart-card-technical-reference)<p>
|Credentials|[Credentials Protection and Management](../credentials-protection-and-management/credentials-protection-and-management.md)<br />Contains links to current and past resources<p>[Passwords Overview](../kerberos/passwords-overview.md)<br />Contains links to current and past resources|