---
title: Windows PowerShell Commands for RSS and vRSS
description: You can use this topic to quickly locate technical reference information about Windows PowerShell commands for Receive Side Scaling and vRSS in Windows Server 2016.
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.assetid: 49e93b9f-46d9-4cee-bcda-1c4634893ddd
manager: brianlic
ms.author: pashort
author: shortpatti
---

# Windows PowerShell Commands for RSS and vRSS

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this topic to quickly locate technical reference information about Windows PowerShell commands for Receive Side Scaling \(RSS\) and virtual RSS \(vRSS\).

>[!NOTE]
>You can use the following RSS commands to configure RSS on a physical computer that has multiple processors or multiple cores. You can use the same commands to configure vRSS on a virtual machine \(VM\) that is running a supported operating system. 

The following RSS and vRSS configuration commands are part of the Network Adapter Cmdlets in Windows PowerShell. For more information, see [Network Adapter Cmdlets in Windows PowerShell](https://technet.microsoft.com/library/jj134956.aspx).

## Configure VMQ

vRSS requires that VMQ is enabled and configured. You can use the following Windows PowerShell commands to manage VMQ settings.

- [Disable-NetAdapterVmq](https://technet.microsoft.com/itpro/powershell/windows/netadapter/disable-netadaptervmq)
- [Enable-NetAdapterVmq](https://technet.microsoft.com/itpro/powershell/windows/netadapter/enable-netadaptervmq)
- [Get-NetAdapterVmq](https://technet.microsoft.com/itpro/powershell/windows/netadapter/get-netadaptervmq)
- [Set-NetAdapterVmq](https://technet.microsoft.com/itpro/powershell/windows/netadapter/set-netadaptervmq)

## Enable and configure RSS on a native host

The following PowerShell commands allow you to configure RSS on a native host. Some of the parameters of these commands might also affect Virtual Machine Queue \(VMQ\) in the Hyper-V host. You can use these commands to manage RSS in a VM or on a host virtual NIC \(vNIC\). 

>[!IMPORTANT]
>Enabling RSS in a VM or on a host vNIC is a prerequisite for enabling and using vRSS.

- [Disable-NetAdapterRss](https://technet.microsoft.com/library/jj130892.aspx)
- [Enable-NetAdapterRss](https://technet.microsoft.com/library/jj130859.aspx)
- [Get-NetAdapterRss](https://technet.microsoft.com/library/jj130912.aspx)
- [Set-NetAdapterRss](https://technet.microsoft.com/library/jj130863.aspx)

## Enable vRSS on the Hyper\-V Virtual Switch port

In addition to enabling RSS in the VM, vRSS requires that you enable vRSS on the Hyper\-V Virtual Switch port. To determine the present settings for vRSS and to enable or disable the feature for a VM, you can use the following Windows PowerShell commands.

    
    Get-VMNetworkAdapter <vm-name> | fl
    Set-VMNetworkAdapter <vm-name> -VrssEnabled [$True|$False]
    

## Enable or disable vRSS on a host vNIC

To determine the present settings for vRSS, and to enable or disable the feature for a host vNIC, you can use the following Windows PowerShell commands.

    
    Get-VMNetworkAdapter -ManagementOS | fl
    Set-VMNetworkAdapter -ManagementOS -VrssEnabled [$True|$False]
    

For more information, see the following reference topics.

- [Get-VMNetworkAdapter](https://technet.microsoft.com/itpro/powershell/windows/hyper-v/get-vmnetworkadapter)
- [Set-VMNetworkAdapter](https://technet.microsoft.com/itpro/powershell/windows/hyper-v/set-vmnetworkadapter)

For more information, see [Virtual Receive Side Scaling (vRSS)](vrss-top.md).