---
title: File System (Global Object Access Auditing)
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-auditing
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 90bddcf3-618d-41df-94ba-ce7229067bba
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# File System (Global Object Access Auditing)

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic for the IT professional describes the Advanced Security Audit policy setting, **File System (Global Object Access Auditing)**, which enables you to configure a global system access control list (SACL) on the file system for an entire computer.

If you select the **Configure security** check box on the policy???s property page, you can add a user or group to the global SACL. This enables you to define computer system access control lists (SACLs) per object type for the file system. The specified SACL is then automatically applied to every file system object type.

If both a file or folder SACL and a global SACL are configured on a computer, the effective SACL is derived by combining the file or folder SACL and the global SACL. This means that an audit event is generated if an activity matches either the file or folder SACL or the global SACL.

This policy setting must be used in combination with the **File System** security policy setting under Object Access. For more information, see [Audit File System](Audit-File-System.md).

This policy setting is available on computers running the supported versions of the Windows operating system as designated in the **Applies to** list at the beginning of this topic.

## Related resource
[Advanced Security Audit Policy Settings](../Advanced-Security-Audit-Policy-Settings.md)


