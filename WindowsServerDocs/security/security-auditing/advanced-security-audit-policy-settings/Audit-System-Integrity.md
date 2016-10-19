---
title: Audit System Integrity
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-auditing
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2a1b3612-5614-429d-916a-5e9ec5a4aabc
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Audit System Integrity

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic for the IT professional describes the Advanced Security Audit policy setting, **Audit System Integrity**, which determines whether the operating system audits events that violate the integrity of the security subsystem.

Activities that violate the integrity of the security subsystem include the following:

-   Audited events are lost due to a failure of the auditing system.

-   A process uses an invalid local procedure call (LPC) port in an attempt to impersonate a client, reply to a client address space, read to a client address space, or write from a client address space.

-   A remote procedure call (RPC) integrity violation is detected.

-   A code integrity violation with an invalid hash value of an executable file is detected.

-   Cryptographic tasks are performed.

> [!IMPORTANT]
> Violations of security subsystem integrity are critical and could indicate a potential security attack.

Event volume: Low

Default: Success and failure

If this policy setting is configured, the following events appear on computers running the supported versions of the Windows operating system as designated in the **Applies to** list at the beginning of this topic, in addition to Windows Server 2008 and Windows Vista, unless otherwise noted.

|Event ID|Event message|
|------|---------|
|4612|Internal resources allocated for the queuing of audit messages have been exhausted, leading to the loss of some audits.|
|4615|Invalid use of LPC port.|
|4618|A monitored security event pattern has occurred.|
|4816|RPC detected an integrity violation while decrypting an incoming message.|
|5038|Code integrity determined that the image hash of a file is not valid. The file could be corrupt due to unauthorized modification or the invalid hash could indicate a potential disk device error.|
|5056|A cryptographic self-test was performed.|
|5057|A cryptographic primitive operation failed.|
|5060|Verification operation failed.|
|5061|Cryptographic operation.|
|5062|A kernel-mode cryptographic self-test was performed.|
|6281|Code Integrity determined that the page hashes of an image file are not valid. The file could be improperly signed without page hashes or corrupt due to unauthorized modification. The invalid hashes could indicate a potential disk device error. **Note:** This event is logged only on computers running the supported versions of the Windows operating system.|

## Related resource
[Advanced Security Audit Policy Settings](../Advanced-Security-Audit-Policy-Settings.md)


