---
title: Software only (SO) features and technologies
description: These features are implemented as part of the OS and are independent of the underlying NIC(s). Sometimes these features require some tuning of the NIC for optimal operation. Examples of these include Hyper-v features such as Virtual Machine Quality of Service (vmQoS), Access Control Lists (ACLs), and non-Hyper-V features like NIC Teaming.
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: 0cafb1cc-5798-42f5-89b6-3ffe7ac024ba
manager: dougkim
ms.author: lizross 
author: eross-msft
ms.date: 09/20/2018 
---


# Software only (SO) features and technologies
Software only features are implemented as part of the OS and are independent of the underlying NIC(s). Sometimes these features require some tuning of the NIC for optimal operation. Examples of these include Hyper-v features such as Virtual Machine Quality of Service (vmQoS), Access Control Lists (ACLs), and non-Hyper-V features like NIC Teaming.

## Access Control Lists (ACLs)

A Hyper-V and SDNv1 feature for managing security for a VM. This feature applies to the non-virtualized Hyper-V stack and the HVNv1 stack. You can manage Hyper-V switch ACLs through [Add-VMNetworkAdapterAcl](https://docs.microsoft.com/powershell/module/hyper-v/add-vmnetworkadapteracl?view=win10-ps)
and [Remove-VMNetworkAdapterAcl](https://docs.microsoft.com/powershell/module/hyper-v/remove-vmnetworkadapteracl?view=win10-ps)
PowerShell cmdlets.

## Extended ACLs

Hyper-V Virtual Switch extended ACLs enable you to configure the Hyper-V Virtual Switch Extended Port ACLs to provide firewall protection and enforce security policies for the tenant VMs in datacenters. Because the port ACLs are configured on the Hyper-V Virtual Switch rather than within the VMs, the administrator can manage security policies for all tenants in a multitenant environment.

You can manage Hyper-V switch extended ACLs through the [Add-VMNetworkAdapterExtendedAcl](https://docs.microsoft.com/powershell/module/hyper-v/add-vmnetworkadapterextendedacl?view=win10-ps) and [Remove-VMNetworkAdapterExtendedAcl](https://docs.microsoft.com/powershell/module/hyper-v/remove-vmnetworkadapteracl?view=win10-ps) PowerShell cmdlets.

>[!TIP] 
>This feature applies to the HNVv1 stack. For ACLs in the SDN stack, refer to Software Defined Networking SDN) ACLs below.

For more information about Extended Port Access Control Lists in this library, see [Create Security Policies with Extended Port Access Control Lists](https://docs.microsoft.com/windows-server/virtualization/hyper-v-virtual-switch/Create-Security-Policies-with-Extended-Port-Access-Control-Lists).

## NIC Teaming

NIC Teaming, also called NIC bonding, is the aggregation of multiple NIC ports into an entity the host perceives as a single NIC port. NIC Teaming protects against the failure of a single NIC port (or the cable connected to it). It also aggregates network traffic for faster throughput. For more details, see [NIC Teaming](https://docs.microsoft.com/windows-server/networking/technologies/nic-teaming/nic-teaming).

With Windows Server 2016 you have two ways to do teaming:

1.  Windows Server 2012 teaming solution

2.  Windows Server 2016 Switch Embedded Teaming (SET)


## RSC in the vSwitch

Receive Segment Coalescing (RSC) in the vSwitch is a feature that takes packets that are part of the same stream and arrive between network interrupts, and coalesces them into a single packet before delivering them to the operating system. The virtual switch in Windows Server 2019 has this feature. For more details about this feature, see [Receive Segment Coalescing in the vSwitch](https://docs.microsoft.com/windows-server/networking/technologies/hpn/rsc-in-the-vswitch).

## Software Defined Networking (SDN) ACLs

The SDN-extension in Windows Server 2016 improved ways to support ACLs. In the Windows Server 2016 SDN v2 stack, SDN ACLs are used instead of ACLs and Extended ACLs. You can use Network Controller to manage SDN ACLs. 

## SDN Quality of Service (QoS)

The SDN extension in Windows Server 2016 improved ways to provide bandwidth control (egress reservations, egress limits, and ingress limits) on a 5-tuple basis. Typically, these policies get applied at the vNIC or vmNIC level, but you can make them much more specific. In the Windows Server 2016 SDN v2 stack, SDN QoS is used instead of vmQoS. You can use Network Controller to manage SDN QoS.

## Switch Embedded Teaming (SET)

SET is an alternative NIC Teaming solution that you can use in environments that include Hyper-V and the Software Defined Networking (SDN) stack in Windows Server 2016. SET integrates some NIC Teaming functionality into the Hyper-V Virtual Switch. For information about Switch Embedded Teaming in this library, see [Remote Direct Memory Access (RDMA) and Switch Embedded Teaming (SET)](https://docs.microsoft.com/windows-server/virtualization/hyper-v-virtual-switch/rdma-and-switch-embedded-teaming).

## Virtual Receive Side Scaling (vRSS)

Software vRSS is used to spread incoming traffic destined for a VM across multiple logical processors (LPs) of the VM. Software vRSS gives the VM the ability to handle more networking traffic than a single LP would be able to handle. For more information, see [Virtual Receive Side Scaling (vRSS)](https://docs.microsoft.com/windows-server/networking/technologies/vrss/vrss-top).

## Virtual Machine Quality of Service (vmQoS)

Virtual Machine Quality of Service is a Hyper-V feature that allows the switch to set limits on traffic generated by each VM. It also enables a VM to reserve an amount of bandwidth on the external network connection so that one VM can't starve another VM for bandwidth. In the Windows Server 2016 SDN v2 stack, SDN QoS replaces vmQoS.

vmQoS can set egress limits and egress reservations. You must determine the egress reservation mode (relative weight or absolute bandwidth) before creating the Hyper-V switch.

-  Determine the egress reservation mode with the –MinimumBandwidthMode parameter of the New-VMSwitch PowerShell cmdlet.

-  Set the value of the egress limit with the –MaximumBandwidth parameter on the Set-VMNetworkAdapter PowerShell cmdlet.

-  Set the value for the egress reservation with either of the following parameters of the Set VMNetworkAdapter PowerShell cmdlet:

   -  If the –MinimumBandwidthMode parameter on the New-VMSwitch cmdlet is Absolute, then set the –MinimumBandwidthAbsolute parameter on the Set VMNetworkAdapter cmdlet.

   -  If the –MinimumBandwidthMode parameter on the New-VMSwitch cmdlet is Weight, then set the –MinimumBandwidthWeight parameter on the Set VMNetworkAdapter cmdlet.

Because of the limitations in the algorithm used for this feature, we recommend that the highest weight or absolute bandwidth not be more than 20 times the lowest weight or absolute bandwidth. If more control is needed, consider using the SDN stack and the SDN-QoS feature.


---