---
title: Store passwords using reversible encryption
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 096f74ee-4771-45ae-a177-a384cef7bfe9
---
# Store passwords using reversible encryption
This security policy reference topic for the IT professional describes the best practices, location, values, and security considerations for this policy setting.  
  
## Reference  
The **Store password using reversible encryption** policy setting provides support for applications that use protocols that require the user's password for authentication. Storing encrypted passwords in a way that is reversible means that the encrypted passwords can be decrypted. A knowledgeable attacker who is able to break this encryption can then log on to network resources by using the compromised account. For this reason, never enable **Store password using reversible encryption** for all users in the domain unless application requirements outweigh the need to protect password information.  
  
If you use the Challenge Handshake Authentication Protocol \(CHAP\) through remote access or Internet Authentication Services \(IAS\), you must enable this policy setting. CHAP is an authentication protocol that is used by remote access and network connections. Digest Authentication in Internet Information Services \(IIS\) also requires that you enable this policy setting.  
  
This policy setting is supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.  
  
### Possible values  
  
-   Enabled  
  
-   Disabled  
  
-   Not defined  
  
### Best practices  
Set the value for **Store password using reversible encryption**  to Disabled. If you use CHAP through remote access or IAS, or Digest Authentication in IIS, you must set this value to Enabled. This presents a security risk when you apply the setting by using Group Policy on a user\-by\-user basis because it requires opening the appropriate user account object in Active Directory Users and Computers.  
  
> [!NOTE]  
> Do not enable this policy setting unless business requirements outweigh the need to protect password information.  
  
### Location  
*GPO\_name***\\Computer Configuration\\Windows Settings\\Security Settings\\Account Policies\\Password Policy\\**  
  
### Default values  
The following table lists the actual and effective default policy values for the most recent supported versions of Windows. Default values are also listed on the policy’s property page.  
  
|Server type or Group Policy Object \(GPO\)|Default value|  
|----------------------------------------------|-----------------|  
|Default domain policy|Disabled|  
|Default domain controller policy|Disabled|  
|Stand\-alone server default settings|Disabled|  
|Domain controller effective default settings|Disabled|  
|Member server effective default settings|Disabled|  
|Effective GPO default settings on client computers|Disabled|  
  
### Operating system version differences  
There are no differences in the way this policy setting works between [supported versions of Windows](#BKMK_top).  
  
## Security considerations  
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.  
  
### Vulnerability  
Enabling this policy setting allows the operating system to store passwords in a format that can weaken your overall security.  
  
### Countermeasure  
Disable the **Store password using reversible encryption**  policy setting.  
  
### Potential impact  
If your organization uses CHAP through remote access or IAS, or Digest Authentication in IIS, you must configure this policy setting to Enabled. This presents a security risk when you apply the setting through Group Policy on a user\-by\-user basis because it requires the appropriate user account object to be opened in Active Directory Users and Computers.  
  
## See Also  
[Password Policy](Password-Policy.md)  
  

