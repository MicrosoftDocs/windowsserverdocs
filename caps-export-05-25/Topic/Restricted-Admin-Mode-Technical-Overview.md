---
title: Restricted Admin Mode Technical Overview
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d739c33d-4211-4f1f-ad59-437d76f2e2f5
---
# Restricted Admin Mode Technical Overview
This topic for the IT professional describes the Remote Desktop Protocol \(RDP\) feature of Restricted Admin, which helps control the exposure of administrator credentials when accessing remote computers.  
  
**Did you mean…**  
  
-   *[Remote Desktop Connection](http://technet.microsoft.com/library/cc772051.aspx)*  
  
-   *[Remote Desktop Protocol](http://msdn.microsoft.com/library/aa383015.aspx)*  
  
## <a name="BKMK_OVER"></a>Restricted admin mode description  
Restricted admin mode enhances the Remote Desktop Protocol so that a user, particularly one with high\-privilege credentials, can prevent those credentials from being exposed on the remote computer and also when accessing network resources from that remote computer. This feature is available on versions of Windows designated in the **Applies To** list at the beginning of this topic.  
  
Instead of connecting directly to the network resources using the administrator’s logged on domain credentials through the target computer, restricted admin mode substitutes the target computer’s \(machine\) credential token. Although this prevents additional exposure of the administrator’s credentials when accessing resources, it results in more frequent credential prompts when those resources are being accessed. The administrator then must decide which credentials to use to minimize potential exposure.  
  
RDP uses the Credential Security Support Provider \(CredSSP\) which leverages the security context on the client to establish the connection to the target host computer. The security context, in part, includes the account and plaintext password. When the target computer accepts this request, those credentials are used in the authentication request.  
  
When restricted admin mode is configured for the connection to the remote computer, the administrator’s plaintext credentials are not passed to the remote host or used in any connection to a resource that does not exist on the host. Instead, the remote computer’s machine credentials are used for authentication when the administrator attempts to access network resources, such as local intranet or network shares. If those resources require credentials different than the remote host’s machine credentials, the administrator is required to supply valid credentials.  
  
Smart card authentication is supported but biometric authentication is not supported.  
  
## <a name="BKMK_APP"></a>Practical applications  
Credential theft can quickly lead to compromised systems, and pass\-the\-hash techniques have become a common way for attackers to leverage the compromise of a single system within a network to access multiple systems. The attacker obtains a user’s credentials on the compromised system, such as the target host, and subsequently uses those credentials to gain access to anything else to which that user had access. When the credentials have domain administrator rights, compromise can be widespread.  
  
Restricted admin mode protects administrator’s high\-privilege credentials who remotely manage computers by preventing their credentials from being used to sign on to the remote computer, such as those hosting SharePoint or Lync, and subsequent exposure  to possible compromise while accessing network resources..  
  
Restricted admin mode reduces potential user error by providing server administrators the ability to enforce the use of remote administration tools on designated computers. Restricted admin mode also can reduce the number of authentication attempts where users are prompted for credentials.  
  
For example, Help Desk administration can benefit from this feature when the administrator must assist remote users with their computers. Normally, this consists of using Remote Assistance to take control of the users’ computer and fixing it for them. Sometimes, due to blocking issues, the administrator must use his high\-privilege credentials to resolve the problem. Using the restricted admin feature, he can use his network logon token to authenticate to the target computer where he can resolve the problem without exposing his domain credentials on a potentially compromised system.  
  
## How it works  
The Remote Desktop Protocol \(RDP\) manages the credentials of the administrator who connects to a remote computer using the Remote Desktop Client. The credentials in plaintext form are sent to the target host where the host attempts to perform the authentication process, and, if successful, connects the administrator to allowed local and network resources, using the credentials supplied.  
  
Restricted admin RDP connections do not send the administrator’s plaintext credentials to authenticate to the remote host. Additionally, restricted admin mode does not pass or use the administrator’s plaintext credentials to connect to any resource that does not exist on the host. On the remote host, the administrator has his full admin token and therefore all his rights to access the remote host. When the administrator attempts to access network resources, such as local intranet or network shares the remote computer’s machine credentials are used for authentication. If the machine credentials are sufficient, the administrator account can access network resources, however, if not sufficient, access to those network resources require the administrator to supply valid credentials.  
  
> [!WARNING]  
> Because the purpose of this feature is to limit the use of high\-privilege accounts within the network, you risk exposing your high\-privilege to potentially compromised systems when you use to access network resources.  
  
The following diagram shows the differences in managing credentials in the RDP connection using the restricted admin mode.  
  
![](../Image/CredsProtect_RestrictedAdminMode.jpg)  
  
If restricted admin is not configured for the RDP connection, the remote host by rejects the connection attempt when no user credentials are present in the authentication request. When restricted admin mode is configured, the remote server expects the absence of credentials and substitutes the machine credentials for access use.  
  
## How to configure restricted admin mode  
The target host must be configured to allow for outbound and inbound restricted admin connections.  
  
### Command\-line tool  
The Mstsc command\-line tool creates connections to Remote Desktop Session Host \(RD Session Host\) servers or other remote computers, edits an existing Remote Desktop Connection \(.rdp\) configuration file, and migrates legacy connection files that were created with Client Connection Manager to new .rdp connection files.  
  
Introduced in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] two additional parameters to mstsc support restricted admin mode.  
  
-   The parameter **\/restrictedAdmin** connects the user to the remote computer in restricted administration mode. In this mode, the logged on user’s account is used to connect to the remote computer, but their cleartext credentials are never sent.However, since the administrator’s credentials are not present on the remote computer, any outbound connections from that computer uses that computer’s credentials. This might impact app functionality and compatibility. The **\/restricedAdmin** parameter implies **\/admin**.  
  
-   The parameter **\/prompt** allows the logged in user to use a different user account when connecting to the remote computer. Neither the logged on user nor the provided user’s account credentials are sent to the remote computer. When used with **\/restrictedAdmin**, as in mstsc \/restrictedAdmin \/prompt, it provides the administrator an opportunity to enter credentials that allow a connection to network resources.  
  
For more information, see [Mstsc \[LH\]](../Topic/Mstsc.md).  
  
### Regkey configuration  
Configurable through a DWORD registry value at HKLM\\Software\\Policies\\Microsoft\\Windows\\CredentialsDelegation\\RestrictedRemoteAdministration.  
  
## <a name="BKMK_NEW"></a>New and changed functionality  
This feature was introduced in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)].  
  
## <a name="BKMK_SOFT"></a>Software requirements  
This feature, using mstsc.exe, is available by default on computers running the Windows operating systems designated in the **Applies To** list at the beginning of this topic.  
  
For computers running Windows Server 2008 R2, Windows Server 2012, Windows 8 and Windows 7, you must install QFE <number> on each computer to implement this feature on those computers. For more information, see <link>.  
  
## <a name="BKMK_LINKS"></a>See also  
For information about other credential protection technologies, see [Credentials Protection and Management](../Topic/Credentials-Protection-and-Management.md).  
  
