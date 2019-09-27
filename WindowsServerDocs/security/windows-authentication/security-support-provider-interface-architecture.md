---
title: Security Support Provider Interface Architecture
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: security-windows-auth
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: de09e099-5711-48f8-adbd-e7b8093a0336
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Security Support Provider Interface Architecture

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

This reference topic for the IT professional describes the Windows authentication protocols that are used within the Security Support Provider Interface (SSPI) architecture.

The Microsoft Security Support Provider Interface (SSPI) is the foundation for Windows authentication. Applications and infrastructure services that require authentication use SSPI to provide it.

SSPI is the implementation of the Generic Security Service API (GSSAPI) in Windows Server operating systems. For more information about GSSAPI, see RFC 2743 and RFC 2744 in the IETF RFC Database.

The default Security Support Providers (SSPs) that invoke specific authentication protocols in Windows are incorporated into the SSPI as DLLs. These default SSPs are described in the following sections. Additional SSPs can be incorporated if they can operate with the SSPI.

As shown in the following image, the SSPI in Windows provides a mechanism that carries authentication tokens over the existing communication channel between the client computer and the server. When two computers or devices need to be authenticated so that they can communicate securely, the requests for authentication are routed to the SSPI, which completes the authentication process, regardless of the network protocol currently in use. The SSPI returns transparent binary large objects. These are passed between the applications, at which point they can be passed to the SSPI layer. Thus, the SSPI enables an application to use various security models available on a computer or network without changing the interface to the security system.

![Diagram showing the Security Support Provider Interface Architecture](../media/security-support-provider-interface-architecture/AuthN_SecuritySupportProviderInterfaceArchitecture.jpg)

The following sections describe the default SSPs that interact with the SSPI. The SSPs are used in different ways in Windows operating systems to promote secure communication in an unsecure network environment.

-   [Kerberos Security Support Provider](#BKMK_KerbSSP)

-   [NTLM Security Support Provider](#BKMK_NTLMSSP)

-   [Digest Security Support Provider](#BKMK_DigestSSP)

-   [Schannel Security Support Provider](#BKMK_SchannelSSP)

-   [Negotiate Security Support Provider](#BKMK_NegoSSP)

-   [Credential Security Support Provider](#BKMK_CredSSP)

-   [Negotiate Extensions Security Support Provider](#BKMK_NegoExtsSSP)

-   [PKU2U Security Support Provider](#BKMK_PKU2USSP)

Also included in this topic:

[Security Support Provider selection](security-support-provider-interface-architecture.md#BKMK_SecuritySupportProviderSelection)

### <a name="BKMK_KerbSSP"></a>Kerberos Security Support Provider
This SSP uses only the Kerberos version 5 protocol as implemented by Microsoft. This protocol is based on the Network Working Group's RFC 4120 and draft revisions. It is an industry standard protocol that is used with a password or a smart card for an interactive logon. It is also the preferred authentication method for services in Windows.

Because the Kerberos protocol has been the default authentication protocol since Windows 2000, all domain services support the Kerberos SSP. These services include:

-   Active Directory queries that use the Lightweight Directory Access Protocol (LDAP)

-   Remote server or workstation management that uses the Remote Procedure Call service

-   Print services

-   Client-server authentication

-   Remote file access that uses the Server Message Block (SMB) protocol (also known as Common Internet File System or CIFS)

-   Distributed file system management and referral

-   Intranet authentication to Internet Information Services (IIS)

-   Security authority authentication for Internet Protocol security (IPsec)

-   Certificate requests to Active Directory Certificate Services for domain users and computers

Location: %windir%\Windows\System32\kerberos.dll

This provider is included by default in versions designated in the **Applies to** list at the beginning of this topic, plus Windows Server 2003 and Windows XP.

**Additional resources for the Kerberos protocol and the Kerberos SSP**

-   [Microsoft Kerberos (Windows)](https://msdn.microsoft.com/library/aa378747(VS.85).aspx)

-   [\[MS-KILE\]: Kerberos Protocol Extensions](https://msdn.microsoft.com/library/cc233855(PROT.10).aspx)

-   [\[MS-SFU\]: Kerberos Protocol Extensions: Service for User and Constrained Delegation Protocol Specification](https://msdn.microsoft.com/library/cc246071(PROT.13).aspx)

-   [Kerberos SSP/AP (Windows)](https://msdn.microsoft.com/library/aa377942(VS.85).aspx)

-   [Kerberos Enhancements](https://technet.microsoft.com/library/cc749438(v=ws.10).aspx) for Windows Vista

-   [Changes in Kerberos Authentication](https://technet.microsoft.com/library/dd560670(v=ws.10).aspx) for  Windows 7 

-   [Kerberos Authentication Technical Reference](https://technet.microsoft.com/library/cc739058(v=ws.10).aspx)

### <a name="BKMK_NTLMSSP"></a>NTLM Security Support Provider
The NTLM Security Support Provider (NTLM SSP) is a binary messaging protocol used by the Security Support Provider Interface (SSPI) to allow NTLM challenge-response authentication and to negotiate integrity and confidentiality options. NTLM is used wherever SSPI authentication is used, including for Server Message Block or CIFS authentication, HTTP Negotiate authentication  (for example, Internet Web Authentication), and the Remote Procedure Call service. The NTLM SSP includes the NTLM and NTLM version 2 (NTLMv2) authentication protocols.

The supported Windows operating systems can use the NTLM SSP for the following:

-   Client/server authentication

-   Print services

-   File access by using CIFS (SMB)

-   Secure Remote Procedure Call service or DCOM service

Location: %windir%\Windows\System32\msv1_0.dll

This provider is included by default in versions designated in the **Applies to** list at the beginning of this topic, plus Windows Server 2003 and Windows XP.

**Additional resources for the NTLM protocol and the NTLM SSP**

-   [MSV1_0 Authentication Package (Windows)](https://msdn.microsoft.com/library/aa378753(VS.85).aspx)

-   [Changes in NTLM Authentication](https://technet.microsoft.com/library/dd566199(v=ws.10).aspx) in  Windows 7 

-   [Microsoft NTLM (Windows)](https://msdn.microsoft.com/library/aa378749(VS.85).aspx)

-   [Auditing and restricting NTLM usage guide](https://technet.microsoft.com/library/jj865674(v=ws.10).aspx)

### <a name="BKMK_DigestSSP"></a>Digest Security Support Provider
Digest authentication is an industry standard that is used for Lightweight Directory Access Protocol (LDAP) and web authentication. Digest authentication transmits credentials across the network as an MD5 hash or message digest.

Digest SSP (Wdigest.dll) is used for the following:

-   Internet Explorer and Internet Information Services (IIS) access

-   LDAP queries

Location: %windir%\Windows\System32\Digest.dll

This provider is included by default in versions designated in the **Applies to** list at the beginning of this topic, plus Windows Server 2003 and Windows XP.

**Additional resources for the Digest protocol and the Digest SSP**

-   [Microsoft Digest Authentication (Windows)](https://msdn.microsoft.com/library/aa378745(VS.85).aspx)

-   [\[MS-DPSP\]: Digest Protocol Extensions](https://msdn.microsoft.com/library/cc227906(PROT.13).aspx)

### <a name="BKMK_SchannelSSP"></a>Schannel Security Support Provider
The Secure Channel (Schannel) is used for web-based server authentication, such as when a user attempts to access a secure web server.

The TLS protocol, SSL protocol , the Private Communications Technology (PCT) protocol, and the Datagram Transport Layer (DTLS) protocol are based on public key cryptography. Schannel provides all these protocols. All Schannel protocols use a client/server model. The Schannel SSP uses public key certificates to authenticate parties. When authenticating parties, Schannel SSP selects a protocol in the following order of preference:

-   Transport Layer Security (TLS) version 1.0

-   Transport Layer Security (TLS) version 1.1

-   Transport Layer Security (TLS) version 1.2

-   Secure Socket Layer (SSL) version 2.0

-   Secure Socket Layer (SSL) version 3.0

-   Private Communications Technology (PCT)

    **Note** PCT is disabled by default.

The protocol that is selected is the preferred authentication protocol that the client and the server can support. For example, if a server supports all the Schannel protocols and the client supports only SSL 3.0 and SSL 2.0, the authentication process uses SSL 3.0.

DTLS is used when explicitly called by the application. For more information about DTLS and the other protocols that are used by the Schannel provider, see [Schannel Security Support Provider Technical Reference](../tls/schannel-security-support-provider-technical-reference.md).

Location: %windir%\Windows\System32\Schannel.dll

This provider is included by default in versions designated in the **Applies to** list at the beginning of this topic, plus Windows Server 2003 and Windows XP.

> [!NOTE]
> TLS 1.2 was introduced in this provider in Windows Server 2008 R2 and Windows 7. DTLS was introduced in this provider in Windows Server 2012 and Windows 8.

**Additional resources for the TLS and SSL protocols and the Schannel SSP**

-   [Secure Channel (Windows)](https://msdn.microsoft.com/library/aa380123(VS.85).aspx)

-   [TLS/SSL Technical Reference](https://technet.microsoft.com/library/cc784149(v=ws.10).aspx)

-   [\[MS-TLSP\]: Transport Layer Security (TLS) Profile](https://msdn.microsoft.com/library/dd207968(PROT.13).aspx)

### <a name="BKMK_NegoSSP"></a>Negotiate Security Support Provider
The Simple and Protected GSS-API Negotiation Mechanism (SPNEGO) forms the basis for the Negotiate SSP, whichcan be used to negotiate a specific authentication protocol. When an application calls into SSPI to log on to a network, it can specify an SSP to process the request. If the application specifies the Negotiate SSP, it analyzes the request and picks the appropriate provider to handle the request, based on customer-configured security policies.

SPNEGO is specified in RFC 2478.

In supported versions of the Windows operating systems, the Negotiate security support provider selects between the Kerberos protocol and NTLM. Negotiate selects the Kerberos protocol by default unless that protocol cannot be used by one of the systems involved in the authentication, or the calling application did not provide sufficient information to use the Kerberos protocol.

Location: %windir%\Windows\System32\lsasrv.dll

This provider is included by default in versions designated in the **Applies to** list at the beginning of this topic, plus Windows Server 2003 and Windows XP.

**Additional resources for the Negotiate SSP**

-   [Microsoft Negotiate (Windows)](https://msdn.microsoft.com/library/aa378748(VS.85).aspx)

-   [\[MS-SPNG\]: Simple and Protected GSS-API Negotiation Mechanism (SPNEGO)  Extensions](https://msdn.microsoft.com/library/cc247021(PROT.13).aspx)

-   [\[MS-N2HT\]: Negotiate and Nego2 HTTP Authentication Protocol Specification](https://msdn.microsoft.com/library/dd303576(PROT.13).aspx)

### <a name="BKMK_CredSSP"></a>Credential Security Support Provider
The Credential Security Service Provider (CredSSP) provides a single sign-on (SSO) user experience when starting new Terminal Services and Remote Desktop Services sessions. CredSSP enables applications to delegate users' credentials from the client computer (by using the client-side SSP) to the target server (through the server-side SSP), based on the client's policies. CredSSP policies are configured by using Group Policy, and the delegation of credentials is turned off by default.

Location: %windir%\Windows\System32\credssp.dll

This provider is included by default in versions designated in the **Applies to** list at the beginning of this topic.

**Additional resources for the Credentials SSP**

-   [\[MS-CSSP\]: Credential Security Support Provider (CredSSP) Protocol Specification](https://msdn.microsoft.com/library/cc226764(PROT.13).aspx)

-   [Credential Security Service Provider and SSO for Terminal Services Logon](https://technet.microsoft.com/library/cc749211(v=ws.10).aspx)

### <a name="BKMK_NegoExtsSSP"></a>Negotiate Extensions Security Support Provider
Negotiate Extensions (NegoExts) is an authentication package that negotiates the use of SSPs, other than NTLM or the Kerberos protocol, for applications and scenarios implemented by Microsoft and other software companies.

This extension to the Negotiate package permits the following scenarios:

-   **Rich client availability within a federated system.** Documents can be accessed on SharePoint sites, and they can be edited by using a full-featured Microsoft Office application.

-   **Rich client support for Microsoft Office services.** Users can sign in to Microsoft Office services and use a full-featured Microsoft Office application.

-   **Hosted Microsoft Exchange Server and Outlook.** There is no domain trust established because Exchange Server is hosted on the web. Outlook uses the Windows Live service to authenticate users.

-   **Rich client availability between client computers and servers.** The operating system's networking and authentication components are used.

The Windows Negotiate package treats the NegoExts SSP in the same manner as it does for Kerberos and NTLM. NegoExts.dll is loaded into the Local System Authority (LSA) at startup. When an authentication request is received, based on the request's source, NegoExts negotiates between the supported SSPs. It gathers the credentials and policies, encrypts them, and sends that information to the appropriate SSP, where the security token is created.

The SSPs supported by NegoExts are not stand-alone SSPs such as Kerberos and NTLM. Therefore, within the NegoExts SSP, when the authentication method fails for any reason, an authentication failure message will be displayed or logged. No renegotiation or fallback authentication methods are possible.

Location: %windir%\Windows\System32\negoexts.dll

This provider is included by default in versions designated in the **Applies to** list at the beginning of this topic, excluding Windows Server 2008 and Windows Vista.

### <a name="BKMK_PKU2USSP"></a>PKU2U Security Support Provider
The PKU2U protocol was introduced and implemented as an SSP in  Windows 7  and  Windows Server 2008 R2 . This SSP enables peer-to-peer authentication, particularly through the media and file sharing feature called HomeGroup, which was introduced in  Windows 7 . The feature permits sharing between computers that are not members of a domain.

Location: %windir%\Windows\System32\pku2u.dll

This provider is included by default in versions designated in the **Applies to** list at the beginning of this topic, excluding Windows Server 2008 and Windows Vista.

**Additional resources for the PKU2U protocol and the PKU2U SSP**

-   [Introducing Online Identity Integration](https://technet.microsoft.com/library/dd560662(v=ws.10).aspx)

## <a name="BKMK_SecuritySupportProviderSelection"></a>Security Support Provider selection
The Windows SSPI can use any of the protocols that are supported through the installed Security Support Providers. However, because not all operating systems support the same SSP packages as any given computer running Windows Server, clients and servers must negotiate to use a protocol that they both support. Windows Server prefers client computers and applications to use the Kerberos protocol, a strong standards-based protocol, when possible, but the operating system continues to allow client computers and client applications that do not support the Kerberos protocol to authenticate.

Before authentication can take place the two communicating computers must agree on a protocol that they both can support. For any protocol to be usable through the SSPI, each computer must have the appropriate SSP. For example, for a client computer and server to use the Kerberos authentication protocol, they must both support Kerberos v5. Windows Server uses the function **EnumerateSecurityPackages** to identify which SSPs are supported on a computer and what the capabilities of those SSPs are.

The selection of an authentication protocol can be handled in one of the following two ways:

1.  [Single authentication protocol](#BKMK_SingleAuth)

2.  [Negotiate option](#BKMK_Negotiate)

### <a name="BKMK_SingleAuth"></a>Single authentication protocol
When a single acceptable protocol is specified on the server, the client computer must support the protocol specified or the communication fails. When a single acceptable protocol is specified, the authentication exchange takes place as follows:

1.  The client computer requests access to a service.

2.  The server replies to the request and specifies the protocol that will be used.

3.  The client computer examines the contents of the reply and checks to determine whether it supports the specified protocol. If the client computer does support the specified protocol, the authentication continues. If the client computer does not support the protocol, the authentication fails, regardless of whether the client computer is authorized to access the resource.

### <a name="BKMK_Negotiate"></a>Negotiate option
The negotiate option can be used to allow the client and server to attempt to find an acceptable protocol. This is based on the Simple and Protected GSS-API Negotiation Mechanism (SPNEGO). When the authentication begins with the option to negotiate for an authentication protocol, the SPNEGO exchange takes place as follows:

1.  The client computer requests access to a service.

2.  The server replies with a list of authentication protocols that it can support and an authentication challenge or response, based on the protocol that is its first choice. For example, the server might list the Kerberos protocol and NTLM, and send a Kerberos authentication response.

3.  The client computer examines the contents of the reply and checks to determine whether it supports any of the specified protocols.

    -   If the client computer supports the preferred protocol, authentication proceeds.

    -   If the client computer does not support the preferred protocol, but it does support one of the other protocols listed by the server, the client computer lets the server know which authentication protocol it supports, and the authentication proceeds.

    -   If the client computer does not support any of the listed protocols, the authentication exchange fails.

## See also
[Windows Authentication Architecture](https://technet.microsoft.com/library/dn169024(v=ws.10).aspx)


