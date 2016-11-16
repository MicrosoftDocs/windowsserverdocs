---
title: Network access: Let Everyone permissions apply to anonymous users
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-policy-settings
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: de0c222e-73ea-40c9-a2b7-bdfbb193cf15
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Network access: Let Everyone permissions apply to anonymous users

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This security policy reference topic for the IT professional describes the best practices, location, values, policy management and security considerations for this policy setting.  
  
## Reference  
This policy setting determines what additional permissions are granted for anonymous connections to the computer. If you enable this policy setting, anonymous users can enumerate the names of domain accounts and shared folders and perform certain other activities. This capability is convenient, for example, when an administrator wants to grant access to users in a trusted domain that does not maintain a reciprocal trust.  
  
By default, the token that is created for anonymous connections does not include the Everyone SID. Therefore, permissions that are assigned to the Everyone group do not apply to anonymous users.  
  
### Possible values  
  
-   Enabled  
  
    The Everyone SID is added to the token that is created for anonymous connections, and anonymous users can access any resource for which the Everyone group has been assigned permissions.  
  
-   Disabled  
  
    The Everyone SID is removed from the token that is created for anonymous connections.  
  
-   Not defined  
  
### Best practices  
  
1.  Set this policy to **Disabled**.  
  
### Location  
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Polices\Security Options  
  
### Default values  
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy???s property page.  
  
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
An unauthorized user could anonymously list account names and shared resources and use the information to attempt to guess passwords, perform social engineering attacks, or launch DoS attacks.  
  
### Countermeasure  
Disable the **Network access: Let Everyone permissions apply to anonymous users** setting.  
  
### Potential impact  
None. This is the default configuration.  
  

