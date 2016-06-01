---
title: Audit File System
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1a1c4c6b-575c-45d3-88bc-55f089c49c8a
---
# Audit File System
This topic for the IT professional describes the Advanced Security Audit policy setting, **Audit File System**, which determines whether the operating system generates audit events when users attempt to access file system objects.

Audit events are generated only for objects that have configured system access control lists \(SACLs\), and only if the type of access requested \(such as Write, Read, or Modify\) and the account making the request match the settings in the SACL.

If success auditing is enabled, an audit entry is generated each time any account successfully accesses a file system object that has a matching SACL. If failure auditing is enabled, an audit entry is generated each time any user unsuccessfully attempts to access a file system object that has a matching SACL.

These events are essential for tracking activity for file objects that are sensitive or valuable and require extra monitoring.

Event volume: Varies, depending on how file system SACLs are configured

No audit events are generated for the default file system SACLs.

Default: Not configured

If this policy setting is configured, the following events appear on computers running the supported versions of the Windows operating system as designated in the **Applies to** list at the beginning of this topic, in addition to Windows Server 2008 and Windows Vista.

|Event ID|Event message|
|------------|-----------------|
|4664|An attempt was made to create a hard link.|
|4985|The state of a transaction has changed.|
|5051|A file was virtualized.|

## Related resource
[Advanced Security Audit Policy Settings](Advanced-Security-Audit-Policy-Settings.md)


