---
title: Datagram Transport Layer Security protocol
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: security-tls-ssl
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 57b8873a-ad9c-4f2c-93e0-a2af352c6965
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 05/16/2018
---
# Datagram Transport Layer Security protocol

Windows Server (Semi-Annual Channel), Windows Server 2016, Windows 10

This reference topic for the IT professional describes the Datagram Transport Layer Security (DTLS) protocol, which is part of the Schannel Security Support Provider (SSP).

## <a name="BKMK_DTLS"></a>
Introduced in the Schannel SSP in Windows Server 2012 and Windows 8, the DTLS protocol provides communication privacy for datagram protocols. For information about which DTLS version is supported in Windows versions, see [Protocols in TLS/SSL (Schannel SSP)](https://msdn.microsoft.com/library/windows/desktop/mt808159(v=vs.85).aspx). The protocol allows client and server applications to communicate in a way that is designed to prevent eavesdropping, tampering, or message forgery. The DTLS protocol is based on the Transport Layer Security (TLS) protocol, and it provides equivalent security guarantees, reducing the need to use IPsec or designing a custom application layer security protocol.

Datagrams are common in streaming media, such as gaming or secured video conferencing. Developers can develop applications to use the DTLS protocol within the context of the Windows authentication Security Support Provider Interface (SSPI) model to secure the communication between clients and servers. The DTLS protocol is built on top of the User Datagram Protocol (UDP). DTLS is designed to be as similar to TLS as possible to minimize new security invention and to maximize the amount of code and infrastructure reuse.

The cipher suites that are available for configuration are patterned after those you can configure for TLS. RC4 is not permitted. Schannel continues to use Cryptography Next Generation (CNG). This takes advantage of FIPS 140 certification, which was introduced in Windows Vista.

## See also

[IETF RFC 4347 Datagram Transport Layer Security](http://tools.ietf.org/html/rfc4347)


