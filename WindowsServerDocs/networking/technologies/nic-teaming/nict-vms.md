---
title: NIC Teaming in Virtual Machines (VMs)
description: This topic provides information about using NIC Teaming within Hyper-V VMs in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - networking-nict
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5c73a50c-47f3-4470-a77f-fac1a6739942
ms.author: pashort
author: shortpatti
---
# NIC Teaming in Virtual Machines (VMs)

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic provides information about using NIC Teaming within Hyper-V VMs, and contains the following sections.  
  
-   [NIC Teaming Configuration Requirements](#bkmk_config)  
  
-   [NIC Teaming with SR-IOV-Capable Network Adapters](#bkmk_sriov)  
  
## <a name="bkmk_config"></a>NIC Teaming Configuration Requirements  
If you want to use NIC Teaming in a VM, you must connect the virtual network adapters in the VM to external Hyper-V Virtual Switches only; virtual network adapters that are connected to internal or private Hyper-V Virtual Switches are not able to connect to the switch when they are in a team, and networking fails for the VM.  
  
The  Windows Server 2016 NIC Teaming solution supports teams with two members in VMs. Larger teams can be created but such teams are not supported.  Every team member must be connected to a different external Hyper-V Virtual Switch, and the VM's networking interfaces must be configured to allow teaming. For more information, see [Create a New NIC Team in a VM](../../technologies/nic-teaming/../../technologies/nic-teaming/Create-a-New-NIC-Team-in-a-VM.md).  
  
NIC Teams within a VM must have their Teaming mode configured as Switch Independent.  In addition, Load Balancing mode for the NIC Team in a VM must be configured with the Address Hash distribution mode.  
  
Configuring NIC Teaming in a VM with two virtual network adapters that are connected to different external Hyper-V Virtual Switches allows the VM to sustain network connectivity even in the circumstance when one of the physical network adapters connected to one virtual switch fails or gets disconnected.  
  
## <a name="bkmk_sriov"></a>NIC Teaming with SR-IOV-Capable Network Adapters  
This failover protection is particularly important when working with Single Root I/O Virtualization (SR-IOV), because SR-IOV traffic doesn't go through the Hyper-V Virtual Switch and cannot be protected by a NIC team in or under the Hyper-V host. With the VM NIC Teaming option, you can configure two external Hyper-V Virtual Switches, each connected to its own SR-IOV-capable NIC.  
  
![NIC Teaming with SR-IOV-Capable Network Adapters](../../media/NIC-Teaming-in-Virtual-Machines--VMs-/nict_in_vm.jpg)  
  
Each VM can have a virtual function (VF) from one or both SR-IOV NICs and, in the event of a NIC disconnect, failover from the primary VF to the back-up adapter (VF). Alternately, the VM may have a VF from one NIC and a non-VF vmNIC connected to another virtual switch. If the NIC associated with the VF gets disconnected, the traffic can failover to the other switch without loss of connectivity.  
  
Because failover between NICs in a VM might result in traffic being sent with the MAC address of the other vmNIC, each Hyper-V Virtual Switch port associated with a VM that is using NIC Teaming must be set to allow teaming. To discover how to enable NIC Teaming in the VM, see [Create a New NIC Team in a VM](../../technologies/nic-teaming/../../technologies/nic-teaming/Create-a-New-NIC-Team-in-a-VM.md).  
  
## See Also  
[NIC Teaming and Virtual Local Area Networks &#40;VLANs&#41;](NIC-Teaming-and-Virtual-Local-Area-Networks--VLANs-.md)  
[Create a New NIC Team in a VM](../../technologies/nic-teaming/../../technologies/nic-teaming/Create-a-New-NIC-Team-in-a-VM.md)  
[NIC Teaming](NIC-Teaming.md)  
  

