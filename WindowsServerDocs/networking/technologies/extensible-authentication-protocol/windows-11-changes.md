---
title: EAP - What's changed in Windows 11
description: This article presents information about the changes in Windows 11 for Extensible Authentication Protocol (EAP) settings.
author: samyun
ms.author: wscontent
ms.topic: conceptual
ms.date: 06/15/2023
---

# EAP - What's changed in Windows 11

> Applies to: Windows 11, Windows 10

Windows 11 supports WPA3-Enterprise, a Wi-Fi security standard that defines a set of requirements around server certificate validation for EAP authentication. Windows 11 also supports TLS 1.3 by default. This article details the changes in EAP behavior in Windows 11 due to these features.

## Updated server certificate validation behavior in Windows 11

In previous Windows releases, including Windows 10, the server certificate validation logic varied between EAP methods. In Windows 11 we have adjusted all EAP methods to behave in a consistent and predictable way, which is also consistent with the WPA3-Enterprise specification. This new behavior applies to any EAP authentication using the first party EAP methods that ship with Windows, including Wi-Fi, Ethernet, and VPN scenarios.

Windows will trust the server certificate if one of the following conditions are met:

- The server certificate thumbprint has been added to the profile.
  > [!NOTE]
  > If the user is connecting without a pre-configured profile or if user prompts for server validation are enabled in the profile, the thumbprint will automatically be added to the profile if the user accepts the server through the UI prompt.
- All of the following conditions are met:
  1. The server certificate chain is trusted by the machine or user.
      - This is based on the root certificate being present in the machine or user trusted root store, depending on the OneX [authMode](/windows/win32/nativewifi/onexschema-authmode-onex-element).
  1. The trusted root certificate thumbprint has been added to the profile.
  1. If server name validation is enabled (recommended), the name matches what is specified in the profile.
      - See [Server validation](network-access.md#server-validation) for more information about configuring server name validation in the profile.

### Potential issues upgrading from Windows 10 to Windows 11

In Windows 10, under certain circumstances, PEAP and EAP-TLS authentications could successfully validate the server based solely on the presence of the trusted root certificate in the Windows trusted root store. If you observe that an EAP authentication is consistently failing after upgrading to Windows 11, please check the WLAN, LAN or VPN profiles to ensure they adhere to the new requirements for the behavior described above.

In most cases, specifying the trusted root certificate thumbprint in the profile is enough to address the issue, assuming the root certificate is already present in the trusted root store.

Another thing to note is that server name matching is case sensitive in Windows 11 version 21H2 (build number 22000). This was adjusted back to be case in-sensitive in Windows 11 version 22H2 (build number 22621). If you are using server name validation, please ensure that the name specified in the profile matches the server name exactly or upgrade to Windows 11 version 22H2 or later.

## TLS 1.3

Windows 11 enabled TLS 1.3 by default systemwide, but the Windows EAP methods continued to use TLS 1.2. Windows 11 version 22H2 (build number 22621) updated these methods to use TLS 1.3 by default.

### Known issues with TLS 1.3 and Windows 11

- NPS does not support TLS 1.3 at this time.
- Some older versions of third-party RADIUS servers may incorrectly advertise TLS 1.3 support. If you are experiencing issues with authenticating EAP-TLS with TLS 1.3 with Windows 11 22H2, please ensure the RADIUS server is patched and up to date or has TLS 1.3 disabled.
- There is a known issue with PEAP session resumption tickets when using TLS 1.3. An upcoming Windows Update will address this issue.

## WPA3-Enterprise 192-bit mode

WPA3-Enterprise 192-bit mode is a special mode for WPA3-Enterprise that enforces certain high security requirements on the wireless connection to provide a minimum of 192-bits of security. These requirements align with the [Commercial National Security Algorithm (CNSA) Suite, CNSSP 15](https://www.cnss.gov/CNSS/issuances/Policies.cfm), which is a set of cryptographic algorithms that is approved to protect classified and top secret information by the United States National Security Agency (NSA). 192-bit mode can sometimes be refered to as "Suite B mode", which is a reference to the NSA Suite B Cryptography specification, which was replaced by CNSA in 2016.

The following table lists the algorithms required by the CNSA Suite.

| Algorithm | Description | Parameters |
| --- | --- | --- |
| Advanced Encryption Standard (AES) | Symmetric block cipher used for encryption | 256-bit key (AES-256) |
| Elliptic Curve Diffie-Hellman (ECDH) Key Exchange | Asymmetric algorithm used to establish a shared secret (key) | 384-bit prime modulus curve (P-384) |
| Elliptic Curve Digital Signature Algorithm (ECDSA) | Asymmetric algorithm used for digital signatures | 384-bit prime modulus curve (P-384) |
| Secure Hash Algorithm (SHA) | Cryptographic hash function | SHA-384 |
| Diffie-Hellman (DH) Key Exchange | Asymmetric algorithm used to establish a shared secret (key) | 3072-bit modulus |
| Rivest-Shamir-Adleman (RSA) | Asymmetric algorithm used for digital signatures or key-establishment | 3072-bit modulus |

Aligning with CNSA, WPA3-Enterprise 192-bit mode requires that EAP-TLS is used with the following cipher suites with restrictions:

- `TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384`
  - ECDHE and ECDSA using the 384-bit prime modulus curve P-384
- `TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384` / `TLS_DHE_RSA_AES_256_GCM_SHA384`
  - ECDHE using the 384-bit prime modulus curve P-384
  - RSA >= 3072-bit modulus

> [!NOTE]
> P-384 is also known as `secp384r1` or `nistp384`. Other elliptic curves, such as P-521 are not permitted.
>
> SHA-384 is in the SHA-2 family of hash functions. Other algorithms and variants, such as SHA-512 or SHA3-384, are not permitted.

Windows supports only the `TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384` and `TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384` cipher suites for WPA3-Enterprise 192-bit mode. The `TLS_DHE_RSA_AES_256_GCM_SHA384` cipher suite is not supported.

TLS 1.3 uses new simplified TLS suites, of which only `TLS_AES_256_GCM_SHA384` is compatible with WPA3-Enterprise 192-bit mode. As TLS 1.3 requires (EC)DHE and allows ECDSA or RSA certificates, along with the AES-256 AEAD and SHA384 hash, `TLS_AES_256_GCM_SHA384` is equivalent to `TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384` and `TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384`. However, [RFC 8446](https://www.rfc-editor.org/rfc/rfc8446) requires that TLS 1.3-compliant applications support P-256, which is forbidden by CNSA. Therefore, WPA3-Enterprise 192-bit mode cannot be fully compliant with TLS 1.3. However, there are no known interoperability issues with TLS 1.3 and WPA3-Enterprise 192-bit mode.

> [!CAUTION]
> Current versions of Windows 11 do not enforce all of these restrictions. A future version of Windows will enforce these restrictions. To prepare your enterprise network for this change, we suggest testing with [Windows Insider](/windows-insider/get-started) builds.

To configure a network for WPA3-Enterprise 192-bit mode, Windows requires EAP-TLS be used with a certificate that meeds to previous requirements.
