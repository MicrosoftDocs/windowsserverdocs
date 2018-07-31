---
title: Troubleshoot Shielded VMs 
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 07/31/2018
---

# Troubleshoot Shielded VMs

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016

Why is Virtual Machine Connection (VMConnect) sometimes allowed and sometimes not? This depends on the operating system version. If you want VMConnect to always be available on a VM guest beginning with Windows Server 2019, add this registry key:



 PS direct you can disable in Windows Server 2016. But the reg key disable VM connect is only available in 2019, that’s for the guest OS... 

