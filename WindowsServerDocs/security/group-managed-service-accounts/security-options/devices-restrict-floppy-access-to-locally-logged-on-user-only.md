---
title: Devices - Restrict floppy access to locally logged-on user only
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4547184b-5338-4fae-a395-1cf752ab3fcd
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Devices: Restrict floppy access to locally logged-on user only

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This security policy reference topic for the IT professional describes the best practices, location, values, and security considerations for this policy setting.

## Reference
This policy setting determines whether removable floppy disks are accessible to local and remote users simultaneously. Enabling this policy setting allows only the interactively logged-on user to access removable floppy disks. If this policy setting is enabled and no one is logged on interactively, the floppy disk can be accessed over the network.

The security benefit of enabling this policy setting is small because it only prevents network users from accessing the floppy disk drive when someone is logged on to the local console of the system at the same time. Additionally, floppy disk drives are not automatically made available as network shared drives; administrators must deliberately choose to share the drive. This becomes important when administrators are installing software or copying data from a floppy disk and they do not want network users to be able to execute the applications or view the data.

If this policy setting is enabled, users who connect to the server over the network will not be able to use any floppy disk drives that are installed on the server when anyone is logged on to the local console of the server.

### Possible values

-   Enabled

-   Disabled

-   Not defined

### Best practices

-   Best practices are dependent on your security and user accessibility requirements for CD drives.

### Location
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options

### Default values
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy's property page.

|Server type or GPO|Default value|
|-----------|---------|
|Default Domain Policy|Not defined|
|Default Domain Controller Policy|Not defined|
|Stand-Alone Server Default Settings|Disdabled|
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
A remote user could potentially access a mounted floppy disk that contains sensitive information. This risk is small because floppy disk drives are not automatically shared; administrators must deliberately choose to share the drive. However, administrators can deny network users the ability to view data or run applications from removable media on the server.

### Countermeasure
Enable the **Devices: Restrict floppy access to locally logged-on user only** setting.

### Potential impact
Users who connect to the server over the network cannot use any floppy disk drives that are installed on the server when anyone is logged on to the local console of the server. System tools that require access to floppy disk drives fail. For example, the Volume Shadow Copy service attempts to access all CD-ROM and floppy disk drives that are present on the computer when it initializes, and if the service cannot access one of these drives, it fails. This condition causes the Windows Backup tool to fail if volume shadow copies were specified for the backup job. Any non-Microsoft backup products that use volume shadow copies also fail.


