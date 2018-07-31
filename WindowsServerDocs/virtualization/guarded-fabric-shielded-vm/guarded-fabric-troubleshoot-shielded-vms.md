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

Beginning with Windows Server version 1803, VMConnect enhanced session mode and PS Direct are re-enabled for fully shielded VMs. The virtualization admin still requires VM guest credentials to get access to the VM, but this makes it easier for a hoster to troubleshoot a shielded VM when its network configuration is broken.

To enable VMConnect and PS Direct for your shielded VMs, simply move them to a Hyper-V host that runs Windows Server version 1803 or later. The virtual devices allowing for these features will be re-enabled automatically. If a shielded VM moves to a host that runs and earlier version of Windows Server, VMConnect and PS Direct will be disabled again.

For security-sensitive customers who worry if hosters have any access to the VM and wish to return to the original behavior, the following features should be disabled in the guest OS:

- Disable the PowerShell Direct service in the VM

- Disable the **Microsoft Hyper-V Remote Desktop Control Channel** device in Device Manager


Why is Virtual Machine Connection (VMConnect) sometimes allowed and sometimes not? This depends on the operating system version. If you want VMConnect to always be available on a VM guest beginning with Windows Server 2019, add this registry key:

PS direct you can disable in Windows Server 2016. But the reg key disable VM connect is only available in 2019, that’s for the guest OS... 

