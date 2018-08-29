---
title: Troubleshoot Shielded VMs 
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 08/29/2018
---

# Troubleshoot Shielded VMs

>Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016

Beginning with Windows Server version 1803, Virtual Machine Connection (VMConnect) enhanced session mode and PS Direct are re-enabled for fully shielded VMs. The virtualization admin still requires VM guest credentials to get access to the VM, but this makes it easier for a hoster to troubleshoot a shielded VM when its network configuration is broken.

To enable VMConnect and PS Direct for your shielded VMs, simply move them to a Hyper-V host that runs Windows Server version 1803 or later. The virtual devices allowing for these features will be re-enabled automatically. If a shielded VM moves to a host that runs and earlier version of Windows Server, VMConnect and PS Direct will be disabled again.

For security-sensitive customers who worry if hosters have any access to the VM and wish to return to the original behavior, the following features should be disabled in the guest OS:

- Disable the PowerShell Direct service in the VM:

  ```powershell
  Stop-Service vmicvmsession
  Set-Service vmicvmsession -StartupType Disabled
  ```

- Disable the **Microsoft Hyper-V Remote Desktop Control Channel** device in Device Manager


Depending on the the version of the guest operating system, VMConnect might not be allowed. Beginning with Windows Server 2019, if you want VMConnect to always be available on a VM guest, add this registry key:

```
reg add "HKLM\Software\Microsoft\Virtual Machine\Guest" /v DisableEnhancedSessionConsoleConnection /t REG_DWORD /d 1
```



