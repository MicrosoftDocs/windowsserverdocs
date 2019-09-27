---
title: bitsadmin setclientcertificatebyid
description: "Windows Commands topic for **bitsadmin setclientcertificatebyid** Specifies the identifier of the client certificate to use for client authentication in an HTTPS (SSL) request"
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8585a7a1-7472-437b-b04a-a11925782a3a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin setclientcertificatebyid



Specifies the identifier of the client certificate to use for client authentication in an HTTPS (SSL) request.

## Syntax

```
bitsadmin /SetClientCertificateByID <Job> <store_location> <store_name> hexa-decimal_cert_id>
```

## Parameters

|Parameter|Description|
|---------|-----------|
|Job|The job's display name or GUID|
|Store_location|Identifies the location of a system store to use for looking up the certificate. Possible values include:</br>1 (CURRENT_USER)</br>2 (LOCAL_MACHINE)</br>3 (CURRENT_SERVICE)</br>4 (SERVICES)</br>5 (USERS)</br>6 (CURRENT_USER_GROUP_POLICY)</br>7 (LOCAL_MACHINE_GROUP_POLICY)</br>8 (LOCAL_MACHINE_ENTERPRISE)|
|Store_name|The name of the certificate store. Possible values include:</br>CA (Certification Authority certificates)</br>MY (Personal certificates)</br>ROOT (Root certificates)</br>SPC (Software Publisher Certificate)|
|Hexadecimal_cert_id|A hexadecimal number representing the hash of the certificate|

## <a name="BKMK_examples"></a>Examples

The following example specifies the identifier of the client certificate to use for client authentication in an HTTPS (SSL) request for the job named *myJob*.
```
C:\>bitsadmin Bitsadmin /SetClientCertificateByID myJob BG_CERT_STORE_LOCATION_CURRENT_USER MY A106B52356D3FBCD1853A41B619358BD 
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)