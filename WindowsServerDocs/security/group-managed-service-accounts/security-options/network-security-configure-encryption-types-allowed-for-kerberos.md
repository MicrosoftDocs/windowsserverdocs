---
title: Network security - Configure encryption types allowed for Kerberos
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 28b55216-f123-46ac-b8c6-3e95a77d8327
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Network security: Configure encryption types allowed for Kerberos

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This security policy reference topic for the IT professional describes the best practices, location, values and security considerations for this policy setting.

## Reference
This policy setting allows you to set the encryption types that the Kerberos protocol is allowed to use. If it is not selected, the encryption type will not be allowed. This setting might affect compatibility with client computers or services and applications. Multiple selections are permitted.

The following table lists and explains the allowed encryption types.

|Encryption type|Description and version support|
|----------|------------------|
|DES_CBC_CRC|Data Encryption Standard with Cipher Block Chaining using the Cyclic Redundancy Check  function<br /><br />Supported in Windows 2000 Server, Windows XP, Windows Server 2003, Windows Vista, and Windows Server 2008. The Windows 7 and Windows Server 2008 R2 operating systems do not support DES by default.|
|DES_CBC_MD5|Data Encryption Standard with Cipher Block Chaining using the Message-Digest algorithm 5 checksum function<br /><br />Supported in Windows 2000 Server, Windows XP, Windows Server 2003, Windows Vista, and Windows Server 2008. The   Windows 7 and Windows Server 2008 R2 operating systems do not support DES by default.|
|RC4_HMAC_MD5|Rivest Cipher 4 with Hashed Message Authentication Code using the Message-Digest algorithm 5 checksum function<br /><br />Supported in Windows 2000 Server, Windows XP, Windows Server 2003, Windows Vista, Windows Server 2008, Windows 7, and Windows Server 2008 R2.|
|AES128_HMAC_SHA1|Advanced Encryption Standard in 128 bit cipher block with Hashed Message Authentication Code using the Secure Hash Algorithm (1).<br /><br />Not supported in Windows 2000 Server, Windows XP, or Windows Server 2003. Supported in Windows Vista, Windows Server 2008, Windows 7, and Windows Server 2008 R2.|
|AES256_HMAC_SHA1|Advanced Encryption Standard in 256 bit cipher block with Hashed Message Authentication Code using the Secure Hash Algorithm (1).<br /><br />Not supported in Windows 2000 Server, Windows XP, or Windows Server 2003. Supported in Windows Vista, Windows Server 2008, Windows 7, and Windows Server 2008 R2.|
|Future encryption types|Reserved by Microsoft for additional encryption types that might be implemented.|

### Possible values
The encryption type options include:

-   DES_CBC_CRC

-   DES_CBC_MD5

-   RC4_HMAC_MD5

-   AES128_HMAC_SHA1

-   AES256_HMAC_SHA1

-   Future encryption types

    As of the release of Windows 7 and Windows Server 2008 R2, this is reserved by Microsoft for additional encryption types that might be implemented.

### Best practices
You must analyze your environment to determine which encryption types will be supported and then select those that meet that evaluation.

### Location
*GPO_name***\Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options**

### Default values

|Server type or Group Policy Object (GPO)|Default value|
|-----------------------|---------|
|Default domain policy|Not defined|
|Default domain controller policy|Not defined|
|Stand-alone server default settings|Not defined|
|Domain controller effective default settings|None of these encryption types that are available in this policy are allowed.|
|Member server effective default settings|None of these encryption types that are available in this policy are allowed.|
|Effective GPO default settings on client computers|None of these encryption types that are available in this policy are allowed.|

### Operating system version differences
This policy was introduced in  Windows Server 2008 R2  and  Windows 7 , and it can be applied to Windows operating systems beginning with Windows 2000.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

### Vulnerability
 Windows Server 2008 R2  and  Windows 7  do not support the DES cryptographic suites because stronger ones are available. To enable Kerberos interoperability with non-Windows versions of the Kerberos protocol, these suites can be enabled. However, doing so might open attack vectors on computers running  Windows Server 2008 R2  and  Windows 7 . You can also disable DES for your computers running Windows Vista and Windows Server 2008.

### Countermeasure
Do not configure this policy. This will force the computers running  Windows Server 2008 R2  and  Windows 7  to use the AES or RC4 cryptographic suites.

### Potential impact
If you do not select any of the encryption types, computers running  Windows Server 2008 R2  and  Windows 7  might have Kerberos authentication failures when connecting with computers running non-Windows versions of the Kerberos protocol.

If you do select any encryption type, you will lower the effectiveness of encryption for Kerberos authentication but you will improve interoperability with computers running older versions of Windows.

Contemporary non-Windows implementations of the Kerberos protocol support RC4 and AES 128-bit and AES 256-bit encryption. Most implementations, including the MIT Kerberos protocol and the Windows Kerberos protocol, are deprecating DES encryption.


