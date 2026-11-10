---
title: Configure NDES for SID certificate requests in Windows Server
description: Learn how to configure Network Device Enrollment Service (NDES) to handle certificate requests that contain security identifier (SID) information.
author: robinharwood
ms.author: roharwoo
ms.topic: how-to
ms.date: 11/05/2026
---

# Configure NDES to handle certificate requests containing SID information

**Applies to:** Windows Server 2012 and later versions

By default, Network Device Enrollment Service (NDES) rejects certificate enrollment requests that contain security identifier (SID) information in either the Subject Alternative Name (SAN) extension or a separate SID extension, unless you configure a custom NDES policy module. This behavior is one of several changes introduced in the October 2026 Windows Server security updates to address [CVE-2026-69802](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2026-69802). These changes help prevent certificate-based impersonation attacks.

In this article, you learn how to configure NDES to allow certificate enrollment requests that contain SID information when a trusted component validates that information.

## Security considerations

During certificate-based authentication, the Kerberos Key Distribution Center (KDC) uses SID information in a certificate to establish a strong mapping between the certificate and the authenticating security principal.

An attacker who can supply arbitrary SID information in a certificate enrollment request might obtain a certificate associated with another security principal and impersonate that principal. NDES can't independently verify that the supplied SID belongs to the intended security principal.

You can use a custom NDES policy module to perform additional validation of certificate enrollment requests, including verifying that the supplied SID is associated with the intended security principal. For more information, see [Use a policy module with Network Device Enrollment Service](use-policy-module-with-network-device-enrollment-service.md).

If you validate SID information through a trusted mechanism other than a custom NDES policy module, administrators can use the registry settings described in the next section to allow these requests.

## Configure NDES to allow SID information in requests

> [!WARNING]
> When you enable these settings, NDES accepts requests that contain SID information without independently validating the supplied SID. Incorrect or insufficient validation might allow attackers to impersonate other security principals, potentially leading to elevation of privilege, including domain administrator privileges.
>
> Enable these settings only when a trusted component, such as a mobile device management (MDM) solution, validates the SID information by using a mechanism other than a custom policy module.

Registry path:

```text
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography\MSCEP\OverrideSecureSettings
```

| Value name | Type | Value | Description |
| --- | --- | --- | --- |
| `AllowSIDInSANURI` | `REG_DWORD` | `1` | Allows requests that contain SID information in the SAN URI. |
| `AllowSIDExtensionInRequest` | `REG_DWORD` | `1` | Allows requests that contain SID information in the NTDS CA security extension. |

Configure only the registry values that correspond to the SID format included in your certificate enrollment requests:

- **SID in a SAN URI:** Set `AllowSIDInSANURI` to `1`.
- **SID in the NTDS CA security extension:** Set `AllowSIDExtensionInRequest` to `1`.
- **Both formats:** Set both registry values to `1`.

To apply the registry changes, reset Internet Information Services (IIS) or restart the NDES server. To reset IIS, run the following command from an elevated command prompt:

```console
iisreset
```

## Event reference

When NDES rejects a certificate enrollment request that contains SID information, it logs one of the following events in the **Application** event log. The event depends on how the request includes the SID information.

### Event ID 59: Request contains a SID certificate extension

| Information | Details |
| --- | --- |
| Event log | Application |
| Event type | Error |
| Event source | Microsoft-Windows-NetworkDeviceEnrollmentService |
| Event ID | 59 |
| Event text | The Network Device Enrollment Service rejected a certificate request because it contained a security identifier (SID) certificate extension. The SID extension must not be present in SCEP requests when no custom policy module is registered to validate it. |

### Event ID 60: Request contains SID information in a SAN URI

| Information | Details |
| --- | --- |
| Event log | Application |
| Event type | Error |
| Event source | Microsoft-Windows-NetworkDeviceEnrollmentService |
| Event ID | 60 |
| Event text | The Network Device Enrollment Service rejected a certificate request because the Subject Alternative Name (SAN) extension contained a URI entry with a security identifier (SID). SID values must not be present in SCEP request SAN entries when no custom policy module is registered to validate them. |

## Related content

- [Use a policy module with Network Device Enrollment Service](use-policy-module-with-network-device-enrollment-service.md)
- [CVE-2026-69802](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2026-69802)
- [[MS-WCCE]: szOID_NTDS_CA_SECURITY_EXT](/openspecs/windows_protocols/ms-wcce/e563cff8-1af6-4e6f-a655-7571ca482e71) describes the NTDS CA security extension (OID `1.3.6.1.4.1.311.25.2`).
- [Preview of SAN URI for Certificate Strong Mapping for KB5014754](https://techcommunity.microsoft.com/blog/askds/preview-of-san-uri-for-certificate-strong-mapping-for-kb5014754/3789785) describes the SAN URI format `tag:microsoft.com,2022-09-14:sid:<SID>`.
