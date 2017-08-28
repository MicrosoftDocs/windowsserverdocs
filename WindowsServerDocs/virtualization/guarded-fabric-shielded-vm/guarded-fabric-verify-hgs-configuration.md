---
title: Verify the HGS configuration
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
ms.assetid: 8f01df37-f18e-4386-ae73-ecf84feaa9df
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 08/28/2017
---

# Verify the HGS configuration

>Applies To: Windows Server 2016

>[!div class="step-by-step"]
[« Add HGS nodes](guarded-fabric-configure-additional-hgs-nodes.md)
[Deploy guarded hosts »](guarded-fabric-configure-hgs-with-authorized-hyper-v-hosts.md)

Next, we need to validate that things are working as expected. To do so, run the following command in an elevated Windows PowerShell console:

```powershell
Get-HgsTrace -RunDiagnostics
```

Because the HGS configuration does not yet contain information about the hosts that will be in the guarded fabric, the diagnostics will indicate that no hosts will be able to attest successfully yet. Ignore this result, and review the other information provided by the diagnostics.

[!INCLUDE [Guarded fabric diagnostics tool](../../../includes/guarded-fabric-diagnostics-tool.md)] 

<!-- When a link is available for an updated troubleshooting guide, add a sentence like the following and create a link to the troubleshooting guide:
If failures did occur, please review the remediation steps provided or see the Troubleshooting Guide.
-->

Run the diagnostics on each node in your HGS cluster.

