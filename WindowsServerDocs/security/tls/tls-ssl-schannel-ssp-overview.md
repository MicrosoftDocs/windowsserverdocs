---
title: TLS/SSL overview (Schannel SSP)
description: Learn about the TLS and SSL implementations in Windows using the Schannel Security Service Provider (SSP).
ms.topic: concept-article
ms.date: 01/18/2024
---

# TLS/SSL overview (Schannel SSP)

This article is to introduce IT professionals to TLS and SSL implementations in Windows using the Schannel Security Service Provider (SSP) by describing practical applications, changes in Microsoft's implementation, software requirements, and other resources for Windows Server and client devices.

## Description

Schannel is a Security Support Provider (SSP) that implements the Secure Sockets Layer (SSL) and Transport Layer Security (TLS) Internet standard authentication protocols.

The Security Support Provider Interface (SSPI) is an API used by Windows systems to perform security-related functions including authentication. The SSPI functions as a common interface to several SSPs, including the Schannel SSP.

The Schannel authentication protocol suite provides several protocols that all use a client/server model. The following protocols are based on public key cryptography:

- TLS versions 1.0, 1.1, 1.2, and 1.3
- SSL versions 2.0 and 3.0
- Datagram Transport Layer Security (DTLS) versions 1.0 and 1.2
- Private Communications Transport (PCT)

> [!NOTE]
> TLS 1.0 and TLS 1.1 is being deprecated in Windows starting with Windows 11 September Insider Preview build and later releases. To learn more, see [TLS 1.0 and TLS 1.1 deprecation in Windows](/windows/win32/secauthn/tls-10-11-deprecation-in-windows).

## Applications

One problem when you administer a network is securing data that is being sent between applications across an untrusted network. You can use TLS and SSL to authenticate servers and client computers and then use the protocol to encrypt messages between the authenticated parties.

For example, you can use TLS/SSL for:

- SSL-secured transactions with an e-commerce website
- Authenticated client access to an SSL-secured website
- Remote access
- SQL access
- E-mail

## Requirements

TLS and SSL protocols use a client/server model and are based on certificate authentication, which requires a public key infrastructure.

## Server Manager information

There are no configuration steps necessary to implement TLS, SSL or Schannel.

## See also

- [The Schannel security package](/windows/desktop/com/schannel)
- [Secure Channel](/windows/desktop/SecAuthN/secure-channel)
- [Transport Layer Security Protocol](/windows/desktop/SecAuthN/transport-layer-security-protocol)
