---
title: Network security: LAN Manager authentication level
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5e578bc8-3669-4e57-b234-970333e7d1e1
---
# Network security: LAN Manager authentication level
This security policy reference topic for the IT professional describes the best practices, location, values, policy management and security considerations for this policy setting. This information applies to computers running at least the Windows Server 2008 operating system.  
  
## Reference  
This policy setting determines which challenge or response authentication protocol is used for network logons. LAN Manager \(LM\) includes client computer and server software from Microsoft that allows users to link personal computers together on a single network. Network capabilities include transparent file and print sharing, user security features, and network administration tools. In Active Directory domains, the Kerberos protocol is the default authentication protocol. However, if the Kerberos protocol is not negotiated for some reason, Active Directory uses LM, NTLM, or NTLM version 2 \(NTLMv2\).  
  
LAN Manager authentication includes the LM, NTLM, and NTLMv2 variants, and it is the protocol that is used to authenticate all client computers running the Windows operating system when they perform the following operations:  
  
-   Join a domain  
  
-   Authenticate between Active Directory forests  
  
-   Authenticate to domains based on earlier versions of the Windows operating system  
  
-   Authenticate to computers that do not run Windows operating systems, beginning with Windows 2000  
  
-   Authenticate to computers that are not in the domain  
  
### Possible values  
  
-   Send LM & NTLM responses  
  
-   Send LM & NTLM \- use NTLMv2 session security if negotiated  
  
-   Send NTLM responses only  
  
-   Send NTLMv2 responses only  
  
-   Send NTLMv2 responses only. Refuse LM  
  
-   Send NTLMv2 responses only. Refuse LM & NTLM  
  
-   Not Defined  
  
The **Network security: LAN Manager authentication level** setting determines which challenge\/response authentication protocol is used for network logons. This choice affects the authentication protocol level that clients use, the session security level that the computers negotiate, and the authentication level that servers accept. The following table identifies the policy settings, describes the setting, and identifies the security level used in the corresponding registry setting if you choose to use the registry to control this setting instead of the policy setting.  
  
|Setting|Description|Registry security level|  
|-----------|---------------|---------------------------|  
|Send LM & NTLM responses|Client computers use LM and NTLM authentication, and they never use NTLMv2 session security. Domain controllers accept LM, NTLM, and NTLMv2 authentication.|0|  
|Send LM & NTLM – use NTLMv2 session security if negotiated|Client computers use LM and NTLM authentication, and they use NTLMv2 session security if the server supports it. Domain controllers accept LM, NTLM, and NTLMv2 authentication.|1|  
|Send NTLM response only|Client computers use NTLMv1 authentication, and they use NTLMv2 session security if the server supports it. Domain controllers accept LM, NTLM, and NTLMv2 authentication.|2|  
|Send NTLMv2 response only|Client computers use NTLMv2 authentication, and they use NTLMv2 session security if the server supports it. Domain controllers accept LM, NTLM, and NTLMv2 authentication.|3|  
|Send NTLMv2 response only. Refuse LM|Client computers use NTLMv2 authentication, and they use NTLMv2 session security if the server supports it. Domain controllers refuse to accept LM authentication, and they will accept only NTLM and NTLMv2 authentication.|4|  
|Send NTLMv2 response only. Refuse LM & NTLM|Client computers use NTLMv2 authentication, and they use NTLMv2 session security if the server supports it. Domain controllers refuse to accept LM and NTLM authentication, and they will accept only NTLMv2 authentication.|5|  
  
### Best practices  
  
1.  Best practices are dependent on your specific security and authentication requirements.  
  
### Location  
*GPO\_name*\\Computer Configuration\\Windows Settings\\Security Settings\\Local Policies\\Security Options  
  
### Default values  
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy’s property page.  
  
|Server type or GPO|Default value|  
|----------------------|-----------------|  
|Default Domain Policy|Not defined|  
|Default Domain Controller Policy|Not defined|  
|Stand\-Alone Server Default Settings|Send NTLMv2 response only|  
|DC Effective Default Settings|Send NTLMv2 response only|  
|Member Server Effective Default Settings|Send NTLMv2 response only|  
|Client Computer Effective Default Settings|Not defined|  
  
### Operating system version differences  
In Windows Server 2003, the Default Domain Controllers Policy was **Send NTLM response only**, which changed to **Not defined** in later versions.  
  
In Windows Vista, Windows Server 2008,  Windows 7 , and  Windows Server 2008 R2 , the default is **Send NTLMv2 response only**.  
  
## Policy management  
This section describes features and tools that are available to help you manage this policy.  
  
### Restart requirement  
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.  
  
### Group Policy  
Modifying this setting may affect compatibility with client computers, services, and applications.  
  
## Security considerations  
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.  
  
### Vulnerability  
In Windows 7 and Windows Vista, this setting is undefined. In Windows Server 2008 R2 and  Windows Server 2008  this setting is configured to **Send NTLMv2 responses only**. In Windows 2000, Windows Server 2003, and Windows XP, client computers are configured by default to send LM and NTLM authentication responses \(Windows 95\-based and Windows 98\-based client computers only send LM\). The default setting on servers allows all client computers to authenticate with servers and use their resources. However, this means that LM responses—the weakest form of authentication response—are sent over the network, and it is potentially possible for attackers to intercept that traffic to reproduce the user's password more easily.  
  
The Windows 95, Windows 98, and Windows NT operating systems cannot use Kerberos protocol version 5 for authentication. For this reason, in a Windows Server 2003 domain, these computers authenticate by default with both the LM and NTLM protocols for network authentication. You can enforce a more secure authentication protocol for Windows 95, Windows 98, and Windows NT by using NTLMv2. For the logon process, NTLMv2 uses a secure channel to protect the authentication process. Even if you use NTLMv2 for client computers and servers running these early versions of the Windows operating system, Windows\-based client computers and servers that are members of the domain use the Kerberos protocol to authenticate with Windows Server 2003 domain controllers.  
  
### Countermeasure  
Configure the **Network security: LAN Manager Authentication Level** setting to **Send NTLMv2 responses only**. Microsoft and a number of independent organizations strongly recommend this level of authentication when all client computers support NTLMv2.  
  
For more information about how to enable NTLMv2 on older versions of the Windows operating system, see [article 239869](http://go.microsoft.com/fwlink/?LinkId=100904) in the Microsoft Knowledge Base. Windows NT 4.0 requires Service Pack 4 \(SP4\) to support NTLMv2, and Windows 95 and Windows 98 need the directory service client installed to support NTLMv2.  
  
### Potential impact  
Client computers that do not support NTLMv2 authentication cannot authenticate in the domain and access domain resources by using LM and NTLM.  
  
> [!NOTE]  
> For information about a hotfix to ensure that this setting works in networks that include Windows NT 4.0\-based computers along with Windows 2000, Windows XP, and Windows Server 2003\-based computers, see [article 305379](http://go.microsoft.com/fwlink/?LinkId=100907) in the Microsoft Knowledge Base.  
  

