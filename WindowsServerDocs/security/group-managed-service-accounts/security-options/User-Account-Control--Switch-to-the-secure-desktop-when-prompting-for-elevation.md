---
title: User Account Control: Switch to the secure desktop when prompting for elevation
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 97f15708-f64d-4a95-8088-319a7d6c721b
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# User Account Control: Switch to the secure desktop when prompting for elevation

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This security policy reference topic for the IT professional describes the best practices, location, values, policy management and security considerations for this policy setting.

## Reference
This policy setting determines whether the elevation request prompts on the interactive user desktop or on the secure desktop.

The secure desktop presents the logon UI and restricts functionality and access to the system until the logon requirements are satisfied.

The secure desktop’s primary difference from the user desktop is that only trusted processes running as SYSTEM are allowed to run here (that is, nothing is running at the user’s privilege level). The path to get to the secure desktop from the user desktop must also be trusted through the entire chain.

### Possible values

-   **Enabled**

    All elevation requests by default go to the secure desktop.

-   **Disabled**

    All elevation requests go to the interactive user desktop.

### Best practices

1.  Enable the **User Account Control: Switch to the secure desktop when prompting for elevation setting**. The secure desktop helps protect against input and output spoofing by presenting the credentials dialog box in a protected section of memory that is accessible only by trusted system processes.

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
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.

### Group Policy
This policy has no impact of Windows operating systems earlier than Windows Vista.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

### Vulnerability
Elevation prompt dialog boxes can be spoofed, causing users to disclose their passwords to malicious software. Mouse cursors can be spoofed by hiding the real cursor and replacing it with an offset so the cursor is actually pointing to the **Allow** button.

### Countermeasure
Enable the **User Account Control: Switch to the secure desktop when prompting for elevation setting**. The secure desktop helps protect against input and output spoofing by presenting the credentials dialog box in a protected section of memory that is accessible only by trusted system processes.

### Potential impact
None. This is the default configuration.


