---
title: Receive Segment Coalescing (RSC) in the vSwitch
description: Receive Segment Coalescing (RSC) in the vSwitch is a feature in Windows Server 2019 and Windows 10 October 2018 Update that helps reduce host CPU utilization and increases throughput for virtual workloads by coalescing multiple TCP segments into fewer, but larger segments. Processing fewer, large segments (coalesced) is more efficient than processing numerous, small segments.
manager: dougkim
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: 
ms.author: dacuo 
author: eross-msft
ms.date: 09/07/2018 
---

# RSC in the vSwitch
>Applies to: Windows Server 2019

Receive Segment Coalescing (RSC) in the vSwitch is a feature in Windows Server 2019 and Windows 10 October 2018 Update that helps reduce host CPU utilization and increases throughput for virtual workloads by coalescing multiple TCP segments into fewer, but larger segments. Processing fewer, large segments (coalesced) is more efficient than processing numerous, small segments.

Windows Server 2012 and later included a hardware-only offload version (implemented in the physical network adapter) of the technology also known as Receive Segment Coalescing. This offloaded version of RSC is still available in later versions of Windows. However, it is incompatible with virtual workloads and was disabled once a physical network adapter is attached to a vSwitch. For more information on the hardware-only version of RSC, see [Receive Segment Coalescing (RSC)](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh997024(v=ws.11)).

## Scenarios that benefit from RSC in the vSwitch

Workloads whose datapath traverses a virtual switch benefits from this feature.

For example:

-   Host Virtual NICs including:

    -   Software Defined Networking

    -   Hyper-V Host

    -   Storage Spaces Direct

-   Hyper-V Guest Virtual NICs

-   Software Defined Networking GRE Gateways

-   Container

Workloads that are not compatible with this feature include:

-   Software Defined Networking IPSEC Gateways

-   SR-IOV enabled virtual NICs

-   SMB Direct

## Configure RSC in the vSwitch


By default, on external vSwitches, RSC is enabled.

**View the current settings:**

```PowerShell
Get-VMSwitch -Name vSwitchName | Select-Object *RSC*
```

**Enable or Disable RSC in the vSwitch**


>[!IMPORTANT]
>Important: RSC in the vSwitch can be enabled and disabled on the fly without impact to existing connections.


**Disable RSC in the vSwitch**

```PowerShell
Set-VMSwitch -Name vSwitchName -EnableSoftwareRsc $false
```

**Re-enable RSC in the vSwitch**

```PowerShell
Set-VMSwitch -Name vSwitchName -EnableSoftwareRsc $True
```
For more information, see [Set-VMSwitch](https://docs.microsoft.com/powershell/module/hyper-v/set-vmswitch?view=win10-ps).
