---
title: Software Defined Networking Performance  
description: Software Defined Networking Performance
ms.prod: windows-server-threshold
ms.service: na
manager: dongill
ms.technology: performance-tuning-guide
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7269b66e-7d98-4702-9e84-2171237a0857
author: phstee
ms.author: grcusanz
ms.date: 10/31/2016
---

# Software Defined Networking Performance

Software Defined Networking (SDN) in Windows Server 2016 is made up of a combination of a Network Controller, Hyper-V Hosts, Software Load Balancer Gateways and HNV Gateways.  For tuning of each of these components refer to the following sections:

## Network Controller

The network controller is a Windows Server role which must be enabled on Virtual Machines running on hosts that are configured to use SDN and are controlled by the network controller.

Three Network Controller enabled VMs are sufficient for high availability and maximum performance.  Each VM must be sized according to the guidelines provided in the SDN infrastructure virtual machine role requirements section of the [Plan Software Defined Networking](../../networking/sdn/plan/Plan-Software-Defined-Networking.md) topic.

### SDN Quality of Service (QoS)

To ensure virtual machine traffic is prioritized effectively and fairly, it is recommended that you configure SDN QoS on the workload virtual machines.  For more information on configuring SDN QoS, refer to the [Configure QoS for a Tenant VM Network Adapter](../../networking/sdn/manage/Configure-QoS-for-Tenant-VM-Network-Adapter.md) topic.

## Hyper-V Host Networking

The guidance provided in the [Hyper-V network I/O performance](#netio) section of the    [Performance Tuning for Hyper-V Servers](./Section_13.0-performance-tuning-for-hyper-v-servers.md) guide is applicable when SDN is used, however this section covers additonal guidelines that must be followed to ensure the best performance when using SDN.

### Physical Network Adapter (NIC) Teaming

For best performance and fail-over capabilities, it is recommended that you configure the physical network adapters to be teamed.  When using SDN you must create the team with Switch Embedded Teaming (SET).  

The optimal number of team members is two as virtualized traffic will be spread across both of the team members in both inbound and outbound directions.  You can have more than two team members, however inbound traffic will be spread over at most two of the adapters.  Outbound traffic will always be spread across all adapters if Dynamic load balancing is configured on the virtual switch.

### Encapsulation Offloads

SDN relies on encapsulation of packets to to virtualize the network.  For optimal performance it is important that the network adapter supports hardware offload for the encapsulation format that is used.  There is no significant performance benefit of one encapsulation format over another.  The default encapsulation format is VXLAN.

You can determine which encapsulation format is being used through the network controller with the following powershell cmdlet:

    (Get-NetworkControllerVirtualNetworkConfiguration -connectionuri $uri).properties.networkvirtualizationprotocol

For best performance, if VXLAN is returned then you must make sure your physical network adapters support VXLAN task offload.  If NVGRE is returned then your physical network adapters must support NVGRE task offload. 

### MTU

Encapsulation results in extra bytes being added to each packet.  This requires that the physical network is configured to use jumbo frames with a MTU that is configured large enough to contain the original packet plus the encapsulation.  An MTU of 9234 is recommended size for either VXLAN or NVGRE and must be configured on the physical switch for the physical interfaces of the host ports (L2) and the router interfaces (L3) of the VLANs over which encapsulated packets will be sent.  This includes the Transit, HNV Provider and Management networks. 

MTU on the Hyper-V host is configured through the network adapter, and the Network Controller Host Agent running on the Hyper-V host will adjust for the encapsulation overhead automatically if supported by the network adapter driver.  

Once traffic egresses from the virtual network via a Gateway, the encapsulation is removed and the original MTU as sent from the VM is used.

### Single Root I/O Virtualization (SR-IOV)

SDN is implemented on the Hyper-V host using a forwarding switch extension in the virtual switch.  In order for this switch extension to process packets, SR-IOV must not be used on virtual network interfaces that are configured for use with the network controller as it causes VM traffic to bypass the virtual swtich.

SR-IOV can be enabled on the virtual switch and can be used by VM network adapters that are not controlled by the network controller.  These SR-IOV VMs can coexist on the same virtual switch as network controller controlled VMs which do not use SR-IOV.

## HNV Gateways

You can find information on tuning HNV Gateways for use with SDN in the [RAS Gateways](./Section_11.1-SoftwareDefinedNetworking-RAS.md) section.

## Software Load Balancing

Software Load Balancing (SLB) Gateways can only be used with SDN.  You can find more information on tuning SDN for use iwth SLB Gateways in the [Software Load Balancer Gateways](./Section_11.2-SoftwareDefinedNetworking-SLB.md) section.

