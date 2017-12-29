---
title: NIC Teaming
description: This topic provides an overview of Network Interface Card (NIC) Teaming in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - networking-nict
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: abded6f3-5708-4e35-9a9e-890e81924fec
ms.author: jamesmci
author: jamesmci
---
# NIC Teaming

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic provides an overview of Network Interface Card (NIC) Teaming in Windows Server 2016.

> [!NOTE]  
> In addition to this topic, the following NIC Teaming content is available.  
>   
> - [NIC Teaming in Virtual Machines &#40;VMs&#41;](nict-vms.md)
> - [NIC Teaming and Virtual Local Area Networks &#40;VLANs&#41;](nict-and-vlans.md)
> - [NIC Teaming MAC Address Use and Management](NIC-Teaming-MAC-Address-Use-and-Management.md)
> - [Troubleshooting NIC Teaming](Troubleshooting-NIC-Teaming.md) 
> - [Create a New NIC Team on a Host Computer or VM](Create-a-New-NIC-Team-on-a-Host-Computer-or-VM.md)
> - [NIC Teaming (NetLBFO) Cmdlets in Windows PowerShell](https://technet.microsoft.com/library/jj130849.aspx)
> - TechNet Gallery Download: [Windows Server 2016 NIC and Switch Embedded Teaming User Guide](https://gallery.technet.microsoft.com/Windows-Server-2016-839cb607?redir=0)
  
## <a name="bkmk_over"></a>NIC Teaming Overview  
NIC Teaming allows you to group between one and thirty-two physical Ethernet network adapters into one or more software-based virtual network adapters. These virtual network adapters provide fast performance and fault tolerance in the event of a network adapter failure.  
  
NIC Team member network adapters must all be installed in the same physical host computer to be placed in a team.  
  
> [!NOTE]  
> A NIC team that contains only one network adapter cannot provide load balancing and failover; however with one network adapter, you can use NIC Teaming for separation of network traffic when you are also using virtual Local Area Networks (VLANs).  
  
When you configure network adapters into a NIC team, they are connected into the NIC teaming solution common core, which then presents one or more virtual adapters (also called team NICs [tNICs] or team interfaces) to the operating system. Windows Server 2016 supports up to 32 team interfaces per team. There are a variety of algorithms that distribute outbound traffic (load) between the NICs.  
  
The following illustration depicts a NIC Team with multiple tNICs.  
  
![NIC Team with multiple tNICs](../../media/NIC-Teaming/nict_overview.jpg)  
  
In addition, you can connect your teamed NICs to the same switch or to different switches. If you connect NICs to different switches, both switches must be on the same subnet.  
  
## <a name="bkmk_avail"></a>NIC Teaming Availability  
NIC Teaming is available in all versions of Windows Server 2016. In addition, you can use Windows PowerShell commands, Remote Desktop, and Remote Server Administration Tools to manage NIC Teaming from computers that are running a client operating system upon which the tools are supported.  
  
## <a name="bkmk_nics"></a>Supported and Unsupported NICs for NIC Teaming  
You can use any Ethernet NIC that has passed the Windows Hardware Qualification and Logo test (WHQL tests) in a NIC Team in Windows Server 2016.  
  
The following NICs cannot be placed in a NIC team.  
  
-   Hyper-V virtual network adapters that are Hyper-V Virtual Switch ports exposed as NICs in the host partition.  
  
    > [!IMPORTANT]  
    > Hyper-V virtual NICs that are exposed in the host partition (vNICs) must not be placed in a team. Teaming of vNICs inside of the host partition is not supported in any configuration or combination. Attempts to team vNICs might cause a complete loss of communication if network failures occur.  
  
-   The kernel debug network adapter (KDNIC).  
  
-   NICs that are being used for network boot.  
  
-   NICs that use technologies other than Ethernet, such as WWAN, WLAN/Wi-Fi, Bluetooth, and Infiniband, including Internet Protocol over Infiniband (IPoIB) NICs.  
  
## <a name="bkmk_compat"></a>NIC Teaming Compatibility  
NIC teaming is compatible with all networking technologies in Windows Server 2016 with the following exceptions.  
  
-   **Single-root I/O virtualization (SR-IOV)**. For SR-IOV, data is delivered directly to the NIC without passing it through the networking stack (in the host operating system, in the case of virtualization). Therefore, it is not possible for the NIC team to inspect or redirect the data to another path in the team.  
  
-   **Native host Quality of Service (QoS)**. When QoS policies are set on a native or host system and those policies invoke minimum bandwidth limitations, the overall throughput for a NIC team will be less than it would be without the bandwidth policies in place.  
  
-   **TCP Chimney**. TCP Chimney is not supported with NIC teaming because TCP Chimney offloads the entire networking stack directly to the NIC.  
  
-   **802.1X Authentication**. 802.1X Authentication should not be used with NIC Teaming. Some switches do not permit the configuration of both 802.1X Authentication and NIC Teaming on the same port.  
  
To learn about using NIC Teaming within virtual machines (VMs) that are running on a Hyper-V host, see [NIC Teaming in Virtual Machines &#40;VMs&#41;](../../technologies/nic-teaming/../../technologies/nic-teaming/NIC-Teaming-in-Virtual-Machines--VMs-.md).  
  
## <a name="bkmk_vmq"></a>NIC Teaming and Virtual Machine Queues (VMQs)  
VMQ and NIC Teaming work well together; VMQ should be enabled anytime Hyper-V is enabled. Depending on the switch configuration mode and the load distribution algorithm, NIC teaming will either present VMQ capabilities to the Hyper-V switch that show the number of queues available to be the smallest number of queues supported by any adapter in the team (Min-queues mode) or the total number of queues available across all team members (Sum-of-Queues mode).  
  
Specifically, if the team is in Switch-Independent teaming mode and the Load Distribution is set to Hyper-V Port mode or Dynamic mode, then the number of queues reported is the sum of all the queues available from the team members (Sum-of-Queues mode); otherwise the number of queues reported is the smallest number of queues supported by any member of the team (Min-Queues mode).  
  
Here's why:  
  
-   When the switch independent team is in Hyper-V Port mode or Dynamic mode the inbound traffic for a Hyper-V switch port (VM) will always arrive on the same team member. The host can predict/control which member will receive the traffic for a particular VM so NIC Teaming can be more thoughtful about which VMQ Queues to allocate on a particular team member. NIC Teaming, working with the Hyper-V switch, will set the VMQ for a VM on exactly one team member and know that inbound traffic will hit that queue.  
  
-   When the team is in any switch dependent mode (static teaming or LACP teaming), the switch that the team is connected to controls the inbound traffic distribution. The host's NIC Teaming software can't predict which team member will get the inbound traffic for a VM and it may be that the switch distributes the traffic for a VM across all team members. As a result the NIC Teaming software, working with the Hyper-V switch, programs a queue for the VM on every team member, not just one team member.  
  
-   When the team is in switch-independent mode and is using an address hash load distribution algorithm, the inbound traffic will always come in on one NIC (the primary team member) - all of it on just one team member. Since other team members aren't dealing with inbound traffic they get programmed with the same queues as the primary member so that if the primary member fails any other team member can be used to pick up the inbound traffic and the queues are already in place.  
  
Most NICs have queues that can be used for either Receive Side Scaling (RSS) or VMQ, but not both at the same time. Some VMQ settings appear to be settings for RSS queues but are really settings on the generic queues that both RSS and VMQ use depending on which feature is presently in use. Each NIC has, in its advanced properties, values for *RssBaseProcNumber and \*MaxRssProcessors. Following are a few VMQ settings that provide better system performance.  
  
-   Ideally each NIC should have the *RssBaseProcNumber set to an even number greater than or equal to two (2). This is because the first physical processor, Core 0 (logical processors 0 and 1), typically does most of the system processing so the network processing should be steered away from this physical processor. (Some machine architectures don't have two logical processors per physical processor so for such machines the base processor should be greater than or equal to 1. If in doubt assume your host is using a 2 logical processor per physical processor architecture.)  
  
-   If the team is in Sum-of-Queues mode the team members' processors should be, to the extent practical, non-overlapping. For example, in a 4-core host (8 logical processors) with a team of 2 10Gbps NICs, you could set the first one to use base processor of 2 and to use 4 cores; the second would be set to use base processor 6 and use 2 cores.  
  
-   If the team is in Min-Queues mode the processor sets used by the team members must be identical.  
  
## <a name="bkmk_hnv"></a>NIC Teaming and Hyper-V Network Virtualization (HNV)  
NIC Teaming is fully compatible with Hyper-V Network Virtualization (HNV).  The HNV management system provides information to the NIC Teaming driver that allows NIC Teaming to distribute the load in a way that is optimized for the HNV traffic.  
  
## <a name="bkmk_live"></a>NIC Teaming and Live Migration  
NIC Teaming in VMs does not affect Live Migration. The same rules exist for Live Migration whether or not NIC Teaming is configured in the VM.  
  
## See Also  
[NIC Teaming in Virtual Machines &#40;VMs&#41;](../../technologies/nic-teaming/../../technologies/nic-teaming/NIC-Teaming-in-Virtual-Machines--VMs-.md)  
  


