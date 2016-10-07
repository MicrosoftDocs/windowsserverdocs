---
title: Network access: Shares that can be accessed anonymously
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 547612f9-dbdb-4ba9-be68-206b26128c08
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Network access: Shares that can be accessed anonymously

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This security policy reference topic for the IT professional describes the best practices, location, values, policy management and security considerations for this policy setting.

## Reference
This policy setting determines which shared folders can be accessed by anonymous users.

### Possible values

-   User-defined list of shared folders

-   Not Defined

### Best practices

1.  Set this policy to a null value. There should be little impact because this is the default value. All users will have to be authenticated before they can access shared resources on the server.

### Location
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options

### Default values
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy’s property page.

|Server type or GPO|Default value|
|----------------------|-----------------|
|Default Domain Policy|Not defined|
|Default Domain Controller Policy|Not defined|
|Stand-Alone Server Default Settings|Not defined|
|DC Effective Default Settings|Not defined|
|Member Server Effective Default Settings|Not defined|
|Client Computer Effective Default Settings|Not defined|

### Operating system version differences
In Windows Server 2003, the default setting for stand-alone servers, member servers, and client computers was COMCFG, DFS$. In later versions of the Windows operating system, the default setting for these server types of GPOs is not defined (null).

## Policy management
This section describes features and tools that are available to help you manage this policy.

### Restart requirement
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

### Vulnerability
Any shared folders that are listed can be accessed by any network user, which could lead to the exposure or corruption of sensitive data.

### Countermeasure
Configure the **Network access: Shares that can be accessed anonymously** setting to a null value.

### Potential impact
There should be little impact because this is the default configuration. Only authenticated users have access to shared resources on the server.


