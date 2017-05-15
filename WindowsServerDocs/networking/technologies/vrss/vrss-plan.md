---
title: Plan the Use of vRSS
description: You can use this topic to prepare your virtual machine and Hyper-V host for using vRSS in Windows Server 2016.
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.assetid: 695e6192-5e84-4ab4-b33e-8ebf6b8f5cbb
manager: brianlic
ms.author: jamesmci
author: jamesmci
---

# Plan the Use of vRSS

>Applies To: Windows Server 2016

Following are the steps you can take to plan and prepare for the use of vRSS in a virtual machine \(VM\),
  
1. Verify that the network adapter is compatible with Virtual Machine Queue \(VMQ\) and has a link speed of greater than 10 Gbps.  If the link speed is less than 10 Gbps, the Hyper\-V Virtual Switch disables VMQ by default, even though it still shows VMQ as enabled in the results of the Windows PowerShell command **Get-NetAdapterVmq**. One method you can use to verify that VMQ is enabled or disabled is to use the command **Get-NetAdapterVmqQueue**.  If VMQ is disabled, the results of this command show that there is no QueueID assigned to the VM or host virtual network adapter. 
  
2. Verify that VMQ is enabled on the host machine. vRSS does not work if the host does not support VMQ. You can verify that VMQ is enabled by running **Get-VMSwitch** and finding the adapter that the virtual switch is using. Next, run **Get-NetAdapterVmq** and ensure that the adapter is shown in the results and has VMQ enabled.
  
3. Verify that a Single Root Input\-Output Virtualization \(SR\-IOV\) Virtual Function \(VF\) driver is not attached to the VM network interface. You can verify this by using the **Get-NetAdapterSriov** command. If a VF driver is loaded, RSS uses the scaling settings from this driver instead of those configured by vRSS. If the VF driver does not support RSS, then vRSS is disabled.
  
4. If you are using NIC Teaming, it is important that you properly configure VMQ to work with the NIC Teaming settings. For detailed information about NIC Teaming deployment and management, see [NIC Teaming](https://docs.microsoft.com/en-us/windows-server/networking/technologies/nic-teaming/nic-teaming).  
  