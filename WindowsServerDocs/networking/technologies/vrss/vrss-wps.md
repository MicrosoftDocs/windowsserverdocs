---
title: Windows PowerShell Commands for RSS and vRSS
description: In this topic, you learn how to quickly locate technical reference information about Windows PowerShell commands for Receive Side Scaling (RSS) and virtual RSS (vRSS).
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: 49e93b9f-46d9-4cee-bcda-1c4634893ddd
ms.localizationpriority: medium
manager: dougkim
ms.author: lizross
author: eross-msft
ms.date: 09/05/2018
---

# Windows PowerShell Commands for RSS and vRSS

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

In this topic, you learn how to quickly locate technical reference information about Windows PowerShell commands for Receive Side Scaling \(RSS\) and virtual RSS \(vRSS\).

Use the following RSS commands to configure RSS on a physical computer with multiple processors or multiple cores. You can use the same commands to configure vRSS on a virtual machine \(VM\) that is running a supported operating system. For more information, see [Network Adapter Cmdlets in Windows PowerShell](https://docs.microsoft.com/powershell/module/netadapter/?view=win10-ps).

## Configure VMQ

vRSS requires that VMQ is enabled and configured. You can use the following Windows PowerShell commands to manage VMQ settings.

- [Disable-NetAdapterVmq](https://docs.microsoft.com/powershell/module/netadapter/disable-netadaptervmq?view=win10-ps)
- [Enable-NetAdapterVmq](https://docs.microsoft.com/powershell/module/netadapter/enable-netadaptervmq?view=win10-ps)
- [Get-NetAdapterVmq](https://docs.microsoft.com/powershell/module/netadapter/get-netadaptervmq?view=win10-ps)
- [Set-NetAdapterVmq](https://docs.microsoft.com/powershell/module/netadapter/set-netadaptervmq?view=win10-ps)

## Enable and configure RSS on a native host

Use the following PowerShell commands to configure RSS on a native host as well as manage RSS in a VM or on a host virtual NIC (vNIC). Some of the parameters of these commands might also affect Virtual Machine Queue \(VMQ\) in the Hyper-V host.  

>[!IMPORTANT]
>Enabling RSS in a VM or on a host vNIC is a prerequisite for enabling and using vRSS.

- [Disable-NetAdapterRss](https://docs.microsoft.com/powershell/module/netadapter/disable-netadapterrss?view=win10-ps)
- [Enable-NetAdapterRss](https://docs.microsoft.com/powershell/module/netadapter/enable-netadapterrss?view=win10-ps)
- [Get-NetAdapterRss](https://docs.microsoft.com/powershell/module/netadapter/get-netadapterrss?view=win10-ps)
- [Set-NetAdapterRss](https://docs.microsoft.com/powershell/module/netadapter/Set-NetAdapterRss?view=win10-ps)

## Enable vRSS on the Hyper\-V Virtual Switch port

In addition to enabling RSS in the VM, vRSS requires that you enable vRSS on the Hyper\-V Virtual Switch port. 

Determine the present settings for vRSS and enable or disable the feature for a VM.

   **View the current settings:** 

   ```PowerShell
   Get-VMNetworkAdapter <vm-name> | fl
   ```

   **Enabled the feature:**
   
   ```PowerShell
   Set-VMNetworkAdapter <vm-name> -VrssEnabled [$True|$False]
   ```

## Enable or disable vRSS on a host vNIC

Determine the present settings for vRSS, and enable or disable the feature for a host vNIC.

   **View the current settings:** 

   ```PowerShell
   Get-VMNetworkAdapter -ManagementOS | fl
   ```

   **Enable or disable the feature:** 

   ```PowerShell
   Set-VMNetworkAdapter -ManagementOS -VrssEnabled [$True|$False]
   ```

## Configure the scheduling mode on the Hyper-V virtual switch port 
>Applies to: Windows Server 2019

In Windows Server 2019, vRSS can update the logical processors used to process network traffic dynamically.  Devices with supported drivers have this scheduling mode enabled by default. 

Determine the present scheduling mode on a system, or modify the scheduling mode for a VM.

   **View the current settings:** 

   ```PowerShell
   Get-VMNetworkAdapter <vm-name> | Select 'VRSSQueue'
   ```

   **Set or modify the scheduling mode:**

   ```PowerShell
   Set-VMNetworkAdapter <vm-name> -VrssQueueSchedulingMode [Dynamic|$StaticVrss|StaticVMQ]
   ```

## Configure the scheduling mode on a host vNIC
>Applies to: Windows Server 2019

To determine the present scheduling mode or to modify the scheduling mode for a host vNIC, use the following Windows PowerShell commands:

   **View the current settings:** 

   ```PowerShell
   Get-VMNetworkAdapter -ManagementOS | Select 'VRSSQueue'
   ```

   **Set or modify the scheduling mode:** 

   ```PowerShell
   Set-VMNetworkAdapter -ManagementOS -VrssQueueSchedulingMode -VrssQueueSchedulingMode [Dynamic|$StaticVrss|StaticVMQ]
   ```


## Related topics 
For more information, see the following reference topics.

- [Get-VMNetworkAdapter](https://technet.microsoft.com/itpro/powershell/windows/hyper-v/get-vmnetworkadapter)
- [Set-VMNetworkAdapter](https://technet.microsoft.com/itpro/powershell/windows/hyper-v/set-vmnetworkadapter)

For more information, see [Virtual Receive Side Scaling (vRSS)](vrss-top.md).