---
title: System cryptography: Use FIPS compliant algorithms for encryption, hashing, and signing
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5655bdbd-e7f0-4554-a61f-a271933ea5d1
---
# System cryptography: Use FIPS compliant algorithms for encryption, hashing, and signing
This security policy reference topic for the IT professional describes the best practices, location, values, policy management and security considerations for this policy setting.  
  
## Reference  
The Federal Information Processing Standard \(FIPS\) 140 is a security implementation that is designed for certifying cryptographic software. Windows implements these certified algorithms to meet the requirements and standards for cryptographic modules for use by departments and agencies of the  HYPERLINK "http:\/\/en.wikipedia.org\/wiki\/United\_States" \\o "United States" United States federal government. For information about FIPS, see [FIPS General Information](http://www.nist.gov/itl/fipsinfo.cfm).  
  
**TLS\/SSL**  
  
This policy setting determines whether the TLS\/SSL security provider supports only the FIPS\-compliant strong cipher suite known as TLS\_RSA\_WITH\_3DES\_EDE\_CBC\_SHA, which means that the provider only supports the TLS protocol as a client computer and as a server, if applicable. It uses only the Triple Data Encryption Standard \(3DES\) encryption algorithm for the TLS traffic encryption, only the Rivest\-Shamir\-Adleman \(RSA\) public key algorithm for the TLS key exchange and authentication, and only the Secure Hash Algorithm version 1 \(SHA\-1\) hashing algorithm for the TLS hashing requirements.  
  
**Encrypting File System \(EFS\)**  
  
For the EFS service, this policy setting supports the 3DES and Advanced Encryption Standard \(AES\) encryption algorithms for encrypting file data supported by the NTFS file system. To encrypt file data, by default EFS uses the Advanced Encryption Standard \(AES\) algorithm with a 256\-bit key in the Windows Server 2003 and Windows Vista operating systems, and it uses a DESX algorithm in Windows XP.  
  
**Remote Desktop Services \(RDS\)**  
  
For encrypting Remote Desktop Services network communication, this policy setting supports only the Triple DES encryption algorithm.  
  
**BitLocker**  
  
For BitLocker, this policy setting needs to be enabled before any encryption key is generated.  
  
Recovery passwords created on [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] when this policy is enabled are incompatible with BitLocker on operating systems prior to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)]; BitLocker will prevent the creation or use of recovery passwords on these systems, so recovery keys should be used instead.  
  
### Possible values  
  
-   Enabled  
  
-   Disabled  
  
-   Not defined  
  
### Best practices  
  
1.  For use with TLS, set this policy to **Enabled**. Client computers with this policy setting enabled will be unable to communicate through digitally encrypted or signed protocols with servers that do not support these algorithms. Client computers that are connected to the network and do not support these algorithms cannot use servers that require the algorithms for network communications. If you enable this policy setting, you must also configure Internet Explorer to use TLS.  
  
### Location  
*GPO\_name*\\Computer Configuration\\Windows Settings\\Security Settings\\Local Policies\\Security Options  
  
### Default values  
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy’s property page.  
  
|Server type or GPO|Default value|  
|----------------------|-----------------|  
|Default Domain Policy|Not defined|  
|Default Domain Controller Policy|Not defined|  
|Stand\-Alone Server Default Settings|Disabled|  
|DC Effective Default Settings|Disabled|  
|Member Server Effective Default Settings|Disabled|  
|Client Computer Effective Default Settings|Disabled|  
  
### Operating system version differences  
When this setting is enabled, the Encrypting File System \(EFS\) service supports only the Triple DES encryption algorithm for encrypting file data. By default, the [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)] and the Windows Server 2003 implementation of EFS uses the Advanced Encryption Standard \(AES\) with a 256\-bit key. The Windows XP implementation uses DESX.  
  
When this setting is enabled, BitLocker generates recovery password or recovery keys applicable to versions listed in the following:  
  
|Operating systems|Applicability|  
|---------------------|-----------------|  
|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)]|When created on these operating systems, the recovery password cannot be used on other systems listed in this table.|  
|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)]|When created on these operating systems, the recovery key can be used on other systems listed in this table as well.|  
|[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)]|When created on these operating systems, the recovery key can be used on other systems listed in this table as well.|  
|[!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)]|When created on these operating systems, the recovery key can be used on other systems listed in this table as well.|  
  
## Policy management  
This section describes features and tools that are available to help you manage this policy.  
  
### Restart requirement  
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.  
  
### Group Policy  
  
> [!NOTE]  
> This setting is configured differently than in Windows Server 2003 and Windows XP in computers that are running at least [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)] or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].  
  
## Security considerations  
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.  
  
### Vulnerability  
You can enable this policy setting to ensure that the computer uses the most powerful algorithms that are available for digital encryption, hashing, and signing. Use of these algorithms minimize the risk of compromise of digitally encrypted or signed data by an unauthorized user.  
  
### Countermeasure  
Enable the **System cryptography: Use FIPS compliant algorithms for encryption, hashing, and signing** setting.  
  
### Potential impact  
Client computers that have this policy setting enabled cannot communicate by means of digitally encrypted or signed protocols with servers that do not support these algorithms. Network clients that do not support these algorithms cannot use servers that require them for network communications. For example, many Apache\-based Web servers are not configured to support TLS. If you enable this setting, you must also configure Internet Explorer® to use TLS. This policy setting also affects the encryption level that is used for the Remote Desktop Protocol \(RDP\). The Remote Desktop Connection tool uses the RDP protocol to communicate with servers that run Terminal Services and client computers that are configured for remote control; RDP connections fail if both computers are not configured to use the same encryption algorithms.  
  
##### To enable Internet Explorer to use TLS  
  
1.  On the Internet Explorer **Tools** menu, click **Internet Options**.  
  
2.  Click the **Advanced** tab.  
  
3.  Select the appropriate version for the **Use TLS** check box.  
  
You can also configure this policy setting through Group Policy or by using the Internet Explorer Administrators Kit.  
  
