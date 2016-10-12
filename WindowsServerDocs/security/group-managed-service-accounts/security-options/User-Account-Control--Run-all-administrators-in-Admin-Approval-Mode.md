---
title: User Account Control: Run all administrators in Admin Approval Mode
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 87376719-8cd6-4ab6-9036-581e82eccdfd
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# User Account Control: Run all administrators in Admin Approval Mode

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This security policy reference topic for the IT professional describes the best practices, location, values, policy management and security considerations for this policy setting.

## Reference
This policy setting determines the behavior of all User Account Control (UAC) policies for the entire system. This is the setting that turns UAC on or off.

### Possible values

-   **Enabled**

    Admin Approval Mode and all other UAC policies are dependent on this option being enabled. Changing this setting requires restarting the system.

-   **Disabled**

    Admin Approval Mode and all related UAC policies are disabled.

    > [!NOTE]
    > If this security setting is configured to **Disabled**, the Security Center notifies the user that the overall security of the operating system has been reduced.

### Best practices

1.  Enable this policy to allow all other UAC features and policies to function.

### Location
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options

### Default values
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy’s property page.

|Server type or GPO|Default value|
|----------------------|-----------------|
|Default Domain Policy|Not defined|
|Default Domain Controller Policy|Not defined|
|Stand-Alone Server Default Settings|Enabled|
|DC Effective Default Settings|Enabled|
|Member Server Effective Default Settings|Enabled|
|Client Computer Effective Default Settings|Enabled|

### Operating system version differences
There are no differences in this security policy between operating systems beginning with Windows Vista.

## Policy management
This section describes features and tools that are available to help you manage this policy.

### Restart requirement
A restart of the computer is required before this policy will be effective when changes to this policy are saved locally or distributed through Group Policy.

### Group Policy
This policy has no impact in Windows operating systems earlier than Windows Vista.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

### Vulnerability
This is the setting that turns UAC on or off. If this setting is disabled, UAC is not used, and any security benefits and risk mitigations that are dependent on UAC are not present on the computer.

### Countermeasure
Enable the **User Account Control: Run all users, including administrators, as standard users** setting.

### Potential impact
Users and administrators must learn to work with UAC prompts and adjust their work habits to use least privilege operations.


