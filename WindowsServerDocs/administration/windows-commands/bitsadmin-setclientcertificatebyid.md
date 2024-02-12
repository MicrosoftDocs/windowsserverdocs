---
title: bitsadmin setclientcertificatebyid
description: Reference article for the bitsadmin setclientcertificatebyid command, which specifies the identifier of the client certificate to use for client authentication in an HTTPS (SSL) request
ms.topic: reference
ms.assetid: 8585a7a1-7472-437b-b04a-a11925782a3a
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin setclientcertificatebyid

Specifies the identifier of the client certificate to use for client authentication in an HTTPS (SSL) request.

## Syntax

```
bitsadmin /setclientcertificatebyid <job> <store_location> <store_name> <hexadecimal_cert_id>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |
| store_location | Identifies the location of a system store to use for looking up the certificate, including:<ul><li>CURRENT_USER</li><li>LOCAL_MACHINE</li><li>CURRENT_SERVICE</li><li>SERVICES</li><li>USERS</li><li>CURRENT_USER_GROUP_POLICY</li><li>LOCAL_MACHINE_GROUP_POLICY</li><li>LOCAL_MACHINE_ENTERPRISE.</li></ul> |
| store_name | The name of the certificate store, including:<ul><li>CA (Certification Authority certificates)</li><li>MY (Personal certificates)</li><li>ROOT (Root certificates)</li><li>SPC (Software Publisher Certificate).</li></ul> |
| hexadecimal_cert_id | A hexadecimal number representing the hash of the certificate. |

## Examples

To specify the identifier of the client certificate to use for client authentication in an HTTPS (SSL) request for the job named *myDownloadJob*:

```
bitsadmin /setclientcertificatebyid myDownloadJob BG_CERT_STORE_LOCATION_CURRENT_USER MY A106B52356D3FBCD1853A41B619358BD
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
