---
title: Domain member: Disable machine account password changes
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3cc1b46a-d0f8-4e62-8047-703ec329bc84
---
# Domain member: Disable machine account password changes
This security policy reference topic for the IT professional describes the best practices, location, values, and security considerations for this policy setting.

## Reference
The **Domain member: Disable machine account password changes** policy setting determines whether a domain member periodically changes its computer account password. Setting its value to **Enabled** prevents the domain member from changing the computer account password. Setting it to **Disabled** allows the domain member to change the computer account password as specified by the value of the **Domain member: Maximum machine account password age** policy setting, which is every 30 days by default.

The default configuration for computers running [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)], [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)], or Windows Server 2003 that belong to a domain is that they are automatically required to change the passwords for their accounts every 30 days. Disabling this feature causes computers that are running these operating systems to retain the same passwords as their computer accounts. Computers that are no longer able to automatically change their account password are at risk of a malicious user determining the password for the system's domain account.

Verify that the **Domain member: Disable machine account password changes** option is set to **Disabled**.

### Possible values

-   Enabled

-   Disabled

### Best practices

1.  Do not enable this policy setting. Computer account passwords are used to establish secure channel communications between members and domain controllers and  between the domain controllers within the domain. After it is established, the secure channel transmits sensitive information that is necessary for making authentication and authorization decisions.

2.  Do not use this policy setting in an attempt to support dual\-boot scenarios that use the same computer account. If you want to dual\-boot installations that are joined to the same domain, give the two installations different computer names. This policy setting was added to the Windows operating system to make it easier for organizations that stockpile prebuilt computers that are put into production months later; those computers do not have to be rejoined to the domain.

### Location
*GPO\_name*\\Computer Configuration\\Windows Settings\\Security Settings\\Local Policies\\Security Options

### Default values
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy’s property page.

|Server type or GPO|Default value|
|----------------------|-----------------|
|Default Domain Policy|Disabled|
|Default Domain Controller Policy|Disabled|
|Stand\-Alone Server Default Settings|Disabled|
|DC Effective Default Settings|Disabled|
|Member Server Effective Default Settings|Disabled|
|Client Computer Effective Default Settings|Disabled|

### Operating system version differences
In Windows Server 2003, the default setting for Domain Policy and Domain Controller Policy was not defined. In [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)] and [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)], it is **Disabled**. There is no difference in the effective setting between these two, however.

## Policy management
This section describes features and tools that are available to help you manage this policy.

### Restart requirement
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

### Vulnerability
The default configuration for Windows Server operating systems that belong to a domain automatically require them to change the passwords for their accounts every certain number of days, typically 30. If you disable this policy setting, computers that run Windows Server operating systems retain the same passwords as their computer accounts. Computers that cannot automatically change their account password are at risk from an attacker who could determine the password for the computer's domain account.

### Countermeasure
Verify that the **Domain member: Disable machine account password changes** setting is configured to **Disabled**.

### Potential impact
None. This is the default configuration.


