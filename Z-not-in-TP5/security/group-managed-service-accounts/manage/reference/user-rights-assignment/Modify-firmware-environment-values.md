---
title: Modify firmware environment values
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f9ca8a35-5e44-4025-b77c-67b032fe1f84
---
# Modify firmware environment values
This security policy reference topic for the IT professional describes the best practices, location, values, policy management, and security considerations for this policy setting.

## Reference
This security setting determines who can modify firmware environment values. Firmware environment values are settings that are stored in the nonvolatile RAM of non-x86-based computers. The effect of the setting depends on the processor.

On x86-based computers, the only firmware environment value that can be modified by assigning this user right is the **Last Known Good Configuration** setting, which should only be modified by the system.

On Itanium-based computers, boot information is stored in nonvolatile RAM. Users must be assigned this user right to run bootcfg.exe and to change the **Default Operating System** setting using the **Startup and Recovery** feature on the **Advanced** tab of **System Properties**.

The exact setting for firmware environment values is determined by the boot firmware. The location of these values is also specified by the firmware. For example, on a UEFI-based system, NVRAM contains firmware environment values that specify system boot settings.

On all computers, this user right is required to install or upgrade Windows.

This policy setting is supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.

Constant: SeSystemEnvironmentPrivilege

### Possible values

-   User-defined list of accounts

-   Administrators

-   Not Defined

### Best practices

1.  Ensure that only the local Administrators group is assigned the **Modify firmware environment values** user right.

### Location
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\User Rights Assignment

### Default values
By default this setting is Administrators on domain controllers and on stand-alone servers.

The following table lists the actual and effective default policy values for the most recent supported versions of Windows. Default values are also listed on the policy’s property page.

|Server type or GPO|Default value|
|----------------------|-----------------|
|Default Domain Policy|Not defined|
|Default Domain Controller Policy|Adminstrators|
|Stand-Alone Server Default Settings|Adminstrators|
|Domain Controller Effective Default Settings|Adminstrators|
|Member Server Effective Default Settings|Adminstrators|
|Client Computer Effective Default Settings|Adminstrators|

### Operating system version differences
There are no differences in the way this policy setting works between the supported versions of Windows that are designated in the **Applies To** list at the beginning of this topic.

## Policy management
This section describes features, tools, and guidance to help you manage this policy.

A restart of the computer is not required for this policy setting to be effective.

Any change to the user rights assignment for an account becomes effective the next time the owner of the account logs on.

This security setting does not affect who can modify the system environment values and user environment values that are displayed on the **Advanced** tab of **System Properties**.

### Group Policy
Settings are applied in the following order through a Group Policy Object (GPO), which will overwrite settings on the local computer at the next Group Policy update:

1.  Local policy settings

2.  Site policy settings

3.  Domain policy settings

4.  OU policy settings

When a local setting is greyed out, it indicates that a GPO currently controls that setting.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

### Vulnerability
Anyone who is assigned the **Modify firmware environment values** user right could configure the settings of a hardware component to cause it to fail, which could lead to data corruption or a denial-of-service condition.

### Countermeasure
Ensure that only the local Administrators group is assigned the **Modify firmware environment values** user right.

### Potential impact
None. Restricting the **Modify firmware environment values** user right to the members of the local Administrators group is the default configuration.

## See Also
[User Rights Assignment](User-Rights-Assignment.md)


