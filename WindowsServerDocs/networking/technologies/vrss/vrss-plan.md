---
title: Plan the Use of vRSS
description: You can use this topic to prepare your virtual machine and Hyper-V host for using vRSS in Windows Server 2016.
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: 695e6192-5e84-4ab4-b33e-8ebf6b8f5cbb
ms.localizationpriority: medium
manager: dougkim
ms.author: lizross
author: eross-msft
ms.date: 09/04/2018
---

# Plan the Use of vRSS

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

In Windows Server 2016, vRSS is enabled by default, however you must prepare your environment to allow vRSS to function correctly in a virtual machine \(VM\) or on a host virtual adapter \(vNIC\). In Windows Server 2012 R2, vRSS was disabled by default.

When you plan and prepare the use of vRSS, ensure that:

- The physical network adapter is compatible with Virtual Machine Queue \(VMQ\) and has a link speed of 10 Gbps or more.
- VMQ is enabled on the physical NIC and on the Hyper\-V Virtual Switch port
- There is no Single Root Input\-Output Virtualization \(SR\-IOV\) configured for the VM.
- NIC Teaming is configured correctly.
- The VM has multiple logical processors \(LPs\).

>[!NOTE]
>vRSS is also enabled by default for any host vNICs that have RSS enabled.

Following is additional information you need to complete these preparation steps.
  
1. **Network Adapter Capacity**. Verify that the network adapter is compatible with Virtual Machine Queue \(VMQ\) and has a link speed of 10 Gbps or more. If the link speed is less than 10 Gbps, the Hyper\-V Virtual Switch disables VMQ by default, even though it still shows VMQ as enabled in the results of the Windows PowerShell command **Get-NetAdapterVmq**. One method you can use to verify that VMQ is enabled or disabled is to use the command **Get-NetAdapterVmqQueue**.  If VMQ is disabled, the results of this command show that there is no QueueID assigned to the VM or host virtual network adapter. 
  
2. **Enable VMQ**. Verify that VMQ is enabled on the host machine. vRSS does not work if the host does not support VMQ. You can verify that VMQ is enabled by running **Get-VMSwitch** and finding the adapter that the virtual switch is using. Next, run **Get-NetAdapterVmq** and ensure that the adapter is shown in the results and has VMQ enabled.
  
3. **Absence of SR\-IOV**. Verify that a Single Root Input\-Output Virtualization \(SR\-IOV\) Virtual Function \(VF\) driver is not attached to the VM network interface. You can verify this by using the **Get-NetAdapterSriov** command. If a VF driver is loaded, RSS uses the scaling settings from this driver instead of those configured by vRSS. If the VF driver does not support RSS, then vRSS is disabled.
  
4. **NIC Teaming Configuration**. If you are using NIC Teaming, it is important that you properly configure VMQ to work with the NIC Teaming settings. For detailed information about NIC Teaming deployment and management, see [NIC Teaming](https://docs.microsoft.com/windows-server/networking/technologies/nic-teaming/nic-teaming).

5. **Number of LPs**. Verify that the VM has more than one logical processor \(LP\). vRSS relies on RSS in the VM or on the Hyper-V host to load balance received traffic to multiple LPs for parallel processing. You can observe how many LPs your VM has by running the Windows PowerShell command **Get-VMProcessor** in the host. After you run the command, you can observe the Count column entry for the number of LPs.

The host vNIC always has access to all of the physical processors; to configure the host vNIC to use a specific number of processors, use the settings **-BaseProcessorNumber** and **-MaxProcessors** when you run the **Set-NetAdapterRss** Windows PowerShell command.

---