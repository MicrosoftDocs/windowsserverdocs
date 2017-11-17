---
title: TLS - SSL (Schannel SSP) Overview
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-tls-ssl
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1b7b0432-1bef-4912-8c9a-8989d47a4da9
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# TLS - SSL (Schannel SSP) Overview

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic for the IT professional introduces the TLS/SSL implementation in Windows using the Schannel Security Service Provider (SSP) by describing practical applications, changes in Microsoft's implementation, and software requirements, plus additional resources for Windows Server 2012 and Windows 8.

**Did you mean:**

-   [The Schannel security package](https://msdn.microsoft.com/library/ms678421.aspx)

-   [Secure Channel](https://msdn.microsoft.com/library/windows/desktop/aa380123.aspx)

-   [Transport Layer Security Protocol](https://msdn.microsoft.com/library/windows/desktop/aa380516.aspx)

## <a name="BKMK_OVER"></a>TLS\SSL \(Schannel\) description
Schannel is a Security Support Provider \(SSP\) that implements the Secure Sockets Layer \(SSL\) and Transport Layer Security \(TLS\) Internet standard authentication protocols.

The Security Support Provider Interface \(SSPI\) is an API used by Windows systems to perform security\-related functions including authentication. The SSPI functions as a common interface to several Security Support Providers \(SSPs\), including the Schannel SSP.

The Transport Layer Security \(TLS\) protocol versions 1.0, 1.1, and 1.2, Secure Sockets Layer \(SSL\) protocol, versions 2.0 and 3.0, Datagram Transport Layer Security \(DTLS\) version 1.0, and the Private Communications Transport \(PCT\) protocol are based on public key cryptography. The Security Channel \(Schannel\) authentication protocol suite provides these protocols. All Schannel protocols use a client\/server model.

## <a name="BKMK_APP"></a>Practical applications
One problem when you administer a network is securing data that is being sent between applications across an untrusted network. You can use TLS\SSL to authenticate servers and client computers and then use the protocol to encrypt messages between the authenticated parties.

For example, you can use TLS\SSL for:

-   SSL\-secured transactions with an e\-commerce website

-   Authenticated client access to an SSL\-secured website

-   Remote access

-   SQL access

-   E\-mail

## <a name="BKMK_SOFT"></a>Software requirements
The TLS\SSL protocol use a client\server model and are based on certificate authentication, which requires a Public Key Infrastructure.

## <a name="BKMK_INSTALL"></a>Server Manager information
There are no configuration steps necessary to implement TLS, SSL or Schannel.

