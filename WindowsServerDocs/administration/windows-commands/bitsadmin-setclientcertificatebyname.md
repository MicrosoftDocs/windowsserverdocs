---
title: bitsadmin setclientcertificatebyname
description: Reference article for the bitsadmin setclientcertificatebyname command, which specifies the subject name of the client certificate to use for client authentication in an HTTPS (SSL) request.
ms.topic: reference
ms.assetid: f308a6d9-d0da-48be-ae41-eced14b3cccb
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin setclientcertificatebyname

Specifies the subject name of the client certificate to use for client authentication in an HTTPS (SSL) request.

## Syntax

```
bitsadmin /setclientcertificatebyname <job> <store_location> <store_name> <subject_name>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |
| store_location | Identifies the location of a system store to use for looking up the certificate. Possible values include:<ul><li>1 (CURRENT_USER)</li><li>2 (LOCAL_MACHINE)</li><li>3 (CURRENT_SERVICE)</li><li>4 (SERVICES)</li><li>5 (USERS)</li><li>6 (CURRENT_USER_GROUP_POLICY)</li><li>7 (LOCAL_MACHINE_GROUP_POLICY)</li><li>8 (LOCAL_MACHINE_ENTERPRISE)</li></ul> |
| store_name | The name of the certificate store. Possible values include:<ul><li>CA (Certification Authority certificates)</li><li>MY (Personal certificates)</li><li>ROOT (Root certificates)</li><li>SPC (Software Publisher Certificate)</li></ul> |
| subject_name | Name of the certificate. |

## Examples

To specify the name of the client certificate *myCertificate* to use for client authentication in an HTTPS (SSL) request for the job named *myDownloadJob*:

```
bitsadmin /setclientcertificatebyname myDownloadJob 1 MY myCertificate
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
