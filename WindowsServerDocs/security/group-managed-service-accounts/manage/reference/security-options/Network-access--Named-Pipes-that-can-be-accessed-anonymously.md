---
title: Network access: Named Pipes that can be accessed anonymously
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f81aa054-faf1-480e-9d7f-fef76572344e
---
# Network access: Named Pipes that can be accessed anonymously
This security policy reference topic for the IT professional describes the best practices, location, values, policy management and security considerations for this policy setting.

## Reference
This policy setting determines which communication sessions, or pipes, have attributes and permissions that allow anonymous access.

Restricting access over named pipes such as COMNAP and LOCATOR helps prevent unauthorized access to the network. The table in the [](#BKMK_Vulnerability) section lists default named pipes and their purpose.

### Possible values

-   User\-defined list of shared folders

-   Not defined

### Best practices

1.  Set this policy to a null value; that is, enable the policy setting, but do not enter named pipes in the text box. This will disable null session access over named pipes, and applications that rely on this feature or on unauthenticated access to named pipes will no longer function. For example, with Microsoft Commercial Internet System 1.0, the Internet Mail Service runs under Inetinfo.exe. Inetinfo.exe starts in the context of the System account. When Internet Mail Service needs to query the Microsoft SQL Server database, it uses the System account, which uses null credentials to access an SQL pipe on the computer running SQL Server.

### Location
*GPO\_name*\\Computer Configuration\\Windows Settings\\Security Settings\\Local Policies\\Security Options

### Default values
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy’s property page.

|Server type or GPO|Default value|
|----------------------|-----------------|
|Default Domain Policy|Not defined|
|Default Domain Controller Policy|Netlogon, samr, lsarpc|
|Stand\-Alone Server Default Settings|Null|
|DC Effective Default Settings|Netlogon, samr, lsarpc|
|Member Server Effective Default Settings|Not defined|
|Client Computer Effective Default Settings|Not defined|

### Operating system version differences
The default settings for this policy changed from Windows Server 2003.

## Policy management
This section describes different features and tools available to help you manage this policy.

### Restart requirement
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.

### Group Policy
For this policy setting to take effect, you must also enable the **Network access: Restrict anonymous access to named pipes and shares** setting.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

### <a name="BKMK_Vulnerability"></a>Vulnerability
You can restrict access over named pipes such as COMNAP and LOCATOR to help prevent unauthorized access to the network. The following list describes available named pipes and their purpose. These pipes were granted anonymous access in earlier versions of Windows and some legacy applications may still use them.

|Named pipe|Purpose|
|--------------|-----------|
|COMNAP|SNABase named pipe. Systems network Architecture \(SNA\) is a collection of network protocols that were originally developed for IBM mainframe computers.|
|COMNODE|SNA Server named pipe.|
|SQL\\QUERY|Default named pipe for SQL Server.|
|SPOOLSS|Named pipe for the Print Spooler service.|
|EPMAPPER|End Point Mapper named pipe.|
|LOCATOR|Remote Procedure Call Locator service named pipe.|
|TrlWks|Distributed Link Tracking Client named pipe.|
|TrkSvr|Distributed Link Tracking Server named pipe.|

### Countermeasure
Configure the **Network access: Named Pipes that can be accessed anonymously** setting to a null value \(enable the setting but do not specify named pipes in the text box\).

### Potential impact
This configuration disables null\-session access over named pipes, and applications that rely on this feature or on unauthenticated access to named pipes no longer function. This may break trust between Windows Server 2003 domains in a mixed mode environment.


