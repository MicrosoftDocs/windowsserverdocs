---
title: Microsoft network client: Digitally sign communications (if server agrees)
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-policy-settings
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b432863a-833f-456e-ac57-d74dac4a465d
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Microsoft network client: Digitally sign communications (if server agrees)

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This security policy reference topic for the IT professional describes the best practices, location, values, and security considerations for this policy setting.  
  
## Reference  
The Server Message Block (SMB) protocol provides the basis for Microsoft file and print sharing and many other networking operations, such as remote Windows administration. To prevent man-in-the-middle attacks that modify SMB packets in transit, the SMB protocol supports the digital signing of SMB packets. This policy setting determines whether SMB packet signing must be negotiated before further communication with the Server service is permitted.  
  
Implementation of digital signatures in high-security networks helps to prevent the impersonation of client computers and servers, which is known as "session hijacking." But misuse of these policy settings is a common error that can cause data loss or problems with data access or security.  
  
For this policy to take effect on computers running Windows 2000, client-side packet signing must also be enabled. To enable client-side SMB packet signing, set **Microsoft network client: Digitally sign communications (if server agrees)**. Computers that have this policy set will not be able to communicate with computers that do not have server-side packet signing enabled. By default, server-side packet signing is enabled only on domain controllers running Windows 2000, Windows Server 2003, Windows Server 2008, and Windows Server 2008 R2. Server-side packet signing can be enabled on these computers by setting **Microsoft network server: Digitally sign communications (if client agrees)**.  
  
If server-side SMB signing is required, a client computer will not be able to establish a session with that server, unless it has client-side SMB signing enabled. By default, client-side SMB signing is enabled on workstations, servers, and domain controllers. Similarly, if client-side SMB signing is required, that client computer will not be able to establish a session with servers that do not have packet signing enabled. By default, server-side SMB signing is enabled only on domain controllers.  
  
If server-side SMB signing is enabled, SMB packet signing will be negotiated with client computers that have SMB signing enabled.  
  
Using SMB packet signing can impose up to a 15 percent performance degradation on file service transactions.  
  
There are three other policy settings that relate to packet-signing requirements for Server Message Block (SMB) communications:  
  
-   [Microsoft network server: Digitally sign communications &#40;always&#41;](microsoft-network-server-digitally-sign-communications-always.md)  
  
-   [Microsoft network client: Digitally sign communications &#40;always&#41;](microsoft-network-client-digitally-sign-communications-always.md)  
  
-   [Microsoft network server: Digitally sign communications &#40;if client agrees&#41;](microsoft-network-server-digitally-sign-communications-if-client-agrees.md)  
  
### Possible values  
  
-   Enabled  
  
-   Disabled  
  
-   Not defined  
  
### Best practices  
  
1.  Configure the following security policy settings as follows:  
  
    -   Disable **Microsoft Network Client: Digitally Sign Communications (Always)**.  
  
    -   Disable **Microsoft Network Server: Digitally Sign Communications (Always)**.  
  
    -   Enable **Microsoft Network Client: Digitally Sign Communications (If Server Agrees)**.  
  
    -   Enable **Microsoft Network Server: Digitally Sign Communications (If Client Agrees)**.  
  
2.  Alternately, you can set all of these policy settings to Enabled, but enabling them can cause slower performance on client computers and prevent them from communicating with legacy SMB applications and operating systems.  
  
### Location  
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options  
  
### Default values  
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy???s property page.  
  
|Server type or GPO|Default value|  
|-----------|---------|  
|Default Domain Policy|Not defined|  
|Default Domain Controller Policy|Not defined|  
|Stand-Alone Server Default Settings|Enabled|  
|DC Effective Default Settings|Enabled|  
|Member Server Effective Default Settings|Enabled|  
|Client Computer Effective Default Settings|Enabled|  
  
### Operating system version differences  
There are no differences in this policy setting between operating systems beginning with Windows Server 2003.  
  
## Policy management  
This section describes features and tools that are available to help you manage this policy.  
  
### Restart requirement  
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.  
  
## Security considerations  
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.  
  
### Vulnerability  
Session hijacking uses tools that allow attackers who have access to the same network as the client or server to interrupt, end, or steal a session in progress. Attackers can potentially intercept and modify unsigned Server Message Block (SMB) packets and then modify the traffic and forward it so that the server might perform objectionable actions. Alternatively, the attacker could pose as the server or client computer after legitimate authentication and gain unauthorized access to data.  
  
SMB is the resource-sharing protocol that is supported by many Windows operating systems. It is the basis of NetBIOS and many other protocols. SMB signatures authenticate users and the servers that host the data. If either side fails the authentication process, data transmission does not take place.  
  
### Countermeasure  
Configure the settings as follows:  
  
-   Disable **Microsoft Network Client: Digitally Sign Communications (Always)**.  
  
-   Disable **Microsoft Network Server: Digitally Sign Communications (Always)**.  
  
-   Enable **Microsoft Network Client: Digitally Sign Communications (If Server Agrees)**.  
  
-   Enable **Microsoft Network Server: Digitally Sign Communications (If Client Agrees)**.  
  
In highly secure environments we recommend that you configure all of these settings to Enabled. However, that configuration may cause slower performance on client computers and prevent communications with earlier SMB applications and operating systems.  
  
> [!NOTE]  
> An alternative countermeasure that could protect all network traffic is to implement digital signatures with IPsec. There are hardware-based accelerators for IPsec encryption and signing that could be used to minimize the performance impact on the servers' CPUs. No such accelerators are available for SMB signing.  
  
### Potential impact  
In the  Windows Server 2008 R2 ,  Windows Server 2008 , Windows Server 2003, Windows 2000 Server,  Windows 7 , Windows Vista, Windows XP Professional, and Windows 2000 Professional operating systems, implementations of the SMB file and print-sharing protocol support mutual authentication. This prevents session hijacking attacks and supports message authentication to prevent man-in-the-middle attacks. SMB signing provides this authentication by placing a digital signature into each SMB, which is then verified by the client and the server.  
  
Implementation of SMB signing may negatively affect performance because each packet must be signed and verified. If these settings are enabled on a server that is performing multiple roles, such as a small business server that is serving as a domain controller, file server, print server, and application server, performance may be substantially slowed. Additionally, if you configure computers to ignore all unsigned SMB communications, older applications and operating systems cannot connect. However, if you completely disable all SMB signing, computers are vulnerable to session-hijacking attacks.  
  

