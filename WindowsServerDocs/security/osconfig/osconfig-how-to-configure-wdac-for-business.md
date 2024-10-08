---
title: OSConfig overview for Windows Server (preview)
description: OSConfig is a cross-platform scenario-based security tool to manage on-premises Windows Server 2025 and Arc-connected devices.
ms.topic: conceptual
ms.product: windows-server
ms.author: wscontent
author: xelu86
ms.contributor: Dona Mukherjee, PM
ms.date: 10/10/2024
---


# How to configure WDAC for Business

Windows Defender Application Control (WDAC) for Business is a software-based security layer that reduces attack surface by enforcing an explicit list of software that is allowed to run. Microsoft developed a default policy for Windows Server 2025, which can be implemented on the server using PowerShell cmdlets. WDAC implementation is facilitated by using the OSConfig security configuration platform. Application control provides two main operation modes:

- **Audit mode**: Allows untrusted code to run while events are recorded.
- **Enforcement mode**: Disallows untrusted code from running while events are recorded.

To learn more about these security event logs, see [Understanding App Control events](/windows/security/application-security/application-control/app-control-for-business/operations/event-id-explanations) and [Understanding App Control event tags](/windows/security/application-security/application-control/app-control-for-business/operations/event-tag-explanations).

As a component of Windows Server 2025, the deployment of Application Control policies provides easier access to audit mode and enforcement mode through PowerShell. By default, there aren't Application Control policies set in audit mode in Windows Server 2025. Instead, businesses can utilize the OSConfig tool to add these policies. OSConfig includes base policies (unsigned) that can be customized with supplemental policies to meet specific business needs. To learn more about this security enhancement, see [Application Control for Windows](/windows/security/application-security/application-control/app-control-for-business/appcontrol).

## Prerequisites

Your device must have the OSConfig PowerShell module installed in order to configure WDAC. See [Install the OSConfig PowerShell module](osconfig-how-to-configure-security-baselines.md#install-the-osconfig-powershell-module) for details.

### Configure default policies

To configure the default Application Control policies in audit mode, open PowerShell as admin and run the following command:

```powershell
Set-OSConfigDesiredConfiguration -Scenario AppControl\WS2025\DefaultPolicy\Audit -Default
Set-OSConfigDesiredConfiguration -Scenario AppControl\WS2025\AppBlockList\Audit -Default
```

To verify that the Application Control policy was applied, run the following command and hit <kbd>Enter</kbd> twice:

```powershell
citool -lp | findstr /I "WS2025"
```

If the policy was applied, users should expect the following output:

```output
Friendly Name: BlockUMCI_Microsoft_WS2025_Audit
Friendly Name: AllowMicrosoft_WS2025_Audit
```
