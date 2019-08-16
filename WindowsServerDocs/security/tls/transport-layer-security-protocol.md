---
title: Transport Layer Security protocol
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-tls-ssl
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: de510bb0-a9f6-4bbe-8f8a-8dd7473bbae8
author: justinha
ms.author: justinha
manager: brianlic-msft
ms.date: 05/16/2018
---
# Transport Layer Security protocol

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows 10

This topic for the IT professional describes how the Transport Layer Security (TLS) protocol works and provides links to the IETF RFCs for TLS 1.0, TLS 1.1, and TLS 1.2.

The TLS (and SSL) protocols are located between the application protocol layer and the TCP/IP layer, where they can secure and send application data to the transport layer. Because the protocols work between the application layer and the transport layer, TLS and SSL can support multiple application layer protocols.

TLS and SSL assume that a connection-oriented transport, typically TCP, is in use. The protocol allows client and server applications to detect the following security risks:

-   Message tampering

-   Message interception

-   Message forgery

The TLS and SSL protocols can be divided into two layers. The first layer consists of the application protocol and the three handshaking protocols: the handshake protocol, the change cipher spec protocol, and the alert protocol. The second layer is the record protocol. The following image illustrates the various layers and their elements.

**TLS and SSL protocol layers**


The Schannel SSP implements the TLS and SSL protocols without modification. The SSL protocol is proprietary, but the Internet Engineering Task Force produces the public TLS specifications. For information about which TLS or SSL version is supported in Windows versions, see [Protocols in TLS/SSL (Schannel SSP)](https://msdn.microsoft.com/library/windows/desktop/mt808159(v=vs.85).aspx). The following table lists the specifications for each TLS version. Each specification contains information about:

-   The TLS Record Protocol

-   The TLS Handshaking Protocols:
    \- Change cipher spec protocol
    \- Alert protocol

-   Cryptographic Computations

-   Mandatory Cipher Suites

-   Application Data Protocol

[RFC 5246 - The Transport Layer Security (TLS) Protocol Version 1.2](http://tools.ietf.org/html/rfc5246)

[RFC 4346 - The Transport Layer Security (TLS) Protocol Version 1.1](http://tools.ietf.org/html/rfc4346)

[RFC 2246 - The TLS Protocol Version 1.0](http://tools.ietf.org/html/rfc2246)

## <a name="BKMK_SessionResumption"></a>TLS session resumption
Introduced in  Windows Server 2012 R2 , the Schannel SSP implemented the server-side portion of TLS session resumption. The client-side implementation of RFC 5077 was added in Windows 8.

Devices that connect TLS to servers frequently need to reconnect. TLS session resumption reduces the cost of establishing TLS connections because resumption involves an abbreviated TLS handshake. This facilitates more resumption attempts by allowing a group of TLS servers to resume each other's TLS sessions. This modification provides the following savings for any TLS client that supports RFC 5077, including Windows Phone and Windows RT devices:

-   Reduced resource usage on the server

-   Reduced bandwidth, which improves the efficiency of client connections

-   Reduced time spent for the TLS handshake due to resumptions of the connection

For information about stateless TLS session resumption, see the IETF document [RFC 5077.](http://www.ietf.org/rfc/rfc5077)

## <a name="BKMK_AppProtocolNego"></a>Application protocol negotiation
 Windows Server 2012 R2  and Windows 8.1 introduced support that allows client-side TLS application protocol negotiation. Applications can leverage protocols as part of the HTTP 2.0 standard development, and users can access online services such as Google and Twitter by using apps running the SPDY protocol.

For information about how application protocol negotiation works, see [Transport Layer Security (TLS) Application Layer Protocol Negotiation Extension](http://tools.ietf.org/search/draft-ietf-tls-applayerprotoneg-05).

## <a name="BKMK_SNI"></a>TLS support for Server Name Indication extensions
The Server Name Indication (SNI) feature extends the SSL and TLS protocols to allow proper identification of the server when numerous virtual images are running on a single server. In a virtual hosting scenario, several domains (each with its own potentially distinct certificate) are hosted on one server. In this case, the server has no way of knowing beforehand which certificate to send to the client. SNI allows the client to inform the target domain earlier in the protocol, and this allows the server to correctly select the proper certificate.

This additional functionality:

-   Allows you to host multiple SSL websites on a single Internet Protocol and port combination

-   Reduces the memory usage when multiple SSL websites are hosted on a single web server

-   Allows more users to connect to SSL websites simultaneously



