---
title: Audit Network Policy Server
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-auditing
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bd7039a6-2e1a-474e-bb93-b89f65682c8a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Audit Network Policy Server

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic for the IT professional describes the Advanced Security Audit policy setting, **Audit Network Policy Server**, which determines whether the operating system generates audit events for RADIUS (IAS) and Network Access Protection (NAP) activity on user access requests (Grant, Deny, Discard, Quarantine, Lock, and Unlock).

NAP events can be used to help understand the overall health of the network.

Event volume: Medium to high on servers that are running Network Policy Server (NPS); moderate on other servers or on client computers

Default: Success and failure

If this policy setting is configured, the following events appear on computers running the supported versions of the Windows operating system as designated in the **Applies To** list at the beginning of this topic, in addition to Windows Server 2008, Windows Vista with Service Pack 2 (SP2), or Windows Vista with Service Pack 1 (SP1).

|Event ID|Event message|
|------|---------|
|6272|Network Policy Server granted access to a user.|
|6273|Network Policy Server denied access to a user.|
|6274|Network Policy Server discarded the request for a user.|
|6275|Network Policy Server discarded the accounting request for a user.|
|6276|Network Policy Server quarantined a user.|
|6277|Network Policy Server granted access to a user but put it on probation because the host did not meet the defined health policy.|
|6278|Network Policy Server granted full access to a user because the host met the defined health policy.|
|6279|Network Policy Server locked the user account due to repeated failed authentication attempts.|
|6280|Network Policy Server unlocked the user account.|

## Related resource
[Advanced Security Audit Policy Settings](../advanced-security-audit-policy-settings.md)


