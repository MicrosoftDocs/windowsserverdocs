---
title: Audit RPC Events
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-auditing
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3984c11a-a3c2-4e3e-96b7-b4b40b5d64ae
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Audit RPC Events

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic for the IT professional describes the Advanced Security Audit policy setting, **Audit RPC Events**, which determines whether the operating system generates audit events when inbound remote procedure call (RPC) connections are made.

RPC is a technology for creating distributed client/server programs. RPC is an interprocess communication technique that enables client and server software to communicate. For more information, see [What Is RPC?](http://technet.microsoft.com/library/cc787851(v=WS.10.aspx.

Event volume: High on RPC servers

Default: Not configured

If this policy setting is configured, the following event appears on computers running the supported versions of the Windows operating system as designated in the **Applies To** list at the beginning of this topic, in addition to Windows Server 2008 and Windows Vista.

|Event ID|Event message|
|------------|-----------------|
|5712|A Remote Procedure Call (RPC) was attempted.|

## Related resource
[Advanced Security Audit Policy Settings](../Advanced-Security-Audit-Policy-Settings.md)


