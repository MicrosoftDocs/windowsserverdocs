---
title: TLS (Schannel SSP)
ms.custom: na
ms.prod: windows-server
ms.topic: article
ms.assetid: ebd3c40c-b4c0-4f6d-a00c-f90eda4691df
manager: alanth
author: justinha
ms.technology: security-authentication
ms.date: 05/16/2018
---

# TLS (Schannel SSP) changes in Windows 10 and Windows Server 2016

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016 and Windows 10

## Cipher Suite Changes

Windows 10, version 1511 and Windows Server 2016 add support for configuration of cipher suite order using Mobile Device Management (MDM).

For cipher suite priority order changes, see [Cipher Suites in Schannel](https://msdn.microsoft.com/library/windows/desktop/aa374757.aspx).

Added support for the following cipher suites:

- TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (RFC 5289) in Windows 10, version 1507 and Windows Server 2016
- TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (RFC 5289) in Windows 10, version 1507 and Windows Server 2016

DisabledByDefault change for the following cipher suites:

- TLS_DHE_DSS_WITH_AES_256_CBC_SHA256 (RFC 5246) in Windows 10, version 1703
- TLS_DHE_DSS_WITH_AES_128_CBC_SHA256 (RFC 5246) in Windows 10, version 1703
- TLS_DHE_DSS_WITH_AES_256_CBC_SHA (RFC 5246) in Windows 10, version 1703
- TLS_DHE_DSS_WITH_AES_128_CBC_SHA (RFC 5246) in Windows 10, version 1703
- TLS_DHE_DSS_WITH_3DES_EDE_CBC_SHA (RFC 5246) in Windows 10, version 1703
- TLS_RSA_WITH_RC4_128_SHA in Windows 10, version 1709
- TLS_RSA_WITH_RC4_128_MD5 in Windows 10, version 1709

Starting with Windows 10, version 1507 and Windows Server 2016, SHA 512 certificates are supported by default.

### RSA key changes

Windows 10, version 1507 and Windows Server 2016 add registry configuration options for client RSA key sizes.

For more information, see [KeyExchangeAlgorithm - Client RSA key sizes](tls-registry-settings.md#keyexchangealgorithm---client-rsa-key-sizes).

### Diffie-Hellman key changes

Windows 10, version 1507 and Windows Server 2016 add registry configuration options for Diffie-Hellman key sizes.

For more information, see [KeyExchangeAlgorithm - Diffie-Hellman key sizes](tls-registry-settings.md#keyexchangealgorithm---diffie-hellman-key-sizes).

### SCH_USE_STRONG_CRYPTO option changes

With Windows 10, version 1507 and Windows Server 2016, [SCH_USE_STRONG_CRYPTO](https://msdn.microsoft.com/library/windows/desktop/aa379810.aspx) option now disables NULL, MD5, DES, and export ciphers.

## Elliptical Curve changes

Windows 10, version 1507 and Windows Server 2016 add Group Policy configuration for elliptical curves under Computer Configuration > Administrative Templates > Network > SSL Configuration Settings. 
The ECC Curve Order list specifies the order in which elliptical curves are preferred as well as enables supported curves which are not enabled. 
 
Added support for the following elliptical curves:

- BrainpoolP256r1 (RFC 7027) in Windows 10, version 1507 and Windows Server 2016
- BrainpoolP384r1 (RFC 7027) in Windows 10, version 1507 and Windows Server 2016 
- BrainpoolP512r1 (RFC 7027) in Windows 10, version 1507 and Windows Server 2016
- Curve25519 (RFC draft-ietf-tls-curve25519) in Windows 10, version 1607 and Windows Server 2016

## Dispatch level support for SealMessage & UnsealMessage

Windows 10, version 1507 and Windows Server 2016 add support for SealMessage/UnsealMessage at dispatch level.

## DTLS 1.2

Windows 10, version 1607 and Windows Server 2016 add support for DTLS 1.2 (RFC 6347).

## HTTP.SYS thread pool 

Windows 10, version 1607 and Windows Server 2016 add registry configuration of the size of the thread pool used to handle TLS handshakes for HTTP.SYS.

Registry path: 

HKLM\SYSTEM\CurrentControlSet\Control\LSA

To specify a maximum thread pool size per CPU core, create a **MaxAsyncWorkerThreadsPerCpu** entry. 
This entry does not exist in the registry by default. 
After you have created the entry, change the DWORD value to the desired size. 
If not configured, then the maximum is 2 threads per CPU core.

## Next Protocol Negotiation (NPN) support

Beginning with Windows 10 version 1703, Next Protocol Negotiation (NPN) has been removed and is no longer supported.

## Pre-Shared Key (PSK)

Windows 10, version 1607 and Windows Server 2016 add support for PSK key exchange algorithm (RFC 4279).

Added support for the following PSK cipher suites:

- TLS_PSK_WITH_AES_128_CBC_SHA256 (RFC 5487) in Windows 10, version 1607 and Windows Server 2016
- TLS_PSK_WITH_AES_256_CBC_SHA384(RFC 5487) in Windows 10, version 1607 and Windows Server 2016
- TLS_PSK_WITH_NULL_SHA256 (RFC 5487) in Windows 10, version 1607 and Windows Server 2016
- TLS_PSK_WITH_NULL_SHA384 (RFC 5487) in Windows 10, version 1607 and Windows Server 2016
- TLS_PSK_WITH_AES_128_GCM_SHA256 (RFC 5487) in Windows 10, version 1607 and Windows Server 2016
- TLS_PSK_WITH_AES_256_GCM_SHA384 (RFC 5487) in Windows 10, version 1607 and Windows Server 2016

## Session Resumption without Server-Side State server-side performance improvements

Windows 10, version 1507 and Windows Server 2016 provide 30% more session resumptions per second with session tickets compared to Windows Server 2012.

## Session Hash and Extended Master Secret Extension

Windows 10, version 1507 and Windows Server 2016 add support for RFC 7627: Transport Layer Security (TLS) Session Hash and Extended Master Secret Extension.

Due to this change, Windows 10 and Windows Server 2016 requires 3rd party [CNG SSL provider](https://msdn.microsoft.com/library/windows/desktop/ff468652.aspx) updates to support NCRYPT_SSL_INTERFACE_VERSION_3, and to describe this new interface.


## SSL support

Beginning with Windows 10, version 1607 and Windows Server 2016, the TLS client and server SSL 3.0 is disabled by default. 
This means that unless the application or service specifically requests SSL 3.0 via the SSPI, the client will never offer or accept SSL 3.0 and the server will never select SSL 3.0.

Beginning with Windows 10 version 1607 and Windows Server 2016, SSL 2.0 has been removed and is no longer supported.

## Changes to Windows TLS adherence to TLS 1.2 requirements for connections with non-compliant TLS clients

In TLS 1.2, the client uses the ["signature_algorithms" extension](https://tools.ietf.org/html/rfc5246#section-7.4.1.4.1) to indicate to the server which signature/hash algorithm pairs may be used in digital signatures (i.e., server certificates and server key exchange). 
The TLS 1.2 RFC also requires that the server Certificate message honor "signature_algorithms" extension:

"If the client provided a "signature_algorithms" extension, then all certificates provided by the server MUST be signed by a hash/signature algorithm pair that appears in that extension."

In practice, some third-party TLS clients do not comply with the TLS 1.2 RFC and fail to include all the signature and hash algorithm pairs they are willing to accept in the "signature_algorithms" extension, or omit the extension altogether (the latter indicates to the server that the client only supports SHA1 with RSA, DSA or ECDSA).

A TLS server often only has one certificate configured per endpoint, which means the server can't always supply a certificate that meets the client's requirements.

Prior to Windows 10 and Windows Server 2016, the Windows TLS stack strictly adhered to the TLS 1.2 RFC requirements, resulting in connection failures with RFC non-compliant TLS clients and interoperability issues. 
In Windows 10 and Windows Server 2016, the constraints are relaxed and the server can send a certificate that does not comply with TLS 1.2 RFC, if that's the server's only option. 
The client may then continue or terminate the handshake.

When validating server and client certificates, the Windows TLS stack strictly complies with the TLS 1.2 RFC and only allows the negotiated signature and hash algorithms in the server and client certificates.


