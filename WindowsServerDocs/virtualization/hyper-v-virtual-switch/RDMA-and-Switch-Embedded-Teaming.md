---
title: Remote Direct Memory Access (RDMA) and Switch Embedded Teaming (SET)
description: This topic provides information on configuring Remote Direct Memory Access (RDMA) interfaces with Hyper-V in Windows Server 2016, in addition to information about Switch Embedded Teaming (SET). 
manager: brianlic
ms.prod: windows-server
ms.technology: networking-hv-switch
ms.topic: get-started-article
ms.assetid: 68c35b64-4d24-42be-90c9-184f2b5f19be
ms.author: lizross
author: eross-msft
---
# Remote Direct Memory Access \(RDMA\) and Switch Embedded Teaming \(SET\)

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic provides information on configuring Remote Direct Memory Access \(RDMA\) interfaces with Hyper-V in Windows Server 2016, in addition to information about Switch Embedded Teaming \(SET\).  

> [!NOTE]
> In addition to this topic, the following Switch Embedded Teaming content is available. 
> - TechNet Gallery Download: [Windows Server 2016 NIC and Switch Embedded Teaming User Guide](https://gallery.technet.microsoft.com/Windows-Server-2016-839cb607?redir=0)

## <a name="bkmk_rdma"></a>Configuring RDMA Interfaces with Hyper-V  

In Windows Server 2012 R2, using both RDMA and Hyper-V on the same computer as  the network adapters that provide RDMA services can not be bound to a Hyper-V Virtual Switch. This increases the number of physical network adapters that are required to be installed in the Hyper-V host.

>[!TIP]
>In editions of Windows Server previous to Windows Server 2016, it is not possible to configure RDMA on network adapters that are bound to a NIC Team or to a Hyper-V Virtual Switch. In Windows Server 2016, you can enable RDMA on network adapters that are  bound to a Hyper-V Virtual Switch with or without SET.

In  Windows Server 2016, you can use fewer network adapters while using RDMA with or without SET.

The image below illustrates the software architecture changes between  Windows Server 2012 R2 and Windows Server 2016.

![Architectural changes](../media/RDMA-and-SET/rdma_over.jpg)

The following sections provide instructions on how to use Windows PowerShell commands to enable Data Center Bridging (DCB), create a Hyper-V Virtual Switch with an RDMA virtual NIC \(vNIC\), and create a Hyper-V Virtual Switch with SET and RDMA vNICs.

### Enable Data Center Bridging \(DCB\)

Before using any RDMA over Converged Ethernet \(RoCE\) version of RDMA, you must enable DCB.  While not required for Internet Wide Area RDMA Protocol \(iWARP\) networks, testing has determined that all Ethernet-based RDMA technologies work better with DCB. Because of this, you should consider using DCB even for iWARP RDMA deployments.

The following Windows PowerShell example commands demonstrate how to enable and configure DCB for SMB Direct.

Turn on DCB

    Install-WindowsFeature Data-Center-Bridging

Set a policy for SMB-Direct:

    New-NetQosPolicy "SMB" -NetDirectPortMatchCondition 445 -PriorityValue8021Action 3

Turn on Flow Control for SMB:

    Enable-NetQosFlowControl  -Priority 3

Make sure flow control is off for other traffic:

    Disable-NetQosFlowControl  -Priority 0,1,2,4,5,6,7

Apply policy to the target adapters:

    Enable-NetAdapterQos  -Name "SLOT 2"

Give SMB Direct 30% of the bandwidth minimum:

`New-NetQosTrafficClass "SMB"  -Priority 3  -BandwidthPercentage 30  -Algorithm ETS`  

If you have a kernel debugger installed in the system, you must configure the debugger to allow QoS to be set by running the following command.

Override the Debugger - by default the debugger blocks NetQos:
 
    Set-ItemProperty HKLM:"\SYSTEM\CurrentControlSet\Services\NDIS\Parameters" AllowFlowControlUnderDebugger -type DWORD -Value 1 -Force

### Create a Hyper-V Virtual Switch with an RDMA vNIC

If SET is not required for your deployment, you can use the following Windows PowerShell commands to create a Hyper-V Virtual Switch with an RDMA vNIC.

> [!NOTE]
> Using SET teams with RDMA-capable physical NICs provides more RDMA resources for the vNICs to consume.

    New-VMSwitch -Name RDMAswitch -NetAdapterName "SLOT 2"

Add host vNICs and make them RDMA capable:

    Add-VMNetworkAdapter -SwitchName RDMAswitch -Name SMB_1
    Enable-NetAdapterRDMA "vEthernet (SMB_1)" "SLOT 2"

Verify RDMA capabilities:

    Get-NetAdapterRdma

###  <a name="bkmk_set-rdma"></a>Create a Hyper-V Virtual Switch with SET and RDMA vNICs

To make use of RDMA capabilies on Hyper-V host virtual network adapters \(vNICs\) on a Hyper-V Virtual Switch that supports RDMA teaming, you can use these example Windows PowerShell commands.

    New-VMSwitch -Name SETswitch -NetAdapterName "SLOT 2","SLOT 3" -EnableEmbeddedTeaming $true

Add host vNICs:

    Add-VMNetworkAdapter -SwitchName SETswitch -Name SMB_1 -managementOS
    Add-VMNetworkAdapter -SwitchName SETswitch -Name SMB_2 -managementOS

Many switches won't pass traffic class information on untagged VLAN traffic, so make sure that the host adapters for RDMA are on VLANs. This example assigns the two SMB_* host virtual adapters to VLAN 42.
    
    Set-VMNetworkAdapterIsolation -ManagementOS -VMNetworkAdapterName SMB_1  -IsolationMode VLAN -DefaultIsolationID 42
    Set-VMNetworkAdapterIsolation -ManagementOS -VMNetworkAdapterName SMB_2  -IsolationMode VLAN -DefaultIsolationID 42
    

Enable RDMA on Host vNICs:

    Enable-NetAdapterRDMA "vEthernet (SMB_1)","vEthernet (SMB_2)" "SLOT 2", "SLOT 3"

Verify RDMA capabilities; ensure that the capabilities are non-zero:

    Get-NetAdapterRdma | fl *


## Switch Embedded Teaming (SET)  

This section provides an overview of Switch Embedded Teaming (SET) in  Windows Server 2016, and contains the following sections.

- [SET Overview](#bkmk_over)

- [SET Availability](#bkmk_avail)

- [Supported and Unsupported NICs for SET](#bkmk_nics)

- [SET Compatibility with Windows Server Networking Technologies](#bkmk_compat)

- [SET Modes and Settings](#bkmk_modes)

- [SET and Virtual Machine Queues (VMQs)](#bkmk_vmq)

- [SET and Hyper-V Network Virtualization (HNV)](#bkmk_hnv)

- [SET and Live Migration](#bkmk_live)

- [MAC Address Use on Transmitted Packets](#bkmk_mac)

- [Managing a SET team](#bkmk_manage)

## <a name="bkmk_over"></a>SET Overview

SET is an alternative NIC Teaming solution that you can use in environments that include Hyper-V and the Software Defined Networking \(SDN\) stack in  Windows Server 2016. SET integrates some NIC Teaming functionality into the Hyper-V Virtual Switch.

SET allows you to group between one and eight physical Ethernet network adapters into one or more software-based virtual network adapters. These virtual network adapters provide fast performance and fault tolerance in the event of a network adapter failure.

SET member network adapters must all be installed in the same physical Hyper-V host to be placed in a team.

> [!NOTE]
> The use of SET is only supported in Hyper-V Virtual Switch in  Windows Server 2016. You cannot deploy SET in  Windows Server 2012 R2 .

You can connect your teamed NICs to the same physical switch or to different physical switches. If you connect NICs to different switches, both switches must be on the same subnet.

The following illustration depicts SET architecture.

![SET architecture](../media/RDMA-and-SET/set_architecture.jpg)

Because SET is integrated into the Hyper-V Virtual Switch, you cannot use SET inside of a virtual machine (VM). You can, however use NIC Teaming within VMs.

For more information, see [NIC Teaming in Virtual Machines (VMs)](https://docs.microsoft.com/windows-server/networking/technologies/nic-teaming/nict-vms).

In addition, SET architecture does not expose team interfaces. Instead, you must configure Hyper-V Virtual Switch ports.

## <a name="bkmk_avail"></a>SET Availability

SET is available in all versions of Windows Server 2016 that include Hyper-V and the SDN stack. In addition, you can use Windows PowerShell commands and Remote Desktop connections to manage SET from remote computers that are running a client operating system upon which the tools are supported.

## <a name="bkmk_nics"></a>Supported NICs for SET

You can use any Ethernet NIC that has passed the Windows Hardware Qualification and Logo \(WHQL\) test in a SET team in Windows Server 2016. SET requires that all network adapters that are members of a SET team must  be identical \(i.e., same manufacturer, same model, same firmware and driver\). SET supports between one and eight network adapters in a team.
  
## <a name="bkmk_compat"></a>SET Compatibility with Windows Server Networking Technologies

SET is compatible with the following networking technologies in Windows Server 2016.

- Datacenter bridging \(DCB\)
  
- Hyper-V Network Virtualization - NV-GRE and VxLAN are both supported in Windows Server 2016.  
- Receive-side Checksum offloads \(IPv4, IPv6, TCP\) - These are supported if any of the SET team members support them.

- Remote Direct Memory Access \(RDMA\)

- Single root I/O virtualization \(SR-IOV\)

- Transmit-side Checksum offloads \(IPv4, IPv6, TCP\) - These are supported if all of the SET team members support them.

- Virtual Machine Queues \(VMQ\)

- Virtual Receive Side Scaling \(RSS\)

SET is not compatible with the following networking technologies in Windows Server 2016.

- 802.1X authentication. 802.1X Extensible Authentication Protocol \(EAP\) packets are automatically dropped by Hyper\-V Virtual Switch in SET scenarios.
 
- IPsec Task Offload \(IPsecTO\). This is a legacy technology that is not supported by most network adapters, and where it does exist, it is disabled by default.

- Using QoS \(pacer.exe\) in host or native operating systems. These QoS scenarios are not Hyper\-V scenarios, so the technologies do not intersect. In addition, QoS is available but not enabled by default - you must intentionally enable QoS.

- Receive side coalescing \(RSC\). RSC is automatically disabled by Hyper\-V Virtual Switch.

- Receive side scaling \(RSS\). Because Hyper-V uses the queues for VMQ and VMMQ, RSS is always disabled when you create a virtual switch.

- TCP Chimney Offload. This technology is disabled by default.

- Virtual Machine QoS \(VM-QoS\). VM QoS is available but disabled by default. If you configure VM QoS in a SET environment, the QoS settings will cause unpredictable results.

## <a name="bkmk_modes"></a>SET Modes and Settings

Unlike NIC Teaming, when you create a SET team, you cannot configure a team name. In addition, using a standby adapter is supported in NIC Teaming, but it is not supported in SET. When you deploy SET, all network adapters are active and none are in standby mode.

Another key difference between NIC Teaming and SET is that NIC Teaming provides the choice of three different teaming modes, while SET supports only **Switch Independent** mode. With Switch Independent mode, the switch or switches to which the SET Team members are connected are unaware of the presence of the SET team and do not determine how to distribute network traffic to SET team members - instead, the SET team distributes inbound network traffic across the SET team members.

When you create a new SET team, you must configure the following team properties.

- Member adapters

- Load balancing mode

### Member adapters

When you create a SET team, you must specify up to eight identical network adapters that are bound to the Hyper-V Virtual Switch as SET team member adapters.

### Load Balancing mode

The options for SET team Load Balancing distribution mode are **Hyper-V Port** and **Dynamic**.

**Hyper-V Port**

VMs are connected to a port on the Hyper-V Virtual Switch. When using Hyper-V Port mode for SET teams, the Hyper-V Virtual Switch port and the associated MAC address are used to divide network traffic between SET team members.

> [!NOTE]
> When you use SET  in conjunction with Packet Direct, the teaming mode  **Switch Independent** and the load balancing mode **Hyper-V Port** are required.

Because the adjacent switch always sees a particular MAC address on a given port, the switch distributes the ingress load (the traffic from the switch to the host) to the port where the MAC address is located. This is particularly useful when Virtual Machine Queues (VMQs) are used, because a queue can be placed on the specific NIC where the traffic is expected to arrive.

However, if the host has only a few VMs, this mode might not be granular enough to achieve a well-balanced distribution. This mode will also always limit a single VM (i.e., the traffic from a single switch port) to the bandwidth that is available on a single interface.

**Dynamic**

This load balancing mode provides the following advantages.

- Outbound loads are distributed based on a hash of the TCP Ports and IP addresses.  Dynamic mode also re-balances loads in real time so that a given outbound flow can move back and forth between SET team members.

- Inbound loads are distributed in the same manner as the Hyper-V port mode.

The outbound loads in this mode are dynamically balanced based on the concept of flowlets. Just as human speech has natural breaks at the ends of words and sentences, TCP flows (TCP communication streams) also have naturally occurring breaks. The portion of a TCP flow between two such breaks is referred to as a flowlet.

When the dynamic mode algorithm detects that a flowlet boundary has been encountered - for example when a break of sufficient length has occurred in the TCP flow - the algorithm automatically rebalances the flow to another team member if appropriate.  In some uncommon circumstances, the algorithm might also periodically rebalance flows that do not contain any flowlets. Because of this, the affinity between TCP flow and team member can change at any time as the dynamic balancing algorithm works to balance the workload of the team members.

## <a name="bkmk_vmq"></a>SET and Virtual Machine Queues (VMQs)

VMQ and SET work well together, and you should enable VMQ whenever you are using Hyper-V and SET.

> [!NOTE]
> SET always presents the total number of queues that are available across all SET team members. In NIC Teaming, this is called Sum-of-Queues mode.

Most network adapters have queues that can be used for either Receive Side Scaling \(RSS\) or VMQ, but not both at the same time.
  
Some VMQ settings appear to be settings for RSS queues but are really settings on the generic queues that both RSS and VMQ use depending on which feature is presently in use. Each NIC has, in its advanced properties, values for `*RssBaseProcNumber` and `*MaxRssProcessors`.

Following are a few VMQ settings that provide better system performance.

- Ideally each NIC should have the `*RssBaseProcNumber` set to an even number greater than or equal to two (2). This is because the first physical processor, Core 0 \(logical processors 0 and 1\), typically does most of the system processing so the network processing should be steered away from this physical processor. 

>[!NOTE]
>Some machine architectures don't have two logical processors per physical processor, so for such machines the base processor should be greater than or equal to 1. If in doubt, assume your host is using a 2 logical processor per physical processor architecture.

- The team members' processors should be, to the extent that it's practical, non-overlapping. For example, in a 4-core host \(8 logical processors\) with a team of 2 10Gbps NICs, you could set the first one to use base processor of 2 and to use 4 cores; the second would be set to use base processor 6 and use 2 cores.

## <a name="bkmk_hnv"></a>SET and Hyper-V Network Virtualization \(HNV\)

SET is fully compatible with Hyper-V Network Virtualization in Windows Server 2016. The HNV management system provides information to the SET driver that allows SET to distribute the network traffic load in a manner that is optimized for the HNV traffic.
  
## <a name="bkmk_live"></a>SET and Live Migration

Live Migration is supported in Windows Server 2016.

## <a name="bkmk_mac"></a>MAC Address Use on Transmitted Packets

When you configure a SET team with dynamic load distribution, the packets from a single source \(such as a single VM\) are simultaneously distributed across multiple team members. 

To prevent the switches from getting confused and to prevent MAC flapping alarms, SET replaces the source MAC address with a different MAC address on the frames that are transmitted on team members other than the affinitized team member. Because of this, each team member uses a different MAC address, and MAC address conflicts are prevented unless and until failure occurs.

When a failure is detected on the primary NIC, the SET teaming software starts using the VM's MAC address on the team member that is chosen to serve as the temporary affinitized team member \(i.e., the one that will now appear to the switch as the VM's interface\).

This change only applies to traffic that was going to be sent on the VM's affinitized team member with the VM's own MAC address as its source MAC address. Other traffic continues to be sent with whatever source MAC address it would have used prior to the failure.

Following are lists that describe SET teaming MAC address replacement behavior, based on how the team is configured:

- In Switch Independent mode with Hyper-V Port distribution

    - Every vmSwitch port is affinitized to a team member
  
    - Every packet is sent on the team member to which the port is affinitized  
  
    - No source MAC replacement is done  
  
- In Switch Independent mode with Dynamic distribution
  
    - Every vmSwitch port is affinitized to a team member  
  
    - All ARP/NS packets are sent on the team member to which the port is affinitized  
  
    - Packets sent on the team member that is the affinitized team member have no source MAC address replacement done  
  
    - Packets sent on a team member other than the affinitized team member will have source MAC address replacement done  
  
## <a name="bkmk_manage"></a>Managing a SET team

It is recommended that you use System Center Virtual Machine Manager \(VMM\) to manage SET teams, however you can also use Windows PowerShell to manage SET. The following sections provide the Windows PowerShell commands that you can use to manage SET.

For information on how to create a SET team using VMM, see the section "Set up a logical switch" in the System Center VMM library topic [Create logical switches](https://docs.microsoft.com/system-center/vmm/network-switch).
  
### Create a SET team

You must create a SET team at the same time that you create the Hyper-V Virtual Switch by using the **New-VMSwitch** Windows PowerShell command.

When you create the Hyper-V Virtual Switch, you must include the new **EnableEmbeddedTeaming** parameter in your command syntax. In the following example, a Hyper-V switch named  **TeamedvSwitch** with embedded teaming and two initial team members is created.
  
```  
New-VMSwitch -Name TeamedvSwitch -NetAdapterName "NIC 1","NIC 2" -EnableEmbeddedTeaming $true  
```  
  
The **EnableEmbeddedTeaming** parameter is assumed by Windows PowerShell when the argument to **NetAdapterName** is an array of NICs instead of a single NIC. As a result, you could revise the previous command in the following way.

```  
New-VMSwitch -Name TeamedvSwitch -NetAdapterName "NIC 1","NIC 2"  
```  

If you want to create a SET-capable switch with a single team member so that you can add a team member at a later time,  then you must use the EnableEmbeddedTeaming parameter.

```  
New-VMSwitch -Name TeamedvSwitch -NetAdapterName "NIC 1" -EnableEmbeddedTeaming $true  
```  

### Adding or removing a SET team member

The **Set-VMSwitchTeam** command includes the **NetAdapterName** option. To change the team members in a SET team, enter the desired list of team members after the **NetAdapterName** option. If **TeamedvSwitch** was originally created with NIC 1 and NIC 2, then the following example command deletes SET team member "NIC 2" and adds new SET team member "NIC 3".
  
```  
Set-VMSwitchTeam -Name TeamedvSwitch -NetAdapterName "NIC 1","NIC 3"  
```  

### Removing a SET team

You can remove a SET team only by removing the Hyper-V Virtual Switch that contains the SET team.  Use the topic [Remove-VMSwitch](https://technet.microsoft.com/itpro/powershell/windows/hyper-v/remove-vmswitch) for information on how to remove the Hyper-V Virtual Switch. The following example removes a Virtual Switch named **SETvSwitch**.

```  
Remove-VMSwitch "SETvSwitch"  
```  

### Changing the load distribution algorithm for a SET team

The **Set-VMSwitchTeam** cmdlet has a **LoadBalancingAlgorithm** option. This option takes one of two possible values: **HyperVPort** or **Dynamic**. To set or change the load distribution algorithm for a switch-embedded team, use this option. 

In the following example, the VMSwitchTeam named **TeamedvSwitch** uses the **Dynamic** load balancing algorithm.  
```  
Set-VMSwitchTeam -Name TeamedvSwitch -LoadBalancingAlgorithm Dynamic  
```  
### Affinitizing virtual interfaces to physical team members

SET allows you to create an affinity between a virtual interface \(i.e., Hyper-V Virtual Switch port\) and one of the physical NICs in the team. 

For example, if you create two host vNICs for SMB\-Direct, as in the section [Create a Hyper-V Virtual Switch with SET and RDMA vNICs](#bkmk_set-rdma), you can ensure that the two vNICs use different team members. 

Adding to the script in that section, you can use the following Windows PowerShell commands.

    Set-VMNetworkAdapterTeamMapping -VMNetworkAdapterName SMB_1 –ManagementOS –PhysicalNetAdapterName “SLOT 2”
    Set-VMNetworkAdapterTeamMapping -VMNetworkAdapterName SMB_2 –ManagementOS –PhysicalNetAdapterName “SLOT 3”

This topic is examined in more depth in section 4.2.5 of the [Windows Server 2016 NIC and Switch Embedded Teaming User Guide](https://gallery.technet.microsoft.com/Windows-Server-2016-839cb607?redir=0).
