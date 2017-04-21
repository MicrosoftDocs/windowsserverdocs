---
title: bitsadmin setclientcertificatebyid
description: "Windows Commands topic for **bitsadmin setclientcertificatebyid** Specifies the identifier of the client certificate to use for client authentication in an HTTPS (SSL) request"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8585a7a1-7472-437b-b04a-a11925782a3a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# bitsadmin setclientcertificatebyid

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Specifies the identifier of the client certificate to use for client authentication in an HTTPS \(SSL\) request.

## Syntax

```
bitsadmin /SetClientCertificateByID <Job> <store_location> <store_name> hexa-decimal_cert_id>
```

## Parameters

|Parameter|Description|
|-------|--------|
|Job|The job's display name or GUID|
|Store\_location|Identifies the location of a system store to use for looking up the certificate. Possible values include:<br /><br />1 \(CURrenT\_USER\)<br /><br />2 \(LOCAL\_MACHINE\)<br /><br />3 \(CURrenT\_SERVICE\)<br /><br />4 \(SERVICES\)<br /><br />5 \(USERS\)<br /><br />6 \(CURrenT\_USER\_GROUP\_POLICY\)<br /><br />7 \(LOCAL\_MACHINE\_GROUP\_POLICY\)<br /><br />8 \(LOCAL\_MACHINE\_ENTERPRISE\)|
|Store\_name|The name of the certificate store. Possible values include:<br /><br />CA \(Certification Authority certificates\)<br /><br />MY \(Personal certificates\)<br /><br />ROOT \(Root certificates\)<br /><br />SPC \(Software Publisher Certificate\)|
|Hexadecimal\_cert\_id|A hexadecimal number representing the hash of the certificate|

## <a name="BKMK_examples"></a>Examples
The following example specifies the identifier of the client certificate to use for client authentication in an HTTPS \(SSL\) request for the job named *myJob*.

```
C:\>bitsadmin bitsadmin /SetClientCertificateByID myJob BG_CERT_STORE_LOCatION_CURrenT_USER MY A106B52356D3FBcd1853A41B619358BD 
```

## additional references
[Command-Line Syntax Key](command-line-syntax-key.md)


