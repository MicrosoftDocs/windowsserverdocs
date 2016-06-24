---
title: Microsoft network server: Amount of idle time required before suspending session
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bb3809d8-b5be-4ef2-846e-7e13dd7ca20d
---
# Microsoft network server: Amount of idle time required before suspending session
This security policy reference topic for the IT professional describes the best practices, location, values, and security considerations for this policy setting.

## Reference
Each Server Message Block (SMB) session consumes server resources. Establishing numerous null sessions will cause the server to slow down or possibly fail. A malicious user might repeatedly establish SMB sessions until the server stops responding; at this point, SMB services will become slow or unresponsive.

The **Microsoft network server: Amount of idle time required before suspending session** policy setting determines the amount of continuous idle time that must pass in an SMB session before the session is suspended due to inactivity. You can use this policy setting to control when a computer suspends an inactive SMB session. The session is automatically reestablished when client computer activity resumes.

### Possible values

-   A user-defined number of minutes from 0 through 99,999

    For this policy setting, a value of 0 means to disconnect an idle session as quickly as is reasonably possible. The maximum value is 99999, which is 208 days. In effect, this value disables the policy.

-   Not defined

### Best practices

1.  It is advisable to set this policy to 15 minutes. There will be little impact because SMB sessions will be reestablished automatically if the client resumes activity.

### Location
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options

### Default values
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy’s property page.

|Server type or GPO|Default value|
|----------------------|-----------------|
|Default Domain Policy|Not defined|
|Default Domain Controller Policy|Not defined|
|Stand-Alone Server Default Settings|15 minutes|
|DC Effective Default Settings|15 minutes|
|Member Server Effective Default Settings|15 minutes|
|Client Computer Effective Default Settings|15 minutes|

### Operating system version differences
There are no differences in this policy between operating systems beginning with Windows Server 2003.

## Policy management
This section describes features and tools that are available to help you manage this policy.

### Restart requirement
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

### Vulnerability
Each SMB session consumes server resources, and numerous null sessions slow the server or possibly cause it to fail. An attacker could repeatedly establish SMB sessions until the server's SMB services become slow or unresponsive.

### Countermeasure
The default behavior on a server mitigates this threat by design in Windows Server 2003 and later.

### Potential impact
There is little impact because SMB sessions are reestablished automatically if the client computer resumes activity.


