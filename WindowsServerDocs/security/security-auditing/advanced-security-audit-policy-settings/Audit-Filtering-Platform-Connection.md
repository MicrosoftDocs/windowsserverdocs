---
title: Audit Filtering Platform Connection
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-auditing
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b936a9e9-91b2-4cc6-80d4-b1c469ef75ff
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Audit Filtering Platform Connection

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic for the IT professional describes the Advanced Security Audit policy setting, **Audit Filtering Platform Connection**, which determines whether the operating system generates audit events when connections are allowed or blocked by the Windows Filtering Platform.

Windows Filtering Platform (WFP) was introduced in Windows Server 2008 and Windows Vista to enable independent software vendors (ISVs) to filter and modify TCP/IP packets, monitor or authorize connections, filter Internet Protocol security (IPsec)-protected traffic, and filter remote procedure calls (RPCs).

This security policy enables you to audit the following types of actions:

-   The Windows Firewall service blocks an application from accepting incoming connections on the network.

-   The Windows Filtering Platform allows or blocks a connection.

-   The Windows Filtering Platform permits or blocks a bind to a local port.

-   The Windows Filtering Platform permits or blocks an application or service from listening for incoming connections on a port.

Event volume: High

Default: Not configured

If this policy setting is configured, the following events appear on computers running the supported versions of the Windows operating system as designated in the  **Applies to** list at the beginning of this topic, in addition to Windows Server 2008 and Windows Vista.

|Event ID|Event message|
|------|---------|
|5031|The Windows Firewall Service blocked an application from accepting incoming connections on the network.|
|5140|A network share object was accessed. **Note:** This event is logged only on computers running the supported versions of the Windows operating system as designated in the **Applies To** list.|
|5150|The Windows Filtering Platform blocked a packet.|
|5151|A more restrictive Windows Filtering Platform filter has blocked a packet.|
|5154|The Windows Filtering Platform has permitted an application or service to listen on a port for incoming connections.|
|5155|The Windows Filtering Platform has blocked an application or service from listening on a port for incoming connections.|
|5156|The Windows Filtering Platform has allowed a connection.|
|5157|The Windows Filtering Platform has blocked a connection.|
|5158|The Windows Filtering Platform has permitted a bind to a local port.|
|5159|The Windows Filtering Platform has blocked a bind to a local port.|

## Related resource
[Advanced Security Audit Policy Settings](../advanced-security-audit-policy-settings.md)


