---
title: Audit Other System Events
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-auditing
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 033425bd-d883-4230-8899-62af92763c7b
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Audit Other System Events

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This topic for the IT professional describes the Advanced Security Audit policy setting, **Audit Other System Events**, which determines whether the operating system audits various system events.

The system events in this category include:

-   Startup and shutdown of the Windows Firewall service and driver.

-   Security policy processing by the Windows Firewall service.

-   Cryptography key file and migration operations.

> [!IMPORTANT]
> Failure to start the Windows Firewall service may result in a computer that is not fully protected against network threats.

Event volume: Low

Default: Success and failure

If this policy setting is configured, the following events appear on computers running the supported versions of the Windows operating system as designated in the **Applies to** list at the beginning of this topic, in addition to Windows Server 2008 and Windows Vista, unless otherwise noted.

|Event ID|Event message|
|------|---------|
|5024|The Windows Firewall Service has started successfully.|
|5025|The Windows Firewall Service has been stopped.|
|5027|The Windows Firewall Service was unable to retrieve the security policy from the local storage. The service will continue enforcing the current policy.|
|5028|The Windows Firewall Service was unable to parse the new security policy. The service will continue with currently enforced policy.|
|5029|The Windows Firewall Service failed to initialize the driver. The service will continue to enforce the current policy.|
|5030|The Windows Firewall Service failed to start.|
|5032|Windows Firewall was unable to notify the user that it blocked an application from accepting incoming connections on the network.|
|5033|The Windows Firewall Driver has started successfully.|
|5034|The Windows Firewall Driver has been stopped.|
|5035|The Windows Firewall Driver failed to start.|
|5037|The Windows Firewall Driver detected critical runtime error. Terminating.|
|5058|Key file operation.|
|5059|Key migration operation.|
|6400|BranchCache: Received an incorrectly formatted response while discovering availability of content. **Note:** This event is logged only on computers running supported versions of the Windows operating system.|
|6401|BranchCache: Received invalid data from a peer. Data discarded. **Note:** This event is logged only on computers running supported versions of the Windows operating system. .|
|6402|BranchCache: The message to the hosted cache offering it data is incorrectly formatted. **Note:** This event is logged only on computers running supported versions of the Windows operating system.|
|6403|BranchCache: The hosted cache sent an incorrectly formatted response to the client. **Note:** This event is logged only on computers running supported versions of the Windows operating system.|
|6404|BranchCache: Hosted cache could not be authenticated using the provisioned SSL certificate. **Note:** This event is logged only on computers running supported versions of the Windows operating system.|
|6405|BranchCache: %2 instance(s) of event id %1 occurred. **Note:** This event is logged only on computers running supported versions of the Windows operating system.|
|6406|%1 registered to Windows Firewall to control filtering for the following: %2 **Note:** This event is logged only on computers running supported versions of the Windows operating system.|
|6407|1% **Note:** This event is logged only on computers running supported versions of the Windows operating system.|
|6408|Registered product %1 failed and Windows Firewall is now controlling the filtering for %2 **Note:** This event is logged only on computers running supported versions of the Windows operating system.|

## Related resource
[Advanced Security Audit Policy Settings](../advanced-security-audit-policy-settings.md)


