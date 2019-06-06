---
title:  TLS - SSL (Schannel SSP) Overview
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-tls-ssl
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c8836345-16bb-4dcc-8d2b-2b9b687456a3
author: justinha
ms.author: justinha
manager: brianlic-msft
ms.date: 05/16/2018
---
# Overview of TLS - SSL (Schannel SSP)

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows 10

This topic for the IT professional describes the changes in functionality in the Schannel Security Support Provider (SSP), which includes the Transport Layer Security (TLS), the Secure Sockets Layer (SSL), and the Datagram Transport Layer Security (DTLS) authentication protocols, for  Windows Server 2012 R2 ,  Windows Server 2012 , Windows 8.1, and Windows 8.

Schannel is a Security Support Provider (SSP) that implements the SSL, TLS and DTLS Internet standard authentication protocols. The Security Support Provider Interface (SSPI) is an API used by Windows systems to perform security-related functions including authentication. The SSPI functions as a common interface to several Security Support Providers (SSPs), including the Schannel SSP.

For more information about Microsoft's implementation of TLS and SSL in the Schannel SSP, see the [TLS/SSL Technical Reference (2003)](https://technet.microsoft.com/library/cc784149(v=ws.10).aspx).


## TLS/SSL (Schannel SSP) features
The following describes features of TLS in the Schannel SSP.

### TLS session resumption
The Transport Layer Security (TLS) protocol, a component of the Schannel Security Support Provider, is used to secure data that is sent between applications across an untrusted network. TLS/SSL can be used to authenticate servers and client computers, and also to encrypt messages between the authenticated parties.

Devices that connect TLS to servers frequently need to reconnect due to session expiration. Windows 8.1 and  Windows Server 2012 R2  now support RFC 5077 (TLS Session Resumption without Server-Side State). This modification provides Windows Phone and Windows RT devices with:

-   Reduced resource usage on the server

-   Reduced bandwidth, which improves the efficiency of client connections

-   Reduced time spent for the TLS handshake due to resumptions of the connection.

> [!NOTE]
> The client-side implementation of RFC 5077 was added in Windows 8.

For information about stateless TLS session resumption, see the IETF document [RFC 5077.](http://www.ietf.org/rfc/rfc5077)

### Application protocol negotiation
 Windows Server 2012 R2  and Windows 8.1 support client-side TLS application protocol negotiation so applications can leverage protocols as part of the HTTP 2.0 standard development and users can access online services such as Google and Twitter using apps running the SPDY protocol.

**How it works**

Client and server applications enable application protocol negotiation extension by supplying lists of supported application protocol IDs, in descending order of preference. The TLS client indicates that it supports application protocol negotiation by including the Application Layer Protocol Negotiation (ALPN) extension with a list of client-supported protocols in the ClientHello message.

When the TLS client makes the request to the server, the TLS server reads its supported protocol list for the most-preferred application protocol which the client also supports. If such a protocol is found, the server responds with the selected protocol ID and continues with the handshake as usual. If there is no common application protocol, the server sends a fatal handshake failure alert.

### <a name="BKMK_TrustedIssuers"></a>Management of trusted issuers for client authentication
When authentication of the client computer is required using SSL or TLS, the server can be configured to send a list of trusted certificate issuers. This list contains the set of certificate issuers which the server will trust and is a hint to the client computer as to which client certificate to select if there are multiple certificates present. In addition, the certificate chain the client computer sends to the server must be validated against the configured trusted issuers list.

Prior to Windows Server 2012 and Windows 8, applications or processes that used the Schannel SSP (including  HTTP.sys and IIS) could provide a list of the trusted issuers that they supported for Client Authentication through a Certificate Trust List (CTL).

In Windows Server 2012 and Windows 8, changes were made to the underlying authentication process so that:

-   CTL-based trusted issuer list management is no longer supported.

-   The behavior to send the Trusted Issuer List by default is off: Default value of the SendTrustedIssuerList registry key is now 0 (off by default) instead of 1.

-   Compatibility to previous versions of Windows operating systems is preserved.

**What value does this add?**

Beginning with  Windows Server 2012 , the use of the CTL has been replaced with a certificate store-based implementation. This allows for more familiar manageability through the existing certificate management commandlets of the PowerShell provider, as well as command line tools such as certutil.exe.

Although the maximum size of the trusted certification authorities list that the Schannel SSP supports (16 KB) remains the same as in  Windows Server 2008 R2 , in Windows Server 2012 there is a new dedicated certificate store for client authentication issuers so that unrelated certificates are not included in the message.

**How it works?**

In  Windows Server 2012 , the trusted issuers list is configured using certificate stores; one default global computer certificate store and one that is optional per site. The source of the list will be determined as follows:

-   If there is a specific credential store configured for the site, it will be used as the source

-   If no certificates exist in the application-defined store, then Schannel checks the **Client Authentication Issuers** store on the local computer and, if certificates are present, uses that store as the source. If no certificate is found in either store, the Trusted Roots store is checked.

-   If neither the global or local stores contain certificates, the Schannel provider will use the  **Trusted Root Certifictation Authorities** store as the source of trusted issuers list. (This is the behavior for  Windows Server 2008 R2 .)

If the  **Trusted Root Certifictation Authorities** store that was used contains a mix of Root (self-signed) and certification authority (CA) Issuer certificates, only the CA Issuer certificates will be sent to the server by default.

**How to configure Schannel to use the certificate store for Trusted Issuers**

The Schannel SSP architecture in Windows Server 2012 will by default use the stores as described above to manage the Trusted Issuers list. You can still use the existing certificate management commandlets of the PowerShell provider, as well as command line tools such as Certutil to manage certificates.

For information about managing certificates using the PowerShell provider, see [AD CS Administration Cmdlets in Windows](https://technet.microsoft.com/library/hh848365(v=wps.620).aspx).

For information about managing certificates using the certificate utility, see [certutil.exe](https://technet.microsoft.com/library/cc732443.aspx).

For information about what data, including the application-defined store, is defined for an Schannel credential, see [SCHANNEL_CRED structure (Windows)](https://msdn.microsoft.com/library/windows/desktop/aa379810(v=vs.85).aspx).

**Defaults for Trust Modes**

There are three Client Authentication Trust Modes supported by the Schannel provider. The trust mode controls how validation of the client's certificate chain is performed and is a system-wide setting controlled by the REG_DWORD "ClientAuthTrustMode" under HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\Schannel.

|Value|Trust Mode|Description|
|-----|-------|--------|
|0|Machine Trust (default)|Requires that the client certificate is issued by a certificate in the Trusted Issuers list.|
|1|Exclusive Root Trust|Requires that a client certificate chains to a root certificate contained in the caller-specified trusted issuer store. The certificate must also be issued by an issuer in the Trusted Issuers list|
|2|Exclusive CA Trust|Requires that a client certificate chain to either an intermediate CA certificate or root certificate in the caller-specified trusted issuer store.|

For information about authentication failures due to trusted issuers configuration issues, see Knowledge Base article [280256](https://support.microsoft.com/kb/2802568).

### <a name="BKMK_SNI"></a>TLS support for Server Name Indicator (SNI) Extensions
Server Name Indication feature extends the SSL and TLS protocols to allow proper identification of the server when numerous virtual images are running on a single server. To properly secure the communication between a client computer and a server, the client computer requests a digital certificate from the server. After the server responds to the request and sends the certificate, the client computer examines it, uses it to encrypt the communication, and proceeds with the normal request-response exchange. However, in a virtual hosting scenario, several domains, each with its own potentially distinct certificate, are hosted on one server. In this case, the server has no way of knowing beforehand which certificate to send to the client computer. SNI allows the client computer to inform the target domain earlier in the protocol, and this allows the server to correctly select the proper certificate.

**What value does this add?**

This additional functionality:

-   Allows you to host multiple SSL websites on a single IP and port combination

-   Reduces the memory usage when multiple SSL websites are hosted on a single web server

-   Allows more users to connect to my SSL websites simultaneously

-   Permits you to provide hints to end users through the computer interface for selecting the correct certificate during a client authentication process.

**How it works**

The Schannel SSP maintains an in-memory cache of client connection states permitted for clients. This allows client computers to reconnect quickly to the SSL server without subject to a full SSL handshake on subsequent visits.  This efficient use of certificate management permits more sites to be hosted on a single Windows Server 2012 compared to previous operating system versions.

Certificate selection by the end user has been enhanced by allowing you to construct a list of probable certificate issuer names that provide the end user with hints on which one to choose. This list is configurable using Group Policy.

### <a name="BKMK_DTLS"></a>Datagram Transport Layer Security (DTLS)
The DTLS version 1.0 protocol has been added to the Schannel Security Support Provider. The DTLS protocol provides communications privacy for datagram protocols. The protocol allows client/server applications to communicate in a way that is designed to prevent eavesdropping, tampering, or message forgery. The DTLS protocol is based on the Transport Layer Security (TLS) protocol and provides equivalent security guarantees, reducing the need to use IPsec or designing a custom application layer security protocol.

**What value does this add?**

Datagrams are common in streaming media, such as gaming or secured video conferencing. Adding the DTLS protocol to the Schannel provider gives you the ability to use the familiar Windows SSPI model in securing the communication between client computers and servers. DTLS is deliberately designed to be as similar to TLS as possible, both to minimize new security invention and to maximize the amount of code and infrastructure reuse.

**How it works**

Applications that use DTLS over UDP can use the SSPI model in Windows Server 2012 and Windows 8. Certain cipher suites are available for configuration, similar to how you can configure TLS. Schannel continues to use the CNG cryptographic provider which takes advantage of FIPS 140 certification, which was introduced in Windows Vista.

### <a name="BKMK_Deprecated"></a>Deprecated functionality
In the Schannel SSP for Windows Server 2012 and Windows 8, there are no deprecated features or functionality.

## See also
-   [Private Cloud Security Model - Wrapper Functionality](https://social.technet.microsoft.com/wiki/contents/articles/6756.private-cloud-security-model-wrapper-functionality.aspx)



