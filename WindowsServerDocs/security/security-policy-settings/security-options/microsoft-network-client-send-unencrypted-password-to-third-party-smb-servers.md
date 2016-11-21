---
title: Microsoft network client: Send unencrypted password to third-party SMB servers
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-policy-settings
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d972f992-ec4e-4caf-a71a-5ee1893943af
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Microsoft network client: Send unencrypted password to third-party SMB servers

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This security policy reference topic for the IT professional describes the best practices, location, values, policy management and security considerations for this policy setting.  
  
## Reference  
The Server Message Block (SMB) protocol provides the basis for file and print sharing and many other networking operations, such as remote Windows administration. This policy setting allows or prevents the SMB redirector to send plaintext passwords to a non-Microsoft server service that does not support password encryption during authentication.  
  
### Possible values  
  
-   Enabled  
  
    The Server Message Block (SMB) redirector is allowed to send plaintext passwords to a non-Microsoft server service that does not support password encryption during authentication.  
  
-   Disabled  
  
    The Server Message Block (SMB) redirector only sends encrypted passwords to non-Microsoft SMB server services. If those server services do not support password encryption, the authentication request will fail.  
  
-   Not defined  
  
### Best practices  
  
1.  It is advisable to set **Microsoft network client: Send unencrypted password to connect to third-party SMB servers** to Disabled. Some old applications and operating systems (such as MS-DOS, Windows for Workgroups 3.11, and Windows 95) might not be able to communicate with the servers in your organization through the SMB protocol.  
  
### Location  
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options  
  
### Default values  
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy' property page.  
  
|Server type or GPO|Default value|  
|-----------|---------|  
|Default Domain Policy|Not defined|  
|Default Domain Controller Policy|Not defined|  
|Stand-Alone Server Default Settings|Disabled|  
|DC Effective Default Settings|Disabled|  
|Member Server Effective Default Settings|Disabled|  
|Client Computer Effective Default Settings|Disabled|  
  
### Operating system version differences  
There are no differences in this policy between operating systems beginning with Windows Server 2003.  
  
## Policy management  
This section describes features and tools that are available to help you manage this policy.  
  
### Restart requirement  
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.  
  
## Security considerations  
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.  
  
### Vulnerability  
If you enable this policy setting, the server can transmit plaintext passwords across the network to other computers that offer SMB services. These other computers might not use any of the SMB security mechanisms that are included with Windows Server 2003 or later.  
  
### Countermeasure  
Disable the **Microsoft network client: Send unencrypted password to connect to third-party SMB servers** setting.  
  
### Potential impact  
Some old applications and operating systems (such as MS-DOS, Windows for Workgroups 3.11, and Microsoft Windows 95) may not be able to communicate with the servers in your organization by means of the SMB protocol.  
  

